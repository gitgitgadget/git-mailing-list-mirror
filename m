Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8998C47080
	for <git@archiver.kernel.org>; Sun, 23 May 2021 09:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A621D61155
	for <git@archiver.kernel.org>; Sun, 23 May 2021 09:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhEWJzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 05:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbhEWJzC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 05:55:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E96C06138A
        for <git@vger.kernel.org>; Sun, 23 May 2021 02:53:35 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z85-20020a1c7e580000b029017a76f3afbaso6902766wmc.2
        for <git@vger.kernel.org>; Sun, 23 May 2021 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L2czlVqpq2JqbESLOu8qgFb96QiNnwLZgPHinypE6Tg=;
        b=lfNp763a06tbhCLAxh68P6E4N7Bm+sJMq/fYbFexpIXAy/0yJ1+VkwirA73nwXx89b
         fA9DcdLBabSeIisGxFX+XCrHlY24XznU+sRsV5ZvDOPOemXOKXNmLei84scq5VQwnCn7
         BGkc3HmJrDQXmqLtvQ8BWSMtEqUJLLd8MdfQHpJ1wuRzU6P7zViXMmybre4j2hyO4tni
         czfGZWtmx90CrHDbTbzEaxHk5mKN1RqxoPHXbFEALF/vyjbPlec/S8iYd8KHUcVjnTss
         wwovtRoHPfkqnWcvpIeXzK/gY4rhrKju9LR24KTWfuS7bH/qwtDgS4Pp/tjDEZg3Jzxd
         dNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L2czlVqpq2JqbESLOu8qgFb96QiNnwLZgPHinypE6Tg=;
        b=NZ66k91KzTg9bH1UUDN4rcCvYHf1PrNsKfsIfLZCQjBKVvA3V1WEuOOmCtgqaXooH/
         zRMKwRXAJI/OLGS5Ey4qX8OghpUk2pMmxlDFitUFhX5AXBiBYyejOf2KAJatidJKb1mZ
         nWae2SNEgWYtpOWCu/99plVDf8XdHvogQXu+ewfJIKlMlwkgDafMnNxiRmBEYW7NVUJH
         89NVlw8Pn33wnY/rl1iSN3JQ4to+BbC/HNvrpxdxLAAW8Uud7tTgAidd6rAqIKFmcSMj
         wCmd0L2mkI/5jlmR5m22RCDuTa1H+GcIkHbn36/J3APb8ppEEQFDSgKlRPC0+Vto3FlC
         GIjg==
X-Gm-Message-State: AOAM532ygsyQlms4gmUuynof9q2Ub0SLm0x9KR7T2zDT0XkxF+cB4FdQ
        ZgFwJ/fofYnsueSd0c+a5igPHNDoPkE=
X-Google-Smtp-Source: ABdhPJwavHf2TUE7dXudmbEAJM0/rbxCTUiNld9gsz65fNyuAvolDzqBnGRm9m2NNdhu7WgPYgO0pA==
X-Received: by 2002:a7b:c304:: with SMTP id k4mr16090956wmj.68.1621763614425;
        Sun, 23 May 2021 02:53:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18sm8316321wro.33.2021.05.23.02.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 02:53:34 -0700 (PDT)
Message-Id: <f7121bdc4d8d8ac0071e6410960fd8787b0c36ae.1621763612.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.959.git.1621763612.gitgitgadget@gmail.com>
References: <pull.959.git.1621763612.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 23 May 2021 09:53:30 +0000
Subject: [PATCH 1/3] [GSOC] quote: add *.quote_buf_with_size functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

With the original functions `*._quote_buf()`, there may be
'\0' in our source string, only the content before the first '\0'
will be processed and added to the buffer.

Add `perl_quote_buf_with_size()`, `python_quote_buf_with_size()`,
`tcl_quote_buf_with_size`,`sq_quote_buf_with_size()` to
`quote.c`, they will process the source string with specified
length characters. With them, the content after '\0' will not
be truncated.

This will help us add binary data containing '\0' to
`quote_formatting()` in `ref-filter.c`.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 quote.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 quote.h |   4 ++
 2 files changed, 120 insertions(+)

diff --git a/quote.c b/quote.c
index 8a3a5e39eb12..9a1d9dde1fdb 100644
--- a/quote.c
+++ b/quote.c
@@ -43,6 +43,39 @@ void sq_quote_buf(struct strbuf *dst, const char *src)
 	free(to_free);
 }
 
