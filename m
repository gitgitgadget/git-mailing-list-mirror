From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 04/15] quote: remove sq_quote_print()
Date: Tue,  9 Jul 2013 16:02:15 +0530
Message-ID: <1373365946-9230-5-git-send-email-artagnon@gmail.com>
References: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 09 12:36:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwVHY-0006sg-Fx
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 12:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512Ab3GIKgY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 06:36:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37846 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab3GIKgW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 06:36:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so5366606pbb.19
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 03:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bMPb37JPhOCy11Gyyl+mxjyRKe/8H7oNOorzGaJFMTU=;
        b=VLTvK0b9FJSL+131Ien7cu1E/NTFgRF/W7kyYUjWxyuvxfSP0qvdOBCK6WozJAODOg
         GspNoa4/SnqvbGAncOEI4VgaUMVYArs+9JrI6bEabBcYpVeKy6jtZI3cn7a39v85OumI
         FcxRI5a3yD6QKu911NyAYhdSfzz5U8C5XPepDDiEv2E1nNTB2v/1sCndiryEoAojXwTY
         YTSNvnxvXdI7EORSb8YKj8BdjtyYlwFknJM8KHxEcypcMRZWMd/bUtLcGPNoFnNaBKEO
         odw3FDPr8ik2kS+J2WCRsMmazpKBMMJYPLDw96k97kC2nKuuiJbmQSW10u3bye0RJP58
         bKcA==
X-Received: by 10.66.138.15 with SMTP id qm15mr26870349pab.128.1373366181531;
        Tue, 09 Jul 2013 03:36:21 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id fr1sm27553398pbb.26.2013.07.09.03.36.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 03:36:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.736.g869de25
In-Reply-To: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229931>

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
1.8.3.2.736.g869de25
