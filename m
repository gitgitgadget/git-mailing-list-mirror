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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE96CC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A208564DFF
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhBRAJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 19:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhBRAI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 19:08:58 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433A6C061797
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:41 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 7so698222wrz.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9dhop04OYuXYIvdSWsg6X1Sw/d3KCqxIwe8yeo2PfOM=;
        b=GQyBDmr9Q2vm9nVhwrJEz4AzJaj26JRZUoNcaIJE0B1DfkIA+uqgNqryiG2r9o8sXs
         8sZvsXG7cWjvWMT2v8zKFPBqF/by0Y+vGF4WiEKoAbOLbCHbQ91WS3MEg2mbyPCa+v/+
         mdlDeRt7y3V4OGXWtcZIzus2Lr3KatlpE6JuBamje7Cp5HmRDYjKrwErlfpocAfQqCyN
         D2S1VTk38chNumgOrSALo48eGcpPq2N89okSZoesjaA2mzmIX6WiNHxjsJgFumGZve7W
         toYJrs9ghRirdW4IbOIifHHNuLRYm/BlPIoPjo3PnO0kZUUeB7Vgyh9iekhrfCdPbhKg
         8Zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9dhop04OYuXYIvdSWsg6X1Sw/d3KCqxIwe8yeo2PfOM=;
        b=lCDkPwRk4VyZDCVHc0LWGr3ZWLiXOeYa9SeTzfptSLOLV0NkexeHbcHt1EReuPV9Gm
         Cp518uLM487ReGgtlAEv5Mb1R7+PlGFB31XrPClXIyEUJM8I5ZbGBg+heYj/q7iJjZH9
         1ocgL92xg1UDUjEqRe6HZv9xJo28DlZvJW3W4Lw6rnrhzHMKlvJ//UW4wm96bUwJAuWy
         31jfzwPVxmWsRfDDuxaW4jm9K3yDSZmMPNqq+JW2wnKyPhQ1A+nLnYNtxfRD5APAfYAo
         5lfjPT1RLfha8YXH3ilMriMWfvyMkIDMKrJXWpE6C46iqTVgMQ85eG0h5MVY9AabR0G3
         E/hQ==
X-Gm-Message-State: AOAM532Io5xpKBSUW2BuS1cEQKaLFQIOh30ZXCRAkfvy2oYuEb0UEFPW
        iB0W7YoYiUIQtK+sYg/qlH7tvbhkKes3ig==
X-Google-Smtp-Source: ABdhPJwZe+avkp3sXwrXNGuSVGsaLGfTrJfNlg72LlEjOmyu6EbbOuQ6rzkmh4EVtdlCTYeIoHqoJA==
X-Received: by 2002:adf:8185:: with SMTP id 5mr1604011wra.288.1613606859715;
        Wed, 17 Feb 2021 16:07:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r17sm6232795wrx.82.2021.02.17.16.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:07:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/10] grep/pcre2: move definitions of pcre2_{malloc,free}
Date:   Thu, 18 Feb 2021 01:07:28 +0100
Message-Id: <20210218000728.13995-11-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210204210556.25242-1-avarab@gmail.com>
References: <20210204210556.25242-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the definitions of the pcre2_{malloc,free} functions above the
compile_pcre2_pattern() function they're used in.

Before the preceding commit they used to be needed earlier, but now we
can move them to be adjacent to the other PCREv2 functions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/grep.c b/grep.c
index 2599f329cd6..636ac48bf07 100644
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

