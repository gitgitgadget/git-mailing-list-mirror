Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 416352047F
	for <e@80x24.org>; Fri, 29 Sep 2017 09:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbdI2JpP (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 05:45:15 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37331 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdI2JpL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 05:45:11 -0400
Received: by mail-pg0-f65.google.com with SMTP id 125so1067201pgj.4
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VMczH406sdaXEmZvcqFgZk6cwWQuOUlRc8dD3xnEZvw=;
        b=F9f92ScyjMJdTC3Pltu4WBF8qzE6w8lH5g7dsTKJ7VF/XdUzOhXVu7oYGe+hcvx9O4
         wAknOcqgbuFX4E2j2zqO9GWOwwkA32LDhDzJvXiTpH4WKQoiqRSASytEKFxw1Q6m6Sxu
         OuMvNDChm5CzOqZxhdfsPBpXH+dNQgeA7IQ2dsikdGGfdR1FzLEBfgJOUCmAvlWPPerc
         fgYxncVbeL6p865trvH+HLnETE6G6UdSVKzyUbh8vivbXShI01oEY1iau4/4nGTfegLd
         ccx5ICbfx3Nl8eeDu5icHxujesR/s2wCGdVPMgDDIIrYAafKVG3Fxb0WcuQOSSgJMtM9
         MAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VMczH406sdaXEmZvcqFgZk6cwWQuOUlRc8dD3xnEZvw=;
        b=mIgikn5ObgP7euIvyI5mku7ZIxsK5Ky+nb99rOPBnwd2YLReI9scV3zbDOb7pHpnPn
         gwKYcOp8mOMlO9gMiTATx7xFruUhzVIW3EKbWmbDaQrNrsQqZ6YQx65CesqUeTpB7p3q
         2uOBnVWRn9QnnzHQpLWwcpCVbydCbbyznzcqQTiFovIXKHLmoWFWOzkVGOtt9HekTlr5
         EP62y4nxZfLbyvBQzZszQg6i+5k5qU/p+5beAH3Hj0aynKtG7e1Mg1cYm+vTeq1WdnOH
         zg8zcRwcGL91B4ejrBZTX7doZqDrO4gUMs5cuGIMt5YstmebpJMF0ehEfgkXnbEWVV9W
         TT4g==
X-Gm-Message-State: AHPjjUg1FfqPkppD2sE69wJKWLLpRgyDc0U5X1Y4RpJWw4KL4m4FkVRS
        R3k28mxqcItbcTHlyNmbroU=
X-Google-Smtp-Source: AOwi7QA8954Kd/QMNaHRlu/DP8aBzkmbaVbjnVZTnAARNYk3EFHcyRf3k71Py/JPawMmYMcsBbLIqw==
X-Received: by 10.98.86.73 with SMTP id k70mr6688166pfb.345.1506678310918;
        Fri, 29 Sep 2017 02:45:10 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.87])
        by smtp.gmail.com with ESMTPSA id s76sm6930477pfj.119.2017.09.29.02.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 02:45:10 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, hanwen@google.com,
        sbeller@google.com, Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v6 3/3] submodule: port submodule subcommand 'status' from shell to C
Date:   Fri, 29 Sep 2017 15:14:53 +0530
Message-Id: <20170929094453.4499-4-pc44800@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20170929094453.4499-1-pc44800@gmail.com>
References: <xmqq4lrrfjt9.fsf@gitster.mtv.corp.google.com>
 <20170929094453.4499-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This aims to make git-submodule 'status' a built-in. Hence, the function
cmd_status() is ported from shell to C. This is done by introducing
four functions: module_status(), submodule_status_cb(),
submodule_status() and print_status().

The function module_status() acts as the front-end of the subcommand.
It parses subcommand's options and then calls the function
module_list_compute() for computing the list of submodules. Then
this functions calls for_each_listed_submodule() looping through the
list obtained.

Then for_each_listed_submodule() calls submodule_status_cb() for each of
the submodule in its list. The function submodule_status_cb() calls
submodule_status() after passing appropriate arguments to the funciton.
Function submodule_status() is responsible for generating the status
each submodule it is called for, and then calls print_status().

Finally, the function print_status() handles the printing of submodule's
status.

Function set_name_rev() is also ported from git-submodule to the
submodule--helper builtin function compute_rev_name(), which now
generates the value of the revision name as required.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 207 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  61 +------------
 2 files changed, 208 insertions(+), 60 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 20a1ef868..50d38fc20 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -13,8 +13,13 @@
 #include "remote.h"
 #include "refs.h"
 #include "connect.h"
