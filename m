Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5351F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbdL1EOh (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:37 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:45451 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752849AbdL1EOe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:34 -0500
Received: by mail-it0-f67.google.com with SMTP id z6so26969978iti.4
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Gp1MA4/i/MOaTZCCWdzfCr0/JjuPnECnMLkS9W6my8=;
        b=PFLQwWZv4l1BRIJq0TNbGtvG9LW1zYqRqSKPddRHrDTpXadhZPr9d8RCGST182Ke8b
         QQLIc1jM3Bw3GONrGXjld9gDXoQ5E88d91xmpW+lRx+VUw+U1nHMX0kk6HgG58BbDdVT
         aDUvopXUGCvlcNdjxNTl2mL4HXcqBYkBSvxLXoFmlw1h+g3SWeoVAXWi06RrjoG8ixJU
         ci2OfguLFBPRiIUMtK0d7Kmy+6weggkGeUR7WE7BlraP7Bgd9+CdjTtnoplVGkTXFIM5
         qolWb9vrXRkPSwiN71jSdyn/JwUepVaH41mU5Io16aIS2NaaPWR0VOWB4dxuYZNqYyoj
         aNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Gp1MA4/i/MOaTZCCWdzfCr0/JjuPnECnMLkS9W6my8=;
        b=Pwa/0Gr1zRZPjf+/5lF8WVYLGtkNqWkRLX1bp6b5l2MJO+CEypzHQOT83Q2IKuhrZR
         fpzFK2Y99iCe+crribT6Za1HaUzQZ0QGZ0sswm5l5ImKQ5vTmomDfXEZBtvgXHjkeMNc
         +/gYkjA2vZvynAwRBdIvD4Rtuyr1GFfOYe8AkLe5EgOwqUJ89BVnJoY4ZZVRK4eTFEMO
         /zHcaezMeBq6fMXNkQMMPoiLgYJo1LhoWPKhPr+5DfQqUDe6+6JPQPd3WOkFhlz9FZf7
         lPv1pR66n5HBjlfY/mqVq+MCKHJKcD8qx7cEPVFMspXkEIdDRBvjxyvplRuP1VBQDN84
         VujQ==
X-Gm-Message-State: AKGB3mL1asSgA6RPRqE/ePdd5LmapOdY5URriJPWco/IAXPlveMPA32f
        S6LkmxLJQIhAg3zFtZ+dpwBRwA==
X-Google-Smtp-Source: ACJfBosFQEM0FEi++/mizZxlNxvm/aUPql4JZQAlr7lPluZX9LDqYrLPeavuMQUjAFPwWekY9zXkGg==
X-Received: by 10.36.125.129 with SMTP id b123mr40542653itc.142.1514434473757;
        Wed, 27 Dec 2017 20:14:33 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:32 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 31/34] merge-recursive: fix remaining directory rename + dirty overwrite cases
Date:   Wed, 27 Dec 2017 20:13:49 -0800
Message-Id: <20171228041352.27880-32-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
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
index 86c215e13..556029ef5 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3224,7 +3224,7 @@ test_expect_success '11b-setup: Avoid losing dirty file involved in directory re
 	)
 '
 
-test_expect_failure '11b-check: Avoid losing dirty file involved in directory rename' '
+test_expect_success '11b-check: Avoid losing dirty file involved in directory rename' '
 	(
 		cd 11b &&
 
@@ -3358,7 +3358,7 @@ test_expect_success '11d-setup: Avoid losing not-uptodate with rename + D/F conf
 	)
 '
 
-test_expect_failure '11d-check: Avoid losing not-uptodate with rename + D/F conflict' '
+test_expect_success '11d-check: Avoid losing not-uptodate with rename + D/F conflict' '
 	(
 		cd 11d &&
 
@@ -3432,7 +3432,7 @@ test_expect_success '11e-setup: Avoid deleting not-uptodate with dir rename/rena
 	)
 '
 
-test_expect_failure '11e-check: Avoid deleting not-uptodate with dir rename/rename(1to2)/add' '
+test_expect_success '11e-check: Avoid deleting not-uptodate with dir rename/rename(1to2)/add' '
 	(
 		cd 11e &&
 
@@ -3506,7 +3506,7 @@ test_expect_success '11f-setup: Avoid deleting not-uptodate with dir rename/rena
 	)
 '
 
-test_expect_failure '11f-check: Avoid deleting not-uptodate with dir rename/rename(2to1)' '
+test_expect_success '11f-check: Avoid deleting not-uptodate with dir rename/rename(2to1)' '
 	(
 		cd 11f &&
 
-- 
2.15.0.408.g8e199d483

