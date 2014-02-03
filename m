From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 01/26] pkt-line.c: rename global variable buffer[] to something less generic
Date: Mon,  3 Feb 2014 11:28:49 +0700
Message-ID: <1391401754-15347-2-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:29:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABA1-0000pq-67
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbaBCE3Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:29:24 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:55023 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbaBCE3X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:29:23 -0500
Received: by mail-pd0-f181.google.com with SMTP id y10so6358181pdj.26
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yn8nYCKFiDUtAHrUFdP0aGXGxEdAqeo8aw/SCmn+7Sw=;
        b=W6Jh4jRY3fWwrUn/RC+v0A1/Y16Co6Sd7diJyfhMOIfzyF08HK0OIlo2mTwHKYNlz4
         GVkMoKu5F7wvzXQHV8ERQ/Ii8y+vmHu6daCNsUcaWOv/T9uTvkSUj2N/naIZQhwxX7fe
         Uqas/qMOqoPyRr9DW+v8JYbooXStma7wEdzlvMES1e6LeMXr+5pJgyXUqkHbj2OnqKhW
         Gn4dEYpaIawCUA4jvRj8gcIUc1CkFSbLSzyIavCkQAPkbAMYKDTam73R95g6yiCPpsPu
         mx61LfiK/pzfGTYu/32DdtF3La/7LQOIeEkhWwixUQkC0nCMsRYp8RvGqQx4KkLAT+bW
         qZuw==
X-Received: by 10.66.13.138 with SMTP id h10mr1045296pac.148.1391401762756;
        Sun, 02 Feb 2014 20:29:22 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id hb10sm51405940pbd.1.2014.02.02.20.29.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:29:22 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:29:20 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241396>

"buffer" is a local variable in some other functions. Rename the
global one to make it less confusing.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pkt-line.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index bc63b3b..eac45ad 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -64,14 +64,15 @@ void packet_buf_flush(struct strbuf *buf)
 }
=20
 #define hex(a) (hexchar[(a) & 15])
-static char buffer[1000];
+static char write_buffer[1000];
 static unsigned format_packet(const char *fmt, va_list args)
 {
 	static char hexchar[] =3D "0123456789abcdef";
+	char *buffer =3D write_buffer;
 	unsigned n;
=20
-	n =3D vsnprintf(buffer + 4, sizeof(buffer) - 4, fmt, args);
-	if (n >=3D sizeof(buffer)-4)
+	n =3D vsnprintf(buffer + 4, sizeof(write_buffer) - 4, fmt, args);
+	if (n >=3D sizeof(write_buffer)-4)
 		die("protocol error: impossibly long line");
 	n +=3D 4;
 	buffer[0] =3D hex(n >> 12);
@@ -90,7 +91,7 @@ void packet_write(int fd, const char *fmt, ...)
 	va_start(args, fmt);
 	n =3D format_packet(fmt, args);
 	va_end(args);
-	write_or_die(fd, buffer, n);
+	write_or_die(fd, write_buffer, n);
 }
=20
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
@@ -101,7 +102,7 @@ void packet_buf_write(struct strbuf *buf, const cha=
r *fmt, ...)
 	va_start(args, fmt);
 	n =3D format_packet(fmt, args);
 	va_end(args);
-	strbuf_add(buf, buffer, n);
+	strbuf_add(buf, write_buffer, n);
 }
=20
 static int get_packet_data(int fd, char **src_buf, size_t *src_size,
--=20
1.8.5.2.240.g8478abd
