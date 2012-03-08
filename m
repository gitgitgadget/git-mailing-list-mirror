From: Dominique Quatravaux <domq@google.com>
Subject: [PATCH 2/2] rebase -i: new option --name-rev
Date: Thu,  8 Mar 2012 11:42:38 +0100
Message-ID: <1331203358-28277-2-git-send-email-domq@google.com>
References: <1331203358-28277-1-git-send-email-domq@google.com>
Cc: Dominique Quatravaux <domq@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 11:43:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5aoM-0004cZ-6i
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 11:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab2CHKnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 05:43:04 -0500
Received: from mail-gy0-f202.google.com ([209.85.160.202]:39777 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab2CHKnA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 05:43:00 -0500
Received: by ghbz15 with SMTP id z15so35663ghb.1
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 02:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9mSbKXozgIBW+o7XjemdY4/5nvicN5AAZwjomaiMMvU=;
        b=MZipAg+5KXh/4Ne2fr/HoA65cq9T7BeXcRgQhughyeB1sYl/KveOF0Mmadrrn/p9CX
         2brItTy5n1+dXVW2yJbgaQfoPbQVd6DNu7nerqzUvc6ic11ZKGGbfAGxmiW+Ea7DpyRv
         T0328VibxY36UMPAXUB3qHMMS9ZDY08amu9cWuuAH4wRJ4Nqj+QpGAtI9v8II5AiSCSx
         qcMgFqa2A0IGe5jAShVDLxqVQAMk2nBISU0hbSt9VLvoxHl9WAZUjW+jQ6zm+8cLNMsn
         3I/816vGcNo60q0ToBQ47RpVADJeZa4ZJYaSebNl7eaDV9hU9tpI9HOg9JD/KuFbhnYq
         xDXA==
Received: by 10.101.2.21 with SMTP id e21mr2149558ani.18.1331203379519;
        Thu, 08 Mar 2012 02:42:59 -0800 (PST)
Received: by 10.101.2.21 with SMTP id e21mr2149545ani.18.1331203379431;
        Thu, 08 Mar 2012 02:42:59 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id g49si802176yhe.6.2012.03.08.02.42.59
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 08 Mar 2012 02:42:59 -0800 (PST)
Received: from alliance-maui.zrh.corp.google.com (alliance-maui.zrh.corp.google.com [172.28.204.12])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 1A7E6100052;
	Thu,  8 Mar 2012 02:42:59 -0800 (PST)
Received: by alliance-maui.zrh.corp.google.com (Postfix, from userid 71297)
	id 94A01600A4; Thu,  8 Mar 2012 11:42:58 +0100 (CET)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1331203358-28277-1-git-send-email-domq@google.com>
X-Gm-Message-State: ALoCoQmYAFjAE0ReGgA/5jAlSOUaA3q7rdNSYPxts86CTJG/r3dTdHW6JsGd/rUathF0/UFtK5iHIG7AXdktsaHMdYdyV6xuMnG/F2tlKIg0BGY/7J/9BSP8IlA+CGZ+Vy0x8viPUm6Smgp4Z/mwLB4i2uSwSjABeJ0YmLw1YSSob/UqcHBsse4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192557>

If set, the second column of the rebase todo contains named revisions (obtained
with git name-rev) instead of short SHA1s.
---
 Documentation/git-rebase.txt  |   11 +++++++++++
 git-rebase--interactive.sh    |   11 ++++++++---
 git-rebase.sh                 |   10 ++++++++++
 t/t3404-rebase-interactive.sh |   11 +++++++++++
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 504945c..e7ecd2c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -365,6 +365,17 @@ If the '--autosquash' option is enabled by default using the
 configuration variable `rebase.autosquash`, this option can be
 used to override and disable this setting.
 
+--name-rev::
+--no-name-rev::
+	Instead of showing short SHA1 hashes in the todo list, show
+	human-readable revisions obtained with linkgit:git-name-rev[1].
++
+This option is only valid when the '--interactive' option is used.
++
+If the '--name-rev' option is enabled by default using the
+configuration variable `rebase.interactivenamerev`, this option can be
+used to override and disable this setting.
+
 --no-ff::
 	With --interactive, cherry-pick all rebased commits instead of
 	fast-forwarding over the unchanged ones.  This ensures that the
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8dcb8b0..5583dcb 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -780,10 +780,15 @@ git rev-list $merges_option --pretty=oneline --no-abbrev-commit \
 	sed -n "s/^>//p" |
 while read -r sha1 rest
 do
-	shortsha1=$(echo $sha1 | cut -c1-7)
+	if test t = "$name_rev"
+	then
+		rev="$(git name-rev $sha1 | cut -d\  -f2)"
+	else
+		rev=$(echo $sha1 | cut -c1-7)
+	fi
 	if test t != "$preserve_merges"
 	then
-		printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
+		printf '%s\n' "pick $rev $rest" >> "$todo"
 	else
 		if test -z "$rebase_root"
 		then
@@ -801,7 +806,7 @@ do
 		if test f = "$preserve"
 		then
 			touch "$rewritten"/$sha1
-			printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
+			printf '%s\n' "pick $rev $rest" >> "$todo"
 		fi
 	fi
 done
diff --git a/git-rebase.sh b/git-rebase.sh
index 69c1374..9330be3 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -43,6 +43,8 @@ s,strategy=!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
 m,merge!           use merging strategies to rebase
 i,interactive!     let the user edit the list of commits to rebase
+name-rev           show revisions by name in the list of commits
+no-name-rev        show revisions by short SHA1 in the list (default)
 f,force-rebase!    force rebase even if branch is up to date
 X,strategy-option=! pass the argument through to the merge strategy
 stat!              display a diffstat of what changed upstream
@@ -98,6 +100,8 @@ action=
 preserve_merges=
 autosquash=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
+name_rev=
+test "$(git config --bool rebase.interactivenamerev)" = "true" && name_rev=t
 
 read_basic_state () {
 	head_name=$(cat "$state_dir"/head-name) &&
@@ -287,6 +291,12 @@ do
 	-f|--no-ff)
 		force_rebase=t
 		;;
+	--name-rev)
+		name_rev=t
+		;;
+	--no-name-rev)
+		name_rev=
+		;;
 	--rerere-autoupdate|--no-rerere-autoupdate)
 		allow_rerere_autoupdate="$1"
 		;;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b981572..299ce40 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -163,6 +163,17 @@ test_expect_success 'exchange two commits' '
 	test G = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
+cat > expect-rebase-todo <<EOF
+pick branch1~1 H
+pick branch1 G
+EOF
+
+test_expect_success 'Symbolic revisions in --name-rev' '
+	exec > debug.log 2>&1 &&
+	FAKE_LINES="exec_cp_.git/rebase-merge/git-rebase-todo_rebase-todo 1 2" git rebase -i --name-rev HEAD~2 &&
+	test_cmp expect-rebase-todo rebase-todo
+'
+
 cat > expect << EOF
 diff --git a/file1 b/file1
 index f70f10e..fd79235 100644
-- 
1.7.7.3
