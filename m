Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA05C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 23:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469CE61424
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 23:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhGBXuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 19:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhGBXuF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 19:50:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B51C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 16:47:32 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id f11so6672904plg.0
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 16:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9VCnRb2bwql1h8i7XmQx5+4s8DVIvS1rsHKUfMOyOLU=;
        b=aikZlyPKzpG193pyvqOsZwMGQe25r/ZupqDGoSDtipx+shoX2yWhr++AWQW6TRNr4x
         JrUFAJOQljQsWyFVMuSKFzehITCyo5q2a2aH5PuZbhShIpzwTasKlC0rtwUGavPumyUQ
         25ihAxN8fmcvVQ3qw2+KvAc15xrh3ngaXvUjauHzJsJURxy+PQ118NCH3/RtHpBikgpT
         nInp+JROdI/MRT+k+JmPPM5fQOFIKheHsxQSQld9SCp9ItvbeSc52ONpJo0RhWRbYBGL
         8JkvG4TJZXSImhvoAF+LiPCjS/trgvLtpHlvylDN8xbTLlgm/hmrtz8d827SPJsZGJt8
         ylVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9VCnRb2bwql1h8i7XmQx5+4s8DVIvS1rsHKUfMOyOLU=;
        b=byD3hbO+sBB2bBNno692VexNhmt+C6sn3a4N4jBdmY24lREeJARVk0Qo3CKxRFBpDC
         U9MyibLKDs01gnLaytJB6JDqDVlUJsTsl2k+k+oCGxGB7cQ7qEMGnXL0inQq9LSqGdKg
         6UjIjnEuBKMHFYpEBu8vGKI8c6YpgvDCkBIX0m03WeK6wytw3Ukbyy9hJtx/EeWOUAR7
         rtvj1ie7obyo/B0jfbsnQZgTVuqF/ZxNokrsuTQox6RQe7bjfa5JG2MRQ437Z8+ACoB3
         Q7SCaASBATRXo1eZTWwsLn7oOLSpWpjkJO64YnlPuS4Yy+xb5L0tPLznpBA/zRMXcH6/
         OehA==
X-Gm-Message-State: AOAM530q5qAZIQ34qCHs+EHIwiZYSIuX7wlni2mIADAt3+iciY7J1LIx
        3iGNrEMJaiRMAlAqy0sDOGbC1Q==
X-Google-Smtp-Source: ABdhPJzhtmLePP1a4uodHmL+OsrtzfIIMxmDwZkjhi8DSKBV7gx6hRsQADWM8859VbhzlCaNRVEMqw==
X-Received: by 2002:a17:90a:69e2:: with SMTP id s89mr2059141pjj.154.1625269651460;
        Fri, 02 Jul 2021 16:47:31 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:7e26:333c:6f31:4d38])
        by smtp.gmail.com with ESMTPSA id hk16sm3538889pjb.1.2021.07.02.16.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 16:47:30 -0700 (PDT)
Date:   Fri, 2 Jul 2021 16:47:24 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 07/27] git hook run: add an --ignore-missing flag
Message-ID: <YN+ljLU7b8o7AF3J@google.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
 <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
 <patch-07.27-12347d901b-20210617T101217Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-07.27-12347d901b-20210617T101217Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 17, 2021 at 12:22:41PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> For certain one-shot hooks we'd like to optimistically run them, and
> not complain if they don't exist. This will be used by send-email in a
> subsequent commit.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/git-hook.txt | 10 +++++++++-
>  builtin/hook.c             |  8 +++++++-
>  t/t1800-hook.sh            |  7 ++++++-
>  3 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
> index 660d6a992a..097fb9de63 100644
> --- a/Documentation/git-hook.txt
> +++ b/Documentation/git-hook.txt
> @@ -8,7 +8,7 @@ git-hook - run git hooks
>  SYNOPSIS
>  --------
>  [verse]
> -'git hook' run <hook-name> [-- <hook-args>]
> +'git hook' run [--ignore-missing] <hook-name> [-- <hook-args>]
>  
>  DESCRIPTION
>  -----------
> @@ -29,6 +29,14 @@ optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
>  arguments (if any) differ by hook name, see linkgit:githooks[5] for
>  what those are.
>  
> +OPTIONS
> +-------
> +
> +--ignore-missing::
> +	Ignore any missing hook by quietly returning zero. Used for
> +	tools that want to do a blind one-shot run of a hook that may
> +	or may not be present.
> +
>  SEE ALSO
>  --------
>  linkgit:githooks[5]
> diff --git a/builtin/hook.c b/builtin/hook.c
> index 7714d31ef1..47e0de7bbc 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -22,10 +22,13 @@ static int run(int argc, const char **argv, const char *prefix)
>  	int i;
>  	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>  	int rc = 0;
> +	int ignore_missing = 0;
>  	const char *hook_name;
>  	const char *hook_path;
>  
>  	struct option run_options[] = {
> +		OPT_BOOL(0, "ignore-missing", &ignore_missing,
> +			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
>  		OPT_END(),
>  	};
>  
> @@ -49,11 +52,14 @@ static int run(int argc, const char **argv, const char *prefix)
>  	/*
>  	 * We are not using run_hooks() because we'd like to detect
>  	 * missing hooks. Let's find it ourselves and call
> -	 * run_found_hooks() instead.
> +	 * run_found_hooks() instead...
>  	 */
>  	hook_name = argv[0];
>  	hook_path = find_hook(hook_name);
>  	if (!hook_path) {
> +		/* ... act like run_hooks() under --ignore-missing */
> +		if (ignore_missing)
> +			return 0;
>  		error("cannot find a hook named %s", hook_name);
>  		return 1;
>  	}

Have started to rebase the configgy stuff on top of this series, and the
final implementation here is kind of confusing to me. The difference
between run_hooks() and run_found_hooks() is the behavior when there's
no hook to run; but you're checking for missing hooks before you even
let them try to run here in builtin/hook.c. So is it really necessary to
have the two methods? I think I'm missing something?

> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index ecd517b162..542e551628 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -23,7 +23,12 @@ test_expect_success 'git hook run: nonexistent hook' '
>  	test_cmp stderr.expect stderr.actual
>  '
>  
> -test_expect_success 'git hook run: basic' '
> +test_expect_success 'git hook run: nonexistent hook with --ignore-missing' '
> +	git hook run --ignore-missing does-not-exist 2>stderr.actual &&
> +	test_must_be_empty stderr.actual
> +'
> +
> +test_expect_success 'git hook run -- basic' '
>  	write_script .git/hooks/test-hook <<-EOF &&
>  	echo Test hook
>  	EOF
> -- 
> 2.32.0.576.g59759b6ca7d
> 
