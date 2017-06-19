Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C381FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 21:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbdFSVvB (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 17:51:01 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33491 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbdFSVvA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 17:51:00 -0400
Received: by mail-pf0-f195.google.com with SMTP id w12so19446295pfk.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 14:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A+wC/1MY69yy0qh/Jianz0McKC46YW7LMDiPD+55Qjc=;
        b=l3PlSdSTaVc18kaD3mtmKDHRMSCQ8vZddKhHq1J5OdjH/Q9iMYnCXgOnUkK5I8wEpX
         f8o1FN+xYllgpWxpmdkN5kvTPWag/Hmoom4sk6RrRFPc522YYJe7l+rpZXcN52gS4V/L
         KOxlUgo8MTo50KIt1JXyznvNnNhx8fLbMr/3+LqfCJqreyBQzrVT5yuIf80rrgmgxJVy
         Tf4eSIi6TEfy1bnU4hP/xCc1uPb1OzHQuuLJXeZ5R9DXVYN26dXzB1HewQSnJg0NIAOi
         bMhds5cwcJsfmkRYhQV6n5Ctcg2nCC4M8O8aLOFbkoGzxlx0QsF9c/03UiVLhxkYP5v4
         PK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A+wC/1MY69yy0qh/Jianz0McKC46YW7LMDiPD+55Qjc=;
        b=OO0MyuK1zKzqpp2U08zNukY/n+NuLJCwIMxhyCe4bdP7QEBm4PVK4iKa/pBmta4PFO
         9xSIdaaQrX9ZFLSeY1sgCljIHj4WgM7OGEyPjtJAVtuErmfWl45XrSchtsmRwjjOotTj
         kPefDpHch9L9zKFGhj25ZYHsqcILogsFiDWMmzevo/0dGFMnBvpUQHZwPSIqL/icEfCA
         UtaPVwZ5Q3Nt0srS+pXokkDMbgHt6IOk2xTen96PAOtH0ygBqz5jkSPkyQszANTIIZwu
         AZlwmDaOZcwO/acTYPBP3VUuws3NISIa7cm7m7N3zYNUE92f8YF76Yy2ewsr09FMwPKs
         R/qA==
X-Gm-Message-State: AKS2vOwiMvLm/kVtQjpXc6KPDnG5+nWZ4vL4MwMOmFj5ZQ3bLJ+r7CCE
        5ibw73StA56GEaJT
X-Received: by 10.99.104.69 with SMTP id d66mr28282396pgc.12.1497909059385;
        Mon, 19 Jun 2017 14:50:59 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id 5sm20744309pfe.60.2017.06.19.14.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 14:50:58 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 6/6] submodule: port submodule subcommand 'deinit' from shell to C
Date:   Tue, 20 Jun 2017 03:20:25 +0530
Message-Id: <20170619215025.10086-6-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170619215025.10086-1-pc44800@gmail.com>
References: <CAME+mvUQJFneV7b1G7zmAidP-5L=nimvY43V0ug-Gtesr83tzg@mail.gmail.com>
 <20170619215025.10086-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The same mechanism is used even for porting this submodule
