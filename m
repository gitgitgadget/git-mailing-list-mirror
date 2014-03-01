From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 12/27] *.sh: avoid hardcoding $GIT_DIR/hooks/...
Date: Sat,  1 Mar 2014 19:12:48 +0700
Message-ID: <1393675983-3232-13-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:22:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJivi-00028r-1F
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbaCAMWF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:22:05 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:60807 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbaCAMWD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:22:03 -0500
Received: by mail-pa0-f52.google.com with SMTP id rd3so378766pab.39
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6VUKcYUbjteipZFLRw6qM3270mkZQeq09npKSVb0WMo=;
        b=pJ4Akk5hYGggeZCCG4Y3iUOVXXr+MSvvNl/vbX95gNyhpdHhI/zqVyb+GCUTERZe8D
         XSztqLWCCxztbq3xWFsi9C+2hqDsSDHPb8TRdlybNcR5ZtC+prToLn8etelyKTQP7PLD
         bG942UC00e1/f6jZwXHBGKkgdnPvcMXYKNjQ+UxrUD5S8fhcWp/EBZg0Oji3jS9+/VNh
         XUwNz1OvfsrrfMGZog5bFgZ6X/qmLMHyMX4Nl3T1R8VA1zIWRryeNrGSLzwELb7XGzCp
         cyIOvtP32NUmwhj19miiGQpBzaNXB7KGj5A6XvkncKyu/zhZT4e7oFc/wJp6zNcCUU+9
         5XvA==
X-Received: by 10.68.131.202 with SMTP id oo10mr9175355pbb.35.1393676523395;
        Sat, 01 Mar 2014 04:22:03 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id pe3sm15903167pbc.23.2014.03.01.04.22.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:22:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:22:28 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243077>

If $GIT_COMMON_DIR is set, it should be $GIT_COMMON_DIR/hooks/, not
$GIT_DIR/hooks/. Just let rev-parse --git-path handle it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-am.sh                              | 22 +++++++++++-----------
 git-rebase--interactive.sh             |  6 +++---
 git-rebase--merge.sh                   |  6 ++----
 git-rebase.sh                          |  4 ++--
 templates/hooks--applypatch-msg.sample |  4 ++--
 templates/hooks--pre-applypatch.sample |  4 ++--
 6 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index bbea430..dfa0618 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -803,10 +803,10 @@ To restore the original branch and stop patching =
run \"\$cmdline --abort\"."
 		continue
 	fi
=20
-	if test -x "$GIT_DIR"/hooks/applypatch-msg
+	hook=3D"`git rev-parse --git-path hooks/applypatch-msg`"
+	if test -x "$hook"
 	then
-		"$GIT_DIR"/hooks/applypatch-msg "$dotest/final-commit" ||
-		stop_here $this
+		"$hook" "$dotest/final-commit" || stop_here $this
 	fi
=20
 	if test -f "$dotest/final-commit"
@@ -880,9 +880,10 @@ did you forget to use 'git add'?"
 		stop_here_user_resolve $this
 	fi
=20
-	if test -x "$GIT_DIR"/hooks/pre-applypatch
+	hook=3D"`git rev-parse --git-path hooks/pre-applypatch`"
+	if test -x "$hook"
 	then
-		"$GIT_DIR"/hooks/pre-applypatch || stop_here $this
+		"$hook" || stop_here $this
 	fi
=20
 	tree=3D$(git write-tree) &&
@@ -908,18 +909,17 @@ did you forget to use 'git add'?"
 		echo "$(cat "$dotest/original-commit") $commit" >> "$dotest/rewritte=
n"
 	fi
=20
-	if test -x "$GIT_DIR"/hooks/post-applypatch
-	then
-		"$GIT_DIR"/hooks/post-applypatch
-	fi
+	hook=3D"`git rev-parse --git-path hooks/post-applypatch`"
+	test -x "$hook" && "$hook"
=20
 	go_next
 done
