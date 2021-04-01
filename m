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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C542C433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A2560FF3
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhDAR6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbhDARza (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:55:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC67C08EC91
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 06:56:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k8so1936747wrc.3
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wKtEcRlE9pDm2vZtPKjkj+Pa8oKcdZ0UFP6zBPGIm/I=;
        b=L9kLRGP0YXY7lUSN1tvoSp8W+FidQGtrrqnVJmCqYJiiopHA6leOXBXCYN5exntGMC
         DPbKvsShNMhVQoy/Ohw9qvdj7GS8wHlhJlFVxZvkc7ts/j+PgzuLiRi8cMtZ+yexlPF5
         bIXAoOjgYqS1Sq5p+uRoASfUoHbBNOPu3OiTVr4u/S3doEjhXtovvMKvH2FNgOLbBCaA
         NsvfrJ+F4xcum8BnxLtxt8+BrRT5W/1kPDkqmsStGTKweijXc8kn4BX6HA0Z+E/bkRhj
         J/zlMhiOEwale4jjJcPUv5vLZifzFvrO8SYWcFn2hm+nZ46fVFHl5nlBIkpyyNayhTyI
         KnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKtEcRlE9pDm2vZtPKjkj+Pa8oKcdZ0UFP6zBPGIm/I=;
        b=SYRv/bPCAYpZNe0p1xdBGDTnERFUiBbmwiy8zMieVrabNukynxOkoX32lFcq7U2zsH
         YSSsTTJr+fiwTZqrU6Q30G/GulL+CUan2ehXxRNshuF4Bz2zTAZ0AfDn1AHx352XSuVn
         EOr7hHwilqVnsJ4awjSsdETJs8MkMEKe4OkNIDsE4nck1LHn43u++/oduuXwyK203pw0
         RbaPdHZ19fY4NwNZiGOk15lfESCybUUDYn4M9mF5MJhvOJkLYnRS5xDMMYSQsEyhz7uU
         4D1+7pXDDoBTq6RROzVTi2FPYu7Clqly9XQi8qT+O3uKN0KnZBRUTJ1MOJbhKM7pP32E
         7QAA==
X-Gm-Message-State: AOAM530boxJ4ehBacBi94pXAmfBqVBPtvYM+MrABoHShwSlbMuEccMps
        YUGujbnEeMSvEOMMecnxQgSim7uZeIVfRg==
X-Google-Smtp-Source: ABdhPJxYfCUJpFK1WtcyyA9/szt/IqPyjXjM7TZf4FbivsC9R+KKDe3mDHjOrIDXrMbMRDHrhayBuw==
X-Received: by 2002:adf:8151:: with SMTP id 75mr9918551wrm.152.1617285394911;
        Thu, 01 Apr 2021 06:56:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n7sm10145770wrv.71.2021.04.01.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 06:56:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] mktag tests: invert --no-strict test
Date:   Thu,  1 Apr 2021 15:56:27 +0200
Message-Id: <patch-2.6-dd71740447d-20210401T135419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com>
References: <YGWFGMdGcKeaqCQF@coredump.intra.peff.net> <cover-0.6-00000000000-20210401T135419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the mktag --no-strict test to actually test success under
--no-strict, that test was added in 06ce79152be (mktag: add a
--[no-]strict option, 2021-01-06).

It doesn't make sense to check that we have the same failure except
when we want --no-strict, by doing that we're assuming that the
behavior will be different under --no-strict, bun nothing was testing
for that.

We should instead assert that --strict is the same as --no-strict,
except in the cases where we've declared that it's not.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index e9008744e3d..951e6d39c2a 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -33,6 +33,8 @@ check_verify_failure () {
 		then
 			test_must_fail git mktag <tag.sig 2>err2 &&
 			test_cmp err err2
+		else
+			git mktag --no-strict <tag.sig
 		fi
 	'
 }
-- 
2.31.1.474.g72d45d12706

