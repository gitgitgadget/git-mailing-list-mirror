Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0879A1F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfHQSmI (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37944 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfHQSmF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id o70so4812470pfg.5
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZgRaETQ/I0RilKLbq76Nx+w+n9xogRK5VVIrBGj94JE=;
        b=pNA2xJ8WNaoi4LD49MzSOsDZ+x/OEexVDP0sLPKhpTEUtJ6AAE4+6Qi14GhC0yxKnQ
         AT1QEZfVCIZXt8zvwJv4xMtHuyL5Fc7oe8KecGrLoQdaBXkkTb2wapQl+J+M/kc+HwtY
         PFYto+TOYDn8UBqendwW90g/x8AXAs92lisftbkw1EY6H4dXyd45XxvRrEThUSP6OHeC
         uS3SZy3Hd/pW1XQPVZ9Aku7DhHS9SEt5sEqEWZ15jd58DpbEy4E79ztziXWUhlW8vU1z
         mAi3M9aejOxLhEry4QxT9lILSHVeQjPjeLWkbqTqS/oC8C4gzti25aA0ZobyyIIWZOy5
         BEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgRaETQ/I0RilKLbq76Nx+w+n9xogRK5VVIrBGj94JE=;
        b=BjejBc8gNWPspTzn1Tplz/4qy/4oqGD8GDocPCVQHPbI7/rn2oFzRErKAIe+drvYWc
         JeFAAJkrpdiCxc3/U7yJ2yfRBAUeOh9Aqa45y6+vvWGo0wpu3E19zCNOVAAIszBQGpJt
         DJrnSVfrzaQhkumyd4Gp18h5XiPCmPQQMpvdxlvc3Xool1cKdOErNblh58gSx7GJr/8e
         Q8rXoPPUpeXXQd7DHlLr/3Af6jqrdawKtS8H1c1EFysUlLCNukxzRU/31BZb7iKR3n75
         CN2typ8OF6oINMjtNLTvJTxY+cufkD8FRkXqZ4lK20kIKZGUrG0a6QD7eBPuEN+kmsrI
         zjNQ==
X-Gm-Message-State: APjAAAVHw1MLOLmtOiwQ0avvCTwenejjkRIBvhHm/D8nYywNQ/OCcvN1
        /1uDWNwnHsWi57X7t2jPx3vokFNM
X-Google-Smtp-Source: APXvYqy7dc266/0Uj2JJY2AcIdtys3RDFuL8AM35O8YHUNlg/MtgsIq+73evU1H92tROLwWyhuxYsg==
X-Received: by 2002:a62:83c9:: with SMTP id h192mr16322134pfe.57.1566067324537;
        Sat, 17 Aug 2019 11:42:04 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:03 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 05/24] merge-recursive: introduce an enum for detect_directory_renames values
Date:   Sat, 17 Aug 2019 11:41:25 -0700
Message-Id: <20190817184144.32179-6-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Improve code readability by introducing an enum to replace the
not-quite-boolean values taken on by detect_directory_renames.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c      |  2 +-
 merge-recursive.c | 24 +++++++++++++++---------
 merge-recursive.h |  6 +++++-
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1aea657a7f..037e828efe 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1538,7 +1538,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	o.branch1 = "HEAD";
 	their_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
 	o.branch2 = their_tree_name;
-	o.detect_directory_renames = 0;
+	o.detect_directory_renames = MERGE_DIRECTORY_RENAMES_NONE;
 
 	if (state->quiet)
 		o.verbosity = 0;
