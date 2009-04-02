From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 03/10] Add a mergetool-lib scriptlet for holding common merge tool functions
Date: Wed,  1 Apr 2009 21:20:38 -0700
Message-ID: <1238646040-46008-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, markus.heidelberg@web.de,
	charles@hashpling.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 02 06:22:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpERV-0002tz-L3
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 06:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbZDBEUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 00:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbZDBEUq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 00:20:46 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:31768 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbZDBEUp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 00:20:45 -0400
Received: by rv-out-0506.google.com with SMTP id f9so400794rvb.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 21:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=da6o1f7hs/aUB+2ICy1fYYMx/lKQ75zP8AeavA+VN04=;
        b=dw3UE9A6CfqMIuptymqzZgRSqqNK3On52kamdUyZ47NxNQnL5iw6oDdmZQQS+q2iVh
         b6/5FrVM/KqCaYoBC8b1xHP2RVSV9uiCprHPilhFnkfyLQAIbDHK4iZp9olaNYfbpyW7
         bKpaTbjrTrGY4m2SW2cet7wMSgbWL9zh5d/sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CgD2+y1CxvCiGO+lR9VKIK3lcQr6vfa45AgkZOBkivG6H8eFUVRT/NDqDRtMFJG8Hg
         Vhx7UzBBHcWCxtX+5gHc8ppY5R1EMgzwY4ZgjgiQJLZFX87cZr76q8tiSQeJ72Tgd644
         hVXR9DhptwJ3uZNc0LD3l2OKLQn3e4qLVYNUU=
Received: by 10.141.26.18 with SMTP id d18mr857932rvj.257.1238646043542;
        Wed, 01 Apr 2009 21:20:43 -0700 (PDT)
Received: from localhost (isrfasc7a1-gw.disneyanimation.com [12.188.26.241])
        by mx.google.com with ESMTPS id k37sm1740972rvb.48.2009.04.01.21.20.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 21:20:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.423.g442d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115435>

git-mergetool-lib provides common merge tool functions.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Includes fixups from Markus

 .gitignore                          |    1 +
 Documentation/git-mergetool-lib.txt |   42 +++++++++++++++++++++++++++++++++++
 Makefile                            |    1 +
 command-list.txt                    |    1 +
 git-mergetool-lib.sh                |   42 +++++++++++++++++++++++++++++++++++
 5 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-mergetool-lib.txt
 create mode 100644 git-mergetool-lib.sh

diff --git a/.gitignore b/.gitignore
index 966c886..75c154a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -80,6 +80,7 @@ git-merge-recursive
 git-merge-resolve
 git-merge-subtree
 git-mergetool
+git-mergetool-lib
 git-mktag
 git-mktree
 git-name-rev
diff --git a/Documentation/git-mergetool-lib.txt b/Documentation/git-mergetool-lib.txt
new file mode 100644
index 0000000..a8d62f5
--- /dev/null
+++ b/Documentation/git-mergetool-lib.txt
@@ -0,0 +1,42 @@
+git-mergetool-lib(1)
+====================
+
+NAME
+----
+git-mergetool-lib - Common git merge tool shell scriptlets
+
+SYNOPSIS
+--------
+'. "$(git --exec-path)/git-mergetool-lib"'
+
+DESCRIPTION
+-----------
+
+This is not a command the end user would want to run.  Ever.
+This documentation is meant for people who are studying the
+Porcelain-ish scripts and/or are writing new ones.
+
+The 'git-mergetool-lib' scriptlet is designed to be sourced (using
+`.`) by other shell scripts to set up functions for working
+with git merge tools.
+
+Before sourcing it, your script should set up a few variables;
+`TOOL_MODE` is used to define the operation mode for various
+functions.  'diff' and 'merge' are valid values.
+
+FUNCTIONS
+---------
+get_merge_tool_path::
+	returns the `merge_tool_path` for a `merge_tool`.
+
+Author
+------
+Written by David Aguilar <davvid@gmail.com>
+
+Documentation
+--------------
+Documentation by David Aguilar and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index d77fd71..086f9e7 100644
--- a/Makefile
+++ b/Makefile
@@ -284,6 +284,7 @@ SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
+SCRIPT_SH += git-mergetool-lib.sh
 SCRIPT_SH += git-parse-remote.sh
 SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
diff --git a/command-list.txt b/command-list.txt
index fb03a2e..922c815 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -69,6 +69,7 @@ git-merge-file                          plumbingmanipulators
 git-merge-index                         plumbingmanipulators
 git-merge-one-file                      purehelpers
 git-mergetool                           ancillarymanipulators
+git-mergetool-lib                       purehelpers
 git-merge-tree                          ancillaryinterrogators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
diff --git a/git-mergetool-lib.sh b/git-mergetool-lib.sh
new file mode 100644
index 0000000..5f9ba97
--- /dev/null
+++ b/git-mergetool-lib.sh
@@ -0,0 +1,42 @@
+# git-mergetool-lib is a library for common merge tool functions
+diff_mode() {
+	test $TOOL_MODE = "diff"
+}
+
+get_merge_tool_path () {
+	if test -z "$2"; then
+		case "$1" in
+		emerge)
+			path=emacs
+			;;
+		*)
+			path="$1"
+			;;
+		esac
+	fi
+	echo "$path"
+}
+
+valid_tool () {
+	case "$1" in
+	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
+		if test "$1" = "kompare" && ! diff_mode; then
+			return 1
+		fi
+		;; # happy
+	*)
+		if test -z "$(get_custom_cmd "$1")"; then
+			return 1
+		fi
+		;;
+	esac
+}
+
+get_custom_cmd () {
+	diff_mode &&
+	custom_cmd="$(git config difftool.$1.cmd)"
+	test -z "$custom_cmd" &&
+	custom_cmd="$(git config mergetool.$1.cmd)"
+	test -n "$custom_cmd" &&
+	echo "$custom_cmd"
+}
-- 
1.6.1.3
