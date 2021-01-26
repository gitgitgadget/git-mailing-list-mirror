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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA02C433E6
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050C3207B3
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404414AbhAZQFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404665AbhAZQDO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:03:14 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC52EC0698CA
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:44 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l12so17021337wry.2
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1BlroPWhD3y+SmudQNbrVaRfcLBj38002/ZAALSt3fk=;
        b=ddtZbXcr5kP3wtfpERSH/guww9vnCpzIGGssTpG6vhB0M/SjznKWFRGuV5s4LwGAvy
         Gpfx74FdmZH580BOvSpzyXs4jKSpty834DkgL9Juqf9XX6JT0MkCxtRzOh/rjvzAubBG
         leCyifJKY1qwLjZ3loMWamlG0dBBiocBOgXbF805ZRIlvmZiaxVrfktZE2NznxyPYLs9
         3JDR6E3QEjSx4kS4kV1hndgYcu2KdQFXgAFQYepPyaZAumV7FWHh300rTiyI7kqyDMm6
         qvcrLe3zD4s5cQ4pTH5phw6uN8wXJL5/eelrG+CbtP2sQfsEQq7urVHA6TMi1cMSajO0
         ZA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1BlroPWhD3y+SmudQNbrVaRfcLBj38002/ZAALSt3fk=;
        b=TtCbpJX7dYc1CY/mDLAMOMZPl75wPwUEz/Uye4AN3WCOj5zDHQca+71+lymoybXsO2
         l7S2juW/TuN+cPq9C+7ZIXBxfDzpEJbJdIW9yX1D9yLTQQphSUrVIjL/LGpXmVsGseLJ
         JZaRZxKaUHg0L+3bLt+8T5+6F/nFsAAWpPWMhqV11b8QGdYI83ajYQ/uogBgJL13Imra
         /k1vm6PK2wXrXtXOKWGt9M5z0xoKohcxjA/jz+npX5N764Cg+DLVzqNXVm8/WKwhDviS
         RGadxR0PphTQ8a8H5UrQW+Yc+DS0WTwRlFxMGFwTnaZCQDOEzk4Ei6O+ET9IsWko4hLJ
         xj1w==
X-Gm-Message-State: AOAM532iS4S/13ugEs9RZ/RScgncS/l/hjfeY2O7JS+t8Xkw927wEJCT
        DnNN1nNTW/NM/SGb2JplPltEbNuErkU=
X-Google-Smtp-Source: ABdhPJzLH4Eu7dwC3odxb8etyzr9bUDezaUqrVNOuLBPb3AWDKOfSlv+8FvM9pHmWp8zq9BixfzoWQ==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr6733279wrw.120.1611676903237;
        Tue, 26 Jan 2021 08:01:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g1sm27408790wrq.30.2021.01.26.08.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:01:42 -0800 (PST)
Message-Id: <62a23842aa650d6f56d5d258cc76fa56a547c088.1611676886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 16:01:25 +0000
Subject: [PATCH 16/17] chunk-format: restore duplicate chunk checks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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
 chunk-format.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/chunk-format.c b/chunk-format.c
index 674d31d5e58..3c833038096 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -14,6 +14,7 @@ struct chunk_info {
 	chunk_write_fn write_fn;
 
 	const void *start;
+	unsigned found:1;
 };
 
 struct chunkfile {
@@ -98,6 +99,7 @@ int read_table_of_contents(struct chunkfile *cf,
 			   uint64_t toc_offset,
 			   int toc_length)
 {
+	int i;
 	uint32_t chunk_id;
 	const unsigned char *table_of_contents = mfile + toc_offset;
 
@@ -124,6 +126,14 @@ int read_table_of_contents(struct chunkfile *cf,
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

