From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/6] utf8.c: move display_mode_esc_sequence_len() for use by other functions
Date: Sat, 22 Sep 2012 11:22:17 +0700
Message-ID: <1348287739-12128-5-git-send-email-pclouds@gmail.com>
References: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 06:23:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFHFA-0003Pi-KC
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 06:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab2IVEWo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Sep 2012 00:22:44 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59381 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab2IVEWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 00:22:33 -0400
X-Greylist: delayed 143753 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Sep 2012 00:22:17 EDT
Received: by mail-pa0-f46.google.com with SMTP id hz1so137078pad.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 21:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9k6vUZnFwaD4yeDQqxEHmi4anHoPr68K1n2JIbNMknA=;
        b=l5XwkbN+I2owrL8noCOZJ/ZNUUgdX9opcWMYxIXktVFxU9XJ2NfP3R8vZEndVWJfGQ
         MBJlVx307NM7wt1r11cvJwmYnkhFSMFxeQI0w0vEj0WpvdFg1FxtSpDN7kOqHzRqi4Id
         HqVshkRsf/RftLZdbodBNZG48BQHUgLub02wOWNkt3awrA4eLLBH3Ey2qvXRYKbBTrp9
         vopwPwWKSGJofFe8M2RAz4bXoDNLdi2T9fJCSbYHdbIdyb5Lbu4gOC0Se26u6Do9so+H
         naC38ikdud/0Oc8+dTmJ9MlUlqktUEJ4cOy0rukNpiHPPxFojtJUjIDpIIPfClYs1kQr
         8MaQ==
Received: by 10.68.224.73 with SMTP id ra9mr20480965pbc.85.1348287753534;
        Fri, 21 Sep 2012 21:22:33 -0700 (PDT)
Received: from lanh ([115.74.43.144])
        by mx.google.com with ESMTPS id c5sm5121952pay.5.2012.09.21.21.22.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Sep 2012 21:22:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Sep 2012 11:22:44 +0700
X-Mailer: git-send-email 1.7.12.1.384.g7b808e7
In-Reply-To: <1348287739-12128-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206181>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 utf8.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/utf8.c b/utf8.c
index a544f15..18a4d9c 100644
--- a/utf8.c
+++ b/utf8.c
@@ -9,6 +9,20 @@ struct interval {
   int last;
 };
=20
+static size_t display_mode_esc_sequence_len(const char *s)
+{
+	const char *p =3D s;
+	if (*p++ !=3D '\033')
+		return 0;
+	if (*p++ !=3D '[')
+		return 0;
+	while (isdigit(*p) || *p =3D=3D ';')
+		p++;
+	if (*p++ !=3D 'm')
+		return 0;
+	return p - s;
+}
+
 /* auxiliary function for binary search in interval table */
 static int bisearch(ucs_char_t ucs, const struct interval *table, int =
max)
 {
@@ -303,20 +317,6 @@ static void strbuf_add_indented_text(struct strbuf=
 *buf, const char *text,
 	}
 }
=20
-static size_t display_mode_esc_sequence_len(const char *s)
-{
-	const char *p =3D s;
-	if (*p++ !=3D '\033')
-		return 0;
-	if (*p++ !=3D '[')
-		return 0;
-	while (isdigit(*p) || *p =3D=3D ';')
-		p++;
-	if (*p++ !=3D 'm')
-		return 0;
-	return p - s;
-}
-
 /*
  * Wrap the text, if necessary. The variable indent is the indent for =
the
  * first line, indent2 is the indent for all other lines.
--=20
1.7.12.1.384.g7b808e7
