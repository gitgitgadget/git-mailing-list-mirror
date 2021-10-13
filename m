Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC38C433FE
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F6D61130
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhJMWap (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 18:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhJMWak (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 18:30:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AD9C061753
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v17so13147739wrv.9
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1oYIMLm/YDq6Ixuqi2fTr+luLXPqf7kd6iZVq8i76Hs=;
        b=GoHJ29MmJOpPlvrZyAOOeI8PAzc5Bih7Z9f4cF4i4O6dDaW5tw9aEwH2zULaf4kNJO
         OwDoxm4cN+xJgfOHU6ppqFhT+NCRty2gn5HngK06NNorzWS6KF/ZvduDPoRIwFbdbK42
         pNGeZRKJtUqC9JbJdj6we57B3KK39H4tDe2GU+tHOBslEFxNb3mcVAa8JmyXk3SnoANy
         stv9GJ/4zUMlDLCDkeOWQOKbuSunjxbFQ+51Q1GQr8ARGn96wAUiEyzCi8pkPb5yCx1+
         PXEShpzX/64K6SaXGTrhDanA5z9u4swhPPupIHWaq9gNPQq8+XdZZP1/Az6z/5KoZGEP
         2j7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1oYIMLm/YDq6Ixuqi2fTr+luLXPqf7kd6iZVq8i76Hs=;
        b=3ydyfe2WxnqySDqdOEqvzyQqC4VsCDei2vbg5f8ovmz20nD44WslU0DeBEf5NYMFkq
         BkTW+dMCOZOYGbRPFh4jHR0iXNqNNgbxofIGiyWOgVOPEeodpPfiryyuA0FwzPVDRhdr
         Eg20LTgFwov4XoH4wT9IHx1YI36ER2enjSqBr1Qc6gav8e59Tjd9rbwuB7XFSEeqmZaB
         NR3ydvukOmfbEWec+y2M2/PBqveXTs5yL5+x47Ir7A4CwCNtHHJsZcudefoRKiql1tfQ
         BfDGmAR/rtXBjPIMwRRZej3IDp8hhIMZHnGWiCSqpwJ75GIsBwfnK0vcoRoAnE4AMx5A
         3Q0w==
X-Gm-Message-State: AOAM530i7BZmReS9DPGr4Iw32CmPlpM2QlzUvzAGKuRSLnaRQ38iH6yS
        Q7VpVooIANWyAQsuLTYvcK+yBWt3o3fCsg==
X-Google-Smtp-Source: ABdhPJxcOFWwAIyhl4HdzFSrRg9+dTQh/9LxaWYIvTnCfm9OcVA5nDBjcCW/Jc/Opi1jrh88Wd6LRQ==
X-Received: by 2002:a1c:1dcb:: with SMTP id d194mr1947127wmd.156.1634164114816;
        Wed, 13 Oct 2021 15:28:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l5sm736683wrq.77.2021.10.13.15.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:28:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/10] pack-bitmap-write.c: don't return without stop_progress()
Date:   Thu, 14 Oct 2021 00:28:24 +0200
Message-Id: <patch-v3-08.10-e0a3510dd88-20211013T222329Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
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
2.33.1.1346.g48288c3c089

