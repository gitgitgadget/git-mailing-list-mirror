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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3BCC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0EF1610FB
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbhGTLLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 07:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbhGTLLg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 07:11:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE49C061762
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:52:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h8so28135722eds.4
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z/ZbnzTKpkP1CAMhggcuNIgtP/1e+nw/W2ODrD2+6kU=;
        b=c68bmcFZ1Wsa45oXHt+JkaGjE5ZxdDELjzX2EbFKN+nAIXyLeSx8e/X3P3kpEYjLGV
         xxiE7E189RelppVHzhSzyBJ7uXmEFkY/emjvG1xCYRhnlKeYZIf2iYfqbgWzTVE/d9Fi
         z+TZecCaNV7gPQ0sK+wPXErUR/rU0XtVZpMY6Ane4SXAw3s3GNPBsEDhLPGCRbTB+qs1
         aY9huX9OVnQBFvzXz5f1WQc1CTjtehRmrJidUHoz3s2dbncIRx5OJJD+sz7SThhOGG4c
         TD3BLrk8numiFXq2JHUAFGUA4OE59C+AZb+Ptu4bd1eAfQBgs2GZBT24V/PGIL3ekaf/
         GBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/ZbnzTKpkP1CAMhggcuNIgtP/1e+nw/W2ODrD2+6kU=;
        b=i91SC+7nE7Qvn48Zt7QZMV6PYRfaFOGbXRO2KW9YgeBQ1AMiWkpCiqypVzY6k8yCMx
         oIO8s2PfjR2UhVTZReHxbH9sGT3a3tBXm4v8RFtp8Vfe+EcB18kSGDj4OHHsjeZUpYyW
         AzGfx8PIpoQMpjLH8yIPRsEObmavm6Ru03eB7Jp51CbY66l5MbVKzZ+h+lIutQ7p9PDA
         vFVtlRI82PvFUpW9Rc9DZ0tiG1d7mj8H0zdGEr/+jZEhsF7dXcAa7jLMCmvsY1eQqUKs
         45ZzrIbl9Ydy76vjncW1UxwQeMHHDN69CYN752upjCIrVq4HKKif3YRw/gVuxpwZANOz
         daOw==
X-Gm-Message-State: AOAM533vRpTGgnDmz154DP70mw7MlXPoC5ZRLxK8nwu2zjy1i6fEBMuk
        CAK9zk9lHWQKddafTv+wX9pp2QQQseSREA==
X-Google-Smtp-Source: ABdhPJzsQIjCEGBl1O2j0wPcWtxaxD9dibBGQHSveBQ/ogkQ2HYY3jxPng/gk1o5v/m+Ek242L/6vA==
X-Received: by 2002:a50:fb04:: with SMTP id d4mr39980798edq.143.1626781933325;
        Tue, 20 Jul 2021 04:52:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i11sm9100409edu.97.2021.07.20.04.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:52:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] bundle tests: use ">file" not ": >file"
Date:   Tue, 20 Jul 2021 13:52:08 +0200
Message-Id: <patch-1.2-746d727113b-20210720T115052Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change redundant uses of ":" on the LHS of a ">" to the more commonly
use ">file" pattern.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5607-clone-bundle.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index f4c383cd5ce..c9323a08fe8 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -54,14 +54,14 @@ test_expect_success 'bundle --stdin <rev-list options>' '
 '
 
 test_expect_success 'empty bundle file is rejected' '
-	: >empty-bundle &&
+	>empty-bundle &&
 	test_must_fail git fetch empty-bundle
 '
 
 # This triggers a bug in older versions where the resulting line (with
 # --pretty=oneline) was longer than a 1024-char buffer.
 test_expect_success 'ridiculously long subject in boundary' '
-	: >file4 &&
+	>file4 &&
 	test_tick &&
 	git add file4 &&
 	printf "%01200d\n" 0 | git commit -F - &&
@@ -75,7 +75,7 @@ test_expect_success 'ridiculously long subject in boundary' '
 '
 
 test_expect_success 'prerequisites with an empty commit message' '
-	: >file1 &&
+	>file1 &&
 	git add file1 &&
 	test_tick &&
 	git commit --allow-empty-message -m "" &&
-- 
2.32.0.874.ge7a9d58bfcf

