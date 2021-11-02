Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A9AC433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A623060EDF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhKBMaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 08:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhKBMaP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 08:30:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DA0C061766
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 05:27:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso1769195wmc.1
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 05:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/jMWJfUEO0PCU/P85MG9HQhuFL4Ay91kAEpF6M/Lyk=;
        b=h+LjEajZWr43bEAJ0NzaZqGfQHaop3tEUWQnh67zomXRUsFqOAmB2flWBEQ3zKU/oV
         yHJpi5lTF9KEIwf0ysNoJ/ZequGf/Ey+eFkO3LoG26LdV5iZzIly7MQJhzJSOSVyEBrQ
         LaY7GLDdr7pzAjeVxTTUJmuVm1Bodw+e1E391fOfJSQv/eq7tbgVLYtyRAXAM8jY8o14
         ByRwN51E3xI7jJ6MAMmJ/caJKCecLKdR1yerHFp1tpFZsUD+cTh1SBuT/OSaiVDACcIp
         Nu+egvO/dwiD6WbB8hbM77wARyms57tTMiVEBnCbgorq/6miwkIfJHoGpk7NalS7Vr/9
         qqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/jMWJfUEO0PCU/P85MG9HQhuFL4Ay91kAEpF6M/Lyk=;
        b=5279UVcvpX5/nKfYhmY75pMJSXsY39aR0tYDiR0hfcAj1rF5s5MZMVmm0V9txN4h23
         YA8EjvmlHDloHlfkjgEnKt7+LxRwqEPskXoc/2qbPl617z86V8bNGe+XETWpPDWatnSp
         sPxUedX7IAA7GNA+FZN3tJ8SeSFsgGEN3t4QyW38bEUi5X1UPCjb2lJoZKkxudXy/9lI
         oYe1PWQkECgZpQWHVXOu9Ju/RrNfyWLt+x9jqUQuUuqdl1XxrA/LChUk0YCn2fIV8kDF
         pjXW0FVb05p0Emlzc03wUjEKF8c32X2RiorJLZlw6iO7roTQl1pue3UW7Dhj8Vt5GSMl
         HMGQ==
X-Gm-Message-State: AOAM5316wxCdXLZ8B9QvOFR29Z4PTFCOUt74JGG3WxRuMYpMWt1xyb8m
        jgGfXnMJnJSNJ948O0fn+Jo34luIbCh0+Q==
X-Google-Smtp-Source: ABdhPJz/94YPuOaDcpkARk9UXhvzojxOMR7GIqFMYL0hcnMdCMZVDJtsuJ4iPb/KY3zg8lslWHfgIQ==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr6624957wmq.148.1635856058577;
        Tue, 02 Nov 2021 05:27:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q84sm3332236wme.3.2021.11.02.05.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:27:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 6/8] pack-bitmap-write.c: don't return without stop_progress()
Date:   Tue,  2 Nov 2021 13:27:28 +0100
Message-Id: <patch-v6-6.8-f6a76b80e91-20211102T122507Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
References: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com> <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug that's been here since 7cc8f971085 (pack-objects: implement
bitmap writing, 2013-12-21), we did not call stop_progress() if we
reached the early exit in this function.

We could call stop_progress() before we return, but better yet is to
defer calling start_progress() until we need it.

This will matter in a subsequent commit where we BUG(...) out if this
happens, and matters now e.g. because we don't have a corresponding
"region_end" for the progress trace2 event.

Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 pack-bitmap-write.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 9c55c1531e1..cab3eaa2acd 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -575,15 +575,15 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 
 	QSORT(indexed_commits, indexed_commits_nr, date_compare);
 
-	if (writer.show_progress)
-		writer.progress = start_progress("Selecting bitmap commits", 0);
-
 	if (indexed_commits_nr < 100) {
 		for (i = 0; i < indexed_commits_nr; ++i)
 			push_bitmapped_commit(indexed_commits[i]);
 		return;
 	}
 
+	if (writer.show_progress)
+		writer.progress = start_progress("Selecting bitmap commits", 0);
+
 	for (;;) {
 		struct commit *chosen = NULL;
 
-- 
2.33.1.1570.g069344fdd45

