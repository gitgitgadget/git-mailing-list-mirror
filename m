Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BDEC433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 14:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A64C23381
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 14:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbhATOJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389562AbhATNFb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 08:05:31 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CFCC0613C1
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 05:04:51 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ke15so25725766ejc.12
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 05:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oOmrbSfFmk+WhxU5UoOA28hUi0BspIprb0jcb7NFWrQ=;
        b=XY31ZBiGhRaS5bPcLBXTV3po3RPbR9Vr5p0CAfzwqmhnC+uIpMpGwKYyiP1Lzt61tg
         OdA2Bzxx51CWu08CL+v4zEsFLLjyJW1RoWoOIC6RZMhgq/WDT0u8cjT4V/LiLeTPv3zP
         dSdiRM/ZZFwbPvCCe1oRm7ufjuEghy/IOesPRmnmKA/uXtbaMYUyLltdQg3WL7N+nEBq
         ai1PcgJVGQqZjJ+koTW5G0ckrbnQ7bIOITbq2krKx8MrstcTRh8ZIvNY2wiaCZ9mJlg/
         KIQgoUBlPqjXTPmQ5mFabsoq4T3fr9uS1A87hNVU/l4oGCBQCoYMbsE6t/S1+76aPzfF
         vmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oOmrbSfFmk+WhxU5UoOA28hUi0BspIprb0jcb7NFWrQ=;
        b=g6vbF7N5mHaptyzLLs6fIIfkx6wJ8iVjK+SdOU3125SqIBjk2ejYEE/Ca/oQH5vuzM
         Ixt4QalGbZaF5yYuPDi5tiyVFHP3mbvXD01SizDSaKI4Hm/CRqGpAIsR5cvYA8LZENOQ
         e0c+jm9cvTDOS11q9ytn1Y9WnIOJU46uezHE+7yi3de6Wi3EraI/igAOprYtK7J47QNf
         EWwnO+aOgQ3RqeodhmokQHWDXZApUSjMihsxw8EgvV6NGMOuNksEIGqWKtYYORAbjXlf
         VbKCGjA+Q9wpW2l7mbfxC7VlQr6xkJcEoCLEE8xUgU18akPvRx5JPPqUuZ/MmPNic4VO
         G2Aw==
X-Gm-Message-State: AOAM531wji40Dr2xNjmz6rEI9c74RKvRF2RyfKE6rhELw98yb8Ib/TOq
        VbLdwdn8b/c/V/KuHNQYcwQ=
X-Google-Smtp-Source: ABdhPJwNrqjKkbDSqnDMwAj+IQhaMOXjLtI5MAfG/ErCDW56hXbPBMjxxaoHd6M7zGTWzQgYGpmi+A==
X-Received: by 2002:a17:907:160d:: with SMTP id hb13mr6052065ejc.521.1611147889714;
        Wed, 20 Jan 2021 05:04:49 -0800 (PST)
Received: from szeder.dev (92-249-246-25.pool.digikabel.hu. [92.249.246.25])
        by smtp.gmail.com with ESMTPSA id t9sm875538ejc.51.2021.01.20.05.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 05:04:49 -0800 (PST)
Date:   Wed, 20 Jan 2021 14:04:47 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 11/11] tests: add a "set -o pipefail" for a patched
 bash
Message-ID: <20210120130447.GB8396@szeder.dev>
References: <20210114233515.31298-1-avarab@gmail.com>
 <20210116153554.12604-12-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210116153554.12604-12-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 16, 2021 at 04:35:54PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Add a "set -o pipefail" test mode to the test suite to detect failures
> in "git" its output is fed directly to a pipe. Doing so is a pattern
> we discourage[1] in the test suite, but we've got plenty of tests like
> that. Now we can reliably detect those failures.
> 
> There was a previous attempt in [2] to add such a test mode, but as
> noted by Jeff King in [3] adding it is a matter of peeing against the
> wind with current bash semantics of failing on SIGPIPE.
> 
> This series relies on a patch of mine to bash, which I'm submitting
> upstream, while not breaking anything for vanilla bash users. They
> won't have GIT_TEST_PIPEFAIL turned on for them, and will only get
> breakages if they turn it on explicitly with "GIT_TEST_PIPEFAIL=true".

I'm not sure about adding code to our test framework that only works
with a patched shell.

