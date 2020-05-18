Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC837C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 14:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE07A20674
	for <git@archiver.kernel.org>; Mon, 18 May 2020 14:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF8FN5UT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgEROwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 10:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEROwp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 10:52:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8738FC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 07:52:45 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z1so5084210pfn.3
        for <git@vger.kernel.org>; Mon, 18 May 2020 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7+2UwgTStkO5mxtUBMYSYX8+fiQe+6DUC6EIlmnG15E=;
        b=SF8FN5UTKOTUxdiZ5WKPMknj1U/rkn6Q5vUaeXs8VkFy2QdM4CcexxCKRNHEiWoD+j
         HgakuxSxEc1x9QTMy7LvPWHzHrONDNzHNrKD4MG/c+uen4hrSnVClLU+ZUc2Z25PK4pg
         LOuVXD76R53+Kn3SpuY/bfHI0bugjxaxzBqTG1JCZzPRV4UH9crKf9IAWJQ8iNRodKFO
         VZsryvcChsoKTq52lJR+1yk8aMU4t9THH46/zniAzJBnFDYXGax7/K6i2XlnAoOdR9Tt
         rIdkg81besqoEntvB+t5CHEEs+lAqI4JeXz5iucS0MFPCMVBLdbHIiBCTAfQRavRgCz6
         nQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7+2UwgTStkO5mxtUBMYSYX8+fiQe+6DUC6EIlmnG15E=;
        b=HZPW2G4nGhCtgCEQO07am2HAXa0XGAJ8JOqCu9C+xuRumt3HZ+1n5BIh2AF9SjikuV
         ZIDsHPTQQimGMpjzRHlY2k1I+ew2Z1cbw6Bnr7X766BrEfeftR+l88tc7GUsRWG1CfDg
         VCFVQJbMSdWPXEnXUGmdPm9hOOkwOb5Z17wJm/exxi4GDIp4mwPtbytOzSo2sroWfC5Z
         2LNbM93m3u7ZcFaUAkMJ8awQS95hsrRmohIjXKPEC3VQa+pr4LuPEH2LW0lBsh+wrg++
         zJ5CIl1+0SCs40/YUZ28bDXSJUI2+MPXpb9DHrL/2N0dh5PZz9FHehxz6NUjuBBlF6NP
         bwjQ==
X-Gm-Message-State: AOAM531LaBH9WGUr8uadZ6yVqtdwwppCOqJjXeB6NLpmgBBtID1MYmAE
        x/pXOwI9D8BQJQyMI1dnwcItdGNM
X-Google-Smtp-Source: ABdhPJzFR27nYfZSFLB4YYCy1wc8J/FW0fYjUCzDSe/y+Jf4PxovFP91/N/oM0BtFYO4mIonpA/qtQ==
X-Received: by 2002:aa7:8d93:: with SMTP id i19mr17686832pfr.112.1589813564753;
        Mon, 18 May 2020 07:52:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id 19sm2530532pgh.21.2020.05.18.07.52.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 07:52:44 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] ci/config: correct instruction for CI preferences
Date:   Mon, 18 May 2020 21:52:34 +0700
Message-Id: <20200518145234.20424-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.672.g232c24e857
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From e76eec3554 (ci: allow per-branch config for GitHub Actions,
2020-05-07), we started to allow contributors decide which branch
they want to build with GitHub Actions
by checking for a file named "ci/config/allow-ref".

In order to assist those contributors,
we provided a sample in "ci/config/allow-refs.sample",
and instructed them to drop the ".sample",
then commit that file to their repository.

We've misspelt the filename in that change.
Let's fix the spelling.

While we're at it, also instruct our contributors introduce that new
file to Git before commit, in case of they've never told Git before.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

This is a merge from:
<20200508180047.GD637136@coredump.intra.peff.net>
<20200509012304.GB2111@danh.dev>

It's slipped over the crack.

Hence, it may need Peff's SoB.
Cc: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>

 ci/config/{allow-refs.sample => allow-ref.sample} | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
 rename ci/config/{allow-refs.sample => allow-ref.sample} (91%)

diff --git a/ci/config/allow-refs.sample b/ci/config/allow-ref.sample
similarity index 91%
rename from ci/config/allow-refs.sample
rename to ci/config/allow-ref.sample
index f157f1945a..af0e076f8a 100755
--- a/ci/config/allow-refs.sample
+++ b/ci/config/allow-ref.sample
@@ -7,8 +7,9 @@
 # your repository:
 #
 #   git checkout -b ci-config
-#   cp allow-refs.sample allow-refs
-#   $EDITOR allow-refs
+#   cp allow-ref.sample allow-ref
+#   $EDITOR allow-ref
+#   git add allow-ref
 #   git commit -am "implement my ci preferences"
 #   git push
 #
-- 
2.26.2.672.g232c24e857

