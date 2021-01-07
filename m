Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7913C43381
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF8220578
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 09:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbhAGJxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 04:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbhAGJw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 04:52:56 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F740C0612F6
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 01:52:15 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c5so4987738wrp.6
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 01:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d+vOJQsMft5q7E3s72vyMd4bot26X4jcMwe0TiApWEQ=;
        b=rHKKFiD4116x1Ejz78C/y2mUbMuDPHuCaNuMxMr+++mFX5NfbV/dqDfDbRX/7mb12B
         qX1mnmsZrWk8/Lj3BzxHkB4e1fS9QTNkeltv+CbLyoKhQeK5a3hrTMi1N/siKPgLsfRE
         Sa+l/uP9H7K3j3JVk9WwLrDDPlSg6kCCAdbH8XwgcDrIHMRFG8ujxknhc9Ww6MJrbC8B
         phhUV4yIMsIUZru20jLwuRI9S/0ZiXFyCwQ48E6UyWlVhE5eapohjGyNHfltB2A6Mdk/
         +m22Dze01fSZatNLZPoi1d4dj9sK4kSIqaXa4fPuthUKJYFSav0TMQBmzB4YT02Yg5A2
         /yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+vOJQsMft5q7E3s72vyMd4bot26X4jcMwe0TiApWEQ=;
        b=gSwxGyHbDTiykk2vVaM0szc5dIjAs9aP0NdOgTqqB7Ynz63KI4aLzQe7+NsBqpLuXs
         /s9FodFAKczp4dEmbYOu5Dz5oADf91mKgrXDaxQWjyDKM5cXUMbysx2AyIpk7jYFOete
         khABmBE+EtEblsKMUd/kMA9YfCiHysW+GSBPGcKo+gkYkVLcAI540zurRDBs4nWkFGUB
         YxvJ13cpICc2HeDzoXTWxjPtZIOjRoy3KU2KNjEOGozlaw1PMXupOxJxS40VdE5HkaRi
         spqssawYdshCSEyataxFRdA58yVMn6vr7Y01Wlh8960S2PXyopN2yhO+InBhDUDRAEO6
         3pqA==
X-Gm-Message-State: AOAM530PkgnO++pbHJ6TRJrnXh+acS0K33/cMnQ9DWaNR185zNJrAeG2
        UBjUBTiB+lAkA8iMhqKOTIEvHg0Z5O1S1Q==
X-Google-Smtp-Source: ABdhPJx9PGRuINnb+Wpbr/J5hq+VK0qnZ5/8/WlrhZA7wik5tj7flRMw1OVNmkpl/zaVs3EzG+oxQA==
X-Received: by 2002:a5d:5401:: with SMTP id g1mr8076024wrv.93.1610013133865;
        Thu, 07 Jan 2021 01:52:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm6806535wrq.38.2021.01.07.01.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 01:52:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/7] branch tests: add to --sort tests
Date:   Thu,  7 Jan 2021 10:51:48 +0100
Message-Id: <20210107095153.4753-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210106100139.14651-1-avarab@gmail.com>
References: <20210106100139.14651-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Further stress the --sort callback in ref-filter.c. The implementation
uses certain short-circuiting logic, let's make sure it behaves the
same way on e.g. name & version sort. Improves a test added in
aedcb7dc75e (branch.c: use 'ref-filter' APIs, 2015-09-23).

I don't think all of this output makes sense, but let's test for the
behavior as-is, we can fix bugs in it in a later commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3203-branch-output.sh | 51 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index b945faf4702..f92fb3aab9d 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -210,7 +210,7 @@ EOF
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'git branch `--sort` option' '
+test_expect_success 'git branch `--sort=[-]objectsize` option' '
 	cat >expect <<-\EOF &&
 	* (HEAD detached from fromtag)
 	  branch-two
@@ -218,6 +218,55 @@ test_expect_success 'git branch `--sort` option' '
 	  main
 	EOF
 	git branch --sort=objectsize >actual &&
+	test_i18ncmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	  branch-one
+	  main
+	* (HEAD detached from fromtag)
+	  branch-two
+	EOF
+	git branch --sort=-objectsize >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'git branch `--sort=[-]type` option' '
+	cat >expect <<-\EOF &&
+	* (HEAD detached from fromtag)
+	  branch-one
+	  branch-two
+	  main
+	EOF
+	git branch --sort=type >actual &&
+	test_i18ncmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	* (HEAD detached from fromtag)
+	  branch-one
+	  branch-two
+	  main
+	EOF
+	git branch --sort=-type >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'git branch `--sort=[-]version:refname` option' '
+	cat >expect <<-\EOF &&
+	* (HEAD detached from fromtag)
+	  branch-one
+	  branch-two
+	  main
+	EOF
+	git branch --sort=version:refname >actual &&
+	test_i18ncmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	  main
+	  branch-two
+	  branch-one
+	* (HEAD detached from fromtag)
+	EOF
+	git branch --sort=-version:refname >actual &&
 	test_i18ncmp expect actual
 '
 
-- 
2.29.2.222.g5d2a92d10f8

