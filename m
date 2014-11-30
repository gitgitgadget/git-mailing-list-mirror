From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/34] *.sh: respect $GIT_INDEX_FILE
Date: Sun, 30 Nov 2014 15:24:32 +0700
Message-ID: <1417335899-27307-8-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:26:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuzq7-0007Xn-7P
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbaK3I0j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:26:39 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:38501 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbaK3I0j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:26:39 -0500
Received: by mail-pd0-f174.google.com with SMTP id w10so8965485pde.33
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=f6dch566FN5qbuwK4WHAW9fF2/+5H4jfZwdObDldHGA=;
        b=jIeSVHXuIOki1qkolCEccCSvlQCytem8fAdmfFvRSXFHmadXUaN2bmt+6BSHbW7JOc
         2osvd1JJMhjSycTNEj86aduf6c14GXNChYeDN0HPRcxb3MAHBFkOAedZYR1beQ3Og6Wi
         Q75bri+6UT8H7vXAN23WctAZC7gRXLCzg9GIrD0dUIQtN5oG75dp8NzAZjL0RsW2Pqi/
         uyAqVMY0BHJ7eAJVx+I9wKVsRzKBcjQ9X57uu1Aeu1kQa2DJ2GoQMiTp6uiTZhx5QC4a
         xlWXmDelQWgK57sqbMYbzrSj7gnqnHPPckMfew6pbH8dCSVrWjrGzxSmL/SNHq7Agbw3
         vltQ==
X-Received: by 10.68.102.5 with SMTP id fk5mr87245266pbb.136.1417335998870;
        Sun, 30 Nov 2014 00:26:38 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id nb3sm14370101pdb.18.2014.11.30.00.26.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:26:38 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:26:31 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260394>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
index d4cf818..b6d4b06 100755
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
