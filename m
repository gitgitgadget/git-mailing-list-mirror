Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08E761F667
	for <e@80x24.org>; Mon, 21 Aug 2017 10:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753194AbdHUKpw (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 06:45:52 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36374 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752695AbdHUKpv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 06:45:51 -0400
Received: by mail-pg0-f65.google.com with SMTP id y129so23251912pgy.3
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 03:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0MnphIdZT36MDXZHBCa0E97rjuPMD5Owx/NEw86GOSM=;
        b=A2hJOcigynah5CnMrVNXSmB0hr4zXZoLUYMYpGC1c7QYd4yia3M2YBSf9SXJJcQUP+
         8LsIaIlMNmSmE7/GIUAdPPRW413x8BUkEbvCoN/1NaMqpaXqVCmvLNuxCwvhUn4qU17i
         7FIE5+oo5wnLAxbmEQ7tgxYklKHgUalDklwhvpqiCMd3uHQHTOw+7lFK9dN2BVFBwss0
         7yZmZdK6uDW+XY1Gml4ROKV3dmYabUs9qfuDmKYjU2O3Z1XrutgjP+WJbp/8EV0VBlg2
         fjm2R5wB3EzrqJxikIxXQZgCVql0wMiesp8R8+9ZlvtK++XeyLjHEp+iH9JdOvbt3AOu
         oBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0MnphIdZT36MDXZHBCa0E97rjuPMD5Owx/NEw86GOSM=;
        b=TEJp/8kfTcip4EOThFkXaSkIQlbddlYlzJBJN3j/BrMPPat5/eclSJD2S/pXJQos5U
         adrAfdwJUVcMMlFlZcJIr76O6NhmXB/4czR9J8Xr1OpWqCOOgAKWUTY8WVZJEKTwCpQ0
         zaaa8b7JTMIaPLITWa/Rrgzp/i5NzPWF/xUru6ENoMWhd6SPm23ANPPnDc9BHFwftUm6
         G4jpKTHot7ZgA2QGUxeJWeHNt0ycSRolAdUi0//8m5MtleM63+9makt4y9laV38xuCLQ
         ePzXefDxzzmCs3IUwTer9IsYVYA1dhyoifYxTVbPRgpJhORuE7io7Ag3zA0m79ngSnIl
         0dTg==
X-Gm-Message-State: AHYfb5gUxIwbRrfPS3QvZ+YAy43hbiyE4Ms4WWfxSgZw59SeQ7P3Rq2R
        3NllX5mOUQxWH/LL6fI=
X-Received: by 10.84.130.42 with SMTP id 39mr19180292plc.60.1503312350553;
        Mon, 21 Aug 2017 03:45:50 -0700 (PDT)
Received: from localhost.localdomain ([223.191.53.21])
        by smtp.gmail.com with ESMTPSA id l24sm20445785pgo.43.2017.08.21.03.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Aug 2017 03:45:50 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 4/4] submodule: port submodule subcommand 'status' from shell to C
Date:   Mon, 21 Aug 2017 21:45:15 +0530
Message-Id: <20170821161515.23775-4-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170821161515.23775-1-pc44800@gmail.com>
References: <20170821161515.23775-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This aims to make git-submodule 'status' a built-in. Hence, the function
cmd_status() is ported from shell to C. This is done by introducing
three functions: module_status(), submodule_status() and print_status().

The function module_status() acts as the front-end of the subcommand.
It parses subcommand's options and then calls the function
module_list_compute() for computing the list of submodules. Then
this functions calls for_each_submodule_list() looping through the
list obtained.

Then for_each_submodule_list() calls submodule_status() for each of the
submodule in its list. The function submodule_status() is responsible
for generating the status each submodule it is called for, and
then calls print_status().

Finally, the function print_status() handles the printing of submodule's
status.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
The patch below underwent some changes after its previous version.

