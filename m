Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3150DC43332
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F5864FA8
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhBEWMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhBEOmy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:42:54 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5406BC061797
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:20:20 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m1so6352295wml.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IcnHLWkBF0/Re8l3DLlTqp0+tCWhKAAetGgWdWH9LR0=;
        b=hDzq7RbxzJrcyNa7yXuhyovnx1sPxmpk5lEo5taAi+RY8Z2h7lLCvyyd7ezZCR/ZEE
         5G+xtrcmjVHZjCJsnFrI8zwH+7Kn6agXUoVabBMaSptjBlXoE/lbKO77w9+YTcYDTAlm
         8avvKRBzuSuGinJQa0wa3Pop8tFMn7nkTHlkb2WIBXe87htKMSlUnda4u9YfGwMmbAeL
         fnLbFqWMjSR1EJzXnhfZ2+94HxeN6gFnwYAH77GsrjpHXqPQQ3L5GJRRLruGDlerpQU5
         HHicsJBzUUIgbwKkZsyCX27fLNDoTi3s8sJUSivDl+cqBJ5YefFvpOGUlQ7bFWVFgPdm
         4Mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IcnHLWkBF0/Re8l3DLlTqp0+tCWhKAAetGgWdWH9LR0=;
        b=m4Byp1Ukpq3pPyqi742x55BVsisiIxm8KRh6L3MZ3iFUQDwXWETiKz9bp2zKq5LPhw
         V7iuTkLoCLxZhNKiSV3P90oliVSo2xHDah4v4nSAgZc2OtyGFTmfKUJq9iIFB7Ifctil
         nrRRw4ES5nNzZCFDSEN1cRgRcoYFejSDCAwIaGGDg/hyi54EkQ9IoRYkxcJraHP4f/rU
         +afowGkdBMqf2hUUkHdObdADiBqs1eAJOZDWDq/Th5g+WuOUz1wCPUrplzbx5xDGJ85R
         efxsB+7KJv5z0Ubnlia0arSCmoQETKXbVyGOJ3Wn51bxfAggig94m4r4c8ZM8z+7eFqN
         tFnA==
X-Gm-Message-State: AOAM531a7Pq/Uglrqjm6XZj/aFk1HsTzdw/j/PxqS1gXTPSdXAIgpqzK
        G1i4eUCTbRKJDqsvt0zbaBhu3GlED18=
X-Google-Smtp-Source: ABdhPJxfww7TplHF+vlen6Rh6QcagWs5bgILwtDUGjj3tJHWaTz5drBt8ChjxWxQad232kYriZ0fiQ==
X-Received: by 2002:a1c:e402:: with SMTP id b2mr3919587wmh.122.1612535471162;
        Fri, 05 Feb 2021 06:31:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm9452189wmj.23.2021.02.05.06.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:31:10 -0800 (PST)
Message-Id: <b9a1bddf615fc1d725ffd1203669d0158296334d.1612535453.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:30:51 +0000
Subject: [PATCH v3 16/17] chunk-format: restore duplicate chunk checks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before refactoring into the chunk-format API, the commit-graph parsing
logic included checks for duplicate chunks. It is unlikely that we would
desire a chunk-based file format that allows duplicate chunk IDs in the
table of contents, so add duplicate checks into
read_table_of_contents().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 chunk-format.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/chunk-format.c b/chunk-format.c
index bc9d4caf7276..e4889d9efcd1 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -98,6 +98,7 @@ int read_table_of_contents(struct chunkfile *cf,
 			   uint64_t toc_offset,
 			   int toc_length)
 {
+	int i;
 	uint32_t chunk_id;
 	const unsigned char *table_of_contents = mfile + toc_offset;
 
@@ -124,6 +125,14 @@ int read_table_of_contents(struct chunkfile *cf,
 			return -1;
 		}
 
+		for (i = 0; i < cf->chunks_nr; i++) {
+			if (cf->chunks[i].id == chunk_id) {
+				error(_("duplicate chunk ID %"PRIx32" found"),
+					chunk_id);
+				return -1;
+			}
+		}
+
 		cf->chunks[cf->chunks_nr].id = chunk_id;
 		cf->chunks[cf->chunks_nr].start = mfile + chunk_offset;
 		cf->chunks[cf->chunks_nr].size = next_chunk_offset - chunk_offset;
-- 
gitgitgadget

