Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77E7C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 19:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB0561167
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 19:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhDBTW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 15:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBTW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 15:22:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571E9C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 12:22:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so4718785wmd.4
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 12:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2oXjbWKvSJ9puvY8zECNLSyBEdOUlANnE1CGJrkrJLA=;
        b=V/+2KeGKn8VKf5G6RnPnvFLz/4bup01SYFfJv0RgxuFW2v4dF2h9xda3DFvjhKSzYv
         biozWfEEWbIor8hyHp03Jc5wjYukF5Z0k6VZa8x5j/r7uCXxti1Koc2Yof/2SKfxmXhL
         DTf8tk43Rz4hC9bsNXmJFK87Lo0C0A/RAdCWN7vG7D32/b6gOEW371jsI7hsFdLA1Nim
         zSqrix3GTqOioTpVH7h8o3oLFndf/Arm+wd+TkwsD6mmxw5w9Mi0wh/CXRF4gZ9Onswd
         Ltv7cNPDqF2JnlZQ6pObBo1NghhA89oY1y/Lcray8+DuFrx6F7GS0ffGbS3BORiVJSKo
         yEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2oXjbWKvSJ9puvY8zECNLSyBEdOUlANnE1CGJrkrJLA=;
        b=EKgzkukrpj+ah+X969PPo8Ef61q1pIALvz4UPMWQsUwdB7lAVARXtlABR85SbOK+Rp
         AH/Wp9kIYOhv78zcntJGww3VJMkOKyu3QsRv+Yxk/FpeJ79DbhEsSd0RqDFOr7SK6otz
         Oli1MMBreGClfpdj4oci+iEbxLbeiA2M/BdAW/v0mlFlGTKgeUskpadd0oiWsTGQx4/V
         sNgqsEe85LDapqwwJlOIBVNaYEMPKlM0PmdCd7yHaq3vychLBJFbYNlB8X5UrMO3HhZY
         VYTENHD64x1+8sTnX6tUF7qKM1HixYmEux1B5hzm/x+5tR+FfyT1lbHVN9JW6yQFrGzW
         Ofow==
X-Gm-Message-State: AOAM532vYAvjG/Yyyc8CnaLTe1gyu/OXB5U3JK0p1FVK0UfK/SYETF9R
        gDQoQnxZo9vUL6Llf+Z+vXqBRddi1Hg=
X-Google-Smtp-Source: ABdhPJznKoAmsSROI6Oz8OWWp18KZTee9kHx7cV91m9uqNy4cqvFrJJPMwgVop/qU7aAtOp5np482Q==
X-Received: by 2002:a1c:20ce:: with SMTP id g197mr13797408wmg.129.1617391376115;
        Fri, 02 Apr 2021 12:22:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9sm11600254wmq.2.2021.04.02.12.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 12:22:55 -0700 (PDT)
Message-Id: <pull.926.git.1617391375445.gitgitgadget@gmail.com>
From:   "gh acct via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Apr 2021 19:22:54 +0000
Subject: [PATCH] gitk: fix selection color not persistent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gh acct <tony@viulogix.com>, ghacct <tony@viulogix.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ghacct <tony@viulogix.com>

Dear git community,
Is it possible please for the gitk selection color setting to be persistent?  Since 2015 this has been working for me.
Thank you for considering!

Signed-off-by: tgomez <tgomez@usa.wtbts.net>
Signed-off-by: ghacct <tony@viulogix.com>
---
    gitk: fix selection color not persistent
    
    Dear git community, Is it possible please for the gitk selection color
    setting to be persistent? Since 2015 this has been working for me. Thank
    you for considering!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-926%2Fghacct%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-926/ghacct/patch-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/926

 gitk-git/gitk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 23d9dd1fe0d0..d255654b02fd 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2412,6 +2412,7 @@ proc makewindow {} {
     text $ctext -background $bgcolor -foreground $fgcolor \
         -state disabled -undo 0 -font textfont \
         -yscrollcommand scrolltext -wrap none \
+        -selectbackground $selectbgcolor -selectforeground $fgcolor \
         -xscrollcommand ".bleft.bottom.sbhorizontal set"
     if {$have_tk85} {
         $ctext conf -tabstyle wordprocessor

base-commit: a65ce7f831aa5fcc596c6d23fcde543d98b39bd7
-- 
gitgitgadget