diff --git a/merge-recursive.c b/merge-recursive.c
index e6b84db2ef..9622781612 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1375,7 +1375,8 @@ static int handle_rename_via_dir(struct merge_options *opt,
 	const struct rename *ren = ci->ren1;
 	const struct diff_filespec *dest = ren->pair->two;
 	char *file_path = dest->path;
-	int mark_conflicted = (opt->detect_directory_renames == 1);
+	int mark_conflicted = (opt->detect_directory_renames ==
+			       MERGE_DIRECTORY_RENAMES_CONFLICT);
 	assert(ren->dir_rename_original_dest);
 
 	if (!opt->call_depth && would_lose_untracked(opt, dest->path)) {
@@ -2860,8 +2861,9 @@ static int detect_and_process_renames(struct merge_options *opt,
 	head_pairs = get_diffpairs(opt, common, head);
 	merge_pairs = get_diffpairs(opt, common, merge);
 
-	if ((opt->detect_directory_renames == 2) ||
-	    (opt->detect_directory_renames == 1 && !opt->call_depth)) {
+	if ((opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE) ||
+	    (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT &&
+	     !opt->call_depth)) {
 		dir_re_head = get_directory_renames(head_pairs);
 		dir_re_merge = get_directory_renames(merge_pairs);
 
@@ -3119,7 +3121,8 @@ static int handle_rename_normal(struct merge_options *opt,
 	clean = handle_content_merge(&mfi, opt, path, was_dirty(opt, path),
 				     o, a, b, ci);
 
-	if (clean && opt->detect_directory_renames == 1 &&
+	if (clean &&
+	    opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT &&
 	    ren->dir_rename_original_dest) {
 		if (update_stages(opt, path,
 				  NULL,
@@ -3164,12 +3167,12 @@ static int warn_about_dir_renamed_entries(struct merge_options *opt,
 		return clean;
 
 	/* Sanity checks */
-	assert(opt->detect_directory_renames > 0);
+	assert(opt->detect_directory_renames > MERGE_DIRECTORY_RENAMES_NONE);
 	assert(ren->dir_rename_original_type == 'A' ||
 	       ren->dir_rename_original_type == 'R');
 
 	/* Check whether to treat directory renames as a conflict */
-	clean = (opt->detect_directory_renames == 2);
+	clean = (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE);
 
 	is_add = (ren->dir_rename_original_type == 'A');
 	if (ren->dir_rename_original_type == 'A' && clean) {
@@ -3679,9 +3682,12 @@ static void merge_recursive_config(struct merge_options *opt)
 	if (!git_config_get_string("merge.directoryrenames", &value)) {
 		int boolval = git_parse_maybe_bool(value);
 		if (0 <= boolval) {
-			opt->detect_directory_renames = boolval ? 2 : 0;
+			opt->detect_directory_renames = boolval ?
+				MERGE_DIRECTORY_RENAMES_TRUE :
+				MERGE_DIRECTORY_RENAMES_NONE;
 		} else if (!strcasecmp(value, "conflict")) {
-			opt->detect_directory_renames = 1;
+			opt->detect_directory_renames =
+				MERGE_DIRECTORY_RENAMES_CONFLICT;
 		} /* avoid erroring on values from future versions of git */
 		free(value);
 	}
@@ -3701,7 +3707,7 @@ void init_merge_options(struct merge_options *opt,
 	opt->renormalize = 0;
 	opt->diff_detect_rename = -1;
 	opt->merge_detect_rename = -1;
-	opt->detect_directory_renames = 1;
+	opt->detect_directory_renames = MERGE_DIRECTORY_RENAMES_CONFLICT;
 	merge_recursive_config(opt);
 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
 	if (merge_verbosity)
diff --git a/merge-recursive.h b/merge-recursive.h
index c2b7bb65c6..f1b6ef38ae 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -22,7 +22,11 @@ struct merge_options {
 	unsigned renormalize : 1;
 	long xdl_opts;
 	int verbosity;
-	int detect_directory_renames;
+	enum {
+		MERGE_DIRECTORY_RENAMES_NONE = 0,
+		MERGE_DIRECTORY_RENAMES_CONFLICT = 1,
+		MERGE_DIRECTORY_RENAMES_TRUE = 2
+	} detect_directory_renames;
 	int diff_detect_rename;
 	int merge_detect_rename;
 	int diff_rename_limit;
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty

