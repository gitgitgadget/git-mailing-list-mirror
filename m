Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730DE1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 04:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeBBE6O (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 23:58:14 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46428 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeBBE6J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 23:58:09 -0500
Received: by mail-pf0-f193.google.com with SMTP id w69so3200028pfd.13
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 20:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l6DIHb+i7rEXUt5RRG32LguETr78IVcZLNUsnSYz8go=;
        b=g4l31kE68sPiatddkvHIcZZx5gUCtjpxTguOWZdc2iTQD74Ce39JJfsSKeAkHhxhNL
         woTtElS/03jhRAd7Luqopespfe4t/JRI1WLSP4gPMRDMYxomYasAWZLXYRtCJaDGoB3V
         kUaXpTVmTGAj4kX8hyB0eBYuRca75pmAfBZkNJU6qFFzIvd0r5lTFlNNRS5CFljmUZ4X
         b+WbtFOMQmXzU1OiqDpHEm+zxU3heidAi5qpVbY8pUrjoGJztJRHnpRrI6W68iCLXu4t
         ymv2sSzWrCxOEdWOzyGlSZXeb5X0McJT7W9GXO6btEDDHetM63trWEyjuzm1S4tKCLw0
         WldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l6DIHb+i7rEXUt5RRG32LguETr78IVcZLNUsnSYz8go=;
        b=Yxz8T6jbZZ7AzoA0psXIJz5szDcrc3ljUKKp11WhF66XQMCZ8ZGN5yVJF5+/mZvYXf
         /n9ADCp0FX+O8yq98diW84B8tAouzYyruxuRotE/XnYhDsyLEJbTxkphSbARKQAxp/4y
         MLs4g8smPupNA9wh1kVlmM9Cn2hocREKFg5rv5OV+JquLtMalQHqCS82Pt1az2jtTgKA
         3hGuuwDiEOMUxGJNg19xzUUFiqMZzjyXfwvvHRtiGHxHNJnkU3lA5VffcxoE0By18lt+
         bkoKrXfR2mRjGdXpQD28+X+JzavvpQ2qhAyJyD8syW8XoRPx63O4Jx1qhe7emqzaAdL5
         tItA==
X-Gm-Message-State: AKwxyteCtbGq0z74aELg6857Z3zzEWAQ6OU1K6WHTSEnYViZp9Ms4IPE
        sY1krZAeb5/4z7krNTpAiH+y3T6x
X-Google-Smtp-Source: AH8x2278Fje9XZyJhWa8PNa4hynQ9uL/XRUv+twV7lo7NkEtDfP+dhAHviH/qaut+lj67BxwmFxF0A==
X-Received: by 10.98.108.130 with SMTP id h124mr39086016pfc.33.1517547488979;
        Thu, 01 Feb 2018 20:58:08 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.200])
        by smtp.gmail.com with ESMTPSA id e3sm1496467pfb.143.2018.02.01.20.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 20:58:08 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, sbeller@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [PATCH v1 5/5] submodule: port submodule subcommand 'foreach' from shell to C
Date:   Fri,  2 Feb 2018 10:27:45 +0530
Message-Id: <20180202045745.5076-6-pc44800@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180202045745.5076-1-pc44800@gmail.com>
References: <20180202045745.5076-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This aims to make git-submodule foreach a builtin. This is the very
first step taken in this direction. Hence, 'foreach' is ported to
submodule--helper, and submodule--helper is called from git-submodule.sh.
The code is split up to have one function to obtain all the list of
submodules. This function acts as the front-end of git-submodule foreach
subcommand. It calls the function for_each_listed_submodule(), which basically
loops through the list and calls function fn, which in this case is
runcommand_in_submodule_cb(). This third function is a callback function that
calls runcommand_in_submodule() with the appropriate parameters and then
takes care of running the command in that submodule, and recursively
performing the same when --recursive is flagged.

The first function module_foreach first parses the options present in
argv, and then with the help of module_list_compute(), generates the list of
submodules present in the current working tree.

The second function for_each_listed_submodule() traverses through the
list, and calls function fn (which in case of submodule subcommand
foreach is runcommand_in_submodule_cb()) is called for each entry.

The third function runcommand_in_submodule_cb() calls the function
runcommand_in_submodule() after passing appropraite parameters.

The fourth function runcommand_in_submodule(), generates a submodule struct sub
for $name, value and then later prepends name=sub->name; and other
value assignment to the env argv_array structure of a child_process.
Also the <command> of submodule-foreach is push to args argv_array
structure and finally, using run_command the commands are executed
using a shell.

