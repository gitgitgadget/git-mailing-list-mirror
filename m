Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05F3C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D8F60F9C
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhJDBOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 21:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbhJDBN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 21:13:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3284FC0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:12:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r10so11121102wra.12
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRU95OW9Ji2PsrVJUcCyWwLiXZ1FJftyWxzZwjNsR8Y=;
        b=BS0YdfrN+BlFE+9zo/VML6iTyYqo8pHx5fYbxoqDjfJfDfteWiNpfCkJiNXAgtjyf5
         EaSHXNxcHNfyWCYWIc/00rtOLhJrIEenY2S02DnusoE4FuKMAT5NFx6GQd9F/l0wX7pq
         PDHf/kqkNg3VKWRMli0PdB2xrss257bImkVBpmpcC40mGpp6TPjU3r3lUc1NgLkrNaZ9
         WA0xuq2peI4V2UJJpjSrHhKHxlEqKCWd82vRR5W0ZHcB2RRbtkNcA0uLETIwvIGPsiHz
         My0Nd4euO6uVG+jrsnrcngzd1VDcDs//cDDMB5xzVQ9+SqojybtADg1zplwaWCvZQwnS
         oQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRU95OW9Ji2PsrVJUcCyWwLiXZ1FJftyWxzZwjNsR8Y=;
        b=dvw6FPA8HtQfHhv3CNk33dknjdbRmlgHkxT8NR23N7OUwSc2X9NLXZTbhQFxg4d8NO
         L9/YNyU/9rgrmJPem+3FAVBMs1RxDOnCOsbEIhzHYx6OI2T21mfwQT4yxsdiNmoVR4X6
         c5TnzcdJFgokE1SlH9Pk78ZXfZmpkYMwwiCXIXP7kWRAFk5cdb630z+6/3DCKIesDm9p
         AMVOOrG3OJoAVil+PPVrpV3QaHA3YylLT/SM5dbZ5tTsM7X6cQbHRXpQEAkKpU/iDFCQ
         DJ8+HL9EmyiI+KAw6jtYZOZMHjISIkNZ7m5KbtO1ZZkiMG7nEXBpz1eBzrkY1SV8rwFU
         Io3A==
X-Gm-Message-State: AOAM533VH/EkXGWf+lDxfYP+e83HVrZM7yAOTF5752+st3chfTYUFjpj
        oEYFxprpTQvc5KU4Zb8v/cTZHaXLfSHqOA==
X-Google-Smtp-Source: ABdhPJxLWsCg3APrGEYGMmjD4trshDVv2hRtQIe9Dxr6q9KvCARU3DLYWLk2MXasNC7eu6ae11q/+w==
X-Received: by 2002:a5d:5234:: with SMTP id i20mr11233181wra.415.1633309927433;
        Sun, 03 Oct 2021 18:12:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q3sm12384317wmc.25.2021.10.03.18.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:12:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v4 06/10] Change unpack_trees' 'reset' flag into an enum
Date:   Mon,  4 Oct 2021 03:11:55 +0200
Message-Id: <RFC-patch-v4-06.10-7b539a120b9-20211004T004902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g83021034c5d
In-Reply-To: <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
References: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Traditionally, unpack_trees_options->reset was used to signal that it
was okay to delete any untracked files in the way.  This was used by
`git read-tree --reset`, but then started appearing in other places as
well.  However, many of the other uses should not be deleting untracked
files in the way.  Change this value to an enum so that a value of 1
(i.e. "true") can be split into two:
   UNPACK_RESET_PROTECT_UNTRACKED,
   UNPACK_RESET_OVERWRITE_UNTRACKED
In order to catch accidental misuses (i.e. where folks call it the way
they traditionally used to), define the special enum value of
   UNPACK_RESET_INVALID = 1
which will trigger a BUG().

Modify existing callers so that
   read-tree --reset
   reset --hard
   checkout --force
continue using the UNPACK_RESET_OVERWRITE_UNTRACKED logic, while other
callers, including
   am
   checkout without --force
   stash  (though currently dead code; reset always had a value of 0)
   numerous callers from rebase/sequencer to reset_head()
will use the new UNPACK_RESET_PROTECT_UNTRACKED value.

Also, note that it has been reported that 'git checkout <treeish>
<pathspec>' currently also allows overwriting untracked files[1].  That
case should also be fixed, but it does not use unpack_trees() and thus
is outside the scope of the current changes.

[1] https://lore.kernel.org/git/15dad590-087e-5a48-9238-5d2826950506@gmail.com/

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c                     |  5 ++---
 builtin/checkout.c               |  5 +++--
 builtin/read-tree.c              |  3 +++
 builtin/reset.c                  |  9 +++++++--
 builtin/stash.c                  |  4 ++--
 reset.c                          |  2 +-
 t/t2500-untracked-overwriting.sh |  6 +++---
 unpack-trees.c                   | 10 +++++++++-
 unpack-trees.h                   | 11 +++++++++--
 9 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 8cb7e72e6c5..dfe2bf207e6 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1917,9 +1917,8 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 	opts.dst_index = &the_index;
 	opts.update = 1;
 	opts.merge = 1;
-	opts.reset = reset;
-	if (!reset)
-		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
+	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
+	opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	opts.fn = twoway_merge;
 	init_tree_desc(&t[0], head->buffer, head->size);
 	init_tree_desc(&t[1], remote->buffer, remote->size);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0c5187025c5..ee3e450537f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -646,9 +646,10 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.head_idx = -1;
 	opts.update = worktree;
 	opts.skip_unmerged = !worktree;
