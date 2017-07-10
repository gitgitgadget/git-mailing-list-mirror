Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D080320357
	for <e@80x24.org>; Mon, 10 Jul 2017 22:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755048AbdGJWyb (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 18:54:31 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35466 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755041AbdGJWya (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 18:54:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id q85so16304937pfq.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZgbCbh3NNu94/6zwtwXea6mswN1b4mS279c26hE9wvs=;
        b=josDvDPp0B2j4g61PA+6szzn3FJDbkyB8YwpaE9cS1gwr4hjMNT15KBTz/FnkUSgO2
         zgRb1AEgLHHNRC1eurnQ7NZEuJB57uEOuKF18g6+39pwNnH36bWl4lADKEZOTnOe7xLt
         YVVcRwE0veRb4QqcVkX7GCoaqUbPshX6kVRzNTApzpQ9DXpUZICi9PDC+KK3AT8mOVfd
         giJGcOGFCMLEPS3VueJGAjTQGYn45tn4qwDe524d8dWzhgcFm7U6j3j0cCkgnml4P2OG
         sXh3en7jlBTVLVmRc3scUjKU1ySsaXcTMK9ta7veK9cQRW1hFEZlhHWDcncI92Ei2kCq
         Dz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZgbCbh3NNu94/6zwtwXea6mswN1b4mS279c26hE9wvs=;
        b=r75FVvNqYHhHnuHtj+ZsyFlQK1l59F1DruLCnxoBWWQXYNmQwOC3Zj9io7/hBjvuFX
         aTh5+dxDhWL8bHkwXaaopQhak8f9FC/ib8EXiGR4y6kZ/RRS1LffQaaGAP+5Aaf06myC
         mgMjHbTDgaY7LiyOaSoPo/WnQ/49hOy5/SI41P0J2lrGnHZEewX/i/cjIu864KEve9Ag
         Vnp8pYHK/shujxQepQB5FC/AgZt3IZvvRI/08EqQrsai7NJBNBpyBA7I9mEFwGjucLV+
         hKmdUJbXxdX2ydoffRBUPmWxO9X7mCpUPrR7ZzlTsue2+oeNzfw992Y3yvWyUPYaUrWX
         AzYA==
X-Gm-Message-State: AIVw111R8ssn2ZbZNoak6mjJEDoSGFE7Ixsi5NEVnW7e1z3Y0AbGKjF/
        0JS6x9dSYBnnwzI8
X-Received: by 10.99.123.18 with SMTP id w18mr16983392pgc.122.1499727269100;
        Mon, 10 Jul 2017 15:54:29 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id o6sm20586774pgs.43.2017.07.10.15.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 15:54:28 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 4/8] submodule: port submodule subcommand 'status' from shell to C
Date:   Tue, 11 Jul 2017 04:24:03 +0530
Message-Id: <20170710225407.29344-4-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170710225407.29344-1-pc44800@gmail.com>
References: <CAME+mvU_8-S4AhTtMYm1L6PK81v23wu4EuB+EnOgkDhi=jo9Rg@mail.gmail.com>
 <20170710225407.29344-1-pc44800@gmail.com>
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
 builtin/submodule--helper.c | 154 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  49 +-------------
 2 files changed, 155 insertions(+), 48 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 80f744407..980b8ed27 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -560,6 +560,159 @@ static int module_init(int argc, const char **argv, const char *prefix)
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
+			 char *sub_sha1, char *displaypath)
+{
+	if (info->quiet)
+		return;
+
+	printf("%c%s %s", state, sub_sha1, displaypath);
+
+	if (state == ' ' || state == '+') {
+		struct argv_array name_rev_args = ARGV_ARRAY_INIT;
+
+		argv_array_pushl(&name_rev_args, "print-name-rev",
+				 path, sub_sha1, NULL);
+		print_name_rev(name_rev_args.argc, name_rev_args.argv,
+			       info->prefix);
+	} else {
+		printf("\n");
+	}
+}
+
+static void status_submodule(const struct cache_entry *list_item, void *cb_data)
+{
+	struct status_cb *info = cb_data;
+	char *sub_sha1 = xstrdup(oid_to_hex(&list_item->oid));
+	char *displaypath;
+	struct argv_array diff_files_args = ARGV_ARRAY_INIT;
+
+	if (!submodule_from_path(null_sha1, list_item->name))
+		die(_("no submodule mapping found in .gitmodules for path '%s'"),
+		      list_item->name);
+
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
+
+	if (list_item->ce_flags) {
+		print_status(info, 'U', list_item->name,
+			     sha1_to_hex(null_sha1), displaypath);
+		goto cleanup;
+	}
+
+	if (!is_submodule_active(the_repository, list_item->name)) {
+		print_status(info, '-', list_item->name, sub_sha1, displaypath);
+		goto cleanup;
+	}
+
+	argv_array_pushl(&diff_files_args, "diff-files",
+			 "--ignore-submodules=dirty", "--quiet", "--",
+			 list_item->name, NULL);
+
+	/* NEEDSWORK: future optimization possible */
+	if (!cmd_diff_files(diff_files_args.argc, diff_files_args.argv,
+			    info->prefix)) {
+		print_status(info, ' ', list_item->name, sub_sha1, displaypath);
+	} else {
+		if (!info->cached) {
+			struct child_process cp = CHILD_PROCESS_INIT;
+			struct strbuf sb = STRBUF_INIT;
+
+			prepare_submodule_repo_env(&cp.env_array);
+			cp.git_cmd = 1;
+			cp.dir = list_item->name;
+
+			argv_array_pushl(&cp.args, "rev-parse",
+					 "--verify", "HEAD", NULL);
+
+			/* NEEDSWORK: future optimization possible */
+			if (capture_command(&cp, &sb, 0))
+				die(_("could not run 'git rev-parse --verify"
+				      "HEAD' in submodule %s"),
+				      list_item->name);
+
+			strbuf_strip_suffix(&sb, "\n");
+			print_status(info, '+', list_item->name, sb.buf,
+				     displaypath);
+			strbuf_release(&sb);
+		} else {
+			print_status(info, '+', list_item->name, sub_sha1,
+				     displaypath);
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
+	free(displaypath);
+	free(sub_sha1);
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
@@ -1306,6 +1459,7 @@ static struct cmd_struct commands[] = {
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

