Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7091F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfEHLN2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:13:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33075 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:13:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so3969867pgv.0
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4ZMZuk5PUzRDWgtCFj7V63t6/TPRpeBoDMTUV6s05Y=;
        b=tyCAA8bNeKSQmoPxkl3WCcUjhJgIpEjBZaq8pNsZrb0EGBDgFjSM3YIQr818sab4WZ
         LDedWWfu4F7hHPd6U44anhDtFzo8HnltBILnQb7XykUwMhSPTIikv4tZRGWzFRgllhQ0
         bqAtwswy1D4dbcMOi7zD0M6WAypHsevoaKveJJFOafMXiGq/6ofnodVHHPMHdfFFW0Sn
         cN+a/Gd72i0s6Qkb/Ov1rRU8HIr7DF2XRYLAvHG3+Ns/BgWjnr1nWJpWF4guc5Ej+NBC
         iBDtq0LPIn32LpiXqU1XA1npkNXUbPwoC3LWWEnary1ai8wsAlqvU7No6qIcx0eQ2a5E
         WUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4ZMZuk5PUzRDWgtCFj7V63t6/TPRpeBoDMTUV6s05Y=;
        b=X/IoPqv991/lufPjiaJRHUuIYOCfwRZlZZiv/8gwZufBXeiUUgeOwb0exLJZx+Js7r
         Nx+zkSxwN168Emv7u5Q22d1Ib+IFEXrUKai1aZV+t+GFIzqqXQD4RAdcZOO8NMH1NYYO
         2A1NmN659AQlV3761rBanyzWEClKPez6odulm3O/kxzrNIAaziiKMRlZWBM/FjnyGlke
         KzM3iv/TZHfdDjZqRS2hWAQex/2tKXVUi6m0dkzYTjj5CdMB57ou4Wyg1rQga/A0q5RB
         T9jc0tRkZcPy/hWQ3/G5G2x6SWcIYeRUtAvPppB9oWsZ9wLo2UpEG2plTt0tv1JUw+yG
         G8Sg==
X-Gm-Message-State: APjAAAXPZTVrLBVoNtAMGSfuTxbs5Pn5MiMyee/QfpvlC2VUF0YBvE0E
        Se7tcIjSAT6ZdfWkBhqrLy1Ah88l
X-Google-Smtp-Source: APXvYqx/UPJ4oxB5nwLJ4IM8dh78683CWNxiur5JjwZbo1E6d4R7AKFD92sfjsrFJod25VAMHd/jrA==
X-Received: by 2002:a62:6b44:: with SMTP id g65mr47973926pfc.27.1557314007540;
        Wed, 08 May 2019 04:13:27 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id h27sm21381876pfd.53.2019.05.08.04.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:13:26 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:13:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/19] revision.h: avoid bit fields in struct rev_info
Date:   Wed,  8 May 2019 18:12:31 +0700
Message-Id: <20190508111249.15262-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <20190508111249.15262-1-pclouds@gmail.com>
References: <20190508111249.15262-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bitfield addresses cannot be passed around in a pointer. This makes it
hard to use parse-options to set/unset them. Turn this struct to
normal integers. This of course increases the size of this struct
multiple times, but since we only have a handful of rev_info variables
around, memory consumption is not at all a concern.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.h | 164 ++++++++++++++++++++++++++---------------------------
 1 file changed, 82 insertions(+), 82 deletions(-)

