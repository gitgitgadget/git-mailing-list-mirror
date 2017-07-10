Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F32520357
	for <e@80x24.org>; Mon, 10 Jul 2017 22:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755072AbdGJWyn (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 18:54:43 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35499 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755057AbdGJWyl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 18:54:41 -0400
Received: by mail-pg0-f68.google.com with SMTP id d193so14321373pgc.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 15:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AiEKA+QB99yMyK2SVmg0SfQPpQVHgo3QSa0VOIGe1b8=;
        b=EuzCPoGLU9hh2t5F69uLu1CE0oknnKuJ4RRrs7avcmJNy9OHWqfTZQwLeOLIvyK8De
         B9/1lY4+xmktxS+oqNLsS+r7yORv+65Q3zF45H/iFeFJjE1bfePw5oSh/JvfGMCkBJ7f
         gmzV+JiFXAzitTn83BycmNzcoG6pkjC6nuJtfEUM850wYcgvBIsyWnzHTA1VhiJ71gYd
         FuZdaRwtCbxjFq2FFtej5zP4dEyEDVfuCRynqdDSX5tns77faQ1cIxKEf1BRJSlcu3zE
         1MPnNEnTNBctZrtX0K/vFbeKJVh+NudPsI2s5kucFH9Y2eDwyWqI9XEmp3TeOyvj06a8
         2lbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AiEKA+QB99yMyK2SVmg0SfQPpQVHgo3QSa0VOIGe1b8=;
        b=k5HsG/iWOEsoFzMwYZ20k0P3alrO18JmlTPoeaLUEQcNHeqjTHq+VbNxWLmfgAEa7E
         mO0HFq8OlNygCx/WiN62U0GrbIn0nCozUkOIWUqFECdKY5ndnSzrDWcOgNVAjJm5APWy
         iiX53cwsohZSjlhfOhk/Jqef6Q7uuVD6r4kmbGlmV+pRde2kZ6WwHPrIbERzxUzS1jzm
         81OmxV2LZKY8wPa9RzGIpgaT3xW1xTt8sKgvUNFx7rcdN1FUr4/lZ3Le2S4jsWm90TVS
         GAjf94v06VrdOBNuT3TvBAJiwf+7ZPNl0WuodP4DT8IQgFRjLIDhUycgMWtqbBEgdb1i
         pttg==
X-Gm-Message-State: AIVw1136+5Xecpvwzcccs3wZbo4XTqWEZzpL5oqhQpSH6uV8POhapM/i
        MwcQ2yma75JFleOk
X-Received: by 10.84.217.139 with SMTP id p11mr21195485pli.214.1499727280138;
        Mon, 10 Jul 2017 15:54:40 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id o6sm20586774pgs.43.2017.07.10.15.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 15:54:39 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 8/8] submodule: port submodule subcommand 'summary' from shell to C
Date:   Tue, 11 Jul 2017 04:24:07 +0530
Message-Id: <20170710225407.29344-8-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170710225407.29344-1-pc44800@gmail.com>
References: <CAME+mvU_8-S4AhTtMYm1L6PK81v23wu4EuB+EnOgkDhi=jo9Rg@mail.gmail.com>
 <20170710225407.29344-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule subcommand 'summary' is ported in the process of
making git-submodule a builtin. The function cmd_summary() from
git-submodule.sh is ported to functions module_summary(),
compute_summary_module_list(), prepare_submodule_summary() and
print_submodule_summary().

The first function module_summary() parses the options of submodule
subcommand and also acts as the front-end of this subcommand.
After parsing them, it calls the compute_summary_module_list()

The functions compute_summary_module_list() runs the diff_cmd,
and generates the modules list, as required by the subcommand.
The generation of this module list is done by the using the
callback function submodule_summary_callback(), and stored in the
structure module_cb.

Once the module list is generated, prepare_submodule_summary()
further goes through the list and filters the list, for
eventually calling the print_submodule_summary() function.

Finally, the print_submodule_summary() takes care of generating
and printing the summary for each submodule.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
This is the first version of submodule-summary posted on the mailing list.

This patch has previously being reviewed off the mailing list as well, and
following are the changes made after the previous update:

An initial check for is_sm_git_dir is added.

