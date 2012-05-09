From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] apply: remove lego in i18n string in gitdiff_verify_name
Date: Wed,  9 May 2012 19:29:22 +0700
Message-ID: <1336566562-21933-1-git-send-email-pclouds@gmail.com>
References: <7vd36ewqi2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 14:33:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS64y-0007X2-JN
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 14:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509Ab2EIMdM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 08:33:12 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35909 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2EIMdK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 08:33:10 -0400
Received: by dady13 with SMTP id y13so251605dad.19
        for <git@vger.kernel.org>; Wed, 09 May 2012 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1RGvgFFFa/fkf+9W1gPg4vu35HkEWmPxHMThrmFbmWE=;
        b=YyeT8+AnagcYqJmUPO82MotQquo4JKsDkMZUQVznabLQAnBMeBFpNASxy2kc66MVxS
         zo4PO6yqpjrliJTKWUG+GgQ4bIZcSySEQWKT92xBxYbMT2EW9Av3kjnN4PsDU33ZgDPS
         7gWNEyxmYfXoh8gwbpj4m7Ax66p3KrtwPY7/Qxl8zKxt3RbwwhJwx631HhaPGtML5bWz
         //9A/Y8bvxFWkQzVYfy7USO3KFfp6SLOdP5MHTodPkNhvJ+VnMu+vqzWUMS/GXbgPa2x
         Mb2kn3Ibqgz6GTfUEAqCg+yg+Fmpb8dc7b2xkngOhUycCdIct8DU6JUfjza8GogcPffo
         36hg==
Received: by 10.68.226.5 with SMTP id ro5mr8688764pbc.74.1336566790203;
        Wed, 09 May 2012 05:33:10 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.158])
        by mx.google.com with ESMTPS id pb4sm5955899pbc.55.2012.05.09.05.33.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 May 2012 05:33:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 May 2012 19:29:24 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <7vd36ewqi2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197468>

Currently it marks the string "...inconsistent %s filename..." where
%s is either "old" or "new" from caller. From a translator point of
view, nothing hints what "%s" may be and what grammatical form it may
use.

Make it two strings "...inconsistent new filename..." and
"...inconsistent old filename..."

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Another try. enum this time.

 builtin/apply.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 725712d..3362f4a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -910,6 +910,11 @@ static int gitdiff_hdrend(const char *line, struct=
 patch *patch)
 	return -1;
 }
=20
+enum diff_filename {
+	DIFF_OLD,
+	DIFF_NEW
+};
+
 /*
  * We're anal about diff header consistency, to make
  * sure that we don't end up having strange ambiguous
@@ -919,7 +924,8 @@ static int gitdiff_hdrend(const char *line, struct =
patch *patch)
  * their names against any previous information, just
  * to make sure..
  */
-static char *gitdiff_verify_name(const char *line, int isnull, char *o=
rig_name, const char *oldnew)
+static char *gitdiff_verify_name(const char *line, int isnull, char *o=
rig_name,
+				 enum diff_filename oldnew)
 {
 	if (!orig_name && !isnull)
 		return find_name(line, NULL, p_value, TERM_TAB);
@@ -934,7 +940,10 @@ static char *gitdiff_verify_name(const char *line,=
 int isnull, char *orig_name,
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line=
 %d"), name, linenr);
 		another =3D find_name(line, NULL, p_value, TERM_TAB);
 		if (!another || memcmp(another, name, len + 1))
-			die(_("git apply: bad git-diff - inconsistent %s filename on line %=
d"), oldnew, linenr);
+			die(oldnew =3D=3D DIFF_OLD ?
+			    _("git apply: bad git-diff - inconsistent old filename on line =
%d") :
+			    _("git apply: bad git-diff - inconsistent new filename on line =
%d"),
+			    linenr);
 		free(another);
 		return orig_name;
 	}
@@ -949,7 +958,7 @@ static char *gitdiff_verify_name(const char *line, =
int isnull, char *orig_name,
 static int gitdiff_oldname(const char *line, struct patch *patch)
 {
 	char *orig =3D patch->old_name;
-	patch->old_name =3D gitdiff_verify_name(line, patch->is_new, patch->o=
ld_name, "old");
+	patch->old_name =3D gitdiff_verify_name(line, patch->is_new, patch->o=
ld_name, DIFF_OLD);
 	if (orig !=3D patch->old_name)
 		free(orig);
 	return 0;
@@ -958,7 +967,7 @@ static int gitdiff_oldname(const char *line, struct=
 patch *patch)
 static int gitdiff_newname(const char *line, struct patch *patch)
 {
 	char *orig =3D patch->new_name;
-	patch->new_name =3D gitdiff_verify_name(line, patch->is_delete, patch=
->new_name, "new");
+	patch->new_name =3D gitdiff_verify_name(line, patch->is_delete, patch=
->new_name, DIFF_NEW);
 	if (orig !=3D patch->new_name)
 		free(orig);
 	return 0;
--=20
1.7.8.36.g69ee2
