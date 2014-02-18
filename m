From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 06/25] *.sh: respect $GIT_INDEX_FILE
Date: Tue, 18 Feb 2014 20:39:55 +0700
Message-ID: <1392730814-19656-7-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:42:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkwe-0000pO-Ve
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755746AbaBRNmD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:42:03 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:47229 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755615AbaBRNkt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:40:49 -0500
Received: by mail-pa0-f51.google.com with SMTP id ld10so16789434pab.38
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=U02I6C8AFhUh3avxOYN0LJX1Ct146qLcFuvXStquhgg=;
        b=hJK04yIVIVj7i93b1ZQTJrEnieHkkbQYla2/s3PG2xSjHSEc8iuMEyTS2/IAgbb/t6
         2apbkyaOzV3wdNVn7mw9+XQVSyN7CUn96QcyQUN49lusqBxPa+MqOjTm6YmffZcw0zhf
         itOea50VfeOT4wRi6RiCsK9OSO60LkPGKsSvRSfEDWOU9FO30B5ZnWABxqFB5NIOntMS
         SbYNjPiYqttgFDmvu/zN1wkjGugnk8BZTLTEkwJWyfUdOIrgAlCMYRgOQJak6OGtMMCn
         SX8188Hi9k3zQejogucwYFr9ffUzz1LPn7+v1c+1XEt4zHqWkPx3AKE9TmLZBPZ03um+
         66DA==
X-Received: by 10.68.240.36 with SMTP id vx4mr15204397pbc.140.1392730849436;
        Tue, 18 Feb 2014 05:40:49 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id xf3sm13077766pbc.30.2014.02.18.05.40.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:40:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:41:02 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242317>

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
1.8.5.2.240.g8478abd
