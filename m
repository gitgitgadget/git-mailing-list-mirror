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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2896C433E0
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 10:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F8564F1F
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 10:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhCSKRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 06:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhCSKRI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 06:17:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2EBC06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 03:17:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v11so8513416wro.7
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 03:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=NDIZvM3R8Opy9DJoemCYb+2QDMzkZHSMPkm+Bjzi1vA=;
        b=SU0i18HaDML5f9Rung+mLFDSBiPOuUjNrtRPlKKra2CAJGIukFUKTfJI06tHFrwFAG
         mLinaJ9tR8PEtH4ePvwr505YEU3vwTG3qrBs2igDxYmV+F8lfhIP6F4c1Z4sZm4y2Mxd
         ++DNVFApYH7XvCe9y5Fd/xP3TvKLJD63PlKLlsJV8ZclJU82PcEHw+/qKqSL/tO1k9Wy
         zKYfnGc5v9E/uV+nFr6uaeOCaNa0SaOGQTB5+UjdWe4aMn7PzaV50Mzu1x0rCUPH10hS
         yUyqqzMRf7r0J44JqkDmkWn2DLIv4G9TlQ5kFQdppDKrcODZV4m1hzqovXXbz+MGrhsg
         wk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NDIZvM3R8Opy9DJoemCYb+2QDMzkZHSMPkm+Bjzi1vA=;
        b=UaCHrQOwfvrVCzIvcVGCvTJpLkc3LvibuLCXvs8xDs8AcGzImMm/iN0T4C34/I0LJl
         31i6FkV5FMJ0u/UuVyUaoNLN+q4hPwZLsJeSOP0nIAHO1Bcdsv3UACV6WrPdCs6jLMtz
         LM/+sBOa5Tb7SjRgXlSqfMhT4JegghR46jWM83x0clSe0LTMNVexaxizyV2FaH9plCII
         JiX/3WFDnBt6HzAagbLz9EylfQZqfykWuhtlY87Vu344SD4g9YhhxnX48nFldY+C/Mii
         h50TEXvzlRhHvXX9/Axz8H5aw0xXdymSFxzaFxTsbO4lKqcSfo8HtETXU6LMV7skcvj3
         /QXw==
X-Gm-Message-State: AOAM532S1aIjugfyLDaaVfKDtoBwL0yMtd49ANiOG4bYuvB+r2l1Ma0B
        BbNeljoanSLOB3iAthnwChN0k4ebK+E=
X-Google-Smtp-Source: ABdhPJzTBGRXGOybwSjgNxFUQCGoy2dGvgBdTdDzt2FX1Aw55pwPcEpXc6b8sw/jAEk8lacmIyPcJA==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr3805271wrn.352.1616149022491;
        Fri, 19 Mar 2021 03:17:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8sm7147997wrx.43.2021.03.19.03.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 03:17:02 -0700 (PDT)
Message-Id: <pull.984.git.git.1616149021392.gitgitgadget@gmail.com>
From:   "Nils Leif Fischer via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 10:17:01 +0000
Subject: [PATCH] Fix a typo in git-maintenance documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nils Leif Fischer <hello@nilsleiffischer.de>,
        Nils Leif Fischer <nils.fischer@aei.mpg.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nils Leif Fischer <nils.fischer@aei.mpg.de>

Signed-off-by: Nils Leif Fischer <nils.fischer@aei.mpg.de>
---
    Fix typo in git-maintenance documentation
    
    Just a small typo.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-984%2Fnilsleiffischer%2Fnilsleiffischer-patch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-984/nilsleiffischer/nilsleiffischer-patch-1-v1
Pull-Request: https://github.com/git/git/pull/984

 Documentation/git-maintenance.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 80ddd33ceba0..8023504dc65d 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -106,7 +106,7 @@ any object transfer.
 
 gc::
 	Clean up unnecessary files and optimize the local repository. "GC"
-	stands for "garbage collection," but this task performs many
+	stands for "garbage collection", but this task performs many
 	smaller tasks. This task can be expensive for large repositories,
 	as it repacks all Git objects into a single pack-file. It can also
 	be disruptive in some situations, as it deletes stale data. See

base-commit: a5828ae6b52137b913b978e16cd2334482eb4c1f
-- 
gitgitgadget
