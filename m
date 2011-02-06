From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 19/31] rebase: extract am code to new source file
Date: Sun,  6 Feb 2011 13:43:48 -0500
Message-ID: <1297017841-20678-20-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9eM-0005ZO-Cd
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860Ab1BFSrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:47:01 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58585 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab1BFSqU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:20 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so3014077qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Au56Nwkc4pQETXIDZbMg0qPR+zOPXkN1qj+/FjJIhKU=;
        b=SYDNaAdz/ElPuhlWcbohQnL9j6tstXBb5ZGBDvW67k/Xh0O026ksGijZKirGaLY7nw
         EiNXWcnqrc0jTwZCtjUt0G8OjQBhus/DGE3k04NqScYiw72Yl8NQRK6fWk8r5L0IVoer
         B//1LJWd3wIU7LdIyF2GG5cxhbvEpyu0cpET0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mCZWL8FITka04xbBYI7VGk4+4YohKXRae6N1PGIosk1zS0a7eGPwMUkKcS0RZXAF2l
         kKKgTwf9/3iw2v+3BibshZ0XIi2J90ohTrw1z/yt8VIJQAC1fFgCZM4aCE0cd1HZAyVy
         Lh5kcNOheL4+1Ib/ecU16oac6MDWXhcWJXTUQ=
Received: by 10.224.67.136 with SMTP id r8mr13587880qai.63.1297017980165;
        Sun, 06 Feb 2011 10:46:20 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:19 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166190>

Extract the code for am-based rebase to git-rebase--am.sh.

Suggested-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 .gitignore        |    1 +
 Makefile          |    1 +
 git-rebase--am.sh |   34 ++++++++++++++++++++++++++++++++++
 git-rebase.sh     |   31 ++-----------------------------
 4 files changed, 38 insertions(+), 29 deletions(-)
 create mode 100644 git-rebase--am.sh

diff --git a/.gitignore b/.gitignore
index a8b98b4..7aaf5c7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -102,6 +102,7 @@
 /git-quiltimport
 /git-read-tree
 /git-rebase
+/git-rebase--am
 /git-rebase--interactive
 /git-rebase--merge
 /git-receive-pack
diff --git a/Makefile b/Makefile
index f47550f..3cc60cb 100644
--- a/Makefile
+++ b/Makefile
@@ -369,6 +369,7 @@ SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
+SCRIPT_SH += git-rebase--am.sh
 SCRIPT_SH += git-rebase--interactive.sh
 SCRIPT_SH += git-rebase--merge.sh
 SCRIPT_SH += git-rebase.sh
diff --git a/git-rebase--am.sh b/git-rebase--am.sh
new file mode 100644
index 0000000..263987c
--- /dev/null
+++ b/git-rebase--am.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Junio C Hamano.
+#
+
+. git-sh-setup
+
+case "$action" in
+continue)
+	git am --resolved --3way --resolvemsg="$resolvemsg" &&
+	move_to_original_branch
+	exit
+	;;
+skip)
+	git am --skip -3 --resolvemsg="$resolvemsg" &&
+	move_to_original_branch
+	exit
+	;;
+esac
+
+test -n "$rebase_root" && root_flag=--root
+
+git format-patch -k --stdout --full-index --ignore-if-in-upstream \
+	--src-prefix=a/ --dst-prefix=b/ \
+	--no-renames $root_flag "$revisions" |
+git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" &&
+move_to_original_branch
+ret=$?
+test 0 != $ret -a -d "$state_dir" &&
+	echo $head_name > "$state_dir/head-name" &&
+	echo $onto > "$state_dir/onto" &&
+	echo $orig_head > "$state_dir/orig-head" &&
+	echo "$GIT_QUIET" > "$state_dir/quiet"
+exit $ret
diff --git a/git-rebase.sh b/git-rebase.sh
index 44e169f..c60221b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -91,7 +91,7 @@ run_specific_rebase () {
 		GIT_EDITOR=:
 		export GIT_EDITOR
 	fi
-	test "$type" != am && . git-rebase--$type
+	. git-rebase--$type
 }
 
 run_pre_rebase_hook () {
@@ -261,17 +261,11 @@ continue)
 	}
 	read_basic_state
 	run_specific_rebase
-	git am --resolved --3way --resolvemsg="$resolvemsg" &&
-	move_to_original_branch
-	exit
 	;;
 skip)
 	git reset --hard HEAD || exit $?
 	read_basic_state
 	run_specific_rebase
-	git am -3 --skip --resolvemsg="$resolvemsg" &&
-	move_to_original_branch
-	exit
 	;;
 abort)
 	git rerere clear
@@ -324,14 +318,12 @@ then
 	shift
 	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
 	die "invalid upstream $upstream_name"
-	unset root_flag
 	upstream_arg="$upstream_name"
 else
 	test -z "$onto" && die "You must specify --onto when using --root"
 	unset upstream_name
 	unset upstream
-	root_flag="--root"
-	upstream_arg="$root_flag"
+	upstream_arg=--root
 fi
 
 # Make sure the branch to rebase onto is valid.
@@ -457,23 +449,4 @@ else
 	revisions="$upstream..$orig_head"
 fi
 
-if test -z "$do_merge"
-then
-	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-		--src-prefix=a/ --dst-prefix=b/ \
-		--no-renames $root_flag "$revisions" |
-	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" &&
-	move_to_original_branch
-	ret=$?
-	test 0 != $ret -a -d "$apply_dir" &&
-		echo $head_name > "$apply_dir/head-name" &&
-		echo $onto > "$apply_dir/onto" &&
-		echo $orig_head > "$apply_dir/orig-head" &&
-		echo "$GIT_QUIET" > "$apply_dir/quiet"
-	exit $ret
-fi
-
-# start doing a rebase with git-merge
-# this is rename-aware if the recursive (default) strategy is used
-
 run_specific_rebase
-- 
1.7.4.rc2.33.g8a14f
