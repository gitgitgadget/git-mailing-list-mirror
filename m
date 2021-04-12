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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A521C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C24160C3E
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242786AbhDLVI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242396AbhDLVIr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211D6C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r7so2331997wrm.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DOjJ2jNd1O2RVKGUUk1xSCeZyh/PdDSjmF8DqHmFsvk=;
        b=m4GXazeo15J61SFZm3gvgzOFnqs26iH/pEKNhercknlx72nBN6Dfni71KHvwHQtAkE
         okjiR9RCBlBTfbd6WuwhtpKSIAeo7TLxGCdkR2ipYt/976MRkPjqdmHGx5AkfI2y03AL
         YlQ/Nbkj4pMhOeaCiTpMB3tipcV3RWNw+88KG8GXk6c5835P6rIDPhqZPFJo9j4otTqr
         E1agUS+sq6+zIuw1363+oK0/IbxHZY9kE5qeQRIP3ZChTsoiJY7RYYgBfXVMhoTCakcF
         1yFo0kkAw7hOt+BfePcZSmZUD/Ss+dgspbbHwQ/sTlQoa1c289qqaavslDpnDwS7Uvco
         IPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DOjJ2jNd1O2RVKGUUk1xSCeZyh/PdDSjmF8DqHmFsvk=;
        b=qzisimKcq5Br5HkfvZqHcrmiOIUzKuutx09D+K0BdEG1l6H9u6RA8ovV0tYofJj1uz
         TCahVOWN+hRCIlIynkxwo6QTetToSF/brcjFjCi6fnYocZYZ2H7Cz1aLxv6V4fiTMTVA
         tDKveF1KYjbVXYrmx84u8EqhbthVWtMtDfxfPhWE7ovyIR0ixqrlAYjTUuG7RYifZeX3
         +ggtqD7E/b09IiV8Q4H/9W5XKe4+XrF14+3wB1Yojb7ifInMbMmXita3Hnf4iNyUu8Rq
         MMuqmMOOKg27KsB81oPhZIFT6LZBFPtTBSzlcCpMzoA6pEOw3NW89D0+akbtXJi9a2vs
         qJAA==
X-Gm-Message-State: AOAM530Nn9HBvd2O5Oru3SDSELpHoWL1aqr1kvFOTfBHj09kISKYKrn7
        0HMF7jwCP0NkaY4aZEiOXOoFn5y3Dso=
X-Google-Smtp-Source: ABdhPJze1dMbzF2niAdR2+o64tnjishDe3z32+s2Q1f7j4AJ7RaeU5LoqoXQZzSvQC42dswaFm0GfQ==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr23274132wrx.19.1618261706913;
        Mon, 12 Apr 2021 14:08:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y31sm477809wmp.46.2021.04.12.14.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:26 -0700 (PDT)
Message-Id: <b00e214515e842f0a4fdb6a6493dc83f3ee17398.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:03 +0000
Subject: [PATCH v3 12/26] ls-files: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full one to avoid missing files.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/ls-files.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 4f9ed1fb29b7..a0b4e54d1149 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -317,6 +317,8 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 
 	if (!(show_cached || show_stage || show_deleted || show_modified))
 		return;
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(repo->index);
 	for (i = 0; i < repo->index->cache_nr; i++) {
 		const struct cache_entry *ce = repo->index->cache[i];
 		struct stat st;
@@ -494,6 +496,8 @@ void overlay_tree_on_index(struct index_state *istate,
 		die("bad tree-ish %s", tree_name);
 
 	/* Hoist the unmerged entries up to stage #3 to make room */
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		if (!ce_stage(ce))
-- 
gitgitgadget

