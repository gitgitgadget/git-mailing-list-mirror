Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ACEC433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E144960FC4
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhKATMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhKATMA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:12:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9711C0613B9
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:09:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so593616wmz.2
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/jMWJfUEO0PCU/P85MG9HQhuFL4Ay91kAEpF6M/Lyk=;
        b=oHIAPaGzI3kfnX3QSi+HE5JOeJla3Rl3a9gi6m/jW1Ybw0HcEXrBPG5PSaIWguIUdG
         YQLQvFfGVoB3jtSH9URBoqlc2uzAlgbNhfsSakxTw++77JIH7es+KDRkdDFG1FuGSlWE
         /eHPQ8SPig570tfxI3g5B+UyHFtK4fXLj8G6sL6Tbr8TbCzqtSGkdd8/t6D6Ap0fymiD
         X/EdvI2lTQ/lxxnu6TVzbjivvhHyeE5QKurQf0rVZtISJgq0FwJZYuiOH1lrcJz0Bmee
         Zf1SwVLfrwek3Mz8zLlJVGy3okgKYzyE5klB8buN+Y20a6yG9MV8CwHJotU1M024n2Xf
         JN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/jMWJfUEO0PCU/P85MG9HQhuFL4Ay91kAEpF6M/Lyk=;
        b=OqlmR/qhCG0mT3bopPIyWPl9wMhAMSJTXKx6YotTv+fQChdxfJTwuw3cJJdya/AuUr
         0DQ+MHofT39NYbj/9bxAkY04/AXOArzhyaRUN2o563u8aMGjfUlSaUnE+ckK8OW4PhdQ
         w7WVxAH/HN7I2LcZ9WLickSIaKoChzxbgNDQRgMdbez0DWf8HnG2pHgHsdHWJLcAt0p+
         R9p3pWw2gVuyRpBSmqp3x8MPKRt6+RiDpVFJV0GYYAaeduwz5han8ZY5OvT1+e9rZFRz
         mJwf5cRu3d9Dn0gp6rU//8MvP2iLy1JHSCNVQ9F4nb8Qz6Ypzkf8DuMRSSrmT2HtrWbO
         xvew==
X-Gm-Message-State: AOAM532PgPMDHO9JZb+2P6JvHHJXnMsdo+W9YtsEp3Az/Ax5WGMk7/0y
        zMstSVpqCPX0EBgjiO1H64RD9UHLhM4RN6Eb
X-Google-Smtp-Source: ABdhPJxjvPMFJDkaJdP/3a/LBIFcw48A1sTRqGSSGvKJmVOGMV6WIHno2LQk8Ja4h4yczlzSet39Lg==
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr838533wmg.181.1635793763167;
        Mon, 01 Nov 2021 12:09:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p12sm4337211wro.33.2021.11.01.12.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:09:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 6/8] pack-bitmap-write.c: don't return without stop_progress()
Date:   Mon,  1 Nov 2021 20:09:12 +0100
Message-Id: <patch-v5-6.8-0300b802dcb-20211101T190630Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
References: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com> <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
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

