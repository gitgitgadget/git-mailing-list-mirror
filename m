Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BEBC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F2D60F6E
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbhJHEUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 00:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhJHEUi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 00:20:38 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB10C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 21:18:43 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id np13so6575252pjb.4
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 21:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+A1VirjeaBSZs0QNfh+4JcWEyLGMKvXzUNFPSyj3JTE=;
        b=DsLjyXzO73QdcQ4uhrkSgUxLtNhzXZqtT2CxpjJ7uXdTUsiIS35rxKSYr7HsGGJHh0
         nAvO+Ss+1xVhhGt/UrVAOdbzulUsTBTjA2O3xaYmDgyu7HcRDuA4VrUkELciCy27vJRV
         Qasw5unNt5U18aPIbYZ8uzJwucVJdu+ZHEezK75Xoa7CgeodWM1OSwZHe2wwRb/D8Zzf
         Ys+DdTjQJ9FGxaQBih8ZTgMQZReevB42CcPtJAoWwHBzxZRpn4BtgZ/4gBRk+XjdmIrh
         tMkxZFUi7/j0i/uv2dUbcTeFrgZs9bPtQjBBfUeZaMFbNTjfOXu1H1yN9ufCL3e09eWa
         XEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+A1VirjeaBSZs0QNfh+4JcWEyLGMKvXzUNFPSyj3JTE=;
        b=NbkdVnOXmGWmfjSoFY2Ffn7ORIWOsU3kxPcvPOulAegKd9mUFiiXUCp6/kBYiiXtYC
         qNjVZAeEALCrGZCQhJaQx2gBTG8QV2DqkZdEFOmoq/i/JAz6wHYlqGAOV2FDDL0m9DL4
         qp7guNTDqdv2ZhW6gGfOhTEIe3kxvg3JwcwTrg5whRYdNnUy4TB9IcW++VyXhDly3X7m
         JmKF7bGLCSfEw4apV5aOfxuOCDUS1YwtbuSyYPdWJiIOgPBd9iYu7t1BBxNiz9sPetnl
         rGBCJ9dL1iIXFOpkyPL5kgyD5XupzUCDewFafx69zyYMHysEbzle8+Ax4mtVuWsQUUiu
         fZdg==
X-Gm-Message-State: AOAM53108oFmnsF1+o2u08JW4zaKMDnnDMOCJB7n5tC1bEswH1kr9eUJ
        Fly8yik/AoQmXVLW79rB2np/Zg==
X-Google-Smtp-Source: ABdhPJyCCypZkKYyZawb9HBQ5h/ptyShWbtCEAcMUBEp/2MsvK8mpMih7IEnmKb013SEsVbK+effcw==
X-Received: by 2002:a17:90a:a087:: with SMTP id r7mr10167878pjp.84.1633666722828;
        Thu, 07 Oct 2021 21:18:42 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:970b:a182:aca1:37a6])
        by smtp.gmail.com with ESMTPSA id t13sm704028pjg.25.2021.10.07.21.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 21:18:42 -0700 (PDT)
Date:   Thu, 7 Oct 2021 21:18:37 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 8/8] progress.c: add & assert a "global_progress"
 variable
Message-ID: <YV/Gndf9e4MbFgYM@google.com>
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <patch-v2-8.8-1bd285eba0d-20210920T225701Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-8.8-1bd285eba0d-20210920T225701Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 01:09:29AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> The progress.c code makes a hard assumption that only one progress bar
> be active at a time (see [1] for a bug where this wasn't the
> case). Add a BUG() that'll trigger if we ever regress on that promise
> and have two progress bars active at the same time.
> 
> There was an alternative test-only approach to doing the same
> thing[2], but by doing this outside of a GIT_TEST_* mode we'll know
> we've put a hard stop to this particular API misuse.
> 
> It will also establish scaffolding to address current fundamental
> limitations in the progress output: The current output must be
> "driven" by calls to the likes of display_progress(). Once we have a
> global current progress object we'll be able to update that object via
> SIGALRM. See [3] for early code to do that.
> 
> It's conceivable that this change will hit the BUG() condition in some
> scenario that we don't currently have tests for, this would be very
> bad. If that happened we'd die just because we couldn't emit some
> pretty output.
> 
> See [4] for a discussion of why our test coverage is lacking; our
> progress display is hidden behind isatty(2) checks in many cases, so
> the test suite doesn't cover it unless individual tests are run in
> "--verbose" mode, we might also have multi-threaded use of the API, so
> two progress bars stopping and starting would only be visible due to a
> race condition.
> 
> Despite that, I think that this change won't introduce such
> regressions, because:
> 
>  1. I've read all the code using the progress API (and have modified a
>     large part of it in some WIP code I have). Almost all of it is really
>     simple, the parts that aren't[5] are complex in the display_progress() part,
>     not in starting or stopping the progress bar.
> 
>  2. The entire test suite passes when instrumented with an ad-hoc
>     Linux-specific mode (it uses gettid()) to die if progress bars are
>     ever started or stopped on anything but the main thread[6].
> 
>     Extending that to die if display_progress() is called in a thread
>     reveals that we have exactly two users of the progress bar under
>     threaded conditions, "git index-pack" and "git pack-objects". Both
>     uses are straightforward, and they don't start/stop the progress
>     bar when threads are active.
> 
>  3. I've likewise done an ad-hoc test to force progress bars to be
>     displayed with:
> 
>         perl -pi -e 's[isatty\((?:STDERR_FILENO|2)\)][1]g' $(git grep -l 'isatty\((STDERR_FILENO|2)\)')

I think your ad-hoc test might be a little more compelling if it was
easier to understand, which is to say, maybe if your Perl oneliner was
on more than one line, or had comments, or was in a different language.
Although you explain it right after, we kind of have to take your word
for it.

