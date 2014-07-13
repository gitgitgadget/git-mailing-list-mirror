From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 07/31] *.sh: respect $GIT_INDEX_FILE
Date: Sun, 13 Jul 2014 11:50:44 +0700
Message-ID: <1405227068-25506-8-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Jul 13 06:53:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6BnJ-00081A-6i
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbaGMExp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:53:45 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:49498 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbaGMExn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:53:43 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so647917pdb.27
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IQuoO4nmbynirGXowX7+Y0QUw3gxsWj1+k2KwMRqP/M=;
        b=b/qFCloumq14/jSkAoeHsB7oo6PTORnCu87Rka052kg22EQRD7mIiAUlIy3JqNvm6Y
         ln/qz5wSXE7O0Z7hUMQCsI57d6q4GZGrghPoMfuSwcDqrEOkrFnplGN2DGpUl423rHN+
         k6Mg0Fy/Y+1unwx/YcIiVIS7r7M4Wg619dzA/P+XWHPL9FAH75Y9dNxAKKtXjNY+jyTb
         bNAXNfxOeXmbbXBmQ5Loul3Q+hgM+2PGBlAImgaKu6m6l1+yTqsL7y6iK4XMzBXgFqOe
         aRtf11Yr4xkbqlN/XS2COH0z5dWjldlRLmeDfJUFJxlIPe8gl3t8hu4u1lxX7Soc7+NL
         hRiQ==
X-Received: by 10.70.92.49 with SMTP id cj17mr8917002pdb.53.1405227223407;
        Sat, 12 Jul 2014 21:53:43 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id g11sm9098037pdl.12.2014.07.12.21.53.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:53:42 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:53:43 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253410>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-pull.sh  | 2 +-
 git-stash.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 18a394f..6ab0c31 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -240,7 +240,7 @@ test true =3D "$rebase" && {
 	if ! git rev-parse -q --verify HEAD >/dev/null
 	then
 		# On an unborn branch
-		if test -f "$GIT_DIR/index"
+		if test -f "$(git rev-parse --git-path index)"
 		then
 			die "$(gettext "updating an unborn branch with changes added to the=
 index")"
 		fi
diff --git a/git-stash.sh b/git-stash.sh
index bcc757b..393e1ec 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -20,7 +20,7 @@ require_work_tree
 cd_to_toplevel
=20
 TMP=3D"$GIT_DIR/.git-stash.$$"
-TMPindex=3D${GIT_INDEX_FILE-"$GIT_DIR/index"}.stash.$$
+TMPindex=3D${GIT_INDEX_FILE-"$(git rev-parse --git-path index)"}.stash=
=2E$$
 trap 'rm -f "$TMP-"* "$TMPindex"' 0
=20
 ref_stash=3Drefs/stash
--=20
1.9.1.346.ga2b5940
