Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8470CC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DF720781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vd4uPI3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbgKJVVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731759AbgKJVVw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:21:52 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211F6C0613D4
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:51 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 79so111026otc.7
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l6cBJZ7n75P2T0lJKrk+2Tr6lfmT2bdrYr6QjHYYFOc=;
        b=vd4uPI3rpaCQjrUKNiOJsFGT1iAWLNXF7JQp9D4H+asdUNZCwrvUt2YYPrKVqW4fIR
         o85eVojpcABmcSZPPM9XA2shKZKCCrMXZ50kJuhnYLSOEFal4miGumt2EV4prI8bJZ2M
         /aoCNsTaYIJjte+uwESOVP5elhE6jERD5AXNZVBEvgA60Gic65UGdyI/NV4WbxX7nO2+
         E9X03SGNWxfLhvTQWKiu9eP64mIj2xTD1iAHv90aXHbnNjTDIlFVvdSCXCdotW4royxo
         y+pvPMIX2Xv1QWGFWyeDTHqnGV3ttcRG2Dh9nRcqSqiYL3YaXdrpEAFL5LufkIAxsdLS
         8Ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l6cBJZ7n75P2T0lJKrk+2Tr6lfmT2bdrYr6QjHYYFOc=;
        b=HGx38G3vCzjsp+1SBN/lFfH6t6JYv0NQDK3M1vmWq5JtYmVGUz+tTAKkjjIw+GvNaY
         FzrrJU0FKIhuSSnh5+QaTyf9+BvrPBPi+kWATkAQRe+cC1aa6sb2rvDcaG8uaY3HQubG
         wfLWjgM1GcK3MC1PRlAUfzbWrd9fiSUJY6aCrLrhTsNSrvwYoXEFZvcrGfeCacKsOHRt
         rSKt1eQOKrIonytPYzWcFJ3t9QWRSZqKGujO+jxoiLhDNWAbMAF3Lm02XiKnY+g1XW5w
         71Z2BNFqSIABet46V+Dbz6zZTne778PICI6bW/4yTkj17r3TghVts7zcQJrPgTSAmJ3j
         2m3Q==
X-Gm-Message-State: AOAM5332eqZO0/HQmsdVJsfqtvLNa7ElNmH3Y3nMGiQqSMy75Vp+x7ns
        uSahgCES98ouOdvJQuOlKOPe/u/cbGFeug==
X-Google-Smtp-Source: ABdhPJwB7p60ElW+V7KckrkCX0Q5zkUErxiayurCHTzuADOrGm41rxf1fNxlN7MklX29CmIRNBfRjg==
X-Received: by 2002:a9d:371:: with SMTP id 104mr15898193otv.266.1605043310321;
        Tue, 10 Nov 2020 13:21:50 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m109sm26102otc.30.2020.11.10.13.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:21:49 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 05/26] test: completion: fix currently typed words
Date:   Tue, 10 Nov 2020 15:21:15 -0600
Message-Id: <20201110212136.870769-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They don't match what we are supposed to be completing.

No functional change.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 4deda01153..2e04462bb0 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -486,7 +486,7 @@ test_expect_success '__gitcomp - option parameter' '
 '
 
 test_expect_success '__gitcomp - prefix' '
-	test_gitcomp "branch.me" "remote merge mergeoptions rebase" \
+	test_gitcomp "branch.maint.me" "remote merge mergeoptions rebase" \
 		"branch.maint." "me" <<-\EOF
 	branch.maint.merge Z
 	branch.maint.mergeoptions Z
@@ -494,7 +494,7 @@ test_expect_success '__gitcomp - prefix' '
 '
 
 test_expect_success '__gitcomp - suffix' '
-	test_gitcomp "branch.me" "master maint next seen" "branch." \
+	test_gitcomp "branch.ma" "master maint next seen" "branch." \
 		"ma" "." <<-\EOF
 	branch.master.Z
 	branch.maint.Z
-- 
2.29.2

