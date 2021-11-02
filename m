Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B54C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0353260C51
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhKBMab (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 08:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhKBMaR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 08:30:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD67C0613F5
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 05:27:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso1769277wmc.1
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s0et02o0GKm6Ox9HByfxeLAz3rXAsfI3+dwDFZjnI+8=;
        b=aUF/c9ZSSV7vdxDZhcezE+Rd+JR3ZW1jhEQfpTUUTAJoDEOKMFVY8dCEFuSEjGiFMm
         JZTIdOGUqjE8EFYBqKCPVXxNvtFxUykXsrif911Ef4u3FA8BN9x7oJ7fhF/Xtsdury9j
         FBjNqcupVkvsWHEQkLRuJHi5xVPf52GX2L19FlKlMkH+St9sVIEGE77n707gu7RrIF90
         z4wWZ0/rNkTuUiq8RZAOHuZ8+B/b1860lYrbHgf5uMk9nzKNZ9aM2DkHha9Slru4Vb4p
         dtSecCNxjtvWs/oFqgCbxytz06CnK39vMkRzAvBryi2h3pXQnh0Hs9a8YUhg4UZJzVBR
         9UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s0et02o0GKm6Ox9HByfxeLAz3rXAsfI3+dwDFZjnI+8=;
        b=MgmS91lXFaDwkSMgu8QeiIwTgIE6XbeR9ygSBIUQQb10I914k+P2ZVmWswxK3gpEiA
         +v4pUpwh1PZTS4GhATzbZM4MhxU1OVTMwKY+uXWVlEe0eB4e+qkuNVm+A+NBDr0EStEp
         doaqadbUPnCLcyxJ7mAVGQkw7+hDHQaV5ODp6ObBcDGu8J1R8lLrVUfsb653t1qZEdtM
         mwwQSOeosDWG/z78VcxBFiRrqjDgSp6Rz5V+frGw400GbLz5/x8Cdm07MI6a2L/e04XB
         fE4dOIO1mCqVyqQgvWKI3Om5bRDxN8h/IHdIVzVstkouoTJ1sWqzumdHWw/MM9VfzSGv
         zkKQ==
X-Gm-Message-State: AOAM532cHA6DpIIlmfSoisWY4iaMTKmDq0wA/PIpR/3EK73zA/GXA6HV
        YVSDcPVzbZ+P6ODaPmE+Z4GlGCS9zIhMvw==
X-Google-Smtp-Source: ABdhPJwYNyrZo57UooxfA8cD05EnKPjZbJLPvKFwTJCZTOIjMop6GDx2AtV1kb+LtvoIxW4bGJm11w==
X-Received: by 2002:a1c:f219:: with SMTP id s25mr6829682wmc.31.1635856060544;
        Tue, 02 Nov 2021 05:27:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q84sm3332236wme.3.2021.11.02.05.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:27:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 8/8] progress.c: add & assert a "global_progress" variable
Date:   Tue,  2 Nov 2021 13:27:30 +0100
Message-Id: <patch-v6-8.8-bff919994b5-20211102T122507Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
References: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com> <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
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
"driven" by calls to the likes of display_progress().

Once we have a global current progress object we'll be able to update
that object via SIGALRM, this will cover cases where we're busy, but
either haven't invoked our first display_progress() yet, or the time
between display_progress() is too long. See [3] for early code to do
that.

The linked code in [3] is WIP and not signal-safe since among other
things it calls sprintf() from within a signal handler, see e.g. "man
7 signal-safety". But on some platforms a real implementation of it
would be able to write() out a prepared-formatted progress update from
within a signal handler. That would be sufficient to e.g. show that
we're "stalled", or to display something like a simple pre-formatted
"spinner".

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

This doesn't address any currently out-of-tree user of progress.c,
i.e. WIP patches, or progress output that's a part of forks of
git.git. Those hopefully have test coverage that would expose the
BUG().

If they don't they'll either run into it in code that displays more
than one progress bar for the lifetime of the progress, or which calls
stop_progress() with a non-NULL "progress" without a corresponding
start_progress(). Both of those cases are less likely than the general
cases of progress.c API misuse.

Between those three points above and the discussion of how this could
impact out-of-tree users I think it's safe to go ahead with this
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
 progress.c                  | 18 ++++++++++++++++++
 t/t0500-progress-display.sh | 11 +++++++++++
 2 files changed, 29 insertions(+)

diff --git a/progress.c b/progress.c
index 76a95cb7322..7483aec2e2a 100644
--- a/progress.c
+++ b/progress.c
@@ -46,6 +46,7 @@ struct progress {
 };
 
 static volatile sig_atomic_t progress_update;
+static struct progress *global_progress;
 
 /*
  * These are only intended for testing the progress output, i.e. exclusively
@@ -249,6 +250,14 @@ void display_progress(struct progress *progress, uint64_t n)
 		display(progress, n, NULL);
 }
 
+static void set_global_progress(struct progress *progress)
+{
+	if (global_progress)
+		BUG("'%s' progress still active when trying to start '%s'",
+		    global_progress->title, progress->title);
+	global_progress = progress;
+}
+
 static struct progress *start_progress_delay(const char *title, uint64_t total,
 					     unsigned delay, unsigned sparse)
 {
@@ -264,6 +273,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	strbuf_init(&progress->counters_sb, 0);
 	progress->title_len = utf8_strwidth(title);
 	progress->split = 0;
+	set_global_progress(progress);
 	set_progress_signal();
 	trace2_region_enter("progress", title, the_repository);
 	return progress;
@@ -340,6 +350,13 @@ void stop_progress(struct progress **p_progress)
 	stop_progress_msg(p_progress, _("done"));
 }
 
+static void unset_global_progress(void)
+{
+	if (!global_progress)
+		BUG("should have active global_progress when cleaning up");
+	global_progress = NULL;
+}
+
 void stop_progress_msg(struct progress **p_progress, const char *msg)
 {
 	struct progress *progress;
@@ -369,6 +386,7 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 		free(buf);
 	}
 	clear_progress_signal();
+	unset_global_progress();
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
2.33.1.1570.g069344fdd45

