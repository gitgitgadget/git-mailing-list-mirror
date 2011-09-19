From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gitk: 'j' and 'k' keyboard shortcuts backward
Date: Mon, 19 Sep 2011 11:49:50 -0500
Message-ID: <20110919164950.GB2861@elie>
References: <CA+Jd1rFzOOxL+-JVeovTiOwM5cmyyis65Y1+xiDmG=tkJ3b2Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Josh Triplett <josh@joshtriplett.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Robert Suetterlin <robert@mpe.mpg.de>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Sep 19 18:50:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5h2m-0008Kp-5k
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 18:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756804Ab1ISQuA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Sep 2011 12:50:00 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53567 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013Ab1ISQt4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2011 12:49:56 -0400
Received: by yxl31 with SMTP id 31so282486yxl.19
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=smj//177DGMWHECIUyB7SHH+3O9HrCHHlcnyNrFZW04=;
        b=BtJdW6axyLizj/F52yiRyTzsM+vQ8g1eCtwjPvS1sGGmTJxZfYsSm3gpOl6EDbptYq
         7UmZPOB1eZ/bt7dQFz4/qvgWBrQXO/oxyHAAfS2Zhx5ZnIaurar18nKMEx26Icug0w5s
         p/QRl230pQbnkngPpMIoilYwSVrVQUWizi6C8=
Received: by 10.236.180.105 with SMTP id i69mr15335599yhm.64.1316450995670;
        Mon, 19 Sep 2011 09:49:55 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id e61sm17977164yhm.2.2011.09.19.09.49.53
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Sep 2011 09:49:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+Jd1rFzOOxL+-JVeovTiOwM5cmyyis65Y1+xiDmG=tkJ3b2Xw@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181683>

(+cc: Josh and upstream)
Hi,

Clemens Buchacher wrote:

> The key bindings are not related to vi. See Help -> Key
> bindings in gitk:
>
> k    Move down one commit
> j    Go back in history list
>
> I know this has confused me too. But I don't think it's worth changin=
g,
> unless you can think of a solution that would confuse neither vi nor =
non-vi
> users.

Eh, I think it's worth changing and that the non-vi users are probably
just using arrow keys. :)  The commit that introduced those key
bindings says:

| commit 6e2dda35
| Author: Robert Suetterlin <robert@mpe.mpg.de>
| Date:   Thu Sep 22 10:07:36 2005 +1000
|
|     [PATCH] Add new keybindings
|
|     This adds several new keybindings to allow history and selectline
|     navigation.  I basically added Opera-like history traversal, as w=
ell
|     as left-right-cursor history traversal and vi-like motion command=
s.
|
|     Signed-off-by: Robert Suetterlin <robert@mpe.mpg.de>
|     Signed-off-by: Paul Mackerras <paulus@samba.org>

How about this patch?

-- >8 --
Subject: gitk: Make vi-style keybindings more vi-like

When commit 6e2dda35 (Add new keybindings, 2005-09-22) added vi-style
keybindings to gitk (an excellent idea!), instead of adopting the
usual "hjkl =3D left, down, up, right" bindings used by less, vi, rogue=
,
and many other programs, it used "ijkl =3D up, left, down, right" to
mimic the inverted-T formation of the arrow keys on a qwerty keyboard,
in the style of Lode runner.  So using 'j' and 'k' to scroll through
commits produces utterly confusing results to the vi user, as 'k'
moves down and 'j' moves to the previous commit.

Luckily most non-vi-users are probably using an alternate set of keys
(cursor keys or z/x + n/p) anyway.  Switch to the expected vi/nethack
convention.

Requested-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 gitk     |   12 ++++++------
 po/de.po |   12 ++++++------
 po/es.po |   12 ++++++------
 po/fr.po |   12 ++++++------
 po/hu.po |   12 ++++++------
 po/it.po |   12 ++++++------
 po/ja.po |   12 ++++++------
 po/ru.po |   12 ++++++------
 po/sv.po |   12 ++++++------
 9 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/gitk b/gitk
