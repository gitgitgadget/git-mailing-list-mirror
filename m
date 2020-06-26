Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746C2C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB91207E8
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4v1Jws/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgFZMap (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZMan (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 08:30:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE752C08C5DB
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so9320951wru.6
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=+L6SCMA7yE5WbnCrIdqh9mek/Hy2vi09CFOR2XSlnpI=;
        b=G4v1Jws/l+l7JdrocXppf84bAzYDDjnTLVweUmUCh+2Rvh3McHaRmuZ0KZHwSI5Ab7
         tYPR5zLPJIG+cEwuPYTzO6sPxxQ9Ez9Qgv9W4cH1QIrzmqcqKIrUwM71Ob0SYDcJO0cV
         V6jE+HQXAKl4lk8NTbt3uBZ7o4/WtHOpB7wVP72dVoJRmw1oDxu6XU+Ok5fVV2P9mu1N
         UZKNvQp7L4xHHZb2erT/ygMBgkyNrQ8XRCgauiuOTuQY+SpmOmUn4gGyQkaicTSy3fhT
         Nys1X+YiGV+R/OxSaoIbElUi/S80jkJV7LPVqY7x7C9rULfGRjEk5Ca03LSrQ/VUiKXC
         UdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=+L6SCMA7yE5WbnCrIdqh9mek/Hy2vi09CFOR2XSlnpI=;
        b=YXb2INRMEZ6+DfETcWq9P8Kqajowazs1xvphOkWaxQa16yI+XEQ6M17PZUqFXEeG/j
         pIbGq1ZogdPmKYekRIaPtLBzD1DGUndlN2c4EWncp+62+/KsfXV0dwe8cwlA66WKy9VO
         mwIO3J5KV2HWOq5N4nAZZRyDUrsZjIRR8SN75muqLJZibGwSEF55SxE1shsoUI1eT6A2
         0QDAd2IftdOhl4+yx2AIaN9nmNXrz27atuaOiWHq1z/9ENiTkavrsR0Ckb3Qc/v9FkWX
         zdr3+rpoUtw0vcyy//6I15bXVnhauhMzQGvDrF0rU3DO2jozP/4hzJV+nTJF3cuEtqNQ
         TuGA==
X-Gm-Message-State: AOAM532cJylT3QSyNKemmBykiZZuFo3qUawJ52YmSMzKFSSb3f4glVlX
        K6LjVEazb7kSNM3ovsV3Cihl7RAm
X-Google-Smtp-Source: ABdhPJyBBVTOU7tMZTiwsmo/iFGl5nemVtstbCETC6SvlgkBvrWrKHZEMkMdBB9z7u0qgrUEmURepQ==
X-Received: by 2002:a5d:6045:: with SMTP id j5mr3465614wrt.209.1593174641198;
        Fri, 26 Jun 2020 05:30:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1sm10959320wrp.10.2020.06.26.05.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:30:40 -0700 (PDT)
Message-Id: <2f809499abadd83b81b3d38d0cad9a2fd08b5440.1593174637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
References: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
        <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 12:30:29 +0000
Subject: [PATCH v3 03/10] bloom: fix logic in get_bloom_filter()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The get_bloom_filter() method is a bit complicated in some parts where
it does not need to be. In particular, it needs to return a NULL filter
only when compute_if_not_present is zero AND the filter data cannot be
loaded from a commit-graph file. This currently happens by accident
because the commit-graph does not load changed-path Bloom filters from
an existing commit-graph when writing a new one. This will change in a
later patch.

Also clean up some style issues while we are here.

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 bloom.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/bloom.c b/bloom.c
index c38d1cff0c..2af5389795 100644
--- a/bloom.c
+++ b/bloom.c
@@ -186,7 +186,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	struct diff_options diffopt;
 	int max_changes = 512;
 
-	if (bloom_filters.slab_size == 0)
+	if (!bloom_filters.slab_size)
 		return NULL;
 
 	filter = bloom_filter_slab_at(&bloom_filters, c);
@@ -194,16 +194,14 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	if (!filter->data) {
 		load_commit_graph_info(r, c);
 		if (c->graph_pos != COMMIT_NOT_FROM_GRAPH &&
-			r->objects->commit_graph->chunk_bloom_indexes) {
-			if (load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
-				return filter;
-			else
-				return NULL;
-		}
+		    r->objects->commit_graph->chunk_bloom_indexes)
+			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c);
 	}
 
-	if (filter->data || !compute_if_not_present)
+	if (filter->data)
 		return filter;
+	if (!compute_if_not_present)
+		return NULL;
 
 	repo_diff_setup(r, &diffopt);
 	diffopt.flags.recursive = 1;
-- 
gitgitgadget

