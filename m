From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] quote: remove sq_quote_print()
Date: Tue, 30 Jul 2013 14:01:27 +0530
Message-ID: <1375173087-2164-4-git-send-email-artagnon@gmail.com>
References: <1375173087-2164-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 30 10:35:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V45Or-0003R2-IQ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 10:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758158Ab3G3IfQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jul 2013 04:35:16 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36784 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524Ab3G3IfM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 04:35:12 -0400
Received: by mail-pa0-f49.google.com with SMTP id bi5so6857353pad.36
        for <git@vger.kernel.org>; Tue, 30 Jul 2013 01:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OoqEY313Zc3Eex2dNfx2+6/l+RW0j5hwWIv7P7QSmLU=;
        b=R+GEas4iRfwMHY09mpBN/dsv6oCfCNuPrmD9QzFhWXNZTfY3+2xftje8gyjpZ5XN10
         e2VQRdFbM6+s1WFVkFcOp/Pj7o6B0b00KTr9u/FitQYQ6sFiiZyLN0UdQVf5UhHApxS9
         i3KpN1efdr0sywV/xmhCcsYhkQe4fUzCfRqXxajB1W6JcMrRyl6xlT59oLSd/oAavUXW
         oVXcR+DLAEJbRec7QEJjaZCeDGY4XPy9eWT6h0W0l9PMT7zGpXervi/h9OlLcXnSkBPi
         jswwZJhis0qhm1MwaqrcH9f2zbxNRxcrnwfAhhLt8v7QTPKF8toV2L4WPaF4UBQK8fWT
         jHrw==
X-Received: by 10.66.164.71 with SMTP id yo7mr74172545pab.92.1375173312205;
        Tue, 30 Jul 2013 01:35:12 -0700 (PDT)
Received: from localhost.localdomain ([122.164.159.87])
        by mx.google.com with ESMTPSA id qb15sm25641801pab.13.2013.07.30.01.35.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Jul 2013 01:35:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.4.g4634265
In-Reply-To: <1375173087-2164-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231355>

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
index 9fd66c6..45e3db1 100644
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
index 6996ebd..71dcc3a 100644
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
1.8.4.rc0.4.g4634265
