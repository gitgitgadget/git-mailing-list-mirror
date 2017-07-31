Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7E81F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbdGaU5M (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:57:12 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36249 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbdGaU5J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:57:09 -0400
Received: by mail-pg0-f67.google.com with SMTP id y129so32274950pgy.3
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/YPm/ul78iZa0CmuZy4TpbGUz6jR7XGEFvVR9zU6TL4=;
        b=LH64G6zkvqnSVbFTzorKPPaZDen5GfQCceQdXm7xlul02cvljpkhRBMIgp1QX4cD39
         PLJxOxdqX3xJK7CvyHNUEBNNZgC5mdo9ft3vs9DkTyqfJxoytAOYi7PAkmkGw2ZQ9mmo
         3N5PPGSsH6PXx3DD9kAbq3YKjiwkpWzEqTeXXVJKKdF6xrLvw79hcJNqsDZ2bHA1ctlA
         DG/b7vTNDoyVSCn8i/tmsi6qWpWbejDYChkXiapC924LEf2SHEy8QD1LOqyTDLLSedA9
         biS4NYSlRAU5trQ0m06Oy2QyDFXaeiSSKgYMXh6fe3wxRIJ+2Hj+uN0DjTMNOMBzL5NB
         ttsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/YPm/ul78iZa0CmuZy4TpbGUz6jR7XGEFvVR9zU6TL4=;
        b=VP40LXxelXQwoPj/l6FyYT7sB2gqyjUNANtC7s7n92NceDALH9GWX0dnE0Ry2xUGrO
         d269l0cYJ6LOcNHJuOszNZcyuyNfLhQx6BZ+y3ZRwg9mLpSWSxdDnUetT17TAhhv8aG5
         N2+KJkCLdIBhsxrhw6cM8n7DbD/toVqkHTdxjRPRIFWye5X3XzcSwfCllX9YBV8asCu4
         1OINduAiIo5YWenA30bwTJMSFbtXt8whClDBrN7mbK3pwL4j4Q0EsF+nAU1NWde/7fE0
         i50as3G7GAqiv4AifIYjhhbyAN43/IaXkKXpnTXntUqwq6tq/vUpMqW6z4VZCpYATltp
         6Iwg==
X-Gm-Message-State: AIVw110vaGzQOFLbTqCquFsnemLQp0Llfq8YOca+29N0AdQjqOUpgUa2
        ZnH3GQv4Mp7yDKw/wCw/lw==
X-Received: by 10.101.90.3 with SMTP id y3mr16876113pgs.185.1501534628234;
        Mon, 31 Jul 2017 13:57:08 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6182:3b53:5da6:3508:cb8e:5545])
        by smtp.gmail.com with ESMTPSA id 16sm52881007pfq.151.2017.07.31.13.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 13:57:07 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 08/13] submodule: port submodule subcommand 'summary' from shell to C
Date:   Tue,  1 Aug 2017 02:26:16 +0530
Message-Id: <20170731205621.24305-9-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170731205621.24305-1-pc44800@gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com>
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
In this new version, the following changes have been made:

* Firstly, about the function compute_summary_module_list().
  This function is created to generate the list of modules, for which
  we will generate the summary further. Since the list is actually
  generated using the git-diff-files or git-diff-index command, but for
  porting this, we required to create a function similar to the builtin
  functions of the above commands. But we can't directly call cmd_diff_files() 
  and cmd_diff_index() since we don't have to display the output and instead
  need to store it. Hence, this function is introduced.
 
* Also, the module_cb_list *list is not freed since it is a non-heap object.
  Hence, free() can't be using on the non-heap objects.

* In the function prepare_submodule_summary(), as suggested
  'git_config_get_string_const' was used instead of instead of '_value'

* Some variables which weren't modified throughout the function-call were
  passed as const.

* The '!!' trick, which wasn't used in the last patch, is now used in this
  new version .

* the variables sha1_dst and sha1_src are removed from the function
  print_submodule_summary(), and instead the p->oid_src and p->oid_dst are
  used.

* The variable sm_git_dir is freed at the end of the function.

