Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCB7C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 13:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244675AbiFCNiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 09:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244670AbiFCNiF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 09:38:05 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D130512D28
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 06:37:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t6so10461612wra.4
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 06:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LEsswD3junsSh5IVs1Gc/4QAldD5XQcbwI2OtZ/tiXU=;
        b=ZcByN87XYzfuL7Re2PDs+WDpoDKFGxB5mkXICsuauQhkWVvoNLY0Ry1z7O2g5iXJOb
         o6fO5UoWqde6P4NGPU4AeYxmQq2ZB415MIp5saQVUdNZVU84zUe5HNbxT6T6HirZ3Z78
         toMrGOdBzXerUfmiXbPRV2w14bKao6qq8+2qSyiRhB3veCbgRoPlFdW8vZLiKDKT1M9d
         sE/6+cEaulPAIll+9jeEs4spzKRNWGm4F4IyuDZFAKD+xx1f+5/5HevlhkpGEz+uIkKN
         JgFBREC0ryVTNPj1OvNCGnJoYeIYy9OZ42j4uW2cOshDyf/VOhnb6gtD04x/sCvWLI0B
         k1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LEsswD3junsSh5IVs1Gc/4QAldD5XQcbwI2OtZ/tiXU=;
        b=Hx35GjjkJYH6H8y2jvF6R+RNSKCqBxhnZA5OG71qqAt/mPhhLxpvcl6T8EI5I1q+s+
         OIZLr9xrlwrrq2X8FBEnKF2gb3u+7VYxi25ihk8O+b4MuqocBfoJiBsIJHQ6xhRZdY31
         iMFgGpH4GXiv8F8xC3CXZlNh8qI+ujSApzl57/tpdMy+gs3xz4KVEdJVTIdjArc4bt9X
         JvIB+eMW44zdMDR+2q9pKqFHRFvus5iQKnbYUvIX6guxQxvAp8M1UAchqFltii1HlZlL
         IwQIU+EBHCrXIAI7vA2PQ7CctU8KdDFXWhUUb5Pox/075917f8XtQBnSELbbhY6bndB0
         IsUA==
X-Gm-Message-State: AOAM530Hn0glStS5PaBC9RD4M3dKddSzmYgOE4jh1WCvdW6rg4IPxS/m
        nxwUCqf4UOLhcVWZf76R+aupm+M8lSdB8qez
X-Google-Smtp-Source: ABdhPJzfRy0CV3CjIKSbgUlXpyWgZKkdhMc9svNxmKnAhKiBzmSLnmZ3mmw5nLxXVmiipleTZvy+FA==
X-Received: by 2002:adf:f750:0:b0:210:2ef5:7c5c with SMTP id z16-20020adff750000000b002102ef57c5cmr8063632wrp.416.1654263477758;
        Fri, 03 Jun 2022 06:37:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t10-20020a7bc3ca000000b003942a244f47sm11548231wmj.32.2022.06.03.06.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:37:57 -0700 (PDT)
Message-Id: <23fa663886405596370e5fc95f679ef299f0725c.1654263472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Jun 2022 13:37:51 +0000
Subject: [PATCH 3/4] rebase: add --update-refs option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When working on a large feature, it can be helpful to break that feature
into multiple smaller parts that become reviewed in sequence. During
development or during review, a change to one part of the feature could
affect multiple of these parts. An interactive rebase can help adjust
the multi-part "story" of the branch.

However, if there are branches tracking the different parts of the
feature, then rebasing the entire list of commits can create commits not
reachable from those "sub branches". It can take a manual step to update
those branches.

Add a new --update-refs option to 'git rebase -i' that adds 'git
update-ref' exec steps to the todo file whenever a commit that is being
rebased is decorated with that <ref>. This allows the user to rebase a
long list of commits in a multi-part feature and keep all of their
pointers to those parts.

Use the new for_each_decoration() while iterating over the existing todo
list. Be sure to iterate after any squashing or fixups are placed.
Update the branch only after those squashes and fixups are complete.
This allows a --fixup commit at the tip of the feature to apply
correctly to the sub branch, even if it is fixing up the most-recent
commit in that part.

