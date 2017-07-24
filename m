Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60847203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 20:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754704AbdGXUgJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 16:36:09 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35051 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753423AbdGXUgI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 16:36:08 -0400
Received: by mail-pg0-f67.google.com with SMTP id d193so12635758pgc.2
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 13:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MnQ0y2uJr+zLiCKyYdbgnMgjCT957AXP/+n7NkG/4a0=;
        b=uC4ZVC2A03J8oL7FQ1QMOuwjgwcvQphsJE11vq7e1gEkFZrdcAh1Kklselm0JkQvGO
         KnmpEdIhbdeXOOPtOz+mybXgRn1Tw7QZ5UFt/iDorx/WNYt7k58V8cvzl2f4rydO7kbl
         CO15De/s+c5ThyX81aM0iRb+AJJLPj1dHsVJam0r4HAkSx8+jncKAFqRh+2Tr1+R33Df
         hcIpA2YhJqBBkMPBzDeEAxaSd1kvif17xLwQxfND7k84y00Whlw4XuHh/BnOZk+Z37DM
         w94gPOCcQxEwMccFb5DxcIxOfk/qN13TeCuLfzI3kgV6vZy8rGZ7mlMOHfLtj/0bpXTL
         miMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MnQ0y2uJr+zLiCKyYdbgnMgjCT957AXP/+n7NkG/4a0=;
        b=Zcz17kvtf5M5PB7fq642okrvpFuP6eiX5TLTJtZArL+GrfqNtDOvZa27sIWGpz5EtG
         BNX8A0n3PhGe2x9aum92XRSteFSjd4lOc4fzWrDWjyyG6exoqEonFtPojSpeRshyFb1C
         cwQSOKIHGNd/96urQJWXAlemUBTnptR5iFFi2xIOeTDqpG04vaqv4nzWiT+7Iu4xvtnW
         Mms/NLyC97WjYDh9fEQU8IdSWFBUKKzxOLlcyOXuq/8ateqXDtLZpcZ7dj+xPRB+7Z5V
         KLVOIW1+XlDHBp/4Bp2xyZ05yCQ9V4iM+C0CEpZFLTDgi8THP36sPCczZUGi7C+P8z3m
         FQzA==
X-Gm-Message-State: AIVw1123U9BYsq2/VkrBSX+O4f/f6SDW36pc14OZwbz3/EtepZin48ku
        Gw7acKGM1MAmrYdrrAE=
X-Received: by 10.84.210.203 with SMTP id a69mr18958783pli.399.1500928568204;
        Mon, 24 Jul 2017 13:36:08 -0700 (PDT)
Received: from localhost.localdomain ([47.11.10.170])
        by smtp.gmail.com with ESMTPSA id d19sm24313984pfe.24.2017.07.24.13.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 13:36:07 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 13/13] submodule: port submodule subcommand 'foreach' from shell to C
Date:   Tue, 25 Jul 2017 02:04:54 +0530
Message-Id: <20170724203454.13947-14-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170724203454.13947-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This aims to make git-submodule foreach a builtin. This is the very
first step taken in this direction. Hence, 'foreach' is ported to
submodule--helper, and submodule--helper is called from git-submodule.sh.
The code is split up to have one function to obtain all the list of
submodules. This function acts as the front-end of git-submodule foreach
subcommand. It calls the function for_each_submodule_list, which basically
loops through the list and calls function fn, which in this case is
runcommand_in_submodule. This third function is a calling function that
takes care of running the command in that submodule, and recursively
perform the same when --recursive is flagged.

The first function module_foreach first parses the options present in
argv, and then with the help of module_list_compute, generates the list of
submodules present in the current working tree.

The second function for_each_submodule_list traverses through the
list, and calls function fn (which in case of submodule subcommand
foreach is runcommand_in_submodule) is called for each entry.

The third function runcommand_in_submodule, generates a submodule struct sub
for $name, value and then later prepends name=sub->name; and other
value assignment to the env argv_array structure of a child_process.
Also the <command> of submodule-foreach is push to args argv_array
structure and finally, using run_command the commands are executed
using a shell.

The third function also takes care of the recursive flag, by creating
a separate child_process structure and prepending "--super-prefix displaypath",
to the args argv_array structure. Other required arguments and the
input <command> of submodule-foreach is also appended to this argv_array.

