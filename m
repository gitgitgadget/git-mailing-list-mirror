Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B7611F453
	for <e@80x24.org>; Fri, 15 Feb 2019 04:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbfBOEbe (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 23:31:34 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43733 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387875AbfBOEbe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 23:31:34 -0500
Received: by mail-pf1-f202.google.com with SMTP id b8so6580589pfe.10
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 20:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PTHZOpQxOwF15L2Ft15KjpOZF8hSS+cliENOoYJAMEQ=;
        b=Vh23aKYam9Cthk5snOGZwD+yxEi9gIsBv83+ySfgm7Tr7vH+e1Q43Q4XgURj1tBEAc
         vgUP4K8e087sRTweY4hb2B+YoPG350+1e18tBEiMpvMsEFP3MrcSmAVUcvHC/fq6BZ9k
         65O+22S7g29RraRZitLfKgijebzPKwC+SQ1fpARXX22OP8O2RG2AtVvCKBPW7U23Atgn
         mnJutAiXEA2FF8B8zQ0esu7TtFY2L8Os/+VJqv78vJDFz1K8L8zwk7yFOV0aVpjRnJ/B
         gCcbDZXphQzmCimIBdAxdcPrJl9nys1YKQGGN3seFKCNRTGPppcOZxUQlkFI6FXCwYya
         FRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PTHZOpQxOwF15L2Ft15KjpOZF8hSS+cliENOoYJAMEQ=;
        b=BkmEWHBpj/JWBQsxkBH/uJ6d2O2kXVY1KsnbTMl7tKajLjL87HUsZZ1Qt/aA6g9clc
         nyIfG3mJnkJ2tz4RaOLEkIQ4ug37W+hR8uUR2oAU7w0V2SL/RJrik8FP/hZBTAVtHXQw
         X8RpA45beCqdRfHpe3277XdEuc9E2Az2DOnG0Te6Fuo55ZCmyt2e64cm44g4/BsDj6Fn
         bd7UoB2nuCFKHi1++K6BbOGhsWo5Aw6H4jnG8rbQNRDA0oSAT8PU2R0K7QeoeTmtWq/z
         tMD0wS67jSNRNm1QseOyo7A+tXIufOwHBbPGZhhbFhFcbFYsZT5nBBFKNBPXasXmL09n
         Lqvg==
X-Gm-Message-State: AHQUAuY6in6yCO3Pfvi4YkJhKRNkpVhmaEtX3nKIHq6ZDvuqpi/Lqpmx
        kuUcB4KYmA9CdhblHm0SHCGBwwsphaBFCv11Q7aVX0jXUfi9SgvGx7Fe91gJCAykO3OOFmoMbGD
        DGJCrJ69EAmsEfDl6FzQTapaFoDBbtAlq7rhLVGuu8Pw9ExP+15PYBQAosQ==
X-Google-Smtp-Source: AHgI3IY4FXuHgOqWwTBJJHeHXfyhzQdfqJt6Yknk1UFkRH29EUOi3bjNpU9fVK5l8RGOmse8uMt+HQ/aCc8=
X-Received: by 2002:aa7:8685:: with SMTP id d5mr2646332pfo.42.1550205092538;
 Thu, 14 Feb 2019 20:31:32 -0800 (PST)
Date:   Thu, 14 Feb 2019 20:31:04 -0800
In-Reply-To: <20190215043105.163688-1-sxenos@google.com>
Message-Id: <20190215043105.163688-7-sxenos@google.com>
Mime-Version: 1.0
References: <20190215043105.163688-1-sxenos@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH v5 7/8] evolve: implement the git change command
From:   sxenos@google.com
To:     git@vger.kernel.org
Cc:     Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Xenos <sxenos@google.com>

Implement the git change update command, which
are sufficient for constructing change graphs.

For example, to create a new change (a stable name) that refers to HEAD:

git change update -c HEAD

To record a rebase or amend in the change graph:

git change update -c <new_commit> -r <old_commit>

To record a cherry-pick in the change graph:

git change update -c <new_commit> -o <original_commit>