One potential problem here is that refs decorating commits that are
already marked as "fixup!" or "squash!" will not be included in this
list. Generally, the reordering of the "fixup!" and "squash!" is likely
to change the relative order of these refs, so it is not recommended.
The workflow here is intended to allow these kinds of commits at the tip
of the rebased branch while the other sub branches come along for the
ride without intervention.

Be careful to not attempt updating any branch that is checked out. The
most common example is the branch being rebased is checked out and
decorates the tip commit. If the user is rebasing commits reachable from
a different branch that is checked out in a different worktree, then
they may be surprised to not see that ref update. However, it's probably
best to not optimize for this scenario and do the safest thing that will
result in a successful rebase. A comment is left in the TODO list that
signals that these refs are currently checked out.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-rebase.txt  |  7 +++
 builtin/rebase.c              |  5 ++
 sequencer.c                   | 99 +++++++++++++++++++++++++++++++++++
 sequencer.h                   |  1 +
 t/t3404-rebase-interactive.sh | 29 ++++++++++
 5 files changed, 141 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 262fb01aec0..866554fc978 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -609,6 +609,13 @@ provided. Otherwise an explicit `--no-reschedule-failed-exec` at the
 start would be overridden by the presence of
 `rebase.rescheduleFailedExec=true` configuration.
 
+--update-refs::
+--no-update-refs::
+	Automatically force-update any branches that point to commits that
+	are being rebased. Any branches that are checked out in a worktree
+	or point to a `squash! ...` or `fixup! ...` commit are not updated
+	in this way.
+
 INCOMPATIBLE OPTIONS
 --------------------
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7ab50cda2ad..56d82a52106 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -102,6 +102,7 @@ struct rebase_options {
 	int reschedule_failed_exec;
 	int reapply_cherry_picks;
 	int fork_point;
+	int update_refs;
 };
 
 #define REBASE_OPTIONS_INIT {			  	\
@@ -298,6 +299,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 		ret = complete_action(the_repository, &replay, flags,
 			shortrevisions, opts->onto_name, opts->onto,
 			&opts->orig_head, &commands, opts->autosquash,
+			opts->update_refs,
 			&todo_list);
 	}
 
@@ -1124,6 +1126,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "autosquash", &options.autosquash,
 			 N_("move commits that begin with "
 			    "squash!/fixup! under -i")),
+		OPT_BOOL(0, "update-refs", &options.update_refs,
+			 N_("update local refs that point to commits "
+			    "that are being rebased")),
 		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
 			N_("GPG-sign commits"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
diff --git a/sequencer.c b/sequencer.c
index 8c3ed3532ac..d6151af9849 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -35,6 +35,8 @@
 #include "commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "branch.h"
+#include "log-tree.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -5603,10 +5605,104 @@ static int skip_unnecessary_picks(struct repository *r,
 	return 0;
 }
 
