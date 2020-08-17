Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B34C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 10:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D037206FA
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 10:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9bZLRnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHQKhG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgHQKhF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 06:37:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E963C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 03:37:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 9so12803040wmj.5
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 03:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Fe21cMeOMTWg3IrYNhesMdwVbnbmU4vzNaX/Zcfp/Nc=;
        b=s9bZLRnNk41OW5lwfLCPb1OI1AavaIDWEDBFYI9ZYessourBIe+kQTflMp5Op7MLaE
         xevw/AQFaaOXsrNQHEMCy9URYUyUNAz6+t/IOIAPOeNjArOu2FoIiea/JXBRgBDgdcpy
         fBTLORWRxhDpWozVWDQkfjSEzkGU2HP2xnXGI0bQgPH87a9+oaSogseBzcDW0wZrcYWa
         syvPWO2EYMR2bAuyj9wdNuXmdhgSM1wi6iDj83wOXIYlv2H5NF3seouFD1dV3FSSbgmM
         ZHiFTUO2svX0hkTjNeWJFWD8MkuH/r+p3xKMeXBGuc9HqfQiZwkNxJVlc83tzqAuQPvN
         q4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fe21cMeOMTWg3IrYNhesMdwVbnbmU4vzNaX/Zcfp/Nc=;
        b=SkKfYcwzms2G0MO8j2JWPOj1vVsF53UOLgAaoDgkOv1Mzg1KpiBPmBXvY3tsx5h9Az
         JXOg9tM0IkZUR3coNS76QyNXGeUUdQ8K4RYFerzh0iF3se67gFl3seulZhi9DoonLhe8
         WhTLxb7x+u83HdNMfsjr0WEtoRLCA6Vet2CbQiT8AhMlsoy/LJal2PwQFPohQnGVlQOF
         xkHjb0rdAGWpKzl+LDowdJ8Og7fL/A84ACqw8nTj/eXnRA0rop1jydmhwEyvv2+FohGF
         xMNhIzMvo10eJMW/VajbPDfX0JFX8an2wZfA5vTEn1RsXRHcYi31/t/Co9I44q/5Sq07
         PhIA==
X-Gm-Message-State: AOAM533k/mWhvNxkYoDXxJXCWWiBc/sNCi6VwPBMuUrQbBty4HKm2b3g
        f6X4r3ccR8jHv6QTUSb5Emp44dwm5vQ=
X-Google-Smtp-Source: ABdhPJys0xm1OtWff18GGIrPMdxHhSZhENW3YGIV1Hhln5T8jWPn+WQ+Z1vJ0ngo2z/HsDAHTkaDag==
X-Received: by 2002:a1c:2d8d:: with SMTP id t135mr13546890wmt.76.1597660623757;
        Mon, 17 Aug 2020 03:37:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 69sm31320507wmb.8.2020.08.17.03.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 03:37:03 -0700 (PDT)
Message-Id: <pull.704.git.1597660622615.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 10:37:02 +0000
Subject: [PATCH] mingw: improve performance of mingw_unlink()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Update mingw_unlink() to first try to delete the file with existing
permissions before trying to force it.

Windows throws an error when trying to delete a read-only file.  The
mingw_unlink() compatibility wrapper always tries to _wchmod(666) the
file before calling _wunlink() to avoid that error.  However, since
most files in the worktree are already writable, this is usually
wasted effort.

Update mingw_unlink() to just call DeleteFileW() directly and if that
succeeds return.  If that fails, fall back into the existing code path
to update the permissions and use _wunlink() to get the existing
error code mapping.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Windows: improve checkout performance with large numbers of files
    
    Jeff Hostetler contributed this patch to Git for Windows a while ago
    after measuring ~15% improvement
    [https://github.com/microsoft/git/pull/264#issuecomment-617216583] with
    a very, very large worktree:
    
    > I ran a series of timing tests on the Office repo on my Z440 desktop.
    > This was a full enlistment at HEAD. I ran git sparse-checkout disable 
    > to populate the entire worktree and then git sparse-checkout init
    > --cone to delete everything except the files at root. I repeated that
    > sequence 3 times.
    >
    > Each init needed to delete about 2.1M files.
    >
    > git sparse-checkout init
    >
    > old: 636.1s, 638.3s, 637.2s, 637.2s new: 535.9s, 544.8s, 533.3s,
    > 538.0s
    >
    > In this example, run time was decreased by 15%.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-704%2Fdscho%2Funlink-perf-gfw-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-704/dscho/unlink-perf-gfw-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/704

 compat/mingw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 4454b3e67b..a00f331230 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -290,6 +290,9 @@ int mingw_unlink(const char *pathname)
 	if (xutftowcs_path(wpathname, pathname) < 0)
 		return -1;
 
+	if (DeleteFileW(wpathname))
+		return 0;
+
 	/* read-only files cannot be removed */
 	_wchmod(wpathname, 0666);
 	while ((ret = _wunlink(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {

base-commit: 878e727637ec5815ccb3301eb994a54df95b21b8
-- 
gitgitgadget
