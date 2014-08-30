From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/32] *.sh: respect $GIT_INDEX_FILE
Date: Sat, 30 Aug 2014 15:33:37 +0700
Message-ID: <1409387642-24492-8-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:34:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe7M-0001b1-IZ
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbaH3Ieg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:34:36 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:37420 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbaH3Ief (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:34:35 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so2041338pdb.13
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kgpzDHrl2TWHFRo1IiyZvRFU9+2QsBYAUPAovpIc3Ms=;
        b=YyaKyOwXbyZKkWkjnvRH8Xp8z9fyldPtiSZJwv9exUr+z0to8jq5degrHeDvmePsS0
         bMCmpMeYNr5XEF8K8zxjcGjpjzK7afFTVb9jgkS8Fz/7RitK7Pe5H66PYgVpmNL9G9FD
         ahALoB0iJu8rgGKLJ+6abXr6Eu607r0EArayCXtycf9BYQhKfZXRZlQi0XB6urg2nhQE
         73xOztDmYIPYEbhI+sD2JIlFoQpXwRjI9x9TMfoY0O4CEVNywz8kAdW+AQC7FeT/ozm8
         LYnaTJMVsXb86n9axH5KPs2DZ0vt8GP32fnsY3zROf5KVn1tYcsjlZS7WAM+JzWHwVSt
         HA7g==
X-Received: by 10.66.136.48 with SMTP id px16mr2910906pab.10.1409387673921;
        Sat, 30 Aug 2014 01:34:33 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id oa8sm3228588pdb.20.2014.08.30.01.34.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:34:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:34:43 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256217>

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
