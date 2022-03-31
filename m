Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0321DC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352248AbiCaBOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350628AbiCaBNz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:13:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E676622D
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:09 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so1097561wme.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=myaYtSqjPTfG95scsZhSxDhASYneOiFhKhTyMCIcc6k=;
        b=Bu5IJEXwvirvLrkcbnsgd58jT0O75oVRL2G5X6IbR3MaRP0lXvXRBYNp9l/HqR184Z
         gOsrB+ZWYdpkXstIx/6cHolO9beMoUN4WHzdyJRyr46xFnR1+Jn2ryGgTm6X+kAexn6s
         zdaso48vz879d0B3zMwop9ot2XZgoR4FiUUWE2IhQvu6qN6NLLXC6dTF4QOVx7nvIBTj
         657cjqpNqFiOIJq5Ayv/lxyT7Huco6mqkCMcld0r/QHf6hbRfooJEjYXPZ6C2/Y3Nf96
         IzSplvROlHOWSMHVp2/ZUkboZxlv6Is/Y4OpVdi2/+YNAVp8pvvLWkX3OyIf0yQTLc1u
         ED+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myaYtSqjPTfG95scsZhSxDhASYneOiFhKhTyMCIcc6k=;
        b=bFQGYKsGuO83YrCk0znxgRuwMiWohTtXY14wF3+BfK3+zj10CM7j8zbw3+mW7hrX1q
         LvMDVYXHfFy2D43Xo2Zb5W8Wj60Dx1PGrDYEJYL127N01FwCvIQkphMAnfPeiAuKYV17
         0gHC5bSe0kTG2HmGT9PXHVahM83ZQjXzZ/VLaF79p9eK8CmvE220VgONJ6A4aA+8o1Qn
         vVgzb7QCqWLs9HqxKJ9LxY57NsVb3BfVS91gI0MPszBMtvnwm1S50FFJun6TyzoRW+QF
         bZe2N89q1BOUFUD+9N9A3AdiIEjPK0KLr34xkPnZ5/Jc6QpgoZakfqzC1HzD/Ekdc6Q6
         SxuQ==
X-Gm-Message-State: AOAM531Xcs3+U/Xq/DX2PV02ahv5t6NGS+L0Yp4Zi7vWbiy9HN8WIHmi
        NowedQRYzlGmqp/r+RrZcxdLvUBHyo3FlQ==
X-Google-Smtp-Source: ABdhPJzk8+zpbcE3ixHdJYAR2XYVwvBT7MA5zscT5wWzHd1rvvJV70aBPmhpvsmbm8OfCaG6b2iL1w==
X-Received: by 2002:a7b:cbc5:0:b0:38c:a756:a8c4 with SMTP id n5-20020a7bcbc5000000b0038ca756a8c4mr2385853wmi.83.1648689127528;
        Wed, 30 Mar 2022 18:12:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/27] blame: use "goto cleanup" for cleanup_scoreboard()
Date:   Thu, 31 Mar 2022 03:11:07 +0200
Message-Id: <patch-v4-02.27-da5be507c0f-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a freeing pattern added in 0906ac2b54b (blame: use changed-path
Bloom filters, 2020-04-16) to use a "goto cleanup", so that we can be
sure that we call cleanup_scoreboard().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/blame.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 8d15b68afc9..885b381ab83 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1167,7 +1167,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	if (!incremental)
 		setup_pager();
 	else
-		return 0;
+		goto cleanup;
 
 	blame_sort_final(&sb);
 
@@ -1201,6 +1201,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		printf("num commits: %d\n", sb.num_commits);
 	}
 
+cleanup:
 	cleanup_scoreboard(&sb);
 	return 0;
 }
-- 
2.35.1.1557.g4e3e9cdb5e0

