Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB4FC433DF
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 06:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99AA12065C
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 06:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC+ZQAxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgHPG7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Aug 2020 02:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgHPG7P (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Aug 2020 02:59:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4554AC061786
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 23:59:15 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id 88so11860975wrh.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 23:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JArmeROMmkV4jbhZczOcNlFtBp4VTj32CPteB0gmQQ0=;
        b=lC+ZQAxvLJKpzqxGljA2fZSK0jlblSIQV+O7zSaUORtneB4x5P8xSq/uK5riXlqBGe
         zp5K8KCp1kxoF6UMMCwcYbdVXTNSPx1hi822omi6v3GQ9tezJSNQYlcfLvTuZrEFnMMr
         U0xzYHtP1bk9OGdLZ8YACaMB53knKhBXbDXhYN9W6xqMjqzt0zKP73BxqgcX4aFDrP0n
         dhV5L0ZrbZx8Z9ZjoxD58+swmip3HsNy19QhI/1PNXGZlexjT4AZ8vy/kADwVHsdxWYK
         eIMZE/chO2aVHhr41bDdjbyevSIMtUAS5dY5AZnbaT5/dUSynn+gIf4BaCxLBS09bbdG
         6Jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JArmeROMmkV4jbhZczOcNlFtBp4VTj32CPteB0gmQQ0=;
        b=XvzbqmjWi0ONhDHI4ZEoRkO9Zemn/cSuQQaVMTUyPa7vi6x8NfOoA8OhhVGukm0cHN
         eh4u6n0ZW5NIdUVPBqoeBxsOCnYe+gQh9RH66UhQ/vNCFjHX1SULudmQn6z4INBJ6eNm
         6YQ2KYOd9S39LRIMfY1pyP/jnSgWZcgqcxesSlbzBTc83FjxYUzJIUiIsT7Ej7MHTdzJ
         TOjHm853/4bxtg3lg75dFXlgAoN6CKw6/4/Ti2lJl4SG81iUMoRcNafmc0vm1rxr8Pua
         XQv0WtPbSwernWsX/S5xCdWokQ1PGvtuRHHuKlE9WD7sYpA/Lcb69yUIDstQQ3qIi6K2
         TCbg==
X-Gm-Message-State: AOAM532ucm7Qqa5e3Liw1OmVl+kfmjKqM9SVqR8rNQ1jnU+onn5LK0PE
        0nCDCpw2fJluvJ8XQ2TDvsBTuhegAdU=
X-Google-Smtp-Source: ABdhPJzfTbO0a4+CkM37VbVKDWOZFtbn15YBdmms6p03p87pYK5EABiwjSxkdVO0tGLrc+kxFFCJCw==
X-Received: by 2002:a5d:4604:: with SMTP id t4mr9497250wrq.417.1597561153817;
        Sat, 15 Aug 2020 23:59:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i4sm25490399wrw.26.2020.08.15.23.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 23:59:13 -0700 (PDT)
Message-Id: <932741d7598ca2934dbca40f715ba2d3819fcc51.1597561152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
References: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Aug 2020 06:59:09 +0000
Subject: [PATCH 1/3] dir: fix leak of parent_hashmap and recursive_hashmap
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 96cc8ab531 ("sparse-checkout: use hashmaps for cone patterns",
2019-11-21) added a parent_hashmap and recursive_hashmap to each struct
pattern_list and initialized these in add_patterns_from_buffer() but did
not make sure to add necessary code to clear_pattern_list() to free
these new structures.  Call hashmap_free_() on each to plug this memory
leak.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dir.c b/dir.c
index fe64be30ed..08df469bf7 100644
--- a/dir.c
+++ b/dir.c
@@ -916,6 +916,10 @@ void clear_pattern_list(struct pattern_list *pl)
 		free(pl->patterns[i]);
 	free(pl->patterns);
 	free(pl->filebuf);
+	hashmap_free_(&pl->parent_hashmap,
+		      offsetof(struct pattern_entry, ent));
+	hashmap_free_(&pl->recursive_hashmap,
+		      offsetof(struct pattern_entry, ent));
 
 	memset(pl, 0, sizeof(*pl));
 }
-- 
gitgitgadget

