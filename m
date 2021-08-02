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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C49C4320A
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E21761106
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhHBQyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhHBQxy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:53:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57EFC0613D5
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 09:53:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l18so22233461wrv.5
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KpLmbp75Sux4pwv8U+t0kPz7J/1D/BqHpfoLRrm2OjA=;
        b=qB0i/r4EGgUo33HWajScwvfSdq67CMHqW/vp4Ew5qoWVyKGp13TU0cnYjL8rE74bIT
         K8YtPRv3ykHapTSCqQqtRAecbACv5aII17vsvyMhvJ2GJ5hT0BKtMTVI7mQ9/ea9RwS0
         on7Zhcbkp0zigMs5lvXQDkkoMFSKgz8kpaokZX8Dr2RpgN0srGDpvChGy+Y/qXU61dhR
         Ic21tGt6DM/bsJCzQnD/NzdwgHwMWAYu9eUjil26EpFl577IEGPazFHDNzS8/AAcnBBy
         /WQvNPPYp7doOasU1Y5xI2Bo3Gm8jd03ijnkcExT1K167qXzI4pUdd5NAQH10dOQBmn9
         N5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KpLmbp75Sux4pwv8U+t0kPz7J/1D/BqHpfoLRrm2OjA=;
        b=qdFQ1+REkxJRaJxM1wnGkZoN0/cbFvRpWxrCAb4kyLzyo7uJM2VRJFDrIEpCZwYn8n
         Bkh6FIZSy8+dKzVdwOOEoanhIhHK79PVf6ub0MuReD2I6S8sqsU910wUMDOPGjr4/rV1
         mZHd9n0HvxPQAwVFmqlUbXq8tlRCFH3NzUQkMnVdWonBDqoufkeEkSUsoWRutAd+TKjn
         WOzOLJZLUiPOfmEhk6laYLhfpBLOgnZRVkUmHiLHHkwL55RKFmER6obTFsD91EAR19Zm
         XPNkplK3oxwFcrgjm9wiCMAfRTgt+VipsNREK5gKBOQeQDQvefPq25NsrB2p4fEDTmuX
         vqMA==
X-Gm-Message-State: AOAM5315DXFmyHNVSGB5SWJuHu8E44o75wuRUUvpPhLtGQRoByNBn7hN
        8ObrXWRAEiqstpg21vpvpOUcLh9tetQ=
X-Google-Smtp-Source: ABdhPJxQ/qQ8VD/BIAXWCcUp4QieljHAnLlrRQLSogeS1acVxwZ1qT5atHfGJQBG4afDAF3TGGD6BQ==
X-Received: by 2002:adf:dd07:: with SMTP id a7mr18138909wrm.377.1627923223558;
        Mon, 02 Aug 2021 09:53:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z20sm10425230wmi.36.2021.08.02.09.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 09:53:43 -0700 (PDT)
Message-Id: <1326e99a1fd1704e44b4f2d1a5731fe9da4d0a8a.1627923216.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
References: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 16:53:34 +0000
Subject: [PATCH v3 09/11] t7064: use update-ref -d to remove upstream branch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The previous code tested this by writing $ZERO_OID explicitly in the packed-refs
file. This is a type of corruption that doesn't reflect realistic use-cases. In
addition, even the ref-store test-tool refuses to write invalid OIDs.
(update-ref interprets $ZERO_OID is deleting the ref).

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t7064-wtstatus-pv2.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 4613882caff..eeb0534163d 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -373,10 +373,7 @@ test_expect_success 'verify upstream fields in branch header' '
 
 		## Test upstream-gone case. Fake this by pointing
 		## origin/initial-branch at a non-existing commit.
-		OLD=$(git rev-parse origin/initial-branch) &&
-		NEW=$ZERO_OID &&
-		mv .git/packed-refs .git/old-packed-refs &&
-		sed "s/$OLD/$NEW/g" <.git/old-packed-refs >.git/packed-refs &&
+		git update-ref -d refs/remotes/origin/initial-branch &&
 
 		HUF=$(git rev-parse HEAD) &&
 
-- 
gitgitgadget