Helped-by: Brandon Williams <bmwill@google.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 129 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  39 +-------------
 2 files changed, 130 insertions(+), 38 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 94d6254f0..be278bf8d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -765,6 +765,134 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct cb_foreach {
+	int argc;
+	const char **argv;
+	const char *prefix;
+	unsigned int quiet: 1;
+	unsigned int recursive: 1;
+};
+#define CB_FOREACH_INIT { 0, NULL, NULL, 0, 0 }
+
+static void runcommand_in_submodule(const struct cache_entry *list_item,
+				    void *cb_data)
+{
+	struct cb_foreach *info = cb_data;
+	const struct submodule *sub;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	char *displaypath;
+
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
+
+	sub = submodule_from_path(null_sha1, list_item->name);
+
+	if (!sub)
+		die(_("No url found for submodule path '%s' in .gitmodules"),
+		      displaypath);
+
+	if (!is_submodule_populated_gently(list_item->name, NULL))
+		goto cleanup;
+
+	prepare_submodule_repo_env(&cp.env_array);
+	/* For the purpose of executing <command> in the submodule,
+	 * separate shell is used for the purpose of running the
+	 * child process.
+	 */
+	cp.use_shell = 1;
+	cp.dir = list_item->name;
+
+	if (info->argc == 1) {
+		char *toplevel = xgetcwd();
+
+		argv_array_pushf(&cp.env_array, "name=%s", sub->name);
+		argv_array_pushf(&cp.env_array, "sm_path=%s", list_item->name);
+		argv_array_pushf(&cp.env_array, "displaypath=%s", displaypath);
+		argv_array_pushf(&cp.env_array, "sha1=%s",
+				 oid_to_hex(&list_item->oid));
+		argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
+
+		/*
+		 * Since still the path variable was accessible from the
+		 * script before porting, it is also made available.
+		 */
+		argv_array_pushf(&cp.args, "path=%s; %s",
+				 list_item->name, info->argv[0]);
+		free(toplevel);
+	} else {
+		argv_array_pushv(&cp.args, info->argv);
+	}
+
+	if (!info->quiet)
+		printf(_("Entering '%s'\n"), displaypath);
+
+	if (info->argv[0] && run_command(&cp))
+		die(_("run_command returned non-zero status for %s\n."),
+		      displaypath);
+
+	if (info->recursive) {
+		struct child_process cpr = CHILD_PROCESS_INIT;
+
+		cpr.git_cmd = 1;
+		cpr.dir = list_item->name;
+		prepare_submodule_repo_env(&cpr.env_array);
+
+		argv_array_pushl(&cpr.args, "--super-prefix", displaypath,
+				 "submodule--helper", "foreach", "--recursive",
+				 NULL);
+
+		if (info->quiet)
+			argv_array_push(&cpr.args, "--quiet");
+
+		argv_array_pushv(&cpr.args, info->argv);
+
+		if (run_command(&cpr))
+			die(_("run_command returned non-zero status while"
+			      "recursing in the nested submodules of %s\n."),
+			      displaypath);
+	}
+
+cleanup:
+	free(displaypath);
+}
+
+static int module_foreach(int argc, const char **argv, const char *prefix)
+{
+	struct cb_foreach info;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+	int quiet = 0;
+	int recursive = 0;
+
+	struct option module_foreach_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress output of entering each submodule command")),
+		OPT_BOOL(0, "recursive", &recursive,
+			 N_("Recurse into nested submodules")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper foreach [--quiet] [--recursive] <command>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_foreach_options,
+			     git_submodule_helper_usage, PARSE_OPT_KEEP_UNKNOWN);
+
+	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
+		BUG("module_list_compute should not choke on empty pathspec");
+
+	info.argc = argc;
+	info.argv = argv;
+	info.prefix = prefix;
+	info.quiet = !!quiet;
+	info.recursive = !!recursive;
+
+	gitmodules_config();
+	for_each_submodule_list(list, runcommand_in_submodule, &info);
+
+	return 0;
+}
+
 struct module_cb {
 	unsigned int mod_src;
 	unsigned int mod_dst;
@@ -2203,6 +2331,7 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"print-name-rev", print_name_rev, 0},
+	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
 	{"print-default-remote", print_default_remote, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 493a64372..e25b2c613 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -298,44 +298,7 @@ cmd_foreach()
 		shift
 	done
 
-	toplevel=$(pwd)
-
-	# dup stdin so that it can be restored when running the external
-	# command in the subshell (and a recursive call to this function)
-	exec 3<&0
-
-	{
-		git submodule--helper list --prefix "$wt_prefix" ||
-		echo "#unmatched" $?
-	} |
-	while read -r mode sha1 stage sm_path
-	do
-		die_if_unmatched "$mode" "$sha1"
-		if test -e "$sm_path"/.git
-		then
-			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
-			say "$(eval_gettext "Entering '\$displaypath'")"
-			name=$(git submodule--helper name "$sm_path")
-			(
-				prefix="$prefix$sm_path/"
-				sanitize_submodule_env
-				cd "$sm_path" &&
-				# we make $path available to scripts ...
-				path=$sm_path &&
-				if test $# -eq 1
-				then
-					eval "$1"
-				else
-					"$@"
-				fi &&
-				if test -n "$recursive"
-				then
-					cmd_foreach "--recursive" "$@"
-				fi
-			) <&3 3<&- ||
-			die "$(eval_gettext "Stopping at '\$displaypath'; script returned non-zero status.")"
-		fi
-	done
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} "$@"
 }
 
 #
-- 
2.13.0

