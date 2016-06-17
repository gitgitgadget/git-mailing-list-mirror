Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66FE91FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbcFQUYX (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:23 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:52110 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964845AbcFQUYW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:22 -0400
Received: (qmail 23669 invoked from network); 17 Jun 2016 20:24:20 -0000
Received: (qmail 5371 invoked from network); 17 Jun 2016 20:24:20 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:19 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 13/38] i18n: git-sh-setup.sh: mark strings for translation
Date:	Fri, 17 Jun 2016 20:21:02 +0000
Message-Id: <1466194887-18236-14-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Positional arguments, such as $0, $1, etc, need to be stored on shell
variables for use in translatable strings, according to gettext manual
[1].

Add git-sh-setup.sh to LOCALIZED_SH variable in Makefile to enable
extraction of string marked for translation by xgettext.

Source git-sh-i18n in git-sh-setup.sh for gettext support.
git-sh-setup.sh is a shell library to be sourced by other shell scripts.
In order to avoid other scripts from sourcing git-sh-i18n twice, remove
line that sources it from them.  Not sourcing git-sh-i18n in any script
that uses gettext would lead to failure due to, for instance, gettextln
not being found.

[1] http://www.gnu.org/software/gettext/manual/html_node/Preparing-Shell-Scripts.html

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 Makefile             |  4 +++-
 git-bisect.sh        |  1 -
 git-merge-octopus.sh |  1 -
 git-rebase.sh        |  1 -
 git-sh-setup.sh      | 63 +++++++++++++++++++++++++++++++++++++++-------------
 git-stash.sh         |  1 -
 git-submodule.sh     |  1 -
 7 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index de5a030..6169389 100644
--- a/Makefile
+++ b/Makefile
@@ -2063,7 +2063,9 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --keyword=__ --language=Perl
 LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
-LOCALIZED_SH = $(SCRIPT_SH) git-parse-remote.sh
+LOCALIZED_SH = $(SCRIPT_SH)
+LOCALIZED_SH += git-parse-remote.sh
+LOCALIZED_SH += git-sh-setup.sh
 LOCALIZED_PERL = $(SCRIPT_PERL)
 
 ifdef XGETTEXT_INCLUDE_TESTS
diff --git a/git-bisect.sh b/git-bisect.sh
index 737bf05..30d01bb 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -33,7 +33,6 @@ Please use "git help bisect" to get the full man page.'
 
 OPTIONS_SPEC=
 . git-sh-setup
-. git-sh-i18n
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index d79fc84..308eafd 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -6,7 +6,6 @@
 #
 
 . git-sh-setup
-. git-sh-i18n
 
 LF='
 '
diff --git a/git-rebase.sh b/git-rebase.sh
index 9ba21ab..04f6e44 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -45,7 +45,6 @@ skip!              skip current patch and continue
 edit-todo!         edit the todo list during an interactive rebase
 "
 . git-sh-setup
-. git-sh-i18n
 set_reflog_action rebase
 require_work_tree_exists
 cd_to_toplevel
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index c48139a..2eda134 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -2,6 +2,9 @@
 # to set up some variables pointing at the normal git directories and
 # a few helper shell functions.
 
+# Source git-sh-i18n for gettext support.
+. git-sh-i18n
+
 # Having this variable in your environment would break scripts because
 # you would cause "cd" to be taken to unexpected places.  If you
 # like CDPATH, define it for your interactive shell sessions without
@@ -83,16 +86,16 @@ if test -n "$OPTIONS_SPEC"; then
 else
 	dashless=$(basename -- "$0" | sed -e 's/-/ /')
 	usage() {
-		die "usage: $dashless $USAGE"
+		die "$(eval_gettext "usage: \$dashless \$USAGE")"
 	}
 
 	if [ -z "$LONG_USAGE" ]
 	then
-		LONG_USAGE="usage: $dashless $USAGE"
+		LONG_USAGE="$(eval_gettext "usage: \$dashless \$USAGE")"
 	else
-		LONG_USAGE="usage: $dashless $USAGE
+		LONG_USAGE="$(eval_gettext "usage: \$dashless \$USAGE
 
