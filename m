Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3923D1FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 13:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbdJFNYi (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 09:24:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36735 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbdJFNYh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 09:24:37 -0400
Received: by mail-pf0-f193.google.com with SMTP id u12so3971426pfl.3
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 06:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xLtov9eXDEZuKryLx2Z5n7MwrFgjxq9KcljYsY7ERpc=;
        b=IIvCnJFErdMisruNE9kPBxnmzGq9jOpaIp42WL89id8GPTbXrFIpwR72dQfMTT9H7E
         AUqcznSGG3NyJwAt9b0soFO8/mXR9W19W5+9i5Q1/R3UFXBXssmt0/BYaThlN3ZCPv3U
         OTxu5r89LeimHqFJISiUHg0pK/kqth7oNIS+t2y+XwHqGsz55cQMPyWtFrHK5sjiE90A
         c94yMKhmMkJE2Ld7/b2HItiUOaljJQIj0gqpY8Q64oH3/Wq7p6NhMTfEvoTXcL9dDh9p
         T/8e1GK7FrnXvuJ27WcttF8MYgH782nS6L/QP/lzeqHwIrZLaElClfRX5tOeVktVo9U/
         6ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xLtov9eXDEZuKryLx2Z5n7MwrFgjxq9KcljYsY7ERpc=;
        b=iLN1WjcamJfZCUSwAZmPQHkFl4dAqLLtw+M4/d0Jz7p5mc2eia832HGTEBGmUm9rPy
         PBU4boWkm0zSkJY8h51OWxH7rRtSjoj81Iy2pQeiLAWkoXmy5tN3DpH1TuF/uIkGVtUg
         n6p1IMt9THZbV/YFbs7nIR9GOscWtastVuWpN0Qzf1vHmTUcdutU/uQbJmppNtwaP9te
         GD3fZ8oVgzFXMvkL+Mxu/EFD1Hg0quNhhJYvK8hkO1FE5LumYUkN9h+Kq/E0jj+0SYcI
         6r2yQVoldpoA2P/qX0lPREgu16eub9kCaGhrc0vVS5WmprC95WE+Q6BQ/slxNGTWvnqN
         SHlQ==
X-Gm-Message-State: AMCzsaXKiqd9+VOWrv80jdemtvs/GtMt/7aBB5rwrCpAr4VvpSrXXf+N
        Mzm51cCUIwyN6qWNjPWWMQI=
X-Google-Smtp-Source: AOwi7QCcFQpypZ9IuH+sec92FCr3ORhfQy7RFohx7iC+CRG2ZhsZSJPefNG1jGM2hpGOv6QsgxFRtg==
X-Received: by 10.84.179.129 with SMTP id b1mr1981423plc.166.1507296276393;
        Fri, 06 Oct 2017 06:24:36 -0700 (PDT)
Received: from localhost.localdomain ([42.110.180.199])
        by smtp.gmail.com with ESMTPSA id b23sm3770939pfm.148.2017.10.06.06.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 06:24:35 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, hanwen@google.com,
        pc44800@gmail.com, sbeller@google.com
Subject: [PATCH v7 3/3] submodule: port submodule subcommand 'status' from shell to C
Date:   Fri,  6 Oct 2017 18:54:15 +0530
Message-Id: <20171006132415.2876-4-pc44800@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171006132415.2876-1-pc44800@gmail.com>
References: <xmqqy3ouqruh.fsf@gitster.mtv.corp.google.com>
 <20171006132415.2876-1-pc44800@gmail.com>
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
 builtin/submodule--helper.c | 198 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  61 +-------------
 2 files changed, 199 insertions(+), 60 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 29e3fde16..d366e8e7b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -13,8 +13,13 @@
 #include "remote.h"
 #include "refs.h"
 #include "connect.h"
+#include "revision.h"
+#include "diffcore.h"
+#include "diff.h"
 
 #define OPT_QUIET (1 << 0)
+#define OPT_CACHED (1 << 1)
+#define OPT_RECURSIVE (1 << 2)
 
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
@@ -244,6 +249,44 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
 	}
 }
 
+static char *compute_rev_name(const char *sub_path, const char* object_id)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char ***d;
+
+	static const char *describe_bare[] = { NULL };
+
+	static const char *describe_tags[] = { "--tags", NULL };
+
+	static const char *describe_contains[] = { "--contains", NULL };
+
+	static const char *describe_all_always[] = { "--all", "--always", NULL };
+
+	static const char **describe_argv[] = { describe_bare, describe_tags,
+						describe_contains,
+						describe_all_always, NULL };
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
@@ -503,6 +546,160 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct status_cb {
+	const char *prefix;
+	unsigned int flags;
+};
+
+#define STATUS_CB_INIT { NULL, 0 }
+
+static void print_status(unsigned int flags, char state, const char *path,
+			 const struct object_id *oid, const char *displaypath)
+{
+	if (flags & OPT_QUIET)
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
+			     unsigned int flags)
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
+		print_status(flags, 'U', path, &null_oid, displaypath);
+		goto cleanup;
+	}
+
+	if (!is_submodule_active(the_repository, path)) {
+		print_status(flags, '-', path, ce_oid, displaypath);
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
+	diff_files_args.argc = setup_revisions(diff_files_args.argc,
+					       diff_files_args.argv,
+					       &rev, NULL);
+	diff_files_result = run_diff_files(&rev, 0);
+
+	if (!diff_result_code(&rev.diffopt, diff_files_result)) {
+		print_status(flags, ' ', path, ce_oid,
+			     displaypath);
+	} else if (!(flags & OPT_CACHED)) {
+		struct object_id oid;
+
+		if (refs_head_ref(get_submodule_ref_store(path),
+				  handle_submodule_head_ref, &oid))
+			die(_("could not resolve HEAD ref inside the"
+			      "submodule '%s'"), path);
+
+		print_status(flags, '+', path, &oid, displaypath);
+	} else {
+		print_status(flags, '+', path, ce_oid, displaypath);
+	}
+
+	if (flags & OPT_RECURSIVE) {
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
+		if (flags & OPT_CACHED)
+			argv_array_push(&cpr.args, "--cached");
+
+		if (flags & OPT_QUIET)
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
+			 info->prefix, info->flags);
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
+		OPT_BIT(0, "cached", &info.flags, N_("Use commit stored in the index instead of the one stored in the submodule HEAD"), OPT_CACHED),
+		OPT_BIT(0, "recursive", &info.flags, N_("recurse into nested submodules"), OPT_RECURSIVE),
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
+		info.flags |= OPT_QUIET;
+
+	for_each_listed_submodule(&list, status_submodule_cb, &info);
+
+	return 0;
+}
+
 static int module_name(int argc, const char **argv, const char *prefix)
 {
 	const struct submodule *sub;
@@ -1300,6 +1497,7 @@ static struct cmd_struct commands[] = {
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
2.14.2

