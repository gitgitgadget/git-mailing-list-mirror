From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 01/12] strbuf: introduce strbuf_split_str_omit_term()
Date: Sun, 31 Jan 2016 23:12:45 +0530
Message-ID: <1454262176-6594-2-git-send-email-Karthik.188@gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 18:43:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPw1c-0008By-2b
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 18:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbcAaRma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 12:42:30 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35361 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066AbcAaRmW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 12:42:22 -0500
Received: by mail-pf0-f194.google.com with SMTP id 66so5969792pfe.2
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 09:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M1l2InsDW60perTISjMo8FtRkuEavNFIU5YUduGGtJM=;
        b=xvOghSA7SzbGuA9VWr2kg1UFzrUUOhqg5RjtzmfkHArnCGxO9aKwPfThPkRlHdUNi4
         LqowJbZS9aN+5WCIeC4fd1yyVjN75aX+SXb6pHrp8HW2Oq7uj2mSfDmZ7Zpq6cqm4y4Y
         PDgrv9/8KzcZyTxa20tc6G+70grHhJTesKVnhGqLXa0411TnPxDhjnvBZz1z+CaWGFN8
         N17/wQDMNSNb1Y7RDyIAuDjPgOPM51m6xaotSUSyvKYAfE6RC3h8CxYjB5J+Kc4jqthc
         cG9+wUXhSsTEUYEk9HhM5XqlE/XtwUnE4oL98i/JE6PDWdhOc99QVA9VF5ZqsZOeDWno
         snbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M1l2InsDW60perTISjMo8FtRkuEavNFIU5YUduGGtJM=;
        b=Ov7o/BNPJLSIGGV6D9Z78Aiq8A+G9YUSKdsKMi0CefRGJFxGQCiRFwPhdjCwEfKzyZ
         Sj5SuEKrzHxuFDJ2t4nS2p6payHIZ/mJwVG03qSGwclLjxXBf9h3HrtLpcFDMz8cOLqg
         PVi9g9jpoTCNtqDVi/Hoi1iOsedLbudQddFPO+iYBmdswbgLuOTAp1JTmiBaAlOXhNoz
         zVmmeDJ+MFD3mPmGjyvTX2/eAFazems16cCbDc38f1LutyOJLAClZAlHebu+wYVD4C9L
         YJvP6t0EBsqwtQqTj9K9JPZPUvNfeMYGppnYfNF4VHhNSpSSeCD9eaX0E1oaeLFpAehX
         MeNw==
X-Gm-Message-State: AG10YOTVG9lMDQbIsmbxA8Fm9CM5Mdc259pyLDvYvaPj8y5n6bKGIerQwj9qRmjUryM2FA==
X-Received: by 10.98.9.27 with SMTP id e27mr17941617pfd.59.1454262141680;
        Sun, 31 Jan 2016 09:42:21 -0800 (PST)
Received: from ashley.localdomain ([106.51.132.212])
        by smtp.gmail.com with ESMTPSA id v26sm37274012pfi.56.2016.01.31.09.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 09:42:21 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285157>

The current implementation of 'strbuf_split_buf()' includes the
terminator at the end of each strbuf post splitting. Add an option
wherein we can drop the terminator if desired. In this context
introduce a wrapper function 'strbuf_split_str_omit_term()' which
splits a given string into strbufs without including the terminator.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 strbuf.c | 14 +++++++++-----
 strbuf.h | 25 ++++++++++++++++---------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index bab316d..4a93e2a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -115,7 +115,7 @@ void strbuf_tolower(struct strbuf *sb)
 }
 
 struct strbuf **strbuf_split_buf(const char *str, size_t slen,
-				 int terminator, int max)
+				 int terminator, int max, int omit_term)
 {
 	struct strbuf **ret = NULL;
 	size_t nr = 0, alloc = 0;
@@ -123,14 +123,18 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 
 	while (slen) {
 		int len = slen;
+		int copylen = len;
+		const char *end = NULL;
 		if (max <= 0 || nr + 1 < max) {
-			const char *end = memchr(str, terminator, slen);
-			if (end)
+			end = memchr(str, terminator, slen);
+			if (end) {
 				len = end - str + 1;
+				copylen = len - !!omit_term;
+			}
 		}
 		t = xmalloc(sizeof(struct strbuf));
-		strbuf_init(t, len);
-		strbuf_add(t, str, len);
+		strbuf_init(t, copylen);
+		strbuf_add(t, str, copylen);
 		ALLOC_GROW(ret, nr + 2, alloc);
 		ret[nr++] = t;
 		str += len;
diff --git a/strbuf.h b/strbuf.h
index f72fd14..6115e72 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -466,11 +466,12 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 /**
  * Split str (of length slen) at the specified terminator character.
  * Return a null-terminated array of pointers to strbuf objects
- * holding the substrings.  The substrings include the terminator,
- * except for the last substring, which might be unterminated if the
- * original string did not end with a terminator.  If max is positive,
- * then split the string into at most max substrings (with the last
- * substring containing everything following the (max-1)th terminator
+ * holding the substrings.  If omit_term is true, the terminator will
+ * be stripped from all substrings. Otherwise, substrings will include
+ * the terminator, except for the final substring, if the original
+ * string lacked a terminator.  If max is positive, then split the
+ * string into at most max substrings (with the last substring
+ * containing everything following the (max-1)th terminator
  * character).
  *
  * The most generic form is `strbuf_split_buf`, which takes an arbitrary
@@ -481,19 +482,25 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
  * For lighter-weight alternatives, see string_list_split() and
  * string_list_split_in_place().
  */
-extern struct strbuf **strbuf_split_buf(const char *, size_t,
-					int terminator, int max);
+extern struct strbuf **strbuf_split_buf(const char *str, size_t slen,
+					int terminator, int max, int omit_term);
+
+static inline struct strbuf **strbuf_split_str_omit_term(const char *str,
+							    int terminator, int max)
+{
+	return strbuf_split_buf(str, strlen(str), terminator, max, 1);
+}
 
 static inline struct strbuf **strbuf_split_str(const char *str,
 					       int terminator, int max)
 {
-	return strbuf_split_buf(str, strlen(str), terminator, max);
+	return strbuf_split_buf(str, strlen(str), terminator, max, 0);
 }
 
 static inline struct strbuf **strbuf_split_max(const struct strbuf *sb,
 						int terminator, int max)
 {
-	return strbuf_split_buf(sb->buf, sb->len, terminator, max);
+	return strbuf_split_buf(sb->buf, sb->len, terminator, max, 0);
 }
 
 static inline struct strbuf **strbuf_split(const struct strbuf *sb,
-- 
2.7.0
