Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF32A1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 18:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeIDWcs (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 18:32:48 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:49426 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeIDWcs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 18:32:48 -0400
Received: by mail-yw1-f73.google.com with SMTP id d20-v6so3308579ywa.16
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uN4F1kFxffkKR88bp0Jii1EW4LtZK95h2Gx3nakgNqE=;
        b=WTVGe56JVF18ibcp8RUyz3Tw7jawgqc5ednhYNeacwL0W1OWaFserSHVi8F8OaCUuu
         /tti4WnLVDWaZiTEkVmlf+gpICjFRua+0mZAOEg6EUrfN98e+c7RYbb8+AgBsOHtH9HA
         epkRxxC+e5p+ASIrGSgj48A1QSCnxY0Izsloli+wNibkwo+AsqOjYO+6fUEkyycC/rY8
         /3zsY8qzqdD2D03m9agreMGn56T1dFmG+h+4BKBIxWj+tTihO5bLqrPqhaIbxuDhlF1q
         StLnqqb0v4W4Rl6W8ocmkwQodEQZJQ1Z3kcVNUv88oapmJEKXr3x4OZysDmg+mSAGV0L
         Tjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uN4F1kFxffkKR88bp0Jii1EW4LtZK95h2Gx3nakgNqE=;
        b=Oxc+bcnQcXVeUhenI6KlcNAQBmyxaPVW8Aj24kAhjjo5RZWrLCDMnLF6yl6Ba1x/Rb
         Y3oMQqihjnl+9/51E/7LsVMep2C/l4ZhGqFXbfMpee2AniJk8cEvmJNErGTUquibw9mQ
         qM/Ug96G1XHP67UCWv8q1oSkxi1eEqUUq/sTTz+Y+T5CrTV+47A9cvOZMDtfcNEAikKE
         cLzYyjQLtVTuO7mtxX5hdEMvUC+4V0cCvD1hf4Amv1/P9ChiPPhk8EcI52eL2iCUqy6I
         2aXHjqeDtA35OeAiUIApMMVjBL2LDvcEX+gBCeV35/MXg+5k8SN7rBVTMTA6fP8Fvu5f
         4Aig==
X-Gm-Message-State: APzg51CHVF5RaeKQ/KCIsDAVUum3el9CH28Nj63hQa/M4CsW3v8RTp3M
        Ec30n1qMagQukoWxOdsoTTyInSx3stE=
X-Google-Smtp-Source: ANB0VdbzyQjkay3NGKNyxznxfEogXrMy9W3hIAN4ZTyrAt5K+kCTcfGIkhemLzmPg/OwjHTUiKDrzHPfzoj5
X-Received: by 2002:a81:8641:: with SMTP id w62-v6mr8702318ywf.184.1536084394791;
 Tue, 04 Sep 2018 11:06:34 -0700 (PDT)
Date:   Tue,  4 Sep 2018 11:05:49 -0700
In-Reply-To: <cover.1536081438.git.matvore@google.com>
Message-Id: <602ab6c3fa1e83139bd3131dc7e44c2a7e172d26.1536081438.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1536081438.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH v7 6/7] list-objects-filter: use BUG rather than die
From:   Matthew DeVore <matvore@google.com>
To:     sbeller@google.com, git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, gitster@pobox.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some cases in this file, BUG makes more sense than die. In such
cases, a we get there from a coding error rather than a user error.

'return' has been removed following some instances of BUG since BUG does
not return.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index a0ba78b20..5f8b1a002 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -44,8 +44,7 @@ static enum list_objects_filter_result filter_blobs_none(
 
 	switch (filter_situation) {
 	default:
-		die("unknown filter_situation");
-		return LOFR_ZERO;
+		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
@@ -102,8 +101,7 @@ static enum list_objects_filter_result filter_blobs_limit(
 
 	switch (filter_situation) {
 	default:
-		die("unknown filter_situation");
-		return LOFR_ZERO;
+		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
@@ -208,8 +206,7 @@ static enum list_objects_filter_result filter_sparse(
 
 	switch (filter_situation) {
 	default:
-		die("unknown filter_situation");
-		return LOFR_ZERO;
+		BUG("unknown filter_situation: %d", filter_situation);
 
 	case LOFS_BEGIN_TREE:
 		assert(obj->type == OBJ_TREE);
@@ -389,7 +386,7 @@ void *list_objects_filter__init(
 	assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
 
 	if (filter_options->choice >= LOFC__COUNT)
-		die("invalid list-objects filter choice: %d",
+		BUG("invalid list-objects filter choice: %d",
 		    filter_options->choice);
 
 	init_fn = s_filters[filter_options->choice];
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