-	opts.reset = 1;
+	opts.reset = o->force ? UNPACK_RESET_OVERWRITE_UNTRACKED :
+				UNPACK_RESET_PROTECT_UNTRACKED;
+	opts.preserve_ignored = (!o->force && !o->overwrite_ignore);
 	opts.merge = 1;
-	opts.preserve_ignored = 0;
 	opts.fn = oneway_merge;
 	opts.verbose_update = o->show_progress;
 	opts.src_index = &the_index;
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 7f3c987b126..5e10caeff5a 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -166,6 +166,9 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (1 < opts.merge + opts.reset + prefix_set)
 		die("Which one? -m, --reset, or --prefix?");
 
+	if (opts.reset)
+		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
+
 	/*
 	 * NEEDSWORK
 	 *
diff --git a/builtin/reset.c b/builtin/reset.c
index 9d1391335a1..00d2de392a8 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -70,9 +70,14 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 		break;
 	case HARD:
 		opts.update = 1;
-		/* fallthrough */
+		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
+		break;
+	case MIXED:
+		opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
+		/* but opts.update=0, so working tree not updated */
+		break;
 	default:
-		opts.reset = 1;
+		BUG("invalid reset_type passed to reset_index");
 	}
 
 	read_cache_unmerged();
diff --git a/builtin/stash.c b/builtin/stash.c
index 92ad3241270..061237cf9a4 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -255,9 +255,9 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	opts.merge = 1;
-	opts.reset = reset;
+	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
 	opts.update = update;
-	if (update && !reset)
+	if (update)
 		opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	opts.fn = oneway_merge;
 
diff --git a/reset.c b/reset.c
index 5f69311b9f4..5788b1926f3 100644
--- a/reset.c
+++ b/reset.c
@@ -59,7 +59,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
 	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
 	if (!detach_head)
-		unpack_tree_opts.reset = 1;
+		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
 
 	if (repo_read_index_unmerged(r) < 0) {
 		ret = error(_("could not read index"));
diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
index 2412d121ea8..18604360df8 100755
--- a/t/t2500-untracked-overwriting.sh
+++ b/t/t2500-untracked-overwriting.sh
@@ -92,7 +92,7 @@ test_setup_checkout_m () {
 	)
 }
 
-test_expect_failure 'checkout -m does not nuke untracked file' '
+test_expect_success 'checkout -m does not nuke untracked file' '
 	test_setup_checkout_m &&
 	(
 		cd checkout &&
@@ -138,7 +138,7 @@ test_setup_sequencing () {
 	)
 }
 
-test_expect_failure 'git rebase --abort and untracked files' '
+test_expect_success 'git rebase --abort and untracked files' '
 	test_setup_sequencing rebase_abort_and_untracked &&
 	(
 		cd sequencing_rebase_abort_and_untracked &&
@@ -155,7 +155,7 @@ test_expect_failure 'git rebase --abort and untracked files' '
 	)
 '
 
-test_expect_failure 'git rebase fast forwarding and untracked files' '
+test_expect_success 'git rebase fast forwarding and untracked files' '
 	test_setup_sequencing rebase_fast_forward_and_untracked &&
 	(
 		cd sequencing_rebase_fast_forward_and_untracked &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 512011cfa42..37f769030ab 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1699,6 +1699,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	struct pattern_list pl;
 	int free_pattern_list = 0;
 
+	if (o->reset == UNPACK_RESET_INVALID)
+		BUG("o->reset had a value of 1; should be UNPACK_TREES_*_UNTRACKED");
+
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 
@@ -1711,6 +1714,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		ensure_full_index(o->dst_index);
 	}
 
+	if (o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED &&
+	    o->preserve_ignored)
+		BUG("UNPACK_RESET_OVERWRITE_UNTRACKED incompatible with preserved ignored files");
+
 	if (!o->preserve_ignored) {
 		o->private_dir.flags |= DIR_SHOW_IGNORED;
 		setup_standard_excludes(&o->private_dir);
@@ -2227,7 +2234,8 @@ static int verify_absent_1(const struct cache_entry *ce,
 	int len;
 	struct stat st;
 
-	if (o->index_only || o->reset || !o->update)
+	if (o->index_only || !o->update ||
+	    o->reset == UNPACK_RESET_OVERWRITE_UNTRACKED)
 		return 0;
 
 	len = check_leading_path(ce->name, ce_namelen(ce), 0);
diff --git a/unpack-trees.h b/unpack-trees.h
index 2eb633bf771..1582599606a 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -48,9 +48,15 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
  */
 void unpack_trees_options_release(struct unpack_trees_options *opts);
 
+enum unpack_trees_reset_type {
+	UNPACK_RESET_NONE = 0,    /* traditional "false" value; still valid */
+	UNPACK_RESET_INVALID = 1, /* "true" no longer valid; use below values */
+	UNPACK_RESET_PROTECT_UNTRACKED,
+	UNPACK_RESET_OVERWRITE_UNTRACKED
+};
+
 struct unpack_trees_options {
-	unsigned int reset,
-		     merge,
+	unsigned int merge,
 		     update,
 		     preserve_ignored,
 		     clone,
@@ -68,6 +74,7 @@ struct unpack_trees_options {
 		     exiting_early,
 		     show_all_errors,
 		     dry_run;
+	enum unpack_trees_reset_type reset;
 	const char *prefix;
 	int cache_bottom;
 	struct dir_struct private_dir; /* for internal use only */
-- 
2.33.0.1404.g83021034c5d

