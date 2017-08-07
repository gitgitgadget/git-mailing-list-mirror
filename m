Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B21A2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbdHGVT3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:19:29 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38637 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbdHGVT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:19:27 -0400
Received: by mail-pg0-f66.google.com with SMTP id 123so1386578pga.5
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=krulgLHChop5y9rKMw/ZtT2Wh4b8qw/RyFUlG/aIxoQ=;
        b=cpEerZUejnTuej4383HMBqqPoIFgUd4rlza4zKFp9xAeoTxfL3wb+OxY01mD7K2pIP
         s6LXcKU1UADE68HK8xOnnC2M5T+dfWtcIjWJoNBr6/lBwcE/48r+8AcM0emZLNp6kCdS
         ZISwpt8H50hRgBX/A13CcrS/v26glKaZLL2tIppBxw1kdxT4qbuNbPZ/Z2irVOFTM4mV
         vhHiQRrgtcL7FFUFmVJvT3wZ34bgcDJbCHEdZaGpyq57Ul/mEwc9IoiiiHnPzsTxCT0I
         0qbbYMF2Xv8Xk8uV7hL09qPv4Z4RSfvSIxr/CkUBEYYUr3sgnHnscZQ2ktMgvzommN47
         Po4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=krulgLHChop5y9rKMw/ZtT2Wh4b8qw/RyFUlG/aIxoQ=;
        b=Rnr5xiGK6jIEfN3I5yRxeA6Y7sn/NErgct59zkZHY3gSwv/GlrIQGxwBuyrfbJ2DIj
         ovunRqwbEyI9pEtk/Ve6GQKETWS2M6lsI5vO7DWd+YKa8JmdFt8QhkHWtepbNkW5/htr
         5KHTtNiGAjpIs8TBZfBTL5odjlgLZ6UDaWDjRNL4qTLmdkCh1ISfFR7gF5CzUSlXyVZr
         MBfvp//aAYDrFdeeHMHOl0Z8KLG0JvVLp6/2q0gq2TOdF0CXV4jDuBiB3mShlM0eTmlm
         hd4UTS+OQi3hP0+cQt2oN5d4Fnbf19vSPWGc+Xshr8tmXJbfJ5flEf+LGT2OkQEAgaq0
         qUqA==
X-Gm-Message-State: AHYfb5hlafJSRX9K3MDF66SoQF2p6l98mew1uq3l3QkDV2Luzr8YVE5E
        OPNFetRe7llfru7hh94=
X-Received: by 10.84.232.72 with SMTP id f8mr2045313pln.361.1502140766939;
        Mon, 07 Aug 2017 14:19:26 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6016:3285:fd77:5453:49e2:f3b5])
        by smtp.gmail.com with ESMTPSA id z127sm15141084pfb.64.2017.08.07.14.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 14:19:26 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 04/13] submodule: port submodule subcommand 'status' from shell to C
Date:   Tue,  8 Aug 2017 02:48:51 +0530
Message-Id: <20170807211900.15001-5-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170807211900.15001-1-pc44800@gmail.com>
References: <20170807211900.15001-1-pc44800@gmail.com>
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
 builtin/submodule--helper.c | 156 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  49 +-------------
 2 files changed, 157 insertions(+), 48 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 421eee1e2..1bf7bb2a2 100644
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
+	if (!submodule_from_path(null_sha1, list_item->name))
+		die(_("no submodule mapping found in .gitmodules for path '%s'"),
+		      list_item->name);
+
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
+
+	if (list_item->ce_flags) {
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

