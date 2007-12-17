From: Andy Dougherty <doughera@lafayette.edu>
Subject: [PATCH] Minor portability patch to git-submodule
Date: Mon, 17 Dec 2007 16:41:33 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712171639420.24957@fractal.phys.lafayette.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 23:42:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4OfQ-0005Ei-Io
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 23:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759483AbXLQWlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 17:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758491AbXLQWlj
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 17:41:39 -0500
Received: from mail.lafayette.edu ([139.147.8.42]:55245 "EHLO lafayette.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758552AbXLQWli (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 17:41:38 -0500
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2007 17:41:38 EST
Received: from fractal.phys.lafayette.edu (account doughera [139.147.232.21] verified)
  by lafayette.edu (CommuniGate Pro SMTP 5.0.13)
  with ESMTPSA id 14350533 for git@vger.kernel.org; Mon, 17 Dec 2007 16:41:36 -0500
X-X-Sender: doughera@fractal.phys.lafayette.edu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68642>

While trying git out on Solaris 8, I needed the following patch.  
The 'grep' command on Solaris doesn't understand the -e option, though 
egrep does. 

More mysterious is the printf patch.  Without it, the sed command didn't 
match anything.

--- git-1.5.4.rc0/git-submodule.sh	Wed Dec 12 21:29:16 2007
+++ git-andy/git-submodule.sh	Mon Dec 17 14:30:46 2007
@@ -74,7 +74,7 @@
 module_name()
 {
 	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
-	re=$(printf '%s' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
+	re=$(printf '%s\n' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
 	name=$( GIT_CONFIG=.gitmodules \
 		git config --get-regexp '^submodule\..*\.path$' |
 		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
@@ -176,7 +176,7 @@
 #
 modules_init()
 {
-	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	git ls-files --stage -- "$@" | egrep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
 		# Skip already registered paths
@@ -209,7 +209,7 @@
 #
 modules_update()
 {
-	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	git ls-files --stage -- "$@" | egrep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
 		name=$(module_name "$path") || exit
@@ -268,7 +268,7 @@
 #
 modules_list()
 {
-	git ls-files --stage -- "$@" | grep -e '^160000 ' |
+	git ls-files --stage -- "$@" | egrep -e '^160000 ' |
 	while read mode sha1 stage path
 	do
 		name=$(module_name "$path") || exit

-- 
    Andy Dougherty		doughera@lafayette.edu