> Vanilla bash ignores SIGPIPE under "set -e" since version 3.1. It's
> only under "set -o pipefail" (added in 3.2) that it doesn't take
> account of SIGPIPE, in a seeming omission nobody bothered to fix yet.
> 
> Patching bash[4] with:
> 
>     diff --git a/jobs.c b/jobs.c
>     index a581f305..fa5de82a 100644
>     --- a/jobs.c
>     +++ b/jobs.c
>     @@ -2851,8 +2851,14 @@ raw_job_exit_status (job)
>            p = jobs[job]->pipe;
>            do
>      	{
>     -	  if (WSTATUS (p->status) != EXECUTION_SUCCESS)
>     -	    fail = WSTATUS(p->status);
>     +	  if (WSTATUS (p->status) != EXECUTION_SUCCESS
>     +#if defined (DONT_REPORT_SIGPIPE)
>     +              && WTERMSIG (p->status) != SIGPIPE
>     +#endif
>     +              )
>     +            {
>     +              fail = WSTATUS(p->status);
>     +            }
>      	  p = p->next;
>      	}
>            while (p != jobs[job]->pipe);
> 
> Makes it useful for something like the git test suite.
> 
> Under this test mode we only tests we need to skip those tests which
> are explicitly testing that a piped command returned SIGPIPE. Those
> tests will now return 0 instead of an exit code indicating SIGPIPE.
> 
> Forcing the mode to run under vanilla bash with
> "GIT_TEST_PIPEFAIL=true" doesn't fail any tests for me, except the
> test in t0000-basic.sh which explicitly checks for the desired
> pipefail semantics. However, as Jeff noted in [3] that absence of
> failure isn't reliable. I might not see some of the failures due to
> the racy nature of how vanilla "set -o pipefail" interacts with *nix
> pipe semantics.
> 
> 1. a378fee5b0 (Documentation: add shell guidelines, 2018-10-05)
> 2. https://lore.kernel.org/git/cover.1573779465.git.liu.denton@gmail.com/
> 3. https://lore.kernel.org/git/20191115040909.GA21654@sigill.intra.peff.net/
> 4. https://github.com/bminor/bash/compare/master...avar:avar/ignore-sigterm-and-sigpipe-on-pipe-fail
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>


> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 9fa7c1d0f6..118dc80ffc 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -36,6 +36,31 @@ then
>  fi
>  GIT_BUILD_DIR="$TEST_DIRECTORY"/..
>  
> +# Does "set -o pipefail" on this bash version handle SIGPIPE? Use it!
> +. "$TEST_DIRECTORY/lib-bash-detection.sh"
> +GIT_TEST_PIPEFAIL_TRUE=
> +GIT_TEST_PIPEFAIL_DEFAULT=false
> +if test -n "$TEST_SH_IS_BIN_BASH" &&
> +       $BASH -c 'set -eo pipefail; yes | head -n 1 >/dev/null'
> +then
> +	GIT_TEST_PIPEFAIL_DEFAULT=true
> +fi
> +# We're too early for test_bool_env
> +if git env--helper --type=bool --default="$GIT_TEST_PIPEFAIL_DEFAULT" \

We're too early to invoke 'git' like this, period.

At this point PATH has not yet been set up to include the 'git' binary
we are testing, and we can't rely on a recent enough 'git' supporting
'env--helper' to be present in the regular PATH, or that any 'git' is
present in PATH at all.  And indeed we have CI jobs whose output with
this patch now looks like this:

  *** prove ***
  t5401-update-hooks.sh: ./test-lib.sh: line 49: git: not found
  t9001-send-email.sh: ./test-lib.sh: line 49: git: not found
  t5608-clone-2gb.sh: ./test-lib.sh: line 49: git: not found
  [22:05:24] t9001-send-email.sh ................................ ok    58390 ms ( 0.06 usr  0.00 sys + 27.37 cusr  7.49 csys = 34.92 CPU)
  t2013-checkout-submodule.sh: ./test-lib.sh: line 49: git: not found
  [22:05:34] t2013-checkout-submodule.sh ........................ ok     9412 ms ( 0.03 usr  0.01 sys +  5.68 cusr  3.00 csys =  8.72 CPU)
  t0027-auto-crlf.sh: ./test-lib.sh: line 49: git: not found

> +       --exit-code GIT_TEST_PIPEFAIL
> +then
> +	set -o pipefail
> +
> +	# Only "set -o pipefail" in the main test scripts, not any
> +	# sub-programs we spawn.
> +	GIT_TEST_PIPEFAIL=
> +	export GIT_TEST_PIPEFAIL
> +
> +	# For the convenience of the prereq for it.
> +	GIT_TEST_PIPEFAIL_TRUE=true
> +	export GIT_TEST_PIPEFAIL_TRUE
> +fi
> +
>  # If we were built with ASAN, it may complain about leaks
>  # of program-lifetime variables. Disable it by default to lower
>  # the noise level. This needs to happen at the start of the script,
> @@ -1552,6 +1577,10 @@ test_lazy_prereq PIPE '
>  	rm -f testfifo && mkfifo testfifo
>  '
>  
> +test_lazy_prereq BASH_SET_O_PIPEFAIL '
> +	test -n "$GIT_TEST_PIPEFAIL_TRUE"
> +'
> +
>  test_lazy_prereq SYMLINKS '
>  	# test whether the filesystem supports symbolic links
>  	ln -s x y && test -h y
> -- 
> 2.29.2.222.g5d2a92d10f8
> 
