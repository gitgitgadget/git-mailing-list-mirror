Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B94120133
	for <e@80x24.org>; Tue,  7 Mar 2017 03:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754691AbdCGC5X (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 21:57:23 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34738 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754483AbdCGC4C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 21:56:02 -0500
Received: by mail-pf0-f178.google.com with SMTP id v190so31576579pfb.1
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 18:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5LNDTrs5hD/PVJxt9Bfo7bjkZ2dxYPAzVgyTp8E2AuM=;
        b=YEXar7MAoc3MxCa5VNY6hjZLEU1Ab8bCmBzu7MLWeSbxAtQGKNTV+znU2UrStIHIAc
         4ztxD8Fa6xDVZxsd6bwqBPBorlhmB7zYgM6xIWzbPCoyk3oiK8EyyaaP868TWyhcYddy
         NG4rQY0wyzD8JIODJj5omBWGtqwWDAQHUEIoiekR7rYtFwJ1UcxHItDnsEvH6D9+4JnC
         S8Yevet/gwX0pG5jYjAxfTwyU99KdnsWpuX4hIV+FXRksSr4puNDL9qzL1kqXT84c2B3
         VklfXzRqmdnKsnIuAHmPXbjF+cHdvlt+QaEXRI/S/063DiO6BaVd40wqJngl1QjLSG96
         tDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5LNDTrs5hD/PVJxt9Bfo7bjkZ2dxYPAzVgyTp8E2AuM=;
        b=VMenOgwvCMXxCScwB5yhVPg4SwrLg5olbDe8h7djVhUOZsHMPP3psb1UeybUmIcUiK
         1i+xz08X0wpoaQQfQCN1c613a1/Uvu1H8EPRTOnoGACQPKcAlZDTK9+ua9CWPbyjXaaS
         AVOLy99aUwB3edry4nAnH/i1LTwuLRZFUucX5JOMtXGPuA4okk9xxTXMBBUg3c64rWIq
         5dGWKGQkVlv7E//q/WZCB29feIkjp+jVhxOL8xicKuf9IY/5WIHwZTqA9G+SfojO+d5u
         H7Fog5UGsM5zPrBCwbD7uhupLNUsXw5exBglR1+B+9rwdCMSYAdHyTNOMtUqBVE53Cxh
         2ajw==
X-Gm-Message-State: AMke39lImWsFIyW2VpzbX4MxXBHs0DL2nJVfyrm60v9eTWVTmSClIBQSQqwDHWwGPHpbv0zy
X-Received: by 10.98.26.199 with SMTP id a190mr17753805pfa.63.1488833963562;
        Mon, 06 Mar 2017 12:59:23 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id r134sm41274279pfr.83.2017.03.06.12.59.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:59:22 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [RFCv7 PATCH 00/18] Checkout aware of Submodules!
Date:   Mon,  6 Mar 2017 12:59:01 -0800
Message-Id: <20170306205919.9713-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170302004759.27852-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

previous work:
https://public-inbox.org/git/20170302004759.27852-1-sbeller@google.com
https://public-inbox.org/git/20161203003022.29797-1-sbeller@google.com/

v7:
 * addressed Erics comment by fixing the bashism in t/lib-submodule-update.sh
diff to v6:
  diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
  index 5caae06bc5..949ebd546c 100755
  --- a/t/lib-submodule-update.sh
  +++ b/t/lib-submodule-update.sh
  @@ -255,7 +255,7 @@ test_superproject_content () {
   # Test that the given submodule at path "$1" contains the content according
   # to the submodule commit recorded in the superproject's commit "$2"
   test_submodule_content () {
  -       if test "$1" == "-C"
  +       if test x"$1" = "x-C"
          then
                  cd "$2"
                  shift; shift;
 * interdiff to v5 below
                  

v6:
 * added support for read-tree (see last patch) to see how generic the
   code of the previous patches is. I am pretty pleased with that patch.
 * marked two functions static. Thanks Ramsay!
 * fixed the recursive test; it still fails but it is the code that fails,
   not the test. For this I had to change the setup code slightly.
 * 2 new patches adding tiny refactoring to the submodule test lib.  
 * interdiff (to origin/sb/checkout-recurse-submodules, which is v5) below.

v5:
 * as v4 was the first version queued by Junio, we do have an interdiff below!
 * renamed functions
 * changed the API, now the caller has to take care of the submodule strategy
   themselves. (Note this can be different for different situations, e.g.
   when a submodule is deleted, we can do that for any strategy except none and
   !command. But for moving to a new state of the submodule we currently
   only implement "checkout" [unspecified defaults to checkout]. warning about
   the others, doing nothing there.)

v4:
 * addressed all comments of Brian, Junio and Brandon.
 Thanks!
 * one major point of change is the introduction of another patch
   "lib-submodule-update.sh: do not use ./. as submodule remote",
   as that took some time to track down the existing bug.
 
v3:
 * moved tests from t2013 to the generic submodule library.
 * factored out the refactoring patches to be up front
 * As I redid the complete implementation, I have the impression this time
   it is cleaner than previous versions.
 
 I think we still have to fix the corner cases of directory/file/submodule 
 conflicts before merging, but this serves as a status update on my current
 way of thinking how to implement the worktree commands being aware of
 submodules.
 
Thanks,
Stefan

v2:
* based on top of the series sent out an hour ago
  "[PATCHv4 0/5] submodule embedgitdirs"
* Try to embed a submodule if we need to remove it.
* Strictly do not change behavior if not giving the new flag.
* I think I missed some review comments from v1, but I'd like to get
  the current state out over the weekend, as a lot has changed so far.
  On Monday I'll go through the previous discussion with a comb to see
  if I missed something.
  
v1:
When working with submodules, nearly anytime after checking out
a different state of the projects, that has submodules changed
you'd run "git submodule update" with a current version of Git.

There are two problems with this approach:

* The "submodule update" command is dangerous as it
  doesn't check for work that may be lost in the submodule
  (e.g. a dangling commit).
* you may forget to run the command as checkout is supposed
  to do all the work for you.

Integrate updating the submodules into git checkout, with the same
safety promises that git-checkout has, i.e. not throw away data unless
asked to. This is done by first checking if the submodule is at the same
sha1 as it is recorded in the superproject. If there are changes we stop
proceeding the checkout just like it is when checking out a file that
has local changes.

The integration happens in the code that is also used in other commands
such that it will be easier in the future to make other commands aware
of submodule.

This also solves d/f conflicts in case you replace a file/directory
with a submodule or vice versa.

The patches are still a bit rough, but the overall series seems
promising enough to me that I want to put it out here.

Any review, specifically on the design level welcome!

Thanks,
Stefan


Stefan Beller (14):
  lib-submodule-update.sh: reorder create_lib_submodule_repo
  lib-submodule-update.sh: define tests for recursing into submodules
  make is_submodule_populated gently
  connect_work_tree_and_git_dir: safely create leading directories
  update submodules: add submodule config parsing
  update submodules: add a config option to determine if submodules are
    updated
  update submodules: introduce is_interesting_submodule
  update submodules: move up prepare_submodule_repo_env
  update submodules: add submodule_go_from_to
  unpack-trees: pass old oid to verify_clean_submodule
  unpack-trees: check if we can perform the operation for submodules
  read-cache: remove_marked_cache_entries to wipe selected submodules.
  entry.c: update submodules when interesting
  builtin/checkout: add --recurse-submodules switch
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index fa1d557e5b..ed9d63ef4a 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -115,6 +115,12 @@ OPTIONS
 	directories the index file and index output file are
 	located in.
 
+--[no-]recurse-submodules::
+	Using --recurse-submodules will update the content of all initialized
+	submodules according to the commit recorded in the superproject by
+	calling read-tree recursively, also setting the submodules HEAD to be
+	detached at that commit.
+
 --no-sparse-checkout::
 	Disable sparse checkout support even if `core.sparseCheckout`
 	is true.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 207ce09771..e9c5fcfaf8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -29,8 +29,8 @@ static const char * const checkout_usage[] = {
 	NULL,
 };
 
-int option_parse_recurse_submodules(const struct option *opt,
-				    const char *arg, int unset)
+static int option_parse_recurse_submodules(const struct option *opt,
+					   const char *arg, int unset)
 {
 	if (unset) {
 		recurse_submodules = RECURSE_SUBMODULES_OFF;
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 8ba64bc785..2dc5cc06da 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -15,10 +15,13 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "resolve-undo.h"
+#include "submodule.h"
+#include "submodule-config.h"
 
 static int nr_trees;
 static int read_empty;
 static struct tree *trees[MAX_UNPACK_TREES];
+int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
 static int list_tree(unsigned char *sha1)
 {
@@ -96,6 +99,23 @@ static int debug_merge(const struct cache_entry * const *stages,
 	return 0;
 }
 
+static int option_parse_recurse_submodules(const struct option *opt,
+					   const char *arg, int unset)
+{
+	if (unset) {
+		recurse_submodules = RECURSE_SUBMODULES_OFF;
+		return 0;
+	}
+	if (arg)
+		recurse_submodules =
+			parse_update_recurse_submodules_arg(opt->long_name,
+							    arg);
+	else
+		recurse_submodules = RECURSE_SUBMODULES_ON;
+
+	return 0;
+}
+
 static struct lock_file lock_file;
 
 int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
@@ -137,6 +157,9 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			 N_("skip applying sparse checkout filter")),
 		OPT_BOOL(0, "debug-unpack", &opts.debug_unpack,
 			 N_("debug unpack-trees")),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules,
+			    "checkout", "control recursive updating of submodules",
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_END()
 	};
 
@@ -152,6 +175,12 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
+	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT) {
+		gitmodules_config();
+		git_config(submodule_config, NULL);
+		set_config_update_recurse_submodules(RECURSE_SUBMODULES_ON);
+	}
+
 	prefix_set = opts.prefix ? 1 : 0;
 	if (1 < opts.merge + opts.reset + prefix_set)
 		die("Which one? -m, --reset, or --prefix?");
diff --git a/submodule.c b/submodule.c
index a2cf8c9376..bc5fecf8c5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1257,7 +1257,7 @@ static int submodule_has_dirty_index(const struct submodule *sub)
 	return finish_command(&cp);
 }
 
-void submodule_reset_index(const char *path)
+static void submodule_reset_index(const char *path)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 54cd8a6366..429cd1041d 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -4,7 +4,7 @@
 # - New submodule (no_submodule => add_sub1)
 # - Removed submodule (add_sub1 => remove_sub1)
 # - Updated submodule (add_sub1 => modify_sub1)
-# - Updated submodule recursively (modify_sub1 => modify_sub1_recursively)
+# - Updated submodule recursively (add_nested_sub => modify_sub1_recursively)
 # - Submodule updated to invalid commit (add_sub1 => invalid_sub1)
 # - Submodule updated from invalid commit (invalid_sub1 => valid_sub1)
 # - Submodule replaced by tracked files in directory (add_sub1 =>
@@ -20,8 +20,8 @@
 #                    /    ^
 #                   /     remove_sub1
 #                  /
-#       add_sub1  /-------O---------O
-#             |  /        ^         modify_sub1_recursive
+#       add_sub1  /-------O---------O--------O  modify_sub1_recursively
+#             |  /        ^         add_nested_sub
 #             | /         modify_sub1
 #             v/
 #      O------O-----------O---------O
@@ -96,12 +96,24 @@ create_lib_submodule_repo () {
 		git add sub1 &&
 		git commit -m "Modify sub1" &&
 
-		git checkout -b modify_sub1_recursively modify_sub1 &&
+		git checkout -b add_nested_sub modify_sub1 &&
 		git -C sub1 checkout -b "add_nested_sub" &&
 		git -C sub1 submodule add --branch no_submodule ../submodule_update_sub2 sub2 &&
 		git -C sub1 commit -a -m "add a nested submodule" &&
 		git add sub1 &&
 		git commit -a -m "update submodule, that updates a nested submodule" &&
+		git checkout -b modify_sub1_recursively &&
+		git -C sub1 checkout -b modify_sub1_recursively &&
+		git -C sub1/sub2 checkout -b modify_sub1_recursively &&
+		echo change >sub1/sub2/file3 &&
+		git -C sub1/sub2 add file3 &&
+		git -C sub1/sub2 commit -m "make a change in nested sub" &&
+		git -C sub1 add sub2 &&
+		git -C sub1 commit -m "update nested sub" &&
+		git add sub1 &&
+		git commit -m "update sub1, that updates nested sub" &&
+		git -C sub1 push origin modify_sub1_recursively &&
+		git -C sub1/sub2 push origin modify_sub1_recursively &&
 		git -C sub1 submodule deinit -f --all &&
 
 		git checkout -b replace_sub1_with_directory add_sub1 &&
@@ -200,9 +212,9 @@ reset_work_tree_to () {
 		git checkout -f "$1" &&
 		git status -u -s >actual &&
 		test_must_be_empty actual &&
-		sha1=$(git rev-parse --revs-only HEAD:sub1) &&
-		if test -n "$sha1" &&
-		   test $(cd "../submodule_update_sub1" && git rev-parse --verify "$sha1^{commit}")
+		hash=$(git rev-parse --revs-only HEAD:sub1) &&
+		if test -n "$hash" &&
+		   test $(cd "../submodule_update_sub1" && git rev-parse --verify "$hash^{commit}")
 		then
 			git submodule update --init --recursive "sub1"
 		fi
@@ -211,14 +223,23 @@ reset_work_tree_to () {
 
 reset_work_tree_to_interested () {
 	reset_work_tree_to $1 &&
-	# indicate we are interested in the submodule:
-	git -C submodule_update config submodule.sub1.url "bogus" &&
-	# also have it available:
+	# make the submodule git dirs available
 	if ! test -d submodule_update/.git/modules/sub1
 	then
 		mkdir -p submodule_update/.git/modules &&
 		cp -r submodule_update_repo/.git/modules/sub1 submodule_update/.git/modules/sub1
-	fi
+		GIT_WORK_TREE=. git -C submodule_update/.git/modules/sub1 config --unset core.worktree
+	fi &&
+	if ! test -d submodule_update/.git/modules/sub1/modules/sub2
+	then
+		mkdir -p submodule_update/.git/modules/sub1/modules &&
+		cp -r submodule_update_repo/.git/modules/sub1/modules/sub2 submodule_update/.git/modules/sub1/modules/sub2
+		GIT_WORK_TREE=. git -C submodule_update/.git/modules/sub1/modules/sub2 config --unset core.worktree
+	fi &&
+	# indicate we are interested in the submodule:
+	git -C submodule_update config submodule.sub1.url "bogus" &&
+	# sub1 might not be checked out, so use the git dir
+	git -C submodule_update/.git/modules/sub1 config submodule.sub2.url "bogus"
 }
 
 # Test that the superproject contains the content according to commit "$1"
@@ -234,6 +255,11 @@ test_superproject_content () {
 # Test that the given submodule at path "$1" contains the content according
 # to the submodule commit recorded in the superproject's commit "$2"
 test_submodule_content () {
+	if test x"$1" == "x-C"
+	then
+		cd "$2"
+		shift; shift;
+	fi
 	if test $# != 2
 	then
 		echo "test_submodule_content needs two arguments"
@@ -761,6 +787,11 @@ test_submodule_switch_recursing () {
 	then
 		RESULT=failure
 	fi
+
+	if test "$KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED" = 1
+	then
+		RESULT1=failure
+	fi
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear checks it out ...
 	test_expect_success "$command: added submodule is checked out" '
@@ -801,7 +832,7 @@ test_submodule_switch_recursing () {
 		)
 	'
 	# ... but an ignored file is fine.
-	test_expect_success "$command: added submodule removes an untracked ignored file" '
+	test_expect_$RESULT1 "$command: added submodule removes an untracked ignored file" '
 		test_when_finished "rm submodule_update/.git/info/exclude" &&
 		prolog &&
 		reset_work_tree_to_interested no_submodule &&
@@ -966,21 +997,17 @@ test_submodule_switch_recursing () {
 		)
 	'
 
-	# This test fails, due to missing setup, we do not clone sub2 into
-	# submodule_update, because it doesn't exist in the 'add_sub1' version
-	#
-	test_expect_success "$command: modified submodule updates submodule recursively" '
+	# recursing deeper than one level doesn't work yet.
+	test_expect_failure "$command: modified submodule updates submodule recursively" '
 		prolog &&
-		reset_work_tree_to_interested add_sub1 &&
+		reset_work_tree_to_interested add_nested_sub &&
 		(
 			cd submodule_update &&
 			git branch -t modify_sub1_recursively origin/modify_sub1_recursively &&
-			test_must_fail $command modify_sub1_recursively &&
-			test_superproject_content origin/add_sub1 &&
-			test_submodule_content sub1 origin/add_sub1
-			# test_superproject_content origin/modify_sub1_recursively &&
-			# test_submodule_content sub1 origin/modify_sub1_recursively &&
-			# test_submodule_content sub1/sub2 no_submodule
+			$command modify_sub1_recursively &&
+			test_superproject_content origin/modify_sub1_recursively &&
+			test_submodule_content sub1 origin/modify_sub1_recursively &&
+			test_submodule_content -C sub1 sub2 origin/modify_sub1_recursively
 		)
 	'
 }
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index 20526aed34..7019d0a04f 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -5,6 +5,13 @@ test_description='read-tree can handle submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
+KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
+KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
+
+test_submodule_switch_recursing "git read-tree --recurse-submodules -u -m"
+
+test_submodule_forced_switch_recursing "git read-tree --recurse-submodules -u --reset"
+
 test_submodule_switch "git read-tree -u -m"
 
 test_submodule_forced_switch "git read-tree -u --reset"
