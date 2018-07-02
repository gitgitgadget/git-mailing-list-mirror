Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 108401F516
	for <e@80x24.org>; Mon,  2 Jul 2018 09:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965032AbeGBJQt (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 05:16:49 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44973 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965025AbeGBJQq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 05:16:46 -0400
Received: by mail-pf0-f193.google.com with SMTP id j3-v6so7214483pfh.11
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 02:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sVrtbnNGbPZ6pjp7HSsAZ0CbYCGfae8kLAuD5DlKTr0=;
        b=Yhxs/i0bd1rJCq8u87n0Kzc1WsE9MMqfD+WqdB7sXGlaL0+OYcJgOYfpntFh7ecPjT
         EPQL+mEqhML22VwOeWtxE/ZiBfUo8i69lYXuOUXELMQaPWnioDw57yP9moi00YCJwvWw
         QfIcuZFSON5gI7XpddGX1WlrsY8wgyDLo2slQY4SmG4vCE5AUuofgo/kqqt7DmcceKQT
         mUxAomtEdqqg0hqUav2oXStnCK+VLF2wiBdlT58iP7L/BLzxBIlBUJsdV1YTn3l+Qhez
         EIK7xzCHpKlNfp//rLFX4kJNIxODVaINAi2au4lkmx4jPAdZJbu1AAKxIv6e289YdV+z
         cnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sVrtbnNGbPZ6pjp7HSsAZ0CbYCGfae8kLAuD5DlKTr0=;
        b=GmE6AXFnaj6kMjx0091deQSFhcp1em4nGUg7WqJuKlT7RBSxyNr90+2+UtSMi4hZ3+
         kYfQRJrthPvxVgoFKJ3inIWyiTn49QPHcjTWEFsl+PR1SeArgEBOSZRp0Aldxa4PI7ms
         6aB0cto9ZAarnGWP7/s2fPv6pk+uMceiyTW4AmJTT8zPRya3HcxpBoSJT17gDOGJcVEL
         MG4RK2jI3PP83M313jQXHOpxrByiLfuWXFica51xTtGaby7lyZc+5geRbr5M6Eehnbwo
         IGZSvZf/9W5AJU1S+w1yuTi9StikCCOecFK8RF5W/vPnUc6X1VR9lDNukvwQWpcH6I1o
         5k9g==
X-Gm-Message-State: APt69E2Q/7El+hgWgEjE6KU5J+OXKhj+DsfbiRn8n9BQGu204Laev5Sl
        DdhADVk/wxDr2WtKPAFyFEWnDQoC2gA=
X-Google-Smtp-Source: ADUXVKJw8iLIkzxlB49JwudJUZZlMF+1dR4hzqjfrGvXm4Xu5pZtucrkf9cgLsnke3+o5Ci/IaZN9Q==
X-Received: by 2002:a63:ae02:: with SMTP id q2-v6mr20882446pgf.189.1530523005606;
        Mon, 02 Jul 2018 02:16:45 -0700 (PDT)
Received: from localhost.localdomain ([27.34.68.63])
        by smtp.gmail.com with ESMTPSA id y2-v6sm35961795pfk.82.2018.07.02.02.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 02:16:44 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH v2 4/4] builtin/rebase: support running "git rebase <upstream>"
Date:   Mon,  2 Jul 2018 15:00:09 +0545
Message-Id: <20180702091509.15950-5-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702091509.15950-1-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com>
 <20180702091509.15950-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch gives life to the skeleton added in the previous patch.
This patch makes real operation happen i.e. by using
`git -c rebase.usebuiltin=true rebase <upstream>`.
With this patch, the basic operation of rebase can be done.

The current version of the builtin rebase does not, however, make full
use of the internals but instead chooses to spawn a couple of Git
processes, still, to make for an easier conversion. There remains a lot
of room for improvement, left later.

These backends use Unix shell functions defined both by git-sh-setup.sh
and git-rebase.sh (we move the latter's into git-rebase--common.sh to
accommodate for that), so we not only have to source the backend file
before calling the respective Unix shell script function, but we have
to source git-sh-setup and git-rebase--common before that.
And since this is all done in a Unix shell script snippet, all of this
is in argv[0]. There will be NULL argv[1] i.e. there are no further
arguments.

This patch does the *bare* minimum to get `git rebase <upstream>` to
work: there is still no option parsing, and only the bare minimum set
of environment variables are set (in particular, the current revision
would be susceptible to bugs where e.g. `rebase_root` could be set by
mistake before running `git rebase` and the `git-rebase--am` backend
would pick up that variable and use it).