subcommand, as used in the ported subcommands till now.
The function cmd_deinit in split up after porting into three
functions: module_deinit, for_each_submodule_list and
deinit_submodule.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 140 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  55 +----------------
 2 files changed, 141 insertions(+), 54 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e10cac462..f029f5fae 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -750,6 +750,145 @@ static int module_status(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct deinit_cb {
+	const char *prefix;
+	unsigned int quiet: 1;
+	unsigned int force: 1;
+	unsigned int all: 1;
+};
+#define DEINIT_CB_INIT { NULL, 0, 0, 0 }
+
+static void deinit_submodule(const struct cache_entry *list_item,
+			     void *cb_data)
+{
+	struct deinit_cb *info = cb_data;
+	const struct submodule *sub;
+	char *displaypath = NULL;
+	struct child_process cp_config = CHILD_PROCESS_INIT;
+	struct strbuf sb_config = STRBUF_INIT;
+	char *sm_path = xstrdup(list_item->name);
+	char *sub_git_dir = xstrfmt("%s/.git", sm_path);
+
+	sub = submodule_from_path(null_sha1, sm_path);
+
+	if (!sub->name)
+		goto cleanup;
+
+	displaypath = get_submodule_displaypath(sm_path, info->prefix);
+
+	/* remove the submodule work tree (unless the user already did it) */
+	if (is_directory(sm_path)) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+
+		/* protect submodules containing a .git directory */
+		if (is_git_directory(sub_git_dir))
+			die(_("Submodule work tree '%s' contains a .git "
+			      "directory use 'rm -rf' if you really want "
+			      "to remove it including all of its history"),
+			      displaypath);
+
+		if (!info->force) {
+			struct child_process cp_rm = CHILD_PROCESS_INIT;
+			cp_rm.git_cmd = 1;
+			argv_array_pushl(&cp_rm.args, "rm", "-qn", sm_path,
+					 NULL);
+
+			/* list_item->name is changed by cmd_rm() below */
+			if (run_command(&cp_rm))
+				die(_("Submodule work tree '%s' contains local "
+				      "modifications; use '-f' to discard them"),
+				      displaypath);
+		}
+
+		cp.use_shell = 1;
+		argv_array_pushl(&cp.args, "rm", "-rf", sm_path, NULL);
+		if (!run_command(&cp)) {
+			if (!info->quiet)
+				printf(_("Cleared directory '%s'\n"),
+					 displaypath);
+		} else {
+			if (!info->quiet)
+				printf(_("Could not remove submodule work tree '%s'\n"),
+					 displaypath);
+		}
+	}
+
+	if (mkdir(sm_path, 0700))
+		die(_("could not create empty submodule directory %s"),
+		      displaypath);
+
+	cp_config.git_cmd = 1;
+	argv_array_pushl(&cp_config.args, "config", "--get-regexp", NULL);
+	argv_array_pushf(&cp_config.args, "submodule.%s\\.", sub->name);
+
+	/* remove the .git/config entries (unless the user already did it) */
+	if (!capture_command(&cp_config, &sb_config, 0) && sb_config.len) {
+		char *sub_key = xstrfmt("submodule.%s", sub->name);
+		/*
+		 * remove the whole section so we have a clean state when
+		 * the user later decides to init this submodule again
+		 */
+		git_config_rename_section_in_file(NULL, sub_key, NULL);
+		if (!info->quiet)
+			printf(_("Submodule '%s' (%s) unregistered for path '%s'\n"),
+				 sub->name, sub->url, displaypath);
+		free(sub_key);
+	}
+
+cleanup:
+	free(displaypath);
+	free(sub_git_dir);
+	free(sm_path);
+	strbuf_release(&sb_config);
+}
+
+static int module_deinit(int argc, const char **argv, const char *prefix)
+{
+	struct deinit_cb info = DEINIT_CB_INIT;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+	int quiet = 0;
+	int force = 0;
+	int all = 0;
+
+	struct option module_deinit_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress submodule status output")),
+		OPT__FORCE(&force, N_("Remove submodule working trees even if they contain local changes")),
+		OPT_BOOL(0, "all", &all, N_("Unregister all submodules")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule deinit [--quiet] [-f | --force] [--all | [--] [<path>...]]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_deinit_options,
+			     git_submodule_helper_usage, 0);
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+		BUG("module_list_compute should not choke on empty pathspec");
+
+	info.prefix = prefix;
+	info.quiet = !!quiet;
+	info.all = !!all;
+	info.force = !!force;
+
+	if (all && argc) {
+		error("pathspec and --all are incompatible");
+		usage_with_options(git_submodule_helper_usage,
+				   module_deinit_options);
+	}
+
+	if (!argc && !all)
+		die(_("Use '--all' if you really want to deinitialize all submodules"));
+
+	gitmodules_config();
+	for_each_submodule_list(list, deinit_submodule, &info);
+
+	return 0;
+}
+
 static int module_name(int argc, const char **argv, const char *prefix)
 {
 	const struct submodule *sub;
@@ -1644,6 +1783,7 @@ static struct cmd_struct commands[] = {
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
 	{"print-default-remote", print_default_remote, 0},
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
+	{"deinit", module_deinit, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 33b4b7306..2b2c6f5da 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -427,60 +427,7 @@ cmd_deinit()
 		shift
 	done
 
-	if test -n "$deinit_all" && test "$#" -ne 0
-	then
-		echo >&2 "$(eval_gettext "pathspec and --all are incompatible")"
-		usage
-	fi
-	if test $# = 0 && test -z "$deinit_all"
-	then
-		die "$(eval_gettext "Use '--all' if you really want to deinitialize all submodules")"
-	fi
-
-	{
-		git submodule--helper list --prefix "$wt_prefix" "$@" ||
-		echo "#unmatched" $?
-	} |
-	while read -r mode sha1 stage sm_path
-	do
-		die_if_unmatched "$mode" "$sha1"
-		name=$(git submodule--helper name "$sm_path") || exit
-
-		displaypath=$(git submodule--helper relative-path "$sm_path" "$wt_prefix")
-
-		# Remove the submodule work tree (unless the user already did it)
-		if test -d "$sm_path"
-		then
-			# Protect submodules containing a .git directory
-			if test -d "$sm_path/.git"
-			then
-				die "$(eval_gettext "\
-Submodule work tree '\$displaypath' contains a .git directory
-(use 'rm -rf' if you really want to remove it including all of its history)")"
-			fi
-
-			if test -z "$force"
-			then
-				git rm -qn "$sm_path" ||
-				die "$(eval_gettext "Submodule work tree '\$displaypath' contains local modifications; use '-f' to discard them")"
-			fi
-			rm -rf "$sm_path" &&
-			say "$(eval_gettext "Cleared directory '\$displaypath'")" ||
-			say "$(eval_gettext "Could not remove submodule work tree '\$displaypath'")"
-		fi
-
-		mkdir "$sm_path" || say "$(eval_gettext "Could not create empty submodule directory '\$displaypath'")"
-
-		# Remove the .git/config entries (unless the user already did it)
-		if test -n "$(git config --get-regexp submodule."$name\.")"
-		then
-			# Remove the whole section so we have a clean state when
-			# the user later decides to init this submodule again
-			url=$(git config submodule."$name".url)
-			git config --remove-section submodule."$name" 2>/dev/null &&
-			say "$(eval_gettext "Submodule '\$name' (\$url) unregistered for path '\$displaypath'")"
-		fi
-	done
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} ${force:+--force} ${deinit_all:+--all} "$@"
 }
 
 is_tip_reachable () (
-- 
2.13.0

