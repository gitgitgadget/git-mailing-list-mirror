Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540BDC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E95B6146D
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhBRQxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbhBROLL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 09:11:11 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35CCC061221
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m1so4073300wml.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XXFb2RG+oHUGoAOF85mt8265szVQ1fzxkOUTQ8bMNVY=;
        b=FMU8GlkdlqlVtuxkzoNroRFRXyH88+1h6K9yo8YY9wZETFCpz6y9NVuD+ixHyU2osW
         CQHI2wNsa0muFE1BqKbsvbDVtEZmAI2gmxwf1S5DH9LAUmuRDY+vzaGi2ACJjR3xR6aw
         NHxVYAGsA9H/e0OSVL+tEiwaXGu0bXMrusQP7v8/NZI6Y/dH5TP/fg7fbQi+9cz8oIKd
         ewN3/HD94O7vnq+BqIY/dsQ5qscqO3aZmikLHnssqqU3BBNg+g4evI2eqoxq04IcKT6H
         XXH4sQOmAw28bi5++fwSrh1GWYvOw/a1mTUKL9orB8JySTFUD5pQWmOkeRa89WJkQVxz
         43vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XXFb2RG+oHUGoAOF85mt8265szVQ1fzxkOUTQ8bMNVY=;
        b=He0El8fcScZd0K/DGWtAPBRhklwTe1KsaueFQdoMve9hrPlep8oTqz9FrNntfB9XkC
         scNfA+9+azQ50tj/0K/oLc6Cyf+UaBvQ/5lY+0BG42jxOeyTMM2aPnwc+p2pjxQJQtgt
         thdlM4WdZM+KHG5/KUfdL7GlAfEM3y1IP+ozOOGfEWsBCFyy4MO+zHhb1Y65JFj7yo7O
         lkllgCN4lr1+4klqccdF/FAaAZuhVY3/QfwVgPkP1Jm2p9u9m6Nj02ENjouiBoc531pk
         4kclRpyqw7Tlg6zzHx2ORY1XWrabaMRySS22KLQ6mxDZGY3nbHouf/6Z+lnu5JPwbZGW
         rBTg==
X-Gm-Message-State: AOAM533BuHXVoFl1gQkQ82eD3XY1SkL6m+lvN92J6N9nhxPIUK1/bfco
        W3lTchJQBjgCU7McrDBW89/0twKNYlU=
X-Google-Smtp-Source: ABdhPJyIU6xg8uLPR4CrewIFr1m6tvHHuhTYRnO9ZAX2EUYfnDKkM7CoOplNn3RPCgqBWA7ZQEDp7w==
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr3779720wmj.178.1613657278303;
        Thu, 18 Feb 2021 06:07:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q20sm7529547wmc.14.2021.02.18.06.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:07:57 -0800 (PST)
Message-Id: <0e58218be4185b428aec48a9169134517330bcde.1613657260.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
        <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 14:07:38 +0000
Subject: [PATCH v4 16/17] chunk-format: restore duplicate chunk checks
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
index 2c1fecf1c3e5..da191e59a29d 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -97,6 +97,7 @@ int read_table_of_contents(struct chunkfile *cf,
 			   uint64_t toc_offset,
 			   int toc_length)
 {
+	int i;
 	uint32_t chunk_id;
 	const unsigned char *table_of_contents = mfile + toc_offset;
 
@@ -123,6 +124,14 @@ int read_table_of_contents(struct chunkfile *cf,
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

