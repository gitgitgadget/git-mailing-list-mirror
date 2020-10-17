Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948A1C433DF
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 21:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A7CB207BC
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 21:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLbg7ukH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439457AbgJQVEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 17:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439459AbgJQVEm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 17:04:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593B7C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 14:04:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i1so7253303wro.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 14:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Djf3TWO3UFcf03qpN2acJDVn06wf04grB536pabMBck=;
        b=gLbg7ukHTuMqqjWgkrOdGnxS+tGe/waLXCXf7TmrhfOroajh6wySHqUUlU0U/D3jQH
         WrJwDIbXeBZyirH4mVTcjfFzWzWo/XWOQngVXU9W9N87/dscn4LGAFch2T9dfOOPXa/M
         F/W35mdMuDbS540cgnzlt0rShXko9vap+F5s3Rif+bzps+4hKrxmChdlVQMnT2cB22gn
         n0Tue2nUHhC6TWWTsq297mAgE+TfvZxpSiO0T3C+4rtjB5RAxZqfDxfStwYs4vNgJ/yK
         YjSvuwDlihyLveLZjND2JJ4YVS2QM4H5CC8BWVAj9D9QvoXW63xiBb/6cr7HvhRkChKs
         5Fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Djf3TWO3UFcf03qpN2acJDVn06wf04grB536pabMBck=;
        b=m5f/puTmE1u4ZlmEZBW9GoobRL2x1g56wHF0MZkDGvaxK8p2BRaJxHIfFMi73KMDN9
         A9aa4ce87YNcFpnk/DbI+70rB+1kcrj2JARA4zTRBtcTo6trSeSXTLJcBHojmqzQtrwq
         ypfXKBkNBIASuCI8UIS7dGEs9K+3w2WEz/fglzqoj+9m3L2+2VGwLzBhGk5r9SelYYFr
         cM5CkPp31EhaGebdv/muWpUj8fNv6/UDWjCbF4plXJ6eAEnfcgixGP1ADAjX31bu5XN4
         G9oobHce18UyQFV4e4/5yWs7lnPI9SiGeebzWzSf+QDjkZamV9zO4MiaCVU2Y4G9yKUj
         icTA==
X-Gm-Message-State: AOAM532VKgsCvZ2r73mUnsFECvf3AlmGCUFQsk++vq3dbZrPPOInyUnC
        Kr+XU7FbjT8jXim5bPR/U3NZ3vJ1Bfg=
X-Google-Smtp-Source: ABdhPJwVcjWDzvb2qIkJqBBSf+HucU9Z4Hz/pyVkFj5iDZKd/TA4lkNZTOSF/HoVqscNPQ7ceoosBw==
X-Received: by 2002:adf:a31a:: with SMTP id c26mr11157507wrb.378.1602968680998;
        Sat, 17 Oct 2020 14:04:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3sm8723213wmb.46.2020.10.17.14.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 14:04:40 -0700 (PDT)
Message-Id: <6482e372bc0dca08efe9686b5b9e06a27a1d7a70.1602968677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.git.1602968677.gitgitgadget@gmail.com>
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Oct 2020 21:04:35 +0000
Subject: [PATCH 3/4] t/perf/p7519-fsmonitor.sh: warm cache on first git status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

The first git status would be inflated due to warming of
filesystem cache. This makes the results comparable.

Before
Test                                                             this tree
--------------------------------------------------------------------------------
7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         2.52(1.59+1.56)
7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.18(0.12+0.06)
7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   1.36(0.73+0.62)
7519.7: status (fsmonitor=)                                      0.69(0.52+0.90)
7519.8: status -uno (fsmonitor=)                                 0.37(0.28+0.81)
7519.9: status -uall (fsmonitor=)                                1.53(0.93+1.32)

After
Test                                                             this tree
--------------------------------------------------------------------------------
7519.2: status (fsmonitor=.git/hooks/fsmonitor-watchman)         0.39(0.33+0.06)
7519.3: status -uno (fsmonitor=.git/hooks/fsmonitor-watchman)    0.17(0.13+0.05)
7519.4: status -uall (fsmonitor=.git/hooks/fsmonitor-watchman)   1.34(0.77+0.56)
7519.7: status (fsmonitor=)                                      0.70(0.53+0.90)
7519.8: status -uno (fsmonitor=)                                 0.37(0.32+0.78)
7519.9: status -uall (fsmonitor=)                                1.55(1.01+1.25)

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index def7ecdbc7..9313d4a51d 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -114,7 +114,8 @@ test_expect_success "setup for fsmonitor" '
 	fi &&
 
 	git config core.fsmonitor "$INTEGRATION_SCRIPT" &&
-	git update-index --fsmonitor
+	git update-index --fsmonitor &&
+	git status  # Warm caches
 '
 
 if test -n "$GIT_PERF_7519_DROP_CACHE"; then
-- 
gitgitgadget

