From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] rebase: new convenient option to edit a single commit
Date: Sun,  2 Mar 2014 09:53:14 +0700
Message-ID: <1393728794-29566-4-git-send-email-pclouds@gmail.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
 <1393728794-29566-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, philipoakley@iee.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 03:54:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJwXQ-0000Om-Un
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 03:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468AbaCBCx4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 21:53:56 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:50524 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbaCBCxq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 21:53:46 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so2391969pbb.0
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 18:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Sz8MuB6rDz0ueKDkfrYZsjFAnOAPMVp6+rxCJCXZIPw=;
        b=jXMK56kJ3B5Y57hnFHw/8Jx7lwW9lHySo+idyvUZ+VG5YzkHeO9VrNn13N7lMPGpS7
         65EEG4WQBTQaLmViVc+vn6TWfrkzrCGUJWHAecF89NYLVP5IV9LPs5QZ9xzF/o0rrS+L
         Fl/ltLj8e8QCUP/gxnTcfsCJf7En3y/gZJspyFk+UiL7ntE2VBCgv/ot4phopZirrTmr
         iexQQk8tqRMPTrmKx/7kgOlsV/ekNNAviPA2KCzj9hhK3pIhdgLYnJ+XuEI/7MPlt8BI
         4wGCwxnh8wS6uGdaUqUx99ToialdloBaC/UwXZpdu5bUfm6uQayTTr0aRS4cxB4h3Pkk
         6hXQ==
X-Received: by 10.68.141.10 with SMTP id rk10mr3685171pbb.68.1393728825681;
        Sat, 01 Mar 2014 18:53:45 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id js7sm21000246pbc.35.2014.03.01.18.53.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 18:53:44 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 02 Mar 2014 09:54:11 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393728794-29566-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243123>

"git rebase -e XYZ" is basically the same as

EDITOR=3D"sed -i '1s/pick XYZ/edit XYZ/' $@" \
git rebase -i XYZ^

In English, it prepares the todo list for you to edit only commit XYZ
to save your time. The time saving is only significant when you edit a
lot of commits separately.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-rebase.txt |  4 ++++
 git-rebase--interactive.sh   | 17 ++++++++++++++---
 git-rebase.sh                | 10 ++++++++++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 52c3561..b8c263d 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -359,6 +359,10 @@ unless the `--fork-point` option is specified.
 	user edit that list before rebasing.  This mode can also be used to
 	split commits (see SPLITTING COMMITS below).
=20
+-e::
+--edit-one::
+	Prepare the todo list to edit only the commit at <upstream>
+
 -p::
 --preserve-merges::
 	Instead of ignoring merges, try to recreate them.
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a1adae8..4762d57 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1040,9 +1040,20 @@ fi
 has_action "$todo" ||
 	die_abort "Nothing to do"
=20
-cp "$todo" "$todo".backup
-git_sequence_editor "$todo" ||
-	die_abort "Could not execute editor"
+if test -n "$edit_one"
+then
+	edit_one=3D"`git rev-parse --short $edit_one`"
+	sed "1s/pick $edit_one /edit $edit_one /" "$todo" > "$todo.new" ||
+		die_abort "failed to update todo list"
+	grep "^edit $edit_one " "$todo.new" >/dev/null ||
+		die_abort "expected to find 'edit $edit_one' line but did not"
+	mv "$todo.new" "$todo" ||
+		die_abort "failed to update todo list"
+else
+	cp "$todo" "$todo".backup
+	git_sequence_editor "$todo" ||
+		die_abort "Could not execute editor"
+fi
=20
 has_action "$todo" ||
 	die_abort "Nothing to do"
diff --git a/git-rebase.sh b/git-rebase.sh
index 33face1..b8b6aa9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -32,6 +32,7 @@ verify             allow pre-rebase hook to run
 rerere-autoupdate  allow rerere to update index with resolved conflict=
s
 root!              rebase all reachable commits up to the root(s)
 autosquash         move commits that begin with squash!/fixup! under -=
i
+e,edit-one!        generate todo list to edit this commit
 committer-date-is-author-date! passed to 'git am'
 ignore-date!       passed to 'git am'
 whitespace=3D!       passed to 'git apply'
@@ -339,6 +340,10 @@ do
 	-NUM=3D*)
 		NUM=3D"${1#-NUM=3D}"
 		;;
+	--edit-one)
+		interactive_rebase=3Dexplicit
+		edit_one=3Dt
+		;;
 	--)
 		shift
 		break
@@ -463,6 +468,11 @@ then
 		;;
 	*)	upstream_name=3D"$1"
 		shift
+		if test -n "$edit_one"
+		then
+			edit_one=3D"$upstream_name"
+			upstream_name=3D"$upstream_name^"
+		fi
 		;;
 	esac
 	upstream=3D$(peel_committish "${upstream_name}") ||
--=20
1.9.0.40.gaa8c3ea
