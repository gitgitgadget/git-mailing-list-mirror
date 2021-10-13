Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E53C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64DB5610F9
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhJMWag (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 18:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhJMWaf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 18:30:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC42CC061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o20so13257504wro.3
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBQrxoqopC7lKNwY7pR3M7d9exFDQYdSo5Sua1MzHsE=;
        b=fjcjqs45tfWiNVCAWj1tLL+8VfbO7iiCOlrbLWqM1i5ptlI99q2fBO0WJ9ilPwg4Ds
         YwDo1At5QTL4bUSgdaZWR/t6Vz1V/qKLvqqCVUdM85gOWgnU8DTW/lRrIsBJtkhTEMxm
         n4nnoJoJ0fRZPVFG/wRxTc000qushiWe0R2z/BKOu8J02GYvFSUI8Ys792hG4v7PHgwi
         TK26bi8kTJmlF6MWy3vgauK6NdY/K9LMahAswx54rRBWI90Ehl9tItduXrPedlV8fxa4
         vTenKUYQFY9KpQWqY/jLb+BR0MVlpV9aK/djcLNxlW9lB4k1VGspby1cIPaXb/+D0LBh
         FOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBQrxoqopC7lKNwY7pR3M7d9exFDQYdSo5Sua1MzHsE=;
        b=bxDGZ/3p9fyHBN+WBdlYxBbIsgbLTnZFUX+Hdipn+HPFwaH9twaNt5H1E9jAHpNk51
         2gIY7SgxxYCEvPt/FvWIVssRDhyfiIu9st7w0ztdkt/hu+qtazssm6izjqvtrarwSA81
         41ywq1txnkD14WJeBn7t8fa2UzRaAW0tIPjtvp3B0A2oy3I0s8TJmQ6XDuUolj7UA75P
         4Obm2IvtIIMFwAbVUbhLwvKRYE9rq0ikxFvD2q9YXpqYUzGcv4KWhbdit2cqYl+Mr4aC
         cNXhSZNndSximxiGZrksNoOdDveOMn7/cBjik05nacDnFR5aGNVYZK/qJ9yHU+wanhzO
         v5eQ==
X-Gm-Message-State: AOAM532RZVgvGlCPvNhGef4Flcwn9NVaOahDA22pCIDQhL+WDG4vHBoC
        /tHf47r3hrdvDSdrj7gjSKgseSBPDR5zlA==
X-Google-Smtp-Source: ABdhPJyibDDDSM9o0h8Lj9jExTg/tSwlX7m/AUO8rV1lHcp2vg3SeG71HRloTxhkzPF0VLv1ItOCEQ==
X-Received: by 2002:a5d:4f8d:: with SMTP id d13mr2102214wru.239.1634164108133;
        Wed, 13 Oct 2021 15:28:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l5sm736683wrq.77.2021.10.13.15.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:28:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/10] progress: assert "global_progress" + test fixes / cleanup
Date:   Thu, 14 Oct 2021 00:28:16 +0200
Message-Id: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes various issues in and related to progress.c, and
adds a BUG() assertion for us not starting two progress bars at the
same time. Those changes are needed for subsequent changes that do
more interesting things with this new global progress bar.

