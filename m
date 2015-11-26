From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] builtin/clone: support submodule groups
Date: Wed, 25 Nov 2015 16:31:24 -0800
Message-ID: <1448497884-2624-1-git-send-email-sbeller@google.com>
References: <5656366D.4010508@web.de>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, ericsunshine@gmail.com,
	hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Thu Nov 26 01:31:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1kTF-0006JN-Tf
	for gcvg-git-2@plane.gmane.org; Thu, 26 Nov 2015 01:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbbKZAbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 19:31:33 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34305 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbbKZAb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 19:31:29 -0500
Received: by padhx2 with SMTP id hx2so72231877pad.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 16:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w4lIaCGxYKfjSA/eHs0Z83I36UZzJx5IxcHbGOu+q/U=;
        b=hflagRtItaeT6aObx6sbq6nmafujG23clDXa+9l73ovfEYlGav8QtvU3TxNyxJqvmh
         mNsGkYJsYWdwiSQ+rCNGX8vjkYHmWvhzUihoH1c+IV2ZGCZTCrFco61IQlYF8IMDXctW
         Tg4tKiNlb7duqVskw8jNTekjCs3h43FNh5eLtjRYyZV5aDcLn0CLuaS6kDxZop+kOj6X
         WU7V7YnIexXJJK0bN4+NOiE5qMdow2xpj9F7P5y6UU++MEX2FIlKxoL5d7Myvih3/YOD
         1E6JCKVq0eU+qTcgN9WqSP0r5FBTImXlDdp6gVwEeI7AXtie6QFhc7Bk86TFfQr2lcrT
         0p4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w4lIaCGxYKfjSA/eHs0Z83I36UZzJx5IxcHbGOu+q/U=;
        b=UBwrijaapacgBQKRn7Ui1ma308Zv0jyOptyVmLmCTm4pjcVItB1N2EModV1PlPC1TY
         FG7/qOR0AmNShHBVSRr/qdRoLzjDq4PGSU6Z1i0HgjTgiTTN6JczCY3J71BB89XShwD+
         +XHXjoEJO3ft3HsO+aUxHFXLXMGghsj+JA1q7RT5M9xF1s3qNtMllNu1b8BdSnQcsqIC
         8CndN8B3ZTU1vJeTSTM5XkASAhwwS9RfX/IkH9aR1yxE/uC9wayHqFNtS8gGGVJfdJMk
         3+geGW4VtNNBN6fNaSICK0x04iA1pYJPLkJSX/VC1mK+notPIckgM9slu/VZqbq5Jlgp
         r8qA==
X-Gm-Message-State: ALoCoQmSMfjh9w2h59sVDrkwGEjAD6dTvHQwle6p42lXlEdbUHNp+UlvcR50CQJa9y2wP9IQDCUF
X-Received: by 10.98.73.133 with SMTP id r5mr35136073pfi.160.1448497886866;
        Wed, 25 Nov 2015 16:31:26 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:38f7:d727:e789:685b])
        by smtp.gmail.com with ESMTPSA id st5sm23717167pab.42.2015.11.25.16.31.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Nov 2015 16:31:26 -0800 (PST)
X-Mailer: git-send-email 2.6.1.261.g0d9c4c1
In-Reply-To: <5656366D.4010508@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281751>

This passes each group to the `submodule update` invocation and
additionally configures the groups to be automatically updated.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This is a resend of the patch "[PATCH 5/5] builtin/clone: support submodule groups"
as that's where Jens and I discussed.

* reworded the documentation to match reality of the patch
* --recurse is now implied and can be turned off.

Thanks for the fast feedback,
Stefan