+struct todo_add_branch_context {
+	struct todo_list new_list;
+	struct strbuf *buf;
+	struct commit *commit;
+};
+
+static int add_branch_for_decoration(const struct name_decoration *d, void *data)
+{
+	struct todo_add_branch_context *ctx = data;
+	size_t base_offset = ctx->buf->len;
+	int i = ctx->new_list.nr;
+	struct todo_item *item;
+	char *path;
+
+	ALLOC_GROW(ctx->new_list.items,
+		   ctx->new_list.nr + 1,
+		   ctx->new_list.alloc);
+	item = &ctx->new_list.items[i];
+
+	/* If the branch is checked out, then leave a comment instead. */
+	if (branch_checked_out(d->name, &path)) {
+		item->command = TODO_COMMENT;
+		strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
+			    d->name, path);
+		free(path);
+	} else {
+		item->command = TODO_EXEC;
+		strbuf_addf(ctx->buf, "git update-ref %s HEAD %s\n",
+			    d->name, oid_to_hex(&ctx->commit->object.oid));
+	}
+
+	item->commit = NULL;
+	item->offset_in_buf = base_offset;
+	item->arg_offset = base_offset;
+	item->arg_len = ctx->buf->len - base_offset;
+	ctx->new_list.nr++;
+
+	return 0;
+}
+
+/*
+ * For each 'pick' command, find out if the commit has a decoration in
+ * refs/heads/. If so, then add a 'git branch -f' exec command after
+ * that 'pick' (plus any following 'squash' or 'fixup' commands).
+ */
+static int todo_list_add_branch_commands(struct todo_list *todo_list)
+{
+	int i;
+	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
+	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
+	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
+	struct decoration_filter decoration_filter = {
+		.include_ref_pattern = &decorate_refs_include,
+		.exclude_ref_pattern = &decorate_refs_exclude,
+		.exclude_ref_config_pattern = &decorate_refs_exclude_config
+	};
+	struct todo_add_branch_context ctx = {
+		.new_list = TODO_LIST_INIT,
+		.buf = &todo_list->buf,
+	};
+
+	string_list_append(&decorate_refs_include, "refs/heads/");
+	load_ref_decorations(&decoration_filter, 0);
+
+	for (i = 0; i < todo_list->nr; ) {
+		struct todo_item *item = &todo_list->items[i];
+
+		do {
+			/* insert ith item into new list */
+			ALLOC_GROW(ctx.new_list.items,
+				   ctx.new_list.nr + 1,
+				   ctx.new_list.alloc);
+
+			memcpy(&ctx.new_list.items[ctx.new_list.nr++],
+			       &todo_list->items[i],
+			       sizeof(struct todo_item));
+
+			i++;
+		} while (i < todo_list->nr &&
+			 todo_list->items[i].command != TODO_PICK);
+
+		ctx.commit = item->commit;
+		for_each_decoration(item->commit, add_branch_for_decoration, &ctx);
+	}
+
+	free(todo_list->items);
+	todo_list->items = ctx.new_list.items;
+	todo_list->nr = ctx.new_list.nr;
+	todo_list->alloc = ctx.new_list.alloc;
+
+	return 0;
+}
+
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    struct commit *onto, const struct object_id *orig_head,
 		    struct string_list *commands, unsigned autosquash,
+		    unsigned keep_decorations,
 		    struct todo_list *todo_list)
 {
 	char shortonto[GIT_MAX_HEXSZ + 1];
@@ -5628,6 +5724,9 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	if (autosquash && todo_list_rearrange_squash(todo_list))
 		return -1;
 
+	if (keep_decorations && todo_list_add_branch_commands(todo_list))
+		return -1;
+
 	if (commands->nr)
 		todo_list_add_exec_commands(todo_list, commands);
 
diff --git a/sequencer.h b/sequencer.h
index da64473636b..1add3c7119f 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -166,6 +166,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		    const char *shortrevisions, const char *onto_name,
 		    struct commit *onto, const struct object_id *orig_head,
 		    struct string_list *commands, unsigned autosquash,
+		    unsigned keep_decorations,
 		    struct todo_list *todo_list);
 int todo_list_rearrange_squash(struct todo_list *todo_list);
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f31afd4a547..38c7ef95e0e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1743,6 +1743,35 @@ test_expect_success 'ORIG_HEAD is updated correctly' '
 	test_cmp_rev ORIG_HEAD test-orig-head@{1}
 '
 
+test_expect_success '--update-refs adds git branch commands' '
+	git checkout -b update-refs no-conflict-branch &&
+	test_commit extra fileX &&
+	git commit --amend --fixup=L &&
+	(
+		set_cat_todo_editor &&
+		git branch -f base A &&
+		git branch -f first J &&
+		git branch -f second J &&
+		git branch -f third L &&
+
+		test_must_fail git rebase -i --autosquash --update-refs primary >todo &&
+
+		cat >expect <<-EOF &&
+		pick $(git log -1 --format=%h J) J
+		exec git update-ref refs/heads/second HEAD $(git rev-parse J)
+		exec git update-ref refs/heads/first HEAD $(git rev-parse  J)
+		pick $(git log -1 --format=%h K) K
+		pick $(git log -1 --format=%h L) L
+		fixup $(git log -1 --format=%h update-refs) fixup! L
+		exec git update-ref refs/heads/third HEAD $(git rev-parse L)
+		pick $(git log -1 --format=%h M) M
+		exec git update-ref refs/heads/no-conflict-branch HEAD $(git rev-parse M)
+		EOF
+
+		test_cmp expect todo
+	)
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
gitgitgadget

