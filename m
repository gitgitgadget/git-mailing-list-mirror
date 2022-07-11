Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57A3CCA47B
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 11:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiGKLnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiGKLmx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 07:42:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A0010B3
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 04:37:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c131-20020a1c3589000000b003a2cc290135so3300019wma.2
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 04:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hlrz4df2zil4nrird2oXWnmuvtrM+sp5lwwp4WWgiHM=;
        b=FMBdhj1JcSN8jocVffJwG9HIghRzudIxhtEGD3d53qz7ErSmK25yKJS/bgaAKSEEl5
         fkD9EYm6WLO175gRbwzuSbNUp4SSP6qHHhN5WRgGZbQmpoK1AIPhO8QUbROkR0GwH7Jb
         9CzZ04ZN9bJFkpnBEcy137DIpx0FPyjg7i3n11msFmXujKvBCv62KojbmQsCjGjs9gDQ
         9GAHdAxkfgIh/bxHtVK1YoHHEXaAkS16JZnG/y9pFYqtSqndmqgF1ozWpBzJNS8KJphO
         ixVm1rahWExHEn9h+yofwVob7QTp8IxXqAmGm7pWQHYi5b73AcV5aXd4nDaKtPZlWtk1
         9vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hlrz4df2zil4nrird2oXWnmuvtrM+sp5lwwp4WWgiHM=;
        b=OYuhCwglQ0v5AF6Xbgz5q6bml9VbUqqEHiaOTer+t3xVCZ4+7Wlrfh1VxEpsQ2Hzik
         JbPqlerHLItVIqpXsuKG7dJRWzelJuvs/mRqEOB8/n7CZR7C5JYRJe+uBnSPKxOnMpze
         n7SIw2E6pESGpizJtjjmBINEB3kxB9w253lSmMSbSF8IEvtPK1JRvrnBqLFwXHdgTYO4
         O6M7AYHOK83L2Db3fKAu5k7ESEaI8HsyD1WMTNypBWu59l0utB7hV2AryhyuS3G0OZss
         fPLQXXa7U8IM5R1wJnC7cAiOK2kjZ/0f7UIziRKoEZVgMUfBdMlMkRkjSZk4SCHLOery
         oInw==
X-Gm-Message-State: AJIora+8AdXCjC2DPa0VleJtZv1HMBUQqKcjbwwdfWBfEXbytGJWgNzS
        eRogyU3oaHrTAF0n8HgYdmLOsRM0bTVrTA==
X-Google-Smtp-Source: AGRyM1vlIDk2XhcOi4gxWpE0BBOTo7hvBjrhp2/dcMIlvUq8RIxXU+KulpheQuzecryId1s+5zNoiA==
X-Received: by 2002:a05:600c:2d86:b0:3a2:eac9:ea0d with SMTP id i6-20020a05600c2d8600b003a2eac9ea0dmr509670wmg.105.1657539462272;
        Mon, 11 Jul 2022 04:37:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b17-20020adff911000000b0021d819c8f6dsm5562463wrr.39.2022.07.11.04.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:37:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 3/4] .clang-format: do not enforce a ColumnLimit
Date:   Mon, 11 Jul 2022 13:37:27 +0200
Message-Id: <RFC-patch-3.4-06d4b76a364-20220711T110019Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g189dca38629
In-Reply-To: <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net> <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our Documentation/CodingGuidelines mention that "We try to keep to at
most 80 characters per line", but in reality we have a lot of code
that runs afoul of that rule.

Before & after this change running "make style-all-diff-apply" will
yield:

	579 files changed, 32065 insertions(+), 29818 deletions(-)
	509 files changed, 13042 insertions(+), 12745 deletions(-)

As with the preceding change what this leaves us with an unresolved
question though, should we have some stricter version of "make
style-all" that incorporates "ColumnLimit: 80", or perhaps apply it
only on "make style", but then what if someone modifies code that
happens to e.g. search/replace a line running afoul of the limit?

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 87398d24d4f..5a106d959be 100644
--- a/.clang-format
+++ b/.clang-format
@@ -12,7 +12,7 @@ UseTab: Always
 TabWidth: 8
 IndentWidth: 8
 ContinuationIndentWidth: 8
-ColumnLimit: 80
+ColumnLimit: 0
 
 # C Language specifics
 Language: Cpp
-- 
2.37.0.913.g189dca38629

