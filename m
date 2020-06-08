Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7D0C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 02:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C5F2067B
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 02:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU6TUlMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgFHCCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 22:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgFHCCX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 22:02:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA859C08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 19:02:21 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u13so13805550wml.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 19:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2vPpVs+ztzNupW0W5xhdPsUZBk8j2GFzo5NfaUPWggM=;
        b=aU6TUlMk5+AKGaup0Cj8tsRpn/5tt3UiTSCGP3mfjQJ8ZiYDSuGKKLzeVRJmU+9c6B
         JxDcmaE+nlFQ9G3pAkyuDp9l+/nW0U5W5icUleVcpjnSQwCGOMyZ6M5SJjHHdZmB6zBS
         o13ZusqDy5uC2Crl/lwFiPKThY5b43bJ44qf+B3zryjCSP3mTV2aNF4mv3qTAPnCFxwC
         /G3d6FrQBdYLaMZqT6X45aD1/1uDcctwPqyrui9YpOnAo4B0GyG1Cg6qjsUtsYmsuP4a
         7830qpXKdOQORNLpl9fEO7j9xwOsMLcMwIjTJs6MD9oRXkZUX/o3JiIJmOvIDcXltTmL
         YKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2vPpVs+ztzNupW0W5xhdPsUZBk8j2GFzo5NfaUPWggM=;
        b=OftNzAtlKz9A+yoCi2MrI9sL7yrCqsqiGWewkhQUagaFkdlwdV8M3dvK5tr5jmfHnf
         b5OLpx1vRmr/cIW21FbxzwGPM1Jnkubq+8eYKSOieAV1XgTPvcY62cntx2tKbKk33NPz
         UJfgJ/toIoVZA3vDu7FVkbkf9GpPmWDLfJm/ZNqSDpVgPqia+0mHHsutFbTCjqP5Cf+9
         1TGtzk0Mzj1JxlYpfiezIfz45ltFsghJShYEfLcSv+3e6TGsdRjtvuLMhp/yNiZtJdJM
         ihXVxSdtkCNC9s2j4ydPLeOEiGSRIqr5TOObeCxEkM5L38XD23guHeiDu22ib5YaXuCy
         RlcA==
X-Gm-Message-State: AOAM530WChO7KW0psWINnj6TTO+Gdu7BliPvND3K83ppgETM1giLsEaC
        R1vyNaH+xTmadLJlp42Q2ye5Etsm
X-Google-Smtp-Source: ABdhPJwnu9dS0xQpEvWD3WLvc151rVJIwH3a47RQ/qWiH41yTAholpbr91nd6X549Ikh/J9dLoVdZg==
X-Received: by 2002:a1c:4009:: with SMTP id n9mr14221272wma.104.1591581740233;
        Sun, 07 Jun 2020 19:02:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s72sm20837113wme.35.2020.06.07.19.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 19:02:19 -0700 (PDT)
Message-Id: <pull.652.git.1591581739031.gitgitgadget@gmail.com>
From:   "John Lin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Jun 2020 02:02:18 +0000
Subject: [PATCH] Recommend "git gc --prune=now" instead of "git prune"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Lin <johnlinp@gmail.com>, John Lin <johnlinp@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Lin <johnlinp@gmail.com>

Signed-off-by: John Lin <johnlinp@gmail.com>
---
    Recommend "git gc --prune=now" instead of "git prune"
    
    Signed-off-by: John Lin johnlinp@gmail.com [johnlinp@gmail.com]
    
    Fix according to #642.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-652%2Fjohnlinp%2Ffix-git-gc-warning-message-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-652/johnlinp/fix-git-gc-warning-message-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/652

 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8e0b9cf41b3..74185eac917 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -692,7 +692,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	if (auto_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
-			"run 'git prune' to remove them."));
+			"run 'git gc --prune=now' to remove them."));
 
 	if (!daemonized)
 		unlink(git_path("gc.log"));

base-commit: 20514004ddf1a3528de8933bc32f284e175e1012
-- 
gitgitgadget
