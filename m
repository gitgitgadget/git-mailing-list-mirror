Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671D7C388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 17:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9432225F
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 17:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="WiuLSDH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437779AbgJURZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 13:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390109AbgJURZU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 13:25:20 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC3C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 10:25:20 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id k9so3273058qki.6
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 10:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hUBYE/hezGO/DqfJS4dpLj55JuuyIdxgfdIKSeXwgbE=;
        b=WiuLSDH1UF3CvJeBlqcXNlaN6WegSwecrowWdWgDQeUEzB6diijH4phc0BxlUjXJot
         vVwHau8SA5THunoZam7/lP9FU2TIdEwH4ORwD+mMMYBrrgqK9ns7uisVIGFwtX6Ty8ll
         bzyW35aztZ1B571sJSVLNqZXJsw+LSQafrE/CFf209gYT0Rf8E9eZJER4RTPf+sC13io
         W76fp4a10g2oIDIhsQL90HF3iMwBPItuzawLWjI5Mwn3sA5B1lpLpuGmGSaWgluWzmFY
         DrtsI8pWgxrSKCwVocl2LeSYfx0Gv/Qb/1LJ6EOxPPrFQi6lTXRNLPBnWzUMRdIZM5Xi
         wxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hUBYE/hezGO/DqfJS4dpLj55JuuyIdxgfdIKSeXwgbE=;
        b=qjsPZdT4aML9TqD6p3je/n3Ep6IShE4/IVIlxyW//PStbHN6ja2pssi1ZMAdDeJDN9
         6pqfAQ0BXw8KqvlbA3dPI12FyonGTlXo+B5gIBcIWeybysGyaVFm8GmuXjNNyJLq67qp
         W58hduVfAw6J3HWpruSiwxCaWzJ1jMDQnMKgsepKhPY6JosQI2URgJjV/9fWRyhOjGpP
         7gc1ud0gD3Jkxlu/wdShZnBtyyNU8fDkp7mutESvyAXkR0UMJh2OJfcyshcqyvQGNrrD
         hmKp/XcocTCoTvzVZ96EpX1dZfrZ7PwK08BREtg/7ULrQg9UUAHVQfgYY9zJT1OGXFio
         IZng==
X-Gm-Message-State: AOAM531pMQxzPCnsG/cpGBiJF8PBqoXLB+PHbOkUvcFjexBcX4Buwk95
        ST/i3iFoktMq+Z9WYopR8hzKHQ==
X-Google-Smtp-Source: ABdhPJzG+93/wn5vveU2bnjUPC/lyVCprNrOwIRGZRj++elc3bFMXEII1BurlbQK6M9OXt+e1GTvxA==
X-Received: by 2002:a37:9b04:: with SMTP id d4mr4125685qke.472.1603301119357;
        Wed, 21 Oct 2020 10:25:19 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:5440:c3ba:60f:b745])
        by smtp.gmail.com with ESMTPSA id c12sm1625663qtp.14.2020.10.21.10.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 10:25:18 -0700 (PDT)
Date:   Wed, 21 Oct 2020 13:25:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael Forney <mforney@mforney.org>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] SKIP_DASHED_BUILT_INS: do not skip the bin/ programs
Message-ID: <20201021172516.GB1237181@nand.local>
References: <pull.768.git.1603293211428.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.768.git.1603293211428.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 03:13:31PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The idea of the `SKIP_DASHED_BUILT_INS` option is to stop hard-linking
> the built-in commands as separate executables. The patches to do that
> specifically excluded the three commands `receive-pack`,
> `upload-archive` and `upload-pack`, though: these commands are expected
> to be present in the `PATH` in their dashed form on the server side of
> any fetch/push.
>
> However, due to an oversight by myself, even if those commands were
> still hard-linked, they were not installed into `bin/`.
>
> Noticed-by: Michael Forney <mforney@mforney.org>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     SKIP_DASHED_BUILT_INS: do not skip the bin/ programs
>
>     As reported by Michael in
>     https://lore.kernel.org/git/CAGw6cBsEjOnh-ZqXCPfFha=NYEdy7JDddha=UzAau0Z1tBrWKg@mail.gmail.com
>     , the SKIP_DASHED_BUILT_INS feature had a bug I wish we had caught in
>     the -rc cycle. But at least SKIP_DASHED_BUILT_INS is still strictly
>     opt-in, so the damage is somewhat contained.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-768%2Fdscho%2Fskip-dashed-built-ins-still-must-install-install_bindir_programs-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-768/dscho/skip-dashed-built-ins-still-must-install-install_bindir_programs-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/768
>
>  Makefile | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 95571ee3fc..1fb0ec1705 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2981,15 +2981,12 @@ endif
>  	} && \
>  	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \

This does still install 'git-shell' into my installation's 'bin'
directory. I'm not up-to-date whether or not we mean to still be
installing that, but, doing the same 'SKIP_DASHED_BUILT_INS=1 make
install' on 'master' also installs git-shell, so I'm fine with that.

>  		$(RM) "$$bindir/$$p" && \
> -		if test -z "$(SKIP_DASHED_BUILT_INS)"; \
> -		then \
> -			test -n "$(INSTALL_SYMLINKS)" && \
> -			ln -s "git$X" "$$bindir/$$p" || \
> -			{ test -z "$(NO_INSTALL_HARDLINKS)" && \
> -			  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
> -			  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
> -			  cp "$$bindir/git$X" "$$bindir/$$p" || exit; }; \
> -		fi \
> +		test -n "$(INSTALL_SYMLINKS)" && \
> +		ln -s "git$X" "$$bindir/$$p" || \
> +		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
> +		  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
> +		  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
> +		  cp "$$bindir/git$X" "$$bindir/$$p" || exit; }; \

OK. $(install_bindir_programs) is the set of programs that we want to
install; that makes sense. And for those, we definitely don't want to
skip them because SKIP_DASHED_BUILT_INS was set. So removing that test
makes sense to me.

>  	done && \
>  	for p in $(BUILT_INS); do \
>  		$(RM) "$$execdir/$$p" && \
>
> base-commit: a5fa49ff0a8f3252c6bff49f92b85e7683868f8a
> --
> gitgitgadget

Looks great, thanks for turning my thoughts into a real patch.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