+#include "revision.h"
+#include "diffcore.h"
+#include "diff.h"
 
 #define CB_OPT_QUIET		(1<<0)
+#define CB_OPT_CACHED		(1<<1)
+#define CB_OPT_RECURSIVE	(1<<2)
 
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
@@ -245,6 +250,53 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
 	}
 }
 
+static char *compute_rev_name(const char *sub_path, const char* object_id)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char ***d;
+
+	static const char *describe_bare[] = {
+		NULL
+	};
+
+	static const char *describe_tags[] = {
+		"--tags", NULL
+	};
+
+	static const char *describe_contains[] = {
+		"--contains", NULL
+	};
+
+	static const char *describe_all_always[] = {
+		"--all", "--always", NULL
+	};
+
+	static const char **describe_argv[] = {
+		describe_bare, describe_tags, describe_contains,
+		describe_all_always, NULL
+	};
+
+	for (d = describe_argv; *d; d++) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		prepare_submodule_repo_env(&cp.env_array);
+		cp.dir = sub_path;
+		cp.git_cmd = 1;
+		cp.no_stderr = 1;
+
+		argv_array_push(&cp.args, "describe");
+		argv_array_pushv(&cp.args, *d);
+		argv_array_push(&cp.args, object_id);
+
+		if (!capture_command(&cp, &sb, 0)) {
+			strbuf_strip_suffix(&sb, "\n");
+			return strbuf_detach(&sb, NULL);
+		}
+	}
+
+	strbuf_release(&sb);
+	return NULL;
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -503,6 +555,160 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct status_cb {
+	const char *prefix;
+	unsigned int cb_flags;
+};
+#define STATUS_CB_INIT { NULL, 0 }
+
+static void print_status(unsigned int flags, char state, const char *path,
+			 const struct object_id *oid, const char *displaypath)
+{
+	if (flags & CB_OPT_QUIET)
+		return;
+
+	printf("%c%s %s", state, oid_to_hex(oid), displaypath);
+
+	if (state == ' ' || state == '+')
+		printf(" (%s)", compute_rev_name(path, oid_to_hex(oid)));
+
+	printf("\n");
+}
+
+static int handle_submodule_head_ref(const char *refname,
+				     const struct object_id *oid, int flags,
+				     void *cb_data)
+{
+	struct object_id *output = cb_data;
+	if (oid)
+		oidcpy(output, oid);
+
+	return 0;
+}
+
+static void status_submodule(const char *path, const struct object_id *ce_oid,
+			     unsigned int ce_flags, const char *prefix,
+			     unsigned int cb_flags)
+{
+	char *displaypath;
+	struct argv_array diff_files_args = ARGV_ARRAY_INIT;
+	struct rev_info rev;
+	int diff_files_result;
+
+	if (!submodule_from_path(&null_oid, path))
+		die(_("no submodule mapping found in .gitmodules for path '%s'"),
+		      path);
+
+	displaypath = get_submodule_displaypath(path, prefix);
+
+	if ((CE_STAGEMASK & ce_flags) >> CE_STAGESHIFT) {
+		print_status(cb_flags, 'U', path, &null_oid, displaypath);
+		goto cleanup;
+	}
+
+	if (!is_submodule_active(the_repository, path)) {
+		print_status(cb_flags, '-', path, ce_oid, displaypath);
+		goto cleanup;
+	}
+
+	argv_array_pushl(&diff_files_args, "diff-files",
+			 "--ignore-submodules=dirty", "--quiet", "--",
+			 path, NULL);
+
+	git_config(git_diff_basic_config, NULL);
+	init_revisions(&rev, prefix);
+	rev.abbrev = 0;
+	precompose_argv(diff_files_args.argc, diff_files_args.argv);
+	diff_files_args.argc = setup_revisions(diff_files_args.argc,
+					       diff_files_args.argv,
+					       &rev, NULL);
+	diff_files_result = run_diff_files(&rev, 0);
+
+	if (!diff_result_code(&rev.diffopt, diff_files_result)) {
+		print_status(cb_flags, ' ', path, ce_oid,
+			     displaypath);
+	} else if (!(cb_flags & CB_OPT_CACHED)) {
+		struct object_id oid;
+
+		if (refs_head_ref(get_submodule_ref_store(path),
+				  handle_submodule_head_ref, &oid))
+			die(_("could not resolve HEAD ref inside the"
+			      "submodule '%s'"), path);
+
+		print_status(cb_flags, '+', path, &oid, displaypath);
+	} else {
+		print_status(cb_flags, '+', path, ce_oid, displaypath);
+	}
+
+	if (cb_flags & CB_OPT_RECURSIVE) {
+		struct child_process cpr = CHILD_PROCESS_INIT;
+
+		cpr.git_cmd = 1;
+		cpr.dir = path;
+		prepare_submodule_repo_env(&cpr.env_array);
+
+		argv_array_push(&cpr.args, "--super-prefix");
+		argv_array_pushf(&cpr.args, "%s/", displaypath);
+		argv_array_pushl(&cpr.args, "submodule--helper", "status",
+				 "--recursive", NULL);
+
+		if (cb_flags & CB_OPT_CACHED)
+			argv_array_push(&cpr.args, "--cached");
+
+		if (cb_flags & CB_OPT_QUIET)
+			argv_array_push(&cpr.args, "--quiet");
+
+		if (run_command(&cpr))
+			die(_("failed to recurse into submodule '%s'"), path);
+	}
+
+cleanup:
+	argv_array_clear(&diff_files_args);
+	free(displaypath);
+}
+
+static void status_submodule_cb(const struct cache_entry *list_item,
+				void *cb_data)
+{
+	struct status_cb *info = cb_data;
+	status_submodule(list_item->name, &list_item->oid, list_item->ce_flags,
+			 info->prefix, info->cb_flags);
+}
+
+static int module_status(int argc, const char **argv, const char *prefix)
+{
+	struct status_cb info = STATUS_CB_INIT;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+	int quiet = 0;
+
+	struct option module_status_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress submodule status output")),
+		OPT_BIT(0, "cached", &info.cb_flags, N_("Use commit stored in the index instead of the one stored in the submodule HEAD"), CB_OPT_CACHED),
+		OPT_BIT(0, "recursive", &info.cb_flags, N_("recurse into nested submodules"), CB_OPT_RECURSIVE),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule status [--quiet] [--cached] [--recursive] [<path>...]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_status_options,
+			     git_submodule_helper_usage, 0);
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+		return 1;
+
+	info.prefix = prefix;
+	if (quiet)
+		info.cb_flags |= CB_OPT_QUIET;
+
+	for_each_listed_submodule(&list, status_submodule_cb, &info);
+
+	return 0;
+}
+
 static int module_name(int argc, const char **argv, const char *prefix)
 {
 	const struct submodule *sub;
@@ -1300,6 +1506,7 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
+	{"status", module_status, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 66d1ae8ef..156255a9e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -758,18 +758,6 @@ cmd_update()
 	}
 }
 
