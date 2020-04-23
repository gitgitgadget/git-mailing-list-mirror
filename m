Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35C7C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9F821569
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hpx/PyfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgDWHwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgDWHwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 03:52:50 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C77CC03C1AB
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:52:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e26so5334451wmk.5
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1fFbXTWz1lTlFthX0pbYlhdUdDoYBawAQS90Kjo59qc=;
        b=Hpx/PyfPHPNZG+iNZmWdPxjPYuqZM+Nw1kmSywhz/p3UJiKUn0qFpmQhudwWg8RVW0
         slmEzJSu3wQ6wIqyMgyvec++4dbVm+iQ5pupowYGhCrfRjyg9wfRemC0Hj3tPleMVFf7
         jVJCP4B2TRBXpIwZZn2g95ETuNBrWYDdmxtL7x9GdDYDSinCRtk8fFnJItMhA6BNF682
         f4QHwP2mLaIHPdRFePB3Bt4ve32/KkFxHdgYmboIeTll8qMWDAfnd/rDQFghqAxt+oHW
         1PyPn2FFMMA1Ca7G+1RXIqjkoMgfmDIHTj2WR38vjGhHr84o/8yWnV45xNIKmPY9vSbc
         6jqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1fFbXTWz1lTlFthX0pbYlhdUdDoYBawAQS90Kjo59qc=;
        b=rnidNiuG3H4QBXFN056/rATLhVCB2sK8U1wi5XGU3hebDf+hzsyrgVunA5ItqaH09U
         CJcf2rwVo/t4ytr+vJgP+9/CH54Heovcsn9a/igalesOp7dVkHNBtE9Ny4vGiLa0WwZU
         JY0iMEctspJS4BTr3ebtiFpNx8hHi4hxhd13m7qaXAHkPdTef8H4MHHU62Y3Cwy0X/U/
         8kFi+tKbT/kOoV1Nn2ugLRhOeWGKaNJk58B+dyWrDVzgRcmZEXo5yZ6lvejEF9eDGnA+
         h5VFUTTyQNIqDPXuIVZUgyOZUAlSXKFi7MM9wW4O+27Wl+bjkwBpxvMzcjHpeBsiRVgU
         idPA==
X-Gm-Message-State: AGi0PuZM/0oVdU/dbx/HGRcG3pgxBM0jGadAddxUBiGp/tpjtzG1M5DC
        nN1zY8/Xsj5veM9vLsCn/Y7k1hdO
X-Google-Smtp-Source: APiQypKzg+rB9e/J69ODgXfWW2VEI+x//Ozsi4pBc5Z/k+uzD4Azk09c6T81pED6kA0UsrU0k5jAHw==
X-Received: by 2002:a7b:c417:: with SMTP id k23mr2722836wmi.147.1587628368806;
        Thu, 23 Apr 2020 00:52:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y20sm2490144wra.79.2020.04.23.00.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 00:52:48 -0700 (PDT)
Message-Id: <pull.616.git.1587628367528.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Apr 2020 07:52:47 +0000
Subject: [PATCH] macos: do let the build find the gettext
 headers/libraries/msgfmt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Apparently a recent Homebrew update now installs `gettext` into a
subdirectory under /usr/local/, requiring the CFLAGS/LDFLAGS to list
explicit directories _even_ when asking to force-link the `gettext`
package.

Likewise, the `msgfmt` tool is no longer in the `PATH`.

Let's work around this issue.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Prepare for Homebrew changing the gettext package
    
    In an early Azure Pipelines preview of what is to come, I saw the 
    osx-clang and osx-gcc jobs fail consistently.
    
    This patch tries to prevent that from affecting our CI/PR builds.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-616%2Fdscho%2Fbrew-gettext-update-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-616/dscho/brew-gettext-update-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/616

 config.mak.uname | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 0ab8e009383..540d124d2ef 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -133,8 +133,11 @@ ifeq ($(uname_S),Darwin)
 	HAVE_BSD_SYSCTL = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
-	BASIC_CFLAGS += -I/usr/local/include
-	BASIC_LDFLAGS += -L/usr/local/lib
+	BASIC_CFLAGS += -I/usr/local/include -I/usr/local/opt/gettext/include
+	BASIC_LDFLAGS += -L/usr/local/lib -L/usr/local/opt/gettext/lib
+	ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt && echo y),y)
+		MSGFMT = /usr/local/opt/gettext/bin/msgfmt
+	endif
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease

base-commit: e870325ee8575d5c3d7afe0ba2c9be072c692b65
-- 
gitgitgadget
