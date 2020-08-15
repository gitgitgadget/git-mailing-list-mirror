Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09427C433DF
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84E12053B
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNbZBnYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgHOWFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgHOVux (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E26C0A3BEE
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so10915578wrs.11
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gEltWc4E8IF32606ynbvm1ztlj4ryx+s7moKETG0/go=;
        b=XNbZBnYszcZWxjF6coIeKTOu2Z/9NJrdZciUcMCjGGx03qa9jXxdGrvUmb99E6W+sH
         kr7RiyIQYjeDcSW1W81GAOcAxw8+cjTdADaSUD4eZzQvg4c5ar6bap0+/WazpJ0Kdwq0
         v4jcSEnp5PVERqGif/B7JiHN/VCd2Bq9X1t99CURXb5WqkEwsPChQmWF5W0pn03o0Mwx
         uo1wLiqyEwhjUuH9QIh+W9rynrcvA0LtVReo2IoUzI1PRPsnS5XNMSKTdNiN4aNsVEyB
         SxUjxMtJFoQvUuW6YI5+ACmSP3OaMCgFdLbLuNo5+XAC/mtjBk3eNa5Fk5F1Os3HxZCr
         jOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gEltWc4E8IF32606ynbvm1ztlj4ryx+s7moKETG0/go=;
        b=JDSmMhCmHzUutAZ8Ev7tZtIgDjm0ZL1JNcwSmNe910erexz+8+StEeTmBwGsRVGRwj
         De5zaV8VVv1jE3sscp72sMKyaMxN0aE/ZuBYCZz2DMzTxafEpD40e/MeYT+gOpXNsR/5
         krOcnMPwfCGd6gV+JJyVugFuC/1v+OxioB7TBbgnqiF/OeoiZhnvbmAdWBo1hEu57Oy0
         XxH/lQxR9/EfNyl803ibRAn3wKxB2VZw6MabV9veO6X5cJiLVP5Je4gnNflCDlZvKTOI
         fM7V0yDy+Pq4udxC9kUZCmvon/z4ddL2iUnHM7qISM6qR2uDq7bJ48HXz2GA9ZVp97IV
         VrWQ==
X-Gm-Message-State: AOAM533lAiQ45NG3yijb4jHH5U20T3C0ex97To5woPUBukzqYHG2fw62
        /qV/F+Z2tJ7FQuyyTSYrOOlDE8QedFE=
X-Google-Smtp-Source: ABdhPJzz1+oxppibR8waSg6rY4WClNOsXNSvGe4vYM2GcrsJgFqweyJ3wmPPFjnRT/FUhKEMfR/1kg==
X-Received: by 2002:adf:f486:: with SMTP id l6mr7545953wro.265.1597509586929;
        Sat, 15 Aug 2020 09:39:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f63sm21468993wmf.9.2020.08.15.09.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:39:46 -0700 (PDT)
Message-Id: <e6738672349254c6405f7dde48f612b82af9299f.1597509583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Aug 2020 16:39:34 +0000
Subject: [PATCH v3 02/11] revision: parse parent in indegree_walk_step()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

In indegree_walk_step(), we add unvisited parents to the indegree queue.
However, parents are not guaranteed to be parsed. As the indegree queue
sorts by generation number, let's parse parents before inserting them to
ensure the correct priority order.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 revision.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/revision.c b/revision.c
index 3dcf689341..ecf757c327 100644
--- a/revision.c
+++ b/revision.c
@@ -3363,6 +3363,9 @@ static void indegree_walk_step(struct rev_info *revs)
 		struct commit *parent = p->item;
 		int *pi = indegree_slab_at(&info->indegree, parent);
 
+		if (parse_commit_gently(parent, 1) < 0)
+			return;
+
 		if (*pi)
 			(*pi)++;
 		else
-- 
gitgitgadget

