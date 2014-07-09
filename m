From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 09/32] *.sh: respect $GIT_INDEX_FILE
Date: Wed,  9 Jul 2014 14:32:54 +0700
Message-ID: <1404891197-18067-10-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:34:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mOU-0003Lg-JJ
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730AbaGIHeR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:34:17 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63003 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbaGIHeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:34:16 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so8653236pac.5
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IQuoO4nmbynirGXowX7+Y0QUw3gxsWj1+k2KwMRqP/M=;
        b=e0FZzIW1Tk8Orxnq1fhZpp9SLkSw6NVjwQHOxbFwmzkjP+14WcHcUOIR7NUcQMTIWH
         Rk86jVB8qnpADRtFRudzUQism+bK+zjVic+Pogx4G78ywuwPysXYaaHpTK0DSSZ1lXkI
         IZWQ2lTYl29D96j9ojy06suNV6GeOewaO1jZcD/SSSriKOQSrb9RfBIZY2ZiZ19uvO02
         y788HIYNK7UlBrMJ/Uq33g9h6ec5Lkv7W5tEndoxtAWrX7k5jisYsqdZHRntRufq+MS3
         9ep1wMaKcoOwuN/AYj8XrGDNxsUCVEkO9a0ZHfaOTxHS8e7wclDmHhYJdv+rCJMCKZA5
         3ITg==
X-Received: by 10.68.176.5 with SMTP id ce5mr30006483pbc.93.1404891255598;
        Wed, 09 Jul 2014 00:34:15 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id d9sm1166124pdj.14.2014.07.09.00.34.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:34:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:34:12 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253083>

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
