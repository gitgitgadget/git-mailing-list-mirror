Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DD5C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168A861222
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243703AbhDLRQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbhDLRQA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7468BC06138C
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:42 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r7so1746022wrm.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YHqYmqdaHu7w0ZNjZphct/fbY3N7u+QZixe8/f8BEtQ=;
        b=dWk8CSgei8Oh6q6bXGr0hYMpxjvhT5kHFBIhn0QyC4K8OeUh3KQodeJBxEPDSVmscI
         20AV6v9DAcgYfoh8Fs04wxt2jEcD7HSzaBzd6XNV5qsnazeQVoPuudEE2dwp82ulhb6e
         3PQoppLPVM+poCkJlxRqgJCa2D2aYIRfxiCAkuvdt3vDFvbI9IQsi2bnHkCk6OFkMABe
         nR57JkJhI0P+CUGgXRESnhz6OvJqS3JEGK8sT8uMryRgUpXUw7L/ORxd4UgwsLXrrdMu
         rLdwZY0L6CXDOM7WtLOCfpzFXknKH4+1CIpXkE6vjZmN1O+ZqdAB6arHw7KFBxYA22wQ
         IvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHqYmqdaHu7w0ZNjZphct/fbY3N7u+QZixe8/f8BEtQ=;
        b=ru4lAsZC72Nv3bF3Xv4E0bf9Rpx3Uxo9Wm/wiZhOnLHINNQjj53CYiA8IJfFKk5/Nc
         jBRSIfybiBcxpVXXbgvpW1EsjNjAhb2/oWBpgXxy/k2nrZG1aymxw5fenKp0X9XUzqPS
         mYDb7TT0+27UV7MDQDv5EJUhQtl79TBBdJQSazX3P86ndu0LaNSj4cqsywxiyr9TlYXK
         uORFW3WvhvyQ3pbZ42W1ciHd5pPPBVzhM3/U7ujugn+mEJa4OT6P5xKX60ZbnSu2LilM
         widY6rQF372vPBKt0J2/J6/5vvPmkWNgHOEL1dqQX90xfNxXY3SnS0ouF3CiBNODnNBZ
         DelQ==
X-Gm-Message-State: AOAM533sZUZ9p+0NjZCIKMlWnyUYtm+VNPvTHNR9QYOntIToKmmIea/S
        0VMVHQAu3tErTCaiiWKFEm5vVkZptPNBuQ==
X-Google-Smtp-Source: ABdhPJxL+eH4dJO8nA8JMnF26sQ34Re+GsduAbQUbp8/o2sMOzUShu7+W3ugq4cKXcqkFzpwau6ibw==
X-Received: by 2002:adf:d082:: with SMTP id y2mr31344054wrh.176.1618247741004;
        Mon, 12 Apr 2021 10:15:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/22] pickaxe tests: add test for "log -S" not being a regex
Date:   Mon, 12 Apr 2021 19:15:11 +0200
Message-Id: <patch-04.22-ca6340c1fa7-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No test in our test suite checked for "log -S<pat>" being a fixed
string, as opposed to "log -S<pat> --pickaxe-regex". Let's test for
it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4209-log-pickaxe.sh | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index eacb9f0a1b5..9fa770b5fbd 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -106,11 +106,18 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
 	rm .gitattributes
 '
 
-test_expect_success 'setup log -[GS] plain' '
+test_expect_success 'setup log -[GS] plain & regex' '
 	test_create_repo GS-plain &&
 	test_commit -C GS-plain --append A data.txt "a" &&
 	test_commit -C GS-plain --append B data.txt "a a" &&
-	test_commit -C GS-plain C data.txt "" &&
+	test_commit -C GS-plain --append C data.txt "b" &&
+	test_commit -C GS-plain --append D data.txt "[b]" &&
+	test_commit -C GS-plain E data.txt "" &&
+
+	# We also include E, the deletion commit
+	git -C GS-plain log --grep="[ABE]" >A-to-B-then-E-log &&
+	git -C GS-plain log --grep="[CDE]" >C-to-D-then-E-log &&
+	git -C GS-plain log --grep="[DE]" >D-then-E-log &&
 	git -C GS-plain log >full-log
 '
 
@@ -118,7 +125,24 @@ test_expect_success 'log -G trims diff new/old [-+]' '
 	git -C GS-plain log -G"[+-]a" >log &&
 	test_must_be_empty log &&
 	git -C GS-plain log -G"^a" >log &&
-	test_cmp log full-log
+	test_cmp log A-to-B-then-E-log
+'
+
+test_expect_success 'log -S<pat> is not a regex, but -S<pat> --pickaxe-regex is' '
+	git -C GS-plain log -S"a" >log &&
+	test_cmp log A-to-B-then-E-log &&
+
+	git -C GS-plain log -S"[a]" >log &&
+	test_must_be_empty log &&
+
+	git -C GS-plain log -S"[a]" --pickaxe-regex >log &&
+	test_cmp log A-to-B-then-E-log &&
+
+	git -C GS-plain log -S"[b]" >log &&
+	test_cmp log D-then-E-log &&
+
+	git -C GS-plain log -S"[b]" --pickaxe-regex >log &&
+	test_cmp log C-to-D-then-E-log
 '
 
 test_expect_success 'setup log -[GS] binary & --text' '
-- 
2.31.1.639.g3d04783866f