This v3 hopefully addresses all the feedback on the v2, thanks
all. Changes:

 * Fix a memory leak in 1/10, and make the progress tests use the
   SANITIZE=leak test mode.

 * Simplified some of the test-progress.c code (no more "start"
   handling, the "total" count is mandatory now.

 * Split out a formatting change into 2/10 to make 3/10 easier to
   read.

 * A new 9/10 makes an ad-hoc test recipie in 10/10 easier to explain
   (in response to Emily's comment).

 * The BUG() assertion in 10/10 now has a much better message, we dump
   the title of the two progress bars in play if we have a bug where
   we started two at the same time.


Ævar Arnfjörð Bjarmason (10):
  leak tests: fix a memory leaks in "test-progress" helper
  progress.c test helper: add missing braces
  progress.c tests: make start/stop verbs on stdin
  progress.c tests: test some invalid usage
  progress.c: move signal handler functions lower
  progress.c: call progress_interval() from progress_test_force_update()
  progress.c: add temporary variable from progress struct
  pack-bitmap-write.c: don't return without stop_progress()
  various *.c: use isatty(1|2), not isatty(STDIN_FILENO|STDERR_FILENO)
  progress.c: add & assert a "global_progress" variable

 builtin/bisect--helper.c    |   2 +-
 builtin/bundle.c            |   2 +-
 compat/mingw.c              |   2 +-
 pack-bitmap-write.c         |   6 +-
 progress.c                  | 111 ++++++++++++++++++++----------------
 t/helper/test-progress.c    |  43 +++++++++-----
 t/t0500-progress-display.sh | 105 +++++++++++++++++++++++++++-------
 7 files changed, 183 insertions(+), 88 deletions(-)

Range-diff against v2:
 -:  ----------- >  1:  40f7c438a1e leak tests: fix a memory leaks in "test-progress" helper
 -:  ----------- >  2:  ee177d253a8 progress.c test helper: add missing braces
 1:  e0a294eb479 !  3:  045d58d8201 progress.c tests: make start/stop verbs on stdin
    @@ Commit message
         This makes for tests that are easier to read, since the recipe will
         mirror the API usage, and allows for easily testing invalid usage that
         would yield (or should yield) a BUG(), e.g. providing two "start"
    -    calls in a row. A subsequent commit will add such stress tests.
    +    calls in a row. A subsequent commit will add such tests.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/helper/test-progress.c
       *
       * Reads instructions from standard input, one instruction per line:
       *
    -+ *   "start[ <total>[ <title>]]" - Call start_progress(title, total),
    -+ *                                 when "start" use a title of
    -+ *                                 "Working hard" with a total of 0.
    ++ *   "start <total>[ <title>]" - Call start_progress(title, total),
    ++ *                               Uses the default title of "Working hard"
    ++ *                               if the " <title>" is omitted.
       *   "progress <items>" - Call display_progress() with the given item count
       *                        as parameter.
       *   "throughput <bytes> <millis> - Call display_throughput() with the given
    @@ t/helper/test-progress.c
       * See 't0500-progress-display.sh' for examples.
       */
     @@
    + #include "parse-options.h"
    + #include "progress.h"
    + #include "strbuf.h"
    ++#include "string-list.h"
      
      int cmd__progress(int argc, const char **argv)
      {
     -	int total = 0;
     -	const char *title;
    -+	const char *default_title = "Working hard";
    -+	char *detached_title = NULL;
    ++	const char *const default_title = "Working hard";
    ++	struct string_list list = STRING_LIST_INIT_DUP;
    ++	const struct string_list_item *item;
      	struct strbuf line = STRBUF_INIT;
     -	struct progress *progress;
     +	struct progress *progress = NULL;
    @@ t/helper/test-progress.c
      		char *end;
      
     -		if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
    -+		if (!strcmp(line.buf, "start")) {
    -+			progress = start_progress(default_title, 0);
    -+		} else if (skip_prefix(line.buf, "start ", (const char **) &end)) {
    ++		if (skip_prefix(line.buf, "start ", (const char **) &end)) {
     +			uint64_t total = strtoull(end, &end, 10);
     +			if (*end == '\0') {
     +				progress = start_progress(default_title, total);
     +			} else if (*end == ' ') {
    -+				free(detached_title);
    -+				detached_title = strbuf_detach(&line, NULL);
    -+				progress = start_progress(end + 1, total);
    ++				item = string_list_insert(&list, end + 1);
    ++				progress = start_progress(item->string, total);
     +			} else {
     +				die("invalid input: '%s'\n", line.buf);
     +			}
    @@ t/helper/test-progress.c
      			if (*end != '\0')
      				die("invalid input: '%s'\n", line.buf);
     @@ t/helper/test-progress.c: int cmd__progress(int argc, const char **argv)
    - 				die("invalid input: '%s'\n", line.buf);
    - 			progress_test_ns = test_ms * 1000 * 1000;
      			display_throughput(progress, byte_count);
    --		} else if (!strcmp(line.buf, "update"))
    -+		} else if (!strcmp(line.buf, "update")) {
    + 		} else if (!strcmp(line.buf, "update")) {
      			progress_test_force_update();
    --		else
     +		} else if (!strcmp(line.buf, "stop")) {
     +			stop_progress(&progress);
    -+		} else {
    + 		} else {
      			die("invalid input: '%s'\n", line.buf);
    -+		}
    + 		}
      	}
     -	stop_progress(&progress);
    -+	free(detached_title);
    + 	strbuf_release(&line);
    ++	string_list_clear(&list, 0);
      
      	return 0;
      }
    @@ t/t0500-progress-display.sh: Working hard.......2.........3.........4.........5.
      EOF
      
      	cat >in <<-\EOF &&
    --	update
     +	start 100000 Working hard.......2.........3.........4.........5.........6
    + 	update
      	progress 1
      	update
      	progress 2
    @@ t/t0500-progress-display.sh: test_expect_success 'progress display with throughp
      	EOF
      
      	cat >in <<-\EOF &&
    -+	start
    ++	start 0
      	throughput 102400 1000
      	update
      	progress 10
    @@ t/t0500-progress-display.sh: test_expect_success 'cover up after throughput shor
      	EOF
      
      	cat >in <<-\EOF &&
    -+	start
    ++	start 0
      	throughput 409600 1000
      	update
      	progress 1
    @@ t/t0500-progress-display.sh: test_expect_success 'cover up after throughput shor
      	EOF
      
      	cat >in <<-\EOF &&
    -+	start
    ++	start 0
      	throughput 1 1000
      	update
      	progress 1
 2:  7b1220b641e !  4:  efc0ec360cc progress.c tests: test some invalid usage
    @@ Commit message
         extends the trace2 tests added in 98a13647408 (trace2: log progress
         time and throughput, 2020-05-12).
     
    +    These tests are not merely testing the helper, but invalid API usage
    +    that can happen if the progress.c API is misused.
    +
    +    The "without stop" test will leak under SANITIZE=leak, since this
    +    buggy use of the API will leak memory. But let's not skip it entirely,
    +    or use the "!SANITIZE_LEAK" prerequisite check as we'd do with tests
    +    that we're skipping due to leaks we haven't fixed yet. Instead
    +    annotate the specific command that should skip leak checking with
    +    custom $LSAN_OPTIONS[1].
    +
    +    1. https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t0500-progress-display.sh ##
    @@ t/t0500-progress-display.sh: test_expect_success 'progress generates traces' '
      
     +test_expect_success 'progress generates traces: stop / start' '
     +	cat >in <<-\EOF &&
    -+	start
    ++	start 0
     +	stop
     +	EOF
     +
    @@ t/t0500-progress-display.sh: test_expect_success 'progress generates traces' '
     +
     +test_expect_success 'progress generates traces: start without stop' '
     +	cat >in <<-\EOF &&
    -+	start
    ++	start 0
     +	EOF
     +
    -+	GIT_TRACE2_EVENT="$(pwd)/trace-start.event" test-tool progress \
    ++	GIT_TRACE2_EVENT="$(pwd)/trace-start.event" \
    ++	LSAN_OPTIONS=detect_leaks=0 \
    ++	test-tool progress \
     +		<in 2>stderr &&
     +	grep region_enter.*progress trace-start.event &&
     +	! grep region_leave.*progress trace-start.event
 3:  f1b8bf1dbde =  5:  9e36f03de46 progress.c: move signal handler functions lower
 4:  74057b0046a =  6:  c7c3843564e progress.c: call progress_interval() from progress_test_force_update()
 5:  250e50667c2 <  -:  ----------- progress.c: stop eagerly fflush(stderr) when not a terminal
 6:  d4e9ff1de73 =  7:  cd2d27b1626 progress.c: add temporary variable from progress struct
 7:  a3f133ca7ad !  8:  e0a3510dd88 pack-bitmap-write.c: add a missing stop_progress()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    pack-bitmap-write.c: add a missing stop_progress()
    +    pack-bitmap-write.c: don't return without stop_progress()
     
         Fix a bug that's been here since 7cc8f971085 (pack-objects: implement
         bitmap writing, 2013-12-21), we did not call stop_progress() if we
    -    reached the early exit in this function. This will matter in a
    -    subsequent commit where we BUG(...) out if this happens, and matters
    -    now e.g. because we don't have a corresponding "region_end" for the
    -    progress trace2 event.
    +    reached the early exit in this function.
     
    +    We could call stop_progress() before we return, but better yet is to
    +    defer calling start_progress() until we need it.
    +
    +    This will matter in a subsequent commit where we BUG(...) out if this
    +    happens, and matters now e.g. because we don't have a corresponding
    +    "region_end" for the progress trace2 event.
    +
    +    Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## pack-bitmap-write.c ##
     @@ pack-bitmap-write.c: void bitmap_writer_select_commits(struct commit **indexed_commits,
    + 
    + 	QSORT(indexed_commits, indexed_commits_nr, date_compare);
    + 
    +-	if (writer.show_progress)
    +-		writer.progress = start_progress("Selecting bitmap commits", 0);
    +-
      	if (indexed_commits_nr < 100) {
      		for (i = 0; i < indexed_commits_nr; ++i)
      			push_bitmapped_commit(indexed_commits[i]);
    -+		stop_progress(&writer.progress);
      		return;
      	}
      
    ++	if (writer.show_progress)
    ++		writer.progress = start_progress("Selecting bitmap commits", 0);
    ++
    + 	for (;;) {
    + 		struct commit *chosen = NULL;
    + 
 -:  ----------- >  9:  2cf14881ecf various *.c: use isatty(1|2), not isatty(STDIN_FILENO|STDERR_FILENO)
 8:  1bd285eba0d ! 10:  01d5bbfce76 progress.c: add & assert a "global_progress" variable
    @@ Commit message
          3. I've likewise done an ad-hoc test to force progress bars to be
             displayed with:
     
    -            perl -pi -e 's[isatty\((?:STDERR_FILENO|2)\)][1]g' $(git grep -l 'isatty\((STDERR_FILENO|2)\)')
    +            perl -pi -e 's[isatty\(2\)][1]g' $(git grep -l -F 'isatty(2)')
     
             I.e. to replace all checks (not just for progress) of checking
             whether STDERR is connected to a TTY, and then monkeypatching
    @@ progress.c: void progress_test_force_update(void)
      	struct itimerval v;
      
     +	if (global_progress)
    -+		BUG("should have no global_progress in set_progress_signal()");
    ++		BUG("'%s' progress still active when trying to start '%s'",
    ++		    global_progress->title, progress->title);
     +	global_progress = progress;
     +
      	if (progress_testing)
    @@ progress.c: static void set_progress_signal(void)
      	struct itimerval v = {{0,},};
      
     +	if (!global_progress)
    -+		BUG("should have a global_progress in clear_progress_signal()");
    ++		BUG("should have active global_progress when cleaning up");
     +	global_progress = NULL;
     +
      	if (progress_testing)
    @@ t/t0500-progress-display.sh: test_expect_success 'cover up after throughput shor
     +
     +	test_must_fail test-tool progress \
     +		<in 2>stderr &&
    -+	grep -E "^BUG: .*: should have no global_progress in set_progress_signal\(\)$" stderr
    ++	grep "^BUG: .*'\''one'\'' progress still active when trying to start '\''two'\''$" stderr
     +'
     +
      test_expect_success 'progress generates traces' '
-- 
2.33.1.1346.g48288c3c089