diff --git a/revision.h b/revision.h
index 4134dc6029..01e4c42274 100644
--- a/revision.h
+++ b/revision.h
@@ -107,95 +107,95 @@ struct rev_info {
 
 	unsigned int early_output;
 
-	unsigned int	ignore_missing:1,
-			ignore_missing_links:1;
+	unsigned int ignore_missing;
+	unsigned int ignore_missing_links;
 
 	/* Traversal flags */
-	unsigned int	dense:1,
-			prune:1,
-			no_walk:2,
-			remove_empty_trees:1,
-			simplify_history:1,
-			topo_order:1,
-			simplify_merges:1,
-			simplify_by_decoration:1,
-			single_worktree:1,
-			tag_objects:1,
-			tree_objects:1,
-			blob_objects:1,
-			verify_objects:1,
-			edge_hint:1,
-			edge_hint_aggressive:1,
-			limited:1,
-			unpacked:1,
-			boundary:2,
-			count:1,
-			left_right:1,
-			left_only:1,
-			right_only:1,
-			rewrite_parents:1,
-			print_parents:1,
-			show_decorations:1,
-			reverse:1,
-			reverse_output_stage:1,
-			cherry_pick:1,
-			cherry_mark:1,
-			bisect:1,
-			ancestry_path:1,
-			first_parent_only:1,
-			line_level_traverse:1,
-			tree_blobs_in_commit_order:1,
-
-			/*
-			 * Blobs are shown without regard for their existence.
-			 * But not so for trees: unless exclude_promisor_objects
-			 * is set and the tree in question is a promisor object;
-			 * OR ignore_missing_links is set, the revision walker
-			 * dies with a "bad tree object HASH" message when
-			 * encountering a missing tree. For callers that can
-			 * handle missing trees and want them to be filterable
-			 * and showable, set this to true. The revision walker
-			 * will filter and show such a missing tree as usual,
-			 * but will not attempt to recurse into this tree
-			 * object.
-			 */
-			do_not_die_on_missing_tree:1,
-
-			/* for internal use only */
-			exclude_promisor_objects:1;
+	unsigned int dense;
+	unsigned int prune;
+	unsigned int no_walk;
+	unsigned int remove_empty_trees;
+	unsigned int simplify_history;
+	unsigned int topo_order;
+	unsigned int simplify_merges;
+	unsigned int simplify_by_decoration;
+	unsigned int single_worktree;
+	unsigned int tag_objects;
+	unsigned int tree_objects;
+	unsigned int blob_objects;
+	unsigned int verify_objects;
+	unsigned int edge_hint;
+	unsigned int edge_hint_aggressive;
+	unsigned int limited;
+	unsigned int unpacked;
+	unsigned int boundary;
+	unsigned int count;
+	unsigned int left_right;
+	unsigned int left_only;
+	unsigned int right_only;
+	unsigned int rewrite_parents;
+	unsigned int print_parents;
+	unsigned int show_decorations;
+	unsigned int reverse;
+	unsigned int reverse_output_stage;
+	unsigned int cherry_pick;
+	unsigned int cherry_mark;
+	unsigned int bisect;
+	unsigned int ancestry_path;
+	unsigned int first_parent_only;
+	unsigned int line_level_traverse;
+	unsigned int tree_blobs_in_commit_order;
+
+	/*
+	 * Blobs are shown without regard for their existence.
+	 * But not so for trees: unless exclude_promisor_objects
+	 * is set and the tree in question is a promisor object;
+	 * OR ignore_missing_links is set, the revision walker
+	 * dies with a "bad tree object HASH" message when
+	 * encountering a missing tree. For callers that can
+	 * handle missing trees and want them to be filterable
+	 * and showable, set this to true. The revision walker
+	 * will filter and show such a missing tree as usual,
+	 * but will not attempt to recurse into this tree
+	 * object.
+	 */
+	unsigned int do_not_die_on_missing_tree;
+
+	/* for internal use only */
+	unsigned int exclude_promisor_objects;
 
 	/* Diff flags */
-	unsigned int	diff:1,
-			full_diff:1,
-			show_root_diff:1,
-			no_commit_id:1,
-			verbose_header:1,
-			ignore_merges:1,
-			combine_merges:1,
-			combined_all_paths:1,
-			dense_combined_merges:1,
-			always_show_header:1;
+	unsigned int diff;
+	unsigned int full_diff;
+	unsigned int show_root_diff;
+	unsigned int no_commit_id;
+	unsigned int verbose_header;
+	unsigned int ignore_merges;
+	unsigned int combine_merges;
+	unsigned int combined_all_paths;
+	unsigned int dense_combined_merges;
+	unsigned int always_show_header;
 
 	/* Format info */
-	unsigned int	shown_one:1,
-			shown_dashes:1,
-			show_merge:1,
-			show_notes:1,
-			show_notes_given:1,
-			show_signature:1,
-			pretty_given:1,
-			abbrev_commit:1,
-			abbrev_commit_given:1,
-			zero_commit:1,
-			use_terminator:1,
-			missing_newline:1,
-			date_mode_explicit:1,
-			preserve_subject:1;
-	unsigned int	disable_stdin:1;
+	unsigned int shown_one;
+	unsigned int shown_dashes;
+	unsigned int show_merge;
+	unsigned int show_notes;
+	unsigned int show_notes_given;
+	unsigned int show_signature;
+	unsigned int pretty_given;
+	unsigned int abbrev_commit;
+	unsigned int abbrev_commit_given;
+	unsigned int zero_commit;
+	unsigned int use_terminator;
+	unsigned int missing_newline;
+	unsigned int date_mode_explicit;
+	unsigned int preserve_subject;
+	unsigned int disable_stdin;
 	/* --show-linear-break */
-	unsigned int	track_linear:1,
-			track_first_time:1,
-			linear:1;
+	unsigned int track_linear;
+	unsigned int track_first_time;
+	unsigned int linear;
 
 	struct date_mode date_mode;
 	int		expand_tabs_in_log; /* unset if negative */
-- 
2.21.0.1141.gd54ac2cb17

