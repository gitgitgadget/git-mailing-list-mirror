Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B53C433ED
	for <git@archiver.kernel.org>; Sat, 15 May 2021 20:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D984F6127C
	for <git@archiver.kernel.org>; Sat, 15 May 2021 20:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhEOUXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 16:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbhEOUXL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 16:23:11 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A479C061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 13:21:56 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so2297627otg.2
        for <git@vger.kernel.org>; Sat, 15 May 2021 13:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=qiEYnQJl/IZWkDvMHSKJoODkf6HxmQJC5QjQgBPNlX8=;
        b=uC5xYOJgbrbxroPReMSV0E6/FGcB+cAzOAnEBNboK7X7eB9eg0xfZFTCYolEbmnabs
         gOpAeY9y3NXc8M4SB5VwHo5Xq0WRNBkkEi64ONId1RUEfIodJ91/wMe5BFBjwBVdTvJ4
         XmHT20CmmEArfOrYHjSdNjSGQU+DcNwa5lh0qjkZ6yGfHUxdzI4Fgw1/zi89onjyrIQN
         ENymVr5EvGA8YMB/j8gMZPB4Slyg0x3ipDxGdRNV/tV2JpYCjb/VsrJewP506KI36t09
         N81N4TMSflkfrm8AQ8OTgL+Z9vtZ2OSQ8nndBHiJ9Ls2nCwPKnOBLDjUSooW5sdUss+u
         2FcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=qiEYnQJl/IZWkDvMHSKJoODkf6HxmQJC5QjQgBPNlX8=;
        b=djRh3gcMwW2VlxA5nsHNpgOQosCqUXjldRPMX2YW6qjXa4FFvUMJ6kPiMiZGjG4JMI
         jAzDND6HK2Gfy/TGNwqfaKxm30E1KaUI5v3+gYCiE9SXMjt+qDMVsZjnRl56t1Dv/wV+
         X3to36qDeZjdQBw+GNKORYBgoXYT5zXhMZ6XV8LI+YquxoEHF96o+xTryCIyMZ9n/8QG
         cwKErJmmRageLzi/zKpHGRH9DIxONZQAkC6ueLgBi7L5sSaURDksCj0+Lkn/qs14fCCo
         ZoRu8aMx5TZw3196JNqDBANMIKSJ9UGEPUolBimEllQjnoeF4MKBWT4IbYvW2lvjvDk7
         zLVA==
X-Gm-Message-State: AOAM531tF2a7lNMY9kIfa4I8MXpHRLks1UDmPfgJd8kqWNp0hshl2lzC
        Xe56tsQi/qp1W82qfHhbw1qkSTlc/2dGoQ==
X-Google-Smtp-Source: ABdhPJzIaKxDHdNkIlaF8Rqps22zDGaMX9rDGaUfAlblnaO0FK7L+yG8qZK64yqUUVQUpZZw/k7V2g==
X-Received: by 2002:a05:6830:2255:: with SMTP id t21mr43962467otd.271.1621110116023;
        Sat, 15 May 2021 13:21:56 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id r124sm1886012oig.38.2021.05.15.13.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 13:21:55 -0700 (PDT)
Date:   Sat, 15 May 2021 15:21:54 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Firmin Martin <firminmartin24@gmail.com>,
        Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <60a02d62838cf_eacf5208d2@natae.notmuch>
In-Reply-To: <60a02bf2f16a2_eacf52085@natae.notmuch>
References: <20210514065508.247044-1-firminmartin24@gmail.com>
 <20210514065508.247044-2-firminmartin24@gmail.com>
 <60a02bf2f16a2_eacf52085@natae.notmuch>
Subject: RE: [PATCH 2/2] t: use test_config whenever possible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> Firmin Martin wrote:
> > diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> > index ed11569d8d..ff18263171 100755
> > --- a/t/t5526-fetch-submodules.sh
> > +++ b/t/t5526-fetch-submodules.sh
> > @@ -418,7 +418,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
> >  		git fetch --recurse-submodules
> >  	) &&
> >  	add_upstream_commit &&
> > -	git config --global fetch.recurseSubmodules false &&
> > +	test_config_global fetch.recurseSubmodules false &&
> >  	head1=$(git rev-parse --short HEAD) &&
> >  	git add submodule &&
> >  	git commit -m "new submodule" &&
> > @@ -429,11 +429,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
> >  	(
> >  		cd downstream &&
> >  		git config fetch.recurseSubmodules on-demand &&
> 
> Uhm:
> 
>   test_config fetch.recurseSubmodules on-demand &&

Ahh, I just read the comment about not using it in a subshell.

Then outside:

  test_config -C downstream fetch.recurseSubmodules on-demand &&

-- 
Felipe Contreras