-set_name_rev () {
-	revname=$( (
-		sanitize_submodule_env
-		cd "$1" && {
-			git describe "$2" 2>/dev/null ||
-			git describe --tags "$2" 2>/dev/null ||
-			git describe --contains "$2" 2>/dev/null ||
-			git describe --all --always "$2"
-		}
-	) )
-	test -z "$revname" || revname=" ($revname)"
-}
 #
 # Show commit summary for submodules in index or working tree
 #
@@ -1016,54 +1004,7 @@ cmd_status()
 		shift
 	done
 
-	{
-		git submodule--helper list --prefix "$wt_prefix" "$@" ||
-		echo "#unmatched" $?
-	} |
-	while read -r mode sha1 stage sm_path
-	do
-		die_if_unmatched "$mode" "$sha1"
-		name=$(git submodule--helper name "$sm_path") || exit
-		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
-		if test "$stage" = U
-		then
-			say "U$sha1 $displaypath"
-			continue
-		fi
-		if ! git submodule--helper is-active "$sm_path" ||
-		{
-			! test -d "$sm_path"/.git &&
-			! test -f "$sm_path"/.git
-		}
-		then
-			say "-$sha1 $displaypath"
-			continue;
-		fi
-		if git diff-files --ignore-submodules=dirty --quiet -- "$sm_path"
-		then
-			set_name_rev "$sm_path" "$sha1"
-			say " $sha1 $displaypath$revname"
-		else
-			if test -z "$cached"
-			then
-				sha1=$(sanitize_submodule_env; cd "$sm_path" && git rev-parse --verify HEAD)
-			fi
-			set_name_rev "$sm_path" "$sha1"
-			say "+$sha1 $displaypath$revname"
-		fi
-
-		if test -n "$recursive"
-		then
-			(
-				prefix="$displaypath/"
-				sanitize_submodule_env
-				wt_prefix=
-				cd "$sm_path" &&
-				eval cmd_status
-			) ||
-			die "$(eval_gettext "Failed to recurse into submodule path '\$sm_path'")"
-		fi
-	done
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} "$@"
 }
 #
 # Sync remote urls for submodules
-- 
2.13.0

