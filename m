Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC10C34035
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 04:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181E420801
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 04:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLNHSIXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgBRESX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 23:18:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39585 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgBRESW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 23:18:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so22179223wrt.6
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 20:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K5Eo6kI2dusgJ1d+aJBcJF92Di8Nhbs37wL7DCksAC4=;
        b=fLNHSIXSYLOBTZL7c8QNgrQ+ZoNa6AYD+Hhe1GdUfTfaPRfq+fye7LJcpoSRNnKd0K
         zsDuRhWgdw7pTrCjwOULuNW8F28VDwYR6kCKtsp8G9rKuXBk4R4dUGqME5fAMC6np6kI
         Axm03iW6JK8Yhd9FNrpJn/zt9lOJCOGmJ4Dzim8bzCj2htWRvyEYwWyvS+d7/ivgOOpn
         TugSqPkHKnisXE9oxd1Xi83wOJKtad4shIZj2BlUxvKZbpAAokhwOIOItpBJi1omPDvK
         xufTo+JZE4R/oJ3poGq7YuW+/7NC/0xXLA9W4u75vL05/wDAKofEK0wkzSJDt1f0ploS
         GDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K5Eo6kI2dusgJ1d+aJBcJF92Di8Nhbs37wL7DCksAC4=;
        b=mUpbiMLlt5MKqTZkbR9dE1bF3dxuxI30rZkFvoyTL/2jeBSUVFvBBZA7MhZPPLh6G3
         up3ovCDcv9LiS0GksuGzNjEzSDOu9WDZYBj+h4E2JkubWJAC9HGpm1F578+aBK5it7S9
         tow7grcP+mdVrvrlqceqaEt1e0Mdyjmw1K0UI0JeXSTIu9wJ03zacwd+d0nafzO7vqAI
         bKK1Ix/aI9TkHR6NLdnBVIkdHfpAk1+jSQRT0Y064OzPbPs+KX3Q96BwjuMY05vtn1ds
         1kdemUzCaAZFRzsiDLK+mPBvSpZY1HsUsToV0SMrBPuhQ5j2fwh2ghDRQv/dq4iofDsb
         PHPw==
X-Gm-Message-State: APjAAAUqeC62OnNMjsOHLPXrOqw1g2I32l3+AcQa0ucBIf2RDUGV5gIF
        lneAoIkj7o7+R1PQrjYbe4GhcsT6S9SPne1R
X-Google-Smtp-Source: APXvYqw/qkQD7IZBawy4E8qJD94O6fKUpoHLDbksCJZif27EOB7tSu0dJH9Z2cvwk5grZATvJcZJAw==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr27911632wrx.153.1581999499201;
        Mon, 17 Feb 2020 20:18:19 -0800 (PST)
Received: from localhost.localdomain ([41.234.233.158])
        by smtp.gmail.com with ESMTPSA id k16sm4228083wru.0.2020.02.17.20.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 20:18:18 -0800 (PST)
From:   Robear Selwans <rwagih.rw@gmail.com>
X-Google-Original-From: Robear Selwans <robear.selwans@outlook.com>
To:     git@vger.kernel.org
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [GSoC][RFC][PATCH 2/2] STRBUF_INIT_CONST: Adapting strbuf_* functions
Date:   Tue, 18 Feb 2020 04:18:05 +0000
Message-Id: <20200218041805.10939-3-robear.selwans@outlook.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200218041805.10939-1-robear.selwans@outlook.com>
References: <20200218041805.10939-1-robear.selwans@outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a previous commit, a new function `STRBUF_INIT_CONST(const_str)`,
which would allow for the quick initialization of constant `strbuf`s,
was introduced.

In this commit, I check through the strbuf_* functions to edit the ones
that would try to edit the passed `strbuf` so that they are guaranteed to
behave in a predictable way when met with a constant.

Added Functions:
    `strbuf_make_var`

Updated Functions:
    `strbuf_grow`
    `strbuf_setlen`
    `strbuf_trim`
    `strbuf_trim_trailing_dir_sep`
    `strbuf_trim_trailing_newline`
    `strbuf_tolower`
    `strbuf_splice`

Functions where comments were added to clarify the expected behavior:
    `strbuf_getcwd`

