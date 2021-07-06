Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C1AC07E9B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC6C61C3F
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhGFSuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhGFSuk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 14:50:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5C4C061760
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 11:48:00 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id w13so188391wmc.3
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lvHwdy9rE59CVyvJ5nfZvFyTIKKxP8gj7MxdUetQth4=;
        b=BH9nKNaRDMb+SYhk60PvWmbXZz9QH9Jv2yye7vEqdwceJ9VjqddmfA/OfABWyakgvf
         NUkc707evk2fRrjHlfbIabnUXVEl4cmbTiqi68M8YsVTEhVllz5hL2+dBF4Xd08ahkb1
         gCj9/2toQ9sl+LBADQ7q1dzrfGeaqloz7TArOFxcCnwzxM0IIZx+skYSeq0NSqzsk/MB
         LeD9lO2FIKeqWOxn9ODjBWZOgBniJWSyXueda1oHwXSE2WL7sni5UDJPXG6v2B1dh0YV
         ag9bfcpW1TjxRNUXSbZxpj0W3O9NFVDO46f16Ju1QqnFQHHV2+tgOs/G6lj2FmyVKlHX
         qMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lvHwdy9rE59CVyvJ5nfZvFyTIKKxP8gj7MxdUetQth4=;
        b=awP0Fgy2j3f3MM1AfumH90o/TmaBffxLIwz5NzwpLrLpQVmMJp29Y/XENB46G4VwgD
         soqHott0SAhAnG5a/HdTHVjhe/Ks22C+ZAO+cVg9Sbfbrpt494yYyEdLWD8Y3eQOO0qn
         AKI5hm1W59b/7QcD9sbuyc4Se+5mbjVZvYqhUyjOWAdCOQ3iQ08Atf5cKGTuqldKLMm4
         ypPWD0GuX1hzOV+XEmIM6EW3VQxjw15+bH2Co/vsN+slRtLFXTy9d7Y+EFcQ+I4C/uJB
         01Hmjt0vpsKYQC/D+3trRQfugLZAokx1RpWwaqRrIAOd00xeZ8WHl5isoRaUyoFx4yfG
         Ji4g==
X-Gm-Message-State: AOAM533tdPDB1si5jxjpRwL3tYGYQ/IWlRnMVVN/Slt70+85BT3UjN16
        Zyl2GAGn1xAtfMk4iTSINncJEHaiKAk=
X-Google-Smtp-Source: ABdhPJx9D3McGXse/Ebrm0spRuenJ02uyUToB26cCO2Nq/5qpnueOGqUO68KF06Wwg8KoivMi67hgw==
X-Received: by 2002:a05:600c:3b0b:: with SMTP id m11mr2378925wms.25.1625597279629;
        Tue, 06 Jul 2021 11:47:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4sm17430661wru.55.2021.07.06.11.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 11:47:59 -0700 (PDT)
Message-Id: <011bbd2ecc8ded798ce47c2c6a2bde64d3f98d2d.1625597277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1042.git.git.1625597277.gitgitgadget@gmail.com>
References: <pull.1042.git.git.1625597277.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 18:47:57 +0000
Subject: [PATCH 2/2] t7509: avoid direct file access for writing
 CHERRY_PICK_HEAD
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t7509-commit-authorship.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7509-commit-authorship.sh b/t/t7509-commit-authorship.sh
index ee6c47416ed..d568593382c 100755
--- a/t/t7509-commit-authorship.sh
+++ b/t/t7509-commit-authorship.sh
@@ -147,7 +147,7 @@ test_expect_success 'commit respects CHERRY_PICK_HEAD and MERGE_MSG' '
 	test_tick &&
 	git commit -am "cherry-pick 1" --author="Cherry <cherry@pick.er>" &&
 	git tag cherry-pick-head &&
-	git rev-parse cherry-pick-head >.git/CHERRY_PICK_HEAD &&
+	git update-ref CHERRY_PICK_HEAD $(git rev-parse cherry-pick-head) &&
 	echo "This is a MERGE_MSG" >.git/MERGE_MSG &&
 	echo "cherry-pick 1b" >>foo &&
 	test_tick &&
@@ -162,7 +162,7 @@ test_expect_success 'commit respects CHERRY_PICK_HEAD and MERGE_MSG' '
 '
 
 test_expect_success '--reset-author with CHERRY_PICK_HEAD' '
-	git rev-parse cherry-pick-head >.git/CHERRY_PICK_HEAD &&
+	git update-ref CHERRY_PICK_HEAD $(git rev-parse cherry-pick-head) &&
 	echo "cherry-pick 2" >>foo &&
 	test_tick &&
 	git commit -am "cherry-pick 2" --reset-author &&
-- 
gitgitgadget
