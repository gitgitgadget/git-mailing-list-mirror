Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1725B207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 23:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbdFZXL2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 19:11:28 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33481 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdFZXL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 19:11:26 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so1954721pgb.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 16:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kOGxuUQp27Y78BAsqH1ZUqY7SUY1ZdssQJCRBQqQLtc=;
        b=nf8RVvG74o2tBQwDWYsTzqJvzFiBoCpiXD40MDZEo8rFv28RI9WDG5g0oXofAH1Npc
         nwxw9t47qk7qeez9UxTphVT4y4qnYmbQB93FkTS9rrkqtzNwsVfrCGmf9tL4nkUi/xua
         c8AiCTIKvvE+mH8s74WYKEVFVvid2nJJFjJ1Jm4MP+ss/Aoh2rF8YCPD05zy0IdgEjB+
         AOl8QzoBN+bCLgpqhUc10vVNS8p+RgRHORTa2NnNzNURS1ZVdeFN7BvkixG8zUbpnd5X
         mlPU1ophkhOJnp70Hlr9ezmrLjsa0TbKmqSttwjp50m3V98sSoLM3S0yMWmR/72iwAw4
         4BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kOGxuUQp27Y78BAsqH1ZUqY7SUY1ZdssQJCRBQqQLtc=;
        b=tnVgS02x8Zba+8PwpzmHL+UzrhEiUWC5XjsY+oe5c5Zl2hS9qd/1YSyOsBEZwVYmQM
         FzmhuBX6OgevOZVg/AihpuCrGuMprTNT7mHYRKd6dt82FFVkMlZwzxl8UZuUjslq1ch/
         bjalKfXuxeB3rHydvkQDhis+ziXzxVgwFr9bB2oGOvkzddkPc9v+GpVL/CuqfK1sz/7o
         7RBCWH/+MQzKJnLCqv1yt0gOzcJecn6DtOo7gdLvvI0QRzH/9CW83KNlcIGKFnnLW856
         On1FOgzdlu+/LML+0KK9AFboSN1Zz50u74DzUa9+6znSjV4xefvQ881b4gwETNjEl8iJ
         pFRg==
X-Gm-Message-State: AKS2vOxzJlwEdsJDErlsoK676QJYXI3R3rC/k0AeEtgQEqdt+c3qNLR5
        Ee8R+OFjxFTJOA==
X-Received: by 10.84.171.197 with SMTP id l63mr2538967plb.167.1498518685243;
        Mon, 26 Jun 2017 16:11:25 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id p5sm1701339pgf.50.2017.06.26.16.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 16:11:24 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     pc44800@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, sbeller@google.com
Subject: [GSoC][PATCH 2/6 v2] submodule: port subcommand foreach from shell to C
Date:   Tue, 27 Jun 2017 04:41:04 +0530
Message-Id: <20170626231108.23640-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170626231108.23640-1-pc44800@gmail.com>
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
 <20170626231108.23640-1-pc44800@gmail.com>
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

Function get_initial_wt_prefix_up_path is introduced to take care of
generating the value for path variable(as it was in the shell script)

Helped-by: Brandon Williams <bmwill@google.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
This patch suggestes the current status of the foreach patch.
Work is still needed on this patch for eleminating the hack
used in this patch for generating path variable.

 builtin/submodule--helper.c | 163 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  39 +----------
 2 files changed, 164 insertions(+), 38 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c4286aac5..5180659fd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -517,6 +517,168 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static char *get_initial_wt_prefix_up_path(char *path)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *p = path;
+
+	while (*p) {
+		if (skip_prefix(p, "./", &p))
+			continue;
+		if (!skip_prefix(p, "../", &p))
+			break;
+		strbuf_addstr(&sb, "../");
+	}
+
+	return strbuf_detach(&sb, NULL);
+}
+
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
+
+		/*
+		 * NEEDSWORK: Here function get_initial_wt_prefix_up_path is
+		 * used as a hack for evaluating the value of the path
+		 * variable. The proper way would have been to store and use
+		 * the prefix of the repository, where first subcommand
+		 * foreach was executed and then evaluate path as
+		 * relative_path(list_item->name, prefix) for each submodule.
+		 */
+		char *initial_wt_prefix_up_path = get_initial_wt_prefix_up_path(displaypath);
+		char *toplevel = xgetcwd();
+		argv_array_pushf(&cp.env_array, "name=%s", sub->name);
+		argv_array_pushf(&cp.env_array, "sm_path=%s%s",
+				 initial_wt_prefix_up_path, list_item->name);
+		argv_array_pushf(&cp.env_array, "sha1=%s",
+				 oid_to_hex(&list_item->oid));
+		argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
+
+		/*
+		 * NEEDSWORK: The value currently assigned to path variable
+		 * is same as that before porting, but it deviates
+		 * from its documented value: "$path is the name of the
+		 * submodule directory relative to the superproject", in
+		 * the case when subcommand foreach is called recursively
+		 * from a subdirectory.
+		 * This is beacuse it is currently relative path from cwd
+		 * to the submodule. In the nested case the intermediate
+		 * submodules are elided, such that it is a bogus path.
+		 */
+		argv_array_pushf(&cp.args, "path=%s%s; %s",
+				 initial_wt_prefix_up_path, list_item->name,
+				 info->argv[0]);
+		free(initial_wt_prefix_up_path);
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
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, struct string_list *reference,
 			   int quiet, int progress)
@@ -1242,6 +1404,7 @@ static struct cmd_struct commands[] = {
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index e131760ee..c88e0ff7e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -323,45 +323,8 @@ cmd_foreach()
 		shift
 	done
 
-	toplevel=$(pwd)
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} "$@"
 
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
-				sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
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
 }
 
 #
-- 
2.13.0

