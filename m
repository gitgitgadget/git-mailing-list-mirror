Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A184C4320E
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6496103A
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243606AbhHZVBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 17:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243597AbhHZVBC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 17:01:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D152EC0613C1
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:00:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u14so9054253ejf.13
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=psUg+hL3CydiurDd5kHZxqXmzehbIRKXtj0b29Ft2ig=;
        b=iWpmLhyXIS4XXJ1b0ENyjdWwXP3mBPqQMQYGUIL9D34eqwGjpE3BWesYHVe//W7ikp
         mcfK/rihzCde24/9QcX5XcC5Jyyvbvm7EWJp+NIVMI6YRTsIYmZV8Qi1W+nEg+AU5Vai
         lypdwm7wUBIzj/N1opT2gTe+GpmNvhaUyEKRLiVixMCmCDP2vFBpWRcE/X4Yq8OrucLN
         NDhyA87tai89tBuBwaSTY1BMC0OAYJC9fnncW5fZkIF+aDDCSvTLpq/kVrm/B22osK97
         uLhzo5kieu5zXBxpx5iDDemiMAiC7cL+E3K1dVRLnTiR7NT0gVauPmYM0/i8RgcjW3Nw
         WXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=psUg+hL3CydiurDd5kHZxqXmzehbIRKXtj0b29Ft2ig=;
        b=dyuwBILZbnNJ7JLKs2iMuwrca/RDlqeATo2b/9nm0vOUM7Md4fmmbPJCTwqet6A0ak
         z98BMdFgpDaeuX//I7brMcJHCIhVd5yIN80Mf8rQnAvAKm7KvTMo9b4B2JCFeZId5V+y
         MAWqGxHIsgAdHxM4AKziP+lcntAjyjz8+XMnrUdFxxmkxGLl7wv0iNsZTli5muCvWshc
         btTBsTvpylGuYnym1s/HLQHx2y9vCSLbZ0vEQAG5YpsiwHuc/rFZjf3QBKGp+1tQgUKf
         gWGQ9Y7gUAW41sw6cp+N5mUJXxbEjuPNocI2mfojfGcUOOj6RjtjWmr+sIhQ/ymQIUfe
         we8g==
X-Gm-Message-State: AOAM531QBz0bdZEFTf/z4Pgbqp0Qn+77gHwxmkGGANOsr+vbyEPR0NyH
        QsjiJzZMsogdtSO/OwBDxGrTRrb80eA=
X-Google-Smtp-Source: ABdhPJwzlIT+9b1b2flAJdRSfnxQu78a08c9TWGHkz/e1Tv+t5MkqrBFNEV3gNNJ013clunU6lAAzg==
X-Received: by 2002:a17:906:9b87:: with SMTP id dd7mr5965796ejc.99.1630011613470;
        Thu, 26 Aug 2021 14:00:13 -0700 (PDT)
Received: from localhost.localdomain (84-236-78-211.pool.digikabel.hu. [84.236.78.211])
        by smtp.gmail.com with ESMTPSA id q14sm1884779ejc.93.2021.08.26.14.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 14:00:13 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/6] t1600-index: remove unnecessary redirection
Date:   Thu, 26 Aug 2021 22:59:59 +0200
Message-Id: <20210826210004.672860-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.358.g803110d36e
In-Reply-To: <20210826210004.672860-1-szeder.dev@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
 <20210826210004.672860-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a helper function in the 't1600-index.sh' test script the stderr
of a 'git add' command is redirected to its stdout, but its stdout is
not redirected anywhere.  So apparently this redirection is
unnecessary, remove it.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1600-index.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index c9b9e718b8..5d10cec67a 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -79,7 +79,7 @@ test_index_version () {
 		else
 			unset GIT_INDEX_VERSION
 		fi &&
-		git add a 2>&1 &&
+		git add a &&
 		echo $EXPECTED_OUTPUT_VERSION >expect &&
 		test-tool index-version <.git/index >actual &&
 		test_cmp expect actual
-- 
2.33.0.358.g803110d36e

