Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E25CC388F9
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 00:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C0A2065C
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 00:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8MeiGQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgKIAJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 19:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgKIAJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 19:09:28 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91833C0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 16:09:28 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w24so3912680wmi.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 16:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=JMHAyueKJpXNdH2G08h7dWsCY20h6/Dmwn+di3bCD3k=;
        b=G8MeiGQZcuOx8bAxEZQoF9GCPxl9kMvUDcORFp9XIxr/mqGWk8o4dpcjuW3gBT3QDs
         jklsq4XD9UM6+wmFyjhWVkTfA1rlcdgDzcJSeNOaaRDRmz8h7UQnuNEVvygo76USDKPV
         lTTR4Wc4YLfhAHGbxtD9HdMI5Z9JSN874ZdziATUTN0a6Nu5Xfh8iYMDMIIix4ZD6BX6
         9tia1PsrZIpQMuVf9BaDv5rl/ew2+X8gzZ0jggYVDOQtwm1kJvfXk8+0/gNw12kfNRKN
         65LYoK7pkJDWImMtS2OZdi+WYV7xfpwpMC7TE9aTBTx6JAb403c3OyCrNXWGyAU8DIdG
         gw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JMHAyueKJpXNdH2G08h7dWsCY20h6/Dmwn+di3bCD3k=;
        b=VNZYZvs+tY2vTsAsMxLVn+zINlEOiWhihQAKDJyx/Ep2vVoCsG2oz5WlTCZ5z/UP8d
         nmH8xcGEoEOcZjqzE9QDdyXWa2+3Xv9/6HOOieC6elx37b7Ib1xdLyoZvnHf8R11+ukz
         S1jTU+TDeXogxy2o4oGbWMpQmxHexh8PuItQ0Cq5QrCd9kQA8BKD70eon4atHwxiM/BC
         0M5FB/q5S1rg/bRP49gab8BabnGfT9BEvMY1V8w49MBJBJjO8C91XRJbgiyhWtovU7Pw
         rP2TRvwIjJf8Pu/k9wTc8RqKDhFzF0Mc9DurMSRcP9Wv2145b79RIj8XHvDOlzkrGA5p
         H0Kg==
X-Gm-Message-State: AOAM531E533QKzWVsTFiHaaT4V6meIkp2oh0DrNGZxzpKF04sFw3HD6K
        EwDuNurS/aaEUJ/wbLpndRHCnkjkbcY=
X-Google-Smtp-Source: ABdhPJx5ux5YlqfpWiNeogFcnsHxojC35203GhTDFWdcJF1HkV2kC3Q3EpNohumrj4CoB71xaXcLQA==
X-Received: by 2002:a1c:55c1:: with SMTP id j184mr11695279wmb.180.1604880567187;
        Sun, 08 Nov 2020 16:09:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p10sm11031704wre.2.2020.11.08.16.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 16:09:26 -0800 (PST)
Message-Id: <pull.784.git.1604880565.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Nov 2020 00:09:19 +0000
Subject: [PATCH 0/6] (Mostly whitespace) cleanups in preparation for renaming the default main
 branch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic branch mostly brings whitespace fixes, so that the 
use-main-as-default-branch-name patch series will avoid being flagged by
Git's new check-whitespace GitHub workflow.

Johannes Schindelin (6):
  t1004: insert missing "branch" in a message
  t3406: indent with tabs, not spaces
  t3427: adjust stale comment
  t5400,t5402: consistently indent with tabs, not with spaces
  t5570: remove trailing padding
  t9603: use tabs for indentation

 t/t1004-read-tree-m-u-wf.sh    |   2 +-
 t/t3406-rebase-message.sh      |  16 ++--
 t/t3427-rebase-subtree.sh      |   2 +-
 t/t5400-send-pack.sh           | 153 +++++++++++++++++----------------
 t/t5402-post-merge-hook.sh     |  16 ++--
 t/t5570-git-daemon.sh          |  12 +--
 t/t9603-cvsimport-patchsets.sh |  24 +++---
 7 files changed, 113 insertions(+), 112 deletions(-)


base-commit: 7f7ebe054af6d831b999d6c2241b9227c4e4e08d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-784%2Fdscho%2Fmain-branch-preliminary-cleanups-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-784/dscho/main-branch-preliminary-cleanups-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/784
-- 
gitgitgadget