In the shell script, the submodules, which had merge-conflicts are
identified by checking if the $stage variable has the value 'U'
Till the last patch series, this was done by checking if ce_flags have
a non-zero value. In this new patch series, this was changed and
instead ce_stage() was called on the list_item(cache_entry), and then
we check whether it has a non-zero value.

 builtin/submodule--helper.c | 156 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  49 +-------------
 2 files changed, 157 insertions(+), 48 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a4bff3f38..831370d6e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -560,6 +560,161 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct status_cb {
+	const char *prefix;
+	unsigned int quiet: 1;
+	unsigned int recursive: 1;
+	unsigned int cached: 1;
+};
+#define STATUS_CB_INIT { NULL, 0, 0, 0 }
+
+static void print_status(struct status_cb *info, char state, const char *path,
+			 const struct object_id *oid, const char *displaypath)
+{
+	if (info->quiet)
+		return;
+
+	printf("%c%s %s", state, oid_to_hex(oid), displaypath);
+
+	if (state == ' ' || state == '+') {
+		struct argv_array name_rev_args = ARGV_ARRAY_INIT;
+
+		argv_array_pushl(&name_rev_args, "print-name-rev",
+				 path, oid_to_hex(oid), NULL);
+		print_name_rev(name_rev_args.argc, name_rev_args.argv,
+			       info->prefix);
+
+		argv_array_clear(&name_rev_args);
+	} else {
+		printf("\n");
+	}
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
+static void status_submodule(const struct cache_entry *list_item, void *cb_data)
+{
+	struct status_cb *info = cb_data;
+	char *displaypath;
+	struct argv_array diff_files_args = ARGV_ARRAY_INIT;
+
+	if (!submodule_from_path(&null_oid, list_item->name))
+		die(_("no submodule mapping found in .gitmodules for path '%s'"),
+		      list_item->name);
+
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
+
+	if (ce_stage(list_item)) {
+		print_status(info, 'U', list_item->name,
+			     &null_oid, displaypath);
+		goto cleanup;
+	}
+
+	if (!is_submodule_active(the_repository, list_item->name)) {
+		print_status(info, '-', list_item->name, &list_item->oid,
+			     displaypath);
+		goto cleanup;
+	}
+
+	argv_array_pushl(&diff_files_args, "diff-files",
+			 "--ignore-submodules=dirty", "--quiet", "--",
+			 list_item->name, NULL);
+
+	if (!cmd_diff_files(diff_files_args.argc, diff_files_args.argv,
+			    info->prefix)) {
+		print_status(info, ' ', list_item->name, &list_item->oid,
+			     displaypath);
+	} else {
+		if (!info->cached) {
+			struct object_id oid;
+
+			if (head_ref_submodule(list_item->name,
+					       handle_submodule_head_ref, &oid))
+				die(_("could not resolve HEAD ref inside the"
+				      "submodule '%s'"), list_item->name);
+
+			print_status(info, '+', list_item->name, &oid,
+				     displaypath);
+		} else {
+			print_status(info, '+', list_item->name,
+				     &list_item->oid, displaypath);
+		}
+	}
+
+	if (info->recursive) {
+		struct child_process cpr = CHILD_PROCESS_INIT;
+
+		cpr.git_cmd = 1;
+		cpr.dir = list_item->name;
+		prepare_submodule_repo_env(&cpr.env_array);
+
+		argv_array_pushl(&cpr.args, "--super-prefix", displaypath,
+				 "submodule--helper", "status", "--recursive",
+				 NULL);
+
+		if (info->cached)
+			argv_array_push(&cpr.args, "--cached");
+
+		if (info->quiet)
+			argv_array_push(&cpr.args, "--quiet");
+
+		if (run_command(&cpr))
+			die(_("failed to recurse into submodule '%s'"),
+			      list_item->name);
+	}
+
+cleanup:
+	argv_array_clear(&diff_files_args);
+	free(displaypath);
+}
+
+static int module_status(int argc, const char **argv, const char *prefix)
+{
+	struct status_cb info = STATUS_CB_INIT;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+	int quiet = 0;
+	int cached = 0;
+	int recursive = 0;
+
+	struct option module_status_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress submodule status output")),
+		OPT_BOOL(0, "cached", &cached, N_("Use commit stored in the index instead of the one stored in the submodule HEAD")),
+		OPT_BOOL(0, "recursive", &recursive, N_("Recurse into nested submodules")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule status [--quiet] [--cached] [--recursive] [<path>]"),
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
+	info.quiet = !!quiet;
+	info.recursive = !!recursive;
+	info.cached = !!cached;
+
+	gitmodules_config();
+	for_each_submodule_list(list, status_submodule, &info);
+
+	return 0;
+}
+
 static int module_name(int argc, const char **argv, const char *prefix)
 {
 	const struct submodule *sub;
@@ -1306,6 +1461,7 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"print-name-rev", print_name_rev, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
+	{"status", module_status, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index e988167e0..51b057d82 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1005,54 +1005,7 @@ cmd_status()
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
-			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
-			say " $sha1 $displaypath$revname"
-		else
-			if test -z "$cached"
-			then
-				sha1=$(sanitize_submodule_env; cd "$sm_path" && git rev-parse --verify HEAD)
-			fi
-			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
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

