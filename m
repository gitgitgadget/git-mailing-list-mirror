Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F7EE201CF
	for <e@80x24.org>; Sun, 21 May 2017 12:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753500AbdEUM6t (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 08:58:49 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34393 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752767AbdEUM6r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 08:58:47 -0400
Received: by mail-pf0-f196.google.com with SMTP id w69so14468374pfk.1
        for <git@vger.kernel.org>; Sun, 21 May 2017 05:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8qJT+DU0KhjkUpX8lcpSrblTuCyycQ3jScFKfvaoy80=;
        b=pmd7KtWJDa142ieZgHTltOYIUechh5ntv7C/i4qLewPUTPvSSoQeY53tVZwjKuktFJ
         vWrxYfmPPGCDWQPB+/j1S2Xi9gtaunzR7jfheDbRrCEBltpoTw8+IEOBy3MmXBzTPNiU
         JXtNLweHMt/CHPA3Ioc/mEpBeeM0R1P5c1hIbzYdwwhViDnxjtjtB0ggFP0vZ/haPnh5
         YfPyvhN/tcQ4bo8bIHF6x3KAMnENBaYog7jIuvcMaasQL3VMJihIWpVqoicqHIK7/+P6
         2SHvrTkKZxm0NfOy90f4mJbYs0ldwIWsgtcuIoA4fciM2KiR+xdov4TrnEkR7xjb/QCG
         hgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8qJT+DU0KhjkUpX8lcpSrblTuCyycQ3jScFKfvaoy80=;
        b=IorZ1YHNAKibA0QqxSYue3Db03IHBrVwLgtculeEoRYY40V26A8u/AT3/rdK2ZFh5i
         eRBEqIkJAu56GgAconA27NOv/X0nHPR4ECo0uFmwMGk7At6B10IrXyZQSiiCT8thLoGq
         JNQRUvMEAHEqHp7F/1BpAlREJqmahvW/ZBX9UzxjRldACcObN83EGvS3w2nrNXKToozR
         JsrvATbaW9RxrTMpIYpFYiorrmtK6Fve/7JO6TjBD7EGL3dkjCLDtM1zGpqY4Js5kH1H
         GHhQoz3vYnB2AimD7Evlh27ziR6eE9a8ZQiIsPXZvd4b7fw6Avfuv5w6CYwdFwRDte/R
         NXDw==
X-Gm-Message-State: AODbwcB/4tmFtDAX738Xiewr+yJiHxHu88en+54N/4vp/5mr8Il3cZB9
        JU2s9INhS93nfIKQBw0=
X-Received: by 10.98.51.129 with SMTP id z123mr20337151pfz.100.1495371526698;
        Sun, 21 May 2017 05:58:46 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.73.225])
        by smtp.gmail.com with ESMTPSA id i63sm24835982pgc.26.2017.05.21.05.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 May 2017 05:58:46 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, peff@peff.net,
        bmwill@google.com, ramsay@ramsayjones.plus.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v4 2/2] submodule: port subcommand foreach from shell to C
Date:   Sun, 21 May 2017 18:28:14 +0530
Message-Id: <20170521125814.26255-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170521125814.26255-1-pc44800@gmail.com>
References: <20170515183405.GA79147@google.com>
 <20170521125814.26255-1-pc44800@gmail.com>
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

The commit 1c4fb136db (submodule foreach: skip eval for more than one
argument, 2013-09-27), which explains that why for the case when argc>1,
we do not use eval. But since in this patch, we are calling the
command in a separate shell itself for all values of argc, this case
is not considered separately.

Both env variable $path and $sm_path were added since both are used in
tests in t7407.

Helped-by: Brandon Williams <bmwill@google.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
This series of patch is based on gitster/jk/bug-to-abort for untilizing its
BUG() macro.

In this new version of patch, a new function
get_submodule_displaypath is introduced, which is the same one
as that in the patch series for porting of submodule subcommand
status. I had to again introduce this in this patch as well as
I am working on two separate branches for parting of each function.
Also, the function for_each_submodule_list repeats for the same
reason.

I have pushed this work on Github at:
https://github.com/pratham-pc/git/commits/foreach

Its build report is available at:
https://travis-ci.org/pratham-pc/git/builds/
Branch: foreach
Build #67

I have also made some changes in git-submodule.sh for correcting
the $path variable. And hence made the corresponding changes in
the new test introduced in t7407-submodule-foreach as well.
I have push this work at:
https://github.com/pratham-pc/git/commits/foreach-bug-fixed

