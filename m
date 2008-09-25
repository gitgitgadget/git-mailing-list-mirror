From: Jonas Fonseca <fonseca@diku.dk>
Subject: [TG PATCH] Complete depend subcommand
Date: Thu, 25 Sep 2008 15:47:06 +0200
Message-ID: <20080925134706.GA16533@diku.dk>
References: <20080925110656.GB12949@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 15:48:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KirCg-00065z-Ik
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 15:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbYIYNrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 09:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbYIYNrN
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 09:47:13 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:40882 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbYIYNrM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 09:47:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 2E26A52C3D3;
	Thu, 25 Sep 2008 15:47:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id up8kgiaf4uQg; Thu, 25 Sep 2008 15:47:06 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 44FD252C3C7;
	Thu, 25 Sep 2008 15:47:06 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 7CFAC6DFD27; Thu, 25 Sep 2008 15:46:32 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 29A9A1A4001; Thu, 25 Sep 2008 15:47:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080925110656.GB12949@diku.dk>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96764>

Also, removes a debug line and fixes the script header.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
 contrib/tg-completion.bash |   60 ++++++++++++++++++++++++++-----------------
 1 files changed, 36 insertions(+), 24 deletions(-)

 The completion of the depend command didn't make it into the first
 patch because I had a broken topgit usage. Here is a resend, which
 also amends the script header.

diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index 35eabe9..59fbc50 100755
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -7,32 +7,13 @@
 # Conceptually based on gitcompletion (http://gitweb.hawaga.org.uk/).
 # Distributed under the GNU General Public License, version 2.0.
 #
-# The contained completion routines provide support for completing:
-#
-#    *) local and remote branch names
-#    *) local and remote tag names
-#    *) .git/remotes file names
-#    *) git 'subcommands'
-#    *) tree paths within 'ref:path/to/file' expressions
-#    *) common --long-options
-#
 # To use these routines:
 #
-#    1) Copy this file to somewhere (e.g. ~/.git-completion.sh).
-#    2) Added the following line to your .bashrc:
-#        source ~/.git-completion.sh
-#
-#    3) You may want to make sure the git executable is available
-#       in your PATH before this script is sourced, as some caching
-#       is performed while the script loads.  If git isn't found
-#       at source time then all lookups will be done on demand,
-#       which may be slightly slower.
+#    1) Copy this file to somewhere (e.g. ~/.tg-completion.sh).
+#    2) Source it from your ~/.bashrc.
 #
-#    4) Consider changing your PS1 to also show the current branch:
-#        PS1='[\u@\h \W$(__tg_ps1 " (%s)")]\$ '
-#
-#       The argument to __tg_ps1 will be displayed only if you
-#       are currently in a git repository.  The %s token will be
+# Note: Make sure the tg script is in your PATH before you source this
+# script, so it can properly setup cached values.
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -172,6 +153,22 @@ __tg_remotes ()
 	done
 }
 
+__tg_find_subcommand ()
+{
+	local word subcommand c=1
+
+	while [ $c -lt $COMP_CWORD ]; do
+		word="${COMP_WORDS[c]}"
+		for subcommand in $1; do
+			if [ "$subcommand" = "$word" ]; then
+				echo "$subcommand"
+				return
+			fi
+		done
+		c=$((++c))
+	done
+}
+
 __tg_complete_revlist ()
 {
 	local pfx cur="${COMP_WORDS[COMP_CWORD]}"
@@ -268,6 +265,21 @@ _tg_delete ()
 	esac
 }
 
+_tg_depend ()
+{
+	local subcommands="add"
+	local subcommand="$(__git_find_subcommand "$subcommands")"
+	if [ -z "$subcommand" ]; then
+		__tgcomp "$subcommands"
+		return
+	fi
+
+	case "$subcommand" in
+	add)
+		__tgcomp "$(__tg_refs)"
+	esac
+}
+
 _tg_export ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -411,6 +423,7 @@ _tg ()
 	case "$command" in
 	create)      _tg_create "$c" ;;
 	delete)      _tg_delete ;;
+	depend)      _tg_depend ;;
 	export)      _tg_export ;;
 	help)        _tg_help ;;
 	import)      _tg_import ;;
@@ -426,7 +439,6 @@ _tg ()
 
 ### }}}
 
-	__tgcomp "$(__tg_refs top-bases)"
 complete -o default -o nospace -F _tg tg
 
 # The following are necessary only for Cygwin, and only are needed
-- 
tg: (43a8db8..) jf/completion-fixes (depends on: master)

-- 
Jonas Fonseca
