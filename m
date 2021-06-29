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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C48C11F65
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6982661CCE
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhF2By2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhF2ByR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:54:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616E5C061767
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l8so14891343wry.13
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H3+gKjSmAWwdDpD6Q8E+pdKb8nC0l5EqTOcc9rWsUbM=;
        b=ckNrCAeZbIcJBEza7MtFilLRpIu6WRSVo9bivcr0F6CXjoDdixuDLjgsFS6HR9aCtc
         yzsiyEoaDrZuK3tMG57fYAqTSziAx6k4dvRrrJXD+XbRlaRLimr+uMsqHWU1lSEPDSIt
         s66PfTCHSpN+ZA2bOe+qLHcnLdccee+IO3ir9Q6py3WpwjLLGj48M2uqixLUB8wFaq56
         6krSxOv/SEpAJtR390psaZ9et4iFpcq9qdbp26M+qlWyvSZWtbdYGQzLy1ndl0QdVK2H
         SHu8u5Wa2Fr7pQXcfPofu5BICIKokrG8hDvvP99YoX+DiM3KAqanetamMpRudMSOx4rZ
         3X5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=H3+gKjSmAWwdDpD6Q8E+pdKb8nC0l5EqTOcc9rWsUbM=;
        b=VDFeXzTW052W2swDGWpmYiUC1QJThjVlZf5wGmTTuXLDrLyByOfWaDlKhZq46/FJoC
         3AfuOf3PIyLzuC47gXK58nR6VDm7QpIMpH9F4KNX1ymt2bA5I2hXlI0UxoUt+CXXZV/9
         TJ/lE2MQynXAwI9+uQ1ptzLRUuQ1t2GCVeyL3IrtYD7OjjgROWAV/ejlPBCQoTNSni9o
         bmnhxiQYxnWeTv1AnVIwAHNiHVUuMTTbyadJx+QhrKLCBj7napDa8lRJRKWlSm7dF2TK
         37cnLzY06JQlNnDYBH+Lnk4MI+zWHyElfcITlLEjA6KlttsdFkRJvZUwvX8zgODv8A1N
         LbQA==
X-Gm-Message-State: AOAM532GSp/axiFF7KxwdMBL6BDSUKQvrn8RUCps5QBSS0yGknOLDRoi
        ARnCtzWV7oW4sKzUFigYbBTat91bAzM=
X-Google-Smtp-Source: ABdhPJyI0EGTTbOc6CyD8q92O2WBUWBQ+avXPx935uX6iU1sC1rOcWbSi4ep08htyFeZHh1Ddmhheg==
X-Received: by 2002:a5d:6d81:: with SMTP id l1mr29941168wrs.282.1624931508071;
        Mon, 28 Jun 2021 18:51:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 22sm14936776wmi.4.2021.06.28.18.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:51:47 -0700 (PDT)
Message-Id: <6fc898ac23e244b3f9c1406badb89441945c6e18.1624931502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
References: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
        <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 01:51:35 +0000
Subject: [PATCH v6 07/14] unpack-trees: compare sparse directories correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As we further integrate the sparse-index into unpack-trees, we need to
ensure that we compare sparse directory entries correctly with other
entries. This affects searching for an exact path as well as sorting
index entries.

Sparse directory entries contain the trailing directory separator. This
is important for the sorting, in particular. Thus, within
do_compare_entry() we stop using S_IFREG in all cases, since sparse
directories should use S_IFDIR to indicate that the comparison should
treat the entry name as a dirctory.

Within compare_entry(), it first calls do_compare_entry() to check the
leading portion of the name. When the input path is a directory name, we
could match exactly already. Thus, we should return 0 if we have an
exact string match on a sparse directory entry.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 87c1ed204c8..7a507ddfe05 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -983,6 +983,7 @@ static int do_compare_entry(const struct cache_entry *ce,
 	int pathlen, ce_len;
 	const char *ce_name;
 	int cmp;
+	unsigned ce_mode;
 
 	/*
 	 * If we have not precomputed the traverse path, it is quicker
@@ -1005,7 +1006,8 @@ static int do_compare_entry(const struct cache_entry *ce,
 	ce_len -= pathlen;
 	ce_name = ce->name + pathlen;
 
-	return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, mode);
+	ce_mode = S_ISSPARSEDIR(ce->ce_mode) ? S_IFDIR : S_IFREG;
+	return df_name_compare(ce_name, ce_len, ce_mode, name, namelen, mode);
 }
 
 static int compare_entry(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
@@ -1014,6 +1016,15 @@ static int compare_entry(const struct cache_entry *ce, const struct traverse_inf
 	if (cmp)
 		return cmp;
 
+	/*
+	 * At this point, we know that we have a prefix match. If ce
+	 * is a sparse directory, then allow an exact match. This only
+	 * works when the input name is a directory, since ce->name
+	 * ends in a directory separator.
+	 */
+	if (S_ISSPARSEDIR(ce->ce_mode))
+		return 0;
+
 	/*
 	 * Even if the beginning compared identically, the ce should
 	 * compare as bigger than a directory leading up to it!
-- 
gitgitgadget

