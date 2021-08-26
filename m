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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C18AC43214
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 12:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201F161073
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 12:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbhHZMXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 08:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242642AbhHZMXR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 08:23:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56117C061796
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 05:22:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q11so4733306wrr.9
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 05:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vHdxbCA+/hsBmu/T36KjN3tcQ7jEN6auW1UJeeywmm8=;
        b=oEe8HYmzmdHKWzYGscZcQFz5n4iavKVbYdpsKXNh1SPDRoSAiFsFo+obzXDiWsfBrz
         oET8MWcJ9WHljDGO8pHTYKhoY2AGJFmyBdwmuYGHhLpbIxqfS4+CklSY/YkL2IgjX03O
         Ah9Q/n8M7Hwert4jfOHin/D6x7N4K0BfKWksWuACjTRRPwbmQAV1fG3jIjYQVsEA5AvN
         S2l9iH7+fbPDpONg+4fNWMwQO2cThWv8QiDYG2aGxhpHGqu1WXdthFmHM2dF5HtAmDcm
         o2PTrOJBLEEJaEYDmf745qIPivSeFOncly4RIsbihZsqbAoLl/tjxWZ/PNJWfmQUd1KS
         QlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vHdxbCA+/hsBmu/T36KjN3tcQ7jEN6auW1UJeeywmm8=;
        b=JwhiHZrWpGxtgsAHLB9+vGCPz6rL38LKII88vCQHpufRrJNMUCpjqgeNbqXMK+mQzX
         7Ib6qNqjSh5EuIGNYd4Wquje6m3GuFxX4IBDyArUVQIiXVxq90jOW5Sg63sQeK6Y3Mz3
         dyf8m3t++jSmkR3S9CbOZbBhy/YXP+hsSDrotxRmrY+LJlSbRV9J1LW+AT59NCm3hkWH
         a1jLJLrouG1+ws2MVWm9ysT+XvtlEBre/3LlFzrIMjReAx6+BG2+S7SXbo8dsx3kbRO2
         GcHBC6gSWvd8ZcjTPVWow5Y/7D16p6uvWQnvLQMRNt4XbNYQUH35TGzbryhkbdB/SIhQ
         6SCA==
X-Gm-Message-State: AOAM532HIaRmMc8dVqLjycEsSu3HDJV1e4Vi5u6/Spd8BZ5UFH7VGVoY
        CLV46peGabvGqcPcHUmc/CA8QmusSop53Q==
X-Google-Smtp-Source: ABdhPJyu3abM/HdbdoF0+GQHznsm9A4Ecc7tBsiYJGdBzRMDXGGvc6WhVbv40JSrwznLIiDE4OvA/A==
X-Received: by 2002:adf:f84d:: with SMTP id d13mr3695028wrq.292.1629980548646;
        Thu, 26 Aug 2021 05:22:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z17sm2969885wrr.66.2021.08.26.05.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 05:22:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/6] tr2: clarify TRACE2_PROCESS_INFO_EXIT comment under Linux
Date:   Thu, 26 Aug 2021 14:22:20 +0200
Message-Id: <patch-v2-2.6-0150e3402a7-20210826T121820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
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
index 15a89676c7a..62f8aaed4cc 100644
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
2.33.0.733.ga72a4f1c2e1

