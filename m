Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11074C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C1164F74
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhBCDaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhBCD3r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:47 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7C8C0617A7
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:29 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l12so3138079wmq.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cfc9HKftHNiMcn9e6q5gY0WzMkB21tulNMrnFpqEr90=;
        b=W7er2G6McWac8hR9BybvPSHZX4E7K6JfMKIosQn6m6th1gsDi39HVdfYdsh0PiV8NY
         eSUOaCcbvP7EZiRcV/ZvKEjioCzvosvqz+cJmrH2KQ06PvlcaGCjBJ9k6n10zGuNX/TO
         rNN1yesQEwQnAaURDSpsgp5FJBfxevO8t54jRrZGeCdLo58auThz38ZwxqZrUbloI0PB
         ydWh2rD/xjRtBTqkJt0ApXMgFgq1vWFp2sVLwYBQJFs8agZ0DSrwv7ALrxF/OBeqg5yJ
         1Ar1ADzTrjPIdE4aHRvKBTDQXQ3mSqEEstAt7DfC0y18YsdMHLkMNGzR11T5vEgyJfEJ
         hYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cfc9HKftHNiMcn9e6q5gY0WzMkB21tulNMrnFpqEr90=;
        b=JkPXN35+enGLS5rkatK1kVmFGpNaV6YflZhAL9G2h3JQBuaQF8HvgXUX5RbFBHRghs
         fV9jahHWwEkE2+ObFKDgQ/Lie/QTzWilXtv8psm9eo2cfF1vf8cUqgQyjkx/crp51TDm
         3j1rp3hgpSGUSm18xuw2cx19rEpgDkuiObfA+Wjv8gr667QCCpzWCkdHmUDZhsSQAsf3
         v04hBbCNFPXB8F+Wi1pZOPw5WUnFrxHkMNViIfYhjH7UglF4X7JlSmR5Nr3ZrcTnaIxR
         YzQK4Ijbt/xXWVrWTrfsJhlScHAtofk1rNAuI1X37ZHMmqEjANRHiyAUGHLOFYN8sHyG
         6ZXw==
X-Gm-Message-State: AOAM530qmUzk8C76jV3+mVU5b/T+Pje6fX5FcbDK5Y1RcnJSuWvAZeYC
        1/ASZvAGuvGcGzWtJuT2VyKjeHEDd/QXDQ==
X-Google-Smtp-Source: ABdhPJxGHuGu4llSwLb3zCZVgxk8jtCvieRCXcDkcMJ8bo7vJUrGV10GzPleTcQDEwzyarHCh4kUhQ==
X-Received: by 2002:a1c:b386:: with SMTP id c128mr890014wmf.48.1612322908178;
        Tue, 02 Feb 2021 19:28:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/25] grep/pcre2: move definitions of pcre2_{malloc,free}
Date:   Wed,  3 Feb 2021 04:27:57 +0100
Message-Id: <20210203032811.14979-12-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the definitions of the pcre2_{malloc,free} functions above the
compile_pcre2_pattern() function they're used it. Before the preceding
commit they used to be needed earlier, but now we can move them to be
adjacent to the other PCREv2 functions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/grep.c b/grep.c
index 2599f329cd..636ac48bf0 100644
--- a/grep.c
+++ b/grep.c
@@ -40,30 +40,6 @@ static struct grep_opt grep_defaults = {
 	.output = std_output,
 };
 
-#ifdef USE_LIBPCRE2
-#define GREP_PCRE2_DEBUG_MALLOC 0
-
-static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
-{
-	void *pointer = malloc(size);
-#if GREP_PCRE2_DEBUG_MALLOC
-	static int count = 1;
-	fprintf(stderr, "PCRE2:%p -> #%02d: alloc(%lu)\n", pointer, count++, size);
-#endif
-	return pointer;
-}
-
-static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
-{
-#if GREP_PCRE2_DEBUG_MALLOC
-	static int count = 1;
-	if (pointer)
-		fprintf(stderr, "PCRE2:%p -> #%02d: free()\n", pointer, count++);
-#endif
-	free(pointer);
-}
-#endif
-
 static const char *color_grep_slots[] = {
 	[GREP_COLOR_CONTEXT]	    = "context",
 	[GREP_COLOR_FILENAME]	    = "filename",
@@ -355,6 +331,28 @@ static int is_fixed(const char *s, size_t len)
 }
 
 #ifdef USE_LIBPCRE2
+#define GREP_PCRE2_DEBUG_MALLOC 0
+
+static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
+{
+	void *pointer = malloc(size);
+#if GREP_PCRE2_DEBUG_MALLOC
+	static int count = 1;
+	fprintf(stderr, "PCRE2:%p -> #%02d: alloc(%lu)\n", pointer, count++, size);
+#endif
+	return pointer;
+}
+
+static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
+{
+#if GREP_PCRE2_DEBUG_MALLOC
+	static int count = 1;
+	if (pointer)
+		fprintf(stderr, "PCRE2:%p -> #%02d: free()\n", pointer, count++);
+#endif
+	free(pointer);
+}
+
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
 {
 	int error;
-- 
2.30.0.284.gd98b1dd5eaa7