Its build report is available at:
https://travis-ci.org/pratham-pc/git/builds/
Branch: foreach-bug-fixed
Build #66

 builtin/submodule--helper.c | 142 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  39 +-----------
 2 files changed, 143 insertions(+), 38 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 566a5b6a6..4e19beaff 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -13,6 +13,8 @@
 #include "refs.h"
 #include "connect.h"
 
+typedef void (*submodule_list_func_t)(const struct cache_entry *list_item, void *cb_data);
+
 static char *get_default_remote(void)
 {
 	char *dest = NULL, *ret;
@@ -219,6 +221,23 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
+static char *get_submodule_displaypath(const char *path, const char *prefix)
+{
+	const char *super_prefix = get_super_prefix();
+
+	if (prefix && super_prefix) {
+		BUG("cannot have prefix '%s' and superprefix '%s'",
+		    prefix, super_prefix);
+	} else if (prefix) {
+		struct strbuf sb = STRBUF_INIT;
+		return xstrdup(relative_path(path, prefix, &sb));
+	} else if (super_prefix) {
+		return xstrfmt("%s/%s", super_prefix, path);
+	} else {
+		return xstrdup(path);
+	}
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -331,6 +350,15 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static void for_each_submodule_list(const struct module_list list, submodule_list_func_t fn, void *cb_data)
+{
+	int i;
+	for (i = 0; i < list.nr; i++)
+		fn(list.entries[i], cb_data);
+
+	return;
+}
+
 static void init_submodule(const char *path, const char *prefix, int quiet)
 {
 	const struct submodule *sub;
@@ -487,6 +515,119 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct cb_foreach {
+	int argc;
+	const char **argv;
+	const char *prefix;
+	unsigned int quiet: 1;
+	unsigned int recursive: 1;
+};
+#define CB_FOREACH_INIT { 0, NULL, 0, 0 }
+
+static void runcommand_in_submodule(const struct cache_entry *list_item, void *cb_data)
+{
+	struct cb_foreach *info = cb_data;
+	char *toplevel = xgetcwd();
+	const struct submodule *sub;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	char* displaypath = NULL;
+	int i;
+
+	/* Only loads from .gitmodules, no overlay with .git/config */
+	gitmodules_config();
+
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
+
+	sub = submodule_from_path(null_sha1, list_item->name);
+
+	if (!sub)
+		die(_("No url found for submodule path '%s' in .gitmodules"),
+		      displaypath);
+
+	prepare_submodule_repo_env(&cp.env_array);
+	cp.use_shell = 1;
+	cp.dir = list_item->name;
+
+	argv_array_pushf(&cp.env_array, "name=%s", sub->name);
+	argv_array_pushf(&cp.env_array, "sm_path=%s", displaypath);
+	argv_array_pushf(&cp.env_array, "path=%s", list_item->name);
+	argv_array_pushf(&cp.env_array, "sha1=%s", oid_to_hex(&list_item->oid));
+	argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
+
+	for (i = 0; i < info->argc; i++)
+		argv_array_push(&cp.args, info->argv[i]);
+
+	if (!is_submodule_populated_gently(list_item->name, NULL))
+		return;
+
+	if (!info->quiet)
+		printf(_("Entering '%s'\n"), displaypath);
+	if (info->argv[0] && run_command(&cp))
+		die(_("run_command returned non-zero status for %s\n."), displaypath);
+
+	if (info->recursive) {
+		struct child_process cpr = CHILD_PROCESS_INIT;
+
+		cpr.use_shell = 1;
+		cpr.dir = list_item->name;
+		prepare_submodule_repo_env(&cpr.env_array);
+
+		argv_array_pushl(&cpr.args, "git", "--super-prefix", displaypath,
+				 "submodule--helper", "foreach", "--recursive", NULL);
+
+		if (info->quiet)
+			argv_array_push(&cpr.args, "--quiet");
+
+		for (i = 0; i < info->argc; i++)
+			argv_array_push(&cpr.args, info->argv[i]);
+
+		if (run_command(&cpr))
+			die(_("run_command returned non-zero status while \
+			      recuring in the nested submodules of %s\n."),
+			      displaypath);
+	}
+
+	free(displaypath);
+	free(toplevel);
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
+		die("BUG: module_list_compute should not choke on empty pathspec");
+
+	info.argc = argc;
+	info.argv = argv;
+	info.prefix = prefix;
+	info.quiet = !!quiet;
+	info.recursive = !!recursive;
+
+	for_each_submodule_list(list, runcommand_in_submodule, &info);
+
+	return 0;
+}
+
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, struct string_list *reference,
 			   int quiet, int progress)
@@ -1212,6 +1353,7 @@ static struct cmd_struct commands[] = {
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index c0d0e9a4c..032fd2540 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -322,45 +322,8 @@ cmd_foreach()
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
2.11.0

