From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 4/5] git-commit: remove lego in i18n messages
Date: Mon, 30 Apr 2012 15:33:13 +0000
Message-ID: <1335799995-7667-5-git-send-email-avarab@gmail.com>
References: <1335799995-7667-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 17:33:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOsbg-0001J5-LU
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 17:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703Ab2D3Pdl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 11:33:41 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55592 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab2D3Pde (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 11:33:34 -0400
Received: by mail-bk0-f46.google.com with SMTP id ji2so383521bkc.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ce2HN5N65nM+zLFGXR2ppV6muQSl5W0PrdZKMUWQcaE=;
        b=oJeksAsXwOrZgddkbvTcndAVHAHNDgxP3g4j723IwErIgfy6qj17+D0fs+9MbZ5t94
         lnLge9bbWC5DzAYyusX75v5BZYqIGNuXZHEHT+MRgL/7/1fgh3XAwABUVw5Ste6gA5y0
         bfFLsLppCKOE8EKXs+3aOvbotZfBe4DL76EbNi1ayVGzIfruOmZUDF6tymgzMrfsqJdJ
         /JZHHo10iaLbh4d2+zA+o5iiACOFRl0DstbXPDzsto88YvwmYODY0HB+aonaZzU7HW3P
         lvbiTOuqkbo0rJUwx9nvQhRrZba/fH2ZlfxduCkJ59+8qvQYvp0OgwQ59phQkyt2WhSu
         K9Ww==
Received: by 10.204.129.21 with SMTP id m21mr7449669bks.124.1335800013600;
        Mon, 30 Apr 2012 08:33:33 -0700 (PDT)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id jr13sm27636569bkb.14.2012.04.30.08.33.32
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Apr 2012 08:33:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.546.gbaa1a.dirty
In-Reply-To: <1335799995-7667-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196567>

Remove the whence_s() function and messages that dependen on it in
favor of messages that use either "merge" or "cherry-pick" directly.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/commit.c |   52 +++++++++++++++++++++++-----------------------=
------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index b257ae8..c7c491e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -194,24 +194,6 @@ static void determine_whence(struct wt_status *s)
 		s->whence =3D whence;
 }
=20
-static const char *whence_s(void)
-{
-	const char *s =3D "";
-
-	switch (whence) {
-	case FROM_COMMIT:
-		break;
-	case FROM_MERGE:
-		s =3D _("merge");
-		break;
-	case FROM_CHERRY_PICK:
-		s =3D _("cherry-pick");
-		break;
-	}
-
-	return s;
-}
-
 static void rollback_index_files(void)
 {
 	switch (commit_style) {
@@ -453,8 +435,12 @@ static char *prepare_index(int argc, const char **=
argv, const char *prefix,
 	 */
 	commit_style =3D COMMIT_PARTIAL;
=20
-	if (whence !=3D FROM_COMMIT)
-		die(_("cannot do a partial commit during a %s."), whence_s());
+	if (whence !=3D FROM_COMMIT) {
+		if (whence =3D=3D FROM_MERGE)
+			die(_("cannot do a partial commit during a merge."));
+		else if (whence =3D=3D FROM_CHERRY_PICK)
+			die(_("cannot do a partial commit during a cherry-pick."));
+	}
=20
 	memset(&partial, 0, sizeof(partial));
 	partial.strdup_strings =3D 1;
@@ -796,13 +782,17 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
 		char *ai_tmp, *ci_tmp;
 		if (whence !=3D FROM_COMMIT)
 			status_printf_ln(s, GIT_COLOR_NORMAL,
-				_("\n"
-				"It looks like you may be committing a %s.\n"
-				"If this is not correct, please remove the file\n"
-				"	%s\n"
-				"and try again.\n"
-				""),
-				whence_s(),
+			    whence =3D=3D FROM_MERGE
+				? _("\n"
+					"It looks like you may be committing a merge.\n"
+					"If this is not correct, please remove the file\n"
+					"	%s\n"
+					"and try again.\n")
+				: _("\n"
+					"It looks like you may be committing a cherry-pick.\n"
+					"If this is not correct, please remove the file\n"
+					"	%s\n"
+					"and try again.\n"),
 				git_path(whence =3D=3D FROM_MERGE
 					 ? "MERGE_HEAD"
 					 : "CHERRY_PICK_HEAD"));
@@ -1072,8 +1062,12 @@ static int parse_and_validate_options(int argc, =
const char *argv[],
 	/* Sanity check options */
 	if (amend && !current_head)
 		die(_("You have nothing to amend."));
-	if (amend && whence !=3D FROM_COMMIT)
-		die(_("You are in the middle of a %s -- cannot amend."), whence_s())=
;
+	if (amend && whence !=3D FROM_COMMIT) {
+		if (whence =3D=3D FROM_MERGE)
+			die(_("You are in the middle of a merge -- cannot amend."));
+		else if (whence =3D=3D FROM_CHERRY_PICK)
+			die(_("You are in the middle of a cherry-pick -- cannot amend."));
+	}
 	if (fixup_message && squash_message)
 		die(_("Options --squash and --fixup cannot be used together"));
 	if (use_message)
--=20
1.7.10.546.gbaa1a.dirty
