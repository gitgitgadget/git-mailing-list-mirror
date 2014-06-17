From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 1/3] add strnncmp() function
Date: Tue, 17 Jun 2014 00:34:37 -0700
Message-ID: <50de63f47ded2337adcd8bce151190fb99b38d64.1402990051.git.jmmahler@gmail.com>
References: <cover.1402990051.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 09:35:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwnvO-00041K-In
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 09:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbaFQHfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 03:35:17 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:63460 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbaFQHfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 03:35:16 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so3645673pad.9
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 00:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xw5mk/0HcbZx7EXk2yYFyT9qLKj0W+viRsTp2bkr6rs=;
        b=Wx6pdAjNx3aRzKclxzNef8oCMVCMP/pcf2xxHE2hQy74WzR2GaMHZUrjbdQDjHMUgT
         gO2cuxz2hypJE8tH7RIqgykzdBfX+FlVtgoEZrqokJ6Pv9FKCR5D/lvGOTo15se9w5aL
         SRu0sFSospFqow45jrsLnsh7tQYz4/t0ZxR9TxD5k2w3rxOuFsRmdu97cVh6rHXKtNOa
         G9DesoANsh+y3pp1YDdzs2W8YEPGNicst14tRDks14nTD/AcR8HIiGUbNu0LE624WO/r
         BBnhTifD1IC9wacP5IRKKsCH+pd5pVLfzdoph/4O0UyZfgioD4X24iSyo8hmIBTuxzPp
         leiA==
X-Received: by 10.68.110.3 with SMTP id hw3mr30392715pbb.144.1402990515525;
        Tue, 17 Jun 2014 00:35:15 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id wp3sm22453481pbc.67.2014.06.17.00.35.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jun 2014 00:35:14 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.695.g38ee9a9
In-Reply-To: <cover.1402990051.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402990051.git.jmmahler@gmail.com>
References: <cover.1402990051.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251848>

Add a strnncmp() function which behaves like strncmp() except it takes
the length of both strings instead of just one.  It behaves the same as
strncmp() up to the minimum common length between the strings.  When the
strings are identical up to this minimum common length, the length
difference is returned.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 strbuf.c | 9 +++++++++
 strbuf.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index ac62982..4eb7954 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -600,3 +600,12 @@ char *xstrdup_tolower(const char *string)
 	result[i] = '\0';
 	return result;
 }
+
+int strnncmp(const char *a, int len_a, const char *b, int len_b)
+{
+	int min_len = (len_a < len_b) ? len_a : len_b;
+	int cmp = strncmp(a, b, min_len);
+	if (cmp)
+		return cmp;
+	return (len_a - len_b);
+}
diff --git a/strbuf.h b/strbuf.h
index e9ad03e..88af9bf 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -187,4 +187,6 @@ extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
 
+extern int strnncmp(const char *a, int len_a, const char *b, int len_b);
+
 #endif /* STRBUF_H */
-- 
2.0.0.695.g38ee9a9