=20
 if test -s "$dotest"/rewritten; then
     git notes copy --for-rewrite=3Drebase < "$dotest"/rewritten
-    if test -x "$GIT_DIR"/hooks/post-rewrite; then
-	"$GIT_DIR"/hooks/post-rewrite rebase < "$dotest"/rewritten
+    hook=3D"`git rev-parse --git-path hooks/post-rewrite`"
+    if test -x "$hook"; then
+	"$hook" rebase < "$dotest"/rewritten
     fi
 fi
=20
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 43c19e0..d741b04 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -632,9 +632,9 @@ do_next () {
 		git notes copy --for-rewrite=3Drebase < "$rewritten_list" ||
 		true # we don't care if this copying failed
 	} &&
-	if test -x "$GIT_DIR"/hooks/post-rewrite &&
-		test -s "$rewritten_list"; then
-		"$GIT_DIR"/hooks/post-rewrite rebase < "$rewritten_list"
+	hook=3D"`git rev-parse --git-path hooks/post-rewrite`"
+	if test -x "$hook" && test -s "$rewritten_list"; then
+		"$hook" rebase < "$rewritten_list"
 		true # we don't care if this hook failed
 	fi &&
 	warn "Successfully rebased and updated $head_name."
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index e7d96de..68f5d09 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -93,10 +93,8 @@ finish_rb_merge () {
 	if test -s "$state_dir"/rewritten
 	then
 		git notes copy --for-rewrite=3Drebase <"$state_dir"/rewritten
-		if test -x "$GIT_DIR"/hooks/post-rewrite
-		then
-			"$GIT_DIR"/hooks/post-rewrite rebase <"$state_dir"/rewritten
-		fi
+		hook=3D"`git rev-parse --git-path hooks/post-rewrite`"
+		test -x "$hook" && "$hook" rebase <"$state_dir"/rewritten
 	fi
 	say All done.
 }
diff --git a/git-rebase.sh b/git-rebase.sh
index 8a3efa2..1cf8dba 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -195,9 +195,9 @@ run_specific_rebase () {
=20
 run_pre_rebase_hook () {
 	if test -z "$ok_to_skip_pre_rebase" &&
-	   test -x "$GIT_DIR/hooks/pre-rebase"
+	   test -x "`git rev-parse --git-path hooks/pre-rebase`"
 	then
-		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} ||
+		"`git rev-parse --git-path hooks/pre-rebase`" ${1+"$@"} ||
 		die "$(gettext "The pre-rebase hook refused to rebase.")"
 	fi
 }
diff --git a/templates/hooks--applypatch-msg.sample b/templates/hooks--=
applypatch-msg.sample
index 8b2a2fe..28b843b 100755
--- a/templates/hooks--applypatch-msg.sample
+++ b/templates/hooks--applypatch-msg.sample
@@ -10,6 +10,6 @@
 # To enable this hook, rename this file to "applypatch-msg".
=20
 . git-sh-setup
-test -x "$GIT_DIR/hooks/commit-msg" &&
-	exec "$GIT_DIR/hooks/commit-msg" ${1+"$@"}
+commitmsg=3D"`git rev-parse --git-path hooks/commit-msg`"
+test -x "$commitmsg" && exec "$commitmsg" ${1+"$@"}
 :
diff --git a/templates/hooks--pre-applypatch.sample b/templates/hooks--=
pre-applypatch.sample
index b1f187c..51aa244 100755
--- a/templates/hooks--pre-applypatch.sample
+++ b/templates/hooks--pre-applypatch.sample
@@ -9,6 +9,6 @@
 # To enable this hook, rename this file to "pre-applypatch".
=20
 . git-sh-setup
-test -x "$GIT_DIR/hooks/pre-commit" &&
-	exec "$GIT_DIR/hooks/pre-commit" ${1+"$@"}
+precommit=3D"`git rev-parse --git-path hooks/pre-commit`"
+test -x "$precommit" && exec "$precommit" ${1+"$@"}
 :
--=20
1.9.0.40.gaa8c3ea
