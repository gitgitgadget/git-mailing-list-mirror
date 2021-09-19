Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAE9C433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 13:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C856101C
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 13:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhISNy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 09:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhISNy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 09:54:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BE1C061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 06:53:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id co2so3408849edb.8
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=HYxiK0gGg0tHjTx/pZuOm+2A++ZPuHw7alT3r7Jjduw=;
        b=CKILfPfgvNm/Gt7ZrCEYT34lmn6ZcSW1o0bNB9S7zTVIKf/d+Z3/pTsN4/KfEPiUwU
         gDAb0AxNozLp94g3kXMO5wvZataH4ZB4cbTmhFFY+KBbt4oQ8Eo99B2478PMf50m/Fw6
         sVsrK2YdqN4nGp1o1n7Z8aGIXSsugXb6LPGlAM6t9tpuhMaWe+VGaprooQFEu48Gdt2s
         37c2ssIP3ql/T0QDUOasmR1ieiuko/drEqfNo5HG63Mbljl8diTplSVbkzPSe3ELiJq3
         /D3wULZJ/V0+/Dkrqo17eckvF5M5BHGYzHULh30FVb2utk8LGgyiXN6xRRrqfJ3aqtdU
         jjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=HYxiK0gGg0tHjTx/pZuOm+2A++ZPuHw7alT3r7Jjduw=;
        b=fIXYdmnQ/OuLVufIjyChoF8Ft5TGWUumrpWcfRwTaxCV5ekRjmSXQd4qwH8yLVtpG7
         b7x/UFJmhbWym32agQgvlwmgwWqNFX4DdJInFucsltVxgenqWTW13KbPQCIwu6PNSvIO
         ejwM68sq/z5NL5QPON+2PVG/0Zm/k9Kcpy5g1Xfz8mwYoW+QK+D3PUTzyRCexhIZ016R
         +eZIPL0qvryQQqrfyjIP1VZVGfr0g8pTTgPAGXeMggnQ3F1oMj+/akhJJT8Ys08djUsY
         uOaiBnozmFToDqZv6bpHPRs6aSarlZiEnna+XoT+aaXBVncBd4Vhjjw/+HAPxH/6GPK4
         E07Q==
X-Gm-Message-State: AOAM530hmMcUJ9siMr4x6UFgvaVgAdTz2T1+N1uFzPAM1BiugXdtAo6l
        LadH5ED8kfVSfOfNwHbFN8TYlgR6xxHcbA==
X-Google-Smtp-Source: ABdhPJyvcsO+6ifJVoFTmiVhmcXdYHUebM0cibxLn3RHmGDHm+nDzFvADc6K1lUEw/4AZK/Zzs48mA==
X-Received: by 2002:aa7:d51a:: with SMTP id y26mr24092862edq.163.1632059579145;
        Sun, 19 Sep 2021 06:52:59 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w11sm5739913edl.12.2021.09.19.06.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 06:52:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/6] unpack-trees: avoid nuking untracked dir in way of
 locally deleted file
Date:   Sun, 19 Sep 2021 15:52:28 +0200
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
 <01bf850bb0f0796564e9363d7faeb792a594f684.1632006924.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <01bf850bb0f0796564e9363d7faeb792a594f684.1632006924.git.gitgitgadget@gmail.com>
Message-ID: <87sfy0brk5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 18 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t2500-untracked-overwriting.sh | 2 +-
>  unpack-trees.c                   | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
> index 017946a494f..d4d9dc928aa 100755
> --- a/t/t2500-untracked-overwriting.sh
> +++ b/t/t2500-untracked-overwriting.sh
> @@ -218,7 +218,7 @@ test_expect_success 'git am --abort and untracked dir vs. unmerged file' '
>  	)
>  '
>  
> -test_expect_failure 'git am --skip and untracked dir vs deleted file' '
> +test_expect_success 'git am --skip and untracked dir vs deleted file' '
>  	test_setup_sequencing am_skip_and_untracked &&
>  	(
>  		cd sequencing_am_skip_and_untracked &&
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 3b3d1c0ff40..858595a13f1 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2395,7 +2395,11 @@ static int deleted_entry(const struct cache_entry *ce,
>  		if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o))
>  			return -1;
>  		return 0;
> +	} else {
> +		if (verify_absent_if_directory(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o))
> +			return -1;
>  	}

Maybe just "else if" ?

[...]

> +

Stray whitespace change
