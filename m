Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1409CC4332F
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 02:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243841AbiBBCh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 21:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243839AbiBBChy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 21:37:54 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C61C06174E
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 18:37:46 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e2so35612693wra.2
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 18:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jCx0TQA+nM3VBIasKno5xrY9sq5xNpTB47wKzQwI3P8=;
        b=ESnn/k13abJiSeL6u/XxnG3gHveW0ZCJ6C/54LgCPGWpD+qmbRu9LwGDwjXzMBSlbU
         ODHguV3uQH4FZQ/LE+8cqL+TPqZQSYaATfpSmhTMJh3xcJ+CvOqi+pd/hS8JTVVh+14n
         mn1CIXEeE2OXDlCDoxIJanLxwImc4sv7EttnjI/PfX/pYh2uT4XzyrGFTNAsd/8lcl+v
         d0Sc6nReLVeeAh4Lfs95t6sJ9uRV8DiqV4bVm9Ao1bfpN73KPGnPeGimKIUgh3AiLQIH
         b3mC4CfMcXm+/a+MFM/fmGRYsd+u7/uI0CtBPenuaclHbEe+gv/IAYsx/9uzagu2RfFe
         GsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jCx0TQA+nM3VBIasKno5xrY9sq5xNpTB47wKzQwI3P8=;
        b=gwreQLa3uVVTuyfhpByHZIfoT4+4ymzUC/BdxR/mmoxIBmc1DmzwbZJX7cr3tunSsa
         aE9Yl7sDeySS6W7weMrzFIDkhvztQ1CLAekz1z/IhIVugvJ8hiBxcgL9ldgunbnx/4i9
         C9/YXkNyNy8aBVUmufDj1vv7vy5mFmluXi3A12RnjTrES4ehApaM5P4lMOzV2wv6JMXx
         Zy+gJ57A4XOjaNkJE/xV/m87q2w5T1ySqHyadTTbVGWMWJw3xV/m94FfS9zavq9tTPYM
         jF1dJaEPXNiFLV8tLhzpLo3eKf+23GCV0rsR21M9S5ToX1+gFI2j7JVzVrBjBdDyLJnr
         D1Uw==
X-Gm-Message-State: AOAM531GPfIz2xfaJWUb3mhJ8uAiteP4QMImLqneHqOi14vsVTzbpx1b
        9EU2Po6pLEo04QTl6O/dCJEPSFr0oaA=
X-Google-Smtp-Source: ABdhPJyif6D+ElXtrT0Ttk1kEr1ERo7FxMi2s93mXAlhRZMesGTYx2X7Pw6nu9V8F2CsvlM1QYVisA==
X-Received: by 2002:adf:bad4:: with SMTP id w20mr23538890wrg.457.1643769465101;
        Tue, 01 Feb 2022 18:37:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9sm10918730wri.95.2022.02.01.18.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 18:37:44 -0800 (PST)
Message-Id: <4d79da6e20a1ebbfac9869d7584d279d280016f0.1643769457.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v5.git.1643769457.gitgitgadget@gmail.com>
References: <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
        <pull.1103.v5.git.1643769457.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 02:37:34 +0000
Subject: [PATCH v5 07/10] diff: add ability to insert additional headers for
 paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When additional headers are provided, we need to
  * add diff_filepairs to diff_queued_diff for each paths in the
    additional headers map which, unless that path is part of
    another diff_filepair already found in diff_queued_diff
  * format the headers (colorization, line_prefix for --graph)
  * make sure the various codepaths that attempt to return early
    if there are "no changes" take into account the headers that
    need to be shown.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c     | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 diff.h     |   3 +-
 log-tree.c |   2 +-
 3 files changed, 123 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 861282db1c3..1bfb01c18ec 100644
--- a/diff.c
+++ b/diff.c
@@ -27,6 +27,7 @@
 #include "help.h"
 #include "promisor-remote.h"
 #include "dir.h"
