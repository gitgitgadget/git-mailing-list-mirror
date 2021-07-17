Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA8FC636CB
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2BB76115C
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhGQPou (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 11:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbhGQPos (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 11:44:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076B9C06175F
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f190so6013489wmf.4
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3oE4NgXE1czZEdifxCLZiX0mFiAVGTk013xlWr3qtH4=;
        b=rgEgq1S2srsJpM8KZFzIVH4fMjcbUJQs0ibZx0FfKS0lDK4UiuSZHFDXESI5L0ynaZ
         FaIKg/R5zkUJ1uezIZLV3RYT+HUN6ogaOfIkftrt5afAKOMHtF23DDlxZ9Lxt3c6kTsW
         a/OzFT4/rrxpFWX+uvJV/+5ivMOH/q5IaZ+ViU04v4kRSC6vA8V84iLR4uwQy3awsvw5
         0a9kw+RqumtCd8KQiW0+hysjlAt0kYu9aK6jxeSh3POAu1LyruEWFvyIZos2mSbjvArm
         e1P4x+VNFPlTGmIPZ/68KaJTRPE7RjjNnE4z4CMT5HGLdNQ/rN/zZS/rw8+DOaGsKffT
         MYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3oE4NgXE1czZEdifxCLZiX0mFiAVGTk013xlWr3qtH4=;
        b=qSZPhjyoj1biGLMI2xhSEU5APxnRVDfWjw6cldtZEPNsdPm+G3W62/tt6pQ8VPhpzi
         auVybK207GkemrRXk79J2PboAlosmgsnwSR4ARoqs/tBu2pTR4rdekOn33pr4n7W9HC+
         KrMnvCPR4Gf1yTeART/9JYJE9qwgdhDHrEnQWb5YhIiUsY4bDvtJc4CKFYRmfrZAnlcg
         fEY8u6CemEFoCfmottvKD6kSLcCa+EMnkMfQ37fWuznixx/cp4NyBU5ZIvKrFqNbqHZ4
         NxyaDVmlAb6Dk1oCCZmqak5Cu2cI9o0Ww4F5FJvx4I0aqerxn3owFiCx/FoNOyR3WS0U
         GWaw==
X-Gm-Message-State: AOAM532U/hgN/8kBwCT9teHPhTAugQjv+ZiOj9+6aED3G2UELXc2Qjuq
        eCJfxBKQtpQKupUi3FGeNyzLcrMptrA=
X-Google-Smtp-Source: ABdhPJwmmSk10xSqYD1xux60RJo+upqgKkWa6MZb/tzBId7H9jnV2DBORnDXlAfo+aHF6jSvSYq0dQ==
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr17288189wml.67.1626536510582;
        Sat, 17 Jul 2021 08:41:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm14533247wrv.20.2021.07.17.08.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 08:41:50 -0700 (PDT)
Message-Id: <329802382bfa24241c2333bd38284aa77e3eb9f0.1626536508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Jul 2021 15:41:40 +0000
Subject: [PATCH 2/9] t7601: add tests of interactions with multiple merge
 heads and config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There were already code checking that --rebase was incompatible with
a merge of multiple heads.  However, we were sometimes throwing warnings
about lack of specification of rebase vs. merge when given multiple
heads.  Since rebasing is disallowed with multiple merge heads, that
seems like a poor warning to print; we should instead just assume
merging is wanted.

Add a few tests checking multiple merge head behavior.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7601-merge-pull-config.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index b24c98cc1b6..40d8fb95113 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -297,6 +297,26 @@ test_expect_success 'pull.rebase=true takes precedence over --ff' '
 
 # End of precedence rules
 
+test_expect_failure 'Multiple heads does not warn about fast forwarding' '
+	git reset --hard c1 &&
+	git pull . c2 c3 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
+test_expect_success 'Cannot fast-forward with multiple heads' '
+	git reset --hard c0 &&
+	test_must_fail git -c pull.ff=only pull . c1 c2 c3 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
+	test_i18ngrep "Not possible to fast-forward, aborting" err
+'
+
+test_expect_success 'Cannot rebase with multiple heads' '
+	git reset --hard c0 &&
+	test_must_fail git -c pull.rebase=true pull . c1 c2 c3 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err &&
+	test_i18ngrep "Cannot rebase onto multiple branches." err
+'
+
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
 	test -f c0.c &&
-- 
gitgitgadget

