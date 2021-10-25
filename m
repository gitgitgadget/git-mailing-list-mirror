Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFD5C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D7560F9D
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhJYL1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbhJYL1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 07:27:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F6C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso12719044wmd.3
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hzrp3g5InBMk/hfmZl1PkVZ3dihy4kchyTa4C99GeBo=;
        b=F47OoBDBrP9+I7RDlXfZu4iCYLJBI/hjZf4gmHK6fZq5P9Q35jXVG2DA8XTEZABkO2
         sGBQt6PWGmVAlk1Sn7UVHPcZ4GCJiWT5Xn7bxbcnGNUOuXWPwSwq/y7pFzLcy9UBrGiH
         WXO2yFWzsA4R/cLPJnywsHsZtBoAyr1GoHjScboB+wy7FqnoAQg9j5fdRprffbmbZQ8z
         lKZLsPpB4HTIKQ/1cxOq4Mu8wCOn7gNtM1nKgolNzrL0/x18AS7sQHCh61ZafVv2O65j
         RNsU/j+amJYdzOF0pRjAkhnVcXgaoF4ldn/qZMsxdg4lGOIyjErpjH5fyyEnoKPwU+4i
         uV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hzrp3g5InBMk/hfmZl1PkVZ3dihy4kchyTa4C99GeBo=;
        b=cVG6GF1V4tY0inl6ZyylOE5SxKDE4JOqlMhPuhXm60F9Hgd3RNtrgvbL1PJNx+tsbR
         VGK6EwDzn2kzfKLDalfQ4qE3cIE6HIML+XZY71HZbZgAyJWpMkZVexYVTtDujKG3fXC0
         fGeSO00EvkwZK8o6Oe+v6dAUH5rSY8WpPmYi7epSn7xVvQSI6nhbYGXNbhV89IBTljdX
         h/oq2cPrHrM/A8pR80L/QEtIfKulM9Cbg6I3/jbJQrlhxPA9fWJuM78flh+pDGpzPfMW
         3L1CnxqpzEEGkRvylfD3vdtnWXspk76M6/6Fnxr7b2Imbi3H2JxUTRqWgpMPRpBWCcDG
         bulg==
X-Gm-Message-State: AOAM532dHz/tLftrVcUr6/+1F9l1MguJ0dQDPDs3Ww3MRLogM6dtsjC+
        M0h4AXU4nRtPZO9mxGZifYUceEfW5Gkklg==
X-Google-Smtp-Source: ABdhPJx5g+lN+4VbCNKx/iTLwliHEmo+7oz6enKR02Y7pbcjDT3/iJRs2h8bfIG6Y9T0BXkK+7ni4A==
X-Received: by 2002:a05:600c:3782:: with SMTP id o2mr5921993wmr.102.1635161114686;
        Mon, 25 Oct 2021 04:25:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm19021993wmi.1.2021.10.25.04.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 04:25:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/8] pack-bitmap-write.c: don't return without stop_progress()
Date:   Mon, 25 Oct 2021 13:25:05 +0200
Message-Id: <patch-v4-6.8-3dfe31decff-20211025T111915Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1510.ge5c82eefb93
In-Reply-To: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
References: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
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
2.33.1.1510.ge5c82eefb93

