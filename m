Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07860C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6DB060F46
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhJYL1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbhJYL1e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 07:27:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78AAC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d3so8041918wrh.8
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2YHDNwsJUK206Rx23tAPBcTZyfB5EdjRMeQeEproxHQ=;
        b=UM3O/38VFS2YKplBJnYSaH+eJWLSC0Gt4ncwxCfhyMRnFSZzSROYOYT3ntX7RrPsLP
         NhXOy2ar3uR6bQwFRU9b8o+Vse3jG/KIyzBH8zUXPLGKVjsUK2hGNUZEvXF/jIB1VJz4
         x0r84q7xjr+YGD5ZR3BhQnsTQTzAnKZlnRp9M75fg7dAXqpzYQGgso+gAQT60He0fDjp
         Yx8nRlcgI79aCtZGF351/X3NC/R7bi1YbVAaeKORwPoLQxYDkIse2ZyzWyN3SyyyJgkp
         3uNdKWsRSzN9JSVkeibzd5+6xL1CqFzlQUHpjzlbXl0j1nTULH+PVJdtFvdNNFpu9QuW
         lgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2YHDNwsJUK206Rx23tAPBcTZyfB5EdjRMeQeEproxHQ=;
        b=6prNx27zxxYSG1R84ZtKCmkXPquzjMA9J/MBIV+Wb8kVhEDqCV40rJS4pq0blriyhM
         PLMh6ejp2TnMijD0lWK3VC2ur0Gq2f/RyEkHzWj5lv+F5Xp6SMkJ9xZ5iguMwRxzcTjD
         e3rp1G17W0ZkhOglXidELfBxMeYOJzVhqbd2LesVS1wvtV+JvA1eSULVWzV5B01WfcKA
         OHRDrJvKK5duy4A45zSnVBsKKOV2g1vaLaxjFK3Ultr0Zs+OYVgA0W5F+PFrkvrS6FP8
         +IIiyksNkqD4GDqRk+3BgWJqWY5X2ajxj800r2ln7OD0QFxEt9rRj+xAPg+jVao6n6zL
         dpTA==
X-Gm-Message-State: AOAM532WnuABmiZamz/tc1pJuu8bNIpr9am457KC/zym7XT9f3dtM24h
        OANiW3EHQ3uX9Lmgcz0sVU+piXbR2AjnLQ==
X-Google-Smtp-Source: ABdhPJwisQTCmWOuQRvHibnF4B4Oouh8BVRDLHFQiqcNriblOuYVgS3SQhvbyVXNbHGr9fth4XhGfQ==
X-Received: by 2002:adf:a2d4:: with SMTP id t20mr22404079wra.229.1635161109954;
        Mon, 25 Oct 2021 04:25:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm19021993wmi.1.2021.10.25.04.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 04:25:09 -0700 (PDT)
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
Subject: [PATCH v4 0/8] progress: assert "global_progress" + test fixes / cleanup
Date:   Mon, 25 Oct 2021 13:24:59 +0200
Message-Id: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1510.ge5c82eefb93
In-Reply-To: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
References: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
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

I think this should address all the feedback on v3[1]. Changes:

 * Clarified the whole string_list_insert() in test-progress.c. I
   added a wrapper function with a comment to make that code flow
   clearer, and as a bonus could drop braces and a temporary variable
   from the main function as a result.

 * I elaborated on the "limitations in the progress output" part of
   the commit message, and tried to address the safety concerns SZEDER
   expressed in [2]. I think we might still disagree on whether 8/8 is
   worth it overall, but hopefully this addreses any outstanding
   questions about the approach & why it's being taken.

 * SZEDER pointed out that I should move the BUG() assert out of the
   signal handlers, there's now a couple of small helpers to do that,
   which also allowed for ejecting a couple of earlier refactoring
   commits (code moves as they were "static").

1. https://lore.kernel.org/git/cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com/
2. https://lore.kernel.org/git/20211025050202.GC2101@szeder.dev/

