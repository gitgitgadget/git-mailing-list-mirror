From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Misc documentation fixes and improvements
Date: Wed, 20 Jul 2005 14:05:01 +0200
Message-ID: <20050720120501.GA14074@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 20 14:11:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvDPM-0007sT-Q1
	for gcvg-git@gmane.org; Wed, 20 Jul 2005 14:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVGTMKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jul 2005 08:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVGTMKE
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jul 2005 08:10:04 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:12011 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261185AbVGTMJ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2005 08:09:58 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 3557E6E1A52; Wed, 20 Jul 2005 14:05:00 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 161306E1F16; Wed, 20 Jul 2005 14:05:00 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 1741D61E6A; Wed, 20 Jul 2005 14:05:02 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Fix displaying of an error message when cg-help is called with unknown
command and use $USAGE so the correct cg-help usage string is printed.
Drop useless use of cat in print_help(). Improve the asciidoc markup.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -172,7 +172,7 @@ print_help()
 	which "cg-$1" >/dev/null 2>&1 || exit 1
 	sed -n '/^USAGE=/,0s/.*"\(.*\)"/Usage: \1/p' < $(which cg-$1) 
 	echo
-	cat $(which cg-$1) | sed -n '3,/^$/s/^# *//p'
+	sed -n '3,/^$/s/^# *//p' < $(which cg-$1)
 	exit
 }
 
diff --git a/cg-admin-uncommit b/cg-admin-uncommit
--- a/cg-admin-uncommit
+++ b/cg-admin-uncommit
@@ -14,14 +14,14 @@
 # -t::
 #	This optional parameter makes `cg-admin-uncommit` to roll back
 #	the tree as well to the previous commit. Without this option
-#	(by default) Cogito keeps the tree in its current state,
+#	(by default) 'Cogito' keeps the tree in its current state,
 #	therefore generating tree with local changes against the target
 #	commit, consisting of the changes in the rolled back commits.
 #
 # CAVEATS
 # -------
 # This command can be dangerous! It is safe to do as long as you do not
-# push the commit out in the meantime, but you should NEVER uncommit an
+# push the commit out in the meantime, but you should 'NEVER' uncommit an
 # already pushed out commit. Things will break for the pullers since you
 # just broke the fast-forward merging mechanism (the new commit is not
 # descendant of the previous one). The future push scripts will refuse
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -17,7 +17,7 @@
 # -------
 # -C::
 #	Make `cg-commit` ignore the cache and just commit the thing as-is.
-#	Note, this is used internally by Cogito when merging. This option
+#	Note, this is used internally by 'Cogito' when merging. This option
 #	does not make sense when files are given on the command line.
 #
 # -mMESSAGE::
diff --git a/cg-diff b/cg-diff
--- a/cg-diff
+++ b/cg-diff
@@ -3,7 +3,7 @@
 # Make a diff between two GIT trees.
 # Copyright (c) Petr Baudis, 2005
 #
-# Outputs a diff for converting the first tree to the second one.
+# Outputs a diff for converting between two trees.
 # By default compares the current working tree to the state at the
 # last commit. The output will automatically be displayed in a pager
 # unless it is piped to a program.
diff --git a/cg-help b/cg-help
--- a/cg-help
+++ b/cg-help
@@ -14,7 +14,7 @@
 # OPTIONS
 # -------
 # -c::
-#	Colorize to the output.
+#	Colorize the output.
 
 USAGE="cg-help [-c] [cg-COMMAND | COMMAND]"
 _git_repo_unneeded=1
@@ -76,7 +76,8 @@ colorize() {
 
 if [ "$ARGS" ]; then
 	cmd=$(echo "${ARGS[0]}" | sed 's/^cg-//')
-	( print_help $cmd | colorize ) && exit
+	print_help $cmd | colorize
+	[ "${PIPESTATUS[0]}" -eq 0 ] && exit
 	echo "cg-help: no help available for command \"${ARGS[0]}\""
 	echo "Call cg-help without any arguments for the list of available commands"
 	exit 1
@@ -90,7 +91,7 @@ ADVANCED_COMMANDS="$(ls $bin_path/cg-adm
 colorize <<__END__
 The Cogito version control system  $(cg-version)
 
-Usage: cg-COMMAND [ARG]...
+Usage: $USAGE
 
 Available commands:
 $(print_command_listing $REGULAR_COMMANDS)
diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -14,7 +14,7 @@
 # cg-log then displays only changes in those files.
 #
 # -c::
-#	Colorize to the output. The used colors are listed below together
+#	Colorize the output. The used colors are listed below together
 #	with information about which log output (summary, full or both)
 #	they apply to:
 #		- `author`:	'cyan'		(both)

-- 
Jonas Fonseca
