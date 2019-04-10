Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1CE520248
	for <e@80x24.org>; Wed, 10 Apr 2019 02:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfDJCN3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 22:13:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43337 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfDJCN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 22:13:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so412483pfd.10
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 19:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LLfpLlhpw31KK81zU7lFM9kt119J6dbXq0O/nIm28/8=;
        b=Rxe2WuuA52DcBt1Zairv9Osr1BlWjGyvCQImBs1tMTSEDYgzpPqSCcVTxjdhs5Cwx/
         pfLPyu8AGQCzK3b4EJxtYe/ULrh9wGFaHMnEKSrmQgCZ512qyHSkcip8T47MBZgZjvHM
         mt4r65AsOiEHQJPVglYr3gs82K4m2XBfWv349Lsdg74vpmMd4Itm+vzT7Mam2N0iDl4F
         SO5HGT0gHhhg7a/ZeTlgE3lziZyQimiYeSEvfH0xhIjg7fz6ApM9FBzvpxk8ZVdKjIXG
         gpGE0zShJcdGjy1Hi/HjCA/NtdpBBGL5Dg6iulx1zroz7FEqVVsIcGnS7Whttk8/2vtT
         43Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LLfpLlhpw31KK81zU7lFM9kt119J6dbXq0O/nIm28/8=;
        b=kvoFQki4+stPMc+ctP61azsG/Pvb+2Bz9UbCQA/0jH8aqjL51crHsVFAMyayqaSphg
         88Ahh0M439PRzjLkVCTkw5qHCrj449M93H2/S27KUKc0KKf/Lojctvv87nlmn3tSAA04
         8E1SD4UFMcV2kR44rNiGS7QDq31RIw9Wb3/6IFwA/sfLl00PWFruTa81gsfF79bg2vCA
         D6g2bJzb+MXtM3YrS3v1L26JjGXymIceIWe49CQCoGrC75uMtHY5lduwzZJkBAdfkolh
         DA0n4fvbbzxAWz7G5EC4q21mPyjy4SUHK3g6JDiyL2y4BmY7mibsgyq9gMuiYdUMqxb7
         Z3vA==
X-Gm-Message-State: APjAAAXF/rnWKtgIl2jsSTh6SQ87FsKok4AFH4O15VMj1JjPxSZWs7I8
        mY8OfXhcrUc/UxihVOkLczWrpv8+kpiuUwLj
X-Google-Smtp-Source: APXvYqzutRrWrk1Kt7GPNlJgeKL8awziDsAl2CkZ//oa8sSoK10zDGfupLL3KRdqutmsRpnS6M61oA==
X-Received: by 2002:aa7:83d1:: with SMTP id j17mr41084488pfn.78.1554862406390;
        Tue, 09 Apr 2019 19:13:26 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:c47d:9491:9418:887])
        by smtp.gmail.com with ESMTPSA id u26sm46050806pfn.5.2019.04.09.19.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:13:25 -0700 (PDT)
Date:   Tue, 9 Apr 2019 19:13:25 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, peff@peff.net,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v2 7/7] rev-list: detect broken root trees
Message-ID: <e0bd479e822ce81de280ee6fdd07f608a96b7836.1554861974.git.me@ttaylorr.com>
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

From: Jeff King <peff@peff.net>

When the traversal machinery sees a commit without a root tree, it
assumes that the tree was part of a BOUNDARY commit, and quietly ignores
the tree. But it could also be caused by a commit whose root tree is
broken or missing.

Instead, let's die() when we see a NULL root tree. We can differentiate
it from the BOUNDARY case by seeing if the commit was actually parsed.
This covers that case, plus future-proofs us against any others where we
might try to show an unparsed commit.

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects.c                         | 3 +++
 t/t6102-rev-list-unexpected-objects.sh | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index bb7e61ef4b..b5651ddd5b 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -374,6 +374,9 @@ static void do_traverse(struct traversal_context *ctx)
 			struct tree *tree = get_commit_tree(commit);
 			tree->object.flags |= NOT_USER_GIVEN;
 			add_pending_tree(ctx->revs, tree);
+		} else if (commit->object.parsed) {
+			die(_("unable to load root tree for commit %s"),
+			      oid_to_hex(&commit->object.oid));
 		}
 		ctx->show_commit(commit, ctx->show_data);
 
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 28ee1bcb07..28611c978e 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -67,8 +67,10 @@ test_expect_success 'traverse unexpected non-tree root (lone)' '
 	test_must_fail git rev-list --objects $broken_commit
 '
 
-test_expect_failure 'traverse unexpected non-tree root (seen)' '
-	test_must_fail git rev-list --objects $blob $broken_commit
+test_expect_success 'traverse unexpected non-tree root (seen)' '
+	test_must_fail git rev-list --objects $blob $broken_commit \
+		>output 2>&1 &&
+	test_i18ngrep "not a tree" output
 '
 
 test_expect_success 'setup unexpected non-commit tag' '
-- 
2.21.0.203.g358da99528
