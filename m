Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B904C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbhL1PTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbhL1PT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:19:29 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7207DC061401
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:19:29 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l4so11828232wmq.3
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=834+0nnrIayXgVqSbG750hSFOKWC6byo2OAokMb7OCA=;
        b=PAucWLbMX/Ln3pb8rUuvUq6RJA987JNaRf9bYyriMsVitMIJ1mzF6P3Id7evH9C4uI
         mu9n5XBtn92ej+i0Ent0ItSmdCtItw/g1i8DDx+P7IG9DeRfiZgPpEfgii3Nlxh+TRdr
         djfhV62BqsOshYdM7loLkEEHouGPmsun06s8uTlo9lzayJ3piUmkzjO5p9Hl+/Qv/0Br
         EyS/bqqs8mTjDx9W0WGzIaEvry8vBkrNx7BZbL0A9X8Z2Tdpqu+J82/ZjjVFKlZuo6f/
         4yt7mZE2trK8YthuQNi6a5goWhXa+f6NtIdAYUjaYTuScXrD6T46C+k3gPTajWrdZ0st
         m81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=834+0nnrIayXgVqSbG750hSFOKWC6byo2OAokMb7OCA=;
        b=cjm7v1NZuUBf/y7R0GVlBKX8fRKE+7mwxO20EKy9d39WniLd+xSR6qqS9WVChHlt48
         PL0AcCRO1gm17HxA/JAVN7aUtiw49YpV0Brg8QTLFFi5l2wuer/Aq2vVbIsytfUB6VAd
         5t+IXXCTutxg/U8iVdBwk48zQFDIo+HOxhb0nnN0nBO2LGFVQZjQrs/64Iiha2V6CQfB
         P9C5AdpmOsaVaNCLbMo3G7Sd4MtI1GURSzRuSpzntNs7iqITavoAOCiigO+EHRAe1vOj
         CO7WDG3Fs2tMqnIX/0NJF7T1Upav8x85kWOGmJxEnpHY1EgvmYuon6vT/fSczVzn43pO
         NZRQ==
X-Gm-Message-State: AOAM531ikwt6F8nBpxV2VZHhhz6Up/qCsr5kDVg03y1vFur3ksQef2XW
        CEuN2g2+zHFWdWjeh87DBotwb/5D21zgDG1+
X-Google-Smtp-Source: ABdhPJwLWK103CY4wMWQoWhUy6ZPWzrKJ3V6yHHMdwqWdOPDh66pGk4DuleW1Q3uYWpDRUl6M6i+sQ==
X-Received: by 2002:a05:600c:3589:: with SMTP id p9mr17969126wmq.65.1640704767786;
        Tue, 28 Dec 2021 07:19:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p11sm20491022wru.99.2021.12.28.07.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 07:19:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Altmanninger <aclopte@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 6/7] pack-bitmap-write.c: don't return without stop_progress()
Date:   Tue, 28 Dec 2021 16:19:02 +0100
Message-Id: <patch-v8-6.7-0bd08e1b018-20211228T150728Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com> <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
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
defer calling start_progress() until we need it. For now this only
matters in practice because we'd previously omit the "region_leave"
for the progress trace2 event.

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
2.34.1.1257.g2af47340c7b

