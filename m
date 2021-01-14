Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A62CC433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 07:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34278233FD
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 07:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbhANHwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 02:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbhANHwg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 02:52:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721AAC061794
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 23:51:49 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id u4so2744289pjn.4
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 23:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=c3YEg3yFGU5SDaMTC2WCGoeV7FcBtQ33GEnX316iUf0=;
        b=T79iciSWNyZrt6JzLtADHoHY6LZBl2HZuk8TxGYDLrJh3ufq9LY10LCavOw7YSzPdn
         BGBWX+HkTDmv9sJc64Vt92GvzS+pyMpK076+ar9HH3qSuJkTApY4EqSJo0ffJL9nORbN
         SJaHkAFmzIqJHf3ZVM5ujH8hdzExdiE0OEVZWygC1Wc9lfgotZA/mddY1y9eJ3wUTxBx
         YqR74kkGrmhfmhLH6BI0W+h+yzbFS0QWVUbo81vsE/BJ14Rv9rN40YQjexe87p69cCgI
         zQJ9bp25rXrxllI0TDl0bluTaTRwKlHn5fc8bwgXUdMT2I6Me8OqxvdgvA08Oi60NR2N
         lUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c3YEg3yFGU5SDaMTC2WCGoeV7FcBtQ33GEnX316iUf0=;
        b=RxBZzSE5Nw/pFFNC4v7xJvVzF9+ZByhw7cnlRjmTLCIJZ/F3BbaPODQMUsesbGo1RD
         rjxNet2Gu6abIBfmWmYve+I2PNG3GMD3P2pnYLc8BH7/pwKDLf6s6dApQbCDz7KQaCFk
         SpG3zXKhEpGC00Ozw7XU/UNzqR80J4m13ANXGJS8lsNGdG2/W13Dl41N6Rj+xOBxT9OX
         K0eSqc8YI8inkCDoElyqgFBY0Iq2jlymxLxoR+vT8opZO16PYHgzxxBX2qHHnajvLvOx
         5rPApNpwtmbjFOA2HWXPvTAvEsL6HVJP1E0vW/Ob6EOiBazRcmZWThv65BEicgGo8MQu
         O+sw==
X-Gm-Message-State: AOAM532DdFZ2zeGk+5zv7yfXWDyBSoIuzSlA0I+a2gvGki2unK9VFJd2
        Ep4HzyrSNfi7c4FB2Djxmnk=
X-Google-Smtp-Source: ABdhPJx1f9VbGheXqtfJ9NVYe6GT6yUh8BEwLzKQgB+ioyfPoNgBpEqhDrkVcfUDzz3wxyD6tt1l5A==
X-Received: by 2002:a17:90a:8985:: with SMTP id v5mr3610331pjn.27.1610610708979;
        Wed, 13 Jan 2021 23:51:48 -0800 (PST)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id l197sm4612031pfd.97.2021.01.13.23.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 23:51:48 -0800 (PST)
Date:   Wed, 13 Jan 2021 23:51:46 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 06/22] mailmap tests: modernize syntax & test idioms
Message-ID: <X//4ErmvlK+lIju9@generichostname>
References: <20210105130359.21139-1-avarab@gmail.com>
 <20210112201806.13284-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210112201806.13284-7-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

On Tue, Jan 12, 2021 at 09:17:50PM +0100, Ævar Arnfjörð Bjarmason wrote:
> @@ -480,7 +545,7 @@ test_expect_success 'log.mailmap=false disables mailmap' '
>  	Author: nick1 <bugs@company.xx>
>  	Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
>  	EOF
> -	git -c log.mailmap=False log | grep Author >actual &&
> +	git -c log.mailmap=false log | grep Author >actual &&

While you're doing test cleanup, here's another suggestion: we should
break all these pipes where git is in the upstream of a pipe. The return
code of a pipe comes from the last thing run which means if git outputs
correctly but then somehow fails after, we won't detect the failure.

In general, I've stopped my crusade against these because it seems like
it's more noise than it's worth in most cases but in this case, since
we're exercising mailmap codepaths that aren't tested in other test
cases, this pipe could plausibly hide a failure that isn't seen
anywhere else.

Thanks,
Denton

>  	test_cmp expect actual
>  '
