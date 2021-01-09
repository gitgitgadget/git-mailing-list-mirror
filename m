Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HAS_TINYURL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591AAC433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 23:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1363C22838
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 23:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbhAIX0z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 18:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbhAIX0y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 18:26:54 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC86C061786
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 15:26:14 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 3so11520344wmg.4
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 15:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=hwxpFaH86S7/wn2qVwg5PvI8N88wV5Ph4gqEtbZ9Sac=;
        b=PzY9sBiL79Qc9HTTtuPUJribHIO2gCrTrGjp9aTo6abnlZeplfaaI/4/LQbOvLjgec
         hVvCyPj0QVSNs8CbsLmySc0DsE/3PzZnMD7HqcWnVH14L6ELFKIFBOk+2tWZhDuxBKas
         WMRo+g1N0DxqcuYxohjP9lk29TXKwa4NN4/w2kSYTFAj8EQDTjIolCvTxAITmD5a/G8S
         NrIR7xungx+S2F5cG7wK/1BU6f7WVTG7pjJ81AB0X34xhjH8iOlkeIxnbyuwJsZN044v
         fgMNSQLNTh9TZgcH7QF5lkRDsu4mukgIdWB7H/LnpyljlIgztd3vlYA5SiR98VRCHxJb
         h5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hwxpFaH86S7/wn2qVwg5PvI8N88wV5Ph4gqEtbZ9Sac=;
        b=feskEhN6othrQAwg6FrfY3ujWU8gdVgE7nHnnULnAMVIDkU25M1AlP1/DlMKVPPDMU
         UUY1BFmxUsUYkAYoLq0nOvHj42swV1BeCKfgvZ6KeQtlivO1Nccj44Sk3YaWh5N0oNhF
         yrirezBfLLHzPdH+/bTxqOlPWIPENcLfHylsuauXgCuCcnadpHeunf/LJXzKf53yOTux
         mUf7+GeDwr1JHnNGu00w4kru2iIk4YyualPe9xyoCjWcoFbAKIlyM7W4IxbOkOO49qKz
         Z4LKlOPEmNcaOpOdiHo5/bEIprsfadg/y90AU0hlt/Z2FmKQbzPaWyPOta+YOqxGYPWY
         pcag==
X-Gm-Message-State: AOAM533+HAGJgKq/itM6DtfIioShr9DL15NvagCiCztyFGOGEEm2W9vn
        Y2q5CdiuK1e+S3IbNUhoP3YvO1IHoIc=
X-Google-Smtp-Source: ABdhPJxy2rPDw9ymeRqPmp4bZ+Nk0V2BN9Hxd+iHb+xVifwJGYng6W/KcxxwG92Cr9sHKuSwLeBrkA==
X-Received: by 2002:a7b:c406:: with SMTP id k6mr8709087wmi.90.1610234772890;
        Sat, 09 Jan 2021 15:26:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d191sm16775389wmd.24.2021.01.09.15.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 15:26:12 -0800 (PST)
Message-Id: <pull.944.git.git.1610234771966.gitgitgadget@gmail.com>
From:   "Tobias Pietzsch via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Jan 2021 23:26:11 +0000
Subject: [PATCH] gitk: check main window visibility before waiting for it to
 show
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Tobias Pietzsch <tobias.pietzsch@gmail.com>,
        Tobias Pietzsch <pietzsch@mycroft.speedport.ip>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tobias Pietzsch <pietzsch@mycroft.speedport.ip>

If the main window is already visible when gitk waits for it to
become visible, gitk hangs forever.
This commit adds a check whether the window is already visible.
See https://wiki.tcl-lang.org/page/tkwait+visibility

Signed-off-by: Tobias Pietzsch <pietzsch@mycroft.speedport.ip>
---
    gitk: check main window visibility before waiting for it to show
    
    If the main window is already visible when gitk waits for it to become
    visible, gitk hangs forever.
    
    This commit adds a check whether the window is already visible. See
    https://wiki.tcl-lang.org/page/tkwait+visibility
    
    The symptom of the for-ever waiting is that gitk shows just an empty
    window, like this: https://tinyurl.com/yxr5qlf6 It happens (to me) on
    macOS 11.1 with git-gui installed via homebrew. It doesn't happen on
    macOS 10.14.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-944%2Ftpietzsch%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-944/tpietzsch/master-v1
Pull-Request: https://github.com/git/git/pull/944

 gitk-git/gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 23d9dd1fe0d..cd02b4d50fc 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -12658,7 +12658,7 @@ catch {
     wm iconphoto . -default gitlogo gitlogo32
 }
 # wait for the window to become visible
-tkwait visibility .
+if {![winfo viewable .]} {tkwait visibility .}
 set_window_title
 update
 readrefs

base-commit: 72c4083ddf91b489b7b7b812df67ee8842177d98
-- 
gitgitgadget
