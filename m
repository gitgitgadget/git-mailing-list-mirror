From: Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] submodule: add verbose mode for add/update
Date: Wed, 10 Apr 2013 23:10:10 +0300
Message-ID: <1365624610-11163-1-git-send-email-orgads@gmail.com>
Cc: Orgad Shaneh <orgads@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 22:10:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ1Lk-0006hg-CM
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936156Ab3DJUK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:10:27 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:64352 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935970Ab3DJUK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:10:26 -0400
Received: by mail-ee0-f47.google.com with SMTP id t10so419060eei.34
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=6toiABpxBXI2EGMSq4i6Y5jDPilD+RQUuqG36Ow0c9E=;
        b=MOox4lHLNccFpUSeLjUpDu8t/bOyuu9oNTOsEVTvLI0C/oIqiVZloW5gt6jWD19OH4
         RBy66gCHrRu/yKCR47GgDC/tLxC9CH9Yr3QdpRGEqDlFIBEmD9L3gVmAqsoZJzVQLb8p
         DGNifRra00tGyFIyeiIwjXquin+BBlBbVlY2DEPo+rQQbzo4ckxM6MJZZloMiENJ1XkC
         d+jW5TUquQZS+88crwXC0xGHDK86FEL0LxIpWcArqTWWP/SoVfNAuIP/X5/RXM06v/Gz
         MPWwEs720+Ew0xqupMX5sHn6AmkH2Vm+7vLkkjz2413pesvOWjqOLEZq/pFdQ6dqdfvh
         WrOg==
X-Received: by 10.14.181.196 with SMTP id l44mr1532031eem.44.1365624625433;
        Wed, 10 Apr 2013 13:10:25 -0700 (PDT)
Received: from localhost.localdomain ([77.127.168.32])
        by mx.google.com with ESMTPS id d47sm1761551eem.9.2013.04.10.13.10.23
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 13:10:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220747>

When 'git submodule add/update' is run there is no output during
checkout. This can take a significant amount of time and it would
be nice if user could enable some feedback to see what's going on.

Add the -v/--verbose option to both add and update which suppresses
the -q normally given to checkout so the user sees progress output
from the checkout command.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 Documentation/git-submodule.txt |   10 ++++++++--
 git-submodule.sh                |   24 +++++++++++++++++++-----
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 74d5bdc..6abfd5d 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -10,13 +10,13 @@ SYNOPSIS
 --------
 [verse]
 'git submodule' [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
-	      [--reference <repository>] [--] <repository> [<path>]
+	      [--reference <repository>] [-v|--verbose] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase] [--reference <repository>]
-	      [--merge] [--recursive] [--] [<path>...]
+	      [--merge] [--recursive] [-v|--verbose] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -324,6 +324,12 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 	only in the submodules of the current repo, but also
 	in any nested submodules inside those submodules (and so on).
 
+-v::
+--verbose::
+	This option makes the checkout operation more verbose.
+	By default, a quiet checkout is performed. Specifying --verbose
+	provides progress information to the user.
+
 <path>...::
 	Paths to submodule(s). When specified this will restrict the command
 	to only operate on the submodules found at the specified paths.
diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..f7964ad 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,11 +5,11 @@
 # Copyright (c) 2007 Lars Hjemli
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
+USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [-v|--verbose] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [-v|--verbose] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
@@ -309,6 +309,9 @@ cmd_add()
 			custom_name=$2
 			shift
 			;;
+		-v|--verbose)
+			VERBOSE=1
+			;;
 		--)
 			shift
 			break
@@ -408,11 +411,15 @@ Use -f if you really want to add it." >&2
 		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" || exit
 		(
 			clear_local_git_env
+			if test -z "$VERBOSE"
+			then
+				subquiet=-q
+			fi
 			cd "$sm_path" &&
 			# ash fails to wordsplit ${branch:+-b "$branch"...}
 			case "$branch" in
-			'') git checkout -f -q ;;
-			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
+			'') git checkout -f $subquiet ;;
+			?*) git checkout -f $subquiet -B "$branch" "origin/$branch" ;;
 			esac
 		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
 	fi
@@ -676,6 +683,9 @@ cmd_update()
 		--checkout)
 			update="checkout"
 			;;
+		-v|--verbose)
+			VERBOSE=1
+			;;
 		--)
 			shift
 			break
@@ -799,7 +809,11 @@ Maybe you want to use 'update --init'?")"
 				must_die_on_failure=yes
 				;;
 			*)
-				command="git checkout $subforce -q"
+				if test -z "$VERBOSE"
+				then
+					subquiet=-q
+				fi
+				command="git checkout $subforce $subquiet"
 				die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$prefix\$sm_path'")"
 				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': checked out '\$sha1'")"
 				;;
-- 
1.7.10.4
