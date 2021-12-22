Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA810C433FE
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344967AbhLVS4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344943AbhLVS4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:56:41 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC50FC061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:40 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g132so2225343wmg.2
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zeOacPG8foepzoe93AsPL3Dhk+VXAN8S9blbgW2/nvM=;
        b=XUFZwh/YyEx+ltkjDdG9nRFaq8aKNpCbiUEI8SEfHh5oYtB++5D8BWygKuo5FfrnSz
         3XiCQSOc5yBSrLQGopqMyRdVa1PBI3Li2+sA2r59Fq49Gq02AcVU+lfF6zzY7pC9vFxQ
         +JubB4Eaao6kuOoqbO2dLXdIiQ2qkc0YZPLH/Mj1SRChiQEewwYI9gthFBe9bskAcuKa
         SS0fIPFUvwP3fnrnOpdQrgubZIamXeJrnsTnNwE2O73F6WVHUrcMvTLo9ucf7Mj27hIF
         wOA0Ju7IGMEJ7UUO7E/I4UpnwN+qo5cE+zQ5xoRdGijFcEOrCSIdV8mLc0wFN+Ui/eNC
         XuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zeOacPG8foepzoe93AsPL3Dhk+VXAN8S9blbgW2/nvM=;
        b=jC5Kp4ravNRaQsybfepiHFQM85XuPWPCd5XZkQkqnEmcVKKwtg2SHDOlrJ/06GdqDh
         HuzHiHLJl7VbxZo6LNhPogeYACYuBiFFUeVSa3U3K11dO3LuLIs9Yel1WmKIQ3Xrix4Q
         OR9UYew3NBAFjerXELGVBihNFJSBFrFOWYRXTaH5PvCepyp5BCbM6FmRAo9I4RJLVGQY
         6n4/Gq5jt/dhNqVaYpeel4DKMpXbFS/adJs3P46kXZfFaRl/oZSF0or1bbftBVAGMK17
         irxpvEt4K7InkoaZFFI9T/p2BTE87kxWWpY/r0vHMQuGo4ses6z8zeYLOJMabesTBRJy
         BMZA==
X-Gm-Message-State: AOAM5303jCVpy8ZNIDv2c3ZX2PxCuTmOc5ypVW/GwEARvIuyELqG971f
        G+JY1GylSmMg3bW/L+VuBSU5AXADcLo=
X-Google-Smtp-Source: ABdhPJxopQ8987cCMk0JSnO0x9X9OoO2++Z8pJsjSuYZMVqsFC3kolnCO3+FZ4ksR6FQCJ1WDBT+hQ==
X-Received: by 2002:a05:600c:4f48:: with SMTP id m8mr1868766wmq.158.1640199399316;
        Wed, 22 Dec 2021 10:56:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h204sm2748329wmh.33.2021.12.22.10.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:56:38 -0800 (PST)
Message-Id: <8301000e83b2f9758087bb741aeac0e6238ad343.1640199396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:56:23 +0000
Subject: [PATCH v5 03/16] reftable: fix resource leak blocksource.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This would be triggered in the unlikely event of fstat() failing on an opened
file.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/blocksource.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 0044eecd9aa..2605371c28d 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -134,8 +134,10 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
 	}
 
 	err = fstat(fd, &st);
-	if (err < 0)
-		return -1;
+	if (err < 0) {
+		close(fd);
+		return REFTABLE_IO_ERROR;
+	}
 
 	p = reftable_calloc(sizeof(struct file_block_source));
 	p->size = st.st_size;
-- 
gitgitgadget

