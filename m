Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9183EC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57971619BB
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 03:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhJVDpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhJVDpD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 23:45:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EF2C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:42:46 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t184so2119807pgd.8
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 20:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tPzOHukispFyxQa10DsqUyeVgFdl7Od7fAxrNc4l4LY=;
        b=q75JJVzyislHRukd136469y1Wh2TZbLt1y2C2N+9AIC0m6BZTdfeQbyCDwqnSVtowR
         1wUuun3r0xlsjJ0O1pH4OrNioiDqZV2OT0oxRV8aWf3mK0Lk/I/wii8me7Jmi2U9EbRf
         gpc26LR+33EOhNbodwr1JfP/1zwycip75ywBnGBfYULSFrnHg9JF/vLGeHyAXRYcy1mx
         vZzVw13UJeUt1M4YSXO++lLhJeRfW+L6MiR7FRQN5pAgmLpn+q+77rnjdQMNuZrDWddC
         oSbyBtA/UNmzIbne0WFUho9MtdQxH7UcKs8jpEKWvlXA8lGFpW0umWCangXpisqQieoS
         tELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tPzOHukispFyxQa10DsqUyeVgFdl7Od7fAxrNc4l4LY=;
        b=MJGd1j8tjLTz05JSiN5tmU+hQJlkD20wplvC/zYmWtejh+XY384W6JdN5CcWpcRSxi
         R60Zlxdgz2PkIIE6Pfrbe49BEVIFQmyPkWlY+3gnL6zwyX0UOuv2rvkWjuQk0JqL21Lk
         0cAQTYhXha6TjK6tqSXGUj0rQTMkeIPhgT2sgWypkwuXQ+eoAB9TgoSXXJ3dgVAmoFXg
         livbRYYYjFx+dCczCETmbO0jIEhDb38rCoGwGr/ygJ6k7hH3T+h5AH3sP7cqw9IjZr6O
         l7UoVEwY1KxYncHc0hyUcOfTxLorXb8iV7x/47SP4HG2oGCrjBbgXA4uxRRv/J+AXb2x
         wcXw==
X-Gm-Message-State: AOAM5315JPrdqsvdKe1YQnpsrpyD8jfHj69kLrRwL708V+bt1meeev5w
        V0Rcb4cKg9skTLwpl2BQT12KqyelsJWc+Q==
X-Google-Smtp-Source: ABdhPJxFTdezv8PmYw8xq5dbfkV0w+FV3nI2FAvpEtFp0S3R3OpquE742mKnL02DzzODZhx9vf8HVw==
X-Received: by 2002:a62:e40a:0:b0:44d:a86:43ce with SMTP id r10-20020a62e40a000000b0044d0a8643cemr9870581pfh.69.1634874165910;
        Thu, 21 Oct 2021 20:42:45 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3866:91e2:ded9:17f2])
        by smtp.gmail.com with ESMTPSA id l6sm10944025pjy.23.2021.10.21.20.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 20:42:44 -0700 (PDT)
Date:   Thu, 21 Oct 2021 20:42:40 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 10/10] progress.c: add & assert a "global_progress"
 variable
Message-ID: <YXIzMFI62fBsgjMM@google.com>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
 <patch-v3-10.10-01d5bbfce76-20211013T222329Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-10.10-01d5bbfce76-20211013T222329Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 14, 2021 at 12:28:26AM +0200, Ævar Arnfjörð Bjarmason wrote:
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
>         perl -pi -e 's[isatty\(2\)][1]g' $(git grep -l -F 'isatty(2)')
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

I find it much nicer to understand now, thanks. The BUG() change in
particular is excellent.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
