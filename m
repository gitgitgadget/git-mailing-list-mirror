Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF2CB20954
	for <e@80x24.org>; Tue, 28 Nov 2017 18:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbdK1SrM (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 13:47:12 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:46154 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbdK1SrL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 13:47:11 -0500
Received: by mail-it0-f44.google.com with SMTP id t1so931599ite.5
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 10:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=35qNTvLsFSwBse9R5sfH91VGq91tC8EFrx/2kIHQ51o=;
        b=ChJGAqEDlwhfKXXK8pJwYTLJmmhUkQNiKQ5gxKJ+E8SAgQSXnJ+oT7+AAZGsAEQtF5
         p08ZS2ZJ0alMNES2Yu8MWpKSxKBve1cWOyGq6Pgbp49lb6uxqtRCH5RySL2I8JiEIRoY
         YXBMZd8mV4vBtwzvEvWfpyX1PcMuzSig+k2PJP0VKaKiLGevYNnXc/eI+N0O9HhzWLDw
         pIwWZA9leRG4XUd85hIoRH+je85MCDzmhMqhNN1uEOVX/phak/XtdmG6yxiQDlcLEby0
         DaNMgQbRUHAH4NTxYAQbS/F5tYa1w1vn+szDqW/cESD5736y8ofnvAY461Kdvhiiyue0
         L+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=35qNTvLsFSwBse9R5sfH91VGq91tC8EFrx/2kIHQ51o=;
        b=SsSZqdCkIK6PEssvNzfaH63xIBSbarZKkISojMcJ7KSvz77oyPC9Lo1iK1WH1gXfB+
         ZGdV8owk3ZMXuZTmfbBSi0xocZWq4NQhjM2ySTrTqKIiC3pqYkSsht8+71V/rJCeY3pc
         tp5n2E7j7KQ+JgD0M9VKiyi5ytc+4vrR5fnI5F0vYjoYE0XYoDA8CY8CewQPZuQDePk9
         dRoHqWOuwxNYN9gm22z9Zx+a3IqMIBV8cV2R86I+UOpoUwYTdw/w9szfKiWryjD+hQRl
         FwmRDI6TnxNr2UPDfchWQxG0ZNtIJ+3PT5gjqGYYYpjwwS1eSeOLJr4K6cuX8etgnRzc
         RQXw==
X-Gm-Message-State: AJaThX7kwAz0We65zcnHKzvxLKpn5XJHQTw3tqSKz4fZfLRCkmA/kHX4
        omjd2Owyw9OGN4SzE+R1cC3xvg==
X-Google-Smtp-Source: AGs4zMb9jZdCJxiOzkLWVij6Ha7YLNhrXLu6Oyp+/GvuICBaZ1/+BXIN+hE0HRxi50HhtYLi3cE93w==
X-Received: by 10.36.91.15 with SMTP id g15mr3715834itb.141.1511894829876;
        Tue, 28 Nov 2017 10:47:09 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id q132sm11991072iod.26.2017.11.28.10.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Nov 2017 10:47:09 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     jonathantanmy@google.com, sbeller@google.com
Subject: [PATCH v3] diff: support anchoring line(s)
Date:   Tue, 28 Nov 2017 10:47:03 -0800
Message-Id: <20171128184703.155931-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.0.318.g9615d4672.dirty
In-Reply-To: <xmqq1skj9o7r.fsf@gitster.mtv.corp.google.com>
References: <xmqq1skj9o7r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach diff a new algorithm, one that attempts to prevent user-specified
lines from appearing as a deletion or addition in the end result. The
end user can use this by specifying "--anchored=<text>" one or more
times when using Git commands like "diff" and "show".

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
v3 addresses Junio's comments.

> This makes sense, but "--diff-algorithm=patience" would want to do
> the same, I suspect, so the loop would want to become a little
> helper function "clear_patience_anchors(options)" or something like
> that.

Done. Also updated a test to test the interaction of
"--diff-algorithm=patience" with "--anchored=<>".

> This may be too little to matter, but I'd find
>
> 	printf "%s\n" a b c >pre
>
> vastly easier to read.  Or perhaps just use
>
> 	test_write_lines a b c >pre

Thanks for the pointer to test_write_lines - I used that and it is
indeed clearer.
---
 Documentation/diff-options.txt |  10 +++++
 diff.c                         |  31 ++++++++++++-
 diff.h                         |   4 ++
 t/t4064-diff-anchored.sh       | 100 +++++++++++++++++++++++++++++++++++++++++
 xdiff/xdiff.h                  |   4 ++
 xdiff/xpatience.c              |  42 ++++++++++++++---
 6 files changed, 184 insertions(+), 7 deletions(-)
 create mode 100755 t/t4064-diff-anchored.sh

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index dd0dba5b1..6ce39fb69 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -80,6 +80,16 @@ endif::git-format-patch[]
 --histogram::
 	Generate a diff using the "histogram diff" algorithm.
 
+--anchored=<text>::
+	Generate a diff using the "anchored diff" algorithm.
++
+This option may be specified more than once.
++
+If a line exists in both the source and destination, exists only once,
+and starts with this text, this algorithm attempts to prevent it from
+appearing as a deletion or addition in the output. It uses the "patience
+diff" algorithm internally.
+
 --diff-algorithm={patience|minimal|histogram|myers}::
 	Choose a diff algorithm. The variants are as follows:
 +
diff --git a/diff.c b/diff.c
index 0763e8926..7149ff627 100644
--- a/diff.c
+++ b/diff.c
@@ -3210,6 +3210,8 @@ static void builtin_diff(const char *name_a,
 		ecbdata.opt = o;
 		ecbdata.header = header.len ? &header : NULL;
 		xpp.flags = o->xdl_opts;
+		xpp.anchors = o->anchors;
+		xpp.anchors_nr = o->anchors_nr;
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
@@ -3302,6 +3304,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = o->xdl_opts;
+		xpp.anchors = o->anchors;
+		xpp.anchors_nr = o->anchors_nr;
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
 		if (xdi_diff_outf(&mf1, &mf2, diffstat_consume, diffstat,
@@ -4487,6 +4491,21 @@ static int parse_ws_error_highlight_opt(struct diff_options *opt, const char *ar
 	return 1;
 }
 
+/*
+ * Clear the anchors configured for the PATIENCE_DIFF algorithm.
+ *
+ * This must be called whenever a command-line argument indicating that
+ * the patience algorithm is to be used is seen, because the patience
+ * and anchored algorithms both use PATIENCE_DIFF internally.
+ */
+static void clear_patience_anchors(struct diff_options *options)
+{
+	int i;
+	for (i = 0; i < options->anchors_nr; i++)
+		free(options->anchors[i]);
+	options->anchors_nr = 0;
+}
+
 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
@@ -4594,9 +4613,10 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 	else if (!strcmp(arg, "--no-indent-heuristic"))
 		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
-	else if (!strcmp(arg, "--patience"))
+	else if (!strcmp(arg, "--patience")) {
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
-	else if (!strcmp(arg, "--histogram"))
+		clear_patience_anchors(options);
+	} else if (!strcmp(arg, "--histogram"))
 		options->xdl_opts = DIFF_WITH_ALG(options, HISTOGRAM_DIFF);
 	else if ((argcount = parse_long_opt("diff-algorithm", av, &optarg))) {
 		long value = parse_algorithm_value(optarg);
@@ -4607,7 +4627,14 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_CLR(options, NEED_MINIMAL);
 		options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
 		options->xdl_opts |= value;
+		if (value == XDF_PATIENCE_DIFF)
+			clear_patience_anchors(options);
 		return argcount;
+	} else if (skip_prefix(arg, "--anchored=", &arg)) {
+		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
+		ALLOC_GROW(options->anchors, options->anchors_nr + 1,
+			   options->anchors_alloc);
+		options->anchors[options->anchors_nr++] = xstrdup(arg);
 	}
 
 	/* flags options */
diff --git a/diff.h b/diff.h
index 0fb18dd73..7cf276f07 100644
--- a/diff.h
+++ b/diff.h
@@ -166,6 +166,10 @@ struct diff_options {
 	const char *stat_sep;
 	long xdl_opts;
 
+	/* see Documentation/diff-options.txt */
+	char **anchors;
+	size_t anchors_nr, anchors_alloc;
+
 	int stat_width;
 	int stat_name_width;
 	int stat_graph_width;
diff --git a/t/t4064-diff-anchored.sh b/t/t4064-diff-anchored.sh
new file mode 100755
index 000000000..d51ca2c35
--- /dev/null
+++ b/t/t4064-diff-anchored.sh
@@ -0,0 +1,100 @@
+#!/bin/sh
+
+test_description='anchored diff algorithm'
+
+. ./test-lib.sh
+
+test_expect_success '--anchored' '
+	test_write_lines a b c >pre &&
+	test_write_lines c a b >post &&
+
+	# normally, c is moved to produce the smallest diff
+	test_expect_code 1 git diff --no-index pre post >diff &&
+	grep "^+c" diff &&
+
+	# with anchor, a is moved
+	test_expect_code 1 git diff --no-index --anchored=c pre post >diff &&
+	grep "^+a" diff
+'
+
+test_expect_success '--anchored multiple' '
+	test_write_lines a b c d e f >pre &&
+	test_write_lines c a b f d e >post &&
+
+	# with 1 anchor, c is not moved, but f is moved
+	test_expect_code 1 git diff --no-index --anchored=c pre post >diff &&
+	grep "^+a" diff && # a is moved instead of c
+	grep "^+f" diff &&
+
+	# with 2 anchors, c and f are not moved
+	test_expect_code 1 git diff --no-index --anchored=c --anchored=f pre post >diff &&
+	grep "^+a" diff &&
+	grep "^+d" diff # d is moved instead of f
+'
+
+test_expect_success '--anchored with nonexistent line has no effect' '
+	test_write_lines a b c >pre &&
+	test_write_lines c a b >post &&
+
+	test_expect_code 1 git diff --no-index --anchored=x pre post >diff &&
+	grep "^+c" diff
+'
+
+test_expect_success '--anchored with non-unique line has no effect' '
+	test_write_lines a b c d e c >pre &&
+	test_write_lines c a b c d e >post &&
+
+	test_expect_code 1 git diff --no-index --anchored=c pre post >diff &&
+	grep "^+c" diff
+'
+
+test_expect_success 'diff still produced with impossible multiple --anchored' '
+	test_write_lines a b c >pre &&
+	test_write_lines c a b >post &&
+
+	test_expect_code 1 git diff --no-index --anchored=a --anchored=c pre post >diff &&
+	mv post expected_post &&
+
+	# Ensure that the diff is correct by applying it and then
+	# comparing the result with the original
+	git apply diff &&
+	diff expected_post post
+'
+
+test_expect_success 'later algorithm arguments override earlier ones' '
+	test_write_lines a b c >pre &&
+	test_write_lines c a b >post &&
+
+	test_expect_code 1 git diff --no-index --patience --anchored=c pre post >diff &&
+	grep "^+a" diff &&
+
+	test_expect_code 1 git diff --no-index --anchored=c --patience pre post >diff &&
+	grep "^+c" diff &&
+
+	test_expect_code 1 git diff --no-index --histogram --anchored=c pre post >diff &&
+	grep "^+a" diff &&
+
+	test_expect_code 1 git diff --no-index --anchored=c --histogram pre post >diff &&
+	grep "^+c" diff &&
+
+	test_expect_code 1 git diff --no-index --diff-algorithm=patience --anchored=c pre post >diff &&
+	grep "^+a" diff &&
+
+	test_expect_code 1 git diff --no-index --anchored=c --diff-algorithm=patience pre post >diff &&
+	grep "^+c" diff
+'
+
+test_expect_success '--anchored works with other commands like "git show"' '
+	test_write_lines a b c >file &&
+	git add file &&
+	git commit -m foo &&
+	test_write_lines c a b >file &&
+	git add file &&
+	git commit -m foo &&
+
+	# with anchor, a is moved
+	git show --patience --anchored=c >diff &&
+	grep "^+a" diff
+'
+
+test_done
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 785ecb089..e6217e1d7 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -80,6 +80,10 @@ typedef struct s_mmbuffer {
 
 typedef struct s_xpparam {
 	unsigned long flags;
+
+	/* See Documentation/diff-options.txt. */
+	char **anchors;
+	size_t anchors_nr;
 } xpparam_t;
 
 typedef struct s_xdemitcb {
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index a44e77632..f3573d9f0 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -62,6 +62,12 @@ struct hashmap {
 		 * initially, "next" reflects only the order in file1.
 		 */
 		struct entry *next, *previous;
+
+		/*
+		 * If 1, this entry can serve as an anchor. See
+		 * Documentation/diff-options.txt for more information.
+		 */
+		unsigned anchor : 1;
 	} *entries, *first, *last;
 	/* were common records found? */
 	unsigned long has_matches;
@@ -70,8 +76,19 @@ struct hashmap {
 	xpparam_t const *xpp;
 };
 
+static int is_anchor(xpparam_t const *xpp, const char *line)
+{
+	int i;
+	for (i = 0; i < xpp->anchors_nr; i++) {
+		if (!strncmp(line, xpp->anchors[i], strlen(xpp->anchors[i])))
+			return 1;
+	}
+	return 0;
+}
+
 /* The argument "pass" is 1 for the first file, 2 for the second. */
-static void insert_record(int line, struct hashmap *map, int pass)
+static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
+			  int pass)
 {
 	xrecord_t **records = pass == 1 ?
 		map->env->xdf1.recs : map->env->xdf2.recs;
@@ -110,6 +127,7 @@ static void insert_record(int line, struct hashmap *map, int pass)
 		return;
 	map->entries[index].line1 = line;
 	map->entries[index].hash = record->ha;
+	map->entries[index].anchor = is_anchor(xpp, map->env->xdf1.recs[line - 1]->ptr);
 	if (!map->first)
 		map->first = map->entries + index;
 	if (map->last) {
@@ -147,11 +165,11 @@ static int fill_hashmap(mmfile_t *file1, mmfile_t *file2,
 
 	/* First, fill with entries from the first file */
 	while (count1--)
-		insert_record(line1++, result, 1);
+		insert_record(xpp, line1++, result, 1);
 
 	/* Then search for matches in the second file */
 	while (count2--)
-		insert_record(line2++, result, 2);
+		insert_record(xpp, line2++, result, 2);
 
 	return 0;
 }
@@ -192,14 +210,28 @@ static struct entry *find_longest_common_sequence(struct hashmap *map)
 	int longest = 0, i;
 	struct entry *entry;
 
+	/*
+	 * If not -1, this entry in sequence must never be overridden.
+	 * Therefore, overriding entries before this has no effect, so
+	 * do not do that either.
+	 */
+	int anchor_i = -1;
+
 	for (entry = map->first; entry; entry = entry->next) {
 		if (!entry->line2 || entry->line2 == NON_UNIQUE)
 			continue;
 		i = binary_search(sequence, longest, entry);
 		entry->previous = i < 0 ? NULL : sequence[i];
-		sequence[++i] = entry;
-		if (i == longest)
+		++i;
+		if (i <= anchor_i)
+			continue;
+		sequence[i] = entry;
+		if (entry->anchor) {
+			anchor_i = i;
+			longest = anchor_i + 1;
+		} else if (i == longest) {
 			longest++;
+		}
 	}
 
 	/* No common unique lines were found */
-- 
2.15.0.417.g466bffb3ac-goog

