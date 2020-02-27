Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB9C11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 13:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EC021556
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 13:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFhnl3St"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgB0NXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:23:19 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33502 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgB0NXT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 08:23:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id r21so3287217edq.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 05:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PvLcEFm2U2RuVDEvvMsqbjR3vL2S4N4DlN6D8Aeo/gU=;
        b=eFhnl3St8hFpXG5+9KOvw/gxP7PjT4F8a8POohPS2TtIuijTHWb0H0H+xznfrT5BCK
         kyBpoH9/QgBAJ6jaYR+jdY6fQ28pM6IjjUUZLtn9Zkf5JQpHFCdgjxSHOh4uceESaTQE
         NmpNCoQ+yqoto+OoplVYvvMTWg6togAtVJB4YqTUQT1Y7omR95/yMKNScOFev2tWjaRW
         p49OzOipiT0hQkgUsdZ3JcIS/9Yc5jsruGTEApTSEmCCSXdZpTi781eeSfXLim2mJNAT
         ANujc+0pH3uQ37TnUy+B3rYBm2vqybjSL3gwpLVMZm8oI5ZJGjuDgAjUhTCxfW1I7dgK
         3xVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PvLcEFm2U2RuVDEvvMsqbjR3vL2S4N4DlN6D8Aeo/gU=;
        b=tBsJ/3Lkp1ZoGABtCwyAudg7cehZcu5De443Kl53d7O1TlIDH7bIxkzwwZeudEEGIl
         hv7vZhLAzKRjMO6tPxpeAKEZdh2DjQa3vaxxRuqYu7jZbZc8pn8wLgBLBa/I804FMCrY
         5X5LDSCTxt9Ll82R7/uWOcU5PtLmuUD8+oaKxBwUifaYzjcDSK+BGZzdF5O0emoF2qh3
         r8NMOzXRTtqVJVdIUVcmgGfisYl1bxZ5GEjPB/DICRC6Dad5/hHzqHxxpBGbLhm4fynG
         D6Uw5BPuI9Dh/Br3TU3q9OTpRBDsYeSg33yzfPLuwN/9Fi1+V9hTbxrt30OtcQyrRsGM
         WiIQ==
X-Gm-Message-State: APjAAAVmzk4mXPZinguMpTOR3XvXIRSXkrpo69KSyVy56XMpcKj4Tj4N
        gfMWp0unZ9LYQBOt8xxrQDwmsMIP
X-Google-Smtp-Source: APXvYqwP1L0HznR5D/7rl+fACPIUuljKAqmXENzkn9mbnLCyMS1jMv/wo1rpu5wm+vWMbXBPxHLB6g==
X-Received: by 2002:a50:d849:: with SMTP id v9mr4314568edj.105.1582809797280;
        Thu, 27 Feb 2020 05:23:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b17sm355045edt.5.2020.02.27.05.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:23:16 -0800 (PST)
Message-Id: <6d2f8e7e70e19df7e1693b13e64121eabee038f2.1582809793.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.714.v2.git.git.1582809793.gitgitgadget@gmail.com>
References: <pull.714.git.git.1582747775.gitgitgadget@gmail.com>
        <pull.714.v2.git.git.1582809793.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 13:23:13 +0000
Subject: [PATCH v2 3/3] Azure Pipeline: switch to the latest agent pools
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ed Maste <emaste@freebsd.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It would seem that at least the `vs2015-win2012r2` pool (which we use
via its old name, `Hosted`) is about to be phased out. Let's switch
before that.

While at it, use the newer pool names as suggested at
https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops#use-a-microsoft-hosted-agent

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 azure-pipelines.yml | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index af2a5ea4845..675c3a43c9c 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -5,7 +5,8 @@ jobs:
 - job: windows_build
   displayName: Windows Build
   condition: succeeded()
-  pool: Hosted
+  pool:
+    vmImage: windows-latest
   timeoutInMinutes: 240
   steps:
   - powershell: |
@@ -61,7 +62,8 @@ jobs:
   displayName: Windows Test
   dependsOn: windows_build
   condition: succeeded()
-  pool: Hosted
+  pool:
+    vmImage: windows-latest
   timeoutInMinutes: 240
   strategy:
     parallel: 10
@@ -133,7 +135,8 @@ jobs:
 - job: vs_build
   displayName: Visual Studio Build
   condition: succeeded()
-  pool: Hosted VS2017
+  pool:
+    vmImage: windows-latest
   timeoutInMinutes: 240
   steps:
   - powershell: |
@@ -181,6 +184,7 @@ jobs:
       platform: x64
       configuration: Release
       maximumCpuCount: 4
+      msbuildArguments: /p:PlatformToolset=v142
   - powershell: |
       & compat\vcbuild\vcpkg_copy_dlls.bat release
       if (!$?) { exit(1) }
@@ -224,7 +228,8 @@ jobs:
   displayName: Visual Studio Test
   dependsOn: vs_build
   condition: succeeded()
-  pool: Hosted
+  pool:
+    vmImage: windows-latest
   timeoutInMinutes: 240
   strategy:
     parallel: 10
@@ -292,7 +297,8 @@ jobs:
 - job: linux_clang
   displayName: linux-clang
   condition: succeeded()
-  pool: Hosted Ubuntu 1604
+  pool:
+    vmImage: ubuntu-latest
   steps:
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
@@ -330,7 +336,8 @@ jobs:
 - job: linux_gcc
   displayName: linux-gcc
   condition: succeeded()
-  pool: Hosted Ubuntu 1604
+  pool:
+    vmImage: ubuntu-latest
   steps:
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
@@ -367,7 +374,8 @@ jobs:
 - job: osx_clang
   displayName: osx-clang
   condition: succeeded()
-  pool: Hosted macOS
+  pool:
+    vmImage: macOS-latest
   steps:
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
@@ -402,7 +410,8 @@ jobs:
 - job: osx_gcc
   displayName: osx-gcc
   condition: succeeded()
-  pool: Hosted macOS
+  pool:
+    vmImage: macOS-latest
   steps:
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
@@ -435,7 +444,8 @@ jobs:
 - job: gettext_poison
   displayName: GETTEXT_POISON
   condition: succeeded()
-  pool: Hosted Ubuntu 1604
+  pool:
+    vmImage: ubuntu-latest
   steps:
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
@@ -472,7 +482,8 @@ jobs:
 - job: linux32
   displayName: Linux32
   condition: succeeded()
-  pool: Hosted Ubuntu 1604
+  pool:
+    vmImage: ubuntu-latest
   steps:
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
@@ -506,7 +517,8 @@ jobs:
 - job: static_analysis
   displayName: StaticAnalysis
   condition: succeeded()
-  pool: Hosted Ubuntu 1604
+  pool:
+    vmImage: ubuntu-latest
   steps:
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
@@ -526,7 +538,8 @@ jobs:
 - job: documentation
   displayName: Documentation
   condition: succeeded()
-  pool: Hosted Ubuntu 1604
+  pool:
+    vmImage: ubuntu-latest
   steps:
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
-- 
gitgitgadget
