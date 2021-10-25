Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C69DC433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84CC260551
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhJYL1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhJYL1k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 07:27:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFECC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id g141so10350571wmg.4
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fvyCaMkGyKsa/glN12zH0G9IoijkeftbM7jsFbP/N54=;
        b=Yex47PyZVdWi6VT4qFavUEi2dgQzxcQ+6jX/bOy5cRfmV4CzSaAYhg57Vty+NtNFoa
         K4onCUi32LrwSkKOj9poWw2EoLqiCnZ+P7GCxbecuTrQ7p2ip+pLbORDr87xGddqq68s
         /D85/keAXUhhh1r0DrrgaVgkMc7POrfJHRC2BGIY56avVG1hPbiTEXDJC0cU8vV/up40
         vkApf7IOEzotAyZDLD8Rx2u/mZTJs9fx3dFLQrRavlLhyVhd/8I12JgwTk3kmspaZMxm
         ME9s9FhMUoPrw+FSz5eMWnyrBzGI0x3TLX+amSDv3KLBxt8+5Hqdb6ROQoSf12Iv5f/y
         2+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvyCaMkGyKsa/glN12zH0G9IoijkeftbM7jsFbP/N54=;
        b=xod1cWQYYXZwofVIj0k62fjpb0eEBvGBoRCxl11ZfqBRHskqVCw0DvjUH15Dy55AaO
         +CCVp4IeXUyX+1zr9qVA44t14VcXgOwM3MaL+o18QrJrkCQvbOncO3oK10wS8MZ8igQS
         KoeTdPWS5Rl8YkP08qY3Knl3715F/wc+i9C7BdWpEPJY0yIMwxoe1ahDUA+CE/Hc/Vla
         LjDI8qsjQW2LncaP0o6z4Wf8FIji+bfR7dsNUcgCT8BxaVs9GuF6591rURov+CYLvnaJ
         W7fUYBpFkAbFlg2HykZGvZ3Jz4w6DeOOVHNfhnYHl7pOjZvJmw60NAMoL4uTlGLbp6zG
         Vi1A==
X-Gm-Message-State: AOAM533eQNblyBdmNkT26m/TylY/EZIs+Czv6aHqdPyS/XbyRiSmgt5S
        ZfX2iWoRJcvOHBtTWwI6SMzcDWD1IukiEw==
X-Google-Smtp-Source: ABdhPJzb+89KS7A6Ccynw+Z1fRQPfekjFxrWSBQks5diprX11J7iIRe+IPS4gzKQO2pbhL2rUrw4hA==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr19039735wmb.78.1635161116049;
        Mon, 25 Oct 2021 04:25:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm19021993wmi.1.2021.10.25.04.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 04:25:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 8/8] progress.c: add & assert a "global_progress" variable
Date:   Mon, 25 Oct 2021 13:25:07 +0200
Message-Id: <patch-v4-8.8-06124e8ac5e-20211025T111915Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1510.ge5c82eefb93
In-Reply-To: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
References: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
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
SIGALRM, this will cover cases where we're busy, but either haven't
invoked our first display_progress() yet, or the time between
display_progress() is too long. See [3] for early code to do that.

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
2.33.1.1510.ge5c82eefb93

