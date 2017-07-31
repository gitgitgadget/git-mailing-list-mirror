Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6DF1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbdGaU5E (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:57:04 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38776 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbdGaU5C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:57:02 -0400
Received: by mail-pg0-f68.google.com with SMTP id 125so18814001pgi.5
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6dJCqInG1H7zUrxLYPewrE0SFAkvO8lTfxysI4mlgPg=;
        b=Nxpl0zEvnon3RHspPgiXQIj8xI2Y5mwSzBGGt5qKVBE35qozlIJ53sTb20CzJeUJjJ
         1gy1rpOkwY+mr5CKexnfBuruTxnnX/hI34oov5qXQA2QuetG/jS6K04k6cJ8U6H2YkuP
         WL3VkNr7mKJ2ZaF7nhciLwfFdapILm+K70DSGPZ7rw09tnXPyqvU+R18iFVBcMfSUxIq
         tgMS/p3TRtCznQAoV8SnObKK3JSVQnxzLiUn6Bf8HI1fJ9N/ldyT4nhx5QjnOOF2JQt2
         /51hSgel/mGmOn2c7Aj1jdCQv/V0xlZRsMWouZ5f5O2NFgaBcHTt4Q25JpD/bSF3BrY7
         sO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6dJCqInG1H7zUrxLYPewrE0SFAkvO8lTfxysI4mlgPg=;
        b=ij50kZ1M7o4+xorrELA347SlrMgjsI0Yf80LkwMQhMo1IomFJrGFkO2UvozB6/0nCN
         Yi2Q7qXF8UP25V8961wz3GwI0inHCQ2KI8S3Q7NKvoZ3eyyS3OkfxNH1Fv+XlD6+Xmvn
         u8rZUVSMGI6tWG0nExDbsJmmSRgHugukjYoc6fb0eV47VUHd/5YAHVhmQG0ZRF0UZrPO
         qUZx0l3uEnHgmvQ9HHQpvcHwSKK4MzWc3MyzRXGi2LyK8ROkhxC7rvH2eGswSwj0AAQs
         xXx0bccQe8zK35JV8rsPipx3PBMZm4re83NbIXQtKnuo7eUaMcR9xppp5YccY8pzqXXB
         YnQg==
X-Gm-Message-State: AIVw113tD0oUm+hefHFNhA6BjKhVhfJFnRFLfrhjowV/uz+IF01vyaUV
        Si9C37IF2i2cy74+nepvlA==
X-Received: by 10.84.194.195 with SMTP id h61mr19028835pld.140.1501534621508;
        Mon, 31 Jul 2017 13:57:01 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6182:3b53:5da6:3508:cb8e:5545])
        by smtp.gmail.com with ESMTPSA id 16sm52881007pfq.151.2017.07.31.13.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 13:57:00 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 06/13] submodule: port submodule subcommand 'deinit' from shell to C
Date:   Tue,  1 Aug 2017 02:26:14 +0530
Message-Id: <20170731205621.24305-7-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170731205621.24305-1-pc44800@gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com>
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
index 91945337f..f642f9889 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -913,6 +913,149 @@ static int module_sync(int argc, const char **argv, const char *prefix)
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
@@ -1643,6 +1786,7 @@ static struct cmd_struct commands[] = {
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

