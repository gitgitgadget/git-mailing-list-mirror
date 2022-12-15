Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB77C00145
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiLOJL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiLOJLY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:11:24 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC982AE03
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:11:22 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h10so2356282wrx.3
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZTFFb1dffd99B1a97mLIYawUwX7lmGi5sVbF0X8A6o=;
        b=HW1rF1YS1l0alakwKYidK4rduCMu90mht43GAE+LZydkqXJQBcGcqd2Fd8wc2DAXex
         7+PcxysUSo8LiVeXRH+DAoEarG6nOIQ6Blokay9XsseFFb+WnNpKpCvPML/WkI/qTatI
         B1Q8UJwWHH/XnDRsTj3XTAuNT7zP456GCF1vdSAv+a9ItR0/LU51fXNOd90hz/nS/OU1
         O9JmOZeuAWUvmT5CgWIRjWO3FM7xolyXwy0C/HljHDVQVfgg6G0STPJGKBbwYChXW36t
         N8xkDZ/CHHwglsBWxVD3k1csO7PLaskOdkv5XVZxmj7kKlXLwjLNKQSMfy/Qfj4mrpdU
         uChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZTFFb1dffd99B1a97mLIYawUwX7lmGi5sVbF0X8A6o=;
        b=wD5Pc5Z4A4ex72hwYKEvigXqmhBmZOLIIbhQthQXzy8gWHpowZp2Inf4Vz+/f9Ckn2
         m4hZWkUf61f10ntevH+OwlmHyTE/TheonMtM6h2BhW9OM6EHj/RhmKxUGWxnw3C+LMS/
         dtKqxTVdn0+tFAVKP5PO+czDGcjR0a76Q9hi5RDSbGXdMC6+VWoRUKrpIZlSln8ivm7o
         gz2/HKOrryr4KdUDf0e+5jPpgTG/yUndLCTh/wsa64luC2PAX0KyocVd3FpUdPDHPjth
         toLci+uPSMPOOA3W9I3GYuVkb9QTJozsfTAfVq+QSLJoC/NfnkGrx09TUetDVsZoZk8x
         m9yQ==
X-Gm-Message-State: ANoB5pkErZLR88Pp4Xka8v10vXP6ge/tZ3IWCbLqxjaMnhCEJkpHARsm
        SXO6wM34R/kLToinvgH7cXcUARCoSYGcDw==
X-Google-Smtp-Source: AA0mqf7FfkavqQtZsK52RFnOl3/GXkis6lV4RsCx4JGVwvl47hhXT0ZHWvga/1w7q2HsCmOBriWmbw==
X-Received: by 2002:a5d:4e03:0:b0:242:37e3:1747 with SMTP id p3-20020a5d4e03000000b0024237e31747mr16335820wrt.21.1671095480792;
        Thu, 15 Dec 2022 01:11:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000024700b002366f9bd717sm6193835wrz.45.2022.12.15.01.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:11:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 3/5] strvec API: add a "STRVEC_INIT_NODUP"
Date:   Thu, 15 Dec 2022 10:11:09 +0100
Message-Id: <RFC-patch-3.5-16c20baf5ec-20221215T090226Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
References: <221214.86ilie48cv.gmgdl@evledraar.gmail.com> <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have various tricky cases where we'll leak a "struct strvec" even
when we call strvec_clear(), these happen because we'll call
setup_revisions(), parse_options() etc., which will munge our "v"
member.

There's various potential ways to deal with that, see the extensive
on-list discussion at [1]. One way would be to pass a flag to ask the
underlying API to free() these, as was done for setup_revisions() in
[2].

But we don't need that complexity for many common cases, which are
pushing fixed strings to the "struct strvec". Let's instead add a flag
analogous to the "strdup_strings" flag in the "struct string_list". A
subsequent commit will make use of this API.

Implementation notes: The BUG_unless_dup() is implemented as a macro
so we'll report the correct line number on BUG(). The "nodup_strings"
flag could have been named a "strdup_strings" for consistency with the
"struct string_list" API, but to do so we'd have to be confident that
we've spotted all callers that assume that they can memset() a "struct
strvec" to zero.

1. https://lore.kernel.org/git/221214.86ilie48cv.gmgdl@evledraar.gmail.com/
2. f92dbdbc6a8 (revisions API: don't leak memory on argv elements that
   need free()-ing, 2022-08-02)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 strvec.c | 20 ++++++++++++++++++--
 strvec.h | 30 +++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/strvec.c b/strvec.c
