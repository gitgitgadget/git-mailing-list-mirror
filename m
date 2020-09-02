Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6C0C433E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 20:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1392320773
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 20:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0O4FSnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIBUS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIBUSY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 16:18:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761D6C061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 13:18:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c15so682042wrs.11
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=W1cQzLK+UYbD+zb5rWOvS1ynlq4jdRuNkH2dVvcnNzE=;
        b=S0O4FSnNTIPHu6/qBkpib1Ho9KEieaeegghyCU803Yh5u+vXn8Crp0Fy1uFYO9ID59
         KViMeW+AID3/NqsZ+qAvnDNn4TE4dLIXFh3gcjf7eIuOXDNHHVQnv9GWqUu/x0iCJol4
         zcdZAOcbg4otfdlovRZpVNmnm3xILsdk6ZqOJ3wJuQ2tvb3Rk/iBGocLcJ0NmIeQiqVz
         nzhf/GpGNey7kgMTpawWiA2rMrNjiXFN5z12rJueEP1GB2U+hq7LeEZ5+kigqHIpxDFA
         8q8ztSQBSpmlubooUF+wV+mgvXg2t2dk42rSkzGH0Fy3X4vbGHvm/NrrHuLeOGvT+Mom
         4BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W1cQzLK+UYbD+zb5rWOvS1ynlq4jdRuNkH2dVvcnNzE=;
        b=E3EaQjDG2kiTLTeS5ZRJaDyB3hFSOy3f5xJxnLrHlmo678oSF4HaUuGkzKJiQs2kJd
         cIVghG2V4nvBwIFLQ9l7I/9ZEavwRFN8l1o+KnZUKwg3cYNHqpgfQhsB0HfZHGDn1wFK
         IDdeXt70bxYqK/J5y+zWSJlOaR6h6FA+3AEgAtRSaLPyOCGQ0fGnlzhvQVta3CPFLId7
         KVgFW367T7Nm0fiFUowt5HKizo2PJ8trQx/yMKQWYDAz9H5oVAK90rxnD+/6D0lmSGzH
         3l5ZZ8RjOKaOv6pPc+UjR0LoIDAEEAZYAuTLlpKwEJaIC2WB3DR6+SLEDOgfuTdTDtjZ
         Jt7A==
X-Gm-Message-State: AOAM531WD2+JquTs8u7+orHQSmIn2OjsWhNPj98CMtrSTm4IoTaOmYoW
        UYPsPtyZWE1ElxZoWo2wrdcWpr3bBK4=
X-Google-Smtp-Source: ABdhPJw61l1w9tdaGe6MG7xuTc11WwAjeQsfPLWnifz545AZ+vHM5oidQ+fVyD30xoG/SxjK33IV9Q==
X-Received: by 2002:a5d:60c6:: with SMTP id x6mr8738207wrt.26.1599077901960;
        Wed, 02 Sep 2020 13:18:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5sm1148144wrb.28.2020.09.02.13.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 13:18:21 -0700 (PDT)
Message-Id: <pull.721.git.1599077900986.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Sep 2020 20:18:20 +0000
Subject: [PATCH] vcbuild: fix batch file name in README
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    vcbuild: Fix batch file name in README
    
    Signed-off-by: Orgad Shaneh orgads@gmail.com [orgads@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-721%2Forgads%2Fvcbuild-readme-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-721/orgads/vcbuild-readme-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/721

 compat/vcbuild/README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index 42292e7c09..51fb083dbb 100644
--- a/compat/vcbuild/README
+++ b/compat/vcbuild/README
@@ -26,8 +26,8 @@ The Steps to Build Git with VS2015 or VS2017 from the command line.
    Use ONE of the following forms which should match how you want to
    compile git.exe.
 
-   $ ./compat/vcbuild/vcpkg_copy_packages.bat debug
-   $ ./compat/vcbuild/vcpkg_copy_packages.bat release
+   $ ./compat/vcbuild/vcpkg_copy_dlls.bat debug
+   $ ./compat/vcbuild/vcpkg_copy_dlls.bat release
 
 3. Build git using MSVC from an SDK bash window using one of the
    following commands:

base-commit: e19713638985533ce461db072b49112da5bd2042
-- 
gitgitgadget
