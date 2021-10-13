Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ABFC433FE
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917BD610F9
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhJMWar (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 18:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhJMWao (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 18:30:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3F8C061766
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i12so13175424wrb.7
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G9ac3knnjEv/RFKA+6kLIUZXWuXXTtqmIJDu9xNXc68=;
        b=pPGAbXxegU7Lhyy+Y5Zl4LJkLzHg29hRwPCQs1LYUXkrzZSlE0zNolwHQRrh7ld7S+
         jzeAFfhvtDzmagnl4RY6khw0XV9xd8ldXI0m44JLwYiiUQo/V4WntEG230P54JWZ0rCQ
         zIIJ9ZVVaBEMEu4dxHSs3E+dxZiHYkk6a7wGNl5bSKtP433+OX23xy1TjLErlUx92yiR
         6zl8KCHjT/dyTt7Dq3soUi/v7ggKdK014ie8jzAu76IYxy7eUcm7ewc1+V4TQFnTsIz6
         obvcnGrFUXmBh8iN2NAGzzpvEdtgwje5vcWotQe/PFCEekWohDm+yfgI7DFf71FkjPC0
         Hd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G9ac3knnjEv/RFKA+6kLIUZXWuXXTtqmIJDu9xNXc68=;
        b=TqEspKZ81B9BneCTjTnyEAxuWjela0XzQxXgiAYDFnqqEpdkTJ0N/NUy02tZ7qgf1i
         10dBb9qaooaBB1rYQxKeBaJLUvWx8OiW1ByiMYM13j8ddJkoUt/m2aaWAEHkxaolFODi
         JIgOI4JaeehVyNN28xTLWj6vMtLwCfB/iJaCQTuK6EBftGLb8Qidcm9lXmkXJVCuafKf
         aRG4yDumES5rfaRJDWu166SG6cBm2rOT4JIsFJs40x90gLK2BvCOb6aKJnN+kny3c7dq
         j85xd+bxJyb7MdTJd47PTWt0qwielnhqKhUUyboYSQ5DBCBilR3//4Fdvd3nKNo7hfhK
         qjEw==
X-Gm-Message-State: AOAM533bhZJ80RA7ZX+HUJSXTGWIzHIweBJ1XdXoCeDmLjQcFvS+3QJB
        RQIMjnO9wcHIj84ZtY0kwOAUory2WSn8yg==
X-Google-Smtp-Source: ABdhPJz5WRUvZy6LCCwu9q6mDm5qNAtgjNPRx9pe5yWBUOmBvcuDMLWH2p+mTI7Pk5He4VMFfy2x/A==
X-Received: by 2002:a05:6000:2a3:: with SMTP id l3mr2209236wry.12.1634164116322;
        Wed, 13 Oct 2021 15:28:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l5sm736683wrq.77.2021.10.13.15.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:28:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/10] progress.c: add & assert a "global_progress" variable
Date:   Thu, 14 Oct 2021 00:28:26 +0200
Message-Id: <patch-v3-10.10-01d5bbfce76-20211013T222329Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The progress.c code makes a hard assumption that only one progress bar
be active at a time (see [1] for a bug where this wasn't the
case). Add a BUG() that'll trigger if we ever regress on that promise
and have two progress bars active at the same time.

There was an alternative test-only approach to doing the same
thing[2], but by doing this outside of a GIT_TEST_* mode we'll know
we've put a hard stop to this particular API misuse.

It will also establish scaffolding to address current fundamental
limitations in the progress output: The current output must be
"driven" by calls to the likes of display_progress(). Once we have a
global current progress object we'll be able to update that object via
SIGALRM. See [3] for early code to do that.

It's conceivable that this change will hit the BUG() condition in some
scenario that we don't currently have tests for, this would be very
bad. If that happened we'd die just because we couldn't emit some
pretty output.

See [4] for a discussion of why our test coverage is lacking; our
progress display is hidden behind isatty(2) checks in many cases, so
the test suite doesn't cover it unless individual tests are run in
"--verbose" mode, we might also have multi-threaded use of the API, so
two progress bars stopping and starting would only be visible due to a
race condition.

Despite that, I think that this change won't introduce such
regressions, because:

 1. I've read all the code using the progress API (and have modified a
    large part of it in some WIP code I have). Almost all of it is really
    simple, the parts that aren't[5] are complex in the display_progress() part,
    not in starting or stopping the progress bar.

 2. The entire test suite passes when instrumented with an ad-hoc
    Linux-specific mode (it uses gettid()) to die if progress bars are
    ever started or stopped on anything but the main thread[6].

    Extending that to die if display_progress() is called in a thread
    reveals that we have exactly two users of the progress bar under
    threaded conditions, "git index-pack" and "git pack-objects". Both
    uses are straightforward, and they don't start/stop the progress
    bar when threads are active.

 3. I've likewise done an ad-hoc test to force progress bars to be
    displayed with:

        perl -pi -e 's[isatty\(2\)][1]g' $(git grep -l -F 'isatty(2)')

    I.e. to replace all checks (not just for progress) of checking
    whether STDERR is connected to a TTY, and then monkeypatching
    is_foreground_fd() in progress.c to always "return 1". Running the
    tests with those applied, interactively and under -V reveals via:

        $ grep -e set_progress_signal -e clear_progress_signal test-results/*out

    That nothing our tests cover hits the BUG conditions added here,
    except the expected "BUG: start two concurrent progress bars" test
    being added here.

    That isn't entirely true since we won't be getting 100% coverage
    due to cascading failures from tests that expected no progress
    output on stderr. To make sure I covered 100% I also tried making
    the display() function in progress.c a NOOP on top of that (it's
    the calls to start_progress_delay() and stop_progress()) that
    matter.

    That doesn't hit the BUG() either. Some tests fail in that mode
    due to a combination of the overzealous isatty(2) munging noted
    above, and the tests that are testing that the progress output
    itself is present (but for testing I'd made display() a NOOP).

Between those three points I think it's safe to go ahead with this
change.

1. 6f9d5f2fda1 (commit-graph: fix progress of reachable commits, 2020-07-09)
2. https://lore.kernel.org/git/20210620200303.2328957-3-szeder.dev@gmail.com
3. https://lore.kernel.org/git/patch-18.25-e21fc66623f-20210623T155626Z-avarab@gmail.com/
4. https://lore.kernel.org/git/cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com/
5. b50c37aa44d (Merge branch 'ab/progress-users-adjust-counters' into
   next, 2021-09-10)
6. https://lore.kernel.org/git/877dffg37n.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c                  | 18 ++++++++++++++----
 t/t0500-progress-display.sh | 11 +++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/progress.c b/progress.c
index b9369e9a264..a31500f8b2b 100644
--- a/progress.c
+++ b/progress.c
@@ -46,6 +46,7 @@ struct progress {
 };
 
 static volatile sig_atomic_t progress_update;
+static struct progress *global_progress;
 
 /*
  * These are only intended for testing the progress output, i.e. exclusively
@@ -219,11 +220,16 @@ void progress_test_force_update(void)
 	progress_interval(SIGALRM);
 }
 
-static void set_progress_signal(void)
+static void set_progress_signal(struct progress *progress)
 {
 	struct sigaction sa;
 	struct itimerval v;
 
+	if (global_progress)
+		BUG("'%s' progress still active when trying to start '%s'",
+		    global_progress->title, progress->title);
+	global_progress = progress;
+
 	if (progress_testing)
 		return;
 
@@ -241,10 +247,14 @@ static void set_progress_signal(void)
 	setitimer(ITIMER_REAL, &v, NULL);
 }
 
-static void clear_progress_signal(void)
+static void clear_progress_signal(struct progress *progress)
 {
 	struct itimerval v = {{0,},};
 
+	if (!global_progress)
+		BUG("should have active global_progress when cleaning up");
+	global_progress = NULL;
+
 	if (progress_testing)
 		return;
 
@@ -268,7 +278,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	strbuf_init(&progress->counters_sb, 0);
 	progress->title_len = utf8_strwidth(title);
 	progress->split = 0;
-	set_progress_signal();
+	set_progress_signal(progress);
 	trace2_region_enter("progress", title, the_repository);
 	return progress;
 }
@@ -372,7 +382,7 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 		display(progress, progress->last_value, buf);
 		free(buf);
 	}
-	clear_progress_signal();
+	clear_progress_signal(progress);
 	strbuf_release(&progress->counters_sb);
 	if (progress->throughput)
 		strbuf_release(&progress->throughput->display);
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 59e9f226ea4..867fdace3f2 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -298,6 +298,17 @@ test_expect_success 'cover up after throughput shortens a lot' '
 	test_cmp expect out
 '
 
+test_expect_success 'BUG: start two concurrent progress bars' '
+	cat >in <<-\EOF &&
+	start 0 one
+	start 0 two
+	EOF
+
+	test_must_fail test-tool progress \
+		<in 2>stderr &&
+	grep "^BUG: .*'\''one'\'' progress still active when trying to start '\''two'\''$" stderr
+'
+
 test_expect_success 'progress generates traces' '
 	cat >in <<-\EOF &&
 	start 40
-- 
2.33.1.1346.g48288c3c089

