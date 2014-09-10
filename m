From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 13/32] *.sh: avoid hardcoding $GIT_DIR/hooks/...
Date: Thu, 11 Sep 2014 05:41:49 +0700
Message-ID: <1410388928-32265-14-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:43:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqbf-0001hH-Um
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbaIJWnO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:43:14 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:43258 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbaIJWnM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:43:12 -0400
Received: by mail-pd0-f174.google.com with SMTP id v10so11973356pde.5
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZUwL/U2dzrQW8eMxyiIB/Vs+BbjCkreL4gVQveL80Xw=;
        b=EwSPLTKfz8R0ponpmdkl+z/BuHKxKlIwtMxjUouBHxxiU+OkhyzxKha3VYf0JJgfkq
         hms5etAm41p4bWbtm9PNLBi6p11ozBSEH4OviFfgsPOIdsqLFtC2+4aAAsOODPuhgjKn
         Ko5RVQr8WwsQrpJcpdCycIfqFkF4KRdEWFthKltxv/g8eDwze6ONPejz0c8A00QVM9v3
         2AO4WznXR3KH7SzIB61xbddPx8pbbE/O5MBihyIZgLlojPAGK/E3Vd6Z4QoRuxgMaKd6
         bzRQ5CLUr1gjO+Llg71zzcinhj+Pt+GzPnF7Eh49KXWItCJ0IQbWtxsE5Cg1rGUFcyvF
         ncRA==
X-Received: by 10.70.90.237 with SMTP id bz13mr70968968pdb.110.1410388992328;
        Wed, 10 Sep 2014 15:43:12 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id j5sm15622542pdp.9.2014.09.10.15.43.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:43:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:43:32 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256790>

If $GIT_COMMON_DIR is set, it should be $GIT_COMMON_DIR/hooks/, not
$GIT_DIR/hooks/. Just let rev-parse --git-path handle it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.1.0.rc0.78.gc0d8480
