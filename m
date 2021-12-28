Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE3AC433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhL1PT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbhL1PT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:19:26 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1B8C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:19:25 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l4so11828141wmq.3
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qtHS407AXq4lnzbQ4O/Tj/6g5Il7BkEAy2NhDzl1gZc=;
        b=MggUa4KuB2G8zAtqhMc4e7SM56r9xpSwmtu/9x1tFBtE9CFDdqZ/Xqf1989KUdfvmQ
         YRl/XeERm58WGNpQa8uJ8XoCqfF6K2gfk2/gEm5HZkkycaE81V1sqwJOZS3i7guTQG6m
         Mx1gvkbODuHIJMM0c63ibs2XeJ27ciREGyE6N/y6q//aRFc9cDEMRqW4O2R5tESGYr6i
         r0Da5uGGQg6GHlftxPsc3eoiE8VITrjcVYahHLz5KOB4DV79AIjSpLpmqjo5B94GJoM/
         OcNqNQP2xwEOhrEfBkHVkbyAT2QzLYeFEuq6KSSzCePduMd/vXmpwj2NNNyMjOts5FQN
         rbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtHS407AXq4lnzbQ4O/Tj/6g5Il7BkEAy2NhDzl1gZc=;
        b=7oFff7Uy+tOJKyc4w//evEkSNTgNz8aFnAcNZyqnyW5ZCcd6xI5FTzj5lLQe9tn9+x
         eerE58mgxrhXYgGb0F4Uhbv7oVZFpRBhbd82PAcpzRS0U+2br6FlCw/qQbLQc/DYUQyg
         zoUgKNRSNkn8a3aLVKWhPAta+YRJj0tPWQaPXb0YC/kzq0XDfhJP7zIs2zcuxkLdQrwh
         jD52GOOc2ViBfrmOtOGDZSPSb41XPiRyQNTr1JLiZgT11lgjdj2EEcEM2HBdIRy2ppr0
         LD+nZ3CRW4TMf+Ea7dQ+q1mQxbOfJRTiWhhT9C6s2P7FUnrVmapXHpI648wx5FHgBxeO
         FUcA==
X-Gm-Message-State: AOAM530YndviqjZVnSOjLLOlYuIF/E0PB4FW5Lq496Si0VMHQH/zWVpw
        7fCrh+WRP+MEy4+dk61JinnMPLUMX/c8SZA8
X-Google-Smtp-Source: ABdhPJykbc0t8o4g55xxfowut3URbpXbaMWzDcwAcRFY/dWea9dyAT3QSz3CbTUMq3A/fjcsfeiUIw==
X-Received: by 2002:a05:600c:a4c:: with SMTP id c12mr17898114wmq.60.1640704763830;
        Tue, 28 Dec 2021 07:19:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p11sm20491022wru.99.2021.12.28.07.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 07:19:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Altmanninger <aclopte@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 0/7] progress: test fixes / cleanup
Date:   Tue, 28 Dec 2021 16:18:56 +0100
Message-Id: <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Various test, leak and other fixes for the progress.c code and its
tests. This v8 addresses feedback on v7[1] by Johannes
Altmanninger. For that round I accidentally broke the In-Reply-To
chain, so I'm replying to the v6 here to attach it to the original
thread again.

1. https://lore.kernel.org/git/cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (7):
  leak tests: fix a memory leak in "test-progress" helper
  progress.c test helper: add missing braces
  progress.c tests: make start/stop commands on stdin
  progress.c tests: test some invalid usage
  progress.c: add temporary variable from progress struct
  pack-bitmap-write.c: don't return without stop_progress()
  *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)

 builtin/bisect--helper.c    |  2 +-
 builtin/bundle.c            |  2 +-
 compat/mingw.c              |  2 +-
 pack-bitmap-write.c         |  6 +--
 progress.c                  | 14 +++---
 t/helper/test-progress.c    | 52 +++++++++++++++-----
 t/t0500-progress-display.sh | 94 ++++++++++++++++++++++++++++---------
 7 files changed, 126 insertions(+), 46 deletions(-)

Range-diff against v7:
1:  5367293ee84 ! 1:  aa08dab654d leak tests: fix a memory leaks in "test-progress" helper
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    leak tests: fix a memory leaks in "test-progress" helper
    +    leak tests: fix a memory leak in "test-progress" helper
     
         Fix a memory leak in the test-progress helper, and mark the
         corresponding "t0500-progress-display.sh" test as being leak-free
