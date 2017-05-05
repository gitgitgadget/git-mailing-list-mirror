Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C073207D6
	for <e@80x24.org>; Fri,  5 May 2017 05:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755091AbdEEF1r (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 01:27:47 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35851 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbdEEF1o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 01:27:44 -0400
Received: by mail-io0-f193.google.com with SMTP id x86so8559968ioe.3
        for <git@vger.kernel.org>; Thu, 04 May 2017 22:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QbXzZy9BxEUct1UfO/Ft5TNuVWIV9xcPHCXfUwql7pk=;
        b=jFBBr9u/I8RSW2IpqmCGG13JDY0px+SISiP/K5K+KMuDGbslTzQWD5xxDcTwLDo/2G
         Q1jeu7lG55km9IQyxCQxXJOyGe64hOuY4E3z9TqQScirg+tv8kZPzT4e7lJjek4A+Acf
         ybwPXvzwKRTm18eMdFhq4Yo/z8H9dEsvmjesB3VQriJv7uJwm8l7Qhiy/67rqIkY/1ud
         1HDkkoe8r8bdsc35wvn/Oeel1Wd22tKVUnTZkbKlymmbxiEVy/GjVcPHo48q4ix1mH0S
         PzLfkd84KZRX+Q+QRDPHY/l95f2brcD6WMAFsvs21S3y9ZxwHlO7z4TvUXK9Q95p8uBs
         KJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QbXzZy9BxEUct1UfO/Ft5TNuVWIV9xcPHCXfUwql7pk=;
        b=CHT0iVgbpOMhg1XN2P50IYbGil6kT/He37RfIiyXatRwmqBCbylIngWl52uR7W/poC
         GXsRZyHH5dofYBmH38oIQ6kaLryjvvuanyYIOXHT9vLMhWxeC9o0yUqIrl3aVXa1AZzo
         x8TNgomQ++nbWIYt+ig9cPqS2aDoMbjM/p5J+B5DzThUFPuDQDS5oPvx1kucsC5uq/kw
         f5G/FTnOk+V483PXYBIryuirWjEEEGGbTqt63021vUKwM8Pwe5oXW8RPDRQIYqa5cPe0
         kKTjFD3rHXKaxOaSrCo7IA0JDb0jUpzrUPw1Pompf3gucwuACAb9e9S4QHBFCB/MVeoE
         0s3w==
X-Gm-Message-State: AN3rC/4X1YnkoOAkc23lkzJBcB81nA/832W+2BX2yAHDiERqUuVF03+g
        JafJHnvHJj6gqg==
X-Received: by 10.157.7.114 with SMTP id 105mr16912897ote.170.1493962062975;
        Thu, 04 May 2017 22:27:42 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 2sm2179586ota.46.2017.05.04.22.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 22:27:41 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH 07/10] Break out scoreboard a little better
Date:   Fri,  5 May 2017 00:27:26 -0500
Message-Id: <20170505052729.7576-8-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170505052729.7576-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 149 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 93 insertions(+), 56 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index c873cc2..dc7600c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -62,11 +62,6 @@ static struct string_list mailmap = STRING_LIST_INIT_NODUP;
 #define DEBUG 0
 #endif
 
-/* stats */
-static int num_read_blob;
-static int num_get_patch;
-static int num_commits;
-
 #define PICKAXE_BLAME_MOVE		01
 #define PICKAXE_BLAME_COPY		02
 #define PICKAXE_BLAME_COPY_HARDER	04
@@ -91,7 +86,7 @@ struct progress_info {
 };
 
 static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