It still calls original `git-legacy-rebase.sh` unless the config
setting rebase.useBuiltin is set to true. This patch uses the
detach_head_to() function from checkout.c introduced by a previous
commit to perform initial checkout.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 229 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 228 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c0c9d6cd2..dc6816e34 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -9,6 +9,19 @@
 #include "exec-cmd.h"
 #include "argv-array.h"
 #include "dir.h"
+#include "packfile.h"
+#include "checkout.h"
+#include "refs.h"
+
+static GIT_PATH_FUNC(apply_dir, "rebase-apply");
+static GIT_PATH_FUNC(merge_dir, "rebase-merge");
+
+enum rebase_type {
+	REBASE_AM,
+	REBASE_MERGE,
+	REBASE_INTERACTIVE,
+	REBASE_PRESERVE_MERGES
+};
 
 static int use_builtin_rebase(void)
 {
@@ -28,8 +41,129 @@ static int use_builtin_rebase(void)
 	return ret;
 }
 
+static int apply_autostash(void)
+{
+	warning("TODO");
+	return 0;
+}
+
+struct rebase_options {
+	enum rebase_type type;
+	const char *state_dir;
+	struct commit *upstream;
+	const char *upstream_name;
+	char *head_name;
+	struct object_id orig_head;
+	struct commit *onto;
+	const char *onto_name;
+	const char *revisions;
+	const char *root;
+};
+
+static int finish_rebase(struct rebase_options *opts)
+{
+	struct strbuf dir = STRBUF_INIT;
+	const char *argv_gc_auto[] = { "gc", "--auto", NULL };
+
+	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
+	apply_autostash();
+	close_all_packs(the_repository->objects);
+	/*
+	 * We ignore errors in 'gc --auto', since the
+	 * user should see them.
+	 */
+	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+	strbuf_addstr(&dir, opts->state_dir);
+	remove_dir_recursively(&dir, 0);
+	strbuf_release(&dir);
+
+	return 0;
+}
+
+static struct commit *peel_committish(const char *name)
+{
+	struct object *obj;
+	struct object_id oid;
+	if (get_oid(name, &oid))
+		return NULL;
+	obj = parse_object(&oid);
+	return (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
+}
+
+static int run_specific_rebase(struct rebase_options *opts)
+{
+	const char *argv[] = { NULL, NULL };
+	struct strbuf script_snippet = STRBUF_INIT;
+	struct argv_array env = ARGV_ARRAY_INIT;
+	int status;
+	const char *backend, *backend_func;
+
+	argv_array_pushf(&env, "upstream_name=%s", opts->upstream_name);
+	argv_array_pushf(&env, "GIT_DIR=%s", absolute_path(get_git_dir()));
+	argv_array_pushf(&env, "upstream=%s",
+				oid_to_hex(&opts->upstream->object.oid));
+	argv_array_pushf(&env, "orig_head=%s", oid_to_hex(&opts->orig_head));
+	argv_array_pushf(&env, "onto=%s",
+				oid_to_hex(&opts->onto->object.oid));
+	argv_array_pushf(&env, "onto_name=%s", opts->onto_name);
+	argv_array_pushf(&env, "revisions=%s", opts->revisions);
+
+	switch (opts->type) {
+		case REBASE_AM:
+			backend = "git-rebase--am";
+			backend_func = "git_rebase__am";
+			break;
+		case REBASE_INTERACTIVE:
+			backend = "git-rebase--interactive";
+			backend_func = "git_rebase__interactive";
+			break;
+		case REBASE_MERGE:
+			backend = "git-rebase--merge";
+			backend_func = "git_rebase__merge";
+			break;
+		case REBASE_PRESERVE_MERGES:
+			backend = "git-rebase--preserve-merges";
+			backend_func = "git_rebase__preserve_merges";
+			break;
+		default:
+			BUG("Unhandled rebase type %d", opts->type);
+			break;
+	}
+
+	strbuf_addf(&script_snippet,
+		    ". git-rebase--common && . %s && %s",
+		    backend, backend_func);
+	argv[0] = script_snippet.buf;
+
+	status = run_command_v_opt_cd_env(argv, RUN_USING_SHELL, NULL,
+					  env.argv);
+	if (status == 0)
+		finish_rebase(opts);
+	else if (status == 2) {
+		struct strbuf dir = STRBUF_INIT;
+
+		apply_autostash();
+		strbuf_addstr(&dir, opts->state_dir);
+		remove_dir_recursively(&dir, 0);
+		strbuf_release(&dir);
+		die("Nothing to do");
+	}
+
+	strbuf_release(&script_snippet);
+	argv_array_clear(&env);
+
+	return status ? -1 : 0;
+}
+
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
+	struct rebase_options options = { -1 };
+	const char *branch_name;
+	int ret, flags, quiet = 0;
+	struct strbuf msg = STRBUF_INIT;
+	struct strbuf revisions = STRBUF_INIT;
+	const char *restrict_revision = NULL;
+
 	/*
 	* NEEDSWORK: Once the builtin rebase has been tested enough
 	* and git-legacy-rebase.sh is retired to contrib/, this preamble
@@ -51,5 +185,98 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	trace_repo_setup(prefix);
 	setup_work_tree();
 
-	die("TODO");
+	options.type = REBASE_AM;
+
+	switch (options.type) {
+	case REBASE_AM:
+		options.state_dir = apply_dir();
+		break;
+	case REBASE_MERGE:
+	case REBASE_INTERACTIVE:
+	case REBASE_PRESERVE_MERGES:
+		options.state_dir = merge_dir();
+		break;
+	}
+	if (!options.root) {
+		if (argc != 2)
+			die("TODO: handle @{upstream}");
+		else {
+			options.upstream_name = argv[1];
+			argc--;
+			argv++;
+			if (!strcmp(options.upstream_name, "-"))
+				options.upstream_name = "@{-1}";
+		}
+		options.upstream = peel_committish(options.upstream_name);
+		if (!options.upstream)
+			die(_("invalid upstream '%s'"), options.upstream_name);
+	} else
+		die("TODO: upstream for --root");
+
+	/* Make sure the branch to rebase onto is valid. */
+	if (!options.onto_name)
+		options.onto_name = options.upstream_name;
+	if (strstr(options.onto_name, "...")) {
+		die("TODO");
+	} else {
+		options.onto = peel_committish(options.onto_name);
+		if (!options.onto)
+			die(_("Does not point to a valid commit '%s'"),
+				options.onto_name);
+	}
+
+	/*
+	* If the branch to rebase is given, that is the branch we will rebase
+	* branch_name -- branch/commit being rebased, or HEAD (already detached)
+	* orig_head -- commit object name of tip of the branch before rebasing
+	* head_name -- refs/heads/<that-branch> or "detached HEAD"
+	*/
+	if (argc > 1)
+		 die ("TODO: handle switch_to");
+	else {
+		/* Do not need to switch branches, we are already on it. */
+		options.head_name =
+			xstrdup_or_null(resolve_ref_unsafe("HEAD", 0, NULL,
+					 &flags));
+		if (!options.head_name)
+			die(_("No such ref: %s"), "HEAD");
+		if (flags & REF_ISSYMREF) {
+			if (!skip_prefix(options.head_name,
+					 "refs/heads/", &branch_name))
+				branch_name = options.head_name;
+
+		} else {
+			options.head_name = xstrdup("detached HEAD");
+			branch_name = "HEAD";
+		}
+		if (get_oid("HEAD", &options.orig_head))
+			die(_("Could not resolve HEAD to a revision"));
+	}
+
+	/* Detach HEAD and reset the tree */
+	if (!quiet)
+		printf("First, rewinding head to replay your work on top of it...");
+
+	strbuf_addf(&msg, "rebase: checkout %s", options.onto_name);
+	if (detach_head_to(&options.onto->object.oid, "checkout", msg.buf))
+		die(_("Could not detach HEAD"));
+	strbuf_release(&msg);
+	if (update_ref("rebase", "ORIG_HEAD", &options.orig_head, NULL, 0,
+		       UPDATE_REFS_MSG_ON_ERR) < 0)
+		die(_("Could not update ORIG_HEAD to '%s'"),
+		    oid_to_hex(&options.orig_head));
+
+	strbuf_addf(&revisions, "%s..%s",
+		!options.root ? oid_to_hex(&options.onto->object.oid) :
+		    (restrict_revision ? restrict_revision :
+			    oid_to_hex(&options.upstream->object.oid)),
+			    oid_to_hex(&options.orig_head));
+
+	options.revisions = revisions.buf;
+
+	ret = !!run_specific_rebase(&options);
+
+	strbuf_release(&revisions);
+	free(options.head_name);
+	return ret;
 }
-- 
2.18.0

