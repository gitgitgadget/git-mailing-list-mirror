Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF433C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 10:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D7864E30
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 10:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhBKKuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 05:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhBKKqm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 05:46:42 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3C8C061794
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 02:45:41 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l17so3546159wmq.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 02:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G5wjg7V7EKFlFbxXEqv1O2aIdgUy4qb/q5kO86nl0UI=;
        b=jdAtU54aBeQtS7O9/OqwrhF6jaBr9+LC0Xm2LXzCRlQrFbptjyzPt6BVwtf/Th8oWw
         sh+fNwZ+JHA5/LJqqfokIf6wXlD6V5hdHBN8QtgCJ4sA+UgETr4WKLTvwDUOgc/ZKPkO
         KdxbqnhtdPK9UVFgsMaM2HpWVKTC9TTMrqUJSmCNsV0cxSC1cgZLg3rdTL7ncntN/Dq7
         R3e0BtHB3JA7hmXWtbFh+Oy2e4SErrNRoVJXLHTeAnvwPEcT2hJ3xWuBMZWMWkk2hrcq
         P5ouwaaZMbmrbznDkK++HY9UJQ0Nbh/Fnm7AHDjGOToNqCH3y0hn7bTmj0MOnImdgjOL
         dhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G5wjg7V7EKFlFbxXEqv1O2aIdgUy4qb/q5kO86nl0UI=;
        b=GfAaOBBPayBJrrFigtrT60XlshxRunhytIABl+FIooVZeyUTOvHjKDnEOhWFJAd1CE
         6KOHcq7ifzVWt3op1ueEhF7f+USnjER7n1NSG3ZASFos+yXtlue5s7+jH2vzYSMLOE0F
         o4pjlh3a3WTQWcgvQVMNNaMmLJJfLzmqvW3s87U83t1uP47h9klt/M27yGJhKpT+PFsX
         u45dErys1HC7w4LP94TqCBkykUEVS5N+wKZhnmZbI9ssSYwIp2nlFgL3f+TkMzkDMS5v
         UuJ7HsZG6faRxSBB3Z8Y3gaxEMXxqCLC9h9/8aAzmGnul3XMaywpBGQrYLm1LCWs4+Mp
         XMvQ==
X-Gm-Message-State: AOAM531iEMhM3CwtAnCbFRHJKbgTHW328KygC5iTey0xo42jjLWaK1sh
        g3h8m0b5B8WieTryE7LdWY7N7EupXMoJ6g==
X-Google-Smtp-Source: ABdhPJxAOBXzV4NipWIGTYAb3THcz4rf8+z0AQa3qo8NnT0v5/YhMapUsJEtVff9WLcycHSmuApaAA==
X-Received: by 2002:a1c:ac85:: with SMTP id v127mr4542313wme.133.1613040339767;
        Thu, 11 Feb 2021 02:45:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s11sm164767wra.82.2021.02.11.02.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 02:45:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <michal@isc.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] diff: add an API for deferred freeing
Date:   Thu, 11 Feb 2021 11:45:34 +0100
Message-Id: <20210211104535.16076-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <YCUFNVj7qlt9wzlX@coredump.intra.peff.net>
References: <YCUFNVj7qlt9wzlX@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a diff_free() function to free anything we may have allocated in
the "diff_options" struct, and the ability to make calling it a noop
by setting "no_free" in "diff_options".

This is required because when e.g. "git diff" is run we'll allocate
things in that struct, use the diff machinery once, and then exit.

But if we run e.g. "git log -p" we're going to re-use what we
allocated across multiple diff_flush() calls, and only want to free
things at the end.

We've thus ended up with features like the recently added "diff -I"[1]
where we'll leak memory. As it turns out it could have simply used the
pattern established in 6ea57703f6 (log: prepare log/log-tree to reuse
the diffopt.close_file attribute, 2016-06-22).

Manually adding more such flags to things log_tree_commit() every time
we need to allocate something would be tedious. Let's instead move
that fclose() code it to a new diff_free(), in anticipation of freeing
more things in that function in follow-up commits.