Instead of changing the dir to sm_path in a child_process, now we instead
are adding the env_variable GIT_DIR. This helped in avoiding the usage of
shell in the child_process as well for getting all the tests cleared
from t7508-status.

Also, the sentences which earlier were translated unnecessarily were
changed for getting all the test cleared with the env_variable
GETTEXT_POISON, out of which 13 test from t7401-submodule-summary
failed earlier.

Still I'm looking into a better way for generating the abbrevation of
sha1_src and sha1_dst.

Complete build report of this series is available at:
https://travis-ci.org/pratham-pc/git/builds/
Branch: week-8
Build #129

 builtin/submodule--helper.c | 466 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 182 +----------------
 2 files changed, 467 insertions(+), 181 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 05d430846..1dc53c2b2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -13,6 +13,9 @@
 #include "remote.h"
 #include "refs.h"
 #include "connect.h"
+#include "revision.h"
+#include "diffcore.h"
+#include "diff.h"
 
 typedef void (*submodule_list_func_t)(const struct cache_entry *list_item,
 				      void *cb_data);
@@ -767,6 +770,468 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct module_cb {
+	unsigned int mod_src;
+	unsigned int mod_dst;
+	struct object_id oid_src;
+	struct object_id oid_dst;
+	char status;
+	const char *sm_path;
+};
+#define MODULE_CB_INIT { 0, 0, NULL, NULL, '\0', NULL }
+
+struct module_cb_list {
+	struct module_cb **entries;
+	int alloc, nr;
+};
+#define MODULE_CB_LIST_INIT { NULL, 0, 0 }
+
+struct summary_cb {
+	int argc;
+	const char **argv;
+	const char *prefix;
+	char *diff_cmd;
+	unsigned int cached: 1;
+	unsigned int for_status: 1;
+	unsigned int quiet: 1;
+	unsigned int files: 1;
+	int summary_limits;
+};
+#define SUMMARY_CB_INIT { 0, NULL, NULL, NULL, 0, 0, 0, 0, 0 }
+
+static void print_submodule_summary(struct summary_cb *info,
+				    struct module_cb *p)
+{
+	int missing_src = 0;
+	int missing_dst = 0;
+	char *displaypath;
+	char *sha1_abbr_src;
+	char *sha1_abbr_dst;
+	int errmsg = 0;
+	int total_commits = -1;
+	struct strbuf sb_sha1_src = STRBUF_INIT;
+	struct strbuf sb_sha1_dst = STRBUF_INIT;
+	char *sha1_dst = oid_to_hex(&p->oid_dst);
+	char *sha1_src = oid_to_hex(&p->oid_src);
+	char *sm_git_dir = xstrfmt("%s/.git", p->sm_path);
+	int is_sm_git_dir = 0;
+
+	if (!info->cached && !strcmp(sha1_dst, sha1_to_hex(null_sha1))) {
+		if (S_ISGITLINK(p->mod_dst)) {
+			struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
+			struct strbuf sb_rev_parse = STRBUF_INIT;
+
+			cp_rev_parse.git_cmd = 1;
+			cp_rev_parse.no_stderr = 1;
+
+			argv_array_pushf(&cp_rev_parse.env_array,
+					 "GIT_DIR=%s/.git", p->sm_path);
+			argv_array_pushl(&cp_rev_parse.args,
+					 "rev-parse", "HEAD", NULL);
+			if (!capture_command(&cp_rev_parse, &sb_rev_parse, 0)) {
+				strbuf_strip_suffix(&sb_rev_parse, "\n");
+				sha1_dst = xstrdup(sb_rev_parse.buf);
+			}
+			strbuf_release(&sb_rev_parse);
+		} else if (S_ISLNK(p->mod_dst) || S_ISREG(p->mod_dst)) {
+			struct child_process cp_hash_object = CHILD_PROCESS_INIT;
+			struct strbuf sb_hash_object = STRBUF_INIT;
+
+			cp_hash_object.git_cmd = 1;
+			argv_array_pushl(&cp_hash_object.args,
+					 "hash-object", p->sm_path,
+					 NULL);
+			if (!capture_command(&cp_hash_object,
+					     &sb_hash_object, 0)) {
+				strbuf_strip_suffix(&sb_hash_object, "\n");
+				sha1_dst = xstrdup(sb_hash_object.buf);
+			}
+			strbuf_release(&sb_hash_object);
+		} else {
+			if (p->mod_dst != 0)
+				die(_("unexpected mode %d\n"), p->mod_dst);
+		}
+	}
+
+	if (is_git_directory(sm_git_dir))
+		is_sm_git_dir = 1;
+
+	if (is_sm_git_dir && S_ISGITLINK(p->mod_src)) {
+		struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
+
+		cp_rev_parse.git_cmd = 1;
+		cp_rev_parse.no_stdout = 1;
+
+		argv_array_pushf(&cp_rev_parse.env_array, "GIT_DIR=%s/.git",
+				 p->sm_path);
+		argv_array_pushl(&cp_rev_parse.args, "rev-parse", "-q",
+				 "--verify", NULL);
+		argv_array_pushf(&cp_rev_parse.args, "%s^0", sha1_src);
+
+		if (run_command(&cp_rev_parse))
+			missing_src = 1;
+	}
+
+	if (is_sm_git_dir && S_ISGITLINK(p->mod_dst)) {
+		struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
+
+		cp_rev_parse.git_cmd = 1;
+		cp_rev_parse.no_stdout = 1;
+
+		argv_array_pushf(&cp_rev_parse.env_array, "GIT_DIR=%s/.git",
+				 p->sm_path);
+		argv_array_pushl(&cp_rev_parse.args, "rev-parse", "-q",
+				 "--verify", NULL);
+		argv_array_pushf(&cp_rev_parse.args, "%s^0", sha1_dst);
+
+		if (run_command(&cp_rev_parse))
+			missing_dst = 1;
+	}
+
+	displaypath = get_submodule_displaypath(p->sm_path, info->prefix);
+
+	if (!missing_dst && !missing_src) {
+		if (is_sm_git_dir) {
+			struct child_process cp_rev_list = CHILD_PROCESS_INIT;
+			struct strbuf sb_rev_list = STRBUF_INIT;
+			const char *range;
+
+			if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst))
+				range = xstrfmt("%s...%s", sha1_src, sha1_dst);
+			else if (S_ISGITLINK(p->mod_src))
+				range = xstrdup(sha1_src);
+			else
+				range = xstrdup(sha1_dst);
+
+			cp_rev_list.git_cmd = 1;
+			argv_array_pushf(&cp_rev_list.env_array,
+					 "GIT_DIR=%s/.git", p->sm_path);
+			argv_array_pushl(&cp_rev_list.args, "rev-list",
+					 "--first-parent", range, "--", NULL);
+			if (!capture_command(&cp_rev_list, &sb_rev_list, 0)) {
+				if (sb_rev_list.len)
+					total_commits = count_lines(sb_rev_list.buf,
+								    sb_rev_list.len);
+				else
+					total_commits = 0;
+			}
+			strbuf_release(&sb_rev_list);
+		}
+	} else {
+		errmsg = 1;
+	}
+
+	strbuf_addstr(&sb_sha1_src, sha1_src);
+	strbuf_addstr(&sb_sha1_dst, sha1_dst);
+
+	strbuf_remove(&sb_sha1_src, 7, 33);
+	strbuf_remove(&sb_sha1_dst, 7, 33);
+
+	sha1_abbr_src = strbuf_detach(&sb_sha1_src, NULL);
+	sha1_abbr_dst = strbuf_detach(&sb_sha1_dst, NULL);
+
+	if (p->status == 'T') {
+		if (S_ISGITLINK(p->mod_dst)) {
+			if (total_commits < 0)
+				printf(_("* %s %s(blob)->%s(submodule):\n"),
+					 displaypath, sha1_abbr_src,
+					 sha1_abbr_dst);
+			else
+				printf(_("* %s %s(blob)->%s(submodule) (%d):\n"),
+					 displaypath, sha1_abbr_src,
+					 sha1_abbr_dst, total_commits);
+		} else {
+			if (total_commits < 0)
+				printf(_("* %s %s(submodule)->%s(blob):\n"),
+					 displaypath, sha1_abbr_src,
+					 sha1_abbr_dst);
+			else
+				printf(_("* %s %s(submodule)->%s(blob) (%d):\n"),
+					 displaypath, sha1_abbr_src,
+					 sha1_abbr_dst, total_commits);
+		}
+	} else {
+		if (total_commits < 0)
+			printf("* %s %s...%s:\n", displaypath, sha1_abbr_src,
+				 sha1_abbr_dst);
+		else
+			printf("* %s %s...%s (%d):\n", displaypath,
+				 sha1_abbr_src, sha1_abbr_dst, total_commits);
+	}
+
+	if (errmsg) {
+		/*
+		 * Don't give error msg for modification whose dst is not
+		 * submodule, i.e. deleted or changed to blob
+		 */
+		if (S_ISGITLINK(p->mod_src)) {
+			if (missing_src && missing_dst) {
+				printf(_("  Warn: %s doesn't contain commits %s and %s\n"),
+				 displaypath, sha1_src, sha1_dst);
+			} else if (missing_src) {
+				printf(_("  Warn: %s doesn't contain commit %s\n"),
+				 displaypath, sha1_src);
+			} else {
+				printf(_("  Warn: %s doesn't contain commit %s\n"),
+				 displaypath, sha1_dst);
+			}
+		}
+
+	} else if (is_sm_git_dir) {
+		if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst)) {
+			struct child_process cp_log = CHILD_PROCESS_INIT;
+			char *limit = NULL;
+
+			if (info->summary_limits > 0)
+				limit = xstrfmt("-%d", info->summary_limits);
+
+			cp_log.git_cmd = 1;
+
+			argv_array_pushf(&cp_log.env_array, "GIT_DIR=%s/.git",
+					 p->sm_path);
+			argv_array_pushl(&cp_log.args, "log", NULL);
+			if (limit)
+				argv_array_push(&cp_log.args, limit);
+			argv_array_pushl(&cp_log.args, "--pretty=  %m %s",
+					 "--first-parent", NULL);
+			argv_array_pushf(&cp_log.args, "%s...%s", sha1_src,
+					 sha1_dst);
+
+			run_command(&cp_log);
+
+		} else if (S_ISGITLINK(p->mod_dst)) {
+			struct child_process cp_log = CHILD_PROCESS_INIT;
+
+			cp_log.git_cmd = 1;
+			argv_array_pushf(&cp_log.env_array, "GIT_DIR=%s/.git",
+					 p->sm_path);
+			argv_array_pushl(&cp_log.args, "log",
+					 "--pretty=  > %s", "-1",
+					 sha1_dst, NULL);
+
+			run_command(&cp_log);
+		} else {
+			struct child_process cp_log = CHILD_PROCESS_INIT;
+
+			cp_log.git_cmd = 1;
+			argv_array_pushf(&cp_log.env_array, "GIT_DIR=%s/.git",
+					 p->sm_path);
+			argv_array_pushl(&cp_log.args, "log",
+					 "--pretty=  < %s",
+					 "-1", sha1_src, NULL);
+
+			run_command(&cp_log);
+		}
+	}
+	printf("\n");
+}
+
+static void prepare_submodule_summary(struct summary_cb *info,
+				      struct module_cb_list *list)
+{
+	int i;
+	for (i = 0; i < list->nr; i++) {
+		struct module_cb *p = list->entries[i];
+		struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
+
+		if (p->status == 'D' || p->status == 'T') {
+			print_submodule_summary(info, p);
+			continue;
+		}
+
+		if (info->for_status) {
+			char *config_key;
+			const char *ignore_config = "none";
+			const char *value;
+			const struct submodule *sub = submodule_from_path(null_sha1, p->sm_path);
+
+			if (sub) {
+				config_key = xstrfmt("submodule.%s.ignore",
+						     sub->name);
+				if (!git_config_get_value(config_key, &value))
+					ignore_config = value;
+				else if (sub->ignore)
+					ignore_config = sub->ignore;
+
+				if (p->status != 'A' && !strcmp(ignore_config,
+								"all"))
+					continue;
+			}
+		}
+
+		/* Also show added or modified modules which are checked out */
+		cp_rev_parse.dir = p->sm_path;
+		cp_rev_parse.git_cmd = 1;
+		cp_rev_parse.no_stderr = 1;
+		cp_rev_parse.no_stdout = 1;
+
+		argv_array_pushl(&cp_rev_parse.args, "rev-parse",
+				 "--git-dir", NULL);
+
+		if (!run_command(&cp_rev_parse))
+			print_submodule_summary(info, p);
+	}
+}
+
+static void submodule_summary_callback(struct diff_queue_struct *q,
+				       struct diff_options *options,
+				       void *data)
+{
+	int i;
+	struct module_cb_list *list = data;
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		struct module_cb *temp;
+
+		if (!S_ISGITLINK(p->one->mode) && !S_ISGITLINK(p->two->mode))
+			continue;
+		temp = (struct module_cb*)malloc(sizeof(struct module_cb));
+		temp->mod_src = p->one->mode;
+		temp->mod_dst = p->two->mode;
+		temp->oid_src = p->one->oid;
+		temp->oid_dst = p->two->oid;
+		temp->status = p->status;
+		temp->sm_path = xstrdup(p->one->path);
+
+		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
+		list->entries[list->nr++] = temp;
+	}
+}
+
+static int compute_summary_module_list(char *head, struct summary_cb *info)
+{
+	struct argv_array diff_args = ARGV_ARRAY_INIT;
+	struct rev_info rev;
+	struct module_cb_list list = MODULE_CB_LIST_INIT;
+
+	argv_array_push(&diff_args, info->diff_cmd);
+	if (info->cached)
+		argv_array_push(&diff_args, "--cached");
+	argv_array_pushl(&diff_args, "--ignore-submodules=dirty", "--raw",
+			 NULL);
+	if (head)
+		argv_array_push(&diff_args, head);
+	argv_array_push(&diff_args, "--");
+	if (info->argc)
+		argv_array_pushv(&diff_args, info->argv);
+
+	git_config(git_diff_basic_config, NULL);
+	init_revisions(&rev, info->prefix);
+	gitmodules_config();
+	rev.abbrev = 0;
+	precompose_argv(diff_args.argc, diff_args.argv);
+
+	diff_args.argc = setup_revisions(diff_args.argc, diff_args.argv,
+					 &rev, NULL);
+	rev.diffopt.output_format = DIFF_FORMAT_NO_OUTPUT | DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = submodule_summary_callback;
+	rev.diffopt.format_callback_data = &list;
+
+	if (!info->cached) {
+		if (!strcmp(info->diff_cmd, "diff-index"))
+			setup_work_tree();
+		if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
+			perror("read_cache_preload");
+			return -1;
+		}
+	} else if (read_cache() < 0) {
+		perror("read_cache");
+		return -1;
+	}
+
+	if (!strcmp(info->diff_cmd, "diff-index"))
+		run_diff_index(&rev, info->cached);
+	else
+		run_diff_files(&rev, 0);
+	prepare_submodule_summary(info, &list);
+	return 0;
+
+}
+
+static int module_summary(int argc, const char **argv, const char *prefix)
+{
+	struct summary_cb info = SUMMARY_CB_INIT;
+	int cached = 0;
+	char *diff_cmd = "diff-index";
+	int for_status = 0;
+	int quiet = 0;
+	int files = 0;
+	int summary_limits = -1;
+	char *head = NULL;
+	struct child_process cp_rev = CHILD_PROCESS_INIT;
+	struct strbuf sb_rev = STRBUF_INIT;
+
+	struct option module_summary_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
+		OPT_BOOL(0, "cached", &cached, N_("Use the commit stored in the index instead of the submodule HEAD")),
+		OPT_BOOL(0, "files", &files, N_("To compares the commit in the index with that in the submodule HEAD")),
+		OPT_BOOL(0, "for-status", &for_status, N_("Skip submodules with 'all' ignore_config value")),
+		OPT_INTEGER('n', "summary-limits", &summary_limits, N_("Limit the summary size")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper summary [<options>] [--] [<path>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_summary_options,
+			     git_submodule_helper_usage, 0);
+
+	if (!summary_limits)
+		return 0;
+
+	cp_rev.git_cmd = 1;
+	argv_array_pushl(&cp_rev.args, "rev-parse", "-q", "--verify",
+			 NULL);
+	if (argc)
+		argv_array_push(&cp_rev.args, argv[0]);
+	else
+		argv_array_pushl(&cp_rev.args, "HEAD", NULL);
+
+	if (!capture_command(&cp_rev, &sb_rev, 0)) {
+		strbuf_strip_suffix(&sb_rev, "\n");
+		head = xstrdup(sb_rev.buf);
+		if (argc) {
+			argv++;
+			argc--;
+		}
+		strbuf_release(&sb_rev);
+	} else if (!argc || !strcmp(argv[0], "HEAD")) {
+		/* before the first commit: compare with an empty tree */
+		struct stat st;
+		unsigned char sha1[20];
+		if (fstat(0, &st) < 0 || index_fd(sha1, 0, &st, 2, prefix, 3))
+			die("Unable to add %s to database", sha1);
+		head = sha1_to_hex(sha1);
+		if (argc) {
+			argv++;
+			argc--;
+		}
+	} else {
+		head = "HEAD";
+	}
+
+	if (files) {
+		if (cached)
+			die(_("The --cached option cannot be used with the --files option"));
+		diff_cmd = "diff-files";
+		head = NULL;
+	}
+
+	info.argc = argc;
+	info.argv = argv;
+	info.prefix = prefix;
+	info.cached = cached;
+	info.for_status = for_status;
+	info.quiet = quiet;
+	info.files = files;
+	info.summary_limits = summary_limits;
+	info.diff_cmd = diff_cmd;
+
+	return compute_summary_module_list(head, &info);
+}
+
 struct sync_cb {
 	const char *prefix;
 	unsigned int quiet: 1;
@@ -1782,6 +2247,7 @@ static struct cmd_struct commands[] = {
 	{"print-default-remote", print_default_remote, 0},
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
 	{"deinit", module_deinit, SUPPORT_SUPER_PREFIX},
+	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 73e6f093f..a427ddafd 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -51,31 +51,6 @@ die_if_unmatched ()
 	fi
 }
 
-#
-# Print a submodule configuration setting
-#
-# $1 = submodule name
-# $2 = option name
-# $3 = default value
-#
-# Checks in the usual git-config places first (for overrides),
-# otherwise it falls back on .gitmodules.  This allows you to
-# distribute project-wide defaults in .gitmodules, while still
-# customizing individual repositories if necessary.  If the option is
-# not in .gitmodules either, print a default value.
-#
-get_submodule_config () {
-	name="$1"
-	option="$2"
-	default="$3"
-	value=$(git config submodule."$name"."$option")
-	if test -z "$value"
-	then
-		value=$(git config -f .gitmodules submodule."$name"."$option")
-	fi
-	printf '%s' "${value:-$default}"
-}
-
 isnumber()
 {
 	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
@@ -755,163 +730,8 @@ cmd_summary() {
 		shift
 	done
 
-	test $summary_limit = 0 && return
-
-	if rev=$(git rev-parse -q --verify --default HEAD ${1+"$1"})
-	then
-		head=$rev
-		test $# = 0 || shift
-	elif test -z "$1" || test "$1" = "HEAD"
-	then
-		# before the first commit: compare with an empty tree
-		head=$(git hash-object -w -t tree --stdin </dev/null)
-		test -z "$1" || shift
-	else
-		head="HEAD"
-	fi
-
-	if [ -n "$files" ]
-	then
-		test -n "$cached" &&
-		die "$(gettext "The --cached option cannot be used with the --files option")"
-		diff_cmd=diff-files
-		head=
-	fi
-
-	cd_to_toplevel
-	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
-	# Get modified modules cared by user
-	modules=$(git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- "$@" |
-		sane_egrep '^:([0-7]* )?160000' |
-		while read -r mod_src mod_dst sha1_src sha1_dst status sm_path
-		do
-			# Always show modules deleted or type-changed (blob<->module)
-			if test "$status" = D || test "$status" = T
-			then
-				printf '%s\n' "$sm_path"
-				continue
-			fi
-			# Respect the ignore setting for --for-status.
-			if test -n "$for_status"
-			then
-				name=$(git submodule--helper name "$sm_path")
-				ignore_config=$(get_submodule_config "$name" ignore none)
-				test $status != A && test $ignore_config = all && continue
-			fi
-			# Also show added or modified modules which are checked out
-			GIT_DIR="$sm_path/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
-			printf '%s\n' "$sm_path"
-		done
-	)
-
-	test -z "$modules" && return
-
-	git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- $modules |
-	sane_egrep '^:([0-7]* )?160000' |
-	cut -c2- |
-	while read -r mod_src mod_dst sha1_src sha1_dst status name
-	do
-		if test -z "$cached" &&
-			test $sha1_dst = 0000000000000000000000000000000000000000
-		then
-			case "$mod_dst" in
-			160000)
-				sha1_dst=$(GIT_DIR="$name/.git" git rev-parse HEAD)
-				;;
-			100644 | 100755 | 120000)
-				sha1_dst=$(git hash-object $name)
-				;;
-			000000)
-				;; # removed
-			*)
-				# unexpected type
-				eval_gettextln "unexpected mode \$mod_dst" >&2
-				continue ;;
-			esac
-		fi
-		missing_src=
-		missing_dst=
-
-		test $mod_src = 160000 &&
-		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null &&
-		missing_src=t
-
-		test $mod_dst = 160000 &&
-		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_dst^0 >/dev/null &&
-		missing_dst=t
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper summary ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} ${for_status:+--for-status} ${files:+--files} ${cached:+--cached} ${summary_limit:+-n $summary_limit} "$@"
 
