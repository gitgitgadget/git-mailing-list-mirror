From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] status: hint the user about -uno if read_directory takes too long
Date: Wed, 13 Mar 2013 19:59:16 +0700
Message-ID: <1363179556-4144-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, tboegi@web.de,
	artagnon@gmail.com, robert.allan.zeh@gmail.com, finnag@pvv.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 13 13:59:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFlHe-0006hL-EC
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 13:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471Ab3CMM71 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Mar 2013 08:59:27 -0400
Received: from mail-da0-f50.google.com ([209.85.210.50]:59912 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab3CMM70 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 08:59:26 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so403572dae.9
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 05:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ulU86SsEmWyPbGC/i3xQOBA7EaL6MjRslp9ro9+b7N4=;
        b=H6A6S/BtVLft6ZWZm08ZKhgr+mkNZ05nFePE4C/ifmsdqE4cW0jVKyEJRMGbHnzxME
         CcJZPHylorMd6sawrpcOcL+Wgl2L7J3isRZDxBEm21HOjVgtc6ITQGdVPQnZ+21TQSNK
         TKXYz54gx2vHGBNFeXRbGMbX1uAg4mcF5iRTvhXguftUjFag7uBkZyKO3lLrxpTRSTDf
         5XkK2syWrRmTcWM8lcUcx1mVg7wx8Qq11HKrTZdcmXndlkI9/DUP4uDzM9XtCJUkf99a
         meYM+ccgJ9NJX8bhl6uy3GpaIqM+9/y7ws+JeBY5L53yVWJvVVpR5jsavOp9GnTm7KuJ
         9H2g==
X-Received: by 10.68.48.168 with SMTP id m8mr39697440pbn.138.1363179565845;
        Wed, 13 Mar 2013 05:59:25 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id ab1sm29520989pbd.37.2013.03.13.05.59.20
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Mar 2013 05:59:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Mar 2013 19:59:17 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218053>

This patch attempts to advertise -uno to the users who tolerate slow
"git status" on large repositories (or slow machines/disks). The 2
seconds limit is quite arbitrary but is probably long enough to start
using -uno.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  4 ++++
 advice.c                 |  2 ++
 advice.h                 |  1 +
 t/t7060-wtstatus.sh      |  2 ++
 t/t7508-status.sh        |  4 ++++
 t/t7512-status-help.sh   |  1 +
 wt-status.c              | 20 +++++++++++++++++++-
 wt-status.h              |  1 +
 8 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bbba728..e91d06f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -178,6 +178,10 @@ advice.*::
 		the template shown when writing commit messages in
 		linkgit:git-commit[1], and in the help message shown
 		by linkgit:git-checkout[1] when switching branch.
+	statusUno::
+		If collecting untracked files in linkgit:git-status[1]
+		takes more than 2 seconds, hint the user that the option
+		`-uno` could be used to stop collecting untracked files.
 	commitBeforeMerge::
 		Advice shown when linkgit:git-merge[1] refuses to
 		merge to avoid overwriting local changes.
diff --git a/advice.c b/advice.c
index 780f58d..72b5c66 100644
--- a/advice.c
+++ b/advice.c
@@ -8,6 +8,7 @@ int advice_push_already_exists =3D 1;
 int advice_push_fetch_first =3D 1;
 int advice_push_needs_force =3D 1;
 int advice_status_hints =3D 1;
+int advice_status_uno =3D 1;
 int advice_commit_before_merge =3D 1;
 int advice_resolve_conflict =3D 1;
 int advice_implicit_identity =3D 1;
@@ -25,6 +26,7 @@ static struct {
 	{ "pushfetchfirst", &advice_push_fetch_first },
 	{ "pushneedsforce", &advice_push_needs_force },
 	{ "statushints", &advice_status_hints },
+	{ "statusuno", &advice_status_uno },
 	{ "commitbeforemerge", &advice_commit_before_merge },
 	{ "resolveconflict", &advice_resolve_conflict },
 	{ "implicitidentity", &advice_implicit_identity },
diff --git a/advice.h b/advice.h
index fad36df..d7e03be 100644
--- a/advice.h
+++ b/advice.h
@@ -11,6 +11,7 @@ extern int advice_push_already_exists;
 extern int advice_push_fetch_first;
 extern int advice_push_needs_force;
 extern int advice_status_hints;
+extern int advice_status_uno;
 extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index f4f38a5..dd340d5 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -5,6 +5,7 @@ test_description=3D'basic work tree status reporting'
 . ./test-lib.sh
=20
 test_expect_success setup '
+	git config advice.statusuno false &&
 	test_commit A &&
 	test_commit B oneside added &&
 	git checkout A^0 &&
@@ -46,6 +47,7 @@ test_expect_success 'M/D conflict does not segfault' =
'
 	(
 		cd mdconflict &&
 		git init &&
+		git config advice.statusuno false
 		test_commit initial foo "" &&
 		test_commit modify foo foo &&
 		git checkout -b side HEAD^ &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index a79c032..9d6e4db 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -8,11 +8,13 @@ test_description=3D'git status'
 . ./test-lib.sh
=20
 test_expect_success 'status -h in broken repository' '
+	git config advice.statusuno false &&
 	mkdir broken &&
 	test_when_finished "rm -fr broken" &&
 	(
 		cd broken &&
 		git init &&
+		git config advice.statusuno false &&
 		echo "[status] showuntrackedfiles =3D CORRUPT" >>.git/config &&
 		test_expect_code 129 git status -h >usage 2>&1
 	) &&
@@ -25,6 +27,7 @@ test_expect_success 'commit -h in broken repository' =
'
 	(
 		cd broken &&
 		git init &&
+		git config advice.statusuno false &&
 		echo "[status] showuntrackedfiles =3D CORRUPT" >>.git/config &&
 		test_expect_code 129 git commit -h >usage 2>&1
 	) &&
@@ -780,6 +783,7 @@ test_expect_success 'status refreshes the index' '
 test_expect_success 'setup status submodule summary' '
 	test_create_repo sm && (
 		cd sm &&
+		git config advice.statusuno false &&
 		>foo &&
 		git add foo &&
 		git commit -m "Add foo"
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index d2da89a..033a1b3 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -14,6 +14,7 @@ test_description=3D'git status advice'
 set_fake_editor
=20
 test_expect_success 'prepare for conflicts' '
+	git config advice.statusuno false &&
 	test_commit init main.txt init &&
 	git branch conflicts &&
 	test_commit on_master main.txt on_master &&
diff --git a/wt-status.c b/wt-status.c
index ef405d0..6fde08b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -540,7 +540,16 @@ void wt_status_collect(struct wt_status *s)
 		wt_status_collect_changes_initial(s);
 	else
 		wt_status_collect_changes_index(s);
-	wt_status_collect_untracked(s);
+	if (s->show_untracked_files && advice_status_uno) {
+		struct timeval tv1, tv2;
+		gettimeofday(&tv1, NULL);
+		wt_status_collect_untracked(s);
+		gettimeofday(&tv2, NULL);
+		s->untracked_in_ms =3D
+			(uint64_t)tv2.tv_sec * 1000 + tv2.tv_usec / 1000 -
+			((uint64_t)tv1.tv_sec * 1000 + tv1.tv_usec / 1000);
+	} else
+		wt_status_collect_untracked(s);
 }
=20
 static void wt_status_print_unmerged(struct wt_status *s)
@@ -1097,6 +1106,15 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_other(s, &s->untracked, _("Untracked files"), "add")=
;
 		if (s->show_ignored_files)
 			wt_status_print_other(s, &s->ignored, _("Ignored files"), "add -f")=
;
+		if (advice_status_uno && s->untracked_in_ms > 2000) {
+			status_printf_ln(s, GIT_COLOR_NORMAL,
+					 _("It took %.2f seconds to collect untracked files."),
+					 (float)s->untracked_in_ms / 1000);
+			status_printf_ln(s, GIT_COLOR_NORMAL,
+					 _("If it happens often, you may want to use option -uno"));
+			status_printf_ln(s, GIT_COLOR_NORMAL,
+					 _("to speed up by stopping displaying untracked files"));
+		}
 	} else if (s->commitable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%=
s"),
 			advice_status_hints
diff --git a/wt-status.h b/wt-status.h
index 81e1dcf..74208c0 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -69,6 +69,7 @@ struct wt_status {
 	struct string_list change;
 	struct string_list untracked;
 	struct string_list ignored;
+	uint32_t untracked_in_ms;
 };
=20
 struct wt_status_state {
--=20
1.8.1.2.536.gf441e6d
