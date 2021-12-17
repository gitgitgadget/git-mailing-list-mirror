Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E511C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 04:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhLQEZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 23:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhLQEZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 23:25:29 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E1EC061401
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 20:25:28 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so792361wms.3
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 20:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QxY8RvrnvcG0Yrp5agsq5kTRqPBeJEd7iVEITeSrPPQ=;
        b=VFtcLs3YAyKqUSsMf4MfokvIuXQrcnrIqlYFMeE8Yp8mp3xVwrwx5qvksDox/XaQRA
         oN6GZTS+bklFkzkw7HIwQ7mByXHrgBDAJ6tQXL9wYisZ7f4otRd2ma4Mjf04yo+saSiW
         nXvyLBJyiXTk4i8xijmK5XGAvIGhh+owN//ImSAmPt35LZjyUVGGT+Qzw5PuRYxKIrNh
         1Ah68kKfRRuPbbnOHN3pnI3Wq/1n3pUbuP/VAr8LTv1ft8Rj3EPnTKrvNNVQVUyaEZZt
         Ohd6B2hzpyZ/PcKDSho8nR4/NZ3o6B0Z8uG1SErxXooqFa0RNITe1wbesXoSLHvP9O7t
         +X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QxY8RvrnvcG0Yrp5agsq5kTRqPBeJEd7iVEITeSrPPQ=;
        b=SCPdlYK/IeeKVf72jmV00Z76shZMLaX3ta9/f+QDQpue+z6RJAxTzPl4K7MvodWuWL
         r5HQJDfjdFbGnGmsequamxQ715uQCC7qdHjGkvuTMFAf2LdznuOTHqIzm0ZGpvOZm3a8
         CaXJW69mrqAKgRPkIDpLdke72LqTC6+v2C3O+cETbwQDWfzMceyOiRXmH9DBotohKWW7
         izHAztaAxWEgwRF1NXEQ4NjGFet4DOrnOUx7cbKIFR3p61BF7vHgn+dsXL0AqLTvzgCJ
         ub89ypofX63gpbCBEC0Cnyv3g3v1Ol07e1PMQEuTX8AZDRugq6KuvACpsINdFGs5fKpw
         jPcg==
X-Gm-Message-State: AOAM530dZVnzmjMlpSHbRIZtYiBVuXNZkEhYVN49Js2os9Jm/siloK9r
        ogthrSAKEEkYMotZvsl+Pmvv8JFB1+snfw==
X-Google-Smtp-Source: ABdhPJw+i6PwvKZWMwpf68txpOvvTrVZGy108Jn5CqMayRCvYhvP7FteXvGEpFsmhxrgfjfxZPcuxQ==
X-Received: by 2002:a05:600c:c7:: with SMTP id u7mr882535wmm.85.1639715127046;
        Thu, 16 Dec 2021 20:25:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o64sm6325634wme.28.2021.12.16.20.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 20:25:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 6/7] pack-bitmap-write.c: don't return without stop_progress()
Date:   Fri, 17 Dec 2021 05:25:01 +0100
Message-Id: <patch-v7-6.7-776362de897-20211217T041945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
References: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
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
2.34.1.1119.g7a3fc8778ee

