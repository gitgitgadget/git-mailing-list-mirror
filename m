Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE75020248
	for <e@80x24.org>; Wed, 10 Apr 2019 02:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDJCNW (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 22:13:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46389 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfDJCNV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 22:13:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so358816pll.13
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 19:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FUyReao+6GzBUUf9qm/1o6mzN/asMwdmDcEImgML47I=;
        b=oTvTnDvTV3uoKax3wsKt4bTjT/MaWw3G4OqRsUPYnGzaHAwnXGgeXEzktIc6Te1y9+
         KGjflkOt9xGpe5ioLIgOS1jgcDlBVNVuq4R1QeXtTHObS5atMTS63Mdwn1mi5KLIoS0i
         051CRksVZydAOZsFXtGTsMKlizIc4X//C62VEy6x7prt9bxHFWQmHBvMWu864PVO5r7g
         8rhGCKXoVjz60SYQBtL6Oa5iZsGscubY/yBjjazKBeohGZuBuBG02WkneE//aCwrkQHm
         l0Na13n9TR2t67uQhRxXrpGrV63XRkj8r5hd9k7DcKHTV54uT6s4E1aWXuR+oHY35NfU
         I63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FUyReao+6GzBUUf9qm/1o6mzN/asMwdmDcEImgML47I=;
        b=UlfizEbaH8JmGQb2tVPSoBjh6F0jlse0FJBomcWod2p7Fj2HphkQUUwSK+jRA9MZZv
         dKtGC+05diCN7I2o3ww2hD9ZVeM4uvGk7k19+t2DPYJFemAAabsmcz7359cAiGPVFvFS
         9cnGUJYGzo5fUHHKbmC26/5o1VezGJhR3T1LBuEZbYlx9PL9TVdEHCW34thvlXn+hLFM
         EXlBa+S1enml7EIiVGa9V6DaQpDvEeDEgvEwMVz14sl20kHw0PWlLGnOoNxJJaRq9wTy
         sz3/BjQRj8koAfNnXR6eTmnyfk3af2n1V1HNtRTqXNH/+2siN7JQWWw/JZjGzbjIDlMZ
         DdOg==
X-Gm-Message-State: APjAAAXH18v10b8wgwiLmOHV+sG448aCc1XFIOzf2Jxw3nnSlSNdPhsF
        sojO4xWdjTA96Y3075nLiE1Oxy7i3zAArpIr
X-Google-Smtp-Source: APXvYqwMAs98mb7kxk297F5cEO/Tp0/Ia5n9Z2tTRRUqAcj4U0SjGgll9yMGPQAx0pdn7noHi2DvaA==
X-Received: by 2002:a17:902:8345:: with SMTP id z5mr40989145pln.197.1554862400206;
        Tue, 09 Apr 2019 19:13:20 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:c47d:9491:9418:887])
        by smtp.gmail.com with ESMTPSA id z22sm18223311pgv.23.2019.04.09.19.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:13:19 -0700 (PDT)
Date:   Tue, 9 Apr 2019 19:13:19 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, peff@peff.net,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v2 4/7] list-objects.c: handle unexpected non-tree entries
Message-ID: <97c7e23ec9c2ac33abb2e110c5425482ecfd1925.1554861974.git.me@ttaylorr.com>
References: <cover.1554435033.git.me@ttaylorr.com>
 <cover.1554861974.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554861974.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply similar treatment as the previous commit for non-tree entries,
too.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 list-objects.c                         | 5 +++++
 t/t6102-rev-list-unexpected-objects.sh | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index ea04bbdee6..bb7e61ef4b 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -125,6 +125,11 @@ static void process_tree_contents(struct traversal_context *ctx,
 
 		if (S_ISDIR(entry.mode)) {
 			struct tree *t = lookup_tree(ctx->revs->repo, &entry.oid);
+			if (!t) {
+				die(_("entry '%s' in tree %s has tree mode, "
+				      "but is not a tree"),
+				    entry.path, oid_to_hex(&tree->object.oid));
+			}
 			t->object.flags |= NOT_USER_GIVEN;
 			process_tree(ctx, t, base, entry.path);
 		}
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 1377c60378..e3ec195532 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -34,8 +34,9 @@ test_expect_failure 'traverse unexpected non-tree entry (lone)' '
 	test_must_fail git rev-list --objects $broken_tree
 '
 
-test_expect_failure 'traverse unexpected non-tree entry (seen)' '
-	test_must_fail git rev-list --objects $blob $broken_tree
+test_expect_success 'traverse unexpected non-tree entry (seen)' '
+	test_must_fail git rev-list --objects $blob $broken_tree >output 2>&1 &&
+	test_i18ngrep "is not a tree" output
 '
 
 test_expect_success 'setup unexpected non-commit parent' '
-- 
2.21.0.203.g358da99528

