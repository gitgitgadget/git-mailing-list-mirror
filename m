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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDE2C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66FD64FA4
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhBDVHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhBDVHc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 16:07:32 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D35C06178C
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 13:06:16 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 190so4330980wmz.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 13:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UViOvZ6ebifCYycIoB4e1ICF+utBA/Mwn0gFFMwUjoM=;
        b=ojHLDaRF6pNp7g9rpIKhA//Oc7ysRTBIFZrhBDfnxtzJxFtoJOFTDBQgfG3UJMlVzH
         jeX9ncHhfafMfYIEo5U2P+4QHa1nJacztHMN2lBT1G40zWIym696M+MtBiC1Jl+YC8P9
         rQQTgEOLkMOYPFr58z/psnQa2FfwLQyWDKVzojw1fShXynV8gj6vSWL6B2WrmPeOdmri
         W00mSr+Svnl1Mb0Vzb8qsoAv8TNar8ObbY7CU75KcgeKnJHADzVL8VcWLaiFzpRpgV4V
         MG89+q2y/3hekVcfpa7bmmKyF+mXc12dj8bFVVhF8mqP3btkAy2P1TyNADVdcewPsm4f
         a+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UViOvZ6ebifCYycIoB4e1ICF+utBA/Mwn0gFFMwUjoM=;
        b=T7BjMBTufJFbdg7xmA0IJXd2XgZObsofrCLLXWEZIgFoxsRKouHjGeIZav5wBSNs1E
         C3zsmoeJD7InuWAUT0lP1wD76KNTrNKx1GGhVypnetonadunDNcnr7XXJpajqAcU4N0t
         A9DpITsDPJ8NOSZomHCXyw7TImXvneq+iRVui+msibli7nY7CUYD6ofTFnRh+1iO2caT
         U4Us8sNp4FwLdcCLV9Z6suL74SOJc3L9CUAx9jipBB3y3fn/wDIscLreLUG6hO3XacDe
         oK9UiOrGzMFG8TIsp2xiKG9jf+xl6V3fyzQrwIE981gDyWfK47KdtoJA4fvPZfS5do4D
         v9Jw==
X-Gm-Message-State: AOAM53125ctAeuzseJ2Ed8f06EY3mNLk5T559LVq8tGg5L6QRg4wVEKN
        vbFhb5nIxxtlnuRTsWIrm5e3JvgXr04GpQ==
X-Google-Smtp-Source: ABdhPJxpqFM0g6wh3ektsp5Yqr/KwOLIMvmn2exVZjxFhtiO95psDsMpvQN576z5RLd7/NxIqelBWw==
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr907651wmh.4.1612472775481;
        Thu, 04 Feb 2021 13:06:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5sm6779318wmq.7.2021.02.04.13.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:06:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/10] grep/pcre2: add GREP_PCRE2_DEBUG_MALLOC debug mode
Date:   Thu,  4 Feb 2021 22:05:51 +0100
Message-Id: <20210204210556.25242-6-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
References: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
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

