Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C38F20281
	for <e@80x24.org>; Wed, 24 May 2017 05:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969134AbdEXFQa (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:30 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33540 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969122AbdEXFQX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:23 -0400
Received: by mail-oi0-f66.google.com with SMTP id h4so31065985oib.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+uahgW8GK7+MQCpuCa43CL1bcNPRSph7li86+rBTRLA=;
        b=FQyeD7227Ns6D9DuV+fEulrZYlR2LHyg+Yt5HThEcCWNVQeSvxYLUWh5TaJG0ExcXb
         O925vwIeuA3J76fWB7BBtHX92TXOTjfEUlk9jVNnGo4BrP25TBUp9RKFgXCbZcewMDPt
         KB8dVAUh1QDp9sxwKiLAhABQE21NmKuBVJ/TnZpXpzy89aWtORTWNDF9QKzRUlZcyHQN
         KeZL1QLL9LzjEmclTPiMFY7kncJMAmZW2r2zAQNUK8izpGXgvuiVT3e8gytm/vgjyLzB
         5NZRbxBUZezNVWsUeDa2W/YoMYqS9Z0NbWaA9VgzLAz0lrVcpL4LFRIz9oCbciCtL5uN
         fOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+uahgW8GK7+MQCpuCa43CL1bcNPRSph7li86+rBTRLA=;
        b=r7e6lV2WqEI/5Ywtl+zH+QIvQPj8xpg2Q7BkTAb826OuVMFj8TU6YLwu09isIIDweu
         oYPtV2DtybhpoNfix76Dh6Cv284C2B1Cr8vThxPU9bAqvRtC1wFM+BHoccVVDTiwVk7J
         5meFZtGLyKdwmn8wtcN0WumDN2E4M3uF9fcKamrMV1czXAHT2Jv2l/qkfa9cVLZjfjkL
         QrK95LGGrdGuMgqA/J8zvOkhh6Cn/ClUdT7V//NvxE/SHUvZ1EzTDoKzUex5E6g/CgX0
         9YJ+rxKXMz++zhnAvy/AMNwNro6tqTZ/KuVPw+11ESjBxWUDs6LQnHK4a0YmiEym1Jht
         Np2Q==
X-Gm-Message-State: AODbwcBJbrIJF/bdTY0w630B92tmJw0HYPFmAVPKe3KAr4Z1Dl/gL/xt
        HvH1d1g5N0wPrg==
X-Received: by 10.157.43.116 with SMTP id f49mr3996605otd.216.1495602982707;
        Tue, 23 May 2017 22:16:22 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:21 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 05/29] blame: rename scoreboard structure to blame_scoreboard