Signed-off-by: Stefan Xenos <sxenos@google.com>
---
 .gitignore       |   1 +
 Makefile         |   1 +
 builtin.h        |   1 +
 builtin/change.c | 195 +++++++++++++++++++++++++++++++++++++++++++++++
 git.c            |   1 +
 5 files changed, 199 insertions(+)
 create mode 100644 builtin/change.c

diff --git a/.gitignore b/.gitignore
index 7374587f9d..6c1384e4cb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -27,6 +27,7 @@
 /git-branch
 /git-bundle
 /git-cat-file
+/git-change
 /git-check-attr
 /git-check-ignore
 /git-check-mailmap
diff --git a/Makefile b/Makefile
index 38f2592ec6..ad65b4f8fd 100644
--- a/Makefile
+++ b/Makefile
@@ -1055,6 +1055,7 @@ BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
 BUILTIN_OBJS += builtin/bundle.o
 BUILTIN_OBJS += builtin/cat-file.o
+BUILTIN_OBJS += builtin/change.o
 BUILTIN_OBJS += builtin/check-attr.o
 BUILTIN_OBJS += builtin/check-ignore.o
 BUILTIN_OBJS += builtin/check-mailmap.o
diff --git a/builtin.h b/builtin.h
index 6538932e99..d2d39d9da8 100644
--- a/builtin.h
+++ b/builtin.h
@@ -137,6 +137,7 @@ extern int cmd_blame(int argc, const char **argv, const char *prefix);
 extern int cmd_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_bundle(int argc, const char **argv, const char *prefix);
 extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
