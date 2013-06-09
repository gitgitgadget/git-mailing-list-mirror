From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 04/15] quote: remove sq_quote_print()
Date: Sun,  9 Jun 2013 23:24:23 +0530
Message-ID: <1370800474-8940-5-git-send-email-artagnon@gmail.com>
References: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:56:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljrG-0006QU-7p
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884Ab3FIR4r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:56:47 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:52410 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab3FIR4q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:56:46 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so3057104pdj.3
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dQ/+yxItDcREcESZmL2fy59s7nIA1FdLqP73H5UjcUs=;
        b=Dl1EyKUCIJMjg4A3teIMdHFO2IlxfmKthnXuZ+GimBbwH8sTwVr6VQoBiSmJq+3ce1
         UiuMcLBhY2DMzX4z5Rsfe5ZeDh/FRIdOUtCmE1triRCRMJGJd2/xRzHrqSkePkJ0KyUS
         oj1ZiZDkuZbAr1AtC+yiZeup7NugJDdTkeKivBVOUT8DOV5aXIPx6vacWkDmxHzcD3aj
         bYf4u+WqTU9a+qscZl6NMLtYZS9LLpt0wO0kshJUvtpqY36f4c9UGV/6dzXmNS6YpsYc
         LNMJM1aVFJD6iBnJvEt7XevHDy9JbGz36TyVfbJq3unLn2ZVJ4pEsCPtVPorRygxz9G9
         IwTQ==
X-Received: by 10.68.247.69 with SMTP id yc5mr3039120pbc.66.1370800605572;
        Sun, 09 Jun 2013 10:56:45 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id qp4sm7275815pbc.41.2013.06.09.10.56.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:56:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
In-Reply-To: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227059>

Remove sq_quote_print() since it has no callers.  A nicer alternative
sq_quote_buf() exists: its callers aren't forced to print immediately.

=46or historical context, sq_quote_print() was first introduced in
575ba9d6 (GIT_TRACE: show which built-in/external commands are executed=
,
2006-06-25) for the purpose of printing argv for $GIT_TRACE.  Today, we
achieve this using trace_argv_printf() -> sq_quote_argv() ->
sq_quote_buf(), which ultimately fills in a strbuf.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 quote.c | 17 -----------------
 quote.h |  2 --
 2 files changed, 19 deletions(-)

diff --git a/quote.c b/quote.c
index 8c294df..778b39a 100644
--- a/quote.c
+++ b/quote.c
@@ -42,23 +42,6 @@ void sq_quote_buf(struct strbuf *dst, const char *sr=
c)
 	free(to_free);
 }
=20
-void sq_quote_print(FILE *stream, const char *src)
-{
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
-}
-
 void sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxle=
n)
 {
 	int i;
diff --git a/quote.h b/quote.h
index ed06df5..251f3cc 100644
--- a/quote.h
+++ b/quote.h
@@ -27,8 +27,6 @@ struct strbuf;
  * excluding the final null regardless of the buffer size.
  */
=20
-extern void sq_quote_print(FILE *stream, const char *src);
-
 extern void sq_quote_buf(struct strbuf *, const char *src);
 extern void sq_quote_argv(struct strbuf *, const char **argv, size_t m=
axlen);
=20
--=20
1.8.3.247.g485169c
