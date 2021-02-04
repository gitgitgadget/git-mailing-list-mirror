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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78381C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3122E64FA7
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhBDVH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhBDVHf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 16:07:35 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C11C0617A9
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 13:06:22 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l12so4328079wmq.2
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 13:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cfc9HKftHNiMcn9e6q5gY0WzMkB21tulNMrnFpqEr90=;
        b=ZciB0oft0mcKiFPiX44cNn7gnIMVjP3Lo7lSUIiv6Cyk7YDwb+am+1TCO1E3dhzCyQ
         92vHZYvF1Vq7k3qs6Jg92lh59rY9wbb/jUX5BClsegcJLtO4+p8gJIqTcMm9asorAU5u
         rDOmxtsKvSKx4aVjZlNcovMtcmPC1FYano3/MT/HP/kp4v5UC25SvLC/pcI1P7HH9N8P
         y1AIuZE8f+McPHvQkkTyKLCq+lUR+x1N15I3TglgdMzBmfXRjYF55Z1hkcYfvudy6BeR
         8LrCqgbr6Vkt28XzdTUz0ZDXeuR9XIpS96bXCr+VDxx/RgEoJfTstPFn+HsEmM0Y0l/n
         HVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cfc9HKftHNiMcn9e6q5gY0WzMkB21tulNMrnFpqEr90=;
        b=J0Kqt//DQ3LFkjxQP8otckE+i39WO+mdKJjP7KtqdSdJGaVkVsZB4f0dpRExs4qiS6
         VYK1Rab5xTa9mvDQZblYSSef4xzJQ5nJ2MmKwKsn5tjn98Q8m/fSrxVOYArFcTE4u5TO
         OIxb4wMdwVJsayxBK7Y65ejTQWzjIACKyUs01RHrjf+kS5407g0m/q+Hrbn0d1DiFw6w
         RWfvsWdKl37BYpCHnettUfTgWbmaCHJDSBcwsiWwIZl+cmVcUOPSw84zhY19KdRaqx6n
         ldH2zeRm6pHO7EKfF/2sh+BPlcV5ZzZDdMK3MUovXdO6o6HUwFalggQyMMKwoqGZGXke
         fnxw==
X-Gm-Message-State: AOAM530YLnhkmUhJ/my2/XuBGuWSjnEsuT519+blumYWueOJIxjZiGW2
        Irwgb77QU/IBehYpk0Z28bkJbhMIfaUgbQ==
X-Google-Smtp-Source: ABdhPJwKXMbuYhzzvtK14SQ87m0GMRXu1iTbEQbqKT/20xlWdjwTQ6Ur4x879J6ZqLIUpOi6gOwcjA==
X-Received: by 2002:a1c:356:: with SMTP id 83mr883700wmd.31.1612472781206;
        Thu, 04 Feb 2021 13:06:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5sm6779318wmq.7.2021.02.04.13.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:06:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/10] grep/pcre2: move definitions of pcre2_{malloc,free}
Date:   Thu,  4 Feb 2021 22:05:56 +0100
Message-Id: <20210204210556.25242-11-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
References: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
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

