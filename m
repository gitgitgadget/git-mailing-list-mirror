Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90AAC433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 19:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiDVTfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 15:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiDVTey (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 15:34:54 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFA226EDF8
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 12:12:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id n17so10762640ljc.11
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 12:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gGk3ErApNMJyGFMN3/WryLvirOSFoTqj0IhaF5UkvgQ=;
        b=V+Cjp5sVMR937skpArYXSkLkBkYhqwM7xOLz/BkMqGMdlEl+mvFKDKhSZM8qmo2HIR
         1gGMY2CCjfm3V72lZOjjCeHBKztYSiOYk1kQEmo8DZ6NmVkQyoOLpLmHP59H+bRoo6zZ
         TEVZ9VgV6fZhGfgtOc6HhgWulVEeLnSSUDSymTP7TaCByHilGhacVL/Xd8DqMA8isSRH
         67Ozhh7ZFL1J3MKi059eXZIIfsPRZX6XQVgrxaa75TZ4uIY20+g+Op3If2DZHA5BxMqg
         WCU+BkEG6TsmCK7JDIRgqSnJ8F+Y640+tAVBdq/q7ehFQqbun3HR3Iryc9bOS76IyPC4
         0I3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gGk3ErApNMJyGFMN3/WryLvirOSFoTqj0IhaF5UkvgQ=;
        b=GaynmEh/yIGA7hf2O+VK1tyUPxVlZuB4meOLCqf83i7tbX6eobwQur5oxG4POBICtl
         CUdIMz3jIG1V+6mthRywdE9J6ag9KMWjuMSobkMFRQFhzrhjZxmbx7O2i7n9KPyUFOUX
         WvxrHNPI8qdXk3aSQONzceXkAT+P9UqfIV1emi9E/VQTjNtR/6tr/N+hYqtqJMtndDp4
         2j7iVlG3UZ/teBQCGTxZyFRfr5Df2SN/PStJeOnjVd15qB6gVCPPDsp6cIIWMKx4sPO4
         vavNUJhkr1sR1XXWKaf3LLcvrTSOq0DAs8KWtGpcIv+FFj+F1CaQYgTJxMb1ZvOZnpNK
         HgaQ==
X-Gm-Message-State: AOAM53273FZDAHsk5bjGbboMBSq+7dsb74TXaOAH/RK5N5mPnQuEZNVX
        yBSeCDCjwrBiMd17P24b31rlYXjf1gPSTxMQ
X-Google-Smtp-Source: ABdhPJz44OrtB3Q0DDqRlNOaz3zCC4kc5fDG001F8JaZOVHgrYVUG1i8H7v/bCBBd0lE9eGws34YIA==
X-Received: by 2002:a17:906:7952:b0:6da:94c9:cccb with SMTP id l18-20020a170906795200b006da94c9cccbmr5255216ejo.469.1650652679543;
        Fri, 22 Apr 2022 11:37:59 -0700 (PDT)
Received: from linuxerio.localdomain (j149130.upc-j.chello.nl. [24.132.149.130])
        by smtp.gmail.com with ESMTPSA id h9-20020aa7c949000000b0041b4d8ae50csm1135713edt.34.2022.04.22.11.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 11:37:59 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v1] rebase - recycle
Date:   Fri, 22 Apr 2022 20:37:44 +0200
Message-Id: <20220422183744.347327-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rebasing a branch, there is a very narrow workflow
where a branch is asked to be placed on top of another
branch that has the same tree as the upstream branch.

When this happens, the rebased revisions can be generated using
the trees of the revisions that will be rebased without any
need to involve work from the merge engine and they can also be
created without moving the working tree until the tip of
the target rebased branch is created. This accelerates
the process of rebasing even straight lines and avoids completely
the need to have to go over merge revisions where there might
have been conflicts as is the case with current rebase.

As an example, let's create a sample repo:

$ mkdir temp
$ cd temp
$ git init -b main .
$ for i in $( seq 1 1000 ); do echo $i >> count.txt; git add count.txt; git commit -m $i; done
$ git branch new-main
$ git checkout -b new-base main~999
$ git commit --amend --no-edit

Rebasing this straight line onto new-base:
$ time git rebase --onto HEAD main~999 new-main
Successfully rebased and updated refs/heads/new-main.