Interdiff to previous version [PATCH 5/5] builtin/clone: support submodule groups
        --- a/Documentation/git-clone.txt
        +++ b/Documentation/git-clone.txt
        @@ -211,14 +211,16 @@ objects from the source repository into a pack in the cloned repository.
         
         --group::
                After the clone is created, all submodules which are part of the
        -       group are cloned. This option can be given multiple times to specify
        -       different groups. This option will imply automatic submodule
        -       updates for the groups by setting `submodule.update=groups`.
        -       The group selection will be passed on recursively, i.e. if a submodule
        -       is cloned because of group membership, its submodules will
        -       be cloned according to group membership, too. If a submodule is
        -       not cloned however, its submodules are not evaluated for group
        -       membership.
        +       given groups are cloned. To specify multiple groups, you can either
        +       give the group argument multiple times or comma separate the groups.
        +       This option will be recorded in the `submodule.groups` config,
        +       which will affect the behavior of other submodule related commands,
        +       such as `git submodule update`.
        +       This option implies recursive submodule checkout. If you don't
        +       want to recurse into nested submodules, you need to specify
        +       `--no-recursive`. The group selection will be passed on recursively,
        +       i.e. if a submodule is cloned because of group membership, its
        +       submodules will be cloned according to group membership, too.
         
         --separate-git-dir=<git dir>::
                Instead of placing the cloned repository where it is supposed
        diff --git a/builtin/clone.c b/builtin/clone.c
        index 17e9f54..377c031 100644
        --- a/builtin/clone.c
        +++ b/builtin/clone.c
        @@ -39,7 +39,7 @@ static const char * const builtin_clone_usage[] = {
         };
         
         static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
        -static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
        +static int option_local = -1, option_no_hardlinks, option_shared, option_recursive = -1;
         static char *option_template, *option_depth;
         static char *option_origin = NULL;
         static char *option_branch = NULL;
        @@ -875,9 +875,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
                                die(_("--bare and --separate-git-dir are incompatible."));
                        option_no_checkout = 1;
                }
        -
        -       if (option_recursive && submodule_groups.nr > 0)
        -               die(_("submodule groups and recursive flag are incompatible"));
        +       if (option_recursive == -1) {
        +               if (submodule_groups.nr > 0)
        +                       option_recursive = 1; /* submodule groups implies recursive */
        +               else
        +                       option_recursive = 0; /* preserve historical default */
        +       }
                if (submodule_groups.nr > 0) {
                        int first_item = 1;
                        struct string_list_item *item;

Here comes the actual patch:

 Documentation/git-clone.txt | 13 +++++++++
 builtin/clone.c             | 38 ++++++++++++++++++++++---
 git-submodule.sh            |  5 ++++
 t/t7400-submodule-basic.sh  | 69 +++++++++++++++++++++++++++++++++++++++++++++
 t/t7406-submodule-update.sh | 32 +++++++++++++++++++++
 5 files changed, 153 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 59d8c67..2539fea 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -209,6 +209,19 @@ objects from the source repository into a pack in the cloned repository.
 	repository does not have a worktree/checkout (i.e. if any of
 	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
 
+--group::
+	After the clone is created, all submodules which are part of the
+	given groups are cloned. To specify multiple groups, you can either
+	give the group argument multiple times or comma separate the groups.
+	This option will be recorded in the `submodule.groups` config,
+	which will affect the behavior of other submodule related commands,
+	such as `git submodule update`.
+	This option implies recursive submodule checkout. If you don't
+	want to recurse into nested submodules, you need to specify
+	`--no-recursive`. The group selection will be passed on recursively,
+	i.e. if a submodule is cloned because of group membership, its
+	submodules will be cloned according to group membership, too.
+
 --separate-git-dir=<git dir>::
 	Instead of placing the cloned repository where it is supposed
 	to be, place the cloned repository at the specified directory,
diff --git a/builtin/clone.c b/builtin/clone.c
index ce578d2..377c031 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -39,7 +39,7 @@ static const char * const builtin_clone_usage[] = {
 };
 
 static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
-static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
+static int option_local = -1, option_no_hardlinks, option_shared, option_recursive = -1;
 static char *option_template, *option_depth;
 static char *option_origin = NULL;
 static char *option_branch = NULL;
@@ -51,6 +51,7 @@ static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
 static int max_jobs = -1;
+static struct string_list submodule_groups;
 
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
@@ -95,6 +96,8 @@ static struct option builtin_clone_options[] = {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
+	OPT_STRING_LIST('g', "group", &submodule_groups, N_("group"),
+			N_("clone specific submodule groups")),
 	OPT_END()
 };
 
@@ -723,9 +726,18 @@ static int checkout(void)
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
 
-	if (!err && option_recursive) {
+	if (err)
+		goto out;
+
+	if (option_recursive || submodule_groups.nr > 0) {
 		struct argv_array args = ARGV_ARRAY_INIT;
-		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
+		argv_array_pushl(&args, "submodule", "update", "--init", NULL);
+
+		if (option_recursive)
+			argv_array_pushf(&args, "--recursive");
+
+		if (submodule_groups.nr > 0)
+			argv_array_pushf(&args, "--groups");
 
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
@@ -733,7 +745,7 @@ static int checkout(void)
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
-
+out:
 	return err;
 }
 
@@ -863,6 +875,24 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			die(_("--bare and --separate-git-dir are incompatible."));
 		option_no_checkout = 1;
 	}
+	if (option_recursive == -1) {
+		if (submodule_groups.nr > 0)
+			option_recursive = 1; /* submodule groups implies recursive */
+		else
+			option_recursive = 0; /* preserve historical default */
+	}
+	if (submodule_groups.nr > 0) {
+		int first_item = 1;
+		struct string_list_item *item;
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addstr(&sb, "submodule.groups=");
+		for_each_string_list_item(item, &submodule_groups) {
+			strbuf_addf(&sb, "%s%s", first_item ? "" : ",", item->string);
+			first_item = 0;
+		}
+		if (submodule_groups.nr > 0)
+			string_list_append(&option_config, strbuf_detach(&sb, 0));
+	}
 
 	if (!option_origin)
 		option_origin = "origin";
diff --git a/git-submodule.sh b/git-submodule.sh
index 4092a48..e3d1667 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -611,6 +611,7 @@ cmd_deinit()
 #
 cmd_update()
 {
+	groups=
 	# parse $args after "submodule ... update".
 	while test $# -ne 0
 	do
@@ -650,6 +651,9 @@ cmd_update()
 		--checkout)
 			update="checkout"
 			;;
+		--groups)
+			groups=1
+			;;
 		--depth)
 			case "$2" in '') usage ;; esac
 			depth="--depth=$2"
