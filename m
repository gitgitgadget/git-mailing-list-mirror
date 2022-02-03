Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E846AC433FE
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355228AbiBCVkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355419AbiBCVki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:40:38 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5E8C061759
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:40:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g18so7240962wrb.6
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cfw4kS5PHnzrHd+0EMmKzUmCahqYjc0DYdcrj/gIj5M=;
        b=MktiEuo2Y10jJ+a1eRLAYeVFHDZUQZBkCxsPTSZuPA7tPjoVIJBTuJigNkYbCAaWfE
         50QUkozAosqS4GtGG5yFnRkV2RrgJkLu5kZSGg6qlc4OuVEpHTseaJ6pdnUgu9lW6xOJ
         1497+FbbsfjFJwU7CB2/rqoSqePcXn9W0cJp1pQ4NFm7BaLACXSvbez6dm2bVJ5vhJ6g
         Lb1jYVW7lLzvErMU+MkxJqBWS5e3pWMvMcQRPLRvPEzVWxcBP22SdX+16A87j9xbFB3C
         zA1qKFLIP+GqlPfUuo6o7DWNooVkg/9SJ1VxvI0SVyvLMucEMJd1kOs5DFkKrZcZ0UK1
         tusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cfw4kS5PHnzrHd+0EMmKzUmCahqYjc0DYdcrj/gIj5M=;
        b=W6/kj4o3qsAFy/aqTIdSfO2IV2ZRZxQ5L+9ChpSqv5WSVdDyz8cXl5VFkz4th1beqT
         OQezmmyY3Dl1DO1YpmWpdk8TTts19jgYPsIjwgalF2yW7Xadudp1KS9ed8KMu7Sa+ubc
         MexUVlQwH0iAB6ohOps0hZV/PYJediK/g+5vw2LJhgS/Mc2yzMr8fifjdggKc5CUkq14
         xwGZaoNr5ZwkiLmgywlsWlfgmDsbzvkOHy/JdB9d+x834eSnt4arF22mfcf4AT02+VcH
         JizHDQPDXhOeIjQ8QkTs7pHSBRGlzYg5bon4whDmbu2iBmVNjvhakEL0ikUa+v4lrrsi
         awVw==
X-Gm-Message-State: AOAM533cYjmLaBEknZXkwek9/SjdeaJ2LmWI/X5c8TCpQMth/qHVkzTH
        dIHPaah0a4pYD8FCAPTxuw3kreR1A+B0Uw==
X-Google-Smtp-Source: ABdhPJwUFzxbyZWgjlZ1oQ6s8exlEZsUHkG4Lkn9+Hp2mHyLkMsad9OK0Jdka7vgsL0159n/fnavyw==
X-Received: by 2002:a5d:43c2:: with SMTP id v2mr4525467wrr.455.1643924433494;
        Thu, 03 Feb 2022 13:40:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13sm10637wrf.3.2022.02.03.13.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:40:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 9/9] pack-bitmap-write.c: don't return without stop_progress()
Date:   Thu,  3 Feb 2022 22:40:19 +0100
Message-Id: <patch-v9-9.9-0b2248a2d74-20220203T213350Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.939.g42bf83caa3d
In-Reply-To: <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
References: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com> <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
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
2.35.1.939.g42bf83caa3d

