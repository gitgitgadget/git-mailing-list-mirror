From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 07/32] *.sh: respect $GIT_INDEX_FILE
Date: Sun, 28 Sep 2014 08:22:21 +0700
Message-ID: <1411867366-3821-8-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:23:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3D4-0002Ed-Sr
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbaI1BXb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:23:31 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:51754 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BXa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:23:30 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so13111329pde.8
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=svL6JybK6MhOl56Y2SoOz4qj3/FWEUEItJzjY6lnTTY=;
        b=bg/KytFEiJCAOFrgwAxhRM1whNBp6qOh/sG/YTLSOVXAQEfVDYv13klvb8ZHt3cMfO
         YvSQkr7umLJupdlMNfpD/Y74pWFqsKdcN21BcimmHtDgzbSu/XTQnenOHhg0NpYA4tek
         WyHJMGDI6rhnAjRT1g3rVAOapo5KBNW21ePzyuCZKzv8jYIu+4uo78Vro8upxZaRLaSw
         WMiy5qSGns669QU8Dgo8zPimqII3GZy8+tk2GdpfyZdymauabGzRPdjSeDaa2x0oL6yW
         Tfv0MZjzX5z8Brvn1RIXEmpVGGXfLhU+d5+IrC5Yr6YUqaWEf4vhLIqjxVHvIaySSnft
         +Igg==
X-Received: by 10.68.65.74 with SMTP id v10mr27503367pbs.72.1411867408580;
        Sat, 27 Sep 2014 18:23:28 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id j3sm8559527pdr.31.2014.09.27.18.23.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:23:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:23:31 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257566>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-pull.sh  | 2 +-
 git-stash.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 4d4fc77..ad44226 100755
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
index 0158c73..4294aa0 100755
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
2.1.0.rc0.78.gc0d8480
