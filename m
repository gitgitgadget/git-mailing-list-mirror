From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 5/4] move sane_truncate_line to utf8_truncate_line
Date: Tue, 27 Mar 2012 01:31:25 -0400
Message-ID: <1332826286-13490-1-git-send-email-lodatom@gmail.com>
References: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 07:32:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCP0y-0006EV-1c
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 07:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530Ab2C0FcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 01:32:11 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:51008 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab2C0FcI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 01:32:08 -0400
Received: by qcqw6 with SMTP id w6so3818334qcq.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 22:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JdFA7eaFyZloc432ygsatfSw3Z1v4oESWrCliQGc86Q=;
        b=AMCKAcqz59ebsG5AHBMeVxXgWjBOIOHde+ia4jCee2Ai2YICDfYlYijcEv8nuMVYhq
         7PHW5aRde6ODsrQY+NUp/qjtcFH/q8ap/F3l1iBKSyf3A41cbo6j+h9j8RsseUZbrZpP
         8yN1c14bT9eI3N2Jqh4whhlMJZM4pMEsznjNZ1BKsSaI0SJHmHnqIeSwcLSXjf3sMBi/
         9/m20ha7YX0PQaEt3JZ0tEqpWxldZRjGaxQnceUHLKnyg17smZajQX5L1m3zNfESsGQh
         GulfqGtUjeq8RXh7RD2tKKcKsr+qwB7tCmNGNaLLrInb18lqMnw6TixRpm3+B6XNABis
         oyhA==
Received: by 10.224.213.7 with SMTP id gu7mr5250827qab.25.1332826327875;
        Mon, 26 Mar 2012 22:32:07 -0700 (PDT)
Received: from mark.hsd1.dc.comcast.net. (c-76-21-213-235.hsd1.dc.comcast.net. [76.21.213.235])
        by mx.google.com with ESMTPS id fp8sm20718309qab.20.2012.03.26.22.32.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 22:32:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.4
In-Reply-To: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194009>

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---

As promised, here are the additional patches to move the function name to the
same line as the hunk header.

 diff.c |   14 ++------------
 utf8.c |   13 +++++++++++++
 utf8.h |    2 ++
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index 377ec1e..74c77bc 100644
--- a/diff.c
+++ b/diff.c
@@ -1015,20 +1015,10 @@ const char *diff_get_color(int diff_use_color, enum color_diff ix)
 
 static unsigned long sane_truncate_line(struct emit_callback *ecb, char *line, unsigned long len)
 {
-	const char *cp;
-	unsigned long allot;
-	size_t l = len;
-
 	if (ecb->truncate)
 		return ecb->truncate(line, len);
-	cp = line;
-	allot = l;
-	while (0 < l) {
-		(void) utf8_width(&cp, &l);
-		if (!cp)
-			break; /* truncated in the middle? */
-	}
-	return allot - l;
+	else
+		return utf8_truncate_line(line, len);
 }
 
 static void find_lno(const char *line, struct emit_callback *ecbdata)
diff --git a/utf8.c b/utf8.c
index 8acbc66..d70ee9b 100644
--- a/utf8.c
+++ b/utf8.c
@@ -482,3 +482,16 @@ char *reencode_string(const char *in, const char *out_encoding, const char *in_e
 	return out;
 }
 #endif
+
+unsigned long utf8_truncate_line(const char *line, unsigned long len)
+{
+	const char *cp = line;
+	unsigned long allot = len;
+	size_t l = len;
+	while (0 < l) {
+		(void) utf8_width(&cp, &l);
+		if (!cp)
+			break; /* truncated in the middle? */
+	}
+	return allot - l;
+}
diff --git a/utf8.h b/utf8.h
index 81f2c82..929e2df 100644
--- a/utf8.h
+++ b/utf8.h
@@ -19,4 +19,6 @@ char *reencode_string(const char *in, const char *out_encoding, const char *in_e
 #define reencode_string(a,b,c) NULL
 #endif
 
+unsigned long utf8_truncate_line(const char *line, unsigned long len);
+
 #endif
-- 
1.7.9.4