real    0m5,801s
user    0m0,844s
sys     0m1,899s

Same operation recycling:
$ time git rebase --recycle --onto HEAD main~999 new-main
$ time ../git rebase --recycle --onto HEAD main~999 new-main
Recycled new-main onto HEAD.

real    0m0,263s
user    0m0,098s
sys     0m0,135s

If we tried recycling a complex tree that has multiple
merges, it avoids having to go through conflict resolution. Using
rather recent releases of git as an example:

$ git checkout v2.34.0
$ git commit --amend --no-edit
$ time ../git rebase --recycle --onto HEAD v2.34.0 v2.36.0
Recycled v2.36.0 onto HEAD.

real    0m5,137s
user    0m0,841s
sys     0m0,530s

Two options are added to support this feature:
--recycle
  Try to recycle. If it's not possible to recycle, fail.
--attempt-recycle
  Try to recycle. If it's not possible to recycle, allow
  the normal preexisting implementation of rebase to work.

Avoided implementing it to be triggered based on just a check
for the trees to match and then recycle because recycling
implies that merges will be applied which differs from
default rebase behavior.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 builtin/rebase.c | 230 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 229 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 27fde7bf28..aa764991e2 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -29,6 +29,9 @@
 #include "rebase-interactive.h"
 #include "reset.h"
 #include "hook.h"
+#include "oidmap.h"
+#include "progress.h"
+#include "wt-status.h"
 
 #define DEFAULT_REFLOG_ACTION "rebase"
 
@@ -49,7 +52,8 @@ static GIT_PATH_FUNC(merge_dir, "rebase-merge")
 enum rebase_type {
 	REBASE_UNSPECIFIED = -1,
 	REBASE_APPLY,
-	REBASE_MERGE
+	REBASE_MERGE,
+	REBASE_RECYCLE
 };
 
 enum empty_type {
@@ -83,6 +87,8 @@ struct rebase_options {
 		REBASE_DIFFSTAT = 1<<2,
 		REBASE_FORCE = 1<<3,
 		REBASE_INTERACTIVE_EXPLICIT = 1<<4,
+		REBASE_RECYCLE_OR_FAIL = 1 << 5,
+		REBASE_ATTEMPT_RECYCLE = 1<<6,
 	} flags;
 	struct strvec git_am_opts;
 	const char *action;
@@ -104,6 +110,16 @@ struct rebase_options {
 	int fork_point;
 };
 
+struct recycle_parent_mapping {
+	struct oidmap_entry e;
+	struct commit *new_parent;
+};
+
+struct recycle_progress_info {
+	struct progress *progress;
+	int commits;
+};
+
 #define REBASE_OPTIONS_INIT {			  	\
 		.type = REBASE_UNSPECIFIED,	  	\
 		.empty = EMPTY_UNSPECIFIED,	  	\
@@ -384,6 +400,12 @@ static int is_merge(struct rebase_options *opts)
 	return opts->type == REBASE_MERGE;
 }
 
