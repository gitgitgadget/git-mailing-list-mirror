From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 06/27] *.sh: respect $GIT_INDEX_FILE
Date: Sat,  1 Mar 2014 19:12:42 +0700
Message-ID: <1393675983-3232-7-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:21:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJiv5-0001qW-VF
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbaCAMV1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:21:27 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:35739 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbaCAMV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:21:27 -0500
Received: by mail-pb0-f47.google.com with SMTP id up15so1894822pbc.20
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=s89z7qfeRpRbOkF1Ydj2ZiYo0qkf2aNXcCIPfj0gXQA=;
        b=xa+1bPOVsx6X9pjmUuFc5eYuTTD9tp2I3gWdINS1wt8rmmPPzK5j4c3t1wdf/XZNWJ
         i3kwBRQWmOBCOYU5eZutNBYOczqdPUmQW2JspUkvay88ywd4RSC4puMacPSD/ottScnV
         cORkF+ZYZXnYZWO1Rd1SfM6oz8Jn2e2GN2BOkii/srkW4wGP9fTYHfqGnvH2t0DRcjN3
         rElRXe+Kc233WH8FRGTJdb9adC/cDFbyIaXjAwdIpkvV3qKRAeHBIioipIfPwbWGJbei
         F4snpcS+EbQnRoyPsfVyEkrfUfB7jmXOewjBtLIFNYIZiBBXOOfPS/j+HEJrpzV6cZLB
         +wgw==
X-Received: by 10.66.139.38 with SMTP id qv6mr4062800pab.123.1393676486675;
        Sat, 01 Mar 2014 04:21:26 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id vx10sm37113626pac.17.2014.03.01.04.21.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:21:25 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:21:51 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243071>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-pull.sh  | 2 +-
 git-stash.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 0a5aa2c..c9dc9ba 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -218,7 +218,7 @@ test true =3D "$rebase" && {
 	if ! git rev-parse -q --verify HEAD >/dev/null
 	then
 		# On an unborn branch
-		if test -f "$GIT_DIR/index"
+		if test -f "`git rev-parse --git-path index`"
 		then
 			die "$(gettext "updating an unborn branch with changes added to the=
 index")"
 		fi
diff --git a/git-stash.sh b/git-stash.sh
index f0a94ab..ae7d16e 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -20,7 +20,7 @@ require_work_tree
 cd_to_toplevel
=20
 TMP=3D"$GIT_DIR/.git-stash.$$"
-TMPindex=3D${GIT_INDEX_FILE-"$GIT_DIR/index"}.stash.$$
+TMPindex=3D${GIT_INDEX_FILE-"`git rev-parse --git-path index`"}.stash.=
$$
 trap 'rm -f "$TMP-"* "$TMPindex"' 0
=20
 ref_stash=3Drefs/stash
--=20
1.9.0.40.gaa8c3ea
