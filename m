Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5F7C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B86207F7
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvdCUInK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgFLSmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgFLSmC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 14:42:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2675C03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 11:42:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u8so3984286pje.4
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 11:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Db0rrqo/3iC+zBar16/nACK81crmPgjSQMmTewYrmKU=;
        b=CvdCUInKuTNpxn8dSojSgf+Jxk9lsnCfWBVJbhFNy+usDFrzxLklvWmTEirxlO457I
         Wwkh2DF3ZWT69uavBR0cSL4YAQ1Pp8SilxZXg2+8HLh/5iwoKal/a29U7AIfnnlhotcr
         aK9w/TgRF/Z7Ar8nfy0bniZ+oLRiD41As2x3a87Ul2xGTzT3U1y0zU87qSPt0cEd2gX0
         GIG/sZdNZ8BCNsH4WEcZx+en3rzgzPA2ebqcEwgSIf5ogLxwfvCb4fUHE/zzJxioS1jW
         jyp5Dl0RNrERMf6Bs4WJzMxlSZlF3W7xy2NINdP3+JB2zV/AAgNc/RCcth5CURQFEost
         xEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Db0rrqo/3iC+zBar16/nACK81crmPgjSQMmTewYrmKU=;
        b=pzrz7aTLBlAX0LQOr/YUOy0/MKynSLWc4MMANzhyPBJx1CGagKJWAj6dXwNzvDl2gJ
         GW51FQJBng0X3xM4IuSMJkX1jsqVRW3m/2ikL3AILkLsQryoTPS6makg+uvJU0HZDnTk
         z/Q393kwAgJsg7Ku8kTcbE14KvohXw1shTLve9ALfNNhuCWCoPSDj2Yj8JvgtoN1qG9d
         bfcPRJ9/IfdrpIuz6q5R5ChMg3olyzsRC2avTRrbgFYTSQf2DKurCxq6usdBC2RlESEF
         FucKcDjhXcJIhZb1mIyRr3T/F6Xx+MhB6ew9kxtItCurvSjdgxpSOSdklZZ2wjg59urW
         H8EA==
X-Gm-Message-State: AOAM533wQwWaK3tTpHUL2RuyovliG+bZ/P3b39tA8zWWQQCRPz3MAvAn
        0T3sVW/6KL23UmraDz3JgWpop25v
X-Google-Smtp-Source: ABdhPJyrA5olyGov/WuRKcTH1Qzu/4ddu+yKe9tPs3FPNAy54ljMcLutg++Cjm65vr9n7WDsxNBLNQ==
X-Received: by 2002:a17:90b:307:: with SMTP id ay7mr290806pjb.48.1591987322000;
        Fri, 12 Jun 2020 11:42:02 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:307:970b:360c:5006:374c:b8c0])
        by smtp.gmail.com with ESMTPSA id k12sm5985535pgm.11.2020.06.12.11.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 11:42:01 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jnareb@gmail.com
Subject: [PATCH v3 1/4] alloc: introduce parsed_commits_count
Date:   Sat, 13 Jun 2020 00:10:11 +0530
Message-Id: <20200612184014.1226972-2-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200612184014.1226972-1-abhishekkumar8222@gmail.com>
References: <20200612184014.1226972-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit slab relies on uniqueness of commit->index to access data. As
submodules are repositories on their own, alloc_commit_index() (which
depends on repository->parsed_objects->commit_count) no longer
returns unique values.

This would break tests once we move `generation` and `graph_pos` into a
commit slab, as commits of supermodule and submodule can have the same
index but must have different graph positions.

Let's introduce a counter variable, `parsed_commits_count` to keep track
of parsed commits so far.


Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---

CI Build for the failing tests:
https://travis-ci.com/github/abhishekkumar2718/git/jobs/345413840

 alloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/alloc.c b/alloc.c
index 1c64c4dd16..29f0e3aa80 100644
--- a/alloc.c
+++ b/alloc.c
@@ -101,7 +101,9 @@ void *alloc_object_node(struct repository *r)
 
 static unsigned int alloc_commit_index(struct repository *r)
 {
-	return r->parsed_objects->commit_count++;
+	static unsigned int parsed_commits_count = 0;
+	r->parsed_objects->commit_count++;
+	return parsed_commits_count++;
 }
 
 void init_commit_node(struct repository *r, struct commit *c)
-- 
2.27.0

