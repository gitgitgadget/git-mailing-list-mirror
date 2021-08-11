Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079F8C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 09:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E385060FC3
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 09:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhHKJIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 05:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbhHKJH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 05:07:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDFEC0613D5
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 02:07:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so8548609pjb.3
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 02:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7zP0ybDu9IW3Ia2jHWQr+DAjzzmUeyWnfFY4bEsy/0=;
        b=u/vE/x6fBgcqKZVzy+OAIrno2h017nEdKB7ILkXf8TZBeIAKGD/0V7WevaDVPaN9Hp
         X+W+vOU+f7MBUxUaLWHbM9wu1uI14KtJ4ssYj2flWKGC2z+oKw8oFXS7JHrKcCiCivMi
         lo4S3oGAE0hAh6VNtRgW1pFUlNOero6SLlVdcyA6Lr2DiPUyK4nCnc480Vhnv3F/joRy
         shWynZZw6t5E0XHPrcqNcUNi/nab5YDHy6PeTfEETDKDQzdy1rb9ZE4z2xFb3K6fgyZj
         sfDYW+vzDYgxH3p2AX+DRz83QMaH8KYpYdolZZXsU/OWWBzIqPyxCIEGJHdLItGXNgon
         BDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7zP0ybDu9IW3Ia2jHWQr+DAjzzmUeyWnfFY4bEsy/0=;
        b=jTfasuRcY0tTnwQnSmh6O84JLpDrM+rBqDGdFzGdcQvsmDE7tXGul4SQFetWH/ky4s
         a2Wp7XQw2c+vz6QbG6vDKE277g5fAkCeD6UdgwUVo2BBCkoa5bSv+exJxRCNH067MQ9x
         y0iu2sMQJZqgV+f+S+6vaDaCMOySoHGq6yocwg1hqF2Zc5u5Ba0XrW4/zPSJrg5rwjYL
         6w7PzL8WSwbkgAKi0vIGP3n39jbf8cd+nrscQqV5dhSxKSBX9AyfbAYijf6NUv8clSUW
         B5FLn83JoGCij9UR2EL0ZuEEmunQGozd3nbplh9dLqb+p6vTAs+kfqrnyPsPiDYvZg0A
         3UuA==
X-Gm-Message-State: AOAM532K06rHubfmZZUXt6I6WHxT0NNObEAwXPZ1ylEzM/dFJ3bteO5w
        fk5idXDio9XyXsRx4gFiLj8=
X-Google-Smtp-Source: ABdhPJySQTKoI8TraDV51OfMtDZMdIPJ6W7kcs3/JblklVZ8kuO0CgAMew4qTagd3sGVD1ELZzi8rQ==
X-Received: by 2002:a17:90a:c8b:: with SMTP id v11mr9348080pja.114.1628672854918;
        Wed, 11 Aug 2021 02:07:34 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id 8sm16245270pfo.153.2021.08.11.02.07.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Aug 2021 02:07:34 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     git@vger.kernel.org
Subject: [PATCH v1 1/1] list-objects.c: traverse_trees_and_blobs: rename and tree-wide
Date:   Wed, 11 Aug 2021 17:07:14 +0800
Message-Id: <b6f3b15253d44c9250f59b53aafe471edda9f4b7.1628670288.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.32.0.dirty
In-Reply-To: <cover.1628670288.git.dyroneteng@gmail.com>
References: <cover.1628670288.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Function `traverse_trees_and_blobs` not only works on trees and blobs,
but also on tags, the function name is somewhat misleading. This commit
rename it to `traverse_trees_and_blobs_and_tags`.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 list-objects.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 7f404677d5..37a37fc502 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -334,7 +334,7 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 	add_pending_object(revs, &tree->object, "");
 }
 
-static void traverse_trees_and_blobs(struct traversal_context *ctx,
+static void traverse_trees_and_blobs_and_tags(struct traversal_context *ctx,
 				     struct strbuf *base)
 {
 	int i;
@@ -407,9 +407,9 @@ static void do_traverse(struct traversal_context *ctx)
 			 * needs a reallocation for each commit. Can we pass the
 			 * tree directory without allocation churn?
 			 */
-			traverse_trees_and_blobs(ctx, &csp);
+			traverse_trees_and_blobs_and_tags(ctx, &csp);
 	}
-	traverse_trees_and_blobs(ctx, &csp);
+	traverse_trees_and_blobs_and_tags(ctx, &csp);
 	strbuf_release(&csp);
 }
 
-- 
2.32.0.dirty

