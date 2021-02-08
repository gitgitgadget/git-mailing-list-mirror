Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E79C433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 21:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643C764EA1
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 21:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhBHVtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 16:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbhBHVtB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 16:49:01 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBAEC061788
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 13:48:21 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id o193so6546875qke.11
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 13:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2UOPIxyvG0wFMrZMj7nX8Z9azGNx8gJ1mF3XIutTWIc=;
        b=HPTz6Y5nXZXHUDibJydsmvcsDbIzQLAhf38PYpR9YFaGgYlfz/2Fpm2QcSBHlqruYt
         vnVMGbu0i9NZvsb0KVOhf9wLak3HgKPD5arLMXDUxuqssGf+ZCHkTwGepzfpb+shrPBS
         MLjn1Azbl44EPkBu38FbNjIpHM/JpA6ZV18KzHLJ+SPlwCKc+0LIvX4MwCs/qsvWxMZz
         J/jj9Qh34gTH1L+5vPqf/FSOaTwR0St8jZXiE0G9+DYPYKbs/i1CEVmhT2UulnF94mvb
         MkTrynm55JNckHxOIw6BPIsYh+/9pCvG/VJEYCcXy5VlIvsVs3TlcNvLN3No077sP8X6
         3SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2UOPIxyvG0wFMrZMj7nX8Z9azGNx8gJ1mF3XIutTWIc=;
        b=Z2NwlHDbm1WwkZmoPnGX4MwwYef4bLa5kOXYkDJt1eGrd8oXJ5oBXUzmfdazgf2ONC
         H9Yi+Rqw9Tpe+juPJkC79n4AZdJWPiG7yhiKD9y84b1HCgv8sZpLxBYXwzL7g8cQTWUz
         ejbbXLRw1dBRKNqYzwQHjtOnAp/An93N69v/NKovzZOxxcvO/jY2ff2b82JB+S7jhRrc
         QUsSKYXYju33HnDd3KpuiJzVm4q/fJ0IqOvqyXlXywJzeU5iVvi3ZGdfyDSqCPQaIjg9
         E6tT6Ha/BmWrd0TLb1/6UjLJXXSmx8rQIsvM0F9W7L6IAfoBVQhlTJEVZazWIIB5yZzr
         gMhA==
X-Gm-Message-State: AOAM533a/j0rLRe+UssoK/tCQ5TiE/QEhrmXsDK+1MF+e1HR7gmaCJFS
        b4mIjTmsEEvWsQGyB+O1NbIqc4rVjGQp/w==
X-Google-Smtp-Source: ABdhPJxpfRBAXvvX9D5vBi4u97zhN71PQM+wlkgvo0U1+pEsWBJRSpJ0FeAJPAfkd8pX+WnrBPc65w==
X-Received: by 2002:a05:620a:146a:: with SMTP id j10mr18697208qkl.166.1612820900696;
        Mon, 08 Feb 2021 13:48:20 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:65b:f1e7:ac0e:a3a2])
        by smtp.gmail.com with ESMTPSA id k8sm17862353qkk.79.2021.02.08.13.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 13:48:19 -0800 (PST)
Date:   Mon, 8 Feb 2021 16:48:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] grep: error out if --untracked is used with --cached
Message-ID: <YCGxos2vB6mgHOTA@nand.local>
References: <5bd9dce8f611c5fe380c9f58dbdfa2dc6d2fd51f.1612813249.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5bd9dce8f611c5fe380c9f58dbdfa2dc6d2fd51f.1612813249.git.matheus.bernardino@usp.br>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 08, 2021 at 04:43:28PM -0300, Matheus Tavares wrote:
> The options --untracked and --cached are not compatible, but if they are
> used together, grep just silently ignores --cached and searches the
> working tree. Error out, instead, to avoid any potential confusion.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  builtin/grep.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index ca259af441..392acf8cab 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1157,6 +1157,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	if (!use_index && (untracked || cached))
>  		die(_("--cached or --untracked cannot be used with --no-index"));
>
> +	if (untracked && cached)
> +		die(_("--untracked cannot be used with --cached"));
> +

Are these really incompatible? --untracked says that untracked files are
searched in addition to tracked ones in the working tree.
--cached says that the index is searched instead of tracked files. From
my reading, that seems to imply that the combination you're proposing
getting rid of would mean: "search the index,and untracked files".

That's a narrow use-case, but I couldn't think of a reason that it
shouldn't work (but it's been a while since I've looked or thought much
about the "git grep" code...).

Assuming that they are incompatible, though, a few thoughts:

Should this come before the "!use_index && (untracked || cached)" guard?
right now passing all three options first says you can't combine
--cached/--untracked with --no-index. Presumably the next invocation
would come without --no-index, only to come back that the remaining
options are incompatible.

I dunno. I'm thinking out loud, but it feels like this guard should come
before the one above it, not after.

Should this appear in 'git-grep(1)' too? I guess not, since looking for
"[iI]ncompatible" in that file turns up zero results.

Thanks,
Taylor