+extern int cmd_change(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 extern int cmd_check_attr(int argc, const char **argv, const char *prefix);
diff --git a/builtin/change.c b/builtin/change.c
new file mode 100644
index 0000000000..807d148805
--- /dev/null
+++ b/builtin/change.c
@@ -0,0 +1,195 @@
+#include "builtin.h"
+#include "ref-filter.h"
+#include "parse-options.h"
+#include "metacommit.h"
+#include "change-table.h"
+#include "config.h"
+
+static const char * const builtin_change_usage[] = {
+	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
+	NULL
+};
+
+static const char * const builtin_update_usage[] = {
+	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
+	NULL
+};
+
+struct update_state {
+	int options;
+	const char* change;
+	const char* content;
+	struct string_list replace;
+	struct string_list origin;
+};
+
+static void init_update_state(struct update_state *state)
+{
+	memset(state, 0, sizeof(*state));
+	state->content = "HEAD";
+	string_list_init(&state->replace, 0);
+	string_list_init(&state->origin, 0);
+}
+
+static void clear_update_state(struct update_state *state)
+{
+	string_list_clear(&state->replace, 0);
+	string_list_clear(&state->origin, 0);
+}
+
+static int update_option_parse_replace(const struct option *opt,
+							const char *arg, int unset)
+{
+	struct update_state *state = opt->value;
+	string_list_append(&state->replace, arg);
+	return 0;
+}
+
+static int update_option_parse_origin(const struct option *opt,
+							const char *arg, int unset)
+{
+	struct update_state *state = opt->value;
+	string_list_append(&state->origin, arg);
+	return 0;
+}
+
+static int resolve_commit(const char *committish, struct object_id *result)
+{
+	struct commit *commit;
+	if (get_oid_committish(committish, result))
+		die(_("Failed to resolve '%s' as a valid revision."), committish);
+	commit = lookup_commit_reference(the_repository, result);
+	if (!commit)
+		die(_("Could not parse object '%s'."), committish);
+	oidcpy(result, &commit->object.oid);
+	return 0;
+}
+
+static void resolve_commit_list(const struct string_list *commitsish_list,
+	struct oid_array* result)
+{
+	int i;
+	for (i = 0; i < commitsish_list->nr; i++) {
+		struct string_list_item *item = &commitsish_list->items[i];
+		struct object_id next;
+		resolve_commit(item->string, &next);
+		oid_array_append(result, &next);
+	}
+}
+
+/*
+ * Given the command-line options for the update command, fills in a
+ * metacommit_data with the corresponding changes.
+ */
+static void get_metacommit_from_command_line(
+	const struct update_state* commands, struct metacommit_data *result)
+{
+	resolve_commit(commands->content, &(result->content));
+	resolve_commit_list(&(commands->replace), &(result->replace));
+	resolve_commit_list(&(commands->origin), &(result->origin));
+}
+
+static int perform_update(
+	struct repository *repo,
+	const struct update_state *state,
+	struct strbuf *err)
+{
+	struct metacommit_data metacommit;
+	struct change_table chtable;
+	struct string_list changes;
+	int ret;
+	int i;
+
+	change_table_init(&chtable);
+	change_table_add_all_visible(&chtable, repo);
+	string_list_init(&changes, 1);
+
+	init_metacommit_data(&metacommit);
+
+	get_metacommit_from_command_line(state, &metacommit);
+
+	ret = record_metacommit_withresult(repo, &chtable, &metacommit, state->change,
+		state->options, err, &changes);
+
+	for (i = 0; i < changes.nr; i++) {
+		struct string_list_item *it = &changes.items[i];
+
+		if (it->util)
+			fprintf(stdout, N_("Updated change %s\n"), it->string);
+		else
+			fprintf(stdout, N_("Created change %s\n"), it->string);
+	}
+
+	string_list_clear(&changes, 0);
+	change_table_clear(&chtable);
+	clear_metacommit_data(&metacommit);
+
+	return ret;
+}
+
+static int change_update(int argc, const char **argv, const char* prefix)
+{
+	int result;
+	int force = 0;
+	int newchange = 0;
+	struct strbuf err = STRBUF_INIT;
+	struct update_state state;
+	struct option options[] = {
+		{ OPTION_CALLBACK, 'r', "replace", &state, N_("commit"),
+			N_("marks the given commit as being obsolete"),
+			0, update_option_parse_replace },
+		{ OPTION_CALLBACK, 'o', "origin", &state, N_("commit"),
+			N_("marks the given commit as being the origin of this commit"),
+			0, update_option_parse_origin },
+		OPT_BOOL('F', "force", &force,
+			N_("overwrite an existing change of the same name")),
+		OPT_STRING('c', "content", &state.content, N_("commit"),
+				 N_("identifies the new content commit for the change")),
+		OPT_STRING('g', "change", &state.change, N_("commit"),
+				 N_("name of the change to update")),
+		OPT_BOOL('n', "new", &newchange,
+			N_("create a new change - do not append to any existing change")),
+		OPT_END()
+	};
+
+	init_update_state(&state);
+
+	argc = parse_options(argc, argv, prefix, options, builtin_update_usage, 0);
+
+	if (force) state.options |= UPDATE_OPTION_FORCE;
+	if (newchange) state.options |= UPDATE_OPTION_NOAPPEND;
+
+	result = perform_update(the_repository, &state, &err);
+
+	if (result < 0) {
+		error("%s", err.buf);
+		strbuf_release(&err);
+	}
+
+	clear_update_state(&state);
+
+	return result;
+}
+
+int cmd_change(int argc, const char **argv, const char *prefix)
+{
+	/* No options permitted before subcommand currently */
+	struct option options[] = {
+		OPT_END()
+	};
+	int result = 1;
+
+	argc = parse_options(argc, argv, prefix, options, builtin_change_usage,
+		PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc < 1)
+		usage_with_options(builtin_change_usage, options);
+	else if (!strcmp(argv[0], "update"))
+		result = change_update(argc, argv, prefix);
+	else {
+		error(_("Unknown subcommand: %s"), argv[0]);
+		usage_with_options(builtin_change_usage, options);
+	}
+
+	return result ? 1 : 0;
+}
diff --git a/git.c b/git.c
index 2dd588674f..33e3a04395 100644
--- a/git.c
+++ b/git.c
@@ -453,6 +453,7 @@ static struct cmd_struct commands[] = {
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "cat-file", cmd_cat_file, RUN_SETUP },
+	{ "change", cmd_change, RUN_SETUP },
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
 	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
 	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
-- 
2.21.0.rc0.258.g878e2cd30e-goog

