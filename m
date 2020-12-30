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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44CCC433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7821A22287
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgL3T1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 14:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgL3T1i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 14:27:38 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B167C061799
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:26:58 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v14so5710717wml.1
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lZsgzqKL9emT4W9BIj6rxRLXy2CmPoK6OWnPMIFpeTg=;
        b=dcPPu2SYbOU1Q8h4ZTgsMTBdsH5b26pWTRBN4CDHICzVikNM6mYHU2LzlJ2fnQXAGv
         21OokX6639SiJQzE8jWwaiRAas4OEKkHWqNnUZZYzaCiUsRjf8uqLX9VDgIa+HpLNv4A
         YrnwN4IUXhY5Af6MgLGUhzGPss/yhzGeYJQPgdjEmAES8FClexa41Syku+T90j2GKBr0
         7jSZBtFa14dD0pxirwCYfbZ6qPxwdE7LYstHvO3KiYFkOt3nwSNzx7aO8efyFD1arw6i
         ToX3/A+v2f5aI3MFpsu6u18VNU1R9ho9PFhrJnknVLjlzv2mOT5BwmPWfSjSNRFZbHaQ
         bhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lZsgzqKL9emT4W9BIj6rxRLXy2CmPoK6OWnPMIFpeTg=;
        b=s0olrqxERjzA78AVLPWgCrQRS/Me2tK0vnbdiHph+akcFUe9PSfynQf9uOk4kQhyUq
         HIApcrcRITxG+27NyEKPAd0hRhrH6QMaxbSRjhvAi1ZDO7EPoRgUV2EnrZzbbBme9VTP
         oxJkpf6JrDTowa4PWW4fEMXY5hlJf6ND0aAFGTkhpgFXrs6+s3YDqX3opAqfND16I5i3
         8AQb1S3I/mlToVglDcO8EgZND9xamIYIuK7CPISiGhElFR3k7HfZbIA2uKHR8zZERoNl
         /sHPinghT2I+MosBSbcSVYcS/tjgIFe/8eamvuzSXsWF85V6aTejfF25s6LRneqIDOav
         UrJg==
X-Gm-Message-State: AOAM530NuWl+gtZCkG/zlN2kXdH4V6kiYdlL4rmcXSh87NE17oLRk6tu
        CTmt9910EjZ9AnOe7RkWRS27b6fV5eg=
X-Google-Smtp-Source: ABdhPJzCJhcxctG871rVurm1CJrT6LiSOZoUHyOBRn9bRsfuaFeQ6kS/MTqcD6h/1Am3QL/j4mJ6nw==
X-Received: by 2002:a1c:4107:: with SMTP id o7mr8900117wma.69.1609356416585;
        Wed, 30 Dec 2020 11:26:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2sm8517793wma.6.2020.12.30.11.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 11:26:56 -0800 (PST)
Message-Id: <6923e6211aaa9e1e144db747c971c6fe35fb4d41.1609356413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.git.1609356413.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Dec 2020 19:26:47 +0000
Subject: [PATCH 2/8] unpack-trees: add trace2 regions
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

The unpack_trees() method is quite complicated and its performance can
change dramatically depending on how it is used. We already have some
performance tracing regions, but they have not been updated to the
trace2 API. Do so now.

We already have trace2 regions in unpack_trees.c:clear_ce_flags(), which
uses a linear scan through the index without recursing into trees.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index 02f484604ac..7dbd006ac56 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1579,6 +1579,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 
 	trace_performance_enter();
+	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
+
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout && !o->pl) {
@@ -1652,7 +1654,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		}
 
 		trace_performance_enter();
+		trace2_region_enter("unpack_trees", "traverse_trees", the_repository);
 		ret = traverse_trees(o->src_index, len, t, &info);
+		trace2_region_leave("unpack_trees", "traverse_trees", the_repository);
 		trace_performance_leave("traverse_trees");
 		if (ret < 0)
 			goto return_failed;
@@ -1740,6 +1744,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 done:
 	if (free_pattern_list)
 		clear_pattern_list(&pl);
+	trace2_region_leave("unpack_trees", "unpack_trees", the_repository);
 	trace_performance_leave("unpack_trees");
 	return ret;
 
-- 
gitgitgadget

