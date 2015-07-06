From: Evgen Druzhynin <evgen.druzhynin@gmail.com>
Subject: [PATCH] Added ability to scip patch hunk with an empty filename.
Date: Mon,  6 Jul 2015 20:16:14 +0300
Message-ID: <1436202974-7624-2-git-send-email-evgen.druzhynin@gmail.com>
References: <1436202974-7624-1-git-send-email-evgen.druzhynin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Evgen Druzhynin <evgen.druzhynin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:17:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCA16-00077f-FI
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755603AbbGFRRM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jul 2015 13:17:12 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:33132 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621AbbGFRRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:17:09 -0400
Received: by laar3 with SMTP id r3so164235608laa.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=K2UQ+YunCDv/wkVz86nu8yd3bhRsudyDSgHhYSFiZjQ=;
        b=ZAcyGhrx5j2cMFtFPKnTg0PwaFQCedYZPEvR+Og5KpG2UrNjMptUmWvIy7b/OI52s1
         P6qKk+7aeXXEpenYl3jNKt32dG51VnjP4ceXxOh/kSVZLlheWVgl4iQwjgKk9kACtFGC
         VbcHB7xM3t7zuouHn6Dny2p269FwmVSC/1yGY1WJTfinhaW7Blt2jqmjujjFrkXHUkne
         QF0Y25uvYH8Xbpy1wO/0/hwqPd/i15OnNLqjfsDwlMuHEHlBVE0ZFZm/2GKxshGdlpoi
         lGLUNBJS6w0Er9XVG8p5epu4M14moJKfxk7mUfsMiENfqm55wr51ooUBTFLurmrPraS7
         tkGQ==
X-Received: by 10.152.23.167 with SMTP id n7mr50046999laf.108.1436203027145;
        Mon, 06 Jul 2015 10:17:07 -0700 (PDT)
Received: from mech.intropro.com.ua ([193.109.118.129])
        by mx.google.com with ESMTPSA id q1sm4893651lah.27.2015.07.06.10.17.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:17:06 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1436202974-7624-1-git-send-email-evgen.druzhynin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273409>