The fourth function also takes care of the recursive flag, by creating
a separate child_process structure and prepending "--super-prefix displaypath",
to the args argv_array structure. Other required arguments and the
input <command> of submodule-foreach is also appended to this argv_array.

Helped-by: Brandon Williams <bmwill@google.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 151 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  39 +-----------
 2 files changed, 152 insertions(+), 38 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a5c4a8a69..46dee6bf5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -718,6 +718,156 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct cb_foreach {
+	int argc;
+	const char **argv;
+	const char *prefix;
+	unsigned int flags;
+};
+#define CB_FOREACH_INIT { 0, NULL, NULL, 0 }
+
+static void runcommand_in_submodule(const char *path, const struct object_id *ce_oid,
+				    int argc, const char **argv, const char *prefix,
+				    unsigned int flags)
+{
+	const struct submodule *sub;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	char *displaypath;
+
+	displaypath = get_submodule_displaypath(path, prefix);
+
+	sub = submodule_from_path(&null_oid, path);
+
+	if (!sub)
+		die(_("No url found for submodule path '%s' in .gitmodules"),
+		      displaypath);
+
+	if (!is_submodule_populated_gently(path, NULL))
+		goto cleanup;
+
+	prepare_submodule_repo_env(&cp.env_array);
+
+	/*
+	 * For the purpose of executing <command> in the submodule,
+	 * separate shell is used for the purpose of running the
+	 * child process.
+	 */
+	cp.use_shell = 1;
+	cp.dir = path;
+
+	/*
+	 * NEEDSWORK: the command currently has access to the variables $name,
+	 * $sm_path, $displaypath, $sha1 and $toplevel only when the command
+	 * contains a single argument. This is done for maintianing a faithful
+	 * translation from shell script.
+	 */
+	if (argc == 1) {
+		char *toplevel = xgetcwd();
+
+		argv_array_pushf(&cp.env_array, "name=%s", sub->name);
+		argv_array_pushf(&cp.env_array, "sm_path=%s", path);
+		argv_array_pushf(&cp.env_array, "displaypath=%s", displaypath);
+		argv_array_pushf(&cp.env_array, "sha1=%s",
+				 oid_to_hex(ce_oid));
+		argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
+
+		/*
+		 * Since the path variable was accessible from the script
+		 * before porting, it is also made available after porting.
+		 * The environment variable "PATH" has a very special purpose
+		 * on windows. And since environment variables are
+		 * case-insensitive in windows, it interferes with the
+		 * existing PATH variable. Hence, to avoid that, we expose
+		 * path via the args argv_array and not via env_array.
+		 */
+		argv_array_pushf(&cp.args, "path=%s; %s",
+				 path, argv[0]);
+		free(toplevel);
+	} else {
+		argv_array_pushv(&cp.args, argv);
+	}
+
+	if (!(flags & OPT_QUIET))
+		printf(_("Entering '%s'\n"), displaypath);
+
+	if (argv[0] && run_command(&cp))
+		die(_("run_command returned non-zero status for %s\n."),
+		      displaypath);
+
+	if (flags & OPT_RECURSIVE) {
+		struct child_process cpr = CHILD_PROCESS_INIT;
+
+		cpr.git_cmd = 1;
+		cpr.dir = path;
+		prepare_submodule_repo_env(&cpr.env_array);
+
+		argv_array_pushl(&cpr.args, "--super-prefix", NULL);
+		argv_array_pushf(&cpr.args, "%s/", displaypath);
+		argv_array_pushl(&cpr.args, "submodule--helper", "foreach", "--recursive",
+				 NULL);
+
+		if (flags & OPT_QUIET)
+			argv_array_push(&cpr.args, "--quiet");
+
+		argv_array_pushv(&cpr.args, argv);
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
+static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
+				       void *cb_data)
+{
+	struct cb_foreach *info = cb_data;
+	runcommand_in_submodule(list_item->name, &list_item->oid, info->argc,
+				info->argv, info->prefix, info->flags);
+}
+
+static int module_foreach(int argc, const char **argv, const char *prefix)
+{
+	struct cb_foreach info = CB_FOREACH_INIT;
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
+	if (quiet)
+		info.flags |= OPT_QUIET;
+	if (recursive)
+		info.flags |= OPT_RECURSIVE;
+
+	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
+
+	return 0;
+}
+
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, struct string_list *reference,
 			   int quiet, int progress)
@@ -1496,6 +1646,7 @@ static struct cmd_struct commands[] = {
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 7305ee25f..7627e27c8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -323,44 +323,7 @@ cmd_foreach()
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
2.15.1

