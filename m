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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C61C433E9
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B9C23998
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbhAPRL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbhAPRK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:56 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27325C061348
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:03 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a12so12203615wrv.8
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=An/zKZa1E49Kciw5ZClBz1TrdY350YMpfW+jugg+QWY=;
        b=cgcsmK39jLRgV7ZF/gq5pyMDRSFiNWzBkSRDbterwnzyY1ArzN5QFu4ivh5L/4fKSL
         JbVCwBQ/GYHV65aQ8qdYPCsYZJau52yNJoaVhNnVG8DXzbVOqO3fU+gq6uPO+jozvlPe
         jiv4qNXDf5LGsrPQFlKYvGU9GwckF56OhLFzBP2nO4rheCtCvGyCmtn1l9tqdIj7f2VC
         4V1F+tJntWgxEEIpKitRSOz3YPIp9eRTz6lvv3WNKs1DbtKTny4I4a01zjXOlTXqtAnX
         R6EcKzeryoLHUfzvuLvOXYjebaG62rvrioTG0HOMnWwZMstq33OS/r0llUjJc6q86BdO
         YTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=An/zKZa1E49Kciw5ZClBz1TrdY350YMpfW+jugg+QWY=;
        b=VpKonc9ceZ06HL2JBmXYyD7nqLJQrLt+GzfSP6XE5HdTuuFLWnIIOx9KczSmcTcxJc
         5X4k7rSUqlDwooOCMkKQK3QSg/je9VHpK1EmqqHFzY2SKv8MDzpRsl4/IVsP1ysCZ2Pu
         G40GDpl4B8FHz2KQwN9jBL43/oSzII7CKDS5oPIIejs9AfwFsL0e2D7rtzD+OWGimakB
         jkfakuDWHjTiFTCSLCDAuezw1Osi/01ZbL2Zba/QGej74BvqAV3weBnvEUkGY69ZK93B
         OV4UYIuc+SYVdmBugor9GN1m9AjEDo0JFHAbdis2fyloxPrh80eafIUNvCAQzJrRYQ7J
         GG/Q==
X-Gm-Message-State: AOAM5333KcW5qp0GVaVlbP+uF1IJVkTW3wik+mu76LgtoEm8BwTm7RqL
        nZIsBFdg/wOq1pxA+z2ATo2+7gOQZWnplA==
X-Google-Smtp-Source: ABdhPJw5OGjwyh2PAyI7hDO1+8ktW75yIvZLLA6zgOAMCLJspvSv3Rc1HmitGEhL6F4fcrQlThvTGQ==
X-Received: by 2002:a5d:43cc:: with SMTP id v12mr17939494wrr.319.1610811361641;
        Sat, 16 Jan 2021 07:36:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm20008855wra.53.2021.01.16.07.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 07:36:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/11] cache-tree tests: use a sub-shell with less indirection
Date:   Sat, 16 Jan 2021 16:35:45 +0100
Message-Id: <20210116153554.12604-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210114233515.31298-1-avarab@gmail.com>
References: <20210114233515.31298-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a "cd xyz && work && cd .." pattern introduced in
9c4d6c0297 (cache-tree: Write updated cache-tree after commit,
2014-07-13) to use a sub-shell instead with less indirection.

We did actually recover correctly if we failed in this function since
we were wrapped in a subshell one function call up. Let's just use the
sub-shell at the point where we want to change the directory
instead. This also allows us to get rid of the wrapper function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0090-cache-tree.sh | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 354b7f15f7..2e3efeb80e 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -27,20 +27,15 @@ generate_expected_cache_tree_rec () {
 	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
 	for subtree in $subtrees
 	do
-		cd "$subtree"
-		generate_expected_cache_tree_rec "$dir$subtree" || return 1
-		cd ..
+		(
+			cd "$subtree"
+			generate_expected_cache_tree_rec "$dir$subtree" || return 1
+		)
 	done
 }
 
-generate_expected_cache_tree () {
-	(
-		generate_expected_cache_tree_rec
-	)
-}
-
 test_cache_tree () {
-	generate_expected_cache_tree >expect &&
+	generate_expected_cache_tree_rec >expect &&
 	cmp_cache_tree expect
 }
 
-- 
2.29.2.222.g5d2a92d10f8

