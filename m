From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/26] upload-pack: move rev-list code out of check_non_tip()
Date: Wed, 13 Apr 2016 19:54:53 +0700
Message-ID: <1460552110-5554-10-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:56:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKL8-0004Fa-9J
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030724AbcDMM4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:56:00 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33579 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030495AbcDMMz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:55:58 -0400
Received: by mail-pf0-f196.google.com with SMTP id e190so4079751pfe.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7N9xqy3cA5udHzyZR0pVR5zl8EqrMvEFWTtZKn/45Y=;
        b=CG6mU6UaG+SLA18bZhJAfzaV/+NOZPAuXF8RJVu/ebMD0MGPWyudm3KaAIPijltJIh
         +L3rY5Q9Zb3olTgVg/uSVQlwSSfYpCFkr15dTQ2S8g4+txhrUYGZHxm3TwhEWQNQ5A8c
         5MXcewoQE/w0H/v/cYDYeQlohBSghQ4xTIQHub9KUlmNLCW7V5vKozFehoALlLvBW0vk
         aDRiQCa4lC8PvP3MMWg9DrrAd2Yeg5yIp3BflSKHG7y9OzFrBiOoVqP0oMCji7pGNb8G
         6pSgfY8Fk+X/x7zCClr6RNV71bkLteB1e3v2iAWXmL4sfmV0EP4/hT1IAsuOPtHwm+lz
         CDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7N9xqy3cA5udHzyZR0pVR5zl8EqrMvEFWTtZKn/45Y=;
        b=DaHXZ4uBMWj4kvUjVUu2wlsAb9uR5whM3GCugzLkqfNicZ6QC8ytGIrhSLMTkt/UMn
         0T4y2to1lGlrgldFeMy2A9KSld1XdW61rQFWlSl93DsGzKojPXDFCBxSXfDpF3LUP/c8
         W7JDAmgwiPsW7/cytqFdOFN8vLxpGUr2pVChD/lOuU0ty/rtVw/IzgmU1YVsa5qul1sH
         9YK1FT0cS/1PYaHMNYVlDl7xijDwm1u+/wH2SIlFgGz2TjExURfgMncQxA2EG56vV3iA
         XwIjwAR6N0AkuiWK3tz/NjC46OwNoEdTxkse3p0srDRflWuZesM4ItOYpKdNmlFLHHAj
         jqQg==
X-Gm-Message-State: AOPr4FW60agn1OyjcGEAj1TsPmPxQR1xEL74VBJ6kQEe/f4VSf3NYQmfuDphPQTbdm0ILw==
X-Received: by 10.98.23.146 with SMTP id 140mr2856446pfx.96.1460552157901;
        Wed, 13 Apr 2016 05:55:57 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id w189sm733831pfw.46.2016.04.13.05.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:55:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:56:04 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291405>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 9f14933..c8dafe8 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -451,7 +451,7 @@ static int is_our_ref(struct object *o)
 	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
 }
=20
-static void check_non_tip(void)
+static int check_unreachable(struct object_array *src)
 {
 	static const char *argv[] =3D {
 		"rev-list", "--stdin", NULL,
@@ -461,14 +461,6 @@ static void check_non_tip(void)
 	char namebuf[42]; /* ^ + SHA-1 + LF */
 	int i;
=20
-	/*
-	 * In the normal in-process case without
-	 * uploadpack.allowReachableSHA1InWant,
-	 * non-tip requests can never happen.
-	 */
-	if (!stateless_rpc && !(allow_unadvertised_object_request & ALLOW_REA=
CHABLE_SHA1))
-		goto error;
-
 	cmd.argv =3D argv;
 	cmd.git_cmd =3D 1;
 	cmd.no_stderr =3D 1;
@@ -476,7 +468,7 @@ static void check_non_tip(void)
 	cmd.out =3D -1;
=20
 	if (start_command(&cmd))
-		goto error;
+		return 0;
=20
 	/*
 	 * If rev-list --stdin encounters an unknown commit, it
@@ -495,16 +487,16 @@ static void check_non_tip(void)
 			continue;
 		memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
 		if (write_in_full(cmd.in, namebuf, 42) < 0)
-			goto error;
+			return 0;
 	}
 	namebuf[40] =3D '\n';
-	for (i =3D 0; i < want_obj.nr; i++) {
-		o =3D want_obj.objects[i].item;
+	for (i =3D 0; i < src->nr; i++) {
+		o =3D src->objects[i].item;
 		if (is_our_ref(o))
 			continue;
 		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
 		if (write_in_full(cmd.in, namebuf, 41) < 0)
-			goto error;
+			return 0;
 	}
 	close(cmd.in);
=20
@@ -516,7 +508,7 @@ static void check_non_tip(void)
 	 */
 	i =3D read_in_full(cmd.out, namebuf, 1);
 	if (i)
-		goto error;
+		return 0;
 	close(cmd.out);
=20
 	/*
@@ -525,15 +517,29 @@ static void check_non_tip(void)
 	 * even when it showed no commit.
 	 */
 	if (finish_command(&cmd))
-		goto error;
+		return 0;
=20
 	/* All the non-tip ones are ancestors of what we advertised */
-	return;
+	return 1;
+}
+
+static void check_non_tip(void)
+{
+	int i;
+
+	/*
+	 * In the normal in-process case without
+	 * uploadpack.allowReachableSHA1InWant,
+	 * non-tip requests can never happen.
+	 */
+	if (!stateless_rpc && !(allow_unadvertised_object_request & ALLOW_REA=
CHABLE_SHA1))
+		;		/* error */
+	else if (check_unreachable(&want_obj))
+		return;
=20
-error:
 	/* Pick one of them (we know there at least is one) */
 	for (i =3D 0; i < want_obj.nr; i++) {
-		o =3D want_obj.objects[i].item;
+		struct object *o =3D want_obj.objects[i].item;
 		if (!is_our_ref(o))
 			die("git upload-pack: not our ref %s",
 			    oid_to_hex(&o->oid));
--=20
2.8.0.rc0.210.gd302cd2
