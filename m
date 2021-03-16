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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63E6C43381
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AAC165106
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbhCPQSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbhCPQSI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20920C061763
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id g25so10405260wmh.0
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tIB5hS2d2UvV6EfMdHp8V8iDI/rMwg/YNvvqqAS/v80=;
        b=aNjFqnzCV8vmII8OH4kHHr7YZwJo7+FaMq5XvqpkbLq4V7hDb0jN0vjhEJyITNCQEr
         0Yq+P5qD3Fw9yvEg6K/5vpm8HNGCGz4RkXPq6e3/zHLtlOoZB8c49XGZ3fI2y1DFFoXo
         Sq/HfTiA16K6sTmGeHpffE8LcmcmNQ99649iO9trPXSMuP6gyuNhpNcL+aV3QZTnl+S9
         ye2T/2cHu6+udkGGtxumEO0GUiLtQPhODK7HnTmCfau38KaT0npRj5RdFpH9PX/Gc68a
         EpwLYPZYg+xfgHspNWchCml7dngyhKRrRLYu7GbDZlaOkY47LdyvULVU/cuKTlneMhTY
         i07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tIB5hS2d2UvV6EfMdHp8V8iDI/rMwg/YNvvqqAS/v80=;
        b=aIA2PoB+owVKIMVawqqveDRI/N24nuvLhd/JGj37lTNv+6UqxN7J8pWAdV46ZHTBaf
         1LchXG3eGnAmyt44pfkRS9IF3vwrGKyeQh7L5GO2K7bjH6BdHP/u2RtzI7sJfPNH8I/t
         l3P8jJuwE4cCOZV/Ne8p7qnGWjchuXv8U+UfU9qCnSOcdNmozWTenAvbhWTvd2njl4VR
         FfgCMLLIwK/bwRANvyJCk/ni+q0y8iLxMI+jPTcfIA+PeUp4A9xBJAe4VDpPDBrF0WLi
         MBMDfkUxTL3yAHfnVeVZapby39Mx6k46kjJ0PmJ9Wkfg7tw2sFWUpQ7azCcPc4j1tGzy
         jjgg==
X-Gm-Message-State: AOAM531h+amvfuVdwzCuKOPaSXoYXDCEPaiKqJVyKTb2wesgB0xvYlPr
        pG+vuCJAHtnbVMOi1O/uCbo7fKLAjFyR2w==
X-Google-Smtp-Source: ABdhPJyHGMtrF8MQPkYCqlG27NuWXsJGFKlBS+Vr7oSRqKJviT2Fyaitmpq7MWz4Xz+YnzIiJFI+jA==
X-Received: by 2002:a1c:4e07:: with SMTP id g7mr396807wmh.29.1615911486652;
        Tue, 16 Mar 2021 09:18:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:18:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 15/22] fsck.c: give "FOREACH_MSG_ID" a more specific name
Date:   Tue, 16 Mar 2021 17:17:31 +0100
Message-Id: <20210316161738.30254-16-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the FOREACH_MSG_ID macro to FOREACH_FSCK_MSG_ID in preparation
for moving it over to fsck.h. It's good convention to name macros
in *.h files in such a way as to clearly not clash with any other
names in other files.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fsck.c b/fsck.c
index f4c924ed04..6fbc56e9fa 100644
--- a/fsck.c
+++ b/fsck.c
@@ -22,7 +22,7 @@
 static struct oidset gitmodules_found = OIDSET_INIT;
 static struct oidset gitmodules_done = OIDSET_INIT;
 
-#define FOREACH_MSG_ID(FUNC) \
+#define FOREACH_FSCK_MSG_ID(FUNC) \
 	/* fatal errors */ \
 	FUNC(NUL_IN_HEADER, FATAL) \
 	FUNC(UNTERMINATED_HEADER, FATAL) \
@@ -83,7 +83,7 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 
 #define MSG_ID(id, msg_type) FSCK_MSG_##id,
 enum fsck_msg_id {
-	FOREACH_MSG_ID(MSG_ID)
+	FOREACH_FSCK_MSG_ID(MSG_ID)
 	FSCK_MSG_MAX
 };
 #undef MSG_ID
@@ -96,7 +96,7 @@ static struct {
 	const char *camelcased;
 	enum fsck_msg_type msg_type;
 } msg_id_info[FSCK_MSG_MAX + 1] = {
-	FOREACH_MSG_ID(MSG_ID)
+	FOREACH_FSCK_MSG_ID(MSG_ID)
 	{ NULL, NULL, NULL, -1 }
 };
 #undef MSG_ID
-- 
2.31.0.260.g719c683c1d

