Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2C3720C11
	for <e@80x24.org>; Mon, 27 Nov 2017 19:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbdK0Trw (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 14:47:52 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:37831 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753189AbdK0Trv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 14:47:51 -0500
Received: by mail-it0-f41.google.com with SMTP id m191so22821730itg.2
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 11:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q9kr8rIfK+bSgOe00gJg1b7RyMWpN2BRhN1/Q/1dAEA=;
        b=gklKHiVC6skZxU2X3218xjqLBHPyYWlL6O1aU2qp7u5G03uMbKcTGRzgY8QkIgxmOD
         z6VYYAq7CSf30jvu/IpCNHJ3FK4B0b+1Yh3l6ycPnC2zg3SLccAfO76tKKb83zlTNMAR
         5nrzzDuFCOvYqU11ORLwsGouFa7KFAoo6xfW0PnlLAf7sdczmE8vfCBc2wB1gsKYyEeS
         YPCZ4xsRSwMVGoQhfIR0Xi4+vHxn8SzsewReLZ7QSrZuqpWveI02r2kUXiuGHBinTJsY
         fBnh/9d/7/uLqJ9jyb7yn6EVAz8RCwzxb5aZXUR36J/tqoUPS3QYSV8y02/nWKYYh0i1
         izcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q9kr8rIfK+bSgOe00gJg1b7RyMWpN2BRhN1/Q/1dAEA=;
        b=I9UIiD94orj7C+GbLVdE/L2vOXEpSGExi1wj1LRLI4V7+UDtcrbsJk1c9nlVkZC1f4
         SIUgRt3Uzov19yoqMynsbu7zEvbB+b2GTIdA65MzKYwQH/rib5qThGQyYxlkO3SWf5y4
         5rAC/DFvXmlxR2vxwD0V0lDykXgXS7fe6iqzLgubeEiRN5YyA6yL2hOn5H2WjaV+gpnp
         WG7ta5JC5zQfMPf9sSkJwKs6IIzXGcIFWKNjfo2to+8/bKq5EHfWyVNYgCd9wy/L+mVu
         S+xI+5yJrV8XO3FKI22Ex3l9o+7pfMj06xeQ46fbzjAXAEGpCF3Q/JWYmk3hMlQNXD8+
         gHaQ==
X-Gm-Message-State: AJaThX4mbjZx9/saDqHM6AXfHOd5ZszH5NhOIGYFRyaCpRfbnrztFOtU
        JsO/tG7JfUFEZUNKJTqxs02kI4F8ZjU=
X-Google-Smtp-Source: AGs4zMZ32Csuf160ZJ9dv0xLaUbS9/lC98S2ydZ8tLijpBU7/w9xrqhcn4PqlsFTvi5l5nNqDMiyug==
X-Received: by 10.36.80.148 with SMTP id m142mr3671988itb.6.1511812070349;
        Mon, 27 Nov 2017 11:47:50 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id v76sm7864310itb.1.2017.11.27.11.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Nov 2017 11:47:49 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jonathantanmy@google.com, git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com
Subject: [PATCH v2] diff: support anchoring line(s)
Date:   Mon, 27 Nov 2017 11:47:47 -0800
Message-Id: <20171127194747.118254-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.0.318.ga532b69cd.dirty
In-Reply-To: <20171122234152.72901-1-jonathantanmy@google.com>
References: <20171122234152.72901-1-jonathantanmy@google.com>
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
In v2, the UI treats it as a new algorithm. (Internally it's still an
option for "patience".)

Stefan suggested that I add a test where a single --anchored=<> matches
multiple lines, and that reminded me that the patience algorithm only
really works on unique lines. I have updated the documentation to remark
on that, and also added a test to show what happens. I have also added a
test to show that later algorithm options override earlier ones.
---
 Documentation/diff-options.txt | 10 +++++
 diff.c                         | 22 +++++++++-
 diff.h                         |  4 ++
 t/t4064-diff-anchored.sh       | 94 ++++++++++++++++++++++++++++++++++++++++++
 xdiff/xdiff.h                  |  4 ++
 xdiff/xpatience.c              | 42 ++++++++++++++++---
 6 files changed, 169 insertions(+), 7 deletions(-)
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
index 0763e8926..98aa638f8 100644
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
@@ -4594,9 +4598,18 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 	else if (!strcmp(arg, "--no-indent-heuristic"))
 		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
-	else if (!strcmp(arg, "--patience"))
+	else if (!strcmp(arg, "--patience")) {
+		int i;
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
-	else if (!strcmp(arg, "--histogram"))
+		/*
+		 * Both --patience and --anchored use PATIENCE_DIFF
+		 * internally, so remove any anchors previously
+		 * specified.
+		 */
+		for (i = 0; i < options->anchors_nr; i++)
+			free(options->anchors[i]);
+		options->anchors_nr = 0;
+	} else if (!strcmp(arg, "--histogram"))
 		options->xdl_opts = DIFF_WITH_ALG(options, HISTOGRAM_DIFF);
 	else if ((argcount = parse_long_opt("diff-algorithm", av, &optarg))) {
 		long value = parse_algorithm_value(optarg);
@@ -4608,6 +4621,11 @@ int diff_opt_parse(struct diff_options *options,
 		options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
 		options->xdl_opts |= value;
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
index 000000000..b3f510f04
--- /dev/null
+++ b/t/t4064-diff-anchored.sh
@@ -0,0 +1,94 @@
+#!/bin/sh
+
+test_description='anchored diff algorithm'
+
+. ./test-lib.sh
+
+test_expect_success '--anchored' '
+	printf "a\nb\nc\n" >pre &&
+	printf "c\na\nb\n" >post &&
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
+	printf "a\nb\nc\nd\ne\nf\n" >pre &&
+	printf "c\na\nb\nf\nd\ne\n" >post &&
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
+	printf "a\nb\nc\n" >pre &&
+	printf "c\na\nb\n" >post &&
+
+	test_expect_code 1 git diff --no-index --anchored=x pre post >diff &&
+	grep "^+c" diff
+'
+
+test_expect_success '--anchored with non-unique line has no effect' '
+	printf "a\nb\nc\nd\ne\nc\n" >pre &&
+	printf "c\na\nb\nc\nd\ne\n" >post &&
+
+	test_expect_code 1 git diff --no-index --anchored=c pre post >diff &&
+	grep "^+c" diff
+'
+
+test_expect_success 'diff still produced with impossible multiple --anchored' '
+	printf "a\nb\nc\n" >pre &&
+	printf "c\na\nb\n" >post &&
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
+	printf "a\nb\nc\n" >pre &&
+	printf "c\na\nb\n" >post &&
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
+	grep "^+c" diff
+'
+
+test_expect_success '--anchored works with other commands like "git show"' '
+	printf "a\nb\nc\n" >file &&
+	git add file &&
+	git commit -m foo &&
+	printf "c\na\nb\n" >file &&
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

