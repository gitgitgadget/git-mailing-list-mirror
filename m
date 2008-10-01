From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/9] update-index: refactor mark_valid() in preparation for new options
Date: Wed,  1 Oct 2008 11:04:04 +0700
Message-ID: <1222833849-22129-5-git-send-email-pclouds@gmail.com>
References: <1222833849-22129-1-git-send-email-pclouds@gmail.com>
 <1222833849-22129-2-git-send-email-pclouds@gmail.com>
 <1222833849-22129-3-git-send-email-pclouds@gmail.com>
 <1222833849-22129-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 06:06:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkszF-0001ME-VA
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 06:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbYJAEFf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2008 00:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbYJAEFe
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 00:05:34 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:63785 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbYJAEFe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 00:05:34 -0400
Received: by rv-out-0506.google.com with SMTP id k40so384855rvb.1
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 21:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LXpDeBEgfbYd8BnMmU5hZ4S/rWMGus6gpM52Uuc5p6U=;
        b=mcxaS8a7/9v8ji6lBlFIPmrHUXPnnwj65TTuu82I6GABJ064wCh/mE6JllFy3b/wiY
         7mpyd/bUzQv3ZexzY+bEVZ+wvcJ0aMapdedkJS8x4pBz6be/JkJ4OSxbTfJudFP7Ou8u
         GYgviCtteBagbTazYfLpWubOmqawhF8PYoEL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ohLATO4JbIRUwboLcltmEW4MD6uBBg2GwKde2heM+mvfr50GQnxKGwqgLV+QchOjBG
         pZnJZMM+csH88+UGsCZTbNvVwmk3/I37bZnMNJgNrJOVOcsnv084IEPWV4WsEcc5FwgT
         Xkc+T4qXR9dRGnWPE30ANaRQmn8XngUti6ZKo=
Received: by 10.141.87.13 with SMTP id p13mr4032895rvl.93.1222833933744;
        Tue, 30 Sep 2008 21:05:33 -0700 (PDT)
Received: from pclouds@gmail.com ([117.5.46.240])
        by mx.google.com with ESMTPS id g31sm3937326rvb.7.2008.09.30.21.05.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 21:05:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed,  1 Oct 2008 11:05:26 +0700
X-Mailer: git-send-email 1.6.0.2.488.gf604a
In-Reply-To: <1222833849-22129-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97194>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-update-index.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 417f972..ae94739 100644
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
@@ -649,11 +645,11 @@ int cmd_update_index(int argc, const char **argv,=
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
1.6.0.2.488.gf604a
