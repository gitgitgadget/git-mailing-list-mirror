Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A154DC77B61
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 13:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjC1N7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 09:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjC1N7T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C9FA276
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:16 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so9154308wmq.2
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=az5LTQe657GsJFkemNirmpCdecOxpT/jBrqiUwjpVJU=;
        b=VL0rnmjIfsNxz3TrHHKgLpa8i2W9Bb5vBbib8A8Ekax0XNwDbIFUmh56LLOk0Cr/lL
         Y0zRY+Aq0uaSy/6R4B9NwO2Y7B1OmobC96KIIJRSaof0Td0DA99pWy2gprHMilTKf5i8
         hh5Hyroae8TQ8jM6JdAGFRqr6uepk6pfIVeSjZSeEOVsBN7+HTLHF4KP8Awp9NFAVlRB
         Y+jqBq/ICMCY+7c4gRMAS0qPAx2sRKw/t4+lpzzA5w2W5jajpBP7onPIj4QvImlWIKqL
         9CU+SNOeyF5iVXuNntXkV4+kpff38KYCDRmTQoSGvAdpWoc8g7bbQIlLMivsZt1BE1Mm
         kWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=az5LTQe657GsJFkemNirmpCdecOxpT/jBrqiUwjpVJU=;
        b=CRAqM530+CJ/aXdTq7Ou4sm1tqHFGzcFY6yn1qWhAyhkYUanbAMUWcY521KgWqlGE3
         JRMG9EObPQCAkfgPlFhYmWrxBgTlIuM/EShlJTq0optOtz68+JTh/9EDwFzunnNM9RlS
         BwuvjtAOFZ5vmVnytEzXQyCVo/S0vBiueHqMwtQ93NeEj/h3ichkAGolyQS4dUSQrEcb
         HyzO/D9/dH4PrHQU2j3sBV7mBILEDhhjYFrEW2tojTNu/s4Cb6iB0pT4B/jxYaITrNkG
         L6thegHqUMkbvX4GeRcvD6nem1cBUsdFoZzeSEGG4KFKZIpEJx0x3TNs6Dct6WumyjQt
         t6Mg==
X-Gm-Message-State: AO0yUKWmIBB1P7jjM1nfoOy5u4bMuQSXiEx24GZMwkYF9lrGbBLJgGM6
        x6dz+YOemMJ1/N+f+sNAb9d5MOT6We4QMw==
X-Google-Smtp-Source: AK7set8HDA7asWq8MrIE68VuOGUTB7rLD5p/3AtEQebn0yP/1qYMJJUYNQtWKLHYReUEMQ7oYQYNXQ==
X-Received: by 2002:a1c:790b:0:b0:3ee:56f7:75d2 with SMTP id l11-20020a1c790b000000b003ee56f775d2mr12386930wme.20.1680011954642;
        Tue, 28 Mar 2023 06:59:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6252268wmo.37.2023.03.28.06.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:59:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/17] cocci: apply the "commit-reach.h" part of "the_repository.pending"
Date:   Tue, 28 Mar 2023 15:58:47 +0200
Message-Id: <patch-v2-06.17-0f24a57b50b-20230328T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the part of "the_repository.pending.cocci" pertaining to
"commit-reach.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bisect.c                                        |  3 ++-
 builtin/branch.c                                |  5 +++--
 builtin/fast-import.c                           |  2 +-
 builtin/fetch.c                                 |  3 ++-
 builtin/log.c                                   | 10 +++++++---
 builtin/merge-base.c                            |  5 +++--
 builtin/merge-tree.c                            |  3 ++-
 builtin/merge.c                                 |  7 +++++--
 builtin/rebase.c                                |  5 +++--
 builtin/receive-pack.c                          |  2 +-
 builtin/rev-parse.c                             |  2 +-
 commit-reach.c                                  |  3 ++-
 commit-reach.h                                  |  9 ---------
 commit.c                                        |  3 ++-
 contrib/coccinelle/the_repository.cocci         | 16 ++++++++++++++++
 contrib/coccinelle/the_repository.pending.cocci | 16 ----------------
 http-push.c                                     |  2 +-
 log-tree.c                                      |  2 +-
 merge-ort.c                                     |  2 +-
 merge-recursive.c                               |  2 +-
 notes-merge.c                                   |  2 +-
 remote.c                                        |  2 +-
 revision.c                                      |  4 ++--
 sequencer.c                                     |  3 ++-
 shallow.c                                       |  9 +++++----
 t/helper/test-reach.c                           | 10 +++++++---
 26 files changed, 72 insertions(+), 60 deletions(-)

