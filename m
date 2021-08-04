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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38993C432BE
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F5E60F25
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbhHDF3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 01:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbhHDF3P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 01:29:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7737DC06179B
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 22:29:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so710634wmq.2
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 22:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=utdcGNIg7OWGomU34Va6Uc0Koom386wSPXphMdp0pwg=;
        b=DS5nJb+yDrteMTWSrPBeg21i72zZxXlyo0ZSwN8oW28nNbMuHO/8by33gDRUIbDt0y
         5ngzXeJokWk363EKyX1JL+VRMACeL1oztBPz8423lW1fKqsYfZRu7gnqN1FlYfZsOJOl
         UnN6vhawqYQ5+Ssdw4dffbYFQzpZn1m/1Mxw2IQvAMyPvh13ebjbHrG21Ywgma1E8mtd
         rQ0L7xmH9lVuE66vd4vi9AzNDb7urGJqnIp3TdPGO477/WkkeEezgOsfTIlF5wUXWqyu
         xanG/M0/d8ZR5nr5dnuhc6teFQKrQTbFfPsbwNr1yM3K5/oa+DCWpndh0hXCNQf7H0DB
         YGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=utdcGNIg7OWGomU34Va6Uc0Koom386wSPXphMdp0pwg=;
        b=mtbMohhE1BwCx8zbplT3n2ca309EEyVUrZeBceJY79CXInyDdOa7Ug3mc5nOoUTNbB
         0APAA2E4D9DRm0uXm4yVASjGDC5M70Yuvsuy0przNAA5xwVGP0SgEAHqPzB6MSQgX4Xe
         AaWObloit7nIScrm5HWbtQZ0PGeLRnP+BI4UPfuw1+PbXe2NvuWriOtCfaUJhamwqpGF
         wz0Fo3oynBVXBcgaeLt/WXRGMRK/erhshnZpqXG9/Bprl2o+57t/VxldHhb+3YOhnELI
         5B79rqvqM8aXmsiPve1z/aw70m8P3JOLRwhOUhnIcSTIdj1zK89luci2+hp94V06X08w
         YaXw==
X-Gm-Message-State: AOAM5332vKV97BNnls6b0Ysf6aDLSfzpt2KF9eHmXuurkbWboXgWPkTh
        mySMj3h1DyhmvaTxYZ9+ykbSDz3tM2M=
X-Google-Smtp-Source: ABdhPJxEwcriEF5V7hhzX0dTUA7PON17wZvqYV+zSenFuYXsdBsXKLKuw3JAF1N0+9vebkx58oGpOw==
X-Received: by 2002:a1c:a945:: with SMTP id s66mr25251586wme.67.1628054942076;
        Tue, 03 Aug 2021 22:29:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 19sm4588056wmj.48.2021.08.03.22.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:29:01 -0700 (PDT)
Message-Id: <d1521f98deec5973718dabe5051f55383dbb05b8.1628054936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 05:28:52 +0000
Subject: [PATCH v2 07/10] merge-strategies.txt: fix simple capitalization
 error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index c3edcb07e3e..cecdcfff47a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -529,7 +529,7 @@ The `--rebase-merges` mode is similar in spirit to the deprecated
 where commits can be reordered, inserted and dropped at will.
 +
 It is currently only possible to recreate the merge commits using the
-`recursive` merge strategy; Different merge strategies can be used only via
+`recursive` merge strategy; different merge strategies can be used only via
 explicit `exec git merge -s <strategy> [...]` commands.
 +
 See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
-- 
gitgitgadget

