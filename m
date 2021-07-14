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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A811DC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92541613B7
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239438AbhGNNPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbhGNNPk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:15:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E31C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso3864274wmh.4
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Gxz7lg+EC97gwS4D1zzmrOJ2y0SAeCKUWErdEll8pN4=;
        b=l8a1sk9f7Y8h8n3TzxKqGfQ/SwoCDtYZG/+F9wLVkC9WEPX60XlC2M7fOEf3nVTnm0
         jlnSgt42fFzj5H3WrZQ7k7asZbFLoyYJ4BcvNW/1o4RmeSH8Ws9x2GUs7eeRE4ca2P1g
         TuxBC0t+LE2ZxnHIeexG8e/tsdmGu9oUEg/Ui7/ypTQpKNamalq10HChQDRnAVdIM5Bs
         0GbG2IXWqaRmBs45uCtgSWwf03E3R1IIWjQ7yLh+GxApNCYmtwmd7gnwaLBAPBqweBMU
         eKk+Qylx8MVNTIHj68Ux1C41biJsJEVVtFzMznVOm6muz2MYg7EPnm52CElawYUnAYcI
         pTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Gxz7lg+EC97gwS4D1zzmrOJ2y0SAeCKUWErdEll8pN4=;
        b=rZsaof97xB2XU0frE6DTIWyKywJL0ByzF6BYy2kNYga6r94w9POSympkqixxkXWtp+
         KkaKwxKVov1M9OKOv2v8kZZ7qznfhDTSDafr4NHm6mF6ZPcTx8AR0gLKJ17CqHgFx2ke
         xGzoakyfoCu9UeTA5Otlkd01uC7W7H2ic2OFyZM8k588+b2JGYbhog2RGp0hLQPlq4Y9
         80VaKuEB1Er7gVsW0zal/4kgQxb0etukfqTw4Vp59NdXU/OfA5EMbGEgEGCb/rnUVtFN
         RHq2OoU/JFAY4G9zlQm/0v5pvZo3e8nR2toO0aO+XvXxQ8Mx4bCgRRBXWmx/FiLS7INE
         1cwg==
X-Gm-Message-State: AOAM530gZXp0VnbGZUaYRUPgXnKXUAEjQxJnymPa+EclPk8TxfuS+snl
        vgzLMCg7RROlJFjKy/sFti1DzX2cjt0=
X-Google-Smtp-Source: ABdhPJwzCX+m0ruDu9D86HEz8zX/9IzqeksbRIbCVjHUnh+4okQNQavaHumUcPz/GnWB/+yPNlP+jA==
X-Received: by 2002:a1c:741a:: with SMTP id p26mr11047414wmc.47.1626268367248;
        Wed, 14 Jul 2021 06:12:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15sm2715071wri.39.2021.07.14.06.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:12:46 -0700 (PDT)
Message-Id: <bdd47bd30e02a2ffd92ca7371e1d990f08935ba7.1626268360.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
        <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:12:31 +0000
Subject: [PATCH v9 07/16] unpack-trees: compare sparse directories correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de, Bagas Sanjaya <bagasdotme@gmail.com>,
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
exact string match on a sparse directory entry. The final check is a
length comparison between the strings.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 87c1ed204c8..b113cc750f2 100644
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
@@ -1014,6 +1016,16 @@ static int compare_entry(const struct cache_entry *ce, const struct traverse_inf
 	if (cmp)
 		return cmp;
 
+	/*
+	 * At this point, we know that we have a prefix match. If ce
+	 * is a sparse directory, then allow an exact match. This only
+	 * works when the input name is a directory, since ce->name
+	 * ends in a directory separator.
+	 */
+	if (S_ISSPARSEDIR(ce->ce_mode) &&
+	    ce->ce_namelen == traverse_path_len(info, tree_entry_len(n)) + 1)
+		return 0;
+
 	/*
 	 * Even if the beginning compared identically, the ce should
 	 * compare as bigger than a directory leading up to it!
-- 
gitgitgadget