+static int can_recycle(struct rebase_options *opts)
+{
+	return oideq(get_commit_tree_oid(opts->onto),
+		     get_commit_tree_oid(opts->upstream));
+}
+
 static void imply_merge(struct rebase_options *opts, const char *option)
 {
 	switch (opts->type) {
@@ -771,6 +793,173 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	return status ? -1 : 0;
 }
 
+static struct commit *recycle_commit(struct commit *orig_commit,
+				     struct oidmap *parents)
+{
+	const char *body;
+	size_t body_length;
+	const char *author_raw;
+	size_t author_length;
+	struct strbuf author = STRBUF_INIT;
+	const char *message;
+	size_t message_length;
+	int result;
+
+	struct commit *new_commit;
+	struct object_id new_commit_oid;
+	struct commit_list *parent = orig_commit->parents;
+	struct commit_list *new_parents_head = NULL;
+	struct commit_list **new_parents = &new_parents_head;
+
+	while (parent) {
+		struct commit *parent_commit = parent->item;
+		struct commit *new_parent;
+		struct recycle_parent_mapping *parent_mapping;
+
+		parent_mapping = oidmap_get(parents,
+					    &parent_commit->object.oid);
+
+		new_parent = parent_mapping ?
+				parent_mapping->new_parent :
+				parent_commit;
+
+		new_parents = commit_list_append(new_parent,
+						 new_parents);
+		parent = parent->next;
+	}
+
+	message = get_commit_buffer(orig_commit, &message_length);
+	author_raw = find_commit_header(message, "author", &author_length);
+	strbuf_add(&author, author_raw, author_length);
+	find_commit_subject(message, &body);
+	body_length = message_length - (body - message);
+
+	result = commit_tree(body, body_length,
+			     get_commit_tree_oid(orig_commit),
+			     new_parents_head, &new_commit_oid,
+			     author.buf, NULL);
+
+	if (result)
+		die("Could not create a recycled revision for %s\n",
+		    oid_to_hex(&orig_commit->object.oid));
+
+	new_commit = lookup_commit_or_die(&new_commit_oid,
+					  "new commit");
+
+	unuse_commit_buffer(orig_commit, message);
+	strbuf_release(&author);
+
+	return new_commit;
+}
+
+static void recycle_save_parent_mapping(struct oidmap *parents,
+					struct commit *old_parent,
+					struct commit *new_parent)
+{
+	struct recycle_parent_mapping *mapping;
+	mapping = xmalloc(sizeof(*mapping));
+	mapping->new_parent = new_parent;
+	mapping->e.oid = old_parent->object.oid;
+	oidmap_put(parents, mapping);
+}
+
+static struct commit *run_recycle(struct rebase_options *opts)
+{
+	struct rev_info revs;
+	struct commit *orig_head;
+	struct commit *new_head = NULL;
+	struct commit *commit;
+	struct commit_list *old_commits = NULL;
+	struct commit_list *old_commit;
+	struct oidmap parents;
+	struct progress *progress = NULL;
+	int commit_counter = 0;
+
+	init_revisions(&revs, NULL);
+	revs.commit_format = CMIT_FMT_RAW;
+	orig_head = lookup_commit_or_die(&opts->orig_head, "head");
+
+	opts->upstream->object.flags |= UNINTERESTING;
+	add_pending_object(&revs, &opts->upstream->object, "upstream");
+	add_pending_object(&revs, &orig_head->object, "head");
+
+	if (prepare_revision_walk(&revs))
+		die("Could not get commits to recycle");
+
+	while ((commit = get_revision(&revs)) != NULL)
+		commit_list_insert(commit, &old_commits);
+	sort_in_topological_order(&old_commits, REV_SORT_IN_GRAPH_ORDER);
+	old_commits = reverse_commit_list(old_commits);
+
+	oidmap_init(&parents, commit_list_count(old_commits) + 1);
+	recycle_save_parent_mapping(&parents, opts->upstream, opts->onto);
+
+	if (isatty(2)) {
+		start_delayed_progress(_("Recycling commits"),
+				       commit_list_count(old_commits));
+	}
+
+	old_commit = old_commits;
+	while (old_commit) {
+		display_progress(progress, ++commit_counter);
+		new_head = recycle_commit(old_commit->item, &parents);
+		recycle_save_parent_mapping(&parents, old_commit->item,
+					    new_head);
+		old_commit = old_commit->next;
+	}
+
+	stop_progress(&progress);
+
+	return new_head;
+}
+
+static void recycle_wrapup(struct rebase_options *opts,
+			   const char *branch_name, struct commit *new_head)
+{
+	struct strvec args = STRVEC_INIT;
+	if (opts->head_name) {
+		struct wt_status s = { 0 };
+
+		s.show_branch = 1;
+		wt_status_prepare(the_repository, &s);
+		wt_status_collect(&s);
+		if (!strcmp(s.branch, opts->head_name)) {
+			struct reset_head_opts ropts = { 0 };
+			struct strbuf msg = STRBUF_INIT;
+			strbuf_addf(&msg, "rebase recycle: "
+				    "moving to %s",
+				    oid_to_hex(&new_head->object.oid));
+			ropts.oid = &new_head->object.oid;
+			ropts.orig_head = &opts->orig_head,
+			ropts.flags = RESET_HEAD_HARD |
+				      RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+			ropts.head_msg = msg.buf;
+			ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
+			if (reset_head(the_repository, &ropts))
+				die(_("Could not reset"));
+			strbuf_release(&msg);
+		} else {
+			update_ref(NULL, opts->head_name,
+				   &new_head->object.oid, NULL,
+				   0, UPDATE_REFS_DIE_ON_ERR);
+
+			strvec_pushf(&args, "checkout");
+			strvec_pushf(&args, "--quiet");
+			strvec_pushf(&args, "%s", branch_name);
+
+			run_command_v_opt(args.v, RUN_GIT_CMD);
+			strvec_clear(&args);
+		}
+	} else {
+		strvec_pushf(&args, "checkout");
+		strvec_pushf(&args, "--quiet");
+		strvec_pushf(&args, "%s", oid_to_hex(&new_head->object.oid));
+
+		run_command_v_opt(args.v, RUN_GIT_CMD);
+		strvec_clear(&args);
+	}
+}
+
 static int rebase_config(const char *var, const char *value, void *data)
 {
 	struct rebase_options *opts = data;
@@ -1154,6 +1343,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 N_("automatically re-schedule any `exec` that fails")),
 		OPT_BOOL(0, "reapply-cherry-picks", &options.reapply_cherry_picks,
 			 N_("apply all changes, even those already present upstream")),
+		OPT_BIT(0, "recycle", &options.flags,
+			N_("Run a recycle, if possible. Fails otherwise."),
+			REBASE_RECYCLE_OR_FAIL),
+		OPT_BIT(0, "attempt-recycle", &options.flags,
+			N_("Run a recycle, if possible. Continue with other approaches if it can't be done."),
+			REBASE_ATTEMPT_RECYCLE),
 		OPT_END(),
 	};
 	int i;