index 1b0e09a5..ac3fb7d4 100755
--- a/gitk
+++ b/gitk
@@ -2411,9 +2411,9 @@ proc makewindow {} {
     bindkey n "selnextline 1"
     bindkey z "goback"
     bindkey x "goforw"
-    bindkey i "selnextline -1"
-    bindkey k "selnextline 1"
-    bindkey j "goback"
+    bindkey k "selnextline -1"
+    bindkey j "selnextline 1"
+    bindkey h "goback"
     bindkey l "goforw"
     bindkey b prevfile
     bindkey d "$ctext yview scroll 18 units"
@@ -2822,9 +2822,9 @@ proc keys {} {
 [mc "<%s-W>		Close window" $M1T]
 [mc "<Home>		Move to first commit"]
 [mc "<End>		Move to last commit"]
-[mc "<Up>, p, i	Move up one commit"]
-[mc "<Down>, n, k	Move down one commit"]
-[mc "<Left>, z, j	Go back in history list"]
+[mc "<Up>, p, k	Move up one commit"]
+[mc "<Down>, n, j	Move down one commit"]
+[mc "<Left>, z, h	Go back in history list"]
 [mc "<Right>, x, l	Go forward in history list"]
 [mc "<PageUp>	Move up one page in commit list"]
 [mc "<PageDown>	Move down one page in commit list"]
diff --git a/po/de.po b/po/de.po
index bd194a3d..e4cf661a 100644
--- a/po/de.po
+++ b/po/de.po
@@ -371,16 +371,16 @@ msgid "<End>\t\tMove to last commit"
 msgstr "<Ende>\t\tZur =C3=A4ltesten Version springen"
=20
 #: gitk:2819
-msgid "<Up>, p, i\tMove up one commit"
-msgstr "<Hoch>, p, i\tN=C3=A4chste neuere Version"
+msgid "<Up>, p, k\tMove up one commit"
+msgstr "<Hoch>, p, k\tN=C3=A4chste neuere Version"
=20
 #: gitk:2820
-msgid "<Down>, n, k\tMove down one commit"
-msgstr "<Runter>, n, k\tN=C3=A4chste =C3=A4ltere Version"
+msgid "<Down>, n, j\tMove down one commit"
+msgstr "<Runter>, n, j\tN=C3=A4chste =C3=A4ltere Version"
=20
 #: gitk:2821
-msgid "<Left>, z, j\tGo back in history list"
-msgstr "<Links>, z, j\tEine Version zur=C3=BCckgehen"
+msgid "<Left>, z, h\tGo back in history list"
+msgstr "<Links>, z, h\tEine Version zur=C3=BCckgehen"
=20
 #: gitk:2822
 msgid "<Right>, x, l\tGo forward in history list"
diff --git a/po/es.po b/po/es.po
index 0471dd06..9c8bcd29 100644
--- a/po/es.po
+++ b/po/es.po
@@ -319,16 +319,16 @@ msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\tIr a la =C3=BAltima revisi=C3=B3n"
=20
 #: gitk:2522
-msgid "<Up>, p, i\tMove up one commit"
-msgstr "<Up>, p, i\tSubir una revisi=C3=B3n"
+msgid "<Up>, p, k\tMove up one commit"
+msgstr "<Up>, p, k\tSubir una revisi=C3=B3n"
=20
 #: gitk:2523
-msgid "<Down>, n, k\tMove down one commit"
-msgstr "<Down>, n, k\tBajar una revisi=C3=B3n"
+msgid "<Down>, n, j\tMove down one commit"
+msgstr "<Down>, n, j\tBajar una revisi=C3=B3n"
=20
 #: gitk:2524
-msgid "<Left>, z, j\tGo back in history list"
-msgstr "<Left>, z, j\tRetroceder en la historia"
+msgid "<Left>, z, h\tGo back in history list"
+msgstr "<Left>, z, h\tRetroceder en la historia"
=20
 #: gitk:2525
 msgid "<Right>, x, l\tGo forward in history list"
diff --git a/po/fr.po b/po/fr.po
index 5370ddc3..ff476191 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -372,16 +372,16 @@ msgid "<End>\t\tMove to last commit"
 msgstr "<Fin>\t\tAller au dernier commit"
=20
 #: gitk:2691
-msgid "<Up>, p, i\tMove up one commit"
-msgstr "<Haut>, p, i\t Aller au commit suivant"
+msgid "<Up>, p, k\tMove up one commit"
+msgstr "<Haut>, p, k\t Aller au commit suivant"
=20
 #: gitk:2692
-msgid "<Down>, n, k\tMove down one commit"
-msgstr "<Bas>, n, k\t Aller au commit pr=C3=A9c=C3=A9dent"
+msgid "<Down>, n, j\tMove down one commit"
+msgstr "<Bas>, n, j\t Aller au commit pr=C3=A9c=C3=A9dent"
=20
 #: gitk:2693
-msgid "<Left>, z, j\tGo back in history list"
-msgstr "<Gauche>, z, j\tReculer dans l'historique"
+msgid "<Left>, z, h\tGo back in history list"
+msgstr "<Gauche>, z, h\tReculer dans l'historique"
=20
 #: gitk:2694
 msgid "<Right>, x, l\tGo forward in history list"
diff --git a/po/hu.po b/po/hu.po
index 7262b610..af0ddda2 100644
--- a/po/hu.po
+++ b/po/hu.po
@@ -370,16 +370,16 @@ msgid "<End>\t\tMove to last commit"
 msgstr "<Ende>\t\tUtols=C3=B3 commithoz"
=20
 #: gitk:2816
-msgid "<Up>, p, i\tMove up one commit"
-msgstr "<Hoch>, p, i\tEgy committal feljebb"
+msgid "<Up>, p, k\tMove up one commit"
+msgstr "<Hoch>, p, k\tEgy committal feljebb"
=20
 #: gitk:2817
-msgid "<Down>, n, k\tMove down one commit"
-msgstr "<Runter>, n, k\tEgy committal lejjebb"
+msgid "<Down>, n, j\tMove down one commit"
+msgstr "<Runter>, n, j\tEgy committal lejjebb"
=20
 #: gitk:2818
-msgid "<Left>, z, j\tGo back in history list"
-msgstr "<Links>, z, j\tVissza a history list=C3=A1ba"
+msgid "<Left>, z, h\tGo back in history list"
+msgstr "<Links>, z, h\tVissza a history list=C3=A1ba"
=20
 #: gitk:2819
 msgid "<Right>, x, l\tGo forward in history list"
diff --git a/po/it.po b/po/it.po
index a730d63a..5f562109 100644
--- a/po/it.po
+++ b/po/it.po
@@ -372,16 +372,16 @@ msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\tVai all'ultima revisione"
=20
 #: gitk:2819
-msgid "<Up>, p, i\tMove up one commit"
-msgstr "<Su>, p, i\tVai pi=C3=B9 in alto di una revisione"
+msgid "<Up>, p, k\tMove up one commit"
+msgstr "<Su>, p, k\tVai pi=C3=B9 in alto di una revisione"
=20
 #: gitk:2820
-msgid "<Down>, n, k\tMove down one commit"
-msgstr "<Gi=C3=B9>, n, k\tVai pi=C3=B9 in basso di una revisione"
+msgid "<Down>, n, j\tMove down one commit"
+msgstr "<Gi=C3=B9>, n, j\tVai pi=C3=B9 in basso di una revisione"
=20
 #: gitk:2821
-msgid "<Left>, z, j\tGo back in history list"
-msgstr "<Sinistra>, z, j\tTorna indietro nella cronologia"
+msgid "<Left>, z, h\tGo back in history list"
+msgstr "<Sinistra>, z, h\tTorna indietro nella cronologia"
=20
 #: gitk:2822
 msgid "<Right>, x, l\tGo forward in history list"
diff --git a/po/ja.po b/po/ja.po
index 4f470516..249ec150 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -372,16 +372,16 @@ msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\t=E6=9C=80=E5=BE=8C=E3=81=AE=E3=82=B3=E3=83=9F=E3=83=83=
=E3=83=88=E3=81=AB=E7=A7=BB=E5=8B=95"
=20
 #: gitk:2693
-msgid "<Up>, p, i\tMove up one commit"
-msgstr "<Up>, p, i\t=E4=B8=80=E3=81=A4=E4=B8=8A=E3=81=AE=E3=82=B3=E3=83=
=9F=E3=83=83=E3=83=88=E3=81=AB=E7=A7=BB=E5=8B=95"
+msgid "<Up>, p, k\tMove up one commit"
+msgstr "<Up>, p, k\t=E4=B8=80=E3=81=A4=E4=B8=8A=E3=81=AE=E3=82=B3=E3=83=
=9F=E3=83=83=E3=83=88=E3=81=AB=E7=A7=BB=E5=8B=95"
=20
 #: gitk:2694
-msgid "<Down>, n, k\tMove down one commit"
-msgstr "<Down>, n, k\t=E4=B8=80=E3=81=A4=E4=B8=8B=E3=81=AE=E3=82=B3=E3=
=83=9F=E3=83=83=E3=83=88=E3=81=AB=E7=A7=BB=E5=8B=95"
+msgid "<Down>, n, j\tMove down one commit"
+msgstr "<Down>, n, j\t=E4=B8=80=E3=81=A4=E4=B8=8B=E3=81=AE=E3=82=B3=E3=
=83=9F=E3=83=83=E3=83=88=E3=81=AB=E7=A7=BB=E5=8B=95"
=20
 #: gitk:2695
-msgid "<Left>, z, j\tGo back in history list"
-msgstr "<Left>, z, j\t=E5=B1=A5=E6=AD=B4=E3=81=AE=E5=89=8D=E3=81=AB=E6=
=88=BB=E3=82=8B"
+msgid "<Left>, z, h\tGo back in history list"
+msgstr "<Left>, z, h\t=E5=B1=A5=E6=AD=B4=E3=81=AE=E5=89=8D=E3=81=AB=E6=
=88=BB=E3=82=8B"
=20
 #: gitk:2696
 msgid "<Right>, x, l\tGo forward in history list"
diff --git a/po/ru.po b/po/ru.po
index c3d0285b..e7e6e9ef 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -350,16 +350,16 @@ msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =D0=
=BF=D0=BE=D1=81=D0=BB=D0=B5=D0=B4=D0=BD=D0=B5=D0=BC=D1=83 =D1=81=D0=BE=D1=
=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
=20
 #: gitk:2646
-msgid "<Up>, p, i\tMove up one commit"
-msgstr "<Up>, p, i\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =
=D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D1=81=D0=BE=
=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+msgid "<Up>, p, k\tMove up one commit"
+msgstr "<Up>, p, k\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA =
=D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B5=D0=BC=D1=83 =D1=81=D0=BE=
=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
=20
 #: gitk:2647
-msgid "<Down>, n, k\tMove down one commit"
-msgstr "<Down>, n, k\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA=
 =D0=BF=D1=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=BC=D1=83 =D1=
=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
+msgid "<Down>, n, j\tMove down one commit"
+msgstr "<Down>, n, j\t=D0=9F=D0=B5=D1=80=D0=B5=D0=B9=D1=82=D0=B8 =D0=BA=
 =D0=BF=D1=80=D0=B5=D0=B4=D1=8B=D0=B4=D1=83=D1=89=D0=B5=D0=BC=D1=83 =D1=
=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D1=8E"
=20
 #: gitk:2648
-msgid "<Left>, z, j\tGo back in history list"
-msgstr "<Left>, z, j\t=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C=
 =D1=80=D0=B0=D0=BD=D0=B5=D0=B5 =D0=BF=D0=BE=D1=81=D0=B5=D1=89=D1=91=D0=
=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=
=B5"
+msgid "<Left>, z, h\tGo back in history list"
+msgstr "<Left>, z, h\t=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C=
 =D1=80=D0=B0=D0=BD=D0=B5=D0=B5 =D0=BF=D0=BE=D1=81=D0=B5=D1=89=D1=91=D0=
=BD=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D1=81=D1=82=D0=BE=D1=8F=D0=BD=D0=B8=D0=
=B5"
=20
 #: gitk:2649
 msgid "<Right>, x, l\tGo forward in history list"
diff --git a/po/sv.po b/po/sv.po
index 386763ad..8bd72f3d 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -371,16 +371,16 @@ msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\tG=C3=A5 till sista incheckning"
=20
 #: gitk:2819
-msgid "<Up>, p, i\tMove up one commit"
-msgstr "<Upp>, p, i\tG=C3=A5 en incheckning upp"
+msgid "<Up>, p, k\tMove up one commit"
+msgstr "<Upp>, p, k\tG=C3=A5 en incheckning upp"
=20
 #: gitk:2820
-msgid "<Down>, n, k\tMove down one commit"
-msgstr "<Ned>, n, k\tG=C3=A5 en incheckning ned"
+msgid "<Down>, n, j\tMove down one commit"
+msgstr "<Ned>, n, j\tG=C3=A5 en incheckning ned"
=20
 #: gitk:2821
-msgid "<Left>, z, j\tGo back in history list"
-msgstr "<V=C3=A4nster>, z, j\tG=C3=A5 bak=C3=A5t i historiken"
+msgid "<Left>, z, h\tGo back in history list"
+msgstr "<V=C3=A4nster>, z, h\tG=C3=A5 bak=C3=A5t i historiken"
=20
 #: gitk:2822
 msgid "<Right>, x, l\tGo forward in history list"
--=20
1.7.7.rc1