Date:   Wed, 24 May 2017 00:15:13 -0500
Message-Id: <20170524051537.29978-6-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The scoreboard structure is core to the blame interface. Since
scoreboard will become more exposed, rename it to blame_scoreboard to
clarify what it is a part of.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 58 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 3e8aaa4..717868e 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -353,7 +353,7 @@ static int compare_commits_by_reverse_commit_date(const void *a,
 /*
  * The current state of the blame assignment.
  */
-struct scoreboard {
+struct blame_scoreboard {
 	/* the final commit (i.e. where we started digging from) */
 	struct commit *final;
 	/* Priority queue for commits with unassigned blame records */
@@ -377,14 +377,14 @@ struct scoreboard {
 	int *lineno;
 };
 
-static void sanity_check_refcnt(struct scoreboard *);
+static void sanity_check_refcnt(struct blame_scoreboard *);
 
 /*
  * If two blame entries that are next to each other came from
  * contiguous lines in the same origin (i.e. <commit, path> pair),
  * merge them together.
  */
-static void coalesce(struct scoreboard *sb)
+static void coalesce(struct blame_scoreboard *sb)
 {
 	struct blame_entry *ent, *next;
 
@@ -410,7 +410,7 @@ static void coalesce(struct scoreboard *sb)
  * the commit priority queue of the score board.
  */
 
-static void queue_blames(struct scoreboard *sb, struct blame_origin *porigin,
+static void queue_blames(struct blame_scoreboard *sb, struct blame_origin *porigin,
 			 struct blame_entry *sorted)
 {
 	if (porigin->suspects)
@@ -653,14 +653,14 @@ static void dup_entry(struct blame_entry ***queue,
 	*queue = &dst->next;
 }
 
-static const char *nth_line(struct scoreboard *sb, long lno)
+static const char *nth_line(struct blame_scoreboard *sb, long lno)
 {
 	return sb->final_buf + sb->lineno[lno];
 }
 
 static const char *nth_line_cb(void *data, long lno)
 {
-	return nth_line((struct scoreboard *)data, lno);
+	return nth_line((struct blame_scoreboard *)data, lno);
 }
 
 /*
@@ -919,7 +919,7 @@ static int blame_chunk_cb(long start_a, long count_a,
  * for the lines it is suspected to its parent.  Run diff to find
  * which lines came from parent and pass blame for them.
  */
-static void pass_blame_to_parent(struct scoreboard *sb,
+static void pass_blame_to_parent(struct blame_scoreboard *sb,
 				 struct blame_origin *target,
 				 struct blame_origin *parent)
 {
@@ -959,7 +959,7 @@ static void pass_blame_to_parent(struct scoreboard *sb,
  *
  * Compute how trivial the lines in the blame_entry are.
  */
-static unsigned ent_score(struct scoreboard *sb, struct blame_entry *e)
+static unsigned ent_score(struct blame_scoreboard *sb, struct blame_entry *e)
 {
 	unsigned score;
 	const char *cp, *ep;
@@ -986,7 +986,7 @@ static unsigned ent_score(struct scoreboard *sb, struct blame_entry *e)
  * so far, by comparing this and best_so_far and copying this into
  * bst_so_far as needed.
  */
-static void copy_split_if_better(struct scoreboard *sb,
+static void copy_split_if_better(struct blame_scoreboard *sb,
 				 struct blame_entry *best_so_far,
 				 struct blame_entry *this)
 {
@@ -1020,7 +1020,7 @@ static void copy_split_if_better(struct scoreboard *sb,
  *
  * All line numbers are 0-based.
  */
-static void handle_split(struct scoreboard *sb,
+static void handle_split(struct blame_scoreboard *sb,
 			 struct blame_entry *ent,
 			 int tlno, int plno, int same,
 			 struct blame_origin *parent,
@@ -1039,7 +1039,7 @@ static void handle_split(struct scoreboard *sb,
 }
 
 struct handle_split_cb_data {
-	struct scoreboard *sb;
+	struct blame_scoreboard *sb;
 	struct blame_entry *ent;
 	struct blame_origin *parent;
 	struct blame_entry *split;
@@ -1063,7 +1063,7 @@ static int handle_split_cb(long start_a, long count_a,
  * we can pass blames to it.  file_p has the blob contents for
  * the parent.
  */
-static void find_copy_in_blob(struct scoreboard *sb,
+static void find_copy_in_blob(struct blame_scoreboard *sb,
 			      struct blame_entry *ent,
 			      struct blame_origin *parent,
 			      struct blame_entry *split,
@@ -1099,7 +1099,7 @@ static void find_copy_in_blob(struct scoreboard *sb,
  * Returns a pointer to the link pointing to the old head of the small list.
  */
 
-static struct blame_entry **filter_small(struct scoreboard *sb,
+static struct blame_entry **filter_small(struct blame_scoreboard *sb,
 					 struct blame_entry **small,
 					 struct blame_entry **source,
 					 unsigned score_min)
@@ -1126,7 +1126,7 @@ static struct blame_entry **filter_small(struct scoreboard *sb,
  * See if lines currently target is suspected for can be attributed to
  * parent.
  */
-static void find_move_in_parent(struct scoreboard *sb,
+static void find_move_in_parent(struct blame_scoreboard *sb,
 				struct blame_entry ***blamed,
 				struct blame_entry **toosmall,
 				struct blame_origin *target,
@@ -1202,7 +1202,7 @@ static struct blame_list *setup_blame_list(struct blame_entry *unblamed,
  * across file boundary from the parent commit.  porigin is the path
  * in the parent we already tried.
  */
-static void find_copy_in_parent(struct scoreboard *sb,
+static void find_copy_in_parent(struct blame_scoreboard *sb,
 				struct blame_entry ***blamed,
 				struct blame_entry **toosmall,
 				struct blame_origin *target,
@@ -1308,7 +1308,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
  * The blobs of origin and porigin exactly match, so everything
  * origin is suspected for can be blamed on the parent.
  */
-static void pass_whole_blame(struct scoreboard *sb,
+static void pass_whole_blame(struct blame_scoreboard *sb,
 			     struct blame_origin *origin, struct blame_origin *porigin)
 {
 	struct blame_entry *e, *suspects;
@@ -1356,7 +1356,7 @@ static int num_scapegoats(struct rev_info *revs, struct commit *commit)
 /* Distribute collected unsorted blames to the respected sorted lists
  * in the various origins.
  */
-static void distribute_blame(struct scoreboard *sb, struct blame_entry *blamed)
+static void distribute_blame(struct blame_scoreboard *sb, struct blame_entry *blamed)
 {
 	blamed = blame_sort(blamed, compare_blame_suspect);
 	while (blamed)
@@ -1376,7 +1376,7 @@ static void distribute_blame(struct scoreboard *sb, struct blame_entry *blamed)
 
 #define MAXSG 16
 
-static void pass_blame(struct scoreboard *sb, struct blame_origin *origin, int opt)
+static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin, int opt)
 {
 	struct rev_info *revs = sb->revs;
 	int i, pass, num_sg;
@@ -1733,7 +1733,7 @@ static void found_guilty_entry(struct blame_entry *ent,
  * The main loop -- while we have blobs with lines whose true origin
  * is still unknown, pick one blob, and allow its lines to pass blames
  * to its parents. */
-static void assign_blame(struct scoreboard *sb, int opt)
+static void assign_blame(struct blame_scoreboard *sb, int opt)
 {
 	struct rev_info *revs = sb->revs;
 	struct commit *commit = prio_queue_get(&sb->commits);
@@ -1849,7 +1849,7 @@ static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 		write_filename_info(suspect);
 }
 
-static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
+static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 			   int opt)
 {
 	int repeat = opt & OUTPUT_LINE_PORCELAIN;
@@ -1888,7 +1888,7 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
 		putchar('\n');
 }
 
-static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
+static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int opt)
 {
 	int cnt;
 	const char *cp;
@@ -1967,7 +1967,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	commit_info_destroy(&ci);
 }
 
-static void output(struct scoreboard *sb, int option)
+static void output(struct blame_scoreboard *sb, int option)
 {
 	struct blame_entry *ent;
 
@@ -2006,7 +2006,7 @@ static const char *get_next_line(const char *start, const char *end)
  * To allow quick access to the contents of nth line in the
  * final image, prepare an index in the scoreboard.
  */
-static int prepare_lines(struct scoreboard *sb)
+static int prepare_lines(struct blame_scoreboard *sb)
 {
 	const char *buf = sb->final_buf;
 	unsigned long len = sb->final_buf_size;
@@ -2066,7 +2066,7 @@ static int update_auto_abbrev(int auto_abbrev, struct blame_origin *suspect)
  * How many columns do we need to show line numbers, authors,
  * and filenames?
  */
-static void find_alignment(struct scoreboard *sb, int *option)
+static void find_alignment(struct blame_scoreboard *sb, int *option)
 {
 	int longest_src_lines = 0;
 	int longest_dst_lines = 0;
@@ -2120,7 +2120,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
  * For debugging -- origin is refcounted, and this asserts that
  * we do not underflow.
  */
-static void sanity_check_refcnt(struct scoreboard *sb)
+static void sanity_check_refcnt(struct blame_scoreboard *sb)
 {
 	int baa = 0;
 	struct blame_entry *ent;
@@ -2411,14 +2411,14 @@ static struct commit *find_single_final(struct rev_info *revs,
 	return found;
 }
 
-static char *prepare_final(struct scoreboard *sb)
+static char *prepare_final(struct blame_scoreboard *sb)
 {
 	const char *name;
 	sb->final = find_single_final(sb->revs, &name);
 	return xstrdup_or_null(name);
 }
 
-static const char *dwim_reverse_initial(struct scoreboard *sb)
+static const char *dwim_reverse_initial(struct blame_scoreboard *sb)
 {
 	/*
 	 * DWIM "git blame --reverse ONE -- PATH" as
@@ -2453,7 +2453,7 @@ static const char *dwim_reverse_initial(struct scoreboard *sb)
 	return sb->revs->pending.objects[0].name;
 }
 
-static char *prepare_initial(struct scoreboard *sb)
+static char *prepare_initial(struct blame_scoreboard *sb)
 {
 	int i;
 	const char *final_commit_name = NULL;
@@ -2522,7 +2522,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	const char *path;
-	struct scoreboard sb;
+	struct blame_scoreboard sb;
 	struct blame_origin *o;
 	struct blame_entry *ent = NULL;
 	long dashdash_pos, lno;
-- 
2.9.3

