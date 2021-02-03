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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD69C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7EF64F74
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhBCD3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhBCD3j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:39 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DA2C06178B
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:23 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u14so704602wri.3
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UViOvZ6ebifCYycIoB4e1ICF+utBA/Mwn0gFFMwUjoM=;
        b=HIAtZDn9eZKPZVlmmNOA0txH0TCvwJU95XlvQLT3Y47hcjDH3pihwgZvfF9cJz3uQI
         bMLMepveNvGnTifZhqAj8BRC3c1BeiKRIJFWlRJwlHIAUkpgpbDHVHVjuJInOHmbl9vF
         qywoCCo1WGRLFDxZDN8+l8Ma5/2xutc17EWL0t0SBMwMc+ZFiM8t/nCJMCRQB+H9uAsw
         JyWOXI2oo9QEb96TPyItVtA87ZA9RiuepXetLeYvsgMBKKHS3qp5UF5S0Kd4faE6S6df
         349Sb3c+ODtx8FoVan0scXBzp1gnTZb6A0CKKj+HRMZ80mZZOGgLB1PxvhmxjGA/kcHV
         wxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UViOvZ6ebifCYycIoB4e1ICF+utBA/Mwn0gFFMwUjoM=;
        b=r0vauZz9jAjmektTzu6HFgpf5kGRmuMRFprrcQkMTya40qf3MSm6eAvjBR3Mp6qCnd
         4ExzfSsdHAJsBG4LwWVNGg0QI3Ax2qDpssbT2iU8fi5kv50zOeVi2beNyfMPsvdx6UsU
         prQrDp+cXeLmpXXt4xWKqqc/Jc9FUCtLGCsovD8+XXHWSFf3d6yqPSg4mSIpcXlu9WsU
         BsrggFgk+MHkN+a+pIHcwtL/s3gwWMk70xKgDaiYVnXlk/xq3iWzTAqqQ/UVh8Ao5hoW
         RZD87ictY30rKobWgWvE7jhe93qUg51RYl8EEuePuPSlfpPcliGuFJLzMwwYpLzYOsQS
         7+Kg==
X-Gm-Message-State: AOAM5339KjExp1qgy5VaCW5F20E88zusVkAJrWpPl3bpyvKMNRijaNed
        BqFhBkbTfjfZCRgOhdzrUO/X1ZTYSHzV4g==
X-Google-Smtp-Source: ABdhPJwaLYfBT5SLjjQMUet0RjOU0f8kG2lfdTFvXhkVjryUuACPjb9Yz0Iadds3XrBMqrCwLjtSAw==
X-Received: by 2002:a05:6000:8c:: with SMTP id m12mr1046506wrx.101.1612322902429;
        Tue, 02 Feb 2021 19:28:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/25] grep/pcre2: add GREP_PCRE2_DEBUG_MALLOC debug mode
Date:   Wed,  3 Feb 2021 04:27:52 +0100
Message-Id: <20210203032811.14979-7-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add optional printing of PCREv2 allocations to stderr for a developer
who manually changes the GREP_PCRE2_DEBUG_MALLOC definition to
"1".

This will be referenced a subsequent commit, and is generally useful
to manually see what's going on with PCREv2 allocations while working
on that code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/grep.c b/grep.c
index f96d86c929..7d262a23d8 100644
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

