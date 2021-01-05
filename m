Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D90DC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 06:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E093E22286
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 06:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbhAEGom (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 01:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbhAEGol (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 01:44:41 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50601C061793
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 22:44:01 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x18so15853395pln.6
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 22:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/cFGbfkFlGwulZ8Y7XUn6oRgvuECNCDNEON3zfZNQ7g=;
        b=RZWSdupDZGkZwMlc+6Xh1e5+dPEi3gZfexE7AW3+KY9eT40HngziRVkKO25ubyOiBY
         HYxobsrvtlePgz1mFVYRchEzIMO+YQ6olWIO8QLOX51LEkRcADPgNvDOF6TZ3w5CoIaz
         0T9P3Ro4/MfNpGGoVnDUK5OKEEgWGaZkzIwTP8LgJAzMW+2pjsu6KbRmGT5/RSQ0trho
         kUJ+ehHDfswPk9NTNCi0scXIWM439TARwYEmvhrJ5Hkh3WVWhD4/ZVa2qRkI33hsSCez
         CoX2/K487zua/EzMpzeIhf+kZvXFIMA8a5z9qVbeOG9Lw1GQh2zxAUJwOEHND4cys03u
         KHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/cFGbfkFlGwulZ8Y7XUn6oRgvuECNCDNEON3zfZNQ7g=;
        b=ntVnbRccj2ACMAY3z7SiNFb0Csz9z6qZaq9hFTwDGvy3wULB+rP2h4pJy+fLcrkEtM
         xf2v7nOrcZMKb1WD7wh7FvC2QtAXAKHC9HVtstKKfyKNyAI5ANVuiwSaH526xZg8UEL0
         fXSGTr12+SE9IaEdU37t26bApWo166jqMPLhqy8t3vR1diVxPiv7OQcd28/YPE5S2ikT
         bhRhTeEBo8uFxwTNnFS92G3VeunB7PljgmxZEIwzgFL5I2cpyOLtjsDxZJbC3tz809Vu
         7RB7OaV6oCoJM2hs2o/XvO6/9EQMHrIOTeBVr6WQzOYma4pxxkfKVgv6FYpLXy4nWYaR
         8mqA==
X-Gm-Message-State: AOAM530S6icyzuBojkthlrBgfK3XOiQvzVsBunlHB8xs6q7oKCzg+I/c
        z/9gkrq9AGnYWi7m8b7XOrB2D2X0cw5W+w==
X-Google-Smtp-Source: ABdhPJzOuGv9YNTzFL5Sxzi8Ih5bCOOY99YYqP+7k8iHpU6tm0/VbkQNO+Ye1yt7xkJa9LZI//IH1w==
X-Received: by 2002:a17:90a:1b82:: with SMTP id w2mr2709401pjc.127.1609829040696;
        Mon, 04 Jan 2021 22:44:00 -0800 (PST)
Received: from ADLADL.lan ([103.135.249.72])
        by smtp.gmail.com with ESMTPSA id d8sm1397652pjv.3.2021.01.04.22.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 22:44:00 -0800 (PST)
From:   ZheNing Hu <adlternative@gmail.com>
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>
Subject: [RFC PATCH v1 1/1] strbuf.c/h: add the constant version initialization method of strbuf
Date:   Tue,  5 Jan 2021 14:45:02 +0800
Message-Id: <20210105064502.725307-2-adlternative@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105064502.725307-1-adlternative@gmail.com>
References: <20210105064502.725307-1-adlternative@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 strbuf.c | 33 +++++++++++++++++++++++++++++----
 strbuf.h |  8 ++++++++
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index e3397cc4c7..6e1fd2e628 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -58,17 +58,32 @@ void strbuf_init(struct strbuf *sb, size_t hint)
 		strbuf_grow(sb, hint);
 }
 
+void strbuf_const_to_no_const(struct strbuf *sb)
+{
+	if (sb->len && !sb->alloc) {
+		char *new_buf = xstrdup(sb->buf);
+		int len = sb->len;
+		strbuf_init(sb, sb->len);
+		sb->buf = new_buf;
+		sb->len = len;
+		sb->buf[sb->len] = '\0';
+	}
+}
 void strbuf_release(struct strbuf *sb)
 {
 	if (sb->alloc) {
 		free(sb->buf);
 		strbuf_init(sb, 0);
-	}
+	}else if(sb->len)
+		strbuf_init(sb, 0);
 }
 
 char *strbuf_detach(struct strbuf *sb, size_t *sz)
 {
 	char *res;
+	if (sb->len && !sb->alloc)
+    		die("you should not use detach in a const_strbuf");
+
 	strbuf_grow(sb, 0);
 	res = sb->buf;
 	if (sz)
@@ -89,7 +104,9 @@ void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
 
 void strbuf_grow(struct strbuf *sb, size_t extra)
 {
-	int new_buf = !sb->alloc;
+	int new_buf;
+	strbuf_const_to_no_const(sb);
+	new_buf = !sb->alloc;
 	if (unsigned_add_overflows(extra, 1) ||
 	    unsigned_add_overflows(sb->len, extra + 1))
 		die("you want to use way too much memory");
@@ -108,6 +125,7 @@ void strbuf_trim(struct strbuf *sb)
 
 void strbuf_rtrim(struct strbuf *sb)
 {
+	strbuf_const_to_no_const(sb);
 	while (sb->len > 0 && isspace((unsigned char)sb->buf[sb->len - 1]))
 		sb->len--;
 	sb->buf[sb->len] = '\0';
@@ -115,6 +133,7 @@ void strbuf_rtrim(struct strbuf *sb)
 
 void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
 {
+	strbuf_const_to_no_const(sb);
 	while (sb->len > 0 && is_dir_sep((unsigned char)sb->buf[sb->len - 1]))
 		sb->len--;
 	sb->buf[sb->len] = '\0';
@@ -122,6 +141,7 @@ void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
 
 void strbuf_trim_trailing_newline(struct strbuf *sb)
 {
+	strbuf_const_to_no_const(sb);
 	if (sb->len > 0 && sb->buf[sb->len - 1] == '\n') {
 		if (--sb->len > 0 && sb->buf[sb->len - 1] == '\r')
 			--sb->len;
@@ -131,7 +151,9 @@ void strbuf_trim_trailing_newline(struct strbuf *sb)
 
 void strbuf_ltrim(struct strbuf *sb)
 {
-	char *b = sb->buf;
+	char *b;
+	strbuf_const_to_no_const(sb);
+	b = sb->buf;
 	while (sb->len > 0 && isspace(*b)) {
 		b++;
 		sb->len--;
@@ -158,7 +180,9 @@ int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
 
 void strbuf_tolower(struct strbuf *sb)
 {
-	char *p = sb->buf, *end = sb->buf + sb->len;
+	char *p,*end;
+	strbuf_const_to_no_const(sb);
+	p = sb->buf, end = sb->buf + sb->len;
 	for (; p < end; p++)
 		*p = tolower(*p);
 }
@@ -234,6 +258,7 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
 		die("`pos' is too far after the end of the buffer");
 	if (pos + len > sb->len)
 		die("`pos + len' is too far after the end of the buffer");
+	strbuf_const_to_no_const(sb);
 
 	if (dlen >= len)
 		strbuf_grow(sb, dlen - len);
diff --git a/strbuf.h b/strbuf.h
index 223ee2094a..0bfab0177d 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -72,6 +72,13 @@ struct strbuf {
 extern char strbuf_slopbuf[];
 #define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = strbuf_slopbuf }
 
+#define STRBUF_INIT_CONST(str)  { .alloc = 0, .len = strlen(str), .buf = str }
+
+/*
+ *  Through this function, we can turn a constant buffer into a non-constant buffer
+ */
+void strbuf_const_to_no_const(struct strbuf *sb);
+
 /*
  * Predeclare this here, since cache.h includes this file before it defines the
  * struct.
@@ -159,6 +166,7 @@ void strbuf_grow(struct strbuf *sb, size_t amount);
  */
 static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 {
+	strbuf_const_to_no_const(sb);
 	if (len > (sb->alloc ? sb->alloc - 1 : 0))
 		die("BUG: strbuf_setlen() beyond buffer");
 	sb->len = len;
-- 
2.30.0

