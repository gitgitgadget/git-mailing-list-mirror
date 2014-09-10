From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 07/32] *.sh: respect $GIT_INDEX_FILE
Date: Thu, 11 Sep 2014 05:41:43 +0700
Message-ID: <1410388928-32265-8-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:42:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqb7-0001Ng-Rw
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbaIJWmm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:42:42 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:48185 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944AbaIJWml (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:42:41 -0400
Received: by mail-pa0-f43.google.com with SMTP id fa1so7998686pad.30
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kgpzDHrl2TWHFRo1IiyZvRFU9+2QsBYAUPAovpIc3Ms=;
        b=xtlp/dJou8jljtinSrOIJTgPLk3T735vY8MW43P3hGj8rVlMjQ8YqE3ubMIY3ptES7
         ZX01t/ddFgmzn7bmsbgIJ1wSpz7AFT+aQf7rvWqrczT9PNiioMgh5BQOX6SGJg6AIGhF
         P8csoaO7/jqiwmhV2/Fsw9Eni7Cq9rRsAASYWu0qrKDiMpuMiYsXdg+jvVWoaePw4453
         5lJILdBH/EVKxZ2oiFXM7XvY9YOLaALdSmBPUqumyXepX4t7ioSrrkSnZJPnWcoIpMwL
         6imTGbPMnQgSqetfRyAFFYta7UV2Net7fYkokNBI7L0KBK5R4yA0gvNnV4cQpQAiHVst
         uACg==
X-Received: by 10.70.138.102 with SMTP id qp6mr25147963pdb.127.1410388960877;
        Wed, 10 Sep 2014 15:42:40 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id bn4sm15436036pbc.40.2014.09.10.15.42.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:42:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:43:00 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256783>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.1.0.rc0.78.gc0d8480
