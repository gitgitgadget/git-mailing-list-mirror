From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add documentation for git-config-set
Date: Thu, 17 Nov 2005 22:49:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511172249000.18285@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Nov 17 22:51:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcrdD-000323-RM
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 22:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbVKQVtV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 16:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbVKQVtV
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 16:49:21 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:48314 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751500AbVKQVtU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 16:49:20 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9056813FCE0; Thu, 17 Nov 2005 22:49:19 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 714129F342; Thu, 17 Nov 2005 22:49:19 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 531AF837F7; Thu, 17 Nov 2005 22:49:19 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4607713FCE0; Thu, 17 Nov 2005 22:49:19 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12159>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Documentation/git-config-set.txt |  108 ++++++++++++++++++++++++++++++++++++++
 Documentation/git.txt            |    3 +
 2 files changed, 111 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-config-set.txt

applies-to: ee7303ec1f89940eeb5b565477ad903c379004fd
51745dec61000862d5afbdf7024e7793424e7c10
diff --git a/Documentation/git-config-set.txt b/Documentation/git-config-set.txt
new file mode 100644
index 0000000..8e897be
--- /dev/null
+++ b/Documentation/git-config-set.txt
@@ -0,0 +1,108 @@
+git-config-set(1)
+===============
+
+NAME
+----
+git-config-set - Set options in .git/config.
+
+
+SYNOPSIS
+--------
+'git-config-set' ( name [value [value_regex]] | --unset name [value_regex] )
+
+DESCRIPTION
+-----------
+You can set/replace/unset options with this command. The name is actually
+the section and the key separated by a dot, and the value will be escaped.
+
+If you want to set/unset an option which can occor on multiple lines, you
+should provide a POSIX regex for the value.
+
+This command will fail if
+
+. .git/config is invalid,
+. .git/config can not be written to,
+. no section was provided,
+. the section or key is invalid,
+. you try to unset an option which does not exist, or
+. you try to unset/set an option for which multiple lines match.
+
+
+OPTIONS
+-------
+
+--unset::
+	Remove the given option from .git/config
+
+
+EXAMPLE
+-------
+
+Given a .git/config like this:
+
+	#
+	# This is the config file, and
+	# a '#' or ';' character indicates
+	# a comment
+	#
+
+	; core variables
+	[core]
+		; Don't trust file modes
+		filemode = false
+
+	; Our diff algorithm
+	[diff]
+		external = "/usr/local/bin/gnu-diff -u"
+		renames = true
+
+	; Proxy settings
+	[proxy]
+		command="ssh" for "ssh://kernel.org/"
+		command="proxy-command" for kernel.org
+		command="myprotocol-command" for "my://"
+
+you can set the filemode to true with
+
+------------
+% git config-set core.filemode true
+------------
+
+The hypothetic proxy command entries actually have a postfix to discern
+to what URL they apply. Here is how to change the entry for kernel.org
+to "ssh".
+
+------------
+% git config-set proxy.command '"ssh" for kernel.org' 'for kernel.org$'
+------------
+
+This makes sure that only the key/value pair for kernel.org is replaced.
+
+To delete the entry for renames, do
+
+------------
+% git config-set --unset diff.renames
+------------
+
+or just
+
+------------
+% git config-set diff.renames
+------------
+
+If you want to delete an entry for a multivar (like proxy.command above),
+you have to provide a regex matching the value of exactly one line.
+
+
+Author
+------
+Written by Johannes Schindelin <Johannes.Schindelin@gmx.de>
+
+Documentation
+--------------
+Documentation by Johannes Schindelin.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 338e5ac..694fee8 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -84,6 +84,9 @@ gitlink:git-checkout-index[1]::
 gitlink:git-commit-tree[1]::
 	Creates a new commit object
 
+gitlink:git-config-set[1]::
+	Set options in .git/config.
+
 gitlink:git-hash-object[1]::
 	Computes the object ID from a file.
 
---
0.99.9.GIT