* variable head was no longer used in module_summary() and instead the strbuf
  was utilized.

 builtin/submodule--helper.c | 425 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 182 +------------------
 2 files changed, 426 insertions(+), 181 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f642f9889..94438d6ce 100644
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
@@ -766,6 +769,427 @@ static int module_name(int argc, const char **argv, const char *prefix)
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
+static int verify_submodule_object_name(const char *sm_path, const char *sha1)
+{
+	struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
+
+	cp_rev_parse.git_cmd = 1;
+	cp_rev_parse.no_stdout = 1;
+	cp_rev_parse.dir = sm_path;
+	prepare_submodule_repo_env(&cp_rev_parse.env_array);
+
+	argv_array_pushl(&cp_rev_parse.args, "rev-parse", "-q",
+			 "--verify", NULL);
+	argv_array_pushf(&cp_rev_parse.args, "%s^0", sha1);
+
+	if (run_command(&cp_rev_parse))
+		return 1;
+
+	return 0;
+}
+
+static void print_submodule_summary(struct summary_cb *info,
+				    struct module_cb *p)
+{
+	int missing_src = 0;
+	int missing_dst = 0;
+	char *displaypath;
+	const char *sha1_abbr_src;
+	const char *sha1_abbr_dst;
+	int errmsg = 0;
+	int total_commits = -1;
+	char *sm_git_dir = xstrfmt("%s/.git", p->sm_path);
+	int is_sm_git_dir = 0;
+
+	if (!info->cached && !oidcmp(&p->oid_dst, &null_oid)) {
+		if (S_ISGITLINK(p->mod_dst)) {
+			struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
+			struct strbuf sb_rev_parse = STRBUF_INIT;
+
+			cp_rev_parse.git_cmd = 1;
+			cp_rev_parse.no_stderr = 1;
+			cp_rev_parse.dir = p->sm_path;
+			prepare_submodule_repo_env(&cp_rev_parse.env_array);
+
+			argv_array_pushl(&cp_rev_parse.args,
+					 "rev-parse", "HEAD", NULL);
+			if (!capture_command(&cp_rev_parse, &sb_rev_parse, 0)) {
+				strbuf_strip_suffix(&sb_rev_parse, "\n");
+
+				get_oid_hex(sb_rev_parse.buf, &p->oid_dst);
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
+
+				get_oid_hex(sb_hash_object.buf, &p->oid_dst);
+			}
+			strbuf_release(&sb_hash_object);
+		} else {
+			if (p->mod_dst)
+				die(_("unexpected mode %d\n"), p->mod_dst);
+		}
+	}
+
+	if (is_git_directory(sm_git_dir))
+		is_sm_git_dir = 1;
+
+	if (is_sm_git_dir && S_ISGITLINK(p->mod_src))
+		missing_src = verify_submodule_object_name(p->sm_path,
+							   oid_to_hex(&p->oid_src));
+
+	if (is_sm_git_dir && S_ISGITLINK(p->mod_dst))
+		missing_dst = verify_submodule_object_name(p->sm_path,
+							   oid_to_hex(&p->oid_dst));
+
+	displaypath = get_submodule_displaypath(p->sm_path, info->prefix);
+
+	if (!missing_dst && !missing_src) {
+		if (is_sm_git_dir) {
+			struct child_process cp_rev_list = CHILD_PROCESS_INIT;
+			struct strbuf sb_rev_list = STRBUF_INIT;
+			char *range;
+
+			if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst))
+				range = xstrfmt("%s...%s", oid_to_hex(&p->oid_src), oid_to_hex(&p->oid_dst));
+			else if (S_ISGITLINK(p->mod_src))
+				range = xstrdup(oid_to_hex(&p->oid_src));
+			else
+				range = xstrdup(oid_to_hex(&p->oid_dst));
+
+			cp_rev_list.git_cmd = 1;
+			cp_rev_list.dir = p->sm_path;
+			prepare_submodule_repo_env(&cp_rev_list.env_array);
+
+			argv_array_pushl(&cp_rev_list.args, "rev-list",
+					 "--first-parent", range, "--", NULL);
+			if (!capture_command(&cp_rev_list, &sb_rev_list, 0)) {
+				if (sb_rev_list.len)
+					total_commits = count_lines(sb_rev_list.buf,
+								    sb_rev_list.len);
+				else
+					total_commits = 0;
+			}
+
+			free(range);
+			strbuf_release(&sb_rev_list);
+		}
+	} else {
+		errmsg = 1;
+	}
+
+	sha1_abbr_src = find_unique_abbrev(p->oid_src.hash, 7);
+	sha1_abbr_dst = find_unique_abbrev(p->oid_dst.hash, 7);
+
+	if (p->status == 'T') {
+		if (S_ISGITLINK(p->mod_dst))
+			printf(_("* %s %s(blob)->%s(submodule)"),
+				 displaypath, sha1_abbr_src,
+				 sha1_abbr_dst);
+		else
+			printf(_("* %s %s(submodule)->%s(blob)"),
+				 displaypath, sha1_abbr_src,
+				 sha1_abbr_dst);
+	} else {
+			printf("* %s %s...%s", displaypath, sha1_abbr_src,
+				 sha1_abbr_dst);
+	}
+
+	if (total_commits < 0)
+		printf(":\n");
+	else
+		printf(" (%d):\n", total_commits);
+
+	if (errmsg) {
+		/*
+		 * Don't give error msg for modification whose dst is not
+		 * submodule, i.e. deleted or changed to blob
+		 */
+		if (S_ISGITLINK(p->mod_src)) {
+			if (missing_src && missing_dst) {
+				printf(_("  Warn: %s doesn't contain commits %s and %s\n"),
+				 displaypath, oid_to_hex(&p->oid_src), oid_to_hex(&p->oid_dst));
+			} else if (missing_src) {
+				printf(_("  Warn: %s doesn't contain commit %s\n"),
+				 displaypath, oid_to_hex(&p->oid_src));
+			} else {
+				printf(_("  Warn: %s doesn't contain commit %s\n"),
+				 displaypath, oid_to_hex(&p->oid_dst));
+			}
+		}
+	} else if (is_sm_git_dir) {
+		struct child_process cp_log = CHILD_PROCESS_INIT;
+
+		cp_log.git_cmd = 1;
+		cp_log.dir = p->sm_path;
+		prepare_submodule_repo_env(&cp_log.env_array);
+		argv_array_pushl(&cp_log.args, "log", NULL);
+
+		if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst)) {
+			if (info->summary_limits > 0)
+				argv_array_pushf(&cp_log.args, "-%d", info->summary_limits);
+
+			argv_array_pushl(&cp_log.args, "--pretty=  %m %s",
+					 "--first-parent", NULL);
+			argv_array_pushf(&cp_log.args, "%s...%s", oid_to_hex(&p->oid_src), oid_to_hex(&p->oid_dst));
+		} else if (S_ISGITLINK(p->mod_dst)) {
+			argv_array_pushl(&cp_log.args, "--pretty=  > %s",
+					 "-1", oid_to_hex(&p->oid_dst), NULL);
+		} else {
+			argv_array_pushl(&cp_log.args, "--pretty=  < %s",
+					 "-1", oid_to_hex(&p->oid_src), NULL);
+		}
+
+		run_command(&cp_log);
+	}
+	printf("\n");
+
+	free(displaypath);
+	free(sm_git_dir);
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
+			if (sub && p->status != 'A') {
+				config_key = xstrfmt("submodule.%s.ignore",
+						     sub->name);
+				if (!git_config_get_string_const(config_key, &value))
+					ignore_config = value;
+				else if (sub->ignore)
+					ignore_config = sub->ignore;
+
+				free(config_key);
+
+				if (!strcmp(ignore_config, "all"))
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
+
+	free(head);
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
+	struct child_process cp_rev = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
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
+			 argc ? argv[0] : "HEAD", NULL);
+
+	if (!capture_command(&cp_rev, &sb, 0)) {
+		strbuf_strip_suffix(&sb, "\n");
+		if (argc) {
+			argv++;
+			argc--;
+		}
+	} else if (!argc || !strcmp(argv[0], "HEAD")) {
+		/* before the first commit: compare with an empty tree */
+		struct stat st;
+		struct object_id oid;
+		if (fstat(0, &st) < 0 || index_fd(oid.hash, 0, &st, 2, prefix, 3))
+			die("Unable to add %s to database", oid.hash);
+		strbuf_addstr(&sb, oid_to_hex(&oid));
+		if (argc) {
+			argv++;
+			argc--;
+		}
+	} else {
+		strbuf_addstr(&sb, "HEAD");
+	}
+
+	if (files) {
+		if (cached)
+			die(_("The --cached option cannot be used with the --files option"));
+		diff_cmd = "diff-files";
+
+		strbuf_reset(&sb);
+		sb.buf = NULL;
+	}
+
+	info.argc = argc;
+	info.argv = argv;
+	info.prefix = prefix;
+	info.cached = !!cached;
+	info.for_status = !!for_status;
+	info.quiet = quiet;
+	info.files = files;
+	info.summary_limits = summary_limits;
+	info.diff_cmd = diff_cmd;
+
+	return compute_summary_module_list(strbuf_detach(&sb, NULL), &info);
+}
+
 struct sync_cb {
 	const char *prefix;
 	unsigned int quiet: 1;
@@ -1787,6 +2211,7 @@ static struct cmd_struct commands[] = {
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

