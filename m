Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB73B20229
	for <e@80x24.org>; Mon, 24 Oct 2016 10:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757042AbcJXKmf (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 06:42:35 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36668 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756858AbcJXKme (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 06:42:34 -0400
Received: by mail-pf0-f196.google.com with SMTP id r16so16248789pfg.3
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 03:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=55e6h5Q2A/oiT+X8vdF3RxD0GW5xFgWc1HaaW6t2clc=;
        b=DyeV6AUXQmIPIQNRLy/dCTZVgpKpmp1fFxFJTbiYqzX207p2DuBQDr0UFjddMod5jf
         XqRaqr/gXKzmGJGTzST5KwLgPTkWU7kkiOOva0Kb140oRIbdSFet0FPoQux31lrtnaYt
         SlGqvkxvLn0+IG+LlohL8dS/0IcZQP1PMTHkAoT8Trbs/uyhqKymGldQu4oCOLJ/vsTM
         5y10lD3x8UE+LhbPwzqD1bw56+0NCl8iYJ/SKnq55NKMvW5d6sjZQHxYnoDTLt811+OZ
         Z9Dt0P6YFrs+i6tu+JvqB2oZq631dVwNFAr1GrlZjVvmWdUNHv7BYzq8T6mJ6goyQS9j
         YOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=55e6h5Q2A/oiT+X8vdF3RxD0GW5xFgWc1HaaW6t2clc=;
        b=TaMJNFRzIzHTB9l7fb2TlHMwjKHhp0WY+4vzsFdzaa/DIHKQwSV+jpn8YhI/JLbzwF
         P9tgT9Rzt6b1BiuFxEUj/S4rvDy8/mr5fufk7l/o/V2RMHuQYWITK3oYuG6GpLlAXnXt
         sIB+c9zhFh56BK4wzZ9gS/lmlLjVcxpEHRhPTbLe4yVYeMbXloXxOLkrrKaEYznN0hBx
         +95NPQZSgU0c+QMMUe5uYojqQ3oCSEkRXcmiKDWmNn9RVLVIKtqFMttlVhvOc42BRw6w
         JXjF+QF2rl8XtKXfeeOkDLBZJmhxNbbqXUBhkL9vQzBI7YfL/47Ivc8QQAOPpJoGjgJf
         D2MA==
X-Gm-Message-State: ABUngveCHNG9RYh0ro45OIea37y2NMj2IKAF9c2NP5/pc0jg8w1rAxkazBWZzRgIRWOC3A==
X-Received: by 10.98.147.78 with SMTP id b75mr27412439pfe.167.1477305753561;
        Mon, 24 Oct 2016 03:42:33 -0700 (PDT)
Received: from ash ([115.73.162.90])
        by smtp.gmail.com with ESMTPSA id t7sm24327491pfa.22.2016.10.24.03.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Oct 2016 03:42:32 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Oct 2016 17:42:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/4] diff-lib: allow ita entries treated as "not yet exist in index"
Date:   Mon, 24 Oct 2016 17:42:19 +0700
Message-Id: <20161024104222.31128-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161024104222.31128-1-pclouds@gmail.com>
References: <20160928114348.1470-1-pclouds@gmail.com>
 <20161024104222.31128-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When comparing the index and the working tree to show which paths are
new, and comparing the tree recorded in the HEAD and the index to see if
committing the contents recorded in the index would result in an empty
commit, we would want the former comparison to say "these are new paths"
and the latter to say "there is no change" for paths that are marked as
intent-to-add.

We made a similar attempt at d95d728a ("diff-lib.c: adjust position of
i-t-a entries in diff", 2015-03-16), which redefined the semantics of
these two comparison modes globally, which was a disaster and had to be
reverted at 78cc1a54 ("Revert "diff-lib.c: adjust position of i-t-a
entries in diff"", 2015-06-23).

To make sure we do not repeat the same mistake, introduce a new internal
diffopt option so that this different semantics can be asked for only by
callers that ask it, while making sure other unaudited callers will get
the same comparison result.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff-lib.c              | 14 ++++++++++++++
 diff.h                  |  1 +
 t/t2203-add-intent.sh   | 16 +++++++++++++++-
 t/t7064-wtstatus-pv2.sh |  4 ++--
 wt-status.c             |  7 ++++++-
 5 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 3007c85..27f1228 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -214,6 +214,12 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 					       !is_null_oid(&ce->oid),
 					       ce->name, 0);
 				continue;
+			} else if (revs->diffopt.ita_invisible_in_index &&
+				   ce_intent_to_add(ce)) {
+				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
+					       EMPTY_BLOB_SHA1_BIN, 0,
+					       ce->name, 0);
+				continue;
 			}
 
 			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
