Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305CBC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4A061166
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhEFQiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 12:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbhEFQiE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 12:38:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8E8C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 09:37:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a4so6314239wrr.2
        for <git@vger.kernel.org>; Thu, 06 May 2021 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ip0f4ZTBrpSNWw1cioQ4IJ1JU2pR2kXNcZDPw39IZIM=;
        b=WRLqWvsZj+zFINEMwDGnC7PtAOmxbtS+M4L82Lkls9Hjp2Ntc6ZUqqV3niispsXJRm
         uUsIYFpB64SkyodCDAFA2HuDja40w6Qa+4fsROxBMdt3MX6/weOuW61FzAC4Kp627oDH
         uucpOqe5zxK/w6EnpvbGmLFfC7kWD1Pc5wB6RtnSfT7ExTOVu3koVGtEVs0+xttzaxZh
         uU4fM2h6gQNWwa2TkwS4vH/6PR5njVklBXfh0SzS11m0pdPcQQWuc3X8Nn15AUTRcSMc
         bdEXSlVKRPoYZv1thOVwfBsURJ3oO5ispgAyROu85VGUsAcNS8exStaeSacrjc+n+q9k
         GS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ip0f4ZTBrpSNWw1cioQ4IJ1JU2pR2kXNcZDPw39IZIM=;
        b=K9g8LLGp/Fc7iCW8hL8Zmq5n4JwgZAUwB1NXrxVs3/bLHEst3TlqYmq2VfKOetVRMZ
         txJeAoG0+siDI632XtsVcb2UJcucWN2HK1FZWQk2ftyXvyqNrR76zsylsgQLAQENXNFw
         /3Y6ifKLjGRFbmHITu3z9Ws0S1vfMLbccquD8lx6A3U1Y36hk6F4e8kwscWAturi46OV
         tW+npT1B5i3yC8dFoJ7Wcu9RPYWG93sYYV8VBAGHqA0/fRPJ1QagMWDSBRQ/SLqzxebz
         sOCctD6OkHhTk9+0k9eOwPAgVNvvaRFpZWowQTKnSpyckXEWU09IwiUGQtUHknklHB2P
         HzFQ==
X-Gm-Message-State: AOAM532H7/bBsb9Q/0vIAwSlwVIHrvjfyhAdjHiodkQRZTRjPnVCAE+u
        EnvJ6DqqOUxTjYfVf4p+es4SPWDtzfg=
X-Google-Smtp-Source: ABdhPJwevIzyRMXetryY1MzQtmZov7cL7pkOZHHqvBd2CKul5f5RQFSGBVuM13wEshsjjCFQyC1reA==
X-Received: by 2002:a5d:64cf:: with SMTP id f15mr6217255wri.327.1620319024996;
        Thu, 06 May 2021 09:37:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t7sm4979089wrw.60.2021.05.06.09.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 09:37:04 -0700 (PDT)
Message-Id: <pull.1019.git.git.1620319023972.gitgitgadget@gmail.com>
From:   "Lars Berntzon via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 May 2021 16:37:03 +0000
Subject: [PATCH] doc: attempt to clarify a blurry sentence.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Lars Berntzon <lars.berntzon@cecilia-data.se>,
        Lars Berntzon <lars.berntzon@external.atlascopco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Berntzon <lars.berntzon@external.atlascopco.com>

Signed-off-by: Lars Berntzon <lars.berntzon@cecilia-data.se>
---
    Attempt to clarify a blurry sentence.
    
    Signed-off-by: Lars Berntzon lars.berntzon@cecilia-data.se

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1019%2Flboclboc%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1019/lboclboc/master-v1
Pull-Request: https://github.com/git/git/pull/1019

 Documentation/git-push.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index a953c7c38790..bbb30c52395e 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -66,10 +66,10 @@ it can be any arbitrary "SHA-1 expression", such as `master~4` or
 The <dst> tells which ref on the remote side is updated with this
 push. Arbitrary expressions cannot be used here, an actual ref must
 be named.
-If `git push [<repository>]` without any `<refspec>` argument is set to
-update some ref at the destination with `<src>` with
-`remote.<repository>.push` configuration variable, `:<dst>` part can
-be omitted--such a push will update a ref that `<src>` normally updates
+If `git push [<repository>]` without any `<refspec>` argument then
+git will update the remote ref as defined by `remote.<repository>.push` configuration
+and it will be updated from HEAD.
+`:<dst>` part can be omitted--such a push will update a ref that `<src>` normally updates
 without any `<refspec>` on the command line.  Otherwise, missing
 `:<dst>` means to update the same ref as the `<src>`.
 +

base-commit: 7e391989789db82983665667013a46eabc6fc570
-- 
gitgitgadget