-$LONG_USAGE"
+$LONG_USAGE")"
 	fi
 
 	case "$1" in
@@ -182,7 +185,7 @@ is_bare_repository () {
 cd_to_toplevel () {
 	cdup=$(git rev-parse --show-toplevel) &&
 	cd "$cdup" || {
-		echo >&2 "Cannot chdir to $cdup, the toplevel of the working tree"
+		gettextln "Cannot chdir to \$cdup, the toplevel of the working tree" >&2
 		exit 1
 	}
 }
@@ -190,13 +193,16 @@ cd_to_toplevel () {
 require_work_tree_exists () {
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
-		die "fatal: $0 cannot be used without a working tree."
+		program_name=$0
+		die "$(gettext "fatal: \$program_name cannot be used without a working tree.")"
 	fi
 }
 
 require_work_tree () {
-	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
-	die "fatal: $0 cannot be used without a working tree."
+	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true || {
+		program_name=$0
+		die "$(gettext "fatal: \$program_name cannot be used without a working tree.")"
+	}
 }
 
 require_clean_work_tree () {
@@ -206,24 +212,49 @@ require_clean_work_tree () {
 
 	if ! git diff-files --quiet --ignore-submodules
 	then
-		echo >&2 "Cannot $1: You have unstaged changes."
+		action=$1
+		case "$action" in
+		rebase)
+			gettextln "Cannot rebase: You have unstaged changes." >&2
+			;;
+		"rewrite branches")
+			gettextln "Cannot rewrite branches: You have unstaged changes." >&2
+			;;
+		"pull with rebase")
+			gettextln "Cannot pull with rebase: You have unstaged changes." >&2
+			;;
+		*)
+			eval_gettextln "Cannot \$action: You have unstaged changes." >&2
+			;;
+		esac
 		err=1
 	fi
 
 	if ! git diff-index --cached --quiet --ignore-submodules HEAD --
 	then
-		if [ $err = 0 ]
+		if test $err = 0
 		then
-		    echo >&2 "Cannot $1: Your index contains uncommitted changes."
+			action=$1
+			case "$action" in
+			rebase)
+				gettextln "Cannot rebase: Your index contains uncommitted changes." >&2
+				;;
+			"pull with rebase")
+				gettextln "Cannot pull with rebase: Your index contains uncommitted changes." >&2
+				;;
+			*)
+				eval_gettextln "Cannot \$action: Your index contains uncommitted changes." >&2
+				;;
+			esac
 		else
-		    echo >&2 "Additionally, your index contains uncommitted changes."
+		    gettextln "Additionally, your index contains uncommitted changes." >&2
 		fi
 		err=1
 	fi
 
-	if [ $err = 1 ]
+	if test $err = 1
 	then
-		test -n "$2" && echo >&2 "$2"
+		test -n "$2" && echo "$2" >&2
 		exit 1
 	fi
 }
@@ -336,12 +367,12 @@ git_dir_init () {
 	then
 		test -z "$(git rev-parse --show-cdup)" || {
 			exit=$?
-			echo >&2 "You need to run this command from the toplevel of the working tree."
+			gettextln "You need to run this command from the toplevel of the working tree." >&2
 			exit $exit
 		}
 	fi
 	test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {
-		echo >&2 "Unable to determine absolute path of git directory"
+		gettextln "Unable to determine absolute path of git directory" >&2
 		exit 1
 	}
 	: ${GIT_OBJECT_DIRECTORY="$(git rev-parse --git-path objects)"}
diff --git a/git-stash.sh b/git-stash.sh
index c7509e8..22fb8bc 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -15,7 +15,6 @@ SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 START_DIR=$(pwd)
 . git-sh-setup
-. git-sh-i18n
 require_work_tree
 cd_to_toplevel
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 7fe8a51..5b9674a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -16,7 +16,6 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
 OPTIONS_SPEC=
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
-. git-sh-i18n
 . git-parse-remote
 require_work_tree
 wt_prefix=$(git rev-parse --show-prefix)
-- 
2.6.6

