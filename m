Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84D1E1FADF
	for <e@80x24.org>; Sun, 14 Jan 2018 16:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeANQtY (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 11:49:24 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35778 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeANQtV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 11:49:21 -0500
Received: by mail-pl0-f66.google.com with SMTP id b96so2064203pli.2
        for <git@vger.kernel.org>; Sun, 14 Jan 2018 08:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uokdp52m4LARdfrIkP46G7smTSSUfxeWzISbe+tllg4=;
        b=boOIWC01vZelgcnGZLnO742ktS3Xs0I0iHY7O18U8LHnXlZuW8FmOD1n99urZ3P4mX
         6seuzYDQjLuWIDBacodefPQzX7d8/g80m6tFwxTh6jhEnsZX0zvctsaAkc5Krm4vhVi+
         pIrQTGtz+ahgJZ6cbTzbTY5LTZhXoIvwVtBcyPaW9AYZtK452FiZDyrEKBQ9G9UO2NRW
         TRQc2hHWHzDmPl+pumyIM7x9VRB/gG/vXfEL047BA3WKmAldSqkhUkbwKmim83xmnAva
         1Aq39xwQdlmkFoGWo+cK8Z0PV8PUnDkEQCEevOujgAIhsGyx97Gh77aIKiNFFPIuZesa
         6udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uokdp52m4LARdfrIkP46G7smTSSUfxeWzISbe+tllg4=;
        b=SK+iAj0iQNDQuqYTG3R+3HZgV1FYbe88OSNCEswyp4tZNOFRq2EDSozREjbEE0Uu1m
         nMm/br80me/FjeCSfjz7kpiwdIT449sZh7BRpJNE1DGaWC7HqKLet1ZA66Fmmuqde0aw
         TZgIYDWYpVzfc1YA8w8iB+lQN9+5POkxyi4IyBXldo8jTA41BC4hgoNopgfbcdxBSzbk
         HuxXYpNWA71S6WLmC1NC38lkkivNib4vDUP8/3L1qNTLGzXlzncHXjkBTA4Wjj/b2wIt
         tnbG6JVgEoOeTx7CvkZI12DhEnNg3+Qs2PKz1nqbURaOiinvv/VCIk+uigDVWJVHlZ9n
         /1Jg==
X-Gm-Message-State: AKwxytfr6xZIZwneamRNOmO8zZe47X7VPgb6rgmw2nxjM2M+0jTYFrM7
        CxSWcIlkLSIHlTa+zm8LVo4=
X-Google-Smtp-Source: ACJfBouSzV49EtAzF+cMkcCt9C3GBGLHQrtKQgnNXF5hggLsqBhFgI/luiaIKbWv98b00deePT/+Rg==
X-Received: by 10.159.206.134 with SMTP id bg6mr3399081plb.402.1515948561232;
        Sun, 14 Jan 2018 08:49:21 -0800 (PST)
Received: from localhost.localdomain ([27.63.154.55])
        by smtp.gmail.com with ESMTPSA id d6sm4799787pfc.35.2018.01.14.08.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jan 2018 08:49:20 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        sbeller@google.com
Subject: [PATCH v3 2/2] submodule: port submodule subcommand 'deinit' from shell to C
Date:   Mon, 15 Jan 2018 02:45:29 +0530
Message-Id: <20180114211529.6391-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180114211529.6391-1-pc44800@gmail.com>
References: <20180111201721.25930-1-pc44800@gmail.com>
 <20180114211529.6391-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The same mechanism is used even for porting this submodule
subcommand, as used in the ported subcommands till now.
The function cmd_deinit in split up after porting into four
functions: module_deinit(), for_each_listed_submodule(),
deinit_submodule() and deinit_submodule_cb().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 147 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  55 +----------------
 2 files changed, 148 insertions(+), 54 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 745d070ea..b1daca995 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -20,6 +20,7 @@
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
 #define OPT_RECURSIVE (1 << 2)
+#define OPT_FORCE (1 << 3)
 
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
@@ -909,6 +910,151 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct deinit_cb {
+	const char *prefix;
+	unsigned int flags;
+};
+#define DEINIT_CB_INIT { NULL, 0 }
+
+static void deinit_submodule(const char *path, const char *prefix,
+			     unsigned int flags)
+{
+	const struct submodule *sub;
+	char *displaypath = NULL;
+	struct child_process cp_config = CHILD_PROCESS_INIT;
+	struct strbuf sb_config = STRBUF_INIT;
+	char *sub_git_dir = xstrfmt("%s/.git", path);
+
+	sub = submodule_from_path(&null_oid, path);
+
+	if (!sub || !sub->name)
+		goto cleanup;
+
+	displaypath = get_submodule_displaypath(path, prefix);
+
+	/* remove the submodule work tree (unless the user already did it) */
+	if (is_directory(path)) {
+		struct strbuf sb_rm = STRBUF_INIT;
+		const char *format;
+
+		/*
+		 * protect submodules containing a .git directory
+		 * NEEDSWORK: instead of dying, automatically call
+		 * absorbgitdirs and (possibly) warn.
+		 */
+		if (is_directory(sub_git_dir))
+			die(_("Submodule work tree '%s' contains a .git "
+			      "directory (use 'rm -rf' if you really want "
+			      "to remove it including all of its history)"),
+			    displaypath);
+
+		if (!(flags & OPT_FORCE)) {
+			struct child_process cp_rm = CHILD_PROCESS_INIT;
+			cp_rm.git_cmd = 1;
+			argv_array_pushl(&cp_rm.args, "rm", "-qn",
+					 path, NULL);
+
+			if (run_command(&cp_rm))
+				die(_("Submodule work tree '%s' contains local "
+				      "modifications; use '-f' to discard them"),
+				      displaypath);
+		}
+
+		strbuf_addstr(&sb_rm, path);
+
+		if (!remove_dir_recursively(&sb_rm, 0))
+			format = _("Cleared directory '%s'\n");
+		else
+			format = _("Could not remove submodule work tree '%s'\n");
+
+		if (!(flags & OPT_QUIET))
+			printf(format, displaypath);
+
+		strbuf_release(&sb_rm);
+	}
+
+	if (mkdir(path, 0777))
+		printf(_("could not create empty submodule directory %s"),
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
+		if (!(flags & OPT_QUIET))
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
+static void deinit_submodule_cb(const struct cache_entry *list_item,
+				void *cb_data)
+{
+	struct deinit_cb *info = cb_data;
+	deinit_submodule(list_item->name, info->prefix, info->flags);
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
+	if (all && argc) {
+		error("pathspec and --all are incompatible");
+		usage_with_options(git_submodule_helper_usage,
+				   module_deinit_options);
+	}
+
+	if (!argc && !all)
+		die(_("Use '--all' if you really want to deinitialize all submodules"));
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+		BUG("module_list_compute should not choke on empty pathspec");
+
+	info.prefix = prefix;
+	if (quiet)
+		info.flags |= OPT_QUIET;
+	if (force)
+		info.flags |= OPT_FORCE;
+
+	for_each_listed_submodule(&list, deinit_submodule_cb, &info);
+
+	return 0;
+}
+
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, struct string_list *reference,
 			   int quiet, int progress)
@@ -1691,6 +1837,7 @@ static struct cmd_struct commands[] = {
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
 	{"print-default-remote", print_default_remote, 0},
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
+	{"deinit", module_deinit, 0},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 0825cae14..24914963c 100755
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
2.15.1

