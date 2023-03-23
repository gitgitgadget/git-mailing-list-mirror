Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB003C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 17:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjCWR0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 13:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjCWR0b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 13:26:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61AA26C33
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 10:26:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y4so90095792edo.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1679592365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMAFIzFsBhK6Et9opctAfAiAe2Fq0uojm77c1NQsO0U=;
        b=oxQYLMOWoKNQn40n+WB1bBirgzggEUUXHXMOaeQP8PSLi/ANW/Zq56R5fKVd5ikadx
         qF4K1rl6wxxYTCKucL9X0fvYIVWIEGxI29CEJHd5gh9jGjmwpugXgbAuJl0POPWV0DPQ
         LdcUYb2RQVGEUmO4mDHnP/jwT59DY6nKy6S5CsKR7cOfTnGxjjEEXKEfzS4ahJwI0l2p
         cxEm9XYS7+rmnj2avBciygGaYiPHNXkyE6JuIy3RobLgbTJjCC37x7TJgUcBavhTXaXW
         YtowcIZQWOTVlk+zGGCxNF69ZTJPk8i5cXyrxNqvJLkmSbPuWcOL1mcpkJFF6c2JKGMS
         0UUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679592365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMAFIzFsBhK6Et9opctAfAiAe2Fq0uojm77c1NQsO0U=;
        b=KouSZcT5/OXTSlZuNnNwhbxcOMusm0AfPr557K9zgek4aFaxXHOM+Khx/euHM7cq1S
         fSNqfWAalMLauOtt+U3YC6hFS1Ttd5OTqjR4NBv3iRvfScmyLxo29kdLtpFYJ2E5fms/
         32au0aEdUwkFhDVkmwoECE+8l9/QvQM+gMDQsxmJoahJ64JMq5HQqHZ2rGp4MULRHe+k
         G6GrLJbiKUITGXpA7yaPlD1VULYBq+PRf3OZ3w6ztlr0c9HgbbseTl9JPrQekst4KbrO
         VwHiG3h5zQC0PAkrQe/dI/R6xRQUaDq3nP2u+1mKaQTUu+XrTr96iGh7Tgy9SlGDfUGP
         1jZw==
X-Gm-Message-State: AO0yUKXZVaKJdfX0G1FsvZPwTnkNDKg+ABPqhhFj/LLgLX3nKBzWr1nE
        4TfYnm5b6o0cwiKr86j8RiCkBphb8yphn1d8tBU=
X-Google-Smtp-Source: AK7set/NOmv+xNhXIj1z4dSDXViEf2lFDrYISS230HnqnMwIXHB6jrgvfdHP6YE+/WYRBlcnYVtEsQ==
X-Received: by 2002:a17:907:2090:b0:921:7e42:2777 with SMTP id pv16-20020a170907209000b009217e422777mr14113701ejb.69.1679592365273;
        Thu, 23 Mar 2023 10:26:05 -0700 (PDT)
Received: from x1.fritz.box (p200300f6af156c006b24c65af1cba60f.dip0.t-ipconnect.de. [2003:f6:af15:6c00:6b24:c65a:f1cb:a60f])
        by smtp.gmail.com with ESMTPSA id d7-20020a1709067f0700b00882f9130eafsm8867400ejr.26.2023.03.23.10.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:26:04 -0700 (PDT)
From:   Mathias Krause <minipli@grsecurity.net>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Mathias Krause <minipli@grsecurity.net>,
        Stephane Odul <stephane@clumio.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] grep: work around UTF-8 related JIT bug in PCRE2 <= 10.34
Date:   Thu, 23 Mar 2023 18:25:39 +0100
Message-Id: <20230323172539.25230-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323144000.21146-1-minipli@grsecurity.net>
References: <20230323144000.21146-1-minipli@grsecurity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephane is reporting[1] a regression introduced in git v2.40.0 that leads
to 'git grep' segfaulting in his CI pipeline. It turns out, he's using an
older version of libpcre2 that triggers a wild pointer dereference in
the generated JIT code that was fixed in PCRE2 10.35.

Instead of completely disabling the JIT compiler for the buggy version,
just mask out the Unicode property handling as we used to do prior to
commit acabd2048ee0 ("grep: correctly identify utf-8 characters with
\{b,w} in -P").

[1] https://lore.kernel.org/git/7E83DAA1-F9A9-4151-8D07-D80EA6D59EEA@clumio.com/

Reported-by: Stephane Odul <stephane@clumio.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
v2:
- make PCRE2_UCP masking depend only on the PCRE2 version, as
  suggested by Junio

 grep.c | 9 +++++++++
 grep.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/grep.c b/grep.c
index cee44a78d044..dcfa7a27bf88 100644
--- a/grep.c
+++ b/grep.c
@@ -320,6 +320,15 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	if (!opt->ignore_locale && is_utf8_locale() && !literal)
 		options |= (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALID_UTF);
 
+#ifndef GIT_PCRE2_VERSION_10_35_OR_HIGHER
+	/*
+	 * Work around a JIT bug related to invalid Unicode character handling
+	 * fixed in 10.35:
+	 * https://github.com/PCRE2Project/pcre2/commit/c21bd977547d
+	 */
+	options &= ~PCRE2_UCP;
+#endif
+
 #ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
 	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
 	if (PCRE2_MATCH_INVALID_UTF && options & (PCRE2_UTF | PCRE2_CASELESS))
diff --git a/grep.h b/grep.h
index 6075f997e68f..c59592e3bdba 100644
--- a/grep.h
+++ b/grep.h
@@ -7,6 +7,9 @@
 #if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 36) || PCRE2_MAJOR >= 11
 #define GIT_PCRE2_VERSION_10_36_OR_HIGHER
 #endif
+#if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 35) || PCRE2_MAJOR >= 11
+#define GIT_PCRE2_VERSION_10_35_OR_HIGHER
+#endif
 #if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 34) || PCRE2_MAJOR >= 11
 #define GIT_PCRE2_VERSION_10_34_OR_HIGHER
 #endif
-- 
2.39.2

