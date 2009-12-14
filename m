From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/23] update-index: refactor mark_valid() in preparation for new options
Date: Mon, 14 Dec 2009 17:30:44 +0700
Message-ID: <1260786666-8405-2-git-send-email-pclouds@gmail.com>
References: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 11:36:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK8I6-0000bW-J7
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 11:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbZLNKfb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 05:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbZLNKcE
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 05:32:04 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:60353 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbZLNKcA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 05:32:00 -0500
Received: by pwj9 with SMTP id 9so1838737pwj.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 02:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8f5HrX4G7GiGDOE5TRUUw7cGMgc4xXUc5uoCUjgityc=;
        b=Z1r6zue2XBXte3fq2rHwbKSq9W8P67Y8437/Ey6OiuP67XKkGbCARYg4e9XMoAgl+M
         ARuV1jcEAHhbDOsaEIgr8IwDmS0jv3TvUdC5P4e/SpDr9oxeEe9Vcgs8OWIGPGguC/Bx
         qiu2eznGiIiS/KrKCCisBdiOh8D0ZJtA3aPKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=BBgiF9wggFnaurCvvHUcwMDSf4pNjOwbWtYTBzMowwAZ7i1MZQ/GaHFe82NMGZdvlH
         +Oui0UHAFRsvmBbl7QRgdAppIj+723T4c2REsGHHDRex7nZYgLpokTRDoOjtzWncCHl7
         EXezz0x5iA+PtDOIxc0Aeiv/Nq/d3rH9CO8tE=
Received: by 10.140.58.21 with SMTP id g21mr1742954rva.114.1260786719743;
        Mon, 14 Dec 2009 02:31:59 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.253])
        by mx.google.com with ESMTPS id 22sm4897468pzk.10.2009.12.14.02.31.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 02:31:58 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:31:17 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
In-Reply-To: <1260786666-8405-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135195>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-update-index.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 92beaaf..f1b6c8e 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -24,8 +24,8 @@ static int info_only;
 static int force_remove;
 static int verbose;
 static int mark_valid_only;
-#define MARK_VALID 1
-#define UNMARK_VALID 2
+#define MARK_FLAG 1
+#define UNMARK_FLAG 2
=20
 static void report(const char *fmt, ...)
 {
@@ -40,19 +40,15 @@ static void report(const char *fmt, ...)
 	va_end(vp);
 }
=20
-static int mark_valid(const char *path)
+static int mark_ce_flags(const char *path, int flag, int mark)
 {
 	int namelen =3D strlen(path);
 	int pos =3D cache_name_pos(path, namelen);
 	if (0 <=3D pos) {
-		switch (mark_valid_only) {
-		case MARK_VALID:
-			active_cache[pos]->ce_flags |=3D CE_VALID;
-			break;
-		case UNMARK_VALID:
-			active_cache[pos]->ce_flags &=3D ~CE_VALID;
-			break;
-		}
+		if (mark)
+			active_cache[pos]->ce_flags |=3D flag;
+		else
+			active_cache[pos]->ce_flags &=3D ~flag;
 		cache_tree_invalidate_path(active_cache_tree, path);
 		active_cache_changed =3D 1;
 		return 0;
@@ -276,7 +272,7 @@ static void update_one(const char *path, const char=
 *prefix, int prefix_length)
 		goto free_return;
 	}
 	if (mark_valid_only) {
-		if (mark_valid(p))
+		if (mark_ce_flags(p, CE_VALID, mark_valid_only =3D=3D MARK_FLAG))
 			die("Unable to mark file %s", path);
 		goto free_return;
 	}
@@ -647,11 +643,11 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
 				continue;
 			}
 			if (!strcmp(path, "--assume-unchanged")) {
-				mark_valid_only =3D MARK_VALID;
+				mark_valid_only =3D MARK_FLAG;
 				continue;
 			}
 			if (!strcmp(path, "--no-assume-unchanged")) {
-				mark_valid_only =3D UNMARK_VALID;
+				mark_valid_only =3D UNMARK_FLAG;
 				continue;
 			}
 			if (!strcmp(path, "--info-only")) {
--=20
1.6.5.2.216.g9c1ec