@@ -691,6 +695,7 @@ cmd_update()
 		${update:+--update "$update"} \
 		${reference:+--reference "$reference"} \
 		${depth:+--depth "$depth"} \
+		${groups:+--groups} \
 		${jobs:+$jobs} \
 		"$@" | {
 	err=
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index caed4be..e8654d7 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1049,4 +1049,73 @@ test_expect_success 'submodule init --group works' '
 	)
 '
 
+cat <<EOF > expected
+submodule
+-submodule1
+EOF
+
+test_expect_success 'submodule update --groups works' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --group groupA file://"$pwd"/example2 submodule &&
+		git submodule add file://"$pwd"/example2 submodule1 &&
+		git commit -a -m "create repository with 2 submodules, one is in a group"
+	) &&
+	git clone super super_clone &&
+	(
+		cd super_clone &&
+		git config submodule.groups groupA &&
+		git submodule init  &&
+		git submodule update --groups &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected
+'
+
+test_expect_success 'submodule update --init --groups works' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --group groupA file://"$pwd"/example2 submodule &&
+		git submodule add file://"$pwd"/example2 submodule1 &&
+		git commit -a -m "create repository with 2 submodules, one is in a group"
+	) &&
+	git clone super super_clone &&
+	(
+		cd super_clone &&
+		git config submodule.groups groupA &&
+		git submodule update --init --groups &&
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected
+'
+
+test_expect_success 'clone --group works' '
+	test_when_finished "rm -rf super super_clone" &&
+	mkdir super &&
+	pwd=$(pwd) &&
+	(
+		cd super &&
+		git init &&
+		git submodule add --group groupA file://"$pwd"/example2 submodule &&
+		git submodule add file://"$pwd"/example2 submodule1 &&
+		git commit -a -m "create repository with 2 submodules, one is in a group"
+	) &&
+	git clone --group groupA super super_clone &&
+	(
+		cd super_clone &&
+		test_pause
+		git submodule status |cut -c1,42-52 | tr -d " " >../actual
+	) &&
+	test_cmp actual expected
+'
+
+
 test_done
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 090891e..7e59846 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -801,4 +801,36 @@ test_expect_success 'git clone passes the parallel jobs config on to submodules'
 	rm -rf super4
 '
 
+cat >expect <<-EOF &&
+-deeper/submodule
+-merging
+-moved/sub module
+-none
+-rebasing
+-submodule
+-submodule1
+EOF
+
+# none, merging rebasing, submodule1, submodule
+test_expect_success 'git clone works with submodule groups.' '
+	test_when_finished "rm -rf super5" &&
+	(
+		cd super &&
+		git config -f .gitmodules  submodule.submodule.groups default &&
+		git config -f .gitmodules  submodule.submodule1.groups "default,testing" &&
+		git config -f .gitmodules  submodule.none.groups testing &&
+		git commit -a -m "assigning groups to submodules"
+	) &&
+	git clone --group default --group testing super super5 &&
+	(
+		cd super5 &&
+		git submodule status |cut -c1,43- >../actual
+	) &&
+	test_cmp actual expect
+'
+
+test_expect_success 'git submodule update --groups' '
+	true
+'
+
 test_done
-- 
2.6.1.261.g0d9c4c1
