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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182FBC432BE
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED685610A0
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhHSSiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 14:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHSSiA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 14:38:00 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299A7C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 11:37:24 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o123so8150178qkf.12
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IjlkBZhOF2hIHWZY7yHp+edyh9wBdMwocnjVBThR6KU=;
        b=fFi2bL/XhkumuX9rd8k3GPQsKn2hZr9Hul78xjikxBR2ZQssbEGoPNhpHu3d6f1j64
         jmWT4tSCZRcnULq8Kp1+9Qa2hFNSBMvmo/7XBxCb9vnKDfDTMv/AAjRQxqK3U7dBAsjw
         KQCsD3Bv+LgHlVSJar/BJgw52OSby08aagAKdAVwzuwA2sg2IkkDHhuh7W8FGUrzZGPj
         xMUIvYT4Isp72r+AzOJmRPRtUdEHsy8mELMCC0hCdxmnyhfTidyTBxop4jdMEf1TbvwR
         KCqMUYB/UxnpO/llhyGMejFCz9OcsBd4zq5C3DMlXCGCg/uLku3/iwfqirilUgaQgrOu
         59tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IjlkBZhOF2hIHWZY7yHp+edyh9wBdMwocnjVBThR6KU=;
        b=IrmIZrksSf/kpVtogpPES9NXXjCmhrFovn83E5uGcyFvhiX/FvBLuFBoCxgCCR+Dkr
         6+RA+dsqCEVWB0tlPuwUx/6DQSjEUhzDewfUemNworV4OP6qkIM6iFgkwhI+wtAj/v6m
         RLaqSzru6yagsVohpPEOqIpUnNhRBGxNIdJDADzyeCEPySltac0cBJ5yye3MRSkYXaLd
         BA3P7/BUha0NWSq1SGaYf1ZOdevv3eqGSvaeXMqTJvb9j+ghjtCMNhN4m2qU1tczRWfe
         s+PaePLyTjWrxL3Ge/7MvAyg7WdjgkdP2ofh+2Iomw6KkJe18EYLWKOLo8QhO16GPMjS
         /s1Q==
X-Gm-Message-State: AOAM5318OBJcaJKKx+DXMWB4rvhorLiMSgYbrrkWtxzJCsh+KiMga8Am
        LT62PPRQZ+voS17+3acb54DmkIssZdA=
X-Google-Smtp-Source: ABdhPJzimtnEWBf29WdwyzzdvnTx2HhjyixB4vtLKt5SkkTyEmna5RTPsBc54BaB3FQ8Uf3wuhBbmA==
X-Received: by 2002:a37:6451:: with SMTP id y78mr5169092qkb.427.1629398241953;
        Thu, 19 Aug 2021 11:37:21 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id g12sm1555566qtq.92.2021.08.19.11.37.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Aug 2021 11:37:21 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] fixup! fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
Date:   Thu, 19 Aug 2021 11:36:52 -0700
Message-Id: <20210819183652.7750-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

clang defines __GNUC__ for compatibility with gcc (indeed it misrepresents
itself as gcc 4.2.1), so instead use the __clang__ specific macro to
distinguish between them.

tested with Apple clang 12.0.5, clang 14 and gcc 11.2.0

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 compat/fsmonitor/fsmonitor-fs-listen-macos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/fsmonitor/fsmonitor-fs-listen-macos.c b/compat/fsmonitor/fsmonitor-fs-listen-macos.c
index 02f89de216..c55ec35b5d 100644
--- a/compat/fsmonitor/fsmonitor-fs-listen-macos.c
+++ b/compat/fsmonitor/fsmonitor-fs-listen-macos.c
@@ -1,4 +1,4 @@
-#if defined(__GNUC__)
+#ifndef __clang__
 /*
  * It is possible to #include CoreFoundation/CoreFoundation.h when compiling
  * with clang, but not with GCC as of time of writing.
-- 
2.33.0.481.g26d3bed244

