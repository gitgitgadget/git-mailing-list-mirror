Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0903BC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B50611C0
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFGMlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhFGMle (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:41:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99FFC061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 05:39:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p13-20020a05600c358db029019f44afc845so10048697wmq.3
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=RyR0WKM/eT+qeVOsdb/5FKIz86Dt5/HHrwYKOWwPRk4=;
        b=Nnv8iiinUwgjLmskEV/w1s0qrnJbts3wTJ3jAMnnLt/+xCOBnac9UkZwxo6TCiH7b/
         GrBFFgX37F2ukaQ2/G4rsm3aYm/5eyQty5IjBhd998aQkgly6LAz0Fmo2aM+9pFm8k+N
         ZIEzgsEqspYMnYiOrtLUmsS126f7jAoPrIEyP4Oo/DN1y/53S9O/cjkxFtgI1ZpT9Jfc
         5ktRvGgtGt0gHy4Wjw++lYdLwQXiRyTSjJQRfWejV78oqNUDs/YPZvLRp63UdL5inlww
         I/HtRqpd/q+fSFDG0+XVCwkfKaofpK7bOVNu9qjnB1z+Oe7Fm4HjzIO5bBI+Hf9gUtxC
         lrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RyR0WKM/eT+qeVOsdb/5FKIz86Dt5/HHrwYKOWwPRk4=;
        b=XwvtG71z4GRqabKI5F8zzniXPRTtLQcoPY7bM4isJkawjorm3pv1yJJVmBjHLvKjXO
         0o8oZ2FGlNmwaAA/7sIVEp5RtQMVAa7h5AQ+bkjQnuj/HvgD6zCsXwVsaOqT9keW/BgO
         xrQS11/YTLrkjnhoZkshDC9IhP73NcQu9jNSRJQzRMVyuMhQ0mHpWmeJwi2fbcsO2pNn
         hj/vsBuQ3hjLN4WaIGZbZUGz0yVSMQhirItPAcZWHfsXn87KkDiO8dINLSctAh4g4r6T
         WlFoKloTndLgxLKpoL87pSsBZrNpJtIpmRrBPT61Ja/U3DYgGnW4nte3vSHYa2NTTpm1
         Su7w==
X-Gm-Message-State: AOAM532z5xAq6U1CGPVLA03OyunrEqLC2H8tHLOVPNh01Ioi5P5GKmhP
        r/1vuct/g1zMnkuTRgPYyKjJWZ+mr9k=
X-Google-Smtp-Source: ABdhPJxyYD9cCFNzEM9JbLJOI2qixZD0s89BjhWwx+IJUjM1jfHUPF9nEl+x+bTYBLslApmb3odUTQ==
X-Received: by 2002:a7b:c8ce:: with SMTP id f14mr16582096wml.88.1623069571379;
        Mon, 07 Jun 2021 05:39:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm17487146wrc.29.2021.06.07.05.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:39:31 -0700 (PDT)
Message-Id: <pull.974.git.1623069570553.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 12:39:29 +0000
Subject: [PATCH] remote: initialize values that might not be set
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

I noticed during an unrelated test with Valgrind that these variables
might be left un-set by stat_tracking_info() in some cases. Initialize
them so that a later branch upon their value is consistent.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    remote: initialize values that might not be set
    
    A very minor fixup.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-974%2Fderrickstolee%2Fremote-uninitialized-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-974/derrickstolee/remote-uninitialized-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/974

 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index c3f85c17ca7c..a116392fb057 100644
--- a/remote.c
+++ b/remote.c
@@ -2101,7 +2101,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			 enum ahead_behind_flags abf)
 {
-	int ours, theirs, sti;
+	int ours = 0, theirs = 0, sti = 0;
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;

base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
-- 
gitgitgadget
