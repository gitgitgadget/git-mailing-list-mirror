Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007741F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeAEU27 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:28:59 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:45912 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbeAEU25 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:57 -0500
Received: by mail-io0-f194.google.com with SMTP id e20so6953463iof.12
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P6/oVENIj02lbqmm/TTtcko+/W7p6VT3THvyEXfJj5w=;
        b=KgqPjOQ+wlAN5CbiSKNpU2jB6ckepSkecyMjS2S5geTNTzwEXUyFXrZjBPSqi7PzAX
         +/K7JjBKC/fecoms9flviSMDe7d9mUTUP49xjyzvk6Dx4cfHy+690KQOQ0CKX3uJ1IKk
         nBkn2eIILtihsdhTytJKV+3Yy87ukr3ECGXDDBzz6jVZB/HWEyvzgENLiynAENn9L6mD
         +KCTsU34zXGu3h/IfVjLTjr1YSNquKRabbRPofjtOJEH/edpHvl1/WNEQWh+lnwW8cCe
         HALhIeMuZ2CfUC2VPebr/a9PhKjuQcNwrm15hNMXDEFeUT6maexjQPrkfifM4sSjzWIj
         i/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P6/oVENIj02lbqmm/TTtcko+/W7p6VT3THvyEXfJj5w=;
        b=p9zUEOceqwtlXOh1rTmMXg0vs+MOr7L/Ya0RVRLMythX/E6x6KnBBSBKbY6+5UNanC
         sMCuox9rujkyiZUkbtgwM/ZejsV+oCLa2MoZsns4YdtHGbqs9V3I0cegQmkyAXjAOGVX
         7VBYjkq8fMA8p4I7MHorNVGD3iGFojyEva4zkWOX/63nQG1RIk+QtxYkDbZzCIj8v3PM
         Sq5/kA/kAVZWMlTH83T3qPj7ZTY5g8HcWJe5fmx1An7RSQPpN0JQT4Wme/AUAoBjHVo5
         UD9PKeTIMXfFiqVKkTabtp2Q7HyCOQr58HyOY44PqF3+vffEjlQkHpvw5n/dG89hbQQD
         /S6A==
X-Gm-Message-State: AKGB3mJBjBwUjZ+5k3sI5A3bxy/J96MqDmyeLp4hfevvskT2V8aZC7VR
        WUkP5ZsOH5vFhQG6o/ZoPY3wt2Kn
X-Google-Smtp-Source: ACJfBosTZRDuD04bwjgi6FCT0XI/XIrBwe5TFwxAOx1r4zH4hoO8/8zHhLMLehP1W/sxB56oIQY9kw==
X-Received: by 10.107.201.132 with SMTP id z126mr4436256iof.51.1515184136117;
        Fri, 05 Jan 2018 12:28:56 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:55 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 28/31] merge-recursive: fix remaining directory rename + dirty overwrite cases
Date:   Fri,  5 Jan 2018 12:27:08 -0800
Message-Id: <20180105202711.24311-29-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 26 +++++++++++++++++++++++---
 t/t6043-merge-rename-directories.sh |  8 ++++----
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 2b8a5ca03..fe42cabad 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1311,11 +1311,23 @@ static int handle_file(struct merge_options *o,
 
 	add = filespec_from_entry(&other, dst_entry, stage ^ 1);
 	if (add) {
+		int ren_src_was_dirty = was_dirty(o, rename->path);
 		char *add_name = unique_path(o, rename->path, other_branch);
 		if (update_file(o, 0, &add->oid, add->mode, add_name))
 			return -1;
 
-		remove_file(o, 0, rename->path, 0);
+		if (ren_src_was_dirty) {
+			output(o, 1, _("Refusing to lose dirty file at %s"),
+			       rename->path);
+		}
+		/*
+		 * Stupid double negatives in remove_file; it somehow manages
+		 * to repeatedly mess me up.  So, just for myself:
+		 *    1) update_wd iff !ren_src_was_dirty.
+		 *    2) no_wd iff !update_wd
+		 *    3) so, no_wd == !!ren_src_was_dirty == ren_src_was_dirty
+		 */
+		remove_file(o, 0, rename->path, ren_src_was_dirty);
 		dst_name = unique_path(o, rename->path, cur_branch);
 	} else {
 		if (dir_in_way(rename->path, !o->call_depth, 0)) {
@@ -1453,7 +1465,10 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 		char *new_path2 = unique_path(o, path, ci->branch2);
 		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
 		       a->path, new_path1, b->path, new_path2);
-		if (would_lose_untracked(path))
+		if (was_dirty(o, path))
+			output(o, 1, _("Refusing to lose dirty file at %s"),
+			       path);
+		else if (would_lose_untracked(path))
 			/*
 			 * Only way we get here is if both renames were from
 			 * a directory rename AND user had an untracked file
@@ -2033,6 +2048,7 @@ static void apply_directory_rename_modifications(struct merge_options *o,
 {
 	struct string_list_item *item;
 	int stage = (tree == a_tree ? 2 : 3);
+	int update_wd;
 
 	/*
 	 * In all cases where we can do directory rename detection,
@@ -2043,7 +2059,11 @@ static void apply_directory_rename_modifications(struct merge_options *o,
 	 * saying the file would have been overwritten), but it might
 	 * be dirty, though.
 	 */
-	remove_file(o, 1, pair->two->path, 0 /* no_wd */);
+	update_wd = !was_dirty(o, pair->two->path);
+	if (!update_wd)
+		output(o, 1, _("Refusing to lose dirty file at %s"),
+		       pair->two->path);
+	remove_file(o, 1, pair->two->path, !update_wd);
 
 	/* Find or create a new re->dst_entry */
 	item = string_list_lookup(entries, new_path);
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index dd0a037ec..003a65b1b 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3346,7 +3346,7 @@ test_expect_success '11b-setup: Avoid losing dirty file involved in directory re
 	)
 '
 
-test_expect_failure '11b-check: Avoid losing dirty file involved in directory rename' '
+test_expect_success '11b-check: Avoid losing dirty file involved in directory rename' '
 	(
 		cd 11b &&
 
@@ -3488,7 +3488,7 @@ test_expect_success '11d-setup: Avoid losing not-uptodate with rename + D/F conf
 	)
 '
 
-test_expect_failure '11d-check: Avoid losing not-uptodate with rename + D/F conflict' '
+test_expect_success '11d-check: Avoid losing not-uptodate with rename + D/F conflict' '
 	(
 		cd 11d &&
 
@@ -3567,7 +3567,7 @@ test_expect_success '11e-setup: Avoid deleting not-uptodate with dir rename/rena
 	)
 '
 
-test_expect_failure '11e-check: Avoid deleting not-uptodate with dir rename/rename(1to2)/add' '
+test_expect_success '11e-check: Avoid deleting not-uptodate with dir rename/rename(1to2)/add' '
 	(
 		cd 11e &&
 
@@ -3643,7 +3643,7 @@ test_expect_success '11f-setup: Avoid deleting not-uptodate with dir rename/rena
 	)
 '
 
-test_expect_failure '11f-check: Avoid deleting not-uptodate with dir rename/rename(2to1)' '
+test_expect_success '11f-check: Avoid deleting not-uptodate with dir rename/rename(2to1)' '
 	(
 		cd 11f &&
 
-- 
2.14.2

