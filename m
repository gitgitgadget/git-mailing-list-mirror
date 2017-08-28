Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67EC1F4DD
	for <e@80x24.org>; Mon, 28 Aug 2017 11:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbdH1L4j (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 07:56:39 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33507 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdH1L4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 07:56:38 -0400
Received: by mail-pg0-f67.google.com with SMTP id m15so218794pgc.0
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rJKf2xU6mzXymlokIZgFIrWK5kCa3/ESQVvrEh640cE=;
        b=RYtnIFRVJ/ZHKsIIHvFZi/f19WkNJvFwiJNvkM0iDK2KYkmkcMxNRlu6+d81s39g+Y
         dBzrgyyRE/0wskF5gEtthsUrT/YytgMF01jJ4XYQLxIluho2jyB6VWMobk7TPinrLc08
         JVjuJ1JkAdMCdlhDCWaXSKljHR3fvufPMICqwA5hwq2b/LNDpu19Nj+W4wWVGsFe1ggd
         GguQh0td5DeL++sJWUUEiqBXOzxtZu8Z22iC1tmmaapid1yhicMeKt5Xj97+CSTDtm/E
         O1KR68RdDgYJe+Qmiki8TPr63cQfgJC658CFIGEVHEv4GQJxPRF9/9QW/zsxZZ2NxFh9
         eB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rJKf2xU6mzXymlokIZgFIrWK5kCa3/ESQVvrEh640cE=;
        b=dS4ius7OF8WUXdYT6GFyQFR++p3TUIkIk/qdndCUrtZtk14BtV5Bm8AphJ81Stggkf
         TqaHdzviG9qLJfSpOT1vi3yssUZrDXL0J6Z6DA5Jgy/pZGn5mhxMqgfBHEMujnD5FwAk
         Jli1rvMtZAKI0SyOipoZfca4Bau+xJcdy4Gp3W8OeKwRIJTGDX9/v6IKnnG7ameobudK
         5xHQdwHlDhSXW/cD2WePNqsqnK62ATcoumRHWmjTW1u0TqenZ+zpy5+nMaxT3LY+TOlW
         cNqTwbgqVMddSprYEdrKcTzV6ZPjU9brwqsBY6QJWT7ErkH+70dOyhszfoCFp5Uz91E8
         KQhg==
X-Gm-Message-State: AHYfb5gLa4TfG0cbbywxg+cbBmvBPcnlFg1OIRGrggITqfaAOYgVK4qz
        mX94RtCTE+3XoQ==
X-Received: by 10.99.54.12 with SMTP id d12mr303179pga.370.1503921397551;
        Mon, 28 Aug 2017 04:56:37 -0700 (PDT)
Received: from localhost.localdomain ([223.176.49.60])
        by smtp.gmail.com with ESMTPSA id h70sm748608pfc.92.2017.08.28.04.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Aug 2017 04:56:37 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        sbeller@google.com
Subject: [GSoC][PATCH v4 4/4] submodule: port submodule subcommand 'status' from shell to C
Date:   Mon, 28 Aug 2017 17:25:58 +0530
Message-Id: <20170828115558.28297-5-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170828115558.28297-1-pc44800@gmail.com>
References: <xmqqlgm7scpm.fsf@gitster.mtv.corp.google.com>
 <20170828115558.28297-1-pc44800@gmail.com>
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
this functions calls for_each_listed_submodule() looping through the
list obtained.

Then for_each_listed_submodule() calls submodule_status() for each of the
submodule in its list. The function submodule_status() is responsible
for generating the status each submodule it is called for, and
then calls print_status().

Finally, the function print_status() handles the printing of submodule's
status.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 155 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  49 +-------------
 2 files changed, 156 insertions(+), 48 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 85df11129..abf5c126a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -558,6 +558,160 @@ static int module_init(int argc, const char **argv, const char *prefix)
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
+		struct argv_array get_rev_args = ARGV_ARRAY_INIT;
+
+		argv_array_pushl(&get_rev_args, "get-rev-name",
+				 path, oid_to_hex(oid), NULL);
+		get_rev_name(get_rev_args.argc, get_rev_args.argv,
+			     info->prefix);
+
+		argv_array_clear(&get_rev_args);
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
+	for_each_listed_submodule(&list, status_submodule, &info);
+
+	return 0;
+}
+
 static int module_name(int argc, const char **argv, const char *prefix)
 {
 	const struct submodule *sub;
@@ -1356,6 +1510,7 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"get-rev-name", get_rev_name, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
+	{"status", module_status, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 5211361c5..156255a9e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1004,54 +1004,7 @@ cmd_status()
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
-			revname=$(git submodule--helper get-rev-name "$sm_path" "$sha1")
-			say " $sha1 $displaypath$revname"
-		else
-			if test -z "$cached"
-			then
-				sha1=$(sanitize_submodule_env; cd "$sm_path" && git rev-parse --verify HEAD)
-			fi
-			revname=$(git submodule--helper get-rev-name "$sm_path" "$sha1")
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

