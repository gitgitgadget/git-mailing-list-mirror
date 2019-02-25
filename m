Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 005C620248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfBYXQw (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:16:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34264 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfBYXQu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:16:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so11858836wrg.1
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+oUxf/nAiW1PAlHzb7QLdLQw2pO7YnsWgHBedcw/KK8=;
        b=nyOBHl76DjTdBvj9FtzZV7C/ZfPP8npgm2a/ezcrvgZdNTXqVyhEqmQ0AHYPxfZZUt
         SinvYuFVNPy9DK6xPu7e17HAqh12Wa7atFkueXAAIRI2yg7jremuARbipOfL3WoVEJIB
         i7CvXpHzyjBS6wQW+Joy6+q7ebs7Ja4b4+gbOJIpc865MOhKu/PkgEkgEXq7CaEZf1VG
         r5dZU+1KQ4d0cVssUB4p0/N8/+0DxvlThjXmdK9fG3HoPsCgFk8P49l5q3dGnyC6EuhE
         Ykv31BXyqKMRDRDDsBvZAZHrIzsLzqiTvhb2xC09+C2AI6cJSThV8wsp8jNzS5Fic5Rh
         3I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+oUxf/nAiW1PAlHzb7QLdLQw2pO7YnsWgHBedcw/KK8=;
        b=hY1TB6pHRz2w9gPTSAKplTuJqJ/l+UFjVUQ2d5GjZo8BVBAbx1P4WJOAW5Yu3LxJ73
         lFX/pj6TkKMl/MEinuIQBz4x1QxTpHvXA1hsp+4ta4LZFvV9Paexs5TePwXv1WP6JDnA
         RzOOHk1GK4wLD3XVhLbTLuFXqQlBvOrkd1ujUJ9rjeFbjSUgyJ1Ar/GY+U5FpQ47CHy7
         6tZCV51BnFfxAkBCjmAWdvGpKholyG8qXTgXnHYxNK7n6L91jegA09hBjyrm2vtl2Oim
         T2y/qhiHlXtUXoM1JQQKrW4QPU7sHcwLwFcQZEBCRZl/mu1lAES5sY0qt4MDkgS8CoBp
         H7mQ==
X-Gm-Message-State: AHQUAuYUACyVISKrR38mTHY4QRyND3wxNTHspjhXPD8u+o+40iV+5V7W
        F8LZYWwwqtS53fzxTF4E+3lRjEVJ
X-Google-Smtp-Source: AHgI3IZYKZbVxFvoSZWMRNGLxOiC0GXPQ41Vo98+N3aFlf4wAjbEzX+dL7w8saTaE5baVkN4IG4PyQ==
X-Received: by 2002:adf:c3c5:: with SMTP id d5mr13650487wrg.308.1551136608209;
        Mon, 25 Feb 2019 15:16:48 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id d21sm32757481wrc.44.2019.02.25.15.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:16:47 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 02/27] strbuf.c: add `strbuf_join_argv()`
Date:   Mon, 25 Feb 2019 23:16:06 +0000
Message-Id: <20190225231631.30507-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

Implement `strbuf_join_argv()` to join arguments
into a strbuf.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 strbuf.c | 15 +++++++++++++++
 strbuf.h |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index f6a6cf78b9..82e90f1dfe 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -268,6 +268,21 @@ void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
 	strbuf_setlen(sb, sb->len + sb2->len);
 }
 
+const char *strbuf_join_argv(struct strbuf *buf,
+			     int argc, const char **argv, char delim)
+{
+	if (!argc)
+		return buf->buf;
+
+	strbuf_addstr(buf, *argv);
+	while (--argc) {
+		strbuf_addch(buf, delim);
+		strbuf_addstr(buf, *(++argv));
+	}
+
+	return buf->buf;
+}
+
 void strbuf_addchars(struct strbuf *sb, int c, size_t n)
 {
 	strbuf_grow(sb, n);
diff --git a/strbuf.h b/strbuf.h
index fc40873b65..be02150df3 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -288,6 +288,13 @@ static inline void strbuf_addstr(struct strbuf *sb, const char *s)
  */
 void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2);
 
+/**
+ * Join the arguments into a buffer. `delim` is put between every
+ * two arguments.
+ */
+const char *strbuf_join_argv(struct strbuf *buf, int argc,
+			     const char **argv, char delim);
+
 /**
  * This function can be used to expand a format string containing
  * placeholders. To that end, it parses the string and calls the specified
-- 
2.21.0.rc2.291.g17236886c5