Some functions such as log_tree_commit() need an idiom of optionally
retaining a previous "no_free", as they may either free the memory
themselves, or their caller may do so. I'm keeping that idiom in
log_show_early() for good measure, even though I don't think it's
currently called in this manner. It also gets passed an existing
"struct rev_info", so future callers may want to set the "no_free"
flag.

This change is a bit hard to read because while the freeing pattern
we're introducing isn't unusual, the "file" member is a special
snowflake. We usually don't want to fclose() it. This is because
"file" is usually stdout, in which case we don't want to fclose()
it. We only want to opt-in to closing it when we e.g. open a file on
the filesystem. Thus the opt-in "close_file" flag.

So the API in general just needs a "no_free" flag to defer freeing,
but the "file" member still needs its "close_file" flag. This is made
more confusing because while refactoring this code we could replace
some "close_file=0" with "no_free=1", whereas others need to set both
flags.

This is because there were some cases where an existing "close_file=0"
meant "let's defer deallocation", and others where it meant "we don't
want to close this file handle at all".

1. 296d4a94e7 (diff: add -I<regex> that ignores matching changes,
   2020-10-20)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/log.c | 23 ++++++++++++-----------
 diff.c        | 20 ++++++++++++++++----
 diff.h        | 15 ++++++++++++++-
 log-tree.c    | 10 ++++++----
 4 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d0cbaaf68a0..fffaf51970d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -307,10 +307,11 @@ static struct itimerval early_output_timer;
 
 static void log_show_early(struct rev_info *revs, struct commit_list *list)
 {
-	int i = revs->early_output, close_file = revs->diffopt.close_file;
+	int i = revs->early_output;
 	int show_header = 1;
+	int no_free = revs->diffopt.no_free;
 
-	revs->diffopt.close_file = 0;
+	revs->diffopt.no_free = 0;
 	sort_in_topological_order(&list, revs->sort_order);
 	while (list && i) {
 		struct commit *commit = list->item;
@@ -327,8 +328,8 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
 		case commit_ignore:
 			break;
 		case commit_error:
-			if (close_file)
-				fclose(revs->diffopt.file);
+			revs->diffopt.no_free = no_free;
+			diff_free(&revs->diffopt);
 			return;
 		}
 		list = list->next;
@@ -336,8 +337,8 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
 
 	/* Did we already get enough commits for the early output? */
 	if (!i) {
-		if (close_file)
-			fclose(revs->diffopt.file);
+		revs->diffopt.no_free = 0;
+		diff_free(&revs->diffopt);
 		return;
 	}
 
@@ -401,7 +402,7 @@ static int cmd_log_walk(struct rev_info *rev)
 {
 	struct commit *commit;
 	int saved_nrl = 0;
-	int saved_dcctc = 0, close_file = rev->diffopt.close_file;
+	int saved_dcctc = 0;
 
 	if (rev->early_output)
 		setup_early_output();
@@ -417,7 +418,7 @@ static int cmd_log_walk(struct rev_info *rev)
 	 * and HAS_CHANGES being accumulated in rev->diffopt, so be careful to
 	 * retain that state information if replacing rev->diffopt in this loop
 	 */
-	rev->diffopt.close_file = 0;
+	rev->diffopt.no_free = 1;
 	while ((commit = get_revision(rev)) != NULL) {
 		if (!log_tree_commit(rev, commit) && rev->max_count >= 0)
 			/*
@@ -442,8 +443,8 @@ static int cmd_log_walk(struct rev_info *rev)
 	}
 	rev->diffopt.degraded_cc_to_c = saved_dcctc;
 	rev->diffopt.needed_rename_limit = saved_nrl;
-	if (close_file)
-		fclose(rev->diffopt.file);
+	rev->diffopt.no_free = 0;
+	diff_free(&rev->diffopt);
 
 	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
 	    rev->diffopt.flags.check_failed) {
@@ -1955,7 +1956,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		 * file, but but we must instruct it not to close after each
 		 * diff.
 		 */
-		rev.diffopt.close_file = 0;
+		rev.diffopt.no_free = 1;
 	} else {
 		int saved;
 
diff --git a/diff.c b/diff.c
index 69e3bc00ed8..a63c9ecae79 100644
--- a/diff.c
+++ b/diff.c
@@ -6336,6 +6336,20 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	}
 }
 
+static void diff_free_file(struct diff_options *options)
+{
+	if (options->close_file)
+		fclose(options->file);
+}
+
+void diff_free(struct diff_options *options)
+{
+	if (options->no_free)
+		return;
+
+	diff_free_file(options);
+}
+
 void diff_flush(struct diff_options *options)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -6399,8 +6413,7 @@ void diff_flush(struct diff_options *options)
 		 * options->file to /dev/null should be safe, because we
 		 * aren't supposed to produce any output anyway.
 		 */
-		if (options->close_file)
-			fclose(options->file);
+		diff_free_file(options);
 		options->file = xfopen("/dev/null", "w");
 		options->close_file = 1;
 		options->color_moved = 0;
@@ -6433,8 +6446,7 @@ void diff_flush(struct diff_options *options)
 free_queue:
 	free(q->queue);
 	DIFF_QUEUE_CLEAR(q);
-	if (options->close_file)
-		fclose(options->file);
+	diff_free(options);
 
 	/*
 	 * Report the content-level differences with HAS_CHANGES;
diff --git a/diff.h b/diff.h
index 2ff2b1c7f2c..527fb56d851 100644
--- a/diff.h
+++ b/diff.h
@@ -49,7 +49,17 @@
  * - Once you finish feeding the pairs of files, call `diffcore_std()`.
  * This will tell the diffcore library to go ahead and do its work.
  *
- * - Calling `diff_flush()` will produce the output.
+ * - Calling `diff_flush()` will produce the output, it will call
+ *   `diff_free()` to free any resources, e.g. those allocated in
+ *   `diff_opt_parse()`.
+ *
+ * - Set `.no_free = 1` before calling `diff_flush()` to defer the
+ *   freeing of allocated memory in diff_options. This is useful when
+ *   `diff_flush()` is being called in a loop, rather than as a
+ *   one-off. When setting `.no_free = 1` you must ensure that
+ *   `diff_free()` is called at the end, either by flipping the flag
+ *   before the last `diff_flush()` call, or by flipping it before
+ *   calling `diff_free()` yourself.
  */
 
 struct combine_diff_path;
@@ -365,6 +375,8 @@ struct diff_options {
 
 	struct repository *repo;
 	struct option *parseopts;
+
+	int no_free;
 };
 
 unsigned diff_filter_bit(char status);
@@ -559,6 +571,7 @@ void diffcore_fix_diff_index(void);
 
 int diff_queue_is_empty(void);
 void diff_flush(struct diff_options*);
+void diff_free(struct diff_options*);
 void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
 
 /* diff-raw status letters */
diff --git a/log-tree.c b/log-tree.c
index e0484676507..e7fcd70ba17 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -958,12 +958,14 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 int log_tree_commit(struct rev_info *opt, struct commit *commit)
 {
 	struct log_info log;
-	int shown, close_file = opt->diffopt.close_file;
+	int shown;
+	/* maybe called by e.g. cmd_log_walk(), maybe stand-alone */
+	int no_free = opt->diffopt.no_free;
 
 	log.commit = commit;
 	log.parent = NULL;
 	opt->loginfo = &log;
-	opt->diffopt.close_file = 0;
+	opt->diffopt.no_free = 1;
 
 	if (opt->line_level_traverse)
 		return line_log_print(opt, commit);
@@ -980,7 +982,7 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
 	opt->loginfo = NULL;
 	maybe_flush_or_die(opt->diffopt.file, "stdout");
-	if (close_file)
-		fclose(opt->diffopt.file);
+	opt->diffopt.no_free = no_free;
+	diff_free(&opt->diffopt);
 	return shown;
 }
-- 
2.30.0.284.gd98b1dd5eaa7

