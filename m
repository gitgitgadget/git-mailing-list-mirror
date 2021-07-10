Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA790C07E9E
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 08:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACBDB613C2
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 08:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhGJIu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbhGJIuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 04:50:25 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88969C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 01:47:40 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l7so14724728wrv.7
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 01:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BQ64GRkYfResmKiXjUAhVlwb9fcjBVJqqlO8xTzVuXM=;
        b=na1WrriFkavD4pPYmAq492AWCjuV0C+aV+Dvi60yzt/ukWoKg+v8j5vt7qs/cuTG8U
         dKtWHrYxnl2XWHvS+vJkIHDZlVcQnR8cGEdIj3poS32v0W2br783gJddLZ4LFKjTxUAr
         FNe06+tLoyzSUE4gtFyg+16n/rKvNhWx5kjgo23cr7mxJTd72dO3CESrPA5b6CXooDLU
         6v8ajDZm14Y1iS9QlevTQcTu4ThHdfZ21dXRwyeF6rZoWr3VRccbrEl43VBWX11LUI9v
         9TGT/bl3h1wgc/RQaQGHkJZsjZbr80sck+PLk8h3Pm9gtfPVUNinhwAWMgfpcXq3h+3d
         DoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQ64GRkYfResmKiXjUAhVlwb9fcjBVJqqlO8xTzVuXM=;
        b=g5FoT+h7h5ZzJLykwuumf3vSrSNUUHCTL2rAx1j8jYUS4wKoOmLWYa/bMoa+3xzBUd
         O1i40sdPyeoHjQL3/c4/grqe7Yx3ZvrR99ZGmZUE3ZqBReQ8pe0yXDNUrUuMNedXcpr/
         I1md/neSUNjMn2CbHtofG4oCkopfO+1IxjZpuVqkLco+m5aJ1Jsk5Ast7sZucCyFDxdY
         EsYaXMBGNqnr3DT5PbB23cAamjgANA27OGg8WkjddmZQx0NTIg/d34fHAiMFSBfBNPcz
         eX3SUI9DyuHDbMtRfZweTSEJLzN66pK74KZeim+SSNmBzqSLFAvaIFzBlJbHPpg9AL2C
         FxTQ==
X-Gm-Message-State: AOAM530k0tcvWm5c2X+/8ev5JClmKtxCv9i13kIMxw2cGDpD7JJB8IjN
        7JJiPVhBrfue8aUQlYwaxDRfyOuUCatyHw==
X-Google-Smtp-Source: ABdhPJwTsiANS1r9vleoFLATnCqwjNljK7Opyn6Zg+HVhoivg8EUPG+DMBPHgO6al3JNiAfne+NdDw==
X-Received: by 2002:a5d:5286:: with SMTP id c6mr42614635wrv.75.1625906858874;
        Sat, 10 Jul 2021 01:47:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x8sm165769wrt.93.2021.07.10.01.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 01:47:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] bugreport.c: tweak cmd_bugreport() to use __attribute__((printf))
Date:   Sat, 10 Jul 2021 10:47:31 +0200
Message-Id: <patch-5.6-daca344a165-20210710T084445Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in the preceding commit we had no __attribute__((format))
check for strbuf_addftime(), and furthermore had no in-tree user that
passed it a fixed string.

Let's tweak this codepath added in 238b439d698 (bugreport: add tool to
generate debugging info, 2020-04-16) to make use of the compile-time
check.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bugreport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 9915a5841de..02edfb9a047 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -127,7 +127,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	time_t now = time(NULL);
 	struct tm tm;
 	char *option_output = NULL;
-	char *option_suffix = "%Y-%m-%d-%H%M";
+	char *option_suffix = NULL;
 	const char *user_relative_path = NULL;
 	char *prefixed_filename;
 
@@ -149,7 +149,14 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	strbuf_complete(&report_path, '/');
 
 	strbuf_addstr(&report_path, "git-bugreport-");
-	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
+	/*
+	 * This is an if/else for the benefit of the compile-time
+	 * strftime() format checking we have for strbuf_addftime().
+	 */
+	if (option_suffix)
+		strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
+	else
+		strbuf_addftime(&report_path, "%Y-%m-%d-%H%M", localtime_r(&now, &tm), 0, 0);
 	strbuf_addstr(&report_path, ".txt");
 
 	switch (safe_create_leading_directories(report_path.buf)) {
-- 
2.32.0.636.g43e71d69cff