> 
>     I.e. to replace all checks (not just for progress) of checking
>     whether STDERR is connected to a TTY, and then monkeypatching
>     is_foreground_fd() in progress.c to always "return 1". Running the
>     tests with those applied, interactively and under -V reveals via:
> 
>         $ grep -e set_progress_signal -e clear_progress_signal test-results/*out
> 
>     That nothing our tests cover hits the BUG conditions added here,
>     except the expected "BUG: start two concurrent progress bars" test
>     being added here.
> 
>     That isn't entirely true since we won't be getting 100% coverage
>     due to cascading failures from tests that expected no progress
>     output on stderr. To make sure I covered 100% I also tried making
>     the display() function in progress.c a NOOP on top of that (it's
>     the calls to start_progress_delay() and stop_progress()) that
>     matter.
> 
>     That doesn't hit the BUG() either. Some tests fail in that mode
>     due to a combination of the overzealous isatty(2) munging noted
>     above, and the tests that are testing that the progress output
>     itself is present (but for testing I'd made display() a NOOP).
> 
> Between those three points I think it's safe to go ahead with this
> change.

One worry I had was that we might be painting ourselves into a corner
here if we did want to support the ability to do multiple progress bars
simultaneously (for example if we want to pull from multiple CDNs at the
same time when we're using promisor packfiles, and we expect those packs
to be large enough that we'd need to show a progress bar for each one).
However, I think the pattern - hang onto a pointer to the progress
objects, and complain if we get a signal and there are any still valid -
still holds well enough, so I'm ok with this change.

There are a couple patches in the middle which I didn't reply to, but I
did read them, and they were so tiny and mechanical that I did not have
useful comments to add.

Thanks, it's nice to see progress here (ha ha ha).

Preferably with the BUG() message nit below,
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

> 
> 1. 6f9d5f2fda1 (commit-graph: fix progress of reachable commits, 2020-07-09)
> 2. https://lore.kernel.org/git/20210620200303.2328957-3-szeder.dev@gmail.com
> 3. https://lore.kernel.org/git/patch-18.25-e21fc66623f-20210623T155626Z-avarab@gmail.com/
> 4. https://lore.kernel.org/git/cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com/
> 5. b50c37aa44d (Merge branch 'ab/progress-users-adjust-counters' into
>    next, 2021-09-10)
> 6. https://lore.kernel.org/git/877dffg37n.fsf@evledraar.gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  progress.c                  | 17 +++++++++++++----
>  t/t0500-progress-display.sh | 11 +++++++++++
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/progress.c b/progress.c
> index 1ab7d19deb8..14a023f4b43 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -46,6 +46,7 @@ struct progress {
>  };
>  
>  static volatile sig_atomic_t progress_update;
> +static struct progress *global_progress;
>  
>  /*
>   * These are only intended for testing the progress output, i.e. exclusively
> @@ -221,11 +222,15 @@ void progress_test_force_update(void)
>  	progress_interval(SIGALRM);
>  }
>  
> -static void set_progress_signal(void)
> +static void set_progress_signal(struct progress *progress)
>  {
>  	struct sigaction sa;
>  	struct itimerval v;
>  
> +	if (global_progress)
> +		BUG("should have no global_progress in set_progress_signal()");
> +	global_progress = progress;

Can we make the BUG() message a little clearer? Even in the context of
the code, it's not clear that what this BUG() really means is "hey, you
forgot to call stop_progress on something" or "hey, you can't have two
progress bars at the same time". Even if you were to change the name of
'global_progress' to 'existing_progress_bar' or something, I think that
would make the message more understandable.

> +
>  	if (progress_testing)
>  		return;
>  
> @@ -243,10 +248,14 @@ static void set_progress_signal(void)
>  	setitimer(ITIMER_REAL, &v, NULL);
>  }
>  
> -static void clear_progress_signal(void)
> +static void clear_progress_signal(struct progress *progress)
>  {
>  	struct itimerval v = {{0,},};
>  
> +	if (!global_progress)
> +		BUG("should have a global_progress in clear_progress_signal()");
> +	global_progress = NULL;
> +
>  	if (progress_testing)
>  		return;
>  
> @@ -270,7 +279,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
>  	strbuf_init(&progress->counters_sb, 0);
>  	progress->title_len = utf8_strwidth(title);
>  	progress->split = 0;
> -	set_progress_signal();
> +	set_progress_signal(progress);
>  	trace2_region_enter("progress", title, the_repository);
>  	return progress;
>  }
> @@ -374,7 +383,7 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
>  		display(progress, progress->last_value, buf);
>  		free(buf);
>  	}
> -	clear_progress_signal();
> +	clear_progress_signal(progress);
>  	strbuf_release(&progress->counters_sb);
>  	if (progress->throughput)
>  		strbuf_release(&progress->throughput->display);
> diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
> index ffa819ca1db..124d33c96b3 100755
> --- a/t/t0500-progress-display.sh
> +++ b/t/t0500-progress-display.sh
> @@ -296,6 +296,17 @@ test_expect_success 'cover up after throughput shortens a lot' '
>  	test_cmp expect out
>  '
>  
> +test_expect_success 'BUG: start two concurrent progress bars' '
> +	cat >in <<-\EOF &&
> +	start 0 one
> +	start 0 two
> +	EOF
> +
> +	test_must_fail test-tool progress \
> +		<in 2>stderr &&
> +	grep -E "^BUG: .*: should have no global_progress in set_progress_signal\(\)$" stderr
> +'
> +
>  test_expect_success 'progress generates traces' '
>  	cat >in <<-\EOF &&
>  	start 40
> -- 
> 2.33.0.1098.gf02a64c1a2d
> 
