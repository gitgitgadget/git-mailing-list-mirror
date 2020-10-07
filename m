Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61463C4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7A5206BE
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 14:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0A3d4V0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgJGOJv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 10:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgJGOJv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 10:09:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E069DC0613D2
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 07:09:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 13so2490130wmf.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gcKi6qkxI9VO9dEsNVzoKfjgNi2BwArPJy/u5DDUbw8=;
        b=a0A3d4V0XNoJjIXKnnjIUrf8xH36CwzeII+bYGNpUN6ySpNltyPCTXGAwBQa8tfPoa
         xEw9uEbOgJHynuKHo49nbx/CbXXdKkeRNkNVcy9ivui1n8ac1ikpFuzSYa3IHFHJ72rx
         0C+TEUaVFZ2hVXwR9cMber0TJ/3v4BpL1emBgQGgZDQT+vnL1EPoQJEgHB66RTVyCcxu
         5d6f/yTdrBiEs/xOEjqgXnZUsNGCVSSBtpzf87Q4UwJlmIoUI5Ji1Igbcmi55hAJT2lr
         AjbELOriB9vQjI9RvBZsSrFLJ3kjNpv4BjJACsU+oVlxvz//1D/5oiUAvgMCeyMhQYrs
         a7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gcKi6qkxI9VO9dEsNVzoKfjgNi2BwArPJy/u5DDUbw8=;
        b=d3bQQjLKxmr/Mg9MVJJtsutrPWLFEdq2FSHgBGs7FVJxyZrStRhXi7aSzrepsbWM6V
         EqN+YMwB9uVhK5V0ANloS/v8xAv8AMryOrZoTvY8ssVOa2t4WfB8wcToTOfU6KIbwoo9
         L/GH0y+L/3EdOyCCx2UvC3FKync35IdQa9D5dM//r4VDpVt7Kv6uqn4aH+B/n3GEG5wl
         ++u1RhtxQDltMO+clEB88U2IiC3PHgdSRFg7lt9MaRtcOMYP49TwMN3/jXJBHMrXtx1n
         CcE+bamw+w5rri4rqt4lniMhnB2iS4DGeEa5nxnyfaaND/sF8rybM9/FIWMR48fDiqPi
         +ynw==
X-Gm-Message-State: AOAM532IPA5ia2D/S0/YPltYPE+TxOJyjm/pmhaSx0Iis0/yo6TZEt+i
        UyhA+4LLL1WKSX6O3NCVinLv6xHGN0A=
X-Google-Smtp-Source: ABdhPJxyEjI+yjL5QEqA8/V49/EJxLHeey3NwQYmofekV92QFR5HGOk0ie6P+v/4g3/RimtqgREiZg==
X-Received: by 2002:a7b:c01a:: with SMTP id c26mr2537759wmb.35.1602079789500;
        Wed, 07 Oct 2020 07:09:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7sm3248490wrm.6.2020.10.07.07.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 07:09:49 -0700 (PDT)
Message-Id: <4470d916428a28bb8277dfc4c3da84e08110e88e.1602079786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 14:09:37 +0000
Subject: [PATCH v4 02/10] revision: parse parent in indegree_walk_step()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
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
index aa62212040..c97abcdde1 100644
--- a/revision.c
+++ b/revision.c
@@ -3381,6 +3381,9 @@ static void indegree_walk_step(struct rev_info *revs)
 		struct commit *parent = p->item;
 		int *pi = indegree_slab_at(&info->indegree, parent);
 
+		if (repo_parse_commit_gently(revs->repo, parent, 1) < 0)
+			return;
+
 		if (*pi)
 			(*pi)++;
 		else
-- 
gitgitgadget

