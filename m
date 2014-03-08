From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 07/28] *.sh: respect $GIT_INDEX_FILE
Date: Sat,  8 Mar 2014 09:47:59 +0700
Message-ID: <1394246900-31535-8-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:48:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7Jg-0004zH-II
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbaCHCsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:48:38 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:45456 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbaCHCsg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:48:36 -0500
Received: by mail-pd0-f173.google.com with SMTP id z10so4803099pdj.32
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NDpidRXXGMk/cd5C7EdnVQWhBYE6ZIsiJoMcfsnt0xk=;
        b=e8DBOOVF1kw8Lk3D+36/ebwPOLVrGip9xjNp6pzQDSLIkrEFazajG4nImaCSrgqe/u
         ho5NLpefb0C9nNVlydy4IOhiHBau221EkFG0xjub/GZKxlgeOcxScHb69a8G+TA8Zgm1
         +R/D/tPCxN7iNBniIHt4i7IAF8Ikt2DLLlz6rkr5vTA6qSB11hmddYv336Dfl1uyx4ij
         VtSn5jBbub0FizX3QnTSKdxfC8AzCiDK0JRgM9SnAvvMKGzCnv/5zCaVhxadMWBRuZwm
         CqAhPiXkyYvnPgZCCiTe2IGoTV3ZzwmcyxWKa2thnt7mPW9VcOuC6JBOfRgB2acF21ds
         /QHw==
X-Received: by 10.68.198.36 with SMTP id iz4mr25895028pbc.109.1394246916256;
        Fri, 07 Mar 2014 18:48:36 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id pp5sm42346122pbb.33.2014.03.07.18.48.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:48:35 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:49:09 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243645>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-pull.sh  | 2 +-
 git-stash.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 0a5aa2c..2a90262 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -218,7 +218,7 @@ test true =3D "$rebase" && {
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
index f0a94ab..0de9a6c 100755
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
1.9.0.40.gaa8c3ea