@@ -379,6 +385,14 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	struct rev_info *revs = o->unpack_data;
 	int match_missing, cached;
 
+	/* i-t-a entries do not actually exist in the index */
+	if (revs->diffopt.ita_invisible_in_index &&
+	    idx && ce_intent_to_add(idx)) {
+		idx = NULL;
+		if (!tree)
+			return;	/* nothing to diff.. */
+	}
+
 	/* if the entry is not checked out, don't examine work tree */
 	cached = o->index_only ||
 		(idx && ((idx->ce_flags & CE_VALID) || ce_skip_worktree(idx)));
diff --git a/diff.h b/diff.h
index ec76a90..68a6618 100644
--- a/diff.h
+++ b/diff.h
@@ -146,6 +146,7 @@ struct diff_options {
 	int dirstat_permille;
 	int setup;
 	int abbrev;
+	int ita_invisible_in_index;
 /* white-space error highlighting */
 #define WSEH_NEW 1
 #define WSEH_CONTEXT 2
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 8f22c43..2276e4e 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -5,10 +5,24 @@ test_description='Intent to add'
 . ./test-lib.sh
 
 test_expect_success 'intent to add' '
+	test_commit 1 &&
+	git rm 1.t &&
+	echo hello >1.t &&
 	echo hello >file &&
 	echo hello >elif &&
 	git add -N file &&
-	git add elif
+	git add elif &&
+	git add -N 1.t
+'
+
+test_expect_success 'git status' '
+	git status --porcelain | grep -v actual >actual &&
+	cat >expect <<-\EOF &&
+	DA 1.t
+	A  elif
+	 A file
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'check result of "add -N"' '
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 3012a4d..e319fa2 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -246,8 +246,8 @@ test_expect_success 'verify --intent-to-add output' '
 	git add --intent-to-add intent1.add intent2.add &&
 
 	cat >expect <<-EOF &&
-	1 AM N... 000000 100644 100644 $_z40 $EMPTY_BLOB intent1.add
-	1 AM N... 000000 100644 100644 $_z40 $EMPTY_BLOB intent2.add
+	1 .A N... 000000 000000 100644 $_z40 $_z40 intent1.add
+	1 .A N... 000000 000000 100644 $_z40 $_z40 intent2.add
 	EOF
 
 	git status --porcelain=v2 >actual &&
diff --git a/wt-status.c b/wt-status.c
index 9a14658..05a7dcb 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -437,7 +437,7 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 
 		switch (p->status) {
 		case DIFF_STATUS_ADDED:
-			die("BUG: worktree status add???");
+			d->mode_worktree = p->two->mode;
 			break;
 
 		case DIFF_STATUS_DELETED:
@@ -547,6 +547,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	DIFF_OPT_SET(&rev.diffopt, DIRTY_SUBMODULES);
+	rev.diffopt.ita_invisible_in_index = 1;
 	if (!s->show_untracked_files)
 		DIFF_OPT_SET(&rev.diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
 	if (s->ignore_submodule_arg) {
@@ -570,6 +571,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	setup_revisions(0, NULL, &rev, &opt);
 
 	DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
+	rev.diffopt.ita_invisible_in_index = 1;
 	if (s->ignore_submodule_arg) {
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
 	} else {
@@ -605,6 +607,8 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 
 		if (!ce_path_match(ce, &s->pathspec, NULL))
 			continue;
+		if (ce_intent_to_add(ce))
+			continue;
 		it = string_list_insert(&s->change, ce->name);
 		d = it->util;
 		if (!d) {
@@ -911,6 +915,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 
 	init_revisions(&rev, NULL);
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
+	rev.diffopt.ita_invisible_in_index = 1;
 
 	memset(&opt, 0, sizeof(opt));
 	opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
-- 
2.8.2.524.g6ff3d78

