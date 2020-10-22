Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4008C4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 07:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6808A22248
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 07:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYvxIeeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508383AbgJVHUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 03:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440119AbgJVHUG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 03:20:06 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE74C0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 00:20:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y14so567942pfp.13
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 00:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75002kI6Sz9A1VtaOvJzjIf/HZtevb9xw7ms9rpQt+o=;
        b=AYvxIeePJiUf29P3brJ91Mmk59+vyswLdhsj8x1eIFNWPJRexEV1uuck2mKKiBZSVB
         9JQHFwYtqFHGGcWHVkTtjoxZiOqEJVaUBr3lG7A02gnc/oYOObSOphETudfFH1NspVqD
         ROWDwNGFqd0B4gSZk+jZsiqgtQXw/0yceNFwqAcdN1b8b6NVcsZpDwIb1/XnAaNTAPsL
         2G4eBCdbBgF67dplYk+qRWGI6BtuFrNKal1fhoe1ewIO158xX0wdDCG31D60eSLwkcuc
         +dJWc6OV+RjsSGOTGb/jQj2Kds4wHgNmiADQDw1b2nOe6YoGJbxAFjwUS5xRKswzl93x
         nGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75002kI6Sz9A1VtaOvJzjIf/HZtevb9xw7ms9rpQt+o=;
        b=iENcGJsrGEO+P+FvC2/vLWFRTv7JSXvkDsEk1u4Ay6BqFU9ms3rbk4+gWku+uP/Ccp
         DwINU1pWAApKf3ur6THjVEq9RhPru22dU9BZKbitPhmVJhVi9i4JjTkrUOOt5eo2j/Xe
         kDDOBy96B59gWqxcTDTfbr72GieGT47DGP2Jzsz5TJ/vqu87DvrJEggclAtkE6r4fAX5
         IKCHr6Q+sJNamkGyOxE9Iw+Co27yzWLZzeIRH/ydUCCzffxAkTh3wk821Jh/IMmjLwW3
         qMpkAHj2RTPp3NyCAQpdkn72URvV1rYTs9SAFGGb1bG7WdDdP5CiqyyHnSD9jEZIMp0i
         iUKw==
X-Gm-Message-State: AOAM533BVlfwOKmUfs/6XxTxuCXRyKMdsvc0/tSnRhTQPiu2tKXPPx/Y
        gLNFy/IsSxgs45i+Yq0Qwli+t6shSl0Brg==
X-Google-Smtp-Source: ABdhPJy6hHWgXx6THeVzcNilEl5dLXarNClvGQJ8susj1U0MhdWq5J3up1LF/qRXRfGQVVqKxgaVNg==
X-Received: by 2002:a63:3c5c:: with SMTP id i28mr915064pgn.166.1603351204730;
        Thu, 22 Oct 2020 00:20:04 -0700 (PDT)
Received: from localhost.localdomain ([2409:4050:2e84:4e7a:290b:4332:f03e:69aa])
        by smtp.googlemail.com with ESMTPSA id 78sm1030004pfz.211.2020.10.22.00.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 00:20:04 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com, me@ttaylorr.com,
        phillip.wood123@gmail.com, sunshine@sunshineco.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v6 4/5][Outreachy] t7201: use 'git -C' to avoid subshell
Date:   Thu, 22 Oct 2020 12:46:49 +0530
Message-Id: <20201022071649.24284-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201021124823.2217-1-charvi077@gmail.com>
References: <20201021124823.2217-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t7201-co.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 74553f991b..5898182fd2 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -339,10 +339,7 @@ test_expect_success 'switch branches while in subdirectory' '
 	git checkout master &&
 
 	mkdir subs &&
-	(
-		cd subs &&
-		git checkout side
-	) &&
+	git -C subs checkout side &&
 	! test -f subs/one &&
 	rm -fr subs
 '
@@ -357,10 +354,7 @@ test_expect_success 'checkout specific path while in subdirectory' '
 
 	git checkout master &&
 	mkdir -p subs &&
-	(
-		cd subs &&
-		git checkout side -- bero
-	) &&
+	git -C subs checkout side -- bero &&
 	test -f subs/bero
 '
 
-- 
2.29.0.rc1

