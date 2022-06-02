Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC799C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 12:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiFBM0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 08:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiFBMZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 08:25:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C6B1EEBAF
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 05:25:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h5so6298155wrb.0
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 05:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HI0hPeJ9aPK59FN3Uwdr6A54KEAUuPB/OxxJItpI0sk=;
        b=UcMH0gyYA4dLMjStm2BQuCGI4SiqzR2A5SdrgG6sN61qj2099uB4nB/gELOT8qIt29
         SPj1XLHeYMnq39YxpLD5aojyh8UlFaAUVieKRMNhNC8sfi7rfT9pe9oR7CadPrEX3mN+
         gBtA5ak+QAFA5nlw6xRcIrBvuPKtXFwJEWVc7mS0HpDGijhZmbo08IqLBwu0rkwRHjsp
         xPY9Zjwtb6j9Bxk4gFFzCL1wcXeCPplhke+uhTMPVTEw+4WjIrsVsHvSU95/P5qCI7Vs
         67rcthRBlwOMjRBvU1gOhqy+iWdGWLv/5ZuchzanjYJbXenFrisPy7e5tlXhOjFWsfql
         fo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HI0hPeJ9aPK59FN3Uwdr6A54KEAUuPB/OxxJItpI0sk=;
        b=OXed08leTWBBo7dkFbAbkCGGUXUD4sSkpwk8MdjyYRTZsqdkYzbUzqcjmjaR/D3kjt
         V0fcczT1sYQMhLMtSKpzQFkIuGMHYiWxUxKpZ+KIGEEZPBO9mRYy2KmF/hGB5RdKxET9
         he+RJlzBt8AL3p6qhQY8tyvQ2Nd7HCaKTgQVeNbA0GHY4j1NEZ5Bt4nu1EWfTooMX4lv
         SG/KZutxS6QJxu/3NWZlUzRirdIbuSbe+q1JBVExSwz+RBBneNCBBJT8fbX9G2P6UjpH
         x5SuzS266ErUaowoJWTpZXH8oSLV2nivOS/aNR85UkghMVCkzlYhhoLiA/IJVT6b+YpB
         YVhw==
X-Gm-Message-State: AOAM5336c1+rqURQn4aeW0PJInVB0fjsV9gLbOVw70CcI4/BvTHwCyMP
        ehQa57Q+JzPnexn78aPdmVo0iFpvMN4yGA==
X-Google-Smtp-Source: ABdhPJwo3hDibqSzUM1ieQSAF/D0JSCJ0pg6gY5+qkRDVdUboiFXH9r1HIGlpnL0G/kqkJj2iVx0Bg==
X-Received: by 2002:a05:6000:1c2:b0:213:3b79:bd7 with SMTP id t2-20020a05600001c200b002133b790bd7mr2031971wrx.634.1654172746853;
        Thu, 02 Jun 2022 05:25:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b0020e615bab7bsm4305100wrt.7.2022.06.02.05.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 05:25:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/6] cache-tree.c: use bug() and BUG_if_bug()
Date:   Thu,  2 Jun 2022 14:25:37 +0200
Message-Id: <patch-v3-6.6-754a66be365-20220602T122106Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.gb3ecdfb3e6a
In-Reply-To: <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "BUG" output originally added in a97e4075a16 (Keep
rename/rename conflicts of intermediate merges while doing recursive
merge, 2007-03-31), and later made to say it was a "BUG" in
19c6a4f8369 (merge-recursive: do not return NULL only to cause
segfault, 2010-01-21) to use the new bug() function.

This gets the same job done with slightly less code, as we won't need
to prefix lines with "BUG: ". More importantly we'll now log the full
set of messages via trace2, before this we'd only log the one BUG()
invocation.

We don't replace the last "BUG()" invocation with "BUG_if_bug()", as
in this case we're sure that we called bug() earlier, so there's no
need to make it a conditional.

While we're at it let's replace "There" with "there" in the message,
i.e. not start a message with a capital letter, per the
CodingGuidelines.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 6752f69d515..63953bf7772 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -692,12 +692,12 @@ struct tree* write_in_core_index_as_tree(struct repository *repo) {
 	ret = write_index_as_tree_internal(&o, index_state, was_valid, 0, NULL);
 	if (ret == WRITE_TREE_UNMERGED_INDEX) {
 		int i;
-		fprintf(stderr, "BUG: There are unmerged index entries:\n");
+		bug("there are unmerged index entries:");
 		for (i = 0; i < index_state->cache_nr; i++) {
 			const struct cache_entry *ce = index_state->cache[i];
 			if (ce_stage(ce))
-				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
-					(int)ce_namelen(ce), ce->name);
+				bug("%d %.*s", ce_stage(ce),
+				    (int)ce_namelen(ce), ce->name);
 		}
 		BUG("unmerged index entries when writing inmemory index");
 	}
-- 
2.36.1.1103.gb3ecdfb3e6a