---
 builtin/apply.c | 16 +++++-----------
 po/bg.po        | 15 ---------------
 po/ca.po        | 15 ---------------
 po/de.po        | 15 ---------------
 po/fr.po        | 15 ---------------
 po/git.pot      | 11 -----------
 po/it.po        | 11 -----------
 po/pt_PT.po     |  7 -------
 po/ru.po        | 12 ------------
 po/sv.po        | 16 ----------------
 po/vi.po        | 12 ------------
 po/zh_CN.po     | 11 -----------
 12 files changed, 5 insertions(+), 151 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 54aba4e..e4481b4 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1488,17 +1488,11 @@ static int find_header(const char *line, unsign=
ed long size, int *hdrsize, struc
 			int git_hdr_len =3D parse_git_header(line, len, size, patch);
 			if (git_hdr_len <=3D len)
 				continue;
-			if (!patch->old_name && !patch->new_name) {
-				if (!patch->def_name)
-					die(Q_("git diff header lacks filename information when removing =
"
-					       "%d leading pathname component (line %d)",
-					       "git diff header lacks filename information when removing =
"
-					       "%d leading pathname components (line %d)",
-					       p_value),
-					    p_value, linenr);
-				patch->old_name =3D xstrdup(patch->def_name);
-				patch->new_name =3D xstrdup(patch->def_name);
-			}
+
+			/* pass this hunk if the filename length is zero */
+			if (!patch->old_name && !patch->new_name)=20
+				return -1;			=09
+		=09
 			if (!patch->is_delete && !patch->new_name)
 				die("git diff header lacks filename information "
 				    "(line %d)", linenr);
diff --git a/po/bg.po b/po/bg.po
index 171f813..f2cc286 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -2373,21 +2373,6 @@ msgstr "=D0=BF=D1=80=D0=B8 =D0=BF=D0=BE=D0=B2=D1=
=82=D0=BE=D1=80=D0=BD=D0=BE=D1=82=D0=BE =D0=BF=D1=80=D0=B5=D0=B1=D1=80=D0=
=BE=D1=8F=D0=B2=D0=B0=D0=BD=D0=B5 =D0=B1=D0=B5 =D0=BF=D0=BE=D0=BB=D1=83=
=D1=87=D0=B5=D0=BD=20
 msgid "patch fragment without header at line %d: %.*s"
 msgstr "=D1=87=D0=B0=D1=81=D1=82 =D0=BE=D1=82 =D0=BA=D1=80=D1=8A=D0=BF=
=D0=BA=D0=B0 =D0=B1=D0=B5=D0=B7 =D0=B7=D0=B0=D0=B3=D0=BB=D0=B0=D0=B2=D0=
=BD=D0=B0 =D1=87=D0=B0=D1=81=D1=82 =D0=BD=D0=B0 =D1=80=D0=B5=D0=B4 %d: =
%.*s"
=20
-#: builtin/apply.c:1493
-#, c-format
-msgid ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"component (line %d)"
-msgid_plural ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"components (line %d)"
-msgstr[0] ""
-"=D0=A1=D0=BB=D0=B5=D0=B4 =D1=81=D1=8A=D0=BA=D1=80=D0=B0=D1=89=D0=B0=D0=
=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 %d-=D1=82=D0=B0 =D1=87=D0=
=B0=D1=81=D1=82 =D0=BE=D1=82 =D0=BA=D0=BE=D0=BC=D0=BF=D0=BE=D0=BD=D0=B5=
=D0=BD=D1=82=D0=B8=D1=82=D0=B5 =D0=BD=D0=B0 =D0=BF=D1=8A=D1=82=D1=8F, =D0=
=B2 =D0=B7=D0=B0=D0=B3=D0=BB=D0=B0=D0=B2=D0=BD=D0=B0=D1=82=D0=B0 =D1=87=
=D0=B0=D1=81=D1=82 "
-"=D0=BD=D0=B0 =E2=80=9Egit diff=E2=80=9C =D0=BB=D0=B8=D0=BF=D1=81=D0=B2=
=D0=B0 =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8F =D0=
=B7=D0=B0 =D0=B8=D0=BC=D0=B5 =D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=D0=BB (=D1=
=80=D0=B5=D0=B4: %d)"
-msgstr[1] ""
-"=D0=A1=D0=BB=D0=B5=D0=B4 =D1=81=D1=8A=D0=BA=D1=80=D0=B0=D1=89=D0=B0=D0=
=B2=D0=B0=D0=BD=D0=B5=D1=82=D0=BE =D0=BD=D0=B0 =D0=BF=D1=8A=D1=80=D0=B2=
=D0=B8=D1=82=D0=B5 %d =D1=87=D0=B0=D1=81=D1=82=D0=B8 =D0=BE=D1=82 =D0=BA=
=D0=BE=D0=BC=D0=BF=D0=BE=D0=BD=D0=B5=D0=BD=D1=82=D0=B8=D1=82=D0=B5 =D0=BD=
=D0=B0 =D0=BF=D1=8A=D1=82=D1=8F, =D0=B2 =D0=B7=D0=B0=D0=B3=D0=BB=D0=B0=D0=
=B2=D0=BD=D0=B0=D1=82=D0=B0 "
-"=D1=87=D0=B0=D1=81=D1=82 =D0=BD=D0=B0 =E2=80=9Egit diff=E2=80=9C =D0=BB=
=D0=B8=D0=BF=D1=81=D0=B2=D0=B0 =D0=B8=D0=BD=D1=84=D0=BE=D1=80=D0=BC=D0=B0=
=D1=86=D0=B8=D1=8F =D0=B7=D0=B0 =D0=B8=D0=BC=D0=B5 =D0=BD=D0=B0 =D1=84=D0=
=B0=D0=B9=D0=BB (=D1=80=D0=B5=D0=B4: %d)"
-
 #: builtin/apply.c:1656
 msgid "new file depends on old contents"
 msgstr "=D0=BD=D0=BE=D0=B2=D0=B8=D1=8F=D1=82 =D1=84=D0=B0=D0=B9=D0=BB =
=D0=B7=D0=B0=D0=B2=D0=B8=D1=81=D0=B8 =D0=BE=D1=82 =D1=81=D1=82=D0=B0=D1=
=80=D0=BE=D1=82=D0=BE =D1=81=D1=8A=D0=B4=D1=8A=D1=80=D0=B6=D0=B0=D0=BD=D0=
=B8=D0=B5 =D0=BD=D0=B0 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0"
diff --git a/po/ca.po b/po/ca.po
index c733483..c893285 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -2216,21 +2216,6 @@ msgstr "recompte: l=C3=ADnia inesperada: %.*s"
 msgid "patch fragment without header at line %d: %.*s"
 msgstr "fragment de peda=C3=A7 sense cap=C3=A7alera a la l=C3=ADnia %d=
: %.*s"
=20
-#: builtin/apply.c:1493
-#, c-format
-msgid ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"component (line %d)"
-msgid_plural ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"components (line %d)"
-msgstr[0] ""
-"a la cap=C3=A7alera de git diff li manca informaci=C3=B3 de nom de fi=
txer en eliminar "
-"%d component de nom de cam=C3=AD inicial (l=C3=ADnia %d)"
-msgstr[1] ""
-"a la cap=C3=A7alera de git diff li manca informaci=C3=B3 de nom de fi=
txer en eliminar "
-"%d components de nom de cam=C3=AD inicial (l=C3=ADnia %d)"
-
 #: builtin/apply.c:1656
 msgid "new file depends on old contents"
 msgstr "el fitxer nou dep=C3=A8n dels continguts antics"
diff --git a/po/de.po b/po/de.po
index 7d603c2..ea6b555 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2257,21 +2257,6 @@ msgstr "recount: unerwartete Zeile: %.*s"
 msgid "patch fragment without header at line %d: %.*s"
 msgstr "Patch-Fragment ohne Kopfbereich bei Zeile %d: %.*s"
=20
-#: builtin/apply.c:1493
-#, c-format
-msgid ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"component (line %d)"
-msgid_plural ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"components (line %d)"
-msgstr[0] ""
-"Dem Kopfbereich von \"git diff\" fehlen Informationen zum Dateinamen,=
 wenn "
-"%d vorangestellter Teil des Pfades entfernt wird (Zeile %d)"
-msgstr[1] ""
-"Dem Kopfbereich von \"git diff\" fehlen Informationen zum Dateinamen,=
 wenn "
-"%d vorangestellte Teile des Pfades entfernt werden (Zeile %d)"
-
 #: builtin/apply.c:1656
 msgid "new file depends on old contents"
 msgstr "neue Datei h=C3=A4ngt von alten Inhalten ab"
diff --git a/po/fr.po b/po/fr.po
index 00bfefd..b376631 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -2301,21 +2301,6 @@ msgstr "recomptage : ligne inattendue : %.*s"
 msgid "patch fragment without header at line %d: %.*s"
 msgstr "fragment de patch sans en-t=C3=AAte =C3=A0 la ligne %d : %.*s"
=20
-#: builtin/apply.c:1493
-#, c-format
-msgid ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"component (line %d)"
-msgid_plural ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"components (line %d)"
-msgstr[0] ""
-"information de nom de fichier manquante dans l'en-t=C3=AAte de git di=
ff lors de "
-"la suppression de %d composant de pr=C3=A9fixe de chemin (ligne %d)"
-msgstr[1] ""
-"information de nom de fichier manquante dans l'en-t=C3=AAte de git di=
ff lors de "
-"la suppression de %d composants de pr=C3=A9fixe de chemin (ligne %d)"
-
 #: builtin/apply.c:1656
 msgid "new file depends on old contents"
 msgstr "le nouveau fichier d=C3=A9pend de contenus anciens"
diff --git a/po/git.pot b/po/git.pot
index c94a955..f1433e9 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -2093,17 +2093,6 @@ msgstr ""
 msgid "patch fragment without header at line %d: %.*s"
 msgstr ""
=20
-#: builtin/apply.c:1493
-#, c-format
-msgid ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"component (line %d)"
-msgid_plural ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"components (line %d)"
-msgstr[0] ""
-msgstr[1] ""
-
 #: builtin/apply.c:1656
 msgid "new file depends on old contents"
 msgstr ""
diff --git a/po/it.po b/po/it.po
index 9080219..6314bcb 100644
--- a/po/it.po
+++ b/po/it.po
@@ -1042,17 +1042,6 @@ msgstr "recount: riga inattesa: %.*s"
 msgid "patch fragment without header at line %d: %.*s"
 msgstr "frammento di patch senza intestazione alla riga %d: %.*s"
=20
-#: builtin/apply.c:1468
-#, c-format
-msgid ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"component (line %d)"
-msgid_plural ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"components (line %d)"
-msgstr[0] ""
-msgstr[1] ""
-
 #: builtin/apply.c:1628
 msgid "new file depends on old contents"
 msgstr "il nuovo file dipende da contenuti precedenti"
diff --git a/po/pt_PT.po b/po/pt_PT.po
index 689ad1b..7cfba0d 100644
--- a/po/pt_PT.po
+++ b/po/pt_PT.po
@@ -1025,13 +1025,6 @@ msgstr ""
 msgid "patch fragment without header at line %d: %.*s"
 msgstr ""
=20
-#: builtin/apply.c:1461
-#, c-format
-msgid "git diff header lacks filename information when removing %d lea=
ding pathname component (line %d)"
-msgid_plural "git diff header lacks filename information when removing=
 %d leading pathname components (line %d)"
-msgstr[0] ""
-msgstr[1] ""
-
 #: builtin/apply.c:1621
 msgid "new file depends on old contents"
 msgstr ""
diff --git a/po/ru.po b/po/ru.po
index 4356ae9..a796889 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -2114,18 +2114,6 @@ msgstr "recount: =D0=BD=D0=B5 =D0=BE=D0=B6=D0=B8=
=D0=B4=D0=B0=D0=B5=D0=BC=D0=B0=D1=8F =D1=81=D1=82=D1=80=D0=BE=D0=BA=D0=B0=
: %.*s"
 msgid "patch fragment without header at line %d: %.*s"
 msgstr "=D1=84=D1=80=D0=B0=D0=B3=D0=BC=D0=B5=D0=BD=D1=82 =D0=B8=D0=B7=D0=
=BC=D0=B5=D0=BD=D0=B5=D0=BD=D0=B8=D0=B9 =D0=B1=D0=B5=D0=B7 =D0=B7=D0=B0=
=D0=B3=D0=BE=D0=BB=D0=BE=D0=B2=D0=BA=D0=B0 =D0=BD=D0=B0 =D1=81=D1=82=D1=
=80=D0=BE=D0=BA=D0=B5 %d: %.*s"
=20
-#: builtin/apply.c:1493
-#, c-format
-msgid ""
-"git diff header lacks filename information when removing %d leading p=
athname"
-" component (line %d)"
-msgid_plural ""
-"git diff header lacks filename information when removing %d leading p=
athname"
-" components (line %d)"
-msgstr[0] "=D0=B7=D0=B0=D0=B3=D0=BE=D0=BB=D0=BE=D0=B2=D0=BE=D0=BA git =
diff =D0=BD=D0=B5 =D0=BD=D0=B0=D1=88=D0=B5=D0=BB =D0=B8=D0=BD=D1=84=D0=BE=
=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8E =D0=BE=D0=B1 =D0=B8=D0=BC=D0=B5=D0=
=BD=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=BF=D1=80=D0=B8 =D1=83=D0=B4=
=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B8 %d =D0=B2=D0=B5=D0=B4=D1=83=D1=89=D0=
=B5=D0=B3=D0=BE =D0=BA=D0=BE=D0=BC=D0=BF=D0=BE=D0=BD=D0=B5=D0=BD=D1=82=D0=
=B0 =D0=BF=D1=83=D1=82=D0=B8 =D0=BA =D1=84=D0=B0=D0=B9=D0=BB=D1=83 (=D1=
=81=D1=82=D1=80=D0=BE=D0=BA=D0=B0 %d)"
-msgstr[1] "=D0=B7=D0=B0=D0=B3=D0=BE=D0=BB=D0=BE=D0=B2=D0=BE=D0=BA git =
diff =D0=BD=D0=B5 =D0=BD=D0=B0=D1=88=D0=B5=D0=BB =D0=B8=D0=BD=D1=84=D0=BE=
=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8E =D0=BE=D0=B1 =D0=B8=D0=BC=D0=B5=D0=
=BD=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=BF=D1=80=D0=B8 =D1=83=D0=B4=
=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B8 %d =D0=B2=D0=B5=D0=B4=D1=83=D1=89=D0=
=B8=D1=85 =D0=BA=D0=BE=D0=BC=D0=BF=D0=BE=D0=BD=D0=B5=D0=BD=D1=82 =D0=BF=
=D1=83=D1=82=D0=B8 =D0=BA =D1=84=D0=B0=D0=B9=D0=BB=D1=83 (=D1=81=D1=82=D1=
=80=D0=BE=D0=BA=D0=B0 %d)"
-msgstr[2] "=D0=B7=D0=B0=D0=B3=D0=BE=D0=BB=D0=BE=D0=B2=D0=BE=D0=BA git =
diff =D0=BD=D0=B5 =D0=BD=D0=B0=D1=88=D0=B5=D0=BB =D0=B8=D0=BD=D1=84=D0=BE=
=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8E =D0=BE=D0=B1 =D0=B8=D0=BC=D0=B5=D0=
=BD=D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=BF=D1=80=D0=B8 =D1=83=D0=B4=
=D0=B0=D0=BB=D0=B5=D0=BD=D0=B8=D0=B8 %d =D0=B2=D0=B5=D0=B4=D1=83=D1=89=D0=
=B8=D1=85 =D0=BA=D0=BE=D0=BC=D0=BF=D0=BE=D0=BD=D0=B5=D0=BD=D1=82 =D0=BF=
=D1=83=D1=82=D0=B8 =D0=BA =D1=84=D0=B0=D0=B9=D0=BB=D1=83 (=D1=81=D1=82=D1=
=80=D0=BE=D0=BA=D0=B0 %d)"
-
 #: builtin/apply.c:1656
 msgid "new file depends on old contents"
 msgstr "=D0=BD=D0=BE=D0=B2=D1=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB =D0=B7=
=D0=B0=D0=B2=D0=B8=D1=81=D0=B8=D1=82 =D0=BE=D1=82 =D1=81=D1=82=D0=B0=D1=
=80=D0=BE=D0=B3=D0=BE =D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D0=BC=D0=
=BE=D0=B3=D0=BE"
diff --git a/po/sv.po b/po/sv.po
index e4b70d6..5b2d24d 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -2184,22 +2184,6 @@ msgstr "recount: f=C3=B6rv=C3=A4ntade rad: %.*s"
 msgid "patch fragment without header at line %d: %.*s"
 msgstr "patch-fragment utan huvud p=C3=A5 rad %d: %.*s"
=20
-#: builtin/apply.c:1493
-#, c-format
-msgid ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"component (line %d)"
-msgid_plural ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"components (line %d)"
-msgstr[0] ""
-"git-diff-huvudet saknar filnamnsinformation n=C3=A4r %d ledande s=C3=B6=
kv=C3=A4gskomponent\n"
-"tas bort (rad %d)"
-msgstr[1] ""
-"git-diff-huvudet saknar filnamnsinformation n=C3=A4r %d ledande "
-"s=C3=B6kv=C3=A4gskomponenter\n"
-"tas bort (rad %d)"
-
 #: builtin/apply.c:1656
 msgid "new file depends on old contents"
 msgstr "ny fil beror p=C3=A5 gammalt inneh=C3=A5ll"
diff --git a/po/vi.po b/po/vi.po
index 956be5a..ba1ecf5 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -2212,18 +2212,6 @@ msgstr "chi ti=E1=BA=BFt: d=C3=B2ng kh=C3=B4ng c=
=E1=BA=A7n: %.*s"
 msgid "patch fragment without header at line %d: %.*s"
 msgstr "mi=E1=BA=BFng v=C3=A1 ph=C3=A2n m=E1=BA=A3nh m=C3=A0 kh=C3=B4n=
g c=C3=B3 ph=E1=BA=A7n =C4=91=E1=BA=A7u t=E1=BA=A1i d=C3=B2ng %d: %.*s"
=20
-#: builtin/apply.c:1493
-#, c-format
-msgid ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"component (line %d)"
-msgid_plural ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"components (line %d)"
-msgstr[0] ""
-"ph=E1=BA=A7n =C4=91=E1=BA=A7u diff cho git  thi=E1=BA=BFu th=C3=B4ng =
tin t=C3=AAn t=E1=BA=ADp tin khi g=E1=BB=A1 b=E1=BB=8F =C4=91i %d trong=
 "
-"th=C3=A0nh ph=E1=BA=A7n d=E1=BA=ABn =C4=91=E1=BA=A7u t=C3=AAn c=E1=BB=
=A7a =C4=91=C6=B0=E1=BB=9Dng d=E1=BA=ABn (d=C3=B2ng %d)"
-
 #: builtin/apply.c:1656
 msgid "new file depends on old contents"
 msgstr "t=E1=BA=ADp tin m=E1=BB=9Bi ph=E1=BB=A5 thu=E1=BB=99c v=C3=A0o=
 n=E1=BB=99i dung c=C5=A9"
diff --git a/po/zh_CN.po b/po/zh_CN.po
index dd2948c..b65b97a 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -2197,17 +2197,6 @@ msgstr "recount=EF=BC=9A=E6=84=8F=E5=A4=96=E7=9A=
=84=E8=A1=8C=EF=BC=9A%.*s"
 msgid "patch fragment without header at line %d: %.*s"
 msgstr "=E7=AC=AC %d =E8=A1=8C=E7=9A=84=E8=A1=A5=E4=B8=81=E7=89=87=E6=AE=
=B5=E6=B2=A1=E6=9C=89=E5=A4=B4=E4=BF=A1=E6=81=AF=EF=BC=9A%.*s"
=20
-#: builtin/apply.c:1493
-#, c-format
-msgid ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"component (line %d)"
-msgid_plural ""
-"git diff header lacks filename information when removing %d leading p=
athname "
-"components (line %d)"
-msgstr[0] "=E5=BD=93=E7=A7=BB=E9=99=A4 %d =E4=B8=AA=E5=89=8D=E5=AF=BC=E8=
=B7=AF=E5=BE=84=E5=90=8E git diff =E5=A4=B4=E7=BC=BA=E4=B9=8F=E6=96=87=E4=
=BB=B6=E5=90=8D=E4=BF=A1=E6=81=AF=EF=BC=88=E7=AC=AC %d =E8=A1=8C=EF=BC=89=
"
-msgstr[1] "=E5=BD=93=E7=A7=BB=E9=99=A4 %d =E4=B8=AA=E5=89=8D=E5=AF=BC=E8=
=B7=AF=E5=BE=84=E5=90=8E git diff =E5=A4=B4=E7=BC=BA=E4=B9=8F=E6=96=87=E4=
=BB=B6=E5=90=8D=E4=BF=A1=E6=81=AF=EF=BC=88=E7=AC=AC %d =E8=A1=8C=EF=BC=89=
"
-
 #: builtin/apply.c:1656
 msgid "new file depends on old contents"
 msgstr "=E6=96=B0=E6=96=87=E4=BB=B6=E4=BE=9D=E8=B5=96=E6=97=A7=E5=86=85=
=E5=AE=B9"
--=20
1.9.1
