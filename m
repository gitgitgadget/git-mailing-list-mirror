From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 17/41] compat/win32/syslog.c: use warning_errno()
Date: Sun,  8 May 2016 16:47:37 +0700
Message-ID: <1462700881-25108-18-git-send-email-pclouds@gmail.com>
References: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
 <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 11:51:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLLy-0000y9-8g
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbcEHJuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:50:16 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34075 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbcEHJuO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:50:14 -0400
Received: by mail-pf0-f196.google.com with SMTP id 145so13760739pfz.1
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ytrv7VsD9KFUU59IXJ+UOnzp7KtbwGWbBKeUHdmDiuI=;
        b=vavgeX0nE+CDKM0lrXWK4hm+m7qcfUQrIlJmFdFBJdFn1YLGgxTO8Rn+/p3HL0ujqB
         NCinTrDGNeXiPCg7ghxGXmlrtvLXsxI4oKWwr9XShOFuK50mxHt/Ypf+2Vt+jIuur5vC
         Xx6/0JAtQVue1YdYRMAqdZHdpuUXuWAWaJJkuzZOMIm+4FIkwfOgRnWhHJ+VkdyrfYsW
         0TiDQl5DCRV4V3mv3/4kQHQDl8k9iOuAbeLVRih0BuStISnxHhpV6kxjIH44cmDEX8a9
         vmffI7AXIODbJQVeBZ2+dO4AisUxvNbZ0tkn+lacj0jxhZ05+WLZuZKH5aly1C5rwFCQ
         8IUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ytrv7VsD9KFUU59IXJ+UOnzp7KtbwGWbBKeUHdmDiuI=;
        b=YpFnu84fmQd3G+d3bizOHtg9UwIBpjXU3VEg87HCjDPR9tlFCHeF5dg/ercMZSSTVN
         cgPP9nrg1d73YICkzYOn0OxOpwQQ12NkUr+IEc39oi8vlyCZMZw7bua25RxDH9j7SPvP
         aDvYvW1fu3MiIg1zcy6CtZhfwouspFrzQsRNhtjZLCoRxMMV6P8ipJeX6nWdXyAm8evo
         VVcIXIfAFjDmmEqW3P8fuMtj0z8xfLnfb4lfHhpGfB2PNWMt9OkwTdQRB/bRnR3cYUth
         c0Bq9V8hufjepfVA5Ghd13V33TUOqrUuDwP4eBJ4/Lr4JzF0aPBSG42zuih9nxrP8fQE
         Pw/w==
X-Gm-Message-State: AOPr4FUPLkYIGch1WP5uXVfiqq6mbX51ZMD8AwPpBZS/DAH+0+mxMcBMOOgHDlkS1JRj2Q==
X-Received: by 10.98.93.142 with SMTP id n14mr41331009pfj.37.1462701014147;
        Sun, 08 May 2016 02:50:14 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id f187sm32719539pfb.60.2016.05.08.02.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:50:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:50:13 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293935>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 compat/win32/syslog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index b905aea..6c7c9b6 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -28,13 +28,13 @@ void syslog(int priority, const char *fmt, ...)
 	va_end(ap);
=20
 	if (str_len < 0) {
-		warning("vsnprintf failed: '%s'", strerror(errno));
+		warning_errno("vsnprintf failed");
 		return;
 	}
=20
 	str =3D malloc(st_add(str_len, 1));
 	if (!str) {
-		warning("malloc failed: '%s'", strerror(errno));
+		warning_errno("malloc failed");
 		return;
 	}
=20
@@ -45,7 +45,7 @@ void syslog(int priority, const char *fmt, ...)
 	while ((pos =3D strstr(str, "%1")) !=3D NULL) {
 		str =3D realloc(str, st_add(++str_len, 1));
 		if (!str) {
-			warning("realloc failed: '%s'", strerror(errno));
+			warning_errno("realloc failed");
 			return;
 		}
 		memmove(pos + 2, pos + 1, strlen(pos));
--=20
2.8.0.rc0.210.gd302cd2
