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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC15C432BE
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BAF60EFD
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhHDXvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbhHDXvP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:51:15 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8191C061799
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:51:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d8so4086775wrm.4
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0X3X3WPy+yQb/OlJR5qOAmxfHRf3YdMtmDwBSDyfl0s=;
        b=pcpBJyuS7cNdBw78Um3KWFJ9oGqdcxN2FdA5wSeiFEVBA2O0Kwnt6afCD2pFPIB9/u
         RiW/aKg6BgOVUFR9qvhEsf/3Q2VVK2Xa+EV6TsN9G/yvBHe0fBe0EVIDMdEvNwDVeams
         rM43rOwYHjicdOXUl56vqve9uHuBCLnsGxHBemgel2LSS4woSOdM8CnchTVDyOMTAyfC
         lRNkxxHoHTmZ4ord3LsMcl8gha1OaH/g/I9i4NEyP0p9RbXgEzQolkg5PtOqfxCD+8Si
         WZKcidzTOAidOiUWV2WRY6aizFDstZlVZFwnsYMTQ30zgUaMRWxQlzZ+/WorFTJCcZzy
         mIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0X3X3WPy+yQb/OlJR5qOAmxfHRf3YdMtmDwBSDyfl0s=;
        b=dIeW14JYYyS5V7m/2ifOtk5L6emigXEiIv0Blr29B+g8eY7ReU4OfOo7NCpZq9HufG
         qipVake3arFD/sdBceV0MoDW9h6lWe/Kx1SHnt6deAAl/NNMRkLEFrDkeCkl8Vt/A873
         5CQPQd5wQR6QjWpkS2/f4a9EKGH20e7AqHzJI+D8boyjYO5+5lx1xxIccdJDzQueEkYN
         pAQwNgNgUbfchFVYQL9UPFxK5jnNqbzr9JW+PYJaOSogGfFDhI2/nR0vthN/Qu33YQzB
         HFExN86XeU5tZdAzD7j9M7z6Rt9ltVIc4JzrhqNA6ZtKbrpw1ZU/K8IomgcTkROdNOCn
         ct4Q==
X-Gm-Message-State: AOAM532ALOe0ApCqFJX8Iv6BBbB9z6K1wnAmyml9qMpg+JrCWofjOP32
        iMCd0uTkITvhgnEWr3mHEOax1tz4p9c=
X-Google-Smtp-Source: ABdhPJzb0YJV03aVs9FyzWZHVifbOEqeGjSzQqgua3ZSPG5GjF7L4FXHy0JeAfBpe6IHGEhhk+Pbfg==
X-Received: by 2002:a05:6000:1011:: with SMTP id a17mr1783930wrx.97.1628121059307;
        Wed, 04 Aug 2021 16:50:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11sm4881875wrs.81.2021.08.04.16.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:50:59 -0700 (PDT)
Message-Id: <1d144757a2e2f84428a7c2330ca5f9339072b524.1628121054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
References: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
        <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 23:50:49 +0000
Subject: [PATCH v3 05/10] merge-strategies.txt: do not imply using copy
 detection is desired
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Stating that the recursive strategy "currently cannot make use of
detected copies" implies that this is a technical shortcoming of the
current algorithm.  I disagree with that.  I don't see how copies could
possibly be used in a sane fashion in a merge algorithm -- would we
propagate changes in one file on one side of history to each copy of
that file when merging?  That makes no sense to me.  I cannot think of
anything else that would make sense either.  Change the wording to
simply state that we ignore any copies.

Acked-by: Derrick Stolee <dstolee@microsoft.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-strategies.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index f100fad1e43..e2988124581 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -16,9 +16,9 @@ recursive::
 	causing mismerges by tests done on actual merge commits
 	taken from Linux 2.6 kernel development history.
 	Additionally this can detect and handle merges involving
-	renames, but currently cannot make use of detected
-	copies.  This is the default merge strategy when pulling
-	or merging one branch.
+	renames.  It does not make use of detected copies.  This
+	is the default merge strategy when pulling or merging one
+	branch.
 +
 The 'recursive' strategy can take the following options:
 
-- 
gitgitgadget

