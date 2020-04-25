Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5754FC2BA1A
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 00:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E0E20857
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 00:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pu6yCWAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgDYAaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 20:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgDYAaF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 20:30:05 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12EAC09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 17:30:05 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h11so4358102plr.11
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 17:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CumzfGLLsjByLHjtX54y0ktO300JA5USN3PjzsH8xsQ=;
        b=pu6yCWAELQdtF3PCCuY01RSZuhbz+qWdAUPhk7rRLn8TFCZPHhc60RD1G7XGcqZFc8
         T4Uq4fNpwWpNdvkN0m9VoxrXjbwbMz2VUFfHubaqQ3BvDEw9hxTp2eog5EhBmmw4BzC2
         tf1Z7itWQIWet3Lfwb3b6Mr4TrKtIZquH8MQlBbbGxZakm5isoe6Fyvkcbo9Jttk91DX
         k7OtKz5NigvMWlmDsLeuXgOdPfDhWFowj/Bk+m2IsetMZnGtoG8D9cGlTGEEhN19iaSR
         yz1BptLowvlkgHj1un+pwVUviQHtgF6Pu+Q/7CbV/STXn8ToKcBy+u0rbmdiYpcQat5E
         /mSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CumzfGLLsjByLHjtX54y0ktO300JA5USN3PjzsH8xsQ=;
        b=hoQWMioNk0/WZFz5uagcjWwEbpD3dE83efSGgm5FLSRtAnwCVfOXOOP6O933eCdW32
         T/RPWudgpFkXtEQmhAY5whdXEXNaVLZsfmN46mJ4T01XfWwV1VhTRUwm0wBN07tLukPa
         r0zebpsi1hk0KJfgYZyNua5fyjF3RgCAhkjieyzZe119RsENswt++b8iulnQVVapDQma
         TNeyzYnzD3ZMO4pt7ZL1tuiTxriIwCXTKKXLqII/RHeJrQhgiaHSJT6biyAkLH4UTzE9
         me4YNNBrk5ValNb/UnyN5wrdWV3Dn/dGYg6kt4KmiWsXsfoDwWHFsUnmYqYf3fbWHy6X
         qR5A==
X-Gm-Message-State: AGi0PuY2ob7Pn6yiDcB42ME7JrIhBHR0q74VzmeNbowfLnvhYQEPa/+B
        lTnyRe5//NeAcW5Ibguwp/CP3DiH
X-Google-Smtp-Source: APiQypJoo1iz0mN1vSsUPKOPma12oKQAD2pPNBfIKuIptSVJUsM8PIPsfe9cdLaInuS/qPw5yO95fA==
X-Received: by 2002:a17:902:b708:: with SMTP id d8mr1904715pls.69.1587774604830;
        Fri, 24 Apr 2020 17:30:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id a138sm6730620pfd.32.2020.04.24.17.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 17:30:04 -0700 (PDT)
Date:   Fri, 24 Apr 2020 17:30:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] bugreport: collect list of populated hooks
Message-ID: <20200425003002.GC17217@google.com>
References: <20200424233800.200439-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424233800.200439-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:

> Occasionally a failure a user is seeing may be related to a specific
> hook which is being run, perhaps without the user realizing. While the
> contents of hooks can be sensitive - containing user data or process
> information specific to the user's organization - simply knowing that a
> hook is being run at a certain stage can help us to understand whether
> something is going wrong.

Nice.

[...]
>  Documentation/git-bugreport.txt |  1 +
>  bugreport.c                     | 52 +++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)

Can this functionality be demonstrated in a test?

> diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
> index 643d1b2884..7fe9aef34e 100644
> --- a/Documentation/git-bugreport.txt
> +++ b/Documentation/git-bugreport.txt
> @@ -28,6 +28,7 @@ The following information is captured automatically:
>   - 'git version --build-options'
>   - uname sysname, release, version, and machine strings
>   - Compiler-specific info string
> + - A list of enabled hooks
>  
>  This tool is invoked via the typical Git setup process, which means that in some
>  cases, it might not be able to launch - for example, if a relevant config file
> diff --git a/bugreport.c b/bugreport.c
> index 089b939a87..ce32145bce 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -5,6 +5,8 @@
>  #include "time.h"

Not about this patch: this is for the system header <time.h>, right?
Git includes the same system headers in (almost) all source files, via
cache.h or git-compat-util.h, so it should be possible to leave this
#include out.  (Handling it in one place gives us a chance to get
portability gotchas around names of headers, macros like _POSIX_SOURCE,
and so on right).

[...]
> +	/*
> +	 * NEEDSWORK: Doesn't look like there is a list of all possible hooks;
> +	 * so below is a transcription of `git help hooks`. Later, this should
> +	 * be replaced with some programmatically generated list (generated from
> +	 * doc or else taken from some library which tells us about all the
> +	 * hooks)
> +	 */
> +	const char *hook[] = {
> +		"applypatch-msg",
> +		"pre-applypatch",
> +		"post-applypatch",
> +		"pre-commit",
> +		"pre-merge-commit",
> +		"prepare-commit-msg",
> +		"commit-msg",
> +		"post-commit",
> +		"pre-rebase",
> +		"post-checkout",
> +		"post-merge",
> +		"pre-push",
> +		"pre-receive",
> +		"update",
> +		"post-receive",
> +		"post-update",
> +		"push-to-checkout",
> +		"pre-auto-gc",
> +		"post-rewrite",
> +		"sendemail-validate",
> +		"fsmonitor-watchman",
> +		"p4-pre-submit",
> +		"post-index-change",
> +	};

Interesting.   It would be possible to do some gettext-style trickery
involving scanning for run_hook calls, but converting to an enum as
you've suggested previously sounds simpler.

Thanks,
Jonathan
