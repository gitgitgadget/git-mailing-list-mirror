Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF5DC4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 08:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiLUIX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 03:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiLUIXT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 03:23:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17519FED
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 00:23:17 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y8so1124532wrl.13
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 00:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c4i8gYPXUCc9Mo2qCHSrdKU2PgpHmstAFjCHBHaCDc4=;
        b=Rsb68Mbt1/hk/Dk8rupw4Njv5GRERH3d4Jsb3Fw0xi4HBrmXjiMWL2v3GDdr++1KWj
         mFt9upecKRdmL/9gsabsIXiK0FFLe0kLThKPddMgnnVZ/ImNTEdi/ZngBz77DFS9BkP+
         zdHS6UUwPsMzBjj50dsnGLDOa3Jpu2fntVKIo6E+OvTsHJjosmCaGFzPqY6KNlLBvt0Y
         +kjCdzNYGZ5I9j5VwzrWFnwhR0FhALvBdLbVpGhepzA0U5TFn0Z+ss6H3nXEb0WG+f+w
         PwkuJewWOgJe/M4dVFCfRIOJw7X0xvkeYY4xlXx8eOp5fHfnyjIahZ1ctqbdXmvAvOkb
         d09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4i8gYPXUCc9Mo2qCHSrdKU2PgpHmstAFjCHBHaCDc4=;
        b=QlYOAEEDaHKUwk8bgG9kHCLJhyavee/XGrSmHYVYj3wlFyozKi34ZYLEQpdC/OzaJq
         hPXTue4tLVuvKIXI6gYNyN3KFXbzA10iw/IZyoirSwdYKnyvZ5hzP2LLfqk7BFN/1pgQ
         ZkwQ7vQkykzl4YVDt7j24rjZ96b9yu99FYm0Eq31fiv/rE3LDRDrmCl7O7jWpjXhNgH2
         tq30IgizCW+ySDEbYzR2S1b+J2sWt3ashCI9Kug8i4XKLDIfzGimGQRg5jSCMwP3p1L4
         Qu4HtC5sbRPT9EtPsZOaT7GyA2a9woIFVmWgeWAyuxzMgOyY7ayvY6+zo0fz065b9uvf
         3xog==
X-Gm-Message-State: AFqh2kqf3Ix5iiyxsTZ0Lq54nYL9eqnm8+Ol95Qd61rKx6d9TAUjwwFe
        QNoZLSeO1f8bu3TTfskxNVEfiVmKc+U=
X-Google-Smtp-Source: AMrXdXteabtakQ4l8JX8OUc34XgD2HH0BXVn6qry+7pKI7QDVX8ecYPFwu7px/xUZ7cslPIVItz7PA==
X-Received: by 2002:adf:e383:0:b0:255:300d:79c7 with SMTP id e3-20020adfe383000000b00255300d79c7mr623213wrm.18.1671610995449;
        Wed, 21 Dec 2022 00:23:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cc6-20020a5d5c06000000b002428c4fb16asm14729395wrb.10.2022.12.21.00.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 00:23:15 -0800 (PST)
Message-Id: <pull.1447.git.1671610994375.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Dec 2022 08:23:14 +0000
Subject: [PATCH] Documentation: clarify that cache forgets credentials if the
 system restarts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Make it obvious to readers unfamiliar with Unix sockets.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    Documentation: clarify that cache forgets credentials if the system
    restarts
    
    Make it obvious to readers unfamiliar with Unix sockets.
    
    Signed-off-by: M Hickford mirth.hickford@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1447%2Fhickford%2Fpatch-2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1447/hickford/patch-2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1447

 Documentation/git-credential-cache.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 432e159d952..83fb4d4c4dc 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -16,7 +16,8 @@ DESCRIPTION
 
 This command caches credentials in memory for use by future Git
 programs. The stored credentials never touch the disk, and are forgotten
-after a configurable timeout.  The cache is accessible over a Unix
+after a configurable timeout.  Credentials are forgotten sooner if you
+log out or the system restarts.  The cache is accessible over a Unix
 domain socket, restricted to the current user by filesystem permissions.
 
 You probably don't want to invoke this command directly; it is meant to

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
