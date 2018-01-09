Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6F4A1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 18:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756040AbeAISBZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:01:25 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39808 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755946AbeAISBY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:01:24 -0500
Received: by mail-pg0-f66.google.com with SMTP id z20so6228911pgv.6
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 10:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sjR1l7oH3dBeaWnzVsWr/0I2RAkj8akkFNexJGwezYc=;
        b=EXdPg7Oa7F4ugAlrI/gCEqZ4yjJ/lSsQ+2tM9NmGCF7hm0N4SsbQpXq5NU/PNuKHFM
         BRPQr6GpsN0V74+qJxtjCDjDb1H85H4ME1HO+FY2SWQ8cDUN9vqemd4cLMTTuxds1wil
         jmrrctQ1STMtgWLU5JOrqDFbVQcssN/G38oyX+LZzaywAyRnuoYCQjBhR+xtYYBpVrAP
         rI2656WA8fWi+hB4UFNLM9mz+v0zu8Ogo1xylZMne43YMhQawJBoF/qpSlDSUygxlIWx
         TMHu92OB91lsV72fOnipNUbGpRrRjsRupwxomSQEge8aqnpDNbeahYk9qSnMWcg+BbK2
         l89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sjR1l7oH3dBeaWnzVsWr/0I2RAkj8akkFNexJGwezYc=;
        b=FHCjpDiVCDCtG+wPGIzM25dtViAdEEWZyQ/90enhibO67LO3XHvHa3w7fk2KapDE3o
         d53njwdmrdknb/uta39U+NvV08incX/tojB+EkRKKJ6/BFstK6Z89sfjkOt3cOCJesop
         U/qumy2BjfSIsr523avshbve1iWuMIBMj2h6ssdYgvHwMbKMLwdYV7UFN2ZklCODjEhR
         1dNJyOTTwUILy6E7ZaOH2Few+4IZqbYDSPT9JFOm1EswhFQ1ccUst4QGHq2EzSxudCvR
         ButFmUTiskY0L1tcZuRWG8sOHeokFSpGvmYW5TwVcH4fG7c6N+IAGKfPvepc9N2YUMXB
         L/0w==
X-Gm-Message-State: AKGB3mLqBiCtRfXtnSZPj8WblhRyhct/Vv+KT+nITEC0Clxmc//kWCiW
        HiDHvCEpE+zkq0KQmQom3YWrwj8L
X-Google-Smtp-Source: ACJfBouCScEddRYAf7xv99Z3fFY7a9f4iIb/trIvsVa9Oz8OEGQDJnDjhQgBa0T1UQig/T8Guodopg==
X-Received: by 10.101.96.11 with SMTP id m11mr13166658pgu.232.1515520883772;
        Tue, 09 Jan 2018 10:01:23 -0800 (PST)
Received: from localhost.localdomain ([223.176.44.24])
        by smtp.gmail.com with ESMTPSA id z85sm2582446pfk.110.2018.01.09.10.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Jan 2018 10:01:23 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v1 2/2] submodule: port submodule subcommand 'deinit' from shell to C
Date:   Tue,  9 Jan 2018 23:27:03 +0530
Message-Id: <20180109175703.4793-3-pc44800@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180109175703.4793-1-pc44800@gmail.com>
References: <20180109175703.4793-1-pc44800@gmail.com>
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
 builtin/submodule--helper.c | 153 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  55 +---------------
 2 files changed, 154 insertions(+), 54 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index dd7737acd..54b0e46fc 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -20,6 +20,7 @@
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
 #define OPT_RECURSIVE (1 << 2)
+#define OPT_FORCE (1 << 3)
 
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
@@ -908,6 +909,157 @@ static int module_sync(int argc, const char **argv, const char *prefix)
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
+	mode_t mode = 0777;
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
+		struct stat st;
+		/*
+		 * protect submodules containing a .git directory
+		 * NEEDSWORK: automatically call absorbgitdirs before
+		 * warning/die.
+		 */
+		if (is_directory(sub_git_dir))
+			die(_("Submodule work tree '%s' contains a .git "
+			      "directory use 'rm -rf' if you really want "
+			      "to remove it including all of its history"),
+			      displaypath);
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
+		if (!lstat(path, &st)) {
+			struct strbuf sb_rm = STRBUF_INIT;
+			const char *format;
+
+			strbuf_addstr(&sb_rm, path);
+
+			if (!remove_dir_recursively(&sb_rm, 0))
+				format = _("Cleared directory '%s'\n");
+			else
+				format = _("Could not remove submodule work tree '%s'\n");
+
+			if (!(flags & OPT_QUIET))
+				printf(format, displaypath);
+
+			mode = st.st_mode;
+
+			strbuf_release(&sb_rm);
+		}
+	}
+
+	if (mkdir(path, mode))
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
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+		BUG("module_list_compute should not choke on empty pathspec");
+
+	info.prefix = prefix;
+	if (quiet)
+		info.flags |= OPT_QUIET;
+	if (force)
+		info.flags |= OPT_FORCE;
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
+	for_each_listed_submodule(&list, deinit_submodule_cb, &info);
+
+	return 0;
+}
+
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, struct string_list *reference,
 			   int quiet, int progress)
@@ -1690,6 +1842,7 @@ static struct cmd_struct commands[] = {
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
2.14.2

