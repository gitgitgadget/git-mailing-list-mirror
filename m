Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B5A81FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 20:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933082AbeAKURo (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 15:17:44 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46883 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933064AbeAKURl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 15:17:41 -0500
Received: by mail-pf0-f193.google.com with SMTP id y5so2529761pff.13
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 12:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=87qNkeb7JRwOYlkARIUdE/0M5ikAx7HKMR7+r3qbyGM=;
        b=cn82OnB/bkAJojZw6dh/4cUzjKl0yxu5yobG5BYL5+bVyXlQFKMwOmj3w34WQ/uEqA
         2VWn4WbDEzKuqmemZO2V+9rrxyWKMsN5AasYGRIY0nMnd/ZZ8WQl88WCf4PDuR40u3lj
         Ed4t/eM4sfWqLDoqXB+qk4tNcv9zCEc5Dao5K8EWncUBiyVM+StqZkB784fXWuv1qR9x
         ktOXVLXC3jQsOC1xsEoREvDwcBQAEkJA0+uO0I3ZKvQstTqJrlYDLN7ISFqvYt4TbuDP
         7O8V5jUb4Z3LpirNy+WQdVfpYXVnd84F+lYpriiy+muJ0vhzl1WOSmUmU+964tcgCAAc
         8zQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=87qNkeb7JRwOYlkARIUdE/0M5ikAx7HKMR7+r3qbyGM=;
        b=UWsQQZvmbuLmwC9C42NBaYXx2dEqvgh/WoqRJiaQ3C8JTu8bTFMaiMeYO7n/oadu+3
         SOy9NskqJidO+TOIgBh/QhJii8t5osiyz1+EdC3wolqKuwvnriBQXzw0KAr/bNAlXosZ
         VrdZePQC037Sw3yLYTJOMR8CBbL2+7ZtbSj5MA+Tiz+J1Svbazai8WOMDl6bgnhf98DA
         ejt13jgTDS3/xdXEq/62LZF5ROWYWJyQU2DgPdTsmJEv73E1v6Ih9cG6jBwX60aGZzHB
         BGO/SO8SUFAj6XXwuuWPra0CQ+rk27n0q+o2/Kg/HHyrA22lMjS27zXiRSy7+n5PC8ia
         m/0A==
X-Gm-Message-State: AKGB3mK2waGrCqhX/ZheJcT9U2xUVmbzkQlh0FC1fUYuEZpcZ2ucr4wl
        qxx1+p+UzYKnigOU+zOGMR9ASxHY
X-Google-Smtp-Source: ACJfBos86aTxDg42mmZ2It0zbtA2cJStAkcj31t7c9O/6gk3wdz+SUWm+tn4NBJ067VqIZjZjstL0w==
X-Received: by 10.84.215.216 with SMTP id g24mr24209434plj.30.1515701859251;
        Thu, 11 Jan 2018 12:17:39 -0800 (PST)
Received: from localhost.localdomain ([27.63.158.37])
        by smtp.gmail.com with ESMTPSA id n24sm42260201pfi.33.2018.01.11.12.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jan 2018 12:17:38 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, sbeller@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v2 2/2] submodule: port submodule subcommand 'deinit' from shell to C
Date:   Fri, 12 Jan 2018 01:47:21 +0530
Message-Id: <20180111201721.25930-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180111201721.25930-1-pc44800@gmail.com>
References: <20180109175703.4793-1-pc44800@gmail.com>
 <20180111201721.25930-1-pc44800@gmail.com>
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
index eb6f96981..b93e1d50b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -20,6 +20,7 @@
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
 #define OPT_RECURSIVE (1 << 2)
+#define OPT_FORCE (1 << 3)
 
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
@@ -911,6 +912,151 @@ static int module_sync(int argc, const char **argv, const char *prefix)
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
+		die_errno(_("could not create empty submodule directory %s"),
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
@@ -1693,6 +1839,7 @@ static struct cmd_struct commands[] = {
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

