Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D379C433E4
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 09:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AFE620786
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 09:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eq7y3iW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgG1JN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgG1JN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 05:13:58 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C1CC061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 02:13:57 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w9so19876942ejc.8
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 02:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YXG6SyBGOOD+L6+7lkWUgaCbt1pU0UDLL+mn3ynHiH4=;
        b=eq7y3iW8uBfzAaglz1PfZIsGVTSd7Cb9ucwv1/Bbno1ReYIZgn4QcyCuyCTYQ2Ieqm
         74MGPlU+IM390ISUnCkYO0yeuiEUPfcvIlwgEv3M5V0bBj1q/m3bCekQudkwWJ8WroXH
         iUMEGRm4jRz0HCYcLITstvlNmr/rYRpr3IZGAY3Ui5dlPHw8PB5j40denwfpeMZhOAmC
         Ts02+J8kB82Ga58N9Y0eiyV3L/kVD2xLfXj2zX2Z8RIbfXkCJ6Eeg4LCc7LdzX6hKD9s
         PZJv7b0dJ5/ChF0MXaNm9emcRIKwY4AjQrc4DgT9QD0pPmUnIA1qm86RkRQni48NqNii
         em2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YXG6SyBGOOD+L6+7lkWUgaCbt1pU0UDLL+mn3ynHiH4=;
        b=UHehlN+dgKlQDcbgtwfebLTKqqzlpZfngoiuZmZHkboZ+6qXLxc1Jjz1PO+1su3GGR
         5vmAJi9RTSwkNyR70XKIN/eenU2fxbcTra8l33K3yiv46Cjku7UFoeicbjdj9DnyWeQ3
         RQruBH5oM1xps9iqpZO9RRdhuQwTj7BbivjbjqRd4e8iyW4gkCSyyavnUst2xG7HiUGc
         IXwyztDASt0HNgUM8Fh+T7ony/LE2Ld1Dlybr49YkmXFA0TXGM9z7P4xDXbpy4LhZEg/
         MNcXa5+zHpSM6WoSeIWj4S8Njv7pd/SKksnyfyFH59C1QYksYZblZEahhWfcywZokATp
         l43g==
X-Gm-Message-State: AOAM531WMONkif5qb/Zl0tAqHi7GQS1rceSLZUcVAqRGrXFEEymwj0pA
        kovHFyFkRsFuFyfJbzX4bHkas5q6
X-Google-Smtp-Source: ABdhPJy3gsPlzw4IpFBqSQJIpUtUeTwY+pAsOf1U3O3o1Zxk6NrPitmTqCcLD9PE2O4FQF330CWlGQ==
X-Received: by 2002:a17:906:a284:: with SMTP id i4mr1177259ejz.490.1595927636011;
        Tue, 28 Jul 2020 02:13:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cf10sm313554ejb.4.2020.07.28.02.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 02:13:55 -0700 (PDT)
Message-Id: <d23f67dc80b85abe4eba9a9dfc39d50188e23bb7.1595927632.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.git.1595927632.gitgitgadget@gmail.com>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jul 2020 09:13:47 +0000
Subject: [PATCH 2/6] revision: parse parent in indegree_walk_step()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
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
index 6aa7f4f567..23287d26c3 100644
--- a/revision.c
+++ b/revision.c
@@ -3343,6 +3343,9 @@ static void indegree_walk_step(struct rev_info *revs)
 		struct commit *parent = p->item;
 		int *pi = indegree_slab_at(&info->indegree, parent);
 
+		if (parse_commit_gently(parent, 1) < 0)
+			return ;
+
 		if (*pi)
 			(*pi)++;
 		else
-- 
gitgitgadget