2:  81788101763 = 2:  3ecdab074b6 progress.c test helper: add missing braces
3:  d685c248686 ! 3:  271f6d7ec3b progress.c tests: make start/stop commands on stdin
    @@ t/helper/test-progress.c
      #include "progress.h"
      #include "strbuf.h"
     +#include "string-list.h"
    -+
    -+/*
    -+ * We can't use "end + 1" as an argument to start_progress() below, it
    -+ * doesn't xstrdup() its "title" argument. We need to hold onto a
    -+ * valid "char *" for it until the end.
    -+ */
    -+static char *dup_title(struct string_list *titles, const char *title)
    -+{
    -+	return string_list_insert(titles, title)->string;
    -+}
      
      int cmd__progress(int argc, const char **argv)
      {
    @@ t/helper/test-progress.c
     -		if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
     +		if (skip_prefix(line.buf, "start ", (const char **) &end)) {
     +			uint64_t total = strtoull(end, &end, 10);
    -+			if (*end == '\0')
    -+				progress = start_progress(default_title, total);
    ++			const char *title;
    ++			const char *str;
    ++
    ++			/*
    ++			 * We can't use "end + 1" as an argument to
    ++			 * start_progress(), it doesn't xstrdup() its
    ++			 * "title" argument. We need to hold onto a
    ++			 * valid "char *" for it until the end.
    ++			 */
    ++			if (!*end)
    ++				title = default_title;
     +			else if (*end == ' ')
    -+				progress = start_progress(dup_title(&titles,
    -+								    end + 1),
    -+							  total);
    ++				title = string_list_insert(&titles, end + 1)->string;
     +			else
     +				die("invalid input: '%s'\n", line.buf);
    ++
    ++			str = title ? title : default_title;
    ++			progress = start_progress(str, total);
     +		} else if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
      			uint64_t item_count = strtoull(end, &end, 10);
      			if (*end != '\0')
4:  40e446da277 = 4:  7c1b8b287c5 progress.c tests: test some invalid usage
5:  c2303bfd130 ! 5:  72a31bd7191 progress.c: add temporary variable from progress struct
    @@ Metadata
      ## Commit message ##
         progress.c: add temporary variable from progress struct
     
    -    Add a temporary "progress" variable for the dereferenced p_progress
    -    pointer to a "struct progress *". Before 98a13647408 (trace2: log
    -    progress time and throughput, 2020-05-12) we didn't dereference
    -    "p_progress" in this function, now that we do it's easier to read the
    -    code if we work with a "progress" struct pointer like everywhere else,
    -    instead of a pointer to a pointer.
    +    Since 98a13647408 (trace2: log progress time and throughput,
    +    2020-05-12) stop_progress() dereferences a "struct progress **"
    +    parameter in several places. Extract a dereferenced variable (like in
    +    stop_progress_msg()) to reduce clutter and make it clearer who needs
    +    to write to this parameter.
    +
    +    Now instead of using "*p_progress" several times in stop_progress() we
    +    check it once for NULL and then use a dereferenced "progress" variable
    +    thereafter. This continues the same pattern used in the above
    +    stop_progress() function, see ac900fddb7f (progress: don't dereference
    +    before checking for NULL, 2020-08-10).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## progress.c ##
    -@@ progress.c: void stop_progress(struct progress **p_progress)
    - 	finish_if_sparse(*p_progress);
    +@@ progress.c: static void finish_if_sparse(struct progress *progress)
    + 
    + void stop_progress(struct progress **p_progress)
    + {
    ++	struct progress *progress;
    + 	if (!p_progress)
    + 		BUG("don't provide NULL to stop_progress");
    ++	progress = *p_progress;
    + 
    +-	finish_if_sparse(*p_progress);
    ++	finish_if_sparse(progress);
      
    - 	if (*p_progress) {
    -+		struct progress *progress = *p_progress;
    +-	if (*p_progress) {
    ++	if (progress) {
      		trace2_data_intmax("progress", the_repository, "total_objects",
    - 				   (*p_progress)->total);
    +-				   (*p_progress)->total);
    ++				   progress->total);
      
    - 		if ((*p_progress)->throughput)
    +-		if ((*p_progress)->throughput)
    ++		if (progress->throughput)
      			trace2_data_intmax("progress", the_repository,
      					   "total_bytes",
     -					   (*p_progress)->throughput->curr_total);
6:  776362de897 ! 6:  0bd08e1b018 pack-bitmap-write.c: don't return without stop_progress()
    @@ Commit message
         reached the early exit in this function.
     
         We could call stop_progress() before we return, but better yet is to
    -    defer calling start_progress() until we need it.
    -
    -    This will matter in a subsequent commit where we BUG(...) out if this
    -    happens, and matters now e.g. because we don't have a corresponding
    -    "region_end" for the progress trace2 event.
    +    defer calling start_progress() until we need it. For now this only
    +    matters in practice because we'd previously omit the "region_leave"
    +    for the progress trace2 event.
     
         Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
7:  0670d1aa5f2 ! 7:  060483fb5ce various *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    various *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
    +    *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
     
         We have over 50 uses of "isatty(1)" and "isatty(2)" in the codebase,
    -    and around 10 "isatty(0)", but these used the
    +    and around 10 "isatty(0)", but three callers used the
         {STDIN_FILENO,STD{OUT,ERR}_FILENO} macros in "stdlib.h" to refer to
         them.
     
    -    Let's change these for consistency, and because another commit that
    -    would like to be based on top of this one[1] has a recipe to change
    -    all of these for ad-hoc testing, not needing to match these with that
    -    ad-hoc regex will make things easier to explain. Only one of these is
    -    related to the "struct progress" code which it discusses, but let's
    -    change all of these while we're at it.
    +    Let's change these for consistency.  This makes it easier to change
    +    all calls to isatty() at a whim, which is useful to test some
    +    scenarios[1].
     
         1. https://lore.kernel.org/git/patch-v6-8.8-bff919994b5-20211102T122507Z-avarab@gmail.com/
     
-- 
2.34.1.1257.g2af47340c7b

