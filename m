Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1425D207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 23:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbdFZXLn (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 19:11:43 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34653 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbdFZXLg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 19:11:36 -0400
Received: by mail-pf0-f196.google.com with SMTP id d5so2147132pfe.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 16:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JAirn4LHnZyU4cEvCvXM1PNFlAi2Rcdkl86zxyAhTDc=;
        b=LcMFSdX4EGDG1h8RvaKvp1zHLOGSAti77FLh4qGHA3s96hxmTCwNktdTuEvMfcGl3r
         q37yFk2jRuQ1HHYGEf0XnWDjdvqWxGyvdNonv1EDbldbdbNVx42/IJU/vSbAeLZN6BYB
         L+/NJx8bQZUb11evaA/KL+6BecQplAzZ0Ol/Sgm2/9KHnZ0FnJM8n0aUqjfmIj1E+Iuq
         y98wDeCYFQO7C4fv2bOddjBAaxknE/GNE8Ypopo9N0Dkrw6KBNnHopbRzOFZIU1Dy4bC
         g39nuZ4h7rsUmehrMsbMpoYAwUFLo6dSIZR90Z7SUBZ8mtLqn7bt1KseiKTUGdOqnCxN
         ZwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JAirn4LHnZyU4cEvCvXM1PNFlAi2Rcdkl86zxyAhTDc=;
        b=shUkrutVJkGp2zMxtzn13rALgiqFcsV2bfINhSx76ojKeiRrbOgt2Edc9oxxRFHW+z
         me39LgF/ltefJcGAcZ5MRMok+2fQZT8kwRAHa1EbbTgYRV3IF39msFPxhEwC5bzlYNhu
         g1qLEs76BLi3R88BlR/zsjYJprQ0WxpXJXSntU+YdcO7bFeDU4fuGXPlh+Z88mKFQGKC
         bAnkuKbmBu6naMsRL4lFF3S03Or7PA5uXCZDSOZEonCP9Jlhc2udtFU0btffP2+FHGNL
         gob6Oi/g25xT8em1c4yf5RFiSAAeuy2fHClFT8C2uQyl7x4/AacOlgPm/Dx0X+D8wDF/
         ZAfg==
X-Gm-Message-State: AKS2vOx00NNH5IeprHC3D72u56apzvlS3d7zKgwh/1SjNpd0dtqRY+V1
        fsA77QyIuZyyIA==
X-Received: by 10.99.160.17 with SMTP id r17mr2334648pge.95.1498518694539;
        Mon, 26 Jun 2017 16:11:34 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id p5sm1701339pgf.50.2017.06.26.16.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 16:11:34 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     pc44800@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, sbeller@google.com
Subject: [GSoC][PATCH 6/6 v2] submodule: port submodule subcommand 'deinit' from shell to C
Date:   Tue, 27 Jun 2017 04:41:08 +0530
Message-Id: <20170626231108.23640-6-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170626231108.23640-1-pc44800@gmail.com>
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
 <20170626231108.23640-1-pc44800@gmail.com>
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
index 4e3322846..17942529b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -751,6 +751,145 @@ static int module_status(int argc, const char **argv, const char *prefix)
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
@@ -1805,6 +1944,7 @@ static struct cmd_struct commands[] = {
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
 	{"print-default-remote", print_default_remote, 0},
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
+	{"deinit", module_deinit, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 6257d50e9..0d3308d7b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -391,60 +391,7 @@ cmd_deinit()
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

