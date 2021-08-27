Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1815BC43216
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 08:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9ED160FD8
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 08:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244531AbhH0IEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 04:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244548AbhH0IDc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 04:03:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295EBC061796
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 01:02:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t15so2845224wrg.7
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 01:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sV8fyAjqpMUAM+Jt/bpyvC4vPUa2r/gTFr9proLJFw0=;
        b=eEB6Ls+U39azoXKHxCTztpw6eGibsH2UXsrgfBGOe7kN5NbeHU6MlkxY5sqFeBRRk4
         KR0NQL9iTiceGQDKmJtnpYmYKB+bPGn/ByTsbrUrJiJ1mPJtHxwBT/dFyAd5LwVbajSK
         /9ts6E3WfMzTwLfBauT4jfi6+RIRloskJekplX92lI2so+tSJgEw0phzdb8fgaSD1Kj5
         0F9fpTdFJfr8/53X/7wTH5+CtmtdHRjRCfxTr4QqOnIR1bVLvklSRN0QnAzfLHbg481b
         9hV4ueirs2rgYlKCXLooBig8lCljgy1rmueNS9J7/Rl2WyKHf8q5pcZbsYtPsEAj/eKd
         KUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sV8fyAjqpMUAM+Jt/bpyvC4vPUa2r/gTFr9proLJFw0=;
        b=U5LRoaHYGaW+i3Ydr4WiIenWKCFzeAEQt7SbMg71OlVt5daVsz3UjR4JBJsRMS6ZXx
         +6nu4e1qIcDaFdneptOZrLNcAVOMcCh182lIloWr6Ot07S18V39ERANAoQBH6/O89Jtb
         6jWAyJOpxxgtxuc6VhKNvAkvy9yDv01b1ULWIghWCkob7AL8JeO4IJl2KHR2/k7VK149
         qKv9LoIh/EwGnPgjHw1i/nf40cLsqfEYunxAT8QdWO3e9XOFDTe3fQ597cvUlK4kBGDu
         zHm8GogICbstUc0p1e/1UpCWdPn9GXcQEOsG/9xTizm4pKiokKe39GUqtxaOAxbB79wA
         LM7Q==
X-Gm-Message-State: AOAM531/K6YZm6aApVLTbQofBV+PdfCdiqXFPuikUQbeLUrM82/fAWuM
        cjZxs0PgyCZtsDNAkIEptyzM3Wrl00rC+A==
X-Google-Smtp-Source: ABdhPJxohUtKUvNNwqi1Ca2+ctaksggLdr+oMwh6DmgKZa6tMihhoGA/rq/PDRh1L2mBY9gfqkcRMQ==
X-Received: by 2002:a5d:4583:: with SMTP id p3mr8537226wrq.398.1630051344483;
        Fri, 27 Aug 2021 01:02:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z137sm10922636wmc.14.2021.08.27.01.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 01:02:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/6] tr2: clarify TRACE2_PROCESS_INFO_EXIT comment under Linux
Date:   Fri, 27 Aug 2021 10:02:14 +0200
Message-Id: <patch-v3-2.6-a999e016a9-20210827T080054Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.736.g68690aaec9a
In-Reply-To: <cover-v3-0.6-0000000000-20210827T080054Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com> <cover-v3-0.6-0000000000-20210827T080054Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrite a comment added in 2f732bf15e6 (tr2: log parent process name,
2021-07-21) to describe what we might do under
TRACE2_PROCESS_INFO_EXIT in the future, instead of vaguely referring
to "something extra".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 compat/linux/procinfo.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
index 15a89676c7..62f8aaed4c 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -32,8 +32,12 @@ void trace2_collect_process_info(enum trace2_process_info_reason reason)
 	if (!trace2_is_enabled())
 		return;
 
-	/* someday we may want to write something extra here, but not today */
 	if (reason == TRACE2_PROCESS_INFO_EXIT)
+		/*
+		 * The Windows version of this calls its
+		 * get_peak_memory_info() here. We may want to insert
+		 * similar process-end statistics here in the future.
+		 */
 		return;
 
 	if (reason == TRACE2_PROCESS_INFO_STARTUP) {
-- 
2.33.0.736.g68690aaec9a