+#include "strmap.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -3406,6 +3407,31 @@ struct userdiff_driver *get_textconv(struct repository *r,
 	return userdiff_get_textconv(r, one->driver);
 }
 
+static struct strbuf *additional_headers(struct diff_options *o,
+					 const char *path)
+{
+	if (!o->additional_path_headers)
+		return NULL;
+	return strmap_get(o->additional_path_headers, path);
+}
+
+static void add_formatted_headers(struct strbuf *msg,
+				  struct strbuf *more_headers,
+				  const char *line_prefix,
+				  const char *meta,
+				  const char *reset)
+{
+	char *next, *newline;
+
+	for (next = more_headers->buf; *next; next = newline) {
+		newline = strchrnul(next, '\n');
+		strbuf_addf(msg, "%s%s%.*s%s\n", line_prefix, meta,
+			    (int)(newline - next), next, reset);
+		if (*newline)
+			newline++;
+	}
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -3464,6 +3490,17 @@ static void builtin_diff(const char *name_a,
 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
+	if (!DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two)) {
+		/*
+		 * We should only reach this point for pairs from
+		 * create_filepairs_for_header_only_notifications().  For
+		 * these, we should avoid the "/dev/null" special casing
+		 * above, meaning we avoid showing such pairs as either
+		 * "new file" or "deleted file" below.
+		 */
+		lbl[0] = a_one;
+		lbl[1] = b_two;
+	}
 	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix, meta, a_one, b_two, reset);
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
@@ -4328,6 +4365,7 @@ static void fill_metainfo(struct strbuf *msg,
 	const char *set = diff_get_color(use_color, DIFF_METAINFO);
 	const char *reset = diff_get_color(use_color, DIFF_RESET);
 	const char *line_prefix = diff_line_prefix(o);
+	struct strbuf *more_headers = NULL;
 
 	*must_show_header = 1;
 	strbuf_init(msg, PATH_MAX * 2 + 300);
@@ -4364,6 +4402,11 @@ static void fill_metainfo(struct strbuf *msg,
 	default:
 		*must_show_header = 0;
 	}
+	if ((more_headers = additional_headers(o, name))) {
+		add_formatted_headers(msg, more_headers,
+				      line_prefix, set, reset);
+		*must_show_header = 1;
+	}
 	if (one && two && !oideq(&one->oid, &two->oid)) {
 		const unsigned hexsz = the_hash_algo->hexsz;
 		int abbrev = o->abbrev ? o->abbrev : DEFAULT_ABBREV;
@@ -5852,12 +5895,27 @@ int diff_unmodified_pair(struct diff_filepair *p)
 
 static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 {
-	if (diff_unmodified_pair(p))
+	int include_conflict_headers =
+	    (additional_headers(o, p->one->path) &&
+	     (!o->filter || filter_bit_tst(DIFF_STATUS_UNMERGED, o)));
+
+	/*
+	 * Check if we can return early without showing a diff.  Note that
+	 * diff_filepair only stores {oid, path, mode, is_valid}
+	 * information for each path, and thus diff_unmodified_pair() only
+	 * considers those bits of info.  However, we do not want pairs
+	 * created by create_filepairs_for_header_only_notifications()
+	 * (which always look like unmodified pairs) to be ignored, so
+	 * return early if both p is unmodified AND we don't want to
+	 * include_conflict_headers.
+	 */
+	if (diff_unmodified_pair(p) && !include_conflict_headers)
 		return;
 
+	/* Actually, we can also return early to avoid showing tree diffs */
 	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
 	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
-		return; /* no tree diffs in patch format */
+		return;
 
 	run_diff(p, o);
 }
@@ -5888,10 +5946,17 @@ static void diff_flush_checkdiff(struct diff_filepair *p,
 	run_checkdiff(p, o);
 }
 
-int diff_queue_is_empty(void)
+int diff_queue_is_empty(struct diff_options *o)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
+	int include_conflict_headers =
+	    (o->additional_path_headers &&
+	     (!o->filter || filter_bit_tst(DIFF_STATUS_UNMERGED, o)));
+
+	if (include_conflict_headers)
+		return 0;
+
 	for (i = 0; i < q->nr; i++)
 		if (!diff_unmodified_pair(q->queue[i]))
 			return 0;
@@ -6325,6 +6390,54 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
 		warning(_(rename_limit_advice), varname, needed);
 }
 
+static void create_filepairs_for_header_only_notifications(struct diff_options *o)
+{
+	struct strset present;
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+	int i;
+
+	strset_init_with_options(&present, /*pool*/ NULL, /*strdup*/ 0);
+
+	/*
+	 * Find out which paths exist in diff_queued_diff, preferring
+	 * one->path for any pair that has multiple paths.
+	 */
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		char *path = p->one->path ? p->one->path : p->two->path;
+
+		if (strmap_contains(o->additional_path_headers, path))
+			strset_add(&present, path);
+	}
+
+	/*
+	 * Loop over paths in additional_path_headers; for each NOT already
+	 * in diff_queued_diff, create a synthetic filepair and insert that
+	 * into diff_queued_diff.
+	 */
+	strmap_for_each_entry(o->additional_path_headers, &iter, e) {
+		if (!strset_contains(&present, e->key)) {
+			struct diff_filespec *one, *two;
+			struct diff_filepair *p;
+
+			one = alloc_filespec(e->key);
+			two = alloc_filespec(e->key);
+			fill_filespec(one, null_oid(), 0, 0);
+			fill_filespec(two, null_oid(), 0, 0);
+			p = diff_queue(q, one, two);
+			p->status = DIFF_STATUS_MODIFIED;
+		}
+	}
+
+	/* Re-sort the filepairs */
+	diffcore_fix_diff_index();
+
+	/* Cleanup */
+	strset_clear(&present);
+}
+
 static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 {
 	int i;
@@ -6337,6 +6450,9 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	if (o->color_moved)
 		o->emitted_symbols = &esm;
 
+	if (o->additional_path_headers)
+		create_filepairs_for_header_only_notifications(o);
+
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (check_pair_status(p))
@@ -6413,7 +6529,7 @@ void diff_flush(struct diff_options *options)
 	 * Order: raw, stat, summary, patch
 	 * or:    name/name-status/checkdiff (other bits clear)
 	 */
-	if (!q->nr)
+	if (!q->nr && !options->additional_path_headers)
 		goto free_queue;
 
 	if (output_format & (DIFF_FORMAT_RAW |
diff --git a/diff.h b/diff.h
index 8ba85c5e605..ce9e2cf2e4f 100644
--- a/diff.h
+++ b/diff.h
@@ -395,6 +395,7 @@ struct diff_options {
 
 	struct repository *repo;
 	struct option *parseopts;
+	struct strmap *additional_path_headers;
 
 	int no_free;
 };
@@ -593,7 +594,7 @@ void diffcore_fix_diff_index(void);
 "                show all files diff when -S is used and hit is found.\n" \
 "  -a  --text    treat all files as text.\n"
 
-int diff_queue_is_empty(void);
+int diff_queue_is_empty(struct diff_options *o);
 void diff_flush(struct diff_options*);
 void diff_free(struct diff_options*);
 void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc);
diff --git a/log-tree.c b/log-tree.c
index 89da7de5dbf..8013edcc5d4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -850,7 +850,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 	opt->shown_dashes = 0;
 	diffcore_std(&opt->diffopt);
 
-	if (diff_queue_is_empty()) {
+	if (diff_queue_is_empty(&opt->diffopt)) {
 		int saved_fmt = opt->diffopt.output_format;
 		opt->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
 		diff_flush(&opt->diffopt);
-- 
gitgitgadget

