Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E0F2047F
	for <e@80x24.org>; Sat, 29 Jul 2017 22:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbdG2WYt (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 18:24:49 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35720 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753172AbdG2WYs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2017 18:24:48 -0400
Received: by mail-pg0-f67.google.com with SMTP id d193so26888115pgc.2
        for <git@vger.kernel.org>; Sat, 29 Jul 2017 15:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vF/vPp+tD9KuUMEDP9ewlYuj5YJIMEhJqPcaAHX5MaM=;
        b=e5QM3hemtAgY9E8Anuxnb2hvz4+EVn9I7fv00KKwevG0AF9mu9yauv8zFTdPPNsJYC
         42F9PdVECNNkkWh/YJ9b2/2aGiYRFhjSEY38b2Da2xqRKxUaW3jxGTENss69ojKObH1m
         Dtpta9GGKMZMI8q4exM7vAxNPzA5aJBWrCNh2vR1Z5oe4ATWZi16pQU6GyZ0trqLB5qL
         YHlUo/OSC1/C9w/7AUNyJdzQaST3weBPkZX4N9APjaucTRXo1r7dhK2pZDowQRrtU5Av
         0NY6WJ/UthHzwmFYw92/17eJszOmC9ci53BneUyjO26c1Hz3DiTZHIW4D8yXNbwbuvrj
         2ERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vF/vPp+tD9KuUMEDP9ewlYuj5YJIMEhJqPcaAHX5MaM=;
        b=sZ7PUMoWcY9zJUC3tVdNY+p1jmgAgS07VERHdxogtl5KkVVVo1nG/tOH+qO9Gmq2NY
         vOooxjIBY407iQuFAt5lv6VBtfsLcOEETX9jG6OQVokKNObIDtckoYYagqJ7x9KDw9XQ
         GKZGpYl/hGaJ8qAqCByHFkjEnnDFKfuu4V9drVKMriB8I1LTFCBGvG37L0XSgdHA9yzh
         khJScNZQTQgcdTk52x249qSGX22gN22RDhtOafiztCbHpzU6t6l+Hf76h1LJQWtu3oMB
         WrGP+Gp+wzqwuaXhSy2FlUIAB5/5ZT/+KVpgZD3Dh2aIhpy8KmtxdJxL3tctiUKiIh0N
         xk3Q==
X-Gm-Message-State: AIVw110PoHi9YgAL5IAq7WRAukv7NheEufapGtVrR61pp7jyQFyrtKuu
        9sKlpdYc1bpCUEejFmY=
X-Received: by 10.84.209.165 with SMTP id y34mr12206978plh.200.1501367087330;
        Sat, 29 Jul 2017 15:24:47 -0700 (PDT)
Received: from localhost.localdomain ([47.11.7.4])
        by smtp.gmail.com with ESMTPSA id w125sm43476409pfb.117.2017.07.29.15.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Jul 2017 15:24:46 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, bmwill@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v2 06/13] submodule: port submodule subcommand 'deinit' from shell to C
Date:   Sun, 30 Jul 2017 03:53:54 +0530
Message-Id: <20170729222401.12381-7-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170729222401.12381-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
 <20170729222401.12381-1-pc44800@gmail.com>
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
In this new version, the following changes have been made:
* In the function deinit_submodule, since the test is_git_directory()
  adds an additional condition, instead is_directory() is used to check
  if "sm_path/.git" is a directory.

* since it was possible in the previous path that the value st.st_mode passed
  to the function mkdir contained a garbage value, instead we intrduce a
  mode_t variable mode, initially containing a default mode value '0777'.
  This is what the default of mode is set in case, that the value is
  not set after the lstat call.

 builtin/submodule--helper.c | 144 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  55 +----------------
 2 files changed, 145 insertions(+), 54 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 877215567..038be7ee2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -916,6 +916,149 @@ static int module_sync(int argc, const char **argv, const char *prefix)
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
+	char *sub_git_dir = xstrfmt("%s/.git", list_item->name);
+	mode_t mode = 0777;
+
+	sub = submodule_from_path(null_sha1, list_item->name);
+
+	if (!sub || !sub->name)
+		goto cleanup;
+
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
+
+	/* remove the submodule work tree (unless the user already did it) */
+	if (is_directory(list_item->name)) {
+		struct stat st;
+		/* protect submodules containing a .git directory */
+		if (is_directory(sub_git_dir))
+			die(_("Submodule work tree '%s' contains a .git "
+			      "directory use 'rm -rf' if you really want "
+			      "to remove it including all of its history"),
+			      displaypath);
+
+		if (!info->force) {
+			struct child_process cp_rm = CHILD_PROCESS_INIT;
+			cp_rm.git_cmd = 1;
+			argv_array_pushl(&cp_rm.args, "rm", "-qn",
+					 list_item->name, NULL);
+
+			if (run_command(&cp_rm))
+				die(_("Submodule work tree '%s' contains local "
+				      "modifications; use '-f' to discard them"),
+				      displaypath);
+		}
+
+		if (!lstat(list_item->name, &st)) {
+			struct strbuf sb_rm = STRBUF_INIT;
+			const char *format;
+
+			strbuf_addstr(&sb_rm, list_item->name);
+
+			if (!remove_dir_recursively(&sb_rm, 0))
+				format = _("Cleared directory '%s'\n");
+			else
+				format = _("Could not remove submodule work tree '%s'\n");
+
+			if (!info->quiet)
+				printf(format, displaypath);
+
+			mode = st.st_mode;
+
+			strbuf_release(&sb_rm);
+		}
+	}
+
+	if (mkdir(list_item->name, mode))
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
@@ -1646,6 +1789,7 @@ static struct cmd_struct commands[] = {
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

