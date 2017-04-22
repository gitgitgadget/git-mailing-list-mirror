Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FBB91FE90
	for <e@80x24.org>; Sat, 22 Apr 2017 19:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161440AbdDVT7Y (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 15:59:24 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34148 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161387AbdDVT7W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2017 15:59:22 -0400
Received: by mail-io0-f196.google.com with SMTP id h41so38532935ioi.1
        for <git@vger.kernel.org>; Sat, 22 Apr 2017 12:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=API9yJ73Z4roI/2wSPVimx+geCCCkZs+sLn9Ali8scA=;
        b=nFDAMDYJ9GGIsAMBU07QTMhqEWY5EzQoW0BRZ7B/qLUwXCJkBqGokxfib2U9HAEBGA
         KNQk5DX6DDJMpQj/F/uj1marC8q6NBfnkSUrUpeDHneg7BqrZyp44NBMKL4Aqwfty/XK
         UoTIKzzz/xwmI9Oh0E0zNBQCrA6VK/S//Gu0s6YDlGbsy7hAxrsy+SBj/eO3CCo8wx8k
         mpjkXsSq1H97DA7+HvH5wfNWXyDYph68zBRJe2uC2TpG52MT1E8gG2DZc/DgP7fBd9+F
         7KqnHXHIvlotEo/sCGM2olrSeNc27nFcCgqLCG/WEdbu2ec1KIXI1lyLWBWDTW5bblPu
         rw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=API9yJ73Z4roI/2wSPVimx+geCCCkZs+sLn9Ali8scA=;
        b=M4Zq0NkLjKDq+tr1wVHPxM3tCZI+xqzZVs6KJCgV6AKfZcb/M+4mIMHX0kuky2xGkF
         vmbqHsRCk3oJbtwLljc5D5WLdRAw6b+JGlVqO5xW5scCIlBzzjlV0I42B2YNZj0Orsf3
         unS4nh4uD6lGIhQJC84A/rNPmEh2MrvwwjMHhog0iF6gauv5qcrLvaY88vxWlg2g1dxa
         hw4uEpiLlHFCDiRFNR8i87968suxPjmDOfZ7oinBEWIJDTVrxYsW7lQMPCBEWNsRV9jo
         8t7Uhv8qw1NO4IJ4DMPLdAeZub5ytDuFBzFOivMWUXx/MD9we+CGoB7VzDHXmPb/us5C
         qSqg==
X-Gm-Message-State: AN3rC/5TQ+LTtpydwgJGTdbdY8nDmVEk6z8J01DIXEASV7noxuzBDdTz
        lS48B+RjApkgBA==
X-Received: by 10.98.25.69 with SMTP id 66mr17933015pfz.84.1492891160302;
        Sat, 22 Apr 2017 12:59:20 -0700 (PDT)
Received: from localhost.localdomain ([47.11.8.153])
        by smtp.gmail.com with ESMTPSA id r1sm22812889pfg.12.2017.04.22.12.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Apr 2017 12:59:19 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, pc44800@gmail.com
Subject: [GSoC][RFC/PATCH v2] submodule: port subcommand foreach from shell to C
Date:   Sun, 23 Apr 2017 01:28:04 +0530
Message-Id: <20170422195804.18477-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAGZ79kYmRe+NURkgxRQM2QsGQEqtp+oGas5H0ryfztx8s2chwA@mail.gmail.com>
References: <CAGZ79kYmRe+NURkgxRQM2QsGQEqtp+oGas5H0ryfztx8s2chwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This aims to make git-submodule foreach a builtin. This is the very
first step taken in this direction. Hence, 'foreach' is ported to
submodule--helper, and submodule--helper is called from git-submodule.sh.
The code is split up to have one function to obtain all the list of
submodules and a calling function that takes care of running the command
in that submodule, and recursively perform the same when --recursive is
flagged.

The First function module_foreach first parses the options present in
argv, and then with the help of module_list_compute, generates the list of
submodules present in the current working tree. Traversing through the
list, foreach_submodule function is called for each entry.

The second function foreach_submodule, generates a submodule struct sub
for $name, value and then later prepends name=sub->name; and other
value assignment to the env argv_array structure of a child_process.
Also the <command> of submodule-foreach is push to args argv_array
structure and finally, using run_command the commands are executed
using a shell.

The second function also takes care of the recursive flag, by creating
a saperate child_process structure and prepending "--super-prefix displaypath",
to the args argv_array structure. Other required arguments and the
input <command> of submodule-foreach is also appended to this argv_array.

Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---

In this new version of patch following changes have been added:

module_list_compute is used to generate the list of submodules present
in the current working tree.

Instead of using argv_array structure, a child_process structure
is been used to set the env variable, and run the given command at the 
specified path with the given arguments.

It was suggested that the quotes of "$@" be removed to avoid passing
the <command> arguments as a single long string. But since quoted
$@ doesn't pass the arguments as a single long string, but instead
passes quoted arguments, in this patch I have kept "$@" unchanged.
Information related to this is available on:
www.gnu.org/software/bash/manual/html_node/Special-Parameters.html

Also, it was observed that just after removal of the quotes of "$@"
present in the git-submodule.sh file, there were a number of tests
from t7407 which failed, and otherwise were passing with "$@".

Some additional changes are also mode which weren't suggested.

Added the flag PARSE_OPT_KEEP_UNKNOWN in the parameters of
parse_options to ignore any option passed as a part of <command>
and not as an option for git-submodule foreach.

Previously, display path showed incorrect output when the command
was executed from with a subdirectory. This occurred due to an incorrect
order of parameter being passed and hence has been corrected.

Additional env variable $sm_path was added, since it was used in
test '"submodule foreach" from subdirectory' in t7407.
I preferred adding this, instead of changing the test case, since
in the case of git-submodule.sh, this env variable was accessible.

I checked-out the commit 1c4fb136db (submodule foreach: skip eval for 
more than one argument, 2013-09-27), which explains that why for 
the case when argc>1, we do not use eval. But since, we are calling the
command in a separate shell itself for all values of argc, hence IMO,
this case need not be considered separately.

The build report of this patch is available at: 
travis-ci.org/pratham-pc/git/builds/224744614 
  
There are still 5 tests which are failing. I have submitted this
as RFC patch for getting suggestions on debugging these
errors and for reviewing the approach taken for porting submodule
'foreach' subcommand to C.
  
I have observed that when we recursively run a command foreach
submodule from a subdirectory, the $path variable as finally obtained
by this patch differs with the $path variable as observed by the 
existing git-submodule code for a nested submodule.

I'll again mention that I have based my branch on
gitster/jk/ls-files-recurse-submodules-fix, since while
using --super-prefix in recursively calling the foreach
command, it produced results indicating that a --super-prefix can't
be used from a subdirectory:

  fatal: can't use --super-prefix from a subdirectory

The patch and the discussion related to it can be found at: 
public-inbox.org/git/20170412003911.1142-1-jacob.e.keller@intel.com/T/#u

Also, in the function foreach_submodule, we call gitmodules_config()
to read values from the worktree .gitmodules and then look up
the information (in this case only the sub->name) by using
submodule_from_path funciton. Since we don't want to
overwrite the null_sha1 entry, only loads from .gitmodules
and avoid overlaying with .git/config.
(also, since this whole process is required only to get the value
og submodule's name, is there some other way by which we may obtain
the value so as to avoid this step?)

As currently finally exams are going on in my college, I was unable to
work on it much and the submission got delayed.


 builtin/submodule--helper.c | 130 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  40 +-------------
 2 files changed, 131 insertions(+), 39 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 85aafe46a..fba59c495 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -487,6 +487,135 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static void foreach_submodule(int argc, const char **argv, const char *path,
+			      const unsigned char *sha1, const char *prefix,
+			      int quiet, int recursive)
+{
+	const char *toplevel = xgetcwd();
+	const struct submodule *sub;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf sub_sha1 = STRBUF_INIT;
+	struct strbuf file = STRBUF_INIT;
+	char* displaypath = NULL;
+	int i;
+
+	/* Only loads from .gitmodules, no overlay with .git/config */
+	gitmodules_config();
+
+	if (prefix && get_super_prefix()) {
+		die("BUG: cannot have prefix and superprefix");
+	} else if (prefix) {
+		displaypath = xstrdup(relative_path(path, prefix,  &sb));
+	} else if (get_super_prefix()) {
+		strbuf_addf(&sb, "%s/%s", get_super_prefix(), path);
+		displaypath = strbuf_detach(&sb, NULL);
+	} else {
+		displaypath = xstrdup(path);
+	}
+
+	sub = submodule_from_path(null_sha1, path);
+
+	if (!sub)
+		die(_("No url found for submodule path '%s' in .gitmodules"),
+		      displaypath);
+	strbuf_add_unique_abbrev(&sub_sha1, sha1 , 40);
+
+	argv_array_pushf(&cp.env_array, "name=%s", sub->name);
+	argv_array_pushf(&cp.env_array, "path=%s", displaypath);
+	argv_array_pushf(&cp.env_array, "sm_path=%s", displaypath);
+	argv_array_pushf(&cp.env_array, "sha1=%s", sub_sha1.buf);
+	argv_array_pushf(&cp.env_array, "toplevel=%s", toplevel);
+
+	cp.use_shell = 1;
+	cp.dir = path;
+
+	for (i = 0; i < argc; i++)
+		argv_array_push(&cp.args, argv[i]);
+
+	strbuf_addstr(&file, path);
+	strbuf_addstr(&file, "/.git");
+
+	if (!quiet && !access_or_warn(file.buf, R_OK, 0))
+		printf(_("Entering '%s'\n"), displaypath);
+
+	if (!access_or_warn(file.buf, R_OK, 0))
+		run_command(&cp);
+
+	if(recursive) {
+		struct child_process cpr = CHILD_PROCESS_INIT;
+
+		cpr.use_shell = 1;
+		cpr.dir = path;
+
+		argv_array_pushf(&cpr.args, "git");
+		argv_array_pushf(&cpr.args, "--super-prefix");
+		argv_array_push(&cpr.args, displaypath);
+		argv_array_pushf(&cpr.args, "submodule--helper");
+
+		if (quiet)
+			argv_array_pushf(&cpr.args, "--quiet");
+
+		argv_array_pushf(&cpr.args, "foreach");
+		argv_array_pushf(&cpr.args, "--recursive");
+
+		for (i = 0; i < argc; i++)
+			argv_array_push(&cpr.args, argv[i]);
+
+		run_command(&cpr);
+	}
+
+	strbuf_release(&file);
+	strbuf_release(&sub_sha1);
+	strbuf_release(&sb);
+	free(displaypath);
+
+	return;
+}
+
+static int module_foreach(int argc, const char **argv, const char *prefix)
+{
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+	int quiet = 0;
+	int recursive = 0;
+	int i;
+
+	struct option module_foreach_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress output of entering each submodule command")),
+		OPT_BOOL(0, "recursive", &recursive,
+			 N_("Recurse into nested submodules")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper [--quiet] foreach [--recursive] <command>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_foreach_options,
+			     git_submodule_helper_usage, PARSE_OPT_KEEP_UNKNOWN);
+
+	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
+			die("BUG: module_list_compute should not choke on empty pathspec");
+
+	for (i = 0; i < list.nr; i++) {
+		if (prefix) {
+			const char *out = NULL;
+			if (skip_prefix(prefix, list.entries[i]->name, &out)) {
+				if (out && out[0] == '/' && !out + 1)
+					return 0;
+			}
+		}
+
+		foreach_submodule(argc, argv, list.entries[i]->name,
+				  list.entries[i]->oid.hash, prefix,
+				  quiet, recursive);
+	}
+
+	return 0;
+}
+
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, struct string_list *reference,
 			   int quiet, int progress)
@@ -1168,6 +1297,7 @@ static struct cmd_struct commands[] = {
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 6ec35e5fc..e2c2b40f4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -321,46 +321,8 @@ cmd_foreach()
 		esac
 		shift
 	done
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} "$@"
 
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
-	while read mode sha1 stage sm_path
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

