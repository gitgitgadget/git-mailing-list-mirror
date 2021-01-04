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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ACFC433DB
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CACE2151B
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbhADDKF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 22:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbhADDKE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 22:10:04 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EC8C061793
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 19:09:24 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c5so30767339wrp.6
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 19:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TlE4Wa/PmXo18jG1onlTnDHaohvuR3hpK+GpRAAFDa4=;
        b=gaGm+TqJ4gFFMrgrYupd47wmJfjb/BjsNoYqQQAtJgkcPTti82zBHT7JEYNPCSAhzr
         QN6ukPxnbfBs7whyKq/ewtiSi7KffuCeEVKX8e4V0pZ/SCcTdUtLt1bqV6uD7BpdNAd4
         MhB+RzbMJD0FQwXGmflRlfJUbU735GzUyMVjgoN9RZkRoRe8PHDbAXtq3A0kXMKLLnPt
         Buo+FxTbCjmJuzjqqE4g+UGqCUub6lQCBBZ+KE/fFhAgrOGDVUJcxhW5/NTGomcOAJxV
         qiXRDj8J8BNH5Omx5VixlQacfFs7e38cgD88e0su2pnFYqHibdNBRubGamXW4xBgCU/q
         tbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TlE4Wa/PmXo18jG1onlTnDHaohvuR3hpK+GpRAAFDa4=;
        b=QQYJxh6naGZeRLi6/cKMiblhGkuf8Go3ZDiaoGRZhTJ6NjTIfLUoacro3gbLF2HDaP
         gs5KzMX+Jb1/CrkfCwtszKnrYr7CvfgRMTpLb0Ts+xfL7vlR9AB+GYasAwyxzB9CmwtU
         poe8EquGDaJAJTJ/28rUrjXaks7CWAEhKd1GWjbRpQiYgVz+jCPvEg35zaWzfo3NuDVy
         GAhO8idWFjuTGa5bXejCRlwLjx5r8V2canGEEEo390giYx8ffrvfqjm4zZBmtfzl3iDX
         znNxLtk2GPwodnocfYeGBE0xplJGy3yNpiJnIUrDObxiQ2zL6LvOI8Iv5fqB1AUYWlQV
         ZqyA==
X-Gm-Message-State: AOAM531WCcFPGkU41BpdyybHdq17dYUmS984mjC6YLdB+WOh/cqqDMVX
        KLiTztU/7MM6EQiY1njLMU2Qk02CrU0=
X-Google-Smtp-Source: ABdhPJyMRScxRCSwflRZqD91oO/mArW3iZaPKMJWBm4Z6wRksLCr1BpzN5uVrdG/inRbrW5kaPkrYQ==
X-Received: by 2002:a5d:4491:: with SMTP id j17mr76330819wrq.78.1609729762056;
        Sun, 03 Jan 2021 19:09:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm30240557wmf.19.2021.01.03.19.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 19:09:21 -0800 (PST)
Message-Id: <4157b91acf8009ef2136c0856b6b61833d82873e.1609729758.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
        <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Jan 2021 03:09:11 +0000
Subject: [PATCH v2 2/9] unpack-trees: add trace2 regions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
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
index 323280dd48b..af6e9b9c2fd 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1580,6 +1580,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 
 	trace_performance_enter();
+	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
+
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout && !o->pl) {
@@ -1653,7 +1655,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		}
 
 		trace_performance_enter();
+		trace2_region_enter("unpack_trees", "traverse_trees", the_repository);
 		ret = traverse_trees(o->src_index, len, t, &info);
+		trace2_region_leave("unpack_trees", "traverse_trees", the_repository);
 		trace_performance_leave("traverse_trees");
 		if (ret < 0)
 			goto return_failed;
@@ -1741,6 +1745,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 done:
 	if (free_pattern_list)
 		clear_pattern_list(&pl);
+	trace2_region_leave("unpack_trees", "unpack_trees", the_repository);
 	trace_performance_leave("unpack_trees");
 	return ret;
 
-- 
gitgitgadget