-		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data)
+		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data, int xdl_opts)
 {
 	xpparam_t xpp = {0};
 	xdemitconf_t xecfg = {0};
@@ -108,13 +103,13 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
  * diff machinery
  */
 static void fill_origin_blob(struct diff_options *opt,
-			     struct origin *o, mmfile_t *file)
+			     struct origin *o, mmfile_t *file, int *num_read_blob)
 {
 	if (!o->file.ptr) {
 		enum object_type type;
 		unsigned long file_size;
 
-		num_read_blob++;
+		(*num_read_blob)++;
 		if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
 		    textconv_object(o->path, o->mode, &o->blob_oid, 1, &file->ptr, &file_size))
 			;
@@ -265,9 +260,36 @@ struct scoreboard {
 	/* look-up a line in the final buffer */
 	int num_lines;
 	int *lineno;
+
+	/*
+	 * blame for a blame_entry with score lower than these thresholds
+	 * is not passed to the parent using move/copy logic.
+	 */
+	unsigned blame_move_score;
+	unsigned blame_copy_score;
+
+	/* stats */
+	int num_read_blob;
+	int num_get_patch;
+	int num_commits;
+
+	/* options */
+	int show_root;
+	int reverse;
+	int xdl_opts;
+	int no_whole_file_rename;
+
+	/* callbacks */
+	void(*sanity_check)(struct scoreboard *);
+	void(*found_guilty_entry)(struct blame_entry *, void *);
+
+	void *found_guilty_entry_data;
 };
 
-static void sanity_check_refcnt(struct scoreboard *);
+static void blame_sort_final(struct scoreboard *sb)
+{
+	sb->ent = blame_sort(sb->ent, compare_blame_final);
+}
 
 /*
  * If two blame entries that are next to each other came from
@@ -290,8 +312,8 @@ static void coalesce(struct scoreboard *sb)
 		}
 	}
 
-	if (DEBUG) /* sanity */
-		sanity_check_refcnt(sb);
+	if (sb->sanity_check) /* sanity */
+		sb->sanity_check(sb);
 }
 
 /*
@@ -787,11 +809,11 @@ static void pass_blame_to_parent(struct scoreboard *sb,
 	d.offset = 0;
 	d.dstq = &newdest; d.srcq = &target->suspects;
 
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p);
-	fill_origin_blob(&sb->revs->diffopt, target, &file_o);
-	num_get_patch++;
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
+	fill_origin_blob(&sb->revs->diffopt, target, &file_o, &sb->num_read_blob);
+	sb->num_get_patch++;
 
-	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d))
+	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
 		die("unable to generate diff (%s -> %s)",
 		    oid_to_hex(&parent->commit->object.oid),
 		    oid_to_hex(&target->commit->object.oid));
@@ -940,7 +962,7 @@ static void find_copy_in_blob(struct scoreboard *sb,
 	 * file_p partially may match that image.
 	 */
 	memset(split, 0, sizeof(struct blame_entry [3]));
-	if (diff_hunks(file_p, &file_o, handle_split_cb, &d))
+	if (diff_hunks(file_p, &file_o, handle_split_cb, &d, sb->xdl_opts))
 		die("unable to generate diff (%s)",
 		    oid_to_hex(&parent->commit->object.oid));
 	/* remainder, if any, all match the preimage */
@@ -993,7 +1015,7 @@ static void find_move_in_parent(struct scoreboard *sb,
 	if (!unblamed)
 		return; /* nothing remains for this target */
 
-	fill_origin_blob(&sb->revs->diffopt, parent, &file_p);
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p, &sb->num_read_blob);
 	if (!file_p.ptr)
 		return;
 
@@ -1009,7 +1031,7 @@ static void find_move_in_parent(struct scoreboard *sb,
 			next = e->next;
 			find_copy_in_blob(sb, e, parent, split, &file_p);
 			if (split[1].suspect &&
-			    blame_move_score < ent_score(sb, &split[1])) {
+			    sb->blame_move_score < ent_score(sb, &split[1])) {
 				split_blame(blamed, &unblamedtail, split, e);
 			} else {
 				e->next = leftover;
@@ -1018,7 +1040,7 @@ static void find_move_in_parent(struct scoreboard *sb,
 			decref_split(split);
 		}
 		*unblamedtail = NULL;
-		toosmall = filter_small(sb, toosmall, &unblamed, blame_move_score);
+		toosmall = filter_small(sb, toosmall, &unblamed, sb->blame_move_score);
 	} while (unblamed);
 	target->suspects = reverse_blame(leftover, NULL);
 }
@@ -1122,7 +1144,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
 			norigin = get_origin(parent, p->one->path);
 			oidcpy(&norigin->blob_oid, &p->one->oid);
 			norigin->mode = p->one->mode;
-			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p);
+			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p, &sb->num_read_blob);
 			if (!file_p.ptr)
 				continue;
 
@@ -1139,7 +1161,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
 		for (j = 0; j < num_ents; j++) {
 			struct blame_entry *split = blame_list[j].split;
 			if (split[1].suspect &&
-			    blame_copy_score < ent_score(sb, &split[1])) {
+			    sb->blame_copy_score < ent_score(sb, &split[1])) {
 				split_blame(blamed, &unblamedtail, split,
 					    blame_list[j].ent);
 			} else {
@@ -1150,7 +1172,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
 		}
 		free(blame_list);
 		*unblamedtail = NULL;
-		toosmall = filter_small(sb, toosmall, &unblamed, blame_copy_score);
+		toosmall = filter_small(sb, toosmall, &unblamed, sb->blame_copy_score);
 	} while (unblamed);
 	target->suspects = reverse_blame(leftover, NULL);
 	diff_flush(&diff_opts);
