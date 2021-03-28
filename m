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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F06C433E5
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0AC06196D
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhC1NQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhC1NQD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:16:03 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289F7C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v4so10126259wrp.13
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PDkAEWNoNstOWJZXf/6DMEiH+jY1mKIph+pAk5g8cdA=;
        b=uZKSQe6T0ZeXjBT0wXc6n97ULRFh9x02dO459U32/Is+Mu8DEdydXthHZ5ClgTLwsL
         RGWdOVMVhDrlRwcgOO+QlwxJLynQZA4OqGBCMRoHPdj1PYnqgXRty3ayAatqzrbGKkIt
         xCxfvLig0vh0iB2K/y63hV34BBFyFT14GzxCJEfBLufiMdH7amJzFrqpc5a7Cj4D9zgU
         7WuJj5PAVp7MKdN6/JoyaCoZFXz+AP+uQ40Sb7xVhA9+FpDXWUMIclgI3IxstxBhY8SB
         BDV0Vfy83GlZ0wxzaohfo4o1JyzqDHX2ActJ+ehvRIJdKcxkg+XHNCvd5jHXSSaxSKrX
         6yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PDkAEWNoNstOWJZXf/6DMEiH+jY1mKIph+pAk5g8cdA=;
        b=ZTxtVY5bpXQRs03PaCwBpscua/+2XsYk53AGxzecQodF2h1nfuaHyxvGAsQemMiaFW
         ery4CQDDduA2hnJO/UPlK8bkYGaZGvW7jZhYf3CSNzCyS2MBEnvYXL1jbr7O5btaBqLT
         guiP0ANl5cJx+kKaEcmefeBzYD2OrWHwYIrKBcUiqc+kkJjljoiEr0FfCaHoyNGvIn6e
         PGpUtlGAtfoQWUWkBTL9OHSDWOtwzQ3EqNHWrprx7JR5a4TGfd/1LVHKINqtECDj8hCa
         cEd6kK1g315yqIt5+Kt+7GNPsF3lhhLdfpvmFG3syrjWJjWWx0mj5qkAHWsoWlZGsU5F
         Y8fQ==
X-Gm-Message-State: AOAM531UBfYoj3PnK36oYV/ZMx4tlH5Cxtf6pZmL/q7fa5i3adEO8oU8
        fMqZUpkM8Qdr39NKR4aQ2u1pJp90koCy6w==
X-Google-Smtp-Source: ABdhPJwT+2HigAjUuWcj1pWE5X7owVAUzFH+tObX5xZ+DV2jInY3eZunb6S6mXpmmoKFGufXj/7N/Q==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr23716090wrm.87.1616937361608;
        Sun, 28 Mar 2021 06:16:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:16:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 09/19] fsck.h: re-order and re-assign "enum fsck_msg_type"
Date:   Sun, 28 Mar 2021 15:15:41 +0200
Message-Id: <patch-09.20-9316b35cd3b-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the values in the "enum fsck_msg_type" from being manually
assigned to using default C enum values.

This means we end up with a FSCK_IGNORE=0, which was previously
defined as "2".

I'm confident that nothing relies on these values, we always compare
them for equality. Let's not omit "0" so it won't be assumed that
we're using these as a boolean somewhere.

This also allows us to re-structure the fields to mark which are
"private" v.s. "public". See the preceding commit for a rationale for
not simply splitting these into two enums, namely that this is used
for both the private and public fsck API.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fsck.h b/fsck.h
index baf37620760..a7e092d3fb4 100644
--- a/fsck.h
+++ b/fsck.h
@@ -4,11 +4,13 @@
 #include "oidset.h"
 
 enum fsck_msg_type {
-	FSCK_INFO  = -2,
-	FSCK_FATAL = -1,
-	FSCK_ERROR = 1,
+	/* for internal use only */
+	FSCK_IGNORE,
+	FSCK_INFO,
+	FSCK_FATAL,
+	/* "public", fed to e.g. error_func callbacks */
+	FSCK_ERROR,
 	FSCK_WARN,
-	FSCK_IGNORE
 };
 
 struct fsck_options;
-- 
2.31.1.445.g087790d4945

