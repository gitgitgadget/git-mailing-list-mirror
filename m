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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03818C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6AD122B3B
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 18:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbhAYSA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731009AbhAYR4V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:56:21 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75008C061224
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:35 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a9so13816483wrt.5
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C4K9HzfTJGIydN06TzEfi5PvtGP8wNfAxqle/0fCqkI=;
        b=UBFFoIjDtBRDV14Nyk4Adz/C5bJW/8tglfat9j6nB6hi2v0zEbet1Dqevd2zGKpJFy
         mQfgD9s+fOsPrdacvWfNvH0FnKLHKomDfMZTFwLak/o3vYZ4Pq9bTrCaAHuMThfrTk3u
         MiweuHzjxQvUMH0VFUa/pu+gg+9KllL86v6NnJ8O3Y/3hkuTKga4WgbJ9fRLNZFYLde0
         FE88DyElCSOBhMvIWdPyBFTjx6X7rB3/hoGDROtkyflXw6Q7xxCQzS3Ec0HmcVgTV2jS
         hTacxRD81Bbngbk27YewwtU8Y6bTgB8gIM3b1tJM4aKpt5+z5UuOaRfuR/lT529H9wdp
         lXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C4K9HzfTJGIydN06TzEfi5PvtGP8wNfAxqle/0fCqkI=;
        b=gIA+aacsi33LIkqtOOG1rAVcDzecRDkyKFv5dUkMzFOau4krxr4BdAuriR6JKRfGs5
         QVEpRgdf6EWNaB41yh77HM27D8AVGvCmoGm9Zjx4vA5aKX8Q8XEIfafi3W2WhLNuovSz
         6CDrrHQTd9Jkt1VoQ2aSlJRcBRxDaCFhDQrIiMtGXNIHB5L8lIIdKcwqIGDG6Sspq+tK
         zs8dTBUfHunGRGg7oZEBIWTX5LBgU4uexceXxEC3qtzk0iEdLQCDZ5ZIXASjpFGe2RbU
         j+cDlXymqv26SX2A2WUvDeUrKaeaatlUKCBfTM8W9iAYtKFwvRCNzOJ9P4lq2O/p/w19
         vdGw==
X-Gm-Message-State: AOAM531o1XpRYon/pc+RhJkJsGYAUtXPCSLX8QQvOUmb2TL2Ff8pjbOH
        5Fm1+5FhyztwByNOSke8NdNZUctbDvI=
X-Google-Smtp-Source: ABdhPJwrNi0btRo4Yr2S2CA//e3HY1VROY5T13TqPG3AZzY/BdXtc+QtvinC8KZ9Qt5yC/+F1H8WfA==
X-Received: by 2002:a5d:538b:: with SMTP id d11mr2285784wrv.334.1611596554060;
        Mon, 25 Jan 2021 09:42:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m82sm17920wmf.29.2021.01.25.09.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:42:33 -0800 (PST)
Message-Id: <dfbafbde3f54333dc27a18e46b5b79573f015e60.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.1611596533.gitgitgadget@gmail.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 17:42:07 +0000
Subject: [PATCH 21/27] sparse-index: expand_to_path no-op if path exists
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, peff@peff.net,
        jrnieder@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We need to check the file hashmap first, then look to see if the
directory signals a non-sparse directory entry. In such a case, we can
rely on the contents of the sparse-index.

We still use ensure_full_index() in the case that we hit a path that is
within a sparse-directory entry.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 name-hash.c    |  6 ++++++
 sparse-index.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/name-hash.c b/name-hash.c
index 641f6900a7c..cb0f316f652 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -110,6 +110,12 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 	if (ce->ce_flags & CE_HASHED)
 		return;
 	ce->ce_flags |= CE_HASHED;
+
+	if (ce->ce_mode == CE_MODE_SPARSE_DIRECTORY) {
+		add_dir_entry(istate, ce);
+		return;
+	}
+
 	hashmap_entry_init(&ce->ent, memihash(ce->name, ce_namelen(ce)));
 	hashmap_add(&istate->name_hash, &ce->ent);
 
diff --git a/sparse-index.c b/sparse-index.c
index dd1a06dfdd3..bf8dce9a09b 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -281,9 +281,62 @@ void ensure_full_index(struct index_state *istate)
 	trace2_region_leave("index", "ensure_full_index", istate->repo);
 }
 
+static int in_expand_to_path = 0;
+
 void expand_to_path(struct index_state *istate,
 		    const char *path, size_t pathlen, int icase)
 {
+	struct strbuf path_as_dir = STRBUF_INIT;
+	int pos;
+
+	/* prevent extra recursion */
+	if (in_expand_to_path)
+		return;
+
+	if (!istate || !istate->sparse_index)
+		return;
+
+	if (!istate->repo)
+		istate->repo = the_repository;
+
+	in_expand_to_path = 1;
+
+	/*
+	 * We only need to actually expand a region if the
+	 * following are both true:
+	 *
+	 * 1. 'path' is not already in the index.
+	 * 2. Some parent directory of 'path' is a sparse directory.
+	 */
+
+	strbuf_add(&path_as_dir, path, pathlen);
+	strbuf_addch(&path_as_dir, '/');
+
+	/* in_expand_to_path prevents infinite recursion here */
+	if (index_file_exists(istate, path, pathlen, icase))
+		goto cleanup;
+
+	pos = index_name_pos(istate, path_as_dir.buf, path_as_dir.len);
+
+	if (pos < 0)
+		pos = -pos - 1;
+
+	/*
+	 * Even if the path doesn't exist, if the value isn't exactly a
+	 * sparse-directory entry, then there is no need to expand the
+	 * index.
+	 */
+	if (istate->cache[pos]->ce_mode != CE_MODE_SPARSE_DIRECTORY)
+		goto cleanup;
+
+	trace2_region_enter("index", "expand_to_path", istate->repo);
+
 	/* for now, do the obviously-correct, slow thing */
 	ensure_full_index(istate);
+
+	trace2_region_leave("index", "expand_to_path", istate->repo);
+
+cleanup:
+	strbuf_release(&path_as_dir);
+	in_expand_to_path = 0;
 }
-- 
gitgitgadget

