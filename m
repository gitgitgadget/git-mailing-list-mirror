From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/9] quote.c: make sq_quote_print a slight wrapper of sq_quote_buf
Date: Sun, 19 May 2013 17:27:07 +0700
Message-ID: <1368959235-27777-2-git-send-email-pclouds@gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 19 12:26:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue0pB-0006XP-0a
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 12:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab3ESK0V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 06:26:21 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:42074 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab3ESK0T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 06:26:19 -0400
Received: by mail-pb0-f42.google.com with SMTP id uo1so107366pbc.1
        for <git@vger.kernel.org>; Sun, 19 May 2013 03:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=EzTjO+eZnuei9lWzUQ6cWtEdlmqzXZM5HOdoxIgunbA=;
        b=Vm0jsHnqfSUjxjfEmzZDgIbEETWieJjrSHq69N/XxAE+FnC2L2oR8FdlMUyyV1cPdu
         NqLUQLWDvQ3PY9clZLx2t0kpjXPXzOXeGk04AnEajGMz+sZmNk0tqEdP8qosrW8bUmQp
         OB4THwMlvNHWlxciqu0VPMrB58dZKuYJLkVuUj6XFflmyHDaqKGpRVE87/yZQ5kGioK8
         aAunUHz/us+n6Z4wkERZ1IWPudClxyUDyqkuw8mqDUZPFoKP4ziPEso3YYGOa1IkP5e+
         nMKfG8vjWclScf7tB+PXiNxk9JADQK4tqdvV5i90AIrN0pLOy5yt19cjjjKx2tbVn7Lc
         MLRw==
X-Received: by 10.66.145.67 with SMTP id ss3mr56678860pab.18.1368959178579;
        Sun, 19 May 2013 03:26:18 -0700 (PDT)
Received: from lanh ([115.73.232.21])
        by mx.google.com with ESMTPSA id uv1sm19227009pbc.16.2013.05.19.03.26.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 May 2013 03:26:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 19 May 2013 17:27:28 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224838>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 quote.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/quote.c b/quote.c
index 911229f..c67f5d3 100644
--- a/quote.c
+++ b/quote.c
@@ -44,19 +44,10 @@ void sq_quote_buf(struct strbuf *dst, const char *s=
rc)
=20
 void sq_quote_print(FILE *stream, const char *src)
 {
-	char c;
-
-	fputc('\'', stream);
-	while ((c =3D *src++)) {
-		if (need_bs_quote(c)) {
-			fputs("'\\", stream);
-			fputc(c, stream);
-			fputc('\'', stream);
-		} else {
-			fputc(c, stream);
-		}
-	}
-	fputc('\'', stream);
+	struct strbuf sb =3D STRBUF_INIT;
+	sq_quote_buf(&sb, src);
+	fputs(sb.buf, stream);
+	strbuf_release(&sb);
 }
=20
 void sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxle=
n)
--=20
1.8.2.83.gc99314b
