Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19B2C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 11:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1F461441
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 11:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhD2Lkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 07:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbhD2Lkt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 07:40:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EC5C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 04:40:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k14so16640027wrv.5
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 04:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FpEZHpTqIEqdhZLS8Hd8+FsL4SE/BaMoxVMGpMpKoiY=;
        b=GjYcosV+sLmsJAMwCJATWEI5RFLao0DmPW6e0XX4ZZwDxbkIhlZYE0sxVWyZBT0vkb
         1tL9mtS2BTRR/q8WzUaHm1QWDFsDh4rR3I4XT6NqMGVeuBUTOaid054dsEg95oc4AhNb
         5AMorNzYTL0aFfKFGsXAGT22aG8/RTla9e/RB4QpNbgVr1OsfxBHc0dbjMRgvwhFPXOJ
         0C0n7ODaUR5QPCF2RwpHnruM6ZBcEb5acgK1kn4jUuVGQEtwO8J+Y1RVDzs+HCs+PyoO
         NFqQpeoP7k6Bpl+Y5ulSmVQ34D8FKTYc8udyGphgd/ABfCPvDIvRBNyPUXeRcsO4mRc0
         qsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FpEZHpTqIEqdhZLS8Hd8+FsL4SE/BaMoxVMGpMpKoiY=;
        b=Ls3Ejp7GeNSRH3zvaAVuJ6g65ozvGEubmSrPwLctou+hLcQXh/1PshMVEmrbvuCOIF
         eoLJgcJ1BzVSEfoW0lNHc6aMi7Do/dI7EicTt7gaZTRVb+OfTr0n0boK2qaZ/G0lpELZ
         Aw860H60SP4pF53vgS70m01NAaQUFLQ9Y2BeZ0bHJjTFGhGO1HMkomhQ5ZEBhF0wOzlL
         L8MznHjlLRvHGxLKUyKvvnjoEUg4wzeLE/ns+UvlKn2zmRrXaRK8rzL0y4XRNHaRvK+K
         nUo+n7JRcWu+Mz/APQKLTNuIXI/MxvsixvQ/e5SYQzTEigdvxHuzzfnVhfX+u90cTAPx
         /nbw==
X-Gm-Message-State: AOAM531bl7b75DoqUJuwH19pHwah4ywBs4K/8MSvLQNbnVw3Zs/1HkeJ
        XM3f6IA5QToyl3GxVOuPhm2sSlWb7SI=
X-Google-Smtp-Source: ABdhPJyZuPA9WeA8+26jhQJI/zcqdW2pGdCFDJY9AJDQXtNxx3nh6oG+ioXrRra+98l7QZoYv+mDTw==
X-Received: by 2002:a05:6000:1a41:: with SMTP id t1mr29463040wry.265.1619696400074;
        Thu, 29 Apr 2021 04:40:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k15sm4360178wro.87.2021.04.29.04.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 04:39:59 -0700 (PDT)
Message-Id: <pull.1014.git.git.1619696399147.gitgitgadget@gmail.com>
From:   "Bert Huijben via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Apr 2021 11:39:58 +0000
Subject: [PATCH] mergetool: add win32 path translation for diffmerge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bert Huijben <bert@vmoo.com>, Bert Huijben <bert@vmoo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Bert Huijben <bert@vmoo.com>

Use the infrastructure added for finding winmerge to also
automatically find DiffMerge,

Signed-off-by: Bert Huijben <bert@vmoo.com>
---
    mergetool: Add win32 path translation for DiffMerge
    
    Re-use the path translation added for winmerge to automatically find
    SouceGear DiffMerge on Windows.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1014%2Frhuijben%2Ffix%2Fdiffmerge-path-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1014/rhuijben/fix/diffmerge-path-v1
Pull-Request: https://github.com/git/git/pull/1014

 mergetools/diffmerge | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mergetools/diffmerge b/mergetools/diffmerge
index 9b6355b98a71..458ed9a89718 100644
--- a/mergetools/diffmerge
+++ b/mergetools/diffmerge
@@ -16,3 +16,7 @@ merge_cmd () {
 exit_code_trustable () {
 	true
 }
+
+translate_merge_tool_path() {
+	mergetool_find_win32_cmd "sgdm.exe" "SourceGear/Common/DiffMerge"
+}

base-commit: b0c09ab8796fb736efa432b8e817334f3e5ee75a
-- 
gitgitgadget