index 61a76ce6cb9..721f8e94a50 100644
--- a/strvec.c
+++ b/strvec.c
@@ -10,6 +10,16 @@ void strvec_init(struct strvec *array)
 	memcpy(array, &blank, sizeof(*array));
 }
 
+void strvec_init_nodup(struct strvec *array)
+{
+	struct strvec blank = STRVEC_INIT_NODUP;
+	memcpy(array, &blank, sizeof(*array));
+}
+
+#define BUG_unless_dup(array, fn) \
+	if ((array)->nodup_strings) \
+		BUG("cannot %s() on a 'STRVEC_INIT_NODUP' strvec", (fn))
+
 static void strvec_push_nodup(struct strvec *array, const char *value)
 {
 	if (array->v == empty_strvec)
@@ -22,7 +32,9 @@ static void strvec_push_nodup(struct strvec *array, const char *value)
 
 const char *strvec_push(struct strvec *array, const char *value)
 {
-	strvec_push_nodup(array, xstrdup(value));
+	const char *to_push = array->nodup_strings ? value : xstrdup(value);
+
+	strvec_push_nodup(array, to_push);
 	return array->v[array->nr - 1];
 }
 
@@ -31,6 +43,8 @@ const char *strvec_pushf(struct strvec *array, const char *fmt, ...)
 	va_list ap;
 	struct strbuf v = STRBUF_INIT;
 
+	BUG_unless_dup(array, "strvec_pushf");
+
 	va_start(ap, fmt);
 	strbuf_vaddf(&v, fmt, ap);
 	va_end(ap);
@@ -67,6 +81,8 @@ void strvec_pop(struct strvec *array)
 
 void strvec_split(struct strvec *array, const char *to_split)
 {
+	BUG_unless_dup(array, "strvec_pushf");
+
 	while (isspace(*to_split))
 		to_split++;
 	for (;;) {
@@ -89,7 +105,7 @@ void strvec_clear(struct strvec *array)
 {
 	if (array->v != empty_strvec) {
 		int i;
-		for (i = 0; i < array->nr; i++)
+		for (i = 0; !array->nodup_strings && i < array->nr; i++)
 			free((char *)array->v[i]);
 		free(array->v);
 	}
diff --git a/strvec.h b/strvec.h
index 9f55c8766ba..b122b87b369 100644
--- a/strvec.h
+++ b/strvec.h
@@ -26,29 +26,51 @@ extern const char *empty_strvec[];
  * member contains the actual array; the `nr` member contains the
  * number of elements in the array, not including the terminating
  * NULL.
+ *
+ * When using `STRVEC_INIT_NODUP` to initialize it the `nodup_strings'
+ * member is set, and individual members of the "struct strvec" will
+ * not be free()'d by strvec_clear(). This is for fixed string
+ * arguments to parse_options() and others that might munge the "v"
+ * itself.
  */
 struct strvec {
 	const char **v;
 	size_t nr;
 	size_t alloc;
+	unsigned int nodup_strings:1;
 };
 
 #define STRVEC_INIT { \
 	.v = empty_strvec, \
 }
 
+#define STRVEC_INIT_NODUP { \
+	.v = empty_strvec, \
+	.nodup_strings = 1, \
+}
+
 /**
  * Initialize an array. This is no different than assigning from
  * `STRVEC_INIT`.
  */
 void strvec_init(struct strvec *);
 
+/**
+ * Initialize a "nodup" array. This is no different than assigning from
+ * `STRVEC_INIT_NODUP`.
+ */
+void strvec_init_nodup(struct strvec *);
+
 /* Push a copy of a string onto the end of the array. */
 const char *strvec_push(struct strvec *, const char *);
 
 /**
  * Format a string and push it onto the end of the array. This is a
  * convenience wrapper combining `strbuf_addf` and `strvec_push`.
+ *
+ * This is incompatible with arrays initialized with
+ * `STRVEC_INIT_NODUP`, as pushing the formatted string requires the
+ * equivalent of an xstrfmt().
  */
 __attribute__((format (printf,2,3)))
 const char *strvec_pushf(struct strvec *, const char *fmt, ...);
@@ -70,7 +92,13 @@ void strvec_pushv(struct strvec *, const char **);
  */
 void strvec_pop(struct strvec *);
 
-/* Splits by whitespace; does not handle quoted arguments! */
+/**
+ * Splits by whitespace; does not handle quoted arguments!
+ *
+ * This is incompatible with arrays initialized with
+ * `STRVEC_INIT_NODUP`, as pushing the elements requires an xstrndup()
+ * call.
+ */
 void strvec_split(struct strvec *, const char *);
 
 /**
-- 
2.39.0.rc2.1048.g0e5493b8d5b

