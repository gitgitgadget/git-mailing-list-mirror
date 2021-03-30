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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127E5C43446
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE49E619ED
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhC3NLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhC3NLU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:11:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2040C061764
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e18so16190801wrt.6
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=harCcaW6krA58Ri1udByTg/8REVVoWQHOitg/KDNLxQ=;
        b=fTy2SHqSPxGUTE2i8cZLFA5yikd/NQMkfp9GgFHMRUa3Wg6C+66Lu357qA8QXeODGY
         6S+E/Dexd4JlC0hrqD3FKGpLfpRMPjW7FBxUnytzgnf4uklZWFCZ1NrBRYfkjZjh/0ak
         4o4HgkXqqiYAlD50J4ZAB2Pcrdstn6ZHCHkpjLakjBfhRn20MAs4lQuNRdZIUd2hZP3I
         2SEP5MdxVD9Iseken6cf84EHDK8b7CQlSx1+yvxGWMR6idWJ6lTiTTAl0rMCl5n/Ao5x
         R1grHV1NFCjUW3Ctyt62NGEFDbIBUwPSSk5/TO238mPiKMh6knVO38Jybx4TXhhofv7k
         62Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=harCcaW6krA58Ri1udByTg/8REVVoWQHOitg/KDNLxQ=;
        b=ICFsBnQ0chEr2E0OG/xLwjNfdh2MWN2Me6p7JAANATpRyghVlLg1sipDa9lNazK5x3
         y1HDZjJf8B6Olpd0MuvU63EuijajMZMJ7AMrTQFRdnCORsAoXFgcOzaaZtPaUNuzTcC4
         lrGLt6XW98Tb9gXQKzGk2Bpzxo8u7o0TQ8HMuR5ZMNa6Vk73aRyGeil/mBNPVY+HU5cW
         ddZtz+uonAjFzY+mUxneeiVgnzf5zd0XGrfF2EjonKJ1IRsNnaEMCuR43Q37S742UY6S
         MH9GdxhiRm4pLYweGG4tzLWQJhdkr5rnyprmL08EA/BlEaRbQNPlGxrGqXR3gllZPiHk
         hgOA==
X-Gm-Message-State: AOAM530LlRBYOPLJ7ElXRaninKA6zq1Bx2ruwk61BjfduZXgXMKOamTc
        G7KUnoz/Bbf4I/JZB0KhDRN7OV63nEQ=
X-Google-Smtp-Source: ABdhPJxighXUeRef74PrxDZ3bUcPctapw4bXkNIcmP2CIatD1DyjMOzKy+l0cEwBxP1qZ5k84DkrCw==
X-Received: by 2002:adf:f4c2:: with SMTP id h2mr1926803wrp.347.1617109877700;
        Tue, 30 Mar 2021 06:11:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2sm3619693wmp.20.2021.03.30.06.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:11:17 -0700 (PDT)
Message-Id: <7191b48237dee37c095e7e995913bd37b003dd45.1617109865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:10:57 +0000
Subject: [PATCH v5 14/21] unpack-trees: allow sparse directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The index_pos_by_traverse_info() currently throws a BUG() when a
directory entry exists exactly in the index. We need to consider that it
is possible to have a directory in a sparse index as long as that entry
is itself marked with the skip-worktree bit.

The 'pos' variable is assigned a negative value if an exact match is not
found. Since a directory name can be an exact match, it is no longer an
error to have a nonnegative 'pos' value.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 4dd99219073a..0b888dab2246 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -746,9 +746,13 @@ static int index_pos_by_traverse_info(struct name_entry *names,
 	strbuf_make_traverse_path(&name, info, names->path, names->pathlen);
 	strbuf_addch(&name, '/');
 	pos = index_name_pos(o->src_index, name.buf, name.len);
-	if (pos >= 0)
-		BUG("This is a directory and should not exist in index");
-	pos = -pos - 1;
+	if (pos >= 0) {
+		if (!o->src_index->sparse_index ||
+		    !(o->src_index->cache[pos]->ce_flags & CE_SKIP_WORKTREE))
+			BUG("This is a directory and should not exist in index");
+	} else {
+		pos = -pos - 1;
+	}
 	if (pos >= o->src_index->cache_nr ||
 	    !starts_with(o->src_index->cache[pos]->name, name.buf) ||
 	    (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name.buf)))
-- 
gitgitgadget