Ævar Arnfjörð Bjarmason (8):
  leak tests: fix a memory leaks in "test-progress" helper
  progress.c test helper: add missing braces
  progress.c tests: make start/stop commands on stdin
  progress.c tests: test some invalid usage
  progress.c: add temporary variable from progress struct
  pack-bitmap-write.c: don't return without stop_progress()
  various *.c: use isatty(1|2), not isatty(STDIN_FILENO|STDERR_FILENO)
  progress.c: add & assert a "global_progress" variable

 builtin/bisect--helper.c    |   2 +-
 builtin/bundle.c            |   2 +-
 compat/mingw.c              |   2 +-
 pack-bitmap-write.c         |   6 +--
 progress.c                  |  23 +++++++-
 t/helper/test-progress.c    |  52 +++++++++++++-----
 t/t0500-progress-display.sh | 105 ++++++++++++++++++++++++++++--------
 7 files changed, 150 insertions(+), 42 deletions(-)

Range-diff against v3:
 1:  40f7c438a1e =  1:  a3bd032d1eb leak tests: fix a memory leaks in "test-progress" helper
 2:  ee177d253a8 =  2:  e441cfea7c5 progress.c test helper: add missing braces
 3:  045d58d8201 !  3:  1c5f9bdfe6d progress.c tests: make start/stop verbs on stdin
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    progress.c tests: make start/stop verbs on stdin
    +    progress.c tests: make start/stop commands on stdin
     
         Change the usage of the "test-tool progress" introduced in
         2bb74b53a49 (Test the progress display, 2019-09-16) to take command
    @@ t/helper/test-progress.c
      #include "progress.h"
      #include "strbuf.h"
     +#include "string-list.h"
    ++
    ++/*
    ++ * We can't use "end + 1" as an argument to start_progress() below, it
    ++ * doesn't xstrdup() its "title" argument. We need to hold onto a
    ++ * valid "char *" for it until the end.
    ++ */
    ++static char *dup_title(struct string_list *titles, const char *title)
    ++{
    ++	return string_list_insert(titles, title)->string;
    ++}
      
      int cmd__progress(int argc, const char **argv)
      {
     -	int total = 0;
     -	const char *title;
     +	const char *const default_title = "Working hard";
    -+	struct string_list list = STRING_LIST_INIT_DUP;
    -+	const struct string_list_item *item;
    ++	struct string_list titles = STRING_LIST_INIT_DUP;
      	struct strbuf line = STRBUF_INIT;
     -	struct progress *progress;
     +	struct progress *progress = NULL;
    @@ t/helper/test-progress.c
     -		if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
     +		if (skip_prefix(line.buf, "start ", (const char **) &end)) {
     +			uint64_t total = strtoull(end, &end, 10);
    -+			if (*end == '\0') {
    ++			if (*end == '\0')
     +				progress = start_progress(default_title, total);
    -+			} else if (*end == ' ') {
    -+				item = string_list_insert(&list, end + 1);
    -+				progress = start_progress(item->string, total);
    -+			} else {
    ++			else if (*end == ' ')
    ++				progress = start_progress(dup_title(&titles,
    ++								    end + 1),
    ++							  total);
    ++			else
     +				die("invalid input: '%s'\n", line.buf);
    -+			}
     +		} else if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
      			uint64_t item_count = strtoull(end, &end, 10);
      			if (*end != '\0')
    @@ t/helper/test-progress.c: int cmd__progress(int argc, const char **argv)
      	}
     -	stop_progress(&progress);
      	strbuf_release(&line);
    -+	string_list_clear(&list, 0);
    ++	string_list_clear(&titles, 0);
      
      	return 0;
      }
 4:  efc0ec360cc =  4:  474ce31f9d2 progress.c tests: test some invalid usage
 5:  9e36f03de46 <  -:  ----------- progress.c: move signal handler functions lower
 6:  c7c3843564e <  -:  ----------- progress.c: call progress_interval() from progress_test_force_update()
 7:  cd2d27b1626 =  5:  ff039742148 progress.c: add temporary variable from progress struct
 8:  e0a3510dd88 =  6:  3dfe31decff pack-bitmap-write.c: don't return without stop_progress()
 9:  2cf14881ecf =  7:  8a18eb40fae various *.c: use isatty(1|2), not isatty(STDIN_FILENO|STDERR_FILENO)
