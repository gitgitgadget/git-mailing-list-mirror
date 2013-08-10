From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] push: respect --no-thin
Date: Sat, 10 Aug 2013 17:10:07 +0700
Message-ID: <1376129407-30590-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Martin Fick <mfick@codeaurora.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 10 12:09:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8672-0006zb-Of
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 12:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968539Ab3HJKJ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Aug 2013 06:09:29 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:48805 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968534Ab3HJKJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 06:09:27 -0400
Received: by mail-ie0-f170.google.com with SMTP id e14so5873633iej.29
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 03:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=WEu3KZluAw4GaP7+TDaFfbgnxSxzY7rmHJ7uhK1QrQo=;
        b=NuvMYXnyZenjbXsY9SJBBxRINmJC5Cnq2fKnVpaHe7WSpu2vh7FHYLwLWg9wrW3dQR
         Hrh1LKO4L+uzYFFFV7qCn9/IXTNVac8pslcmQBiiLGGIcnSs1WnO6RVlESGE7zpa7+bV
         WWy26tZdCQk920OwnYV2YJs/7e7zTF/1Y4q3Fdiid+jbEw6Cly/wRkp0+c9l7EGY3GqM
         3F/I4py59jq6aeoesphdt8fdCo23pa2/+EZHMALUqtXA9Z+vpl0EydRQwEucGulNIlbw
         +XQaQPjuz5OhOgZUUvCirHkN1TAfCthgiuaLGA6wqwPKmbZR+qws23Xml+3vI+MIAvEl
         98ag==
X-Received: by 10.50.1.20 with SMTP id 20mr4184779igi.56.1376129367404;
        Sat, 10 Aug 2013 03:09:27 -0700 (PDT)
Received: from lanh ([115.73.210.38])
        by mx.google.com with ESMTPSA id cl4sm10510667igc.1.2013.08.10.03.09.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 10 Aug 2013 03:09:26 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 10 Aug 2013 17:10:09 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232087>

Over the time the default value for --thin has been switched between
on and off. As of now it's always on, even if --no-thin is given.
Correct the code to respect --no-thin.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/push.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 04f0eaf..333a1fb 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -15,7 +15,7 @@ static const char * const push_usage[] =3D {
 	NULL,
 };
=20
-static int thin;
+static int thin =3D 1;
 static int deleterefs;
 static const char *receivepack;
 static int verbosity;
@@ -313,8 +313,7 @@ static int push_with_options(struct transport *tran=
sport, int flags)
 	if (receivepack)
 		transport_set_option(transport,
 				     TRANS_OPT_RECEIVEPACK, receivepack);
-	if (thin)
-		transport_set_option(transport, TRANS_OPT_THIN, "yes");
+	transport_set_option(transport, TRANS_OPT_THIN, thin ? "yes" : NULL);
=20
 	if (verbosity > 0)
 		fprintf(stderr, _("Pushing to %s\n"), transport->url);
--=20
1.8.2.83.gc99314b
