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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39D1C43381
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF7A22262
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgL3T1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 14:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgL3T1j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 14:27:39 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7043DC06179C
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:26:59 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 3so5550052wmg.4
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F5mr/fFvRdXYRRCHVaEtFFWbeGwbu/OPMWpaJOKG0T0=;
        b=IslJSAe5s7CJqmEq5/tvEN1AzbQXaJYPDEIPo1pJquUTNYelHOWqXLrN8gW+Md8Ngr
         1yu8+2WG5mXth97KnerjFSYx+Wb8CERDngP+hQtF7R4bPKBS1Q2731JfS+B7no4MiF1k
         KCDyyNgC/V6xptXZnHxVh64oVaLqyJ1ZbCJx/nknb7eThlbnYONaVdcbeh4ABLzrX8vd
         OEbJDOuTipp12xoGyZ8T6/NGqEde8pUSwl97Nc6PonFz/aRS1mZ/pGh4WWykS1SQBK7u
         /bE0DBO40GWys/c5RxztUaFRdx6fwpIOu6tlkpdCFzAjfeo6IlMYcroO27v7Z7MVqQ9M
         tTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F5mr/fFvRdXYRRCHVaEtFFWbeGwbu/OPMWpaJOKG0T0=;
        b=agz4TBjrbYGZcRkkKvTOM1iDglJH+X/QVmTG4ENs5lNOXXsgdXi6xGtUjeMEg5I0V5
         e5zcxK2yK8jxEcuA0HloG17F48orfp25YS7oe7r02hQck01mrbJugUGs+JuCbgQ3MOeW
         f3VjkmkttYa2XgZ4sa7dQlZIOrqW0ZILJe2gJNWtZYKFPmvE6URKjpcRRmN7cXIavxCo
         HxKXXqUsts0sx8C68Yv0FRbtNbQbpWwHVPkA67nrki5FX2blQRRJ9d0hZjAF/sUn37Wd
         owTJb6xJAITZ/tP061sysbJip80+uR9Mi4VigzzL4zl4xL7SA8uBGikgFVdX6nwX8Z93
         pujw==
X-Gm-Message-State: AOAM53385i6JX2QLb+IFkLTXHf0ZJazrCIajd0Xkcz20NRldp/2vMeFI
        0AoAuDQCwaV5kpfIUsgPOO6+2l3omos=
X-Google-Smtp-Source: ABdhPJx9gzVjSQCrGzCCjdgXBr/REc4AvmANTTVFtRejcX1C5kQ0LepWRnD1IbU6gj64/0UHx95YsA==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr9133213wml.155.1609356418112;
        Wed, 30 Dec 2020 11:26:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13sm67965510wrp.80.2020.12.30.11.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 11:26:57 -0800 (PST)
Message-Id: <65feaa497b23b314ed9faa0452408c237f02b197.1609356414.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.git.1609356413.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Dec 2020 19:26:49 +0000
Subject: [PATCH 4/8] cache-tree: trace regions for I/O
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As we write or read the cached tree index extension, it can be good to
isolate how much of the file I/O time is spent constructing this
in-memory tree from the existing index or writing it out again to the
new index file. Use trace2 regions to indicate that we are spending time
on this operation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 9efb6748662..45fb57b17f3 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -494,7 +494,9 @@ static void write_one(struct strbuf *buffer, struct cache_tree *it,
 
 void cache_tree_write(struct strbuf *sb, struct cache_tree *root)
 {
+	trace2_region_enter("cache_tree", "write", the_repository);
 	write_one(sb, root, "", 0);
+	trace2_region_leave("cache_tree", "write", the_repository);
 }
 
 static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
@@ -583,9 +585,16 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size)
 {
+	struct cache_tree *result;
+
 	if (buffer[0])
 		return NULL; /* not the whole tree */
-	return read_one(&buffer, &size);
+
+	trace2_region_enter("cache_tree", "read", the_repository);
+	result = read_one(&buffer, &size);
+	trace2_region_leave("cache_tree", "read", the_repository);
+
+	return result;
 }
 
 static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *path)
-- 
gitgitgadget

