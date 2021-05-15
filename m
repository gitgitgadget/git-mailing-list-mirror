Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A6BC433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 20:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FFE06121E
	for <git@archiver.kernel.org>; Sat, 15 May 2021 20:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhEOURJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 16:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhEOURD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 16:17:03 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1305FC061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 13:15:49 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id f184so2874698oig.3
        for <git@vger.kernel.org>; Sat, 15 May 2021 13:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=BnT8rb3xIoyS2JHdKCdyqu4pBkW33AVHqcQUhIoFsKg=;
        b=PUPz6Or1yNsRmUGua80uoFNOGd0fl0hp0hRk2jwzP3uIH6DhUMDjMK/gotT9CP0/ap
         xX0NV8AqA/NmQVJ7PUgWTs5o1pf70mMWw/fYnLbCyQExMM0PvxNfysXWih8KEg2u16EW
         k/25AXNKYBq0GxWb/i9+X9U582mAclGkdf5F4XuZi94XvON0gbEJHYS9p6uIuSMSZIkp
         kSV2ZnhG9fB2Ekdh31WttPoNeQ9rGocHoDtlgj8Hf84IxuoIjRmOwl7V51NunYdXE5Sq
         sNQvUXxv1RRjRDDKhW9p8Z14bsZhvDh5B+CcBm2ByLlxu5o/BtB8/8ngbcanTtMwM9Mo
         C/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=BnT8rb3xIoyS2JHdKCdyqu4pBkW33AVHqcQUhIoFsKg=;
        b=jn1xF84qO6tb18lTREliRyK1lEZd3zzNU5dPM9Dt7VU2X+W9fTlT4j7+0ePVXVlqjT
         XppJ17ndVEM80zT3rjrYKRl15MKK9wKqxyjknl9PwCq8zn5G3CExTid2mhRRkyL/KUbu
         mlBslsx/pzN2prUaMiCmF5tGSwvkDJ4q+MFTJdoS32njNv54yiYjvRa8dk1f5CWpOREC
         8w4cxafBzdECvEz61bgp5T2loo4BCo3+reonRMsu5Wdp065NmqB2BaCjacVuLeOTbBnh
         e+AdqvYQo+x/NrG7gfVLN2UAcRNBXZzgItVxYCqMR2AhDwM/WitqOAT4gKjxHEbb9siZ
         zrvg==
X-Gm-Message-State: AOAM531doFSb7o9NpYB1y6gTeQ7acDCMWlCxOOzIy0b0kX+sY0IwxPy/
        c5ajOKKfPUDIx1Vn0+ZjuuE=
X-Google-Smtp-Source: ABdhPJw3+GSFutxUfzu8LBi06NpxcPuGH9JvPdnX925ftN1vP5QSu2NASMEGL+hjLlhiI5mJJ9jfVQ==
X-Received: by 2002:a54:438c:: with SMTP id u12mr39326995oiv.114.1621109748565;
        Sat, 15 May 2021 13:15:48 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id c17sm2228284otn.45.2021.05.15.13.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 13:15:48 -0700 (PDT)
Date:   Sat, 15 May 2021 15:15:46 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>,
        Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <60a02bf2f16a2_eacf52085@natae.notmuch>
In-Reply-To: <20210514065508.247044-2-firminmartin24@gmail.com>
References: <20210514065508.247044-1-firminmartin24@gmail.com>
 <20210514065508.247044-2-firminmartin24@gmail.com>
Subject: RE: [PATCH 2/2] t: use test_config whenever possible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firmin Martin wrote:
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index ed11569d8d..ff18263171 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -418,7 +418,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
>  		git fetch --recurse-submodules
>  	) &&
>  	add_upstream_commit &&
> -	git config --global fetch.recurseSubmodules false &&
> +	test_config_global fetch.recurseSubmodules false &&
>  	head1=$(git rev-parse --short HEAD) &&
>  	git add submodule &&
>  	git commit -m "new submodule" &&
> @@ -429,11 +429,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
>  	(
>  		cd downstream &&
>  		git config fetch.recurseSubmodules on-demand &&

Uhm:

  test_config fetch.recurseSubmodules on-demand &&

> -		git fetch >../actual.out 2>../actual.err
> -	) &&
> -	git config --global --unset fetch.recurseSubmodules &&
> -	(
> -		cd downstream &&
> +		git fetch >../actual.out 2>../actual.err &&
>  		git config --unset fetch.recurseSubmodules


Then the above line can be removed too.

>  	) &&
>  	test_must_be_empty actual.out &&
> @@ -446,7 +442,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
>  		git fetch --recurse-submodules
>  	) &&
>  	add_upstream_commit &&
> -	git config fetch.recurseSubmodules false &&
> +	test_config fetch.recurseSubmodules false &&
>  	head1=$(git rev-parse --short HEAD) &&
>  	git add submodule &&
>  	git commit -m "new submodule" &&
> @@ -457,11 +453,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
>  	(
>  		cd downstream &&
>  		git config submodule.submodule.fetchRecurseSubmodules on-demand &&

Ditto.

Very nice cleanup.

-- 
Felipe Contreras