-		display_name=$(git submodule--helper relative-path "$name" "$wt_prefix")
-
-		total_commits=
-		case "$missing_src,$missing_dst" in
-		t,)
-			errmsg="$(eval_gettext "  Warn: \$display_name doesn't contain commit \$sha1_src")"
-			;;
-		,t)
-			errmsg="$(eval_gettext "  Warn: \$display_name doesn't contain commit \$sha1_dst")"
-			;;
-		t,t)
-			errmsg="$(eval_gettext "  Warn: \$display_name doesn't contain commits \$sha1_src and \$sha1_dst")"
-			;;
-		*)
-			errmsg=
-			total_commits=$(
-			if test $mod_src = 160000 && test $mod_dst = 160000
-			then
-				range="$sha1_src...$sha1_dst"
-			elif test $mod_src = 160000
-			then
-				range=$sha1_src
-			else
-				range=$sha1_dst
-			fi
-			GIT_DIR="$name/.git" \
-			git rev-list --first-parent $range -- | wc -l
-			)
-			total_commits=" ($(($total_commits + 0)))"
-			;;
-		esac
-
-		sha1_abbr_src=$(echo $sha1_src | cut -c1-7)
-		sha1_abbr_dst=$(echo $sha1_dst | cut -c1-7)
-		if test $status = T
-		then
-			blob="$(gettext "blob")"
-			submodule="$(gettext "submodule")"
-			if test $mod_dst = 160000
-			then
-				echo "* $display_name $sha1_abbr_src($blob)->$sha1_abbr_dst($submodule)$total_commits:"
-			else
-				echo "* $display_name $sha1_abbr_src($submodule)->$sha1_abbr_dst($blob)$total_commits:"
-			fi
-		else
-			echo "* $display_name $sha1_abbr_src...$sha1_abbr_dst$total_commits:"
-		fi
-		if test -n "$errmsg"
-		then
-			# Don't give error msg for modification whose dst is not submodule
-			# i.e. deleted or changed to blob
-			test $mod_dst = 160000 && echo "$errmsg"
-		else
-			if test $mod_src = 160000 && test $mod_dst = 160000
-			then
-				limit=
-				test $summary_limit -gt 0 && limit="-$summary_limit"
-				GIT_DIR="$name/.git" \
-				git log $limit --pretty='format:  %m %s' \
-				--first-parent $sha1_src...$sha1_dst
-			elif test $mod_dst = 160000
-			then
-				GIT_DIR="$name/.git" \
-				git log --pretty='format:  > %s' -1 $sha1_dst
-			else
-				GIT_DIR="$name/.git" \
-				git log --pretty='format:  < %s' -1 $sha1_src
-			fi
-			echo
-		fi
-		echo
-	done
 }
 #
 # List all submodules, prefixed with:
-- 
2.13.0

