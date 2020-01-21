Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903A6C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 15:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6205A2253D
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 15:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPVb2z1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgAUPBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:01:22 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:50810 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgAUPBW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 10:01:22 -0500
Received: by mail-wm1-f52.google.com with SMTP id a5so3303531wmb.0
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 07:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6PtBOCH3++iVFMvTvJcZuKbnk4q4ZepImhEvYpP1iwU=;
        b=fPVb2z1esU6Bn4cWJI3e4heMA+6CuutJ+IemFv3SnYFZfElY6McAHD9ss1281SrhHY
         jRvNgFDl18yHfhZkATdsmThTpyyEc2CLzyUd2z7+o+E1Eg6u1VKwh/8BQHoPaxMPYgrF
         fzcJBaGiA/SXJaL72fXCBzwmDlpDM4nzrtzJhQkvgZVpVWN0MOqhOeq3aqpkGeL7b9KI
         9otBX4Lom9QBb+R/S9KXKFb8VFrj8xBjrVh+8IZP710NAobg62v0qXzbwkI+4bBFT+AN
         i2q0l4QEjO6jS3XgXtGvpqw2dLa/JAIOYMqFTDFIQOaJiFAcbzqhh3hj6M82TG/rEaW9
         LhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6PtBOCH3++iVFMvTvJcZuKbnk4q4ZepImhEvYpP1iwU=;
        b=gAi2DTBUjDY9yOy1RM43iTaf3LiYPk4w0XaSO3tIFNvbdCA8k0nbQ1DutPD370u9Xf
         PCrVgfa9LQEir1B4k3HB17oYt9QtVShWJqxgAREatMsFsctVmIHNLFo16Wt+iMd73hXr
         hJSiOKlOiIl8BY7CWCZfjkfjKRjzfdM8eViSTBC08L1m5bj4IGfl0uaphylnPEKTJH2e
         Uk/bvwmr8sGQXVy4AOlEMBzk6mxbHJPOjhcrkIMiUHOaBP3dDMakoifRFI6uL3hBj71L
         zfQMk2854VHrzx6y0LFjbTBERF6gALkZ5YmhblFKEo78O5LUqt4DaSM/Njf4rCsAxtL/
         nW0Q==
X-Gm-Message-State: APjAAAVkl2QDFS33GyN1l6xz9FDohZqzwAhnzyE6jo5UuWyfPuy6LM2h
        Vw8dg5OTRKE9Yz8oVn0qInMdZpiR
X-Google-Smtp-Source: APXvYqwvoPVynwt2iOcet6HBHdgNyi7xTBla1W2oBsvDviWft8Xw3Y/bYeIVQMc2ExixWDiNaQpsDw==
X-Received: by 2002:a1c:1d02:: with SMTP id d2mr4955527wmd.185.1579618879846;
        Tue, 21 Jan 2020 07:01:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t190sm4282197wmt.44.2020.01.21.07.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 07:01:19 -0800 (PST)
Message-Id: <1a4eae1ef5eb9749fe3e64c4c13e52c3269bc4be.1579618877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.523.v2.git.1579618877.gitgitgadget@gmail.com>
References: <pull.523.git.1579263809.gitgitgadget@gmail.com>
        <pull.523.v2.git.1579618877.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Jan 2020 15:01:14 +0000
Subject: [PATCH v2 1/4] t7410: rename to t2405-worktree-submodule.sh
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

This test was added in df56607dff (git-common-dir: make "modules/"
per-working-directory directory, 2014-11-30), back when the 'git worktree' command
did not exist and 'git checkout --to' was used to create supplementary worktrees.

Since this file contains tests for the interaction of 'git worktree' with
submodules, rename it to t2405-worktree-submodule.sh, following the naming scheme for
tests checking the behavior of various commands with submodules.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 ...410-submodule-checkout-to.sh => t2405-worktree-submodule.sh} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename t/{t7410-submodule-checkout-to.sh => t2405-worktree-submodule.sh} (96%)

diff --git a/t/t7410-submodule-checkout-to.sh b/t/t2405-worktree-submodule.sh
similarity index 96%
rename from t/t7410-submodule-checkout-to.sh
rename to t/t2405-worktree-submodule.sh
index f1b492ebc4..f2eee328cc 100755
--- a/t/t7410-submodule-checkout-to.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='Combination of submodules and multiple workdirs'
+test_description='Combination of submodules and multiple worktrees'
 
 . ./test-lib.sh
 
-- 
gitgitgadget