@@ -1186,7 +1208,8 @@ static void pass_whole_blame(struct scoreboard *sb,
  * "parent" (and "porigin"), but what we mean is to find scapegoat to
  * exonerate ourselves.
  */
-static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit *commit)
+static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit *commit,
+					int reverse)
 {
 	if (!reverse) {
 		if (revs->first_parent_only &&
@@ -1200,9 +1223,9 @@ static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit
 	return lookup_decoration(&revs->children, &commit->object);
 }
 
-static int num_scapegoats(struct rev_info *revs, struct commit *commit)
+static int num_scapegoats(struct rev_info *revs, struct commit *commit, int reverse)
 {
-	struct commit_list *l = first_scapegoat(revs, commit);
+	struct commit_list *l = first_scapegoat(revs, commit, reverse);
 	return commit_list_count(l);
 }
 
@@ -1240,7 +1263,7 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	struct blame_entry *toosmall = NULL;
 	struct blame_entry *blames, **blametail = &blames;
 
-	num_sg = num_scapegoats(revs, commit);
+	num_sg = num_scapegoats(revs, commit, sb->reverse);
 	if (!num_sg)
 		goto finish;
 	else if (num_sg < ARRAY_SIZE(sg_buf))
@@ -1252,12 +1275,12 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	 * The first pass looks for unrenamed path to optimize for
 	 * common cases, then we look for renames in the second pass.
 	 */
-	for (pass = 0; pass < 2 - no_whole_file_rename; pass++) {
+	for (pass = 0; pass < 2 - sb->no_whole_file_rename; pass++) {
 		struct origin *(*find)(struct scoreboard *,
 				       struct commit *, struct origin *);
 		find = pass ? find_rename : find_origin;
 
-		for (i = 0, sg = first_scapegoat(revs, commit);
+		for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
 			struct commit *p = sg->item;
@@ -1288,8 +1311,8 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 		}
 	}
 
-	num_commits++;
-	for (i = 0, sg = first_scapegoat(revs, commit);
+	sb->num_commits++;
+	for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
 	     i < num_sg && sg;
 	     sg = sg->next, i++) {
 		struct origin *porigin = sg_origin[i];
@@ -1308,9 +1331,9 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	 * Optionally find moves in parents' files.
 	 */
 	if (opt & PICKAXE_BLAME_MOVE) {
-		filter_small(sb, &toosmall, &origin->suspects, blame_move_score);
+		filter_small(sb, &toosmall, &origin->suspects, sb->blame_move_score);
 		if (origin->suspects) {
-			for (i = 0, sg = first_scapegoat(revs, commit);
+			for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
 			     i < num_sg && sg;
 			     sg = sg->next, i++) {
 				struct origin *porigin = sg_origin[i];
@@ -1327,17 +1350,17 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
 	 * Optionally find copies from parents' files.
 	 */
 	if (opt & PICKAXE_BLAME_COPY) {
-		if (blame_copy_score > blame_move_score)
-			filter_small(sb, &toosmall, &origin->suspects, blame_copy_score);
-		else if (blame_copy_score < blame_move_score) {
+		if (sb->blame_copy_score > sb->blame_move_score)
+			filter_small(sb, &toosmall, &origin->suspects, sb->blame_copy_score);
+		else if (sb->blame_copy_score < sb->blame_move_score) {
 			origin->suspects = blame_merge(origin->suspects, toosmall);
 			toosmall = NULL;
-			filter_small(sb, &toosmall, &origin->suspects, blame_copy_score);
+			filter_small(sb, &toosmall, &origin->suspects, sb->blame_copy_score);
 		}
 		if (!origin->suspects)
 			goto finish;
 
-		for (i = 0, sg = first_scapegoat(revs, commit);
+		for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
 		     i < num_sg && sg;
 		     sg = sg->next, i++) {
 			struct origin *porigin = sg_origin[i];
@@ -1566,9 +1589,10 @@ static int emit_one_suspect_detail(struct origin *suspect, int repeat)
  * The blame_entry is found to be guilty for the range.
  * Show it in incremental output.
  */
-static void found_guilty_entry(struct blame_entry *ent,
-			   struct progress_info *pi)
+static void found_guilty_entry(struct blame_entry *ent, void *data)
 {
+	struct progress_info *pi = (struct progress_info *)data;
+
 	if (incremental) {
 		struct origin *suspect = ent->suspect;
 
@@ -1591,11 +1615,6 @@ static void assign_blame(struct scoreboard *sb, int opt)
 {
 	struct rev_info *revs = sb->revs;
 	struct commit *commit = prio_queue_get(&sb->commits);
-	struct progress_info pi = { NULL, 0 };
-
-	if (show_progress)
-		pi.progress = start_progress_delay(_("Blaming lines"),
-						   sb->num_lines, 50, 1);
 
 	while (commit) {
 		struct blame_entry *ent;
@@ -1618,7 +1637,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
 		 */
 		origin_incref(suspect);
 		parse_commit(commit);
-		if (reverse ||
+		if (sb->reverse ||
 		    (!(commit->object.flags & UNINTERESTING) &&
 		     !(revs->max_age != -1 && commit->date < revs->max_age)))
 			pass_blame(sb, suspect, opt);
@@ -1628,7 +1647,7 @@ static void assign_blame(struct scoreboard *sb, int opt)
 				mark_parents_uninteresting(commit);
 		}
 		/* treat root commit as boundary */
-		if (!commit->parents && !show_root)
+		if (!commit->parents && !sb->show_root)
 			commit->object.flags |= UNINTERESTING;
 
 		/* Take responsibility for the remaining entries */
@@ -1637,7 +1656,8 @@ static void assign_blame(struct scoreboard *sb, int opt)
 			suspect->guilty = 1;
 			for (;;) {
 				struct blame_entry *next = ent->next;
-				found_guilty_entry(ent, &pi);
+				if (sb->found_guilty_entry)
+					sb->found_guilty_entry(ent, sb->found_guilty_entry_data);
 				if (next) {
 					ent = next;
 					continue;
@@ -1650,11 +1670,9 @@ static void assign_blame(struct scoreboard *sb, int opt)
 		}
 		origin_decref(suspect);
 
-		if (DEBUG) /* sanity */
-			sanity_check_refcnt(sb);
+		if (sb->sanity_check) /* sanity */
+			sb->sanity_check(sb);
 	}
-
-	stop_progress(&pi.progress);
 }
 
 static const char *format_time(unsigned long time, const char *tz_str,
@@ -2187,6 +2205,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	char *final_commit_name = NULL;
 	enum object_type type;
 	struct commit *final_commit = NULL;
+	struct progress_info pi = { NULL, 0 };
 
 	struct string_list range_list = STRING_LIST_INIT_NODUP;
 	int output_option = 0, opt = 0;
@@ -2476,7 +2495,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			    oid_to_hex(&o->blob_oid),
 			    path);
 	}
-	num_read_blob++;
+	sb.num_read_blob++;
 	lno = prepare_lines(&sb);
 
 	if (lno && !range_list.nr)
@@ -2529,10 +2548,28 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.ent = NULL;
 	sb.path = path;
 
+	sb.blame_move_score = blame_move_score;
+	sb.blame_copy_score = blame_copy_score;
+
+	sb.sanity_check = DEBUG ? &sanity_check_refcnt : NULL;
+
+	sb.show_root = show_root;
+	sb.reverse = reverse;
+	sb.xdl_opts = xdl_opts;
+	sb.no_whole_file_rename = no_whole_file_rename;
+
 	read_mailmap(&mailmap, NULL);
 
+	sb.found_guilty_entry = &found_guilty_entry;
+	sb.found_guilty_entry_data = &pi;
+	if (show_progress)
+		pi.progress = start_progress_delay(_("Blaming lines"),
+						   sb.num_lines, 50, 1);
+
 	assign_blame(&sb, opt);
 
+	stop_progress(&pi.progress);
+
 	if (!incremental)
 		setup_pager();
 
@@ -2541,7 +2578,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	if (incremental)
 		return 0;
 
-	sb.ent = blame_sort(sb.ent, compare_blame_final);
+	blame_sort_final(&sb);
 
 	coalesce(&sb);
 
@@ -2557,9 +2594,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_stats) {
-		printf("num read blob: %d\n", num_read_blob);
-		printf("num get patch: %d\n", num_get_patch);
-		printf("num commits: %d\n", num_commits);
+		printf("num read blob: %d\n", sb.num_read_blob);
+		printf("num get patch: %d\n", sb.num_get_patch);
+		printf("num commits: %d\n", sb.num_commits);
 	}
 	return 0;
 }
-- 
2.9.3

