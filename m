From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 13/31] *.sh: avoid hardcoding $GIT_DIR/hooks/...
Date: Sun, 13 Jul 2014 11:50:50 +0700
Message-ID: <1405227068-25506-14-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:54:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Bnr-0000Bt-02
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbaGMEyT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:54:19 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:62747 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbaGMEyR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:54:17 -0400
Received: by mail-pd0-f178.google.com with SMTP id r10so3517252pdi.9
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MDkrhVpTuJNU3Dg1XMSO8HTbziKvZb93Dp4Fq9MUsRY=;
        b=N+z3jTT9lGwBa99HVwTdR3ia42rJggTOgQUcc7fl2Me146kJfH8tP587xnB4jZ/vV5
         OwFKdd7lVL1B96ACpxeIZT6asytd31AxQqhrMRYejZwqkfB37WZCwH0N8tm3232B6Ky3
         RLWH1LiLqqsEugL3o3KfmKhaVTtq+BO5HkVmZ3+RYMtGmIlSUvu6WnCG9Y3XDLuJ/l2s
         m8ektX4QrBywwVFrlBzCjJGMQlfdczE+o+bQKENewW5E5D27P10Akd756/CpeDCVQMQz
         48DGMPPz+bRI+pF7ikVFlWg7DB3vn5bVmMvdTsEdLy8S9dadyYVeasKKyKDjC29Wa4y5
         h+GA==
X-Received: by 10.70.100.34 with SMTP id ev2mr2531551pdb.81.1405227257041;
        Sat, 12 Jul 2014 21:54:17 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id kt2sm6741084pbc.83.2014.07.12.21.54.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:54:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:54:17 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253416>

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
index ee61a77..66803d1 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -810,10 +810,10 @@ To restore the original branch and stop patching =
run \"\$cmdline --abort\"."
 		continue
 	fi
=20
-	if test -x "$GIT_DIR"/hooks/applypatch-msg
+	hook=3D"$(git rev-parse --git-path hooks/applypatch-msg)"
+	if test -x "$hook"
 	then
-		"$GIT_DIR"/hooks/applypatch-msg "$dotest/final-commit" ||
-		stop_here $this
+		"$hook" "$dotest/final-commit" || stop_here $this
 	fi
=20
 	if test -f "$dotest/final-commit"
@@ -887,9 +887,10 @@ did you forget to use 'git add'?"
 		stop_here_user_resolve $this
 	fi
=20
-	if test -x "$GIT_DIR"/hooks/pre-applypatch
+	hook=3D"$(git rev-parse --git-path hooks/pre-applypatch)"
+	if test -x "$hook"
 	then
-		"$GIT_DIR"/hooks/pre-applypatch || stop_here $this
+		"$hook" || stop_here $this
 	fi
=20
 	tree=3D$(git write-tree) &&
@@ -916,18 +917,17 @@ did you forget to use 'git add'?"
 		echo "$(cat "$dotest/original-commit") $commit" >> "$dotest/rewritte=
n"
 	fi
=20
-	if test -x "$GIT_DIR"/hooks/post-applypatch
-	then
-		"$GIT_DIR"/hooks/post-applypatch
-	fi
+	hook=3D"$(git rev-parse --git-path hooks/post-applypatch)"
+	test -x "$hook" && "$hook"
=20
 	go_next
 done
=20
 if test -s "$dotest"/rewritten; then
     git notes copy --for-rewrite=3Drebase < "$dotest"/rewritten
-    if test -x "$GIT_DIR"/hooks/post-rewrite; then
-	"$GIT_DIR"/hooks/post-rewrite rebase < "$dotest"/rewritten
+    hook=3D"$(git rev-parse --git-path hooks/post-rewrite)"
+    if test -x "$hook"; then
+	"$hook" rebase < "$dotest"/rewritten
     fi
 fi
=20
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 7e1eda0..e8995f9 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -642,9 +642,9 @@ do_next () {
 		git notes copy --for-rewrite=3Drebase < "$rewritten_list" ||
 		true # we don't care if this copying failed
 	} &&
-	if test -x "$GIT_DIR"/hooks/post-rewrite &&
-		test -s "$rewritten_list"; then
-		"$GIT_DIR"/hooks/post-rewrite rebase < "$rewritten_list"
+	hook=3D"$(git rev-parse --git-path hooks/post-rewrite)"
+	if test -x "$hook" && test -s "$rewritten_list"; then
+		"$hook" rebase < "$rewritten_list"
 		true # we don't care if this hook failed
 	fi &&
 	warn "Successfully rebased and updated $head_name."
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index d3fb67d..2cc2a6d 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -94,10 +94,8 @@ finish_rb_merge () {
 	if test -s "$state_dir"/rewritten
 	then
 		git notes copy --for-rewrite=3Drebase <"$state_dir"/rewritten
-		if test -x "$GIT_DIR"/hooks/post-rewrite
-		then
-			"$GIT_DIR"/hooks/post-rewrite rebase <"$state_dir"/rewritten
-		fi
+		hook=3D"$(git rev-parse --git-path hooks/post-rewrite)"
+		test -x "$hook" && "$hook" rebase <"$state_dir"/rewritten
 	fi
 	say All done.
 }
diff --git a/git-rebase.sh b/git-rebase.sh
index 06c810b..d60e710 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -201,9 +201,9 @@ run_specific_rebase () {
=20
 run_pre_rebase_hook () {
 	if test -z "$ok_to_skip_pre_rebase" &&
-	   test -x "$GIT_DIR/hooks/pre-rebase"
+	   test -x "$(git rev-parse --git-path hooks/pre-rebase)"
 	then
-		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} ||
+		"$(git rev-parse --git-path hooks/pre-rebase)" ${1+"$@"} ||
 		die "$(gettext "The pre-rebase hook refused to rebase.")"
 	fi
 }
diff --git a/templates/hooks--applypatch-msg.sample b/templates/hooks--=
applypatch-msg.sample
index 8b2a2fe..a5d7b84 100755
--- a/templates/hooks--applypatch-msg.sample
+++ b/templates/hooks--applypatch-msg.sample
@@ -10,6 +10,6 @@
 # To enable this hook, rename this file to "applypatch-msg".
=20
 . git-sh-setup
-test -x "$GIT_DIR/hooks/commit-msg" &&
-	exec "$GIT_DIR/hooks/commit-msg" ${1+"$@"}
+commitmsg=3D"$(git rev-parse --git-path hooks/commit-msg)"
+test -x "$commitmsg" && exec "$commitmsg" ${1+"$@"}
 :
diff --git a/templates/hooks--pre-applypatch.sample b/templates/hooks--=
pre-applypatch.sample
index b1f187c..4142082 100755
--- a/templates/hooks--pre-applypatch.sample
+++ b/templates/hooks--pre-applypatch.sample
@@ -9,6 +9,6 @@
 # To enable this hook, rename this file to "pre-applypatch".
=20
 . git-sh-setup
-test -x "$GIT_DIR/hooks/pre-commit" &&
-	exec "$GIT_DIR/hooks/pre-commit" ${1+"$@"}
+precommit=3D"$(git rev-parse --git-path hooks/pre-commit)"
+test -x "$precommit" && exec "$precommit" ${1+"$@"}
 :
--=20
1.9.1.346.ga2b5940
