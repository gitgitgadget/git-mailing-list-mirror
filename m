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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A815C636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B77F6113B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhGTUBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhGTTeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 15:34:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089E6C0613E1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:14:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l7so27295272wrv.7
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lX+phGtUUNbbXIoUjtKs9N0xtQbw6A/3yCrL+FgxfnM=;
        b=uhbF/3/j61wrXVptx8S4N/CffDfyayRf/ENbepe46XzeOzbtej65dFCX8KDJNNfNHf
         DBU2USJaS17aaXQQPfsQfPvMr6PZGzaRARrWa3OLPL1um0MjDg9VDYcpbOcRnMbZVEn7
         WNYDR6i4XKyPMMEGhIS9wi8b9ZGARYCtFy8+PVF23MDWcgmJ1LN9xS5UPJxeDsTNjz5C
         G8R0SiBhaPXdD7HfLu/tisZPxKXDNIu7U1JIzSJDqSObXGfvg5f/5P5AgJZvyRvJtfFD
         pdVWZsgy9ZCN5f46nWRCTVSGaW1rnhf6FgBvMdKFotkN/qLGIzkoqPisdMPvo1EBiWrG
         Co1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lX+phGtUUNbbXIoUjtKs9N0xtQbw6A/3yCrL+FgxfnM=;
        b=ZuJcKE5wRpO4hYAqZSxJg8sHBeHsYl83rNp6t/FKDI0KpV+HrwqUS4Qj8w6dAumEZt
         QM6uBZl1P6QUiuZ01MuU9+0r2bEfuJ9pYqzOxXoT+pHeM4GgxF/+y1CTKjihU7ty769r
         d74l9kJRSOKuwISujI7hdFA0GlK+dOEe7u9w1f/eVzVoGoGQKmx48JqEQcowqG5Dqa7o
         KtjgeqFAlEWOuf0iRgRprYo2fmiWELwqr5lf9z/vt+CJgN68caIcinw/5nmS8TIsUOfX
         9b31bydCdolEZOalrkBdr1kJKkVNccyrWysk19baa3lUr2etOlTDoS/LorGMNf5Tolk/
         6FnA==
X-Gm-Message-State: AOAM533PkloZZN6Eodm4XDnLvdlKuKFoH1UgJlqY0bCXF8pCBuPg1JSr
        N5JOzwFjh6er1SJ80wBINUPXsRPvF8g=
X-Google-Smtp-Source: ABdhPJxrujm9eiRhfiIaq0kHMLpbALCwluVU2aCOmEturjYl0Fd09hyTIoTbmnL71cAyJN8iX55mBQ==
X-Received: by 2002:a5d:4fd2:: with SMTP id h18mr36822579wrw.289.1626812084635;
        Tue, 20 Jul 2021 13:14:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 129sm20950673wmz.26.2021.07.20.13.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 13:14:44 -0700 (PDT)
Message-Id: <65e79b8037ca0268363db9ff967c1342a76485c5.1626812081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
        <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 20:14:38 +0000
Subject: [PATCH v2 4/7] sparse-index: recompute cache-tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When some commands run with command_requires_full_index=1, then the
index can get in a state where the in-memory cache tree is actually
equal to the sparse index's cache tree instead of the full one.

This results in incorrect entry_count values. By clearing the cache
tree before converting to sparse, we avoid this issue.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sparse-index.c b/sparse-index.c
index 53c8f711ccc..c6b4feec413 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -170,6 +170,8 @@ int convert_to_sparse(struct index_state *istate)
 	if (index_has_unmerged_entries(istate))
 		return 0;
 
+	/* Clear and recompute the cache-tree */
+	cache_tree_free(&istate->cache_tree);
 	if (cache_tree_update(istate, 0)) {
 		warning(_("unable to update cache-tree, staying full"));
 		return -1;
-- 
gitgitgadget