10:  01d5bbfce76 !  8:  06124e8ac5e progress.c: add & assert a "global_progress" variable
    @@ Commit message
         limitations in the progress output: The current output must be
         "driven" by calls to the likes of display_progress(). Once we have a
         global current progress object we'll be able to update that object via
    -    SIGALRM. See [3] for early code to do that.
    +    SIGALRM, this will cover cases where we're busy, but either haven't
    +    invoked our first display_progress() yet, or the time between
    +    display_progress() is too long. See [3] for early code to do that.
     
         It's conceivable that this change will hit the BUG() condition in some
         scenario that we don't currently have tests for, this would be very
    @@ Commit message
             above, and the tests that are testing that the progress output
             itself is present (but for testing I'd made display() a NOOP).
     
    -    Between those three points I think it's safe to go ahead with this
    +    This doesn't address any currently out-of-tree user of progress.c,
    +    i.e. WIP patches, or progress output that's a part of forks of
    +    git.git. Those hopefully have test coverage that would expose the
    +    BUG().
    +
    +    If they don't they'll either run into it in code that displays more
    +    than one progress bar for the lifetime of the progress, or which calls
    +    stop_progress() with a non-NULL "progress" without a corresponding
    +    start_progress(). Both of those cases are less likely than the general
    +    cases of progress.c API misuse.
    +
    +    Between those three points above and the discussion of how this could
    +    impact out-of-tree users I think it's safe to go ahead with this
         change.
     
         1. 6f9d5f2fda1 (commit-graph: fix progress of reachable commits, 2020-07-09)
    @@ progress.c: struct progress {
      
      /*
       * These are only intended for testing the progress output, i.e. exclusively
    -@@ progress.c: void progress_test_force_update(void)
    - 	progress_interval(SIGALRM);
    +@@ progress.c: void display_progress(struct progress *progress, uint64_t n)
    + 		display(progress, n, NULL);
      }
      
    --static void set_progress_signal(void)
    -+static void set_progress_signal(struct progress *progress)
    - {
    - 	struct sigaction sa;
    - 	struct itimerval v;
    - 
    ++static void set_global_progress(struct progress *progress)
    ++{
     +	if (global_progress)
     +		BUG("'%s' progress still active when trying to start '%s'",
     +		    global_progress->title, progress->title);
     +	global_progress = progress;
    ++}
     +
    - 	if (progress_testing)
    - 		return;
    - 
    -@@ progress.c: static void set_progress_signal(void)
    - 	setitimer(ITIMER_REAL, &v, NULL);
    - }
    - 
    --static void clear_progress_signal(void)
    -+static void clear_progress_signal(struct progress *progress)
    + static struct progress *start_progress_delay(const char *title, uint64_t total,
    + 					     unsigned delay, unsigned sparse)
      {
    - 	struct itimerval v = {{0,},};
    - 
    -+	if (!global_progress)
    -+		BUG("should have active global_progress when cleaning up");
    -+	global_progress = NULL;
    -+
    - 	if (progress_testing)
    - 		return;
    - 
     @@ progress.c: static struct progress *start_progress_delay(const char *title, uint64_t total,
      	strbuf_init(&progress->counters_sb, 0);
      	progress->title_len = utf8_strwidth(title);
      	progress->split = 0;
    --	set_progress_signal();
    -+	set_progress_signal(progress);
    ++	set_global_progress(progress);
    + 	set_progress_signal();
      	trace2_region_enter("progress", title, the_repository);
      	return progress;
    +@@ progress.c: void stop_progress(struct progress **p_progress)
    + 	stop_progress_msg(p_progress, _("done"));
      }
    + 
    ++static void unset_global_progress(void)
    ++{
    ++	if (!global_progress)
    ++		BUG("should have active global_progress when cleaning up");
    ++	global_progress = NULL;
    ++}
    ++
    + void stop_progress_msg(struct progress **p_progress, const char *msg)
    + {
    + 	struct progress *progress;
     @@ progress.c: void stop_progress_msg(struct progress **p_progress, const char *msg)
    - 		display(progress, progress->last_value, buf);
      		free(buf);
      	}
    --	clear_progress_signal();
    -+	clear_progress_signal(progress);
    + 	clear_progress_signal();
    ++	unset_global_progress();
      	strbuf_release(&progress->counters_sb);
      	if (progress->throughput)
      		strbuf_release(&progress->throughput->display);
-- 
2.33.1.1510.ge5c82eefb93