Signed-off-by: Robear Selwans <robear.selwans@outlook.com>
---
 strbuf.c | 25 +++++++++++++++++++++++++
 strbuf.h | 14 ++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index f19da55b07..48af039b6e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -89,6 +89,8 @@ void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
 
 void strbuf_grow(struct strbuf *sb, size_t extra)
 {
+	if (sb->len > sb->alloc)
+		strbuf_make_var(sb);
 	int new_buf = !sb->alloc;
 	if (unsigned_add_overflows(extra, 1) ||
 	    unsigned_add_overflows(sb->len, extra + 1))
@@ -100,8 +102,18 @@ void strbuf_grow(struct strbuf *sb, size_t extra)
 		sb->buf[0] = '\0';
 }
 
+void strbuf_make_var(struct strbuf *sb)
+{
+	char* str_cpy;
+	ALLOC_ARRAY(str_cpy, sb->len + 1);
+	memcpy(str_cpy, sb->buf, sb->len);
+	strbuf_attach(sb, str_cpy, sb->len, sb->len + 1);
+}
+
 void strbuf_trim(struct strbuf *sb)
 {
+	if (sb->len > sb->alloc)
+		strbuf_make_var(sb);
 	strbuf_rtrim(sb);
 	strbuf_ltrim(sb);
 }
@@ -115,6 +127,8 @@ void strbuf_rtrim(struct strbuf *sb)
 
 void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
 {
+	if (sb->len > sb->alloc)
+		strbuf_make_var(sb);
 	while (sb->len > 0 && is_dir_sep((unsigned char)sb->buf[sb->len - 1]))
 		sb->len--;
 	sb->buf[sb->len] = '\0';
@@ -122,6 +136,9 @@ void strbuf_trim_trailing_dir_sep(struct strbuf *sb)
 
 void strbuf_trim_trailing_newline(struct strbuf *sb)
 {
+	if (sb->buf[sb->len - 1] == '\n')
+		if (sb->len > sb->alloc)
+			strbuf_make_var(sb);
 	if (sb->len > 0 && sb->buf[sb->len - 1] == '\n') {
 		if (--sb->len > 0 && sb->buf[sb->len - 1] == '\r')
 			--sb->len;
@@ -158,6 +175,8 @@ int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
 
 void strbuf_tolower(struct strbuf *sb)
 {
+	if (sb->len > sb->alloc)
+		strbuf_make_var(sb);
 	char *p = sb->buf, *end = sb->buf + sb->len;
 	for (; p < end; p++)
 		*p = tolower(*p);
@@ -234,6 +253,8 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
 		die("`pos' is too far after the end of the buffer");
 	if (pos + len > sb->len)
 		die("`pos + len' is too far after the end of the buffer");
+	if (sb->len > sb->alloc)
+		strbuf_make_var(sb);
 
 	if (dlen >= len)
 		strbuf_grow(sb, dlen - len);
@@ -572,6 +593,10 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
 
 int strbuf_getcwd(struct strbuf *sb)
 {
+	/*
+	 * If sb was a constant, then an error would lead to 
+	 * strbuf_release() being called on the sb.
+	 */
 	size_t oldalloc = sb->alloc;
 	size_t guessed_len = 128;
 
diff --git a/strbuf.h b/strbuf.h
index 1a1753424c..a33bc4d90e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -128,6 +128,10 @@ static inline void strbuf_swap(struct strbuf *a, struct strbuf *b)
 	SWAP(*a, *b);
 }
 
+/**
+ * Constant string buffer is turned into a variable one.
+ */
+void strbuf_make_var(struct strbuf *sb);
 
 /**
  * Functions related to the size of the buffer
@@ -160,6 +164,16 @@ void strbuf_grow(struct strbuf *sb, size_t amount);
  */
 static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 {
+	if (sb->len > sb->alloc)
+	{
+		if (!len)
+		{
+			sb->buf = strbuf_slopbuf;
+			return;
+		}
+		else
+			strbuf_make_var(sb);
+	}
 	if (len > (sb->alloc ? sb->alloc - 1 : 0))
 		die("BUG: strbuf_setlen() beyond buffer");
 	sb->len = len;
-- 
2.17.1

