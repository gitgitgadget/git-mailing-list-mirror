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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7F1C43460
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF0F6135C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbhDLVKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242228AbhDLVIq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DC4C061346
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a6so14336932wrw.8
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AqzgF3ydQhx2SGKGBO9a/JEpTg8x4sKJCQWGxp4c3hY=;
        b=GmBA1Ndq9J8MEUwpHEB1mqKTVdB2vhcQLZQdsvjXVdeZ9HQCoC7KNRA2kSdVqtaux5
         xpKBX+tCdPw9oGERbPmSAUPRBAQwIByW42qRXNmeuyU8RfbZWDxppcYsngWdpXhUw0jQ
         Z6HxLR5rdhOMMfuT0bH0acugvVHsuOq73GN8jM/m6UhW6weZGreZFmfZ5DkglnfvTJZ7
         Fsx05nYjPqXlKVe/wjoNkBj+q3a7VCGrOaywb4MUAdJOt9TYPE+XbeDxf0SCQ03ukZgi
         +m0njWU3LYPodSUhMVNdOvEynyF7edmmxuf/RZzzG2Jmv8L+6lWFIh4FExCQ8DYhRaWU
         0zeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AqzgF3ydQhx2SGKGBO9a/JEpTg8x4sKJCQWGxp4c3hY=;
        b=XWLvnjrUMZHz8q6F0qeISfVmbLqFgv8KatE2t3hi2wRf+8ri36zYNLbTvGPY5NDazt
         Vdbe31e+zq3ISS5SvXrR3M9IiYaVstxGuF5XF7WmArNi09NauRX/rgmCrUvZkIJeOwNo
         NL4dL28vDA6SuewcsW01XaB4ezM3ECGuTDq83boYRzxSiNdhq/1PUJQ4VDT5OuyywSVr
         EjkT3hRKBNNorWhyqmMZCL3majRt4JdT0YoMdRNrXly1o8JjbssvLyVBCUsO3HoHNn3r
         aCLbsyip+g3REJhOhrh5huRt4ECIi0RKJlgNY76uil/nYfJqB8eAcEKOPNwVfVruIJQH
         h/kA==
X-Gm-Message-State: AOAM530yOgGwNcfIs5jegiTDI8xlWCiKTTZr7oI662fxy/Nh8OcGAoMs
        0E8OyLMWdtU9ZAIU+YUrzyS8jKktJJA=
X-Google-Smtp-Source: ABdhPJwh76+KDpVvwnSgMouNceeB4CBvOtLL0rv50nabKCObCW6wbrZ/lqRFswZgy4Mi1ahOumYElQ==
X-Received: by 2002:a5d:47c4:: with SMTP id o4mr32759024wrc.138.1618261706275;
        Mon, 12 Apr 2021 14:08:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s10sm46659wrt.23.2021.04.12.14.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:25 -0700 (PDT)
Message-Id: <97124e9fdc7f21d1f82162b8269551c023392fa3.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:02 +0000
Subject: [PATCH v3 11/26] grep: ensure full index
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
expanded to a full one so we do not miss blobs to scan. Later, this can
integrate more carefully with sparse indexes with proper testing.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/grep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 4e91a253ac3b..c2d40414e975 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -504,6 +504,8 @@ static int grep_cache(struct grep_opt *opt,
 	if (repo_read_index(repo) < 0)
 		die(_("index file corrupt"));
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(repo->index);
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
 
-- 
gitgitgadget

