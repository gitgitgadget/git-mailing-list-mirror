Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2828020357
	for <e@80x24.org>; Mon, 10 Jul 2017 22:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755052AbdGJWyg (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 18:54:36 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34596 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754981AbdGJWyf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 18:54:35 -0400
Received: by mail-pf0-f196.google.com with SMTP id c24so16312493pfe.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 15:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3IofVb/4hMjs9p8I8cpyce5VKT+7t+62oUWhDqvsXao=;
        b=nkUN7xLU9xlkZYOmf2C18grqkUXgELn+Eima4/VQE0XjBya5WBjGRRRJ3aWSJxkALj
         ZWVqQPbKdBd58MGel7B/fbCU5ylOn35g5szZZ2O5ZRHPPCKWV09+U9f4NF5XJgyk6XfI
         +jqlQZMzyEZcY0ko5jFueq7Fte9ivByPr3SIsWcH0eBwwjps9ItN4ov3S2okdv6v6Qnt
         L8e5i3JQtlw9zHekfmO5+plxnox0TpYe9Ee4a+hxuwb6d/gh+IdYV8VDITHrGC+gCFF8
         /epME2PjvFhzbR8vEry2mc93IsreYRKm7DN0sjSnBwhqchDw79jB/+kD5bFMzwB9BTJE
         1GBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3IofVb/4hMjs9p8I8cpyce5VKT+7t+62oUWhDqvsXao=;
        b=p4iGIjXJ61Pp/ZAOlY1AOppozT+4oppiCV6M3JGV7MDxXNVzdZHv74PHQgnyWi+p+V
         Ld7ielDXBGSX0PhI+RmYTkY5Cxvs0J3IKHb4dputJv5BdIwHtMqIraFO3ot5TFACvzRL
         PrOC/MlpJqwdmNmBOJAH9JK83XSZd6Xt6LdRKOdzC7A4V3YMTenXmqLVPqqC+l5JamJq
         qGnhI1Q4RQ7pWP4RVXWB60wfjsU4Wsq7GqIX6ryMmznO4isox80S5BtppMRN0f1vqOEb
         5pI02OW0f0YCsyB6CioFk0xHfoWEasGeE5bas7JpvOQ58SRMzWJyiGt6G3gydy3Yn4uw
         TdSg==
X-Gm-Message-State: AIVw113W0LY8q14jeFwFnvH0NYX4Ejmi8JnUOloIioa5/IUMa9zdnVsC
        abkcIfNdywL+cvAV
X-Received: by 10.99.134.72 with SMTP id x69mr17156313pgd.210.1499727274535;
        Mon, 10 Jul 2017 15:54:34 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id o6sm20586774pgs.43.2017.07.10.15.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 15:54:34 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 6/8] submodule: port submodule subcommand 'deinit' from shell to C
Date:   Tue, 11 Jul 2017 04:24:05 +0530
Message-Id: <20170710225407.29344-6-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170710225407.29344-1-pc44800@gmail.com>
References: <CAME+mvU_8-S4AhTtMYm1L6PK81v23wu4EuB+EnOgkDhi=jo9Rg@mail.gmail.com>
 <20170710225407.29344-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The same mechanism is used even for porting this submodule
subcommand, as used in the ported subcommands till now.
The function cmd_deinit in split up after porting into three
functions: module_deinit(), for_each_submodule_list() and
deinit_submodule().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 143 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  55 +----------------
 2 files changed, 144 insertions(+), 54 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4e04b93f3..05d430846 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -909,6 +909,148 @@ static int module_sync(int argc, const char **argv, const char *prefix)
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
+	struct stat st;
+
+	sub = submodule_from_path(null_sha1, sm_path);
+
+	if (!sub || !sub->name)
+		goto cleanup;
+
+	displaypath = get_submodule_displaypath(sm_path, info->prefix);
+
+	/* remove the submodule work tree (unless the user already did it) */
+	if (is_directory(sm_path)) {
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
+		if (!lstat(sm_path, &st)) {
+			struct strbuf sb_rm = STRBUF_INIT;
+			strbuf_addstr(&sb_rm, sm_path);
+
+			if (!remove_dir_recursively(&sb_rm, 0)) {
+				if (!info->quiet)
+					printf(_("Cleared directory '%s'\n"),
+						 displaypath);
+			} else {
+				if (!info->quiet)
+					printf(_("Could not remove submodule work tree '%s'\n"),
+						 displaypath);
+			}
+			strbuf_release(&sb_rm);
+		}
+	}
+
+	if (mkdir(sm_path, st.st_mode))
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
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, struct string_list *reference,
 			   int quiet, int progress)
@@ -1639,6 +1781,7 @@ static struct cmd_struct commands[] = {
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
 	{"print-default-remote", print_default_remote, 0},
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
+	{"deinit", module_deinit, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 6bfc5e17d..73e6f093f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -428,60 +428,7 @@ cmd_deinit()
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