@@ -1234,6 +1429,20 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("The --edit-todo action can only be used during "
 		      "interactive rebase."));
 
+	if (options.flags & (REBASE_RECYCLE_OR_FAIL | REBASE_ATTEMPT_RECYCLE)) {
+		if ((options.flags & (REBASE_RECYCLE_OR_FAIL | REBASE_ATTEMPT_RECYCLE)) ==
+		    (REBASE_RECYCLE_OR_FAIL | REBASE_ATTEMPT_RECYCLE))
+			die(_("Can't use both --recycle and --attempt-recycle."));
+		if (options.flags & REBASE_INTERACTIVE_EXPLICIT)
+			die(_("Can't use --recycle/--attempt-recycle with interactive mode."));
+		if (options.strategy) {
+			die(_("Can't specify a strategy when using --recycle/--atempt-recycle."));
+		}
+		if (options.signoff) {
+			die(_("Can't use --signoff with --recycle/--atempt-recycle"));
+		}
+	}
+
 	if (trace2_is_enabled()) {
 		if (is_merge(&options))
 			trace2_cmd_mode("interactive");
@@ -1761,6 +1970,25 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		diff_flush(&opts);
 	}
 
+	if (options.flags & (REBASE_ATTEMPT_RECYCLE |
+			     REBASE_RECYCLE_OR_FAIL)) {
+		if (can_recycle(&options)) {
+			struct commit *new_head = run_recycle(&options);
+			if (new_head) {
+				options.type = REBASE_RECYCLE;
+				printf(_("Recycled %s onto %s.\n"),
+					branch_name, options.onto_name);
+				recycle_wrapup(&options, branch_name,
+					       new_head);
+				ret = 0;
+				goto cleanup;
+			}
+		} else
+			printf(_("upstream and onto do not share the same tree. "
+				 "Can't run a recycle.\n"));
+		if (options.flags & REBASE_RECYCLE_OR_FAIL)
+			die(_("Recycle failed."));
+	}
 	if (is_merge(&options))
 		goto run_rebase;
 
-- 
2.35.1

This is the rebase-based implementation of my original
git replay concept.

Decided to change the name to "recycle" because there is already
code that relates to "replay" in rebase... and we are "recycling"
trees so the name sounds appropriate (but might consider other
proposals if they gather steam).

There are things that are missing like documentation
and I will gladly add them (along with correcting anything
coming from code review) if this feature is interesting enough
for inclusion in the main line.

Let me know!

PS Hope I am adding this side comment at the right place.