+void sq_quote_buf_with_size(struct strbuf *dst, const char *src, size_t size)
+{
+	char *to_free = NULL;
+	size_t cur_size = 0;
+
+	if (dst->buf == src)
+		to_free = strbuf_detach(dst, NULL);
+
+	strbuf_addch(dst, '\'');
+	while (cur_size < size) {
+		size_t len = strcspn(src, "'!");
+		if (!len) {
+			strbuf_add(dst, src, 1);
+			src++;
+			cur_size++;
+		} else {
+			strbuf_add(dst, src, len);
+			src += len;
+			cur_size += len;
+		}
+		if (cur_size >= size)
+			break;
+		while (need_bs_quote(*src)) {
+			strbuf_addstr(dst, "'\\");
+			strbuf_addch(dst, *src++);
+			cur_size++;
+			strbuf_addch(dst, '\'');
+		}
+	}
+	strbuf_addch(dst, '\'');
+	free(to_free);
+}
+
 void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
 {
 	static const char ok_punct[] = "+,-./:=@_^";
@@ -471,6 +504,25 @@ void perl_quote_buf(struct strbuf *sb, const char *src)
 	strbuf_addch(sb, sq);
 }
 
+void perl_quote_buf_with_size(struct strbuf *sb, const char *src, size_t size)
+{
+	const char sq = '\'';
+	const char bq = '\\';
+	char c;
+	size_t cur_size = 0;
+
+	strbuf_addch(sb, sq);
+	while (cur_size < size) {
+		c = *src++;
+		cur_size++;
+
+		if (c == sq || c == bq)
+			strbuf_addch(sb, bq);
+		strbuf_addch(sb, c);
+	}
+	strbuf_addch(sb, sq);
+}
+
 void python_quote_buf(struct strbuf *sb, const char *src)
 {
 	const char sq = '\'';
@@ -492,6 +544,31 @@ void python_quote_buf(struct strbuf *sb, const char *src)
 	strbuf_addch(sb, sq);
 }
 
+void python_quote_buf_with_size(struct strbuf *sb, const char *src, size_t size)
+{
+	const char sq = '\'';
+	const char bq = '\\';
+	const char nl = '\n';
+	char c;
+	size_t cur_size = 0;
+
+	strbuf_addch(sb, sq);
+	while (cur_size < size) {
+		c = *src++;
+		cur_size++;
+
+		if (c == nl) {
+			strbuf_addch(sb, bq);
+			strbuf_addch(sb, 'n');
+			continue;
+		}
+		if (c == sq || c == bq)
+			strbuf_addch(sb, bq);
+		strbuf_addch(sb, c);
+	}
+	strbuf_addch(sb, sq);
+}
+
 void tcl_quote_buf(struct strbuf *sb, const char *src)
 {
 	char c;
@@ -527,6 +604,45 @@ void tcl_quote_buf(struct strbuf *sb, const char *src)
 	strbuf_addch(sb, '"');
 }
 
+void tcl_quote_buf_with_size(struct strbuf *sb, const char *src, size_t size)
+{
+	char c;
+	size_t cur_size = 0;
+
+	strbuf_addch(sb, '"');
+	while (cur_size < size) {
+		c = *src++;
+		cur_size++;
+
+		switch (c) {
+		case '[': case ']':
+		case '{': case '}':
+		case '$': case '\\': case '"':
+			strbuf_addch(sb, '\\');
+			/* fallthrough */
+		default:
+			strbuf_addch(sb, c);
+			break;
+		case '\f':
+			strbuf_addstr(sb, "\\f");
+			break;
+		case '\r':
+			strbuf_addstr(sb, "\\r");
+			break;
+		case '\n':
+			strbuf_addstr(sb, "\\n");
+			break;
+		case '\t':
+			strbuf_addstr(sb, "\\t");
+			break;
+		case '\v':
+			strbuf_addstr(sb, "\\v");
+			break;
+		}
+	}
+	strbuf_addch(sb, '"');
+}
+
 void basic_regex_quote_buf(struct strbuf *sb, const char *src)
 {
 	char c;
diff --git a/quote.h b/quote.h
index 768cc6338e27..e894507329cc 100644
--- a/quote.h
+++ b/quote.h
@@ -30,6 +30,7 @@ struct strbuf;
  */
 
 void sq_quote_buf(struct strbuf *, const char *src);
+void sq_quote_buf_with_size(struct strbuf *, const char *src, size_t size);
 void sq_quote_argv(struct strbuf *, const char **argv);
 void sq_quotef(struct strbuf *, const char *fmt, ...);
 
@@ -94,8 +95,11 @@ char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigne
 
 /* quoting as a string literal for other languages */
 void perl_quote_buf(struct strbuf *sb, const char *src);
+void perl_quote_buf_with_size(struct strbuf *sb, const char *src, size_t size);
 void python_quote_buf(struct strbuf *sb, const char *src);
+void python_quote_buf_with_size(struct strbuf *sb, const char *src, size_t size);
 void tcl_quote_buf(struct strbuf *sb, const char *src);
+void tcl_quote_buf_with_size(struct strbuf *sb, const char *src, size_t size);
 void basic_regex_quote_buf(struct strbuf *sb, const char *src);
 
 #endif
-- 
gitgitgadget

