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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5CDC433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E5364DFF
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhBRAI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 19:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhBRAI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 19:08:56 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149B8C06178A
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:37 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u14so681790wri.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ze/MiljslprIwFsxOEOEpkzwCRD4BrPoy580Sdpv2xw=;
        b=QM0MTvAUFiLGpYn3MLGGCkFohAuLyZhw6LZX3oBghLGCGgWREiBiF/m5Vds2UhClBo
         VndjeDVqASPnsb78weW2JShBEk/84BwgjxFqGgdXBeVfn+gGssCkliOTHzOkDvmhcbvA
         Zl3YBgH3eaaUbkFYOongengHF0OuN7zd/a7vKp3XUc1A7C7/L5I2BBRkl15fJI4pSCKq
         W3b78R+28Z/Zcj5xZdX9W6/3KxeUGS7JR4hdHskqLMiviZkzFiMUEW197kOcCHAaHxjZ
         MQ3yx1DuG6V6OUuJ7rNDgeyXybLkthYRv9uJtpqFyIbYiwtTe8jPU8hXeDLJCej+sgiU
         WnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ze/MiljslprIwFsxOEOEpkzwCRD4BrPoy580Sdpv2xw=;
        b=BiZlfJnflQJIKPgn7Ih/fKyub7okdAtKknX6Wt0yjPzpzypdLo4Eg8ynF8WvH8gk2l
         Gi6uKDPwjh0C7pj7dNyhxTQBWb1PgKZNS8Rp60DRnwj1yJ02kfs5Icg2lluOYwXqr7Zi
         Yy22GDXDoliwnnXC1YoVD8b41Hf+eQfGbmfulNNoVdEduElZxSaEtQAjpPHsWUV3uchG
         Hqx8k23lzGkm9zOMsRAL9ZtSb/J3A7lvNZBc4mfpWpG106xsXxoaPHRYPhE6qMDdf0Kg
         9bMXOvg1WpTPkzZGCzjvMNOHY9tkSpgjyKadnZn+2mnaoZRmtheG7AgZaSE9zciJlWsh
         LmQw==
X-Gm-Message-State: AOAM532w/woZeXo9cq5g2QBAmy/WoFQzX3hxkoYv2rKyvPQNNnfG8SFl
        tgYzl1s3Val/E45zKH/i+LU4rqvsXf4FVQ==
X-Google-Smtp-Source: ABdhPJxil/30K1dgySECywgWfQt4KNk5mCjlUS+w+f+FytO/Kw2JGTLzNGbmpezyJ/GSAjrBV+7YNw==
X-Received: by 2002:a5d:444a:: with SMTP id x10mr1601152wrr.409.1613606855481;
        Wed, 17 Feb 2021 16:07:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r17sm6232795wrx.82.2021.02.17.16.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:07:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/10] grep/pcre2: add GREP_PCRE2_DEBUG_MALLOC debug mode
Date:   Thu, 18 Feb 2021 01:07:23 +0100
Message-Id: <20210218000728.13995-6-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210204210556.25242-1-avarab@gmail.com>
References: <20210204210556.25242-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add optional printing of PCREv2 allocations to stderr for a developer
who manually changes the GREP_PCRE2_DEBUG_MALLOC definition to "1".

You need to manually change the definition in the source file similar
to the DEBUG_MAILMAP, there's no Makefile knob for this.

This will be referenced a subsequent commit, and is generally useful
to manually see what's going on with PCREv2 allocations while working
on that code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/grep.c b/grep.c
index f96d86c9293..7d262a23d88 100644
--- a/grep.c
+++ b/grep.c
@@ -42,15 +42,25 @@ static struct grep_opt grep_defaults = {
 
 #ifdef USE_LIBPCRE2
 static pcre2_general_context *pcre2_global_context;
+#define GREP_PCRE2_DEBUG_MALLOC 0
 
 static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
 {
 	void *pointer = malloc(size);
+#if GREP_PCRE2_DEBUG_MALLOC
+	static int count = 1;
+	fprintf(stderr, "PCRE2:%p -> #%02d: alloc(%lu)\n", pointer, count++, size);
+#endif
 	return pointer;
 }
 
 static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
 {
+#if GREP_PCRE2_DEBUG_MALLOC
+	static int count = 1;
+	if (pointer)
+		fprintf(stderr, "PCRE2:%p -> #%02d: free()\n", pointer, count++);
+#endif
 	free(pointer);
 }
 #endif
-- 
2.30.0.284.gd98b1dd5eaa7