diff --git a/bisect.c b/bisect.c
index 1409150c5c3..b1639a9de7f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -847,7 +847,8 @@ static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int
 	enum bisect_error res = BISECT_OK;
 	struct commit_list *result;
 
-	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1);
+	result = repo_get_merge_bases_many(the_repository, rev[0], rev_nr - 1,
+					   rev + 1);
 
 	for (; result; result = result->next) {
 		const struct object_id *mb = &result->item->object.oid;
diff --git a/builtin/branch.c b/builtin/branch.c
index 968ea03c059..bbcfb34b3c6 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -150,7 +150,8 @@ static int branch_merged(int kind, const char *name,
 	if (!reference_rev)
 		reference_rev = head_rev;
 
-	merged = reference_rev ? in_merge_bases(rev, reference_rev) : 0;
+	merged = reference_rev ? repo_in_merge_bases(the_repository, rev,
+						     reference_rev) : 0;
 
 	/*
 	 * After the safety valve is fully redefined to "check with
@@ -160,7 +161,7 @@ static int branch_merged(int kind, const char *name,
 	 * a gentle reminder is in order.
 	 */
 	if ((head_rev != reference_rev) &&
-	    (head_rev ? in_merge_bases(rev, head_rev) : 0) != merged) {
+	    (head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0) != merged) {
 		if (merged)
 			warning(_("deleting branch '%s' that has been merged to\n"
 				"         '%s', but not yet merged to HEAD."),
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 7faedc9aa44..e4566490d91 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1626,7 +1626,7 @@ static int update_branch(struct branch *b)
 		if (!old_cmit || !new_cmit)
 			return error("Branch %s is missing commits.", b->name);
 
-		if (!in_merge_bases(old_cmit, new_cmit)) {
+		if (!repo_in_merge_bases(the_repository, old_cmit, new_cmit)) {
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, oid_to_hex(&b->oid),
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6bab662829f..16dc2a33cac 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -966,7 +966,8 @@ static int update_local_ref(struct ref *ref,
 
 	if (fetch_show_forced_updates) {
 		uint64_t t_before = getnanotime();
-		fast_forward = in_merge_bases(current, updated);
+		fast_forward = repo_in_merge_bases(the_repository, current,
+						   updated);
 		forced_updates_ms += (getnanotime() - t_before) / 1000000;
 	} else {
 		fast_forward = 1;
diff --git a/builtin/log.c b/builtin/log.c
index 1e7bbedf5d2..e16bda87ba3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1663,7 +1663,9 @@ static struct commit *get_base_commit(const char *base_commit,
 					return NULL;
 			}
 			commit = lookup_commit_or_die(&oid, "upstream base");
-			base_list = get_merge_bases_many(commit, total, list);
+			base_list = repo_get_merge_bases_many(the_repository,
+							      commit, total,
+							      list);
 			/* There should be one and only one merge base. */
 			if (!base_list || base_list->next) {
 				if (die_on_failure) {
@@ -1697,7 +1699,9 @@ static struct commit *get_base_commit(const char *base_commit,
 	while (rev_nr > 1) {
 		for (i = 0; i < rev_nr / 2; i++) {
 			struct commit_list *merge_base;
-			merge_base = get_merge_bases(rev[2 * i], rev[2 * i + 1]);
+			merge_base = repo_get_merge_bases(the_repository,
+							  rev[2 * i],
+							  rev[2 * i + 1]);
 			if (!merge_base || merge_base->next) {
 				if (die_on_failure) {
 					die(_("failed to find exact merge base"));
@@ -1715,7 +1719,7 @@ static struct commit *get_base_commit(const char *base_commit,
 		rev_nr = DIV_ROUND_UP(rev_nr, 2);
 	}
 
-	if (!in_merge_bases(base, rev[0])) {
+	if (!repo_in_merge_bases(the_repository, base, rev[0])) {
 		if (die_on_failure) {
 			die(_("base commit should be the ancestor of revision list"));
 		} else {
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 5b0ed0d2738..671e424c26c 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -14,7 +14,8 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 {
 	struct commit_list *result, *r;
 
-	result = get_merge_bases_many_dirty(rev[0], rev_nr - 1, rev + 1);
+	result = repo_get_merge_bases_many_dirty(the_repository, rev[0],
+						 rev_nr - 1, rev + 1);
 
 	if (!result)
 		return 1;
@@ -106,7 +107,7 @@ static int handle_is_ancestor(int argc, const char **argv)
 		die("--is-ancestor takes exactly two commits");
 	one = get_commit_reference(argv[0]);
 	two = get_commit_reference(argv[1]);
-	if (in_merge_bases(one, two))
+	if (repo_in_merge_bases(the_repository, one, two))
 		return 0;
 	else
 		return 1;
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index e7825181648..234db21548b 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -453,7 +453,8 @@ static int real_merge(struct merge_tree_options *o,
 		 * Get the merge bases, in reverse order; see comment above
 		 * merge_incore_recursive in merge-ort.h
 		 */
-		merge_bases = get_merge_bases(parent1, parent2);
+		merge_bases = repo_get_merge_bases(the_repository, parent1,
+						   parent2);
 		if (!merge_bases && !o->allow_unrelated_histories)
 			die(_("refusing to merge unrelated histories"));
 		merge_bases = reverse_commit_list(merge_bases);
diff --git a/builtin/merge.c b/builtin/merge.c
index 6a0519c39db..5dfc650a7bc 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1530,7 +1530,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (!remoteheads)
 		; /* already up-to-date */
 	else if (!remoteheads->next)
-		common = get_merge_bases(head_commit, remoteheads->item);
+		common = repo_get_merge_bases(the_repository, head_commit,
+					      remoteheads->item);
 	else {
 		struct commit_list *list = remoteheads;
 		commit_list_insert(head_commit, &list);
@@ -1648,7 +1649,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			 * merge_bases again, otherwise "git merge HEAD^
 			 * HEAD^^" would be missed.
 			 */
-			common_one = get_merge_bases(head_commit, j->item);
+			common_one = repo_get_merge_bases(the_repository,
+							  head_commit,
+							  j->item);
 			if (!oideq(&common_one->item->object.oid, &j->item->object.oid)) {
 				up_to_date = 0;
 				break;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 55ecc2d5f33..6390dd2fcc1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -883,7 +883,7 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	if (!upstream)
 		goto done;
 
-	merge_bases = get_merge_bases(upstream, head);
+	merge_bases = repo_get_merge_bases(the_repository, upstream, head);
 	if (!merge_bases || merge_bases->next)
 		goto done;
 
@@ -902,7 +902,8 @@ static void fill_branch_base(struct rebase_options *options,
 {
 	struct commit_list *merge_bases = NULL;
 
-	merge_bases = get_merge_bases(options->onto, options->orig_head);
+	merge_bases = repo_get_merge_bases(the_repository, options->onto,
+					   options->orig_head);
 	if (!merge_bases || merge_bases->next)
 		oidcpy(branch_base, null_oid());
 	else
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c6ab537a44f..e2b7202b04c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1547,7 +1547,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		}
 		old_commit = (struct commit *)old_object;
 		new_commit = (struct commit *)new_object;
-		if (!in_merge_bases(old_commit, new_commit)) {
+		if (!repo_in_merge_bases(the_repository, old_commit, new_commit)) {
 			rp_error("denying non-fast-forward %s"
 				 " (you should pull first)", name);
 			ret = "non-fast-forward";
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 5db9d6ad518..4969815ca79 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -294,7 +294,7 @@ static int try_difference(const char *arg)
 				*dotdot = '.';
 				return 0;
 			}
-			exclude = get_merge_bases(a, b);
+			exclude = repo_get_merge_bases(the_repository, a, b);
 			while (exclude) {
 				struct commit *commit = pop_commit(&exclude);
 				show_rev(REVERSED, &commit->object.oid, NULL);
diff --git a/commit-reach.c b/commit-reach.c
index 7c0c39fd286..4a2ea9ca1f7 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -164,7 +164,8 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 
 		for (j = ret; j; j = j->next) {
 			struct commit_list *bases;
-			bases = get_merge_bases(i->item, j->item);
+			bases = repo_get_merge_bases(the_repository, i->item,
+						     j->item);
 			if (!new_commits)
 				new_commits = bases;
 			else
diff --git a/commit-reach.h b/commit-reach.h
index 148b56fea50..94a96e03299 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -19,11 +19,6 @@ struct commit_list *repo_get_merge_bases_many(struct repository *r,
 struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
 						    struct commit *one, int n,
 						    struct commit **twos);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define get_merge_bases(r1, r2)           repo_get_merge_bases(the_repository, r1, r2)
-#define get_merge_bases_many(one, n, two) repo_get_merge_bases_many(the_repository, one, n, two)
-#define get_merge_bases_many_dirty(one, n, twos) repo_get_merge_bases_many_dirty(the_repository, one, n, twos)
-#endif
 
 struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
@@ -36,10 +31,6 @@ int repo_in_merge_bases(struct repository *r,
 int repo_in_merge_bases_many(struct repository *r,
 			     struct commit *commit,
 			     int nr_reference, struct commit **reference);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define in_merge_bases(c1, c2) repo_in_merge_bases(the_repository, c1, c2)
-#define in_merge_bases_many(c1, n, cs) repo_in_merge_bases_many(the_repository, c1, n, cs)
-#endif
 
 /*
  * Takes a list of commits and returns a new list where those
diff --git a/commit.c b/commit.c
index c0b1db3d3e1..aa2e58ea207 100644
--- a/commit.c
+++ b/commit.c
@@ -1017,7 +1017,8 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 	for (i = 0; i < revs.nr; i++)
 		revs.commit[i]->object.flags &= ~TMP_MARK;
 
-	bases = get_merge_bases_many(commit, revs.nr, revs.commit);
+	bases = repo_get_merge_bases_many(the_repository, commit, revs.nr,
+					  revs.commit);
 
 	/*
 	 * There should be one and only one merge base, when we found
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index dcdba314fc2..1ab63f0196b 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -38,6 +38,22 @@
 |
 - peel_to_type
 + repo_peel_to_type
+// commit-reach.h
+|
+- get_merge_bases
++ repo_get_merge_bases
+|
+- get_merge_bases_many
++ repo_get_merge_bases_many
+|
+- get_merge_bases_many_dirty
++ repo_get_merge_bases_many_dirty
+|
+- in_merge_bases
++ repo_in_merge_bases
+|
+- in_merge_bases_many
++ repo_in_merge_bases_many
 )
   (
 + the_repository,
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 2d200ab83e7..e9209fc0cc4 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,23 +5,7 @@
 @@
 @@
 (
-// commit-reach.h
-- get_merge_bases
-+ repo_get_merge_bases
-|
-- get_merge_bases_many
-+ repo_get_merge_bases_many
-|
-- get_merge_bases_many_dirty
-+ repo_get_merge_bases_many_dirty
-|
-- in_merge_bases
-+ repo_in_merge_bases
-|
-- in_merge_bases_many
-+ repo_in_merge_bases_many
 // commit.h
-|
 - parse_commit_internal
 + repo_parse_commit_internal
 |
diff --git a/http-push.c b/http-push.c
index 88aa045ecba..2693d73cf9a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1571,7 +1571,7 @@ static int verify_merge_base(struct object_id *head_oid, struct ref *remote)
 	struct commit *branch = lookup_commit_or_die(&remote->old_oid,
 						     remote->name);
 
-	return in_merge_bases(branch, head);
+	return repo_in_merge_bases(the_repository, branch, head);
 }
 
 static int delete_remote_branch(const char *pattern, int force)
diff --git a/log-tree.c b/log-tree.c
index 49411c5c6a6..97d374c76d6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -996,7 +996,7 @@ static int do_remerge_diff(struct rev_info *opt,
 	/* Parse the relevant commits and get the merge bases */
 	parse_commit_or_die(parent1);
 	parse_commit_or_die(parent2);
-	bases = get_merge_bases(parent1, parent2);
+	bases = repo_get_merge_bases(the_repository, parent1, parent2);
 
 	/* Re-merge the parents */
 	merge_incore_recursive(&o, bases, parent1, parent2, &res);
diff --git a/merge-ort.c b/merge-ort.c
index 4c5be8ed910..186e26d90a0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5018,7 +5018,7 @@ static void merge_ort_internal(struct merge_options *opt,
 	struct strbuf merge_base_abbrev = STRBUF_INIT;
 
 	if (!merge_bases) {
-		merge_bases = get_merge_bases(h1, h2);
+		merge_bases = repo_get_merge_bases(the_repository, h1, h2);
 		/* See merge-ort.h:merge_incore_recursive() declaration NOTE */
 		merge_bases = reverse_commit_list(merge_bases);
 	}
diff --git a/merge-recursive.c b/merge-recursive.c
index 89731f40908..cfb201d682b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3592,7 +3592,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 	}
 
 	if (!merge_bases) {
-		merge_bases = get_merge_bases(h1, h2);
+		merge_bases = repo_get_merge_bases(the_repository, h1, h2);
 		merge_bases = reverse_commit_list(merge_bases);
 	}
 
diff --git a/notes-merge.c b/notes-merge.c
index f9137ec768f..699edcfe105 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -601,7 +601,7 @@ int notes_merge(struct notes_merge_options *o,
 	assert(local && remote);
 
 	/* Find merge bases */
-	bases = get_merge_bases(local, remote);
+	bases = repo_get_merge_bases(the_repository, local, remote);
 	if (!bases) {
 		base_oid = null_oid();
 		base_tree_oid = the_hash_algo->empty_tree;
diff --git a/remote.c b/remote.c
index a0f22c8751e..37cb5213795 100644
--- a/remote.c
+++ b/remote.c
@@ -2664,7 +2664,7 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
 		if (MERGE_BASES_BATCH_SIZE < size)
 			size = MERGE_BASES_BATCH_SIZE;
 
-		if ((ret = in_merge_bases_many(commit, size, chunk)))
+		if ((ret = repo_in_merge_bases_many(the_repository, commit, size, chunk)))
 			break;
 	}
 
diff --git a/revision.c b/revision.c
index e08f697c47c..b6a1b47c306 100644
--- a/revision.c
+++ b/revision.c
@@ -1960,7 +1960,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
-	bases = get_merge_bases(head, other);
+	bases = repo_get_merge_bases(the_repository, head, other);
 	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
 	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);
 	free_commit_list(bases);
@@ -2055,7 +2055,7 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 		if (!a || !b)
 			return dotdot_missing(arg, dotdot, revs, symmetric);
 
-		exclude = get_merge_bases(a, b);
+		exclude = repo_get_merge_bases(the_repository, a, b);
 		add_rev_cmdline_list(revs, exclude, REV_CMD_MERGE_BASE,
 				     flags_exclude);
 		add_pending_commit_list(revs, exclude, flags_exclude);
diff --git a/sequencer.c b/sequencer.c
index d73827632d8..3578dc25510 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4105,7 +4105,8 @@ static int do_merge(struct repository *r,
 	}
 
 	merge_commit = to_merge->item;
-	bases = get_merge_bases(head_commit, merge_commit);
+	bases = repo_get_merge_bases(the_repository, head_commit,
+				     merge_commit);
 	if (bases && oideq(&merge_commit->object.oid,
 			   &bases->item->object.oid)) {
 		ret = 0;
diff --git a/shallow.c b/shallow.c
index 1cbb05ba0e4..db9856ef8ad 100644
--- a/shallow.c
+++ b/shallow.c
@@ -793,7 +793,7 @@ static void post_assign_shallow(struct shallow_info *info,
 		for (j = 0; j < bitmap_nr; j++)
 			if (bitmap[0][j] &&
 			    /* Step 7, reachability test at commit level */
-			    !in_merge_bases_many(c, ca.nr, ca.commits)) {
+			    !repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits)) {
 				update_refstatus(ref_status, info->ref->nr, *bitmap);
 				dst++;
 				break;
@@ -821,9 +821,10 @@ int delayed_reachability_test(struct shallow_info *si, int c)
 			si->nr_commits = ca.nr;
 		}
 
-		si->reachable[c] = in_merge_bases_many(commit,
-						       si->nr_commits,
-						       si->commits);
+		si->reachable[c] = repo_in_merge_bases_many(the_repository,
+							    commit,
+							    si->nr_commits,
+							    si->commits);
 		si->need_reachability_test[c] = 0;
 	}
 	return si->reachable[c];
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index afb9bb3189f..d08c3ffa3ba 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -107,13 +107,17 @@ int cmd__reach(int ac, const char **av)
 	if (!strcmp(av[1], "ref_newer"))
 		printf("%s(A,B):%d\n", av[1], ref_newer(&oid_A, &oid_B));
 	else if (!strcmp(av[1], "in_merge_bases"))
-		printf("%s(A,B):%d\n", av[1], in_merge_bases(A, B));
+		printf("%s(A,B):%d\n", av[1],
+		       repo_in_merge_bases(the_repository, A, B));
 	else if (!strcmp(av[1], "in_merge_bases_many"))
-		printf("%s(A,X):%d\n", av[1], in_merge_bases_many(A, X_nr, X_array));
+		printf("%s(A,X):%d\n", av[1],
+		       repo_in_merge_bases_many(the_repository, A, X_nr, X_array));
 	else if (!strcmp(av[1], "is_descendant_of"))
 		printf("%s(A,X):%d\n", av[1], repo_is_descendant_of(r, A, X));
 	else if (!strcmp(av[1], "get_merge_bases_many")) {
-		struct commit_list *list = get_merge_bases_many(A, X_nr, X_array);
+		struct commit_list *list = repo_get_merge_bases_many(the_repository,
+								     A, X_nr,
+								     X_array);
 		printf("%s(A,X):\n", av[1]);
 		print_sorted_commit_ids(list);
 	} else if (!strcmp(av[1], "reduce_heads")) {
-- 
2.40.0.rc1.1034.g5867a1b10c5

