Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C24C2BA16
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B18520730
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNDktAOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgDHEGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:06:16 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:35624 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgDHEGO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 00:06:14 -0400
Received: by mail-pl1-f169.google.com with SMTP id c12so2062865plz.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 21:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8IDNYxGTTFzR2xbXg7IeZjoE+09kWxt7+/pFxM/ObS8=;
        b=ZNDktAOK+0XNpFqo20L/hCH9SYPmB2IxwnHLC3y6oLV9nLpDB9vhoUis+nLrdLF+gS
         apLm22ps3rmpTpXqJ63+36gKYoMlgiZUrACWtSwcGi+6Xt2C136eZLh197Bre/v/z3tC
         IbattJNJy93pHXkQYnOnsd1555zHU0/2sgXg4vvEf4Zy7Ax3QeOvMx6cBfhagVY/oRPB
         mTtZ5N4aWe9M4FWyWhDDX8kvcxVCx4pycg9kLCTwz1Q7lPFiNSaZbz6mf0CzVs/ZXiMm
         kxEtqBhWBQSyMrGn2XhADeqqHikPnGrOZUCcfOnT6pBhV9038WPCFd0XxMYUsqe0Iwi+
         DbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8IDNYxGTTFzR2xbXg7IeZjoE+09kWxt7+/pFxM/ObS8=;
        b=YLLSKPN+DovtReRQ9zq1T0ybLmcOjGq64vkLV7WLVu9VDtQLc2bDl8P4wzNu5fncFR
         NXupu2Pa3Vs63YM8IhK2+TXu6+VtZaGeYzdHzJIVVvGEohfgeB14a8nF05VoBmxri/1f
         VOav7dfZpAHaqVC/bvTUZtKas6LEACrNnZu5HT5Ldh18p54hI9676QQoytfQ7BDjdvOC
         xSa5ZVH5C6m1mkIfVWgt8InR9xAUa8UmvgsoEDi4R84ryeSjlBLTjzX6KLJWgONZLia7
         X4S81R5CiYjnSiScS8TzLmAAzjUG6PKVXrTa8ZP4AF6VgpjBSbPZMUm5i5cIjG0Kc9KP
         JkGg==
X-Gm-Message-State: AGi0PuYMYN8+/L5cWY6KikZs44PmpCE8KhkYYN9RACJsEtOqznUi8Dhc
        LLk3hOq3/hPjzLkqUiCi8CxtExsjMKg=
X-Google-Smtp-Source: APiQypJv+J/Yqxd/b2Mw88DH7Tm+Rs4qMwdCMnsESvxXArSEf4EyFHj1oLpKOteAwO6KB52Yup5b/Q==
X-Received: by 2002:a17:902:b707:: with SMTP id d7mr5131508pls.297.1586318773155;
        Tue, 07 Apr 2020 21:06:13 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s9sm2879725pjr.5.2020.04.07.21.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 21:06:12 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 09/12] ci: retire the Azure Pipelines definition
Date:   Wed,  8 Apr 2020 11:05:40 +0700
Message-Id: <92f2623dc7d2da1e78edfbfbe289bd7722abb543.1586309211.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586309211.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586309211.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We have GitHub Actions now. Running the same builds and tests in Azure
Pipelines would be redundant, and a waste of energy.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 README.md           |   1 -
 azure-pipelines.yml | 558 --------------------------------------------
 2 files changed, 559 deletions(-)
 delete mode 100644 azure-pipelines.yml

diff --git a/README.md b/README.md
index e2e00ae249..eb8115e6b0 100644
--- a/README.md
+++ b/README.md
@@ -1,5 +1,4 @@
 [![Build status](https://github.com/git/git/workflows/CI/PR/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
-[![Build Status](https://dev.azure.com/git/git/_apis/build/status/git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=11)
 
 Git - fast, scalable, distributed revision control system
 =========================================================
diff --git a/azure-pipelines.yml b/azure-pipelines.yml
deleted file mode 100644
index 11413f66f8..0000000000
--- a/azure-pipelines.yml
+++ /dev/null
@@ -1,558 +0,0 @@
-variables:
-  Agent.Source.Git.ShallowFetchDepth: 1
-
-jobs:
-- job: windows_build
-  displayName: Windows Build
-  condition: succeeded()
-  pool:
-    vmImage: windows-latest
-  timeoutInMinutes: 240
-  steps:
-  - powershell: |
-      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
-        net use s: \\gitfileshare.file.core.windows.net\test-cache "$GITFILESHAREPWD" /user:AZURE\gitfileshare /persistent:no
-        cmd /c mklink /d "$(Build.SourcesDirectory)\test-cache" S:\
-      }
-    displayName: 'Mount test-cache'
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-  - powershell: |
-      $urlbase = "https://dev.azure.com/git-for-windows/git/_apis/build/builds"
-      $id = ((Invoke-WebRequest -UseBasicParsing "${urlbase}?definitions=22&statusFilter=completed&resultFilter=succeeded&`$top=1").content | ConvertFrom-JSON).value[0].id
-      $downloadUrl = ((Invoke-WebRequest -UseBasicParsing "${urlbase}/$id/artifacts").content | ConvertFrom-JSON).value[1].resource.downloadUrl
-      (New-Object Net.WebClient).DownloadFile($downloadUrl,"git-sdk-64-minimal.zip")
-      Expand-Archive git-sdk-64-minimal.zip -DestinationPath . -Force
-      Remove-Item git-sdk-64-minimal.zip
-
-      # Let Git ignore the SDK and the test-cache
-      "/git-sdk-64-minimal/`n/test-cache/`n" | Out-File -NoNewLine -Encoding ascii -Append "$(Build.SourcesDirectory)\.git\info\exclude"
-    displayName: 'Download git-sdk-64-minimal'
-  - powershell: |
-      & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
-        ci/make-test-artifacts.sh artifacts
-      "@
-      if (!$?) { exit(1) }
-    displayName: Build
-    env:
-      HOME: $(Build.SourcesDirectory)
-      MSYSTEM: MINGW64
-      DEVELOPER: 1
-      NO_PERL: 1
-  - task: PublishPipelineArtifact@0
-    displayName: 'Publish Pipeline Artifact: test artifacts'
-    inputs:
-      artifactName: 'windows-artifacts'
-      targetPath: '$(Build.SourcesDirectory)\artifacts'
-  - task: PublishPipelineArtifact@0
-    displayName: 'Publish Pipeline Artifact: git-sdk-64-minimal'
-    inputs:
-      artifactName: 'git-sdk-64-minimal'
-      targetPath: '$(Build.SourcesDirectory)\git-sdk-64-minimal'
-  - powershell: |
-      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
-        cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
-      }
-    displayName: 'Unmount test-cache'
-    condition: true
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-
-- job: windows_test
-  displayName: Windows Test
-  dependsOn: windows_build
-  condition: succeeded()
-  pool:
-    vmImage: windows-latest
-  timeoutInMinutes: 240
-  strategy:
-    parallel: 10
-  steps:
-  - powershell: |
-      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
-        net use s: \\gitfileshare.file.core.windows.net\test-cache "$GITFILESHAREPWD" /user:AZURE\gitfileshare /persistent:no
-        cmd /c mklink /d "$(Build.SourcesDirectory)\test-cache" S:\
-      }
-    displayName: 'Mount test-cache'
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-  - task: DownloadPipelineArtifact@0
-    displayName: 'Download Pipeline Artifact: test artifacts'
-    inputs:
-      artifactName: 'windows-artifacts'
-      targetPath: '$(Build.SourcesDirectory)'
-  - task: DownloadPipelineArtifact@0
-    displayName: 'Download Pipeline Artifact: git-sdk-64-minimal'
-    inputs:
-      artifactName: 'git-sdk-64-minimal'
-      targetPath: '$(Build.SourcesDirectory)\git-sdk-64-minimal'
-  - powershell: |
-      & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
-        test -f artifacts.tar.gz || {
-          echo No test artifacts found\; skipping >&2
-          exit 0
-        }
-        tar xf artifacts.tar.gz || exit 1
-
-        # Let Git ignore the SDK and the test-cache
-        printf '%s\n' /git-sdk-64-minimal/ /test-cache/ >>.git/info/exclude
-
-        ci/run-test-slice.sh `$SYSTEM_JOBPOSITIONINPHASE `$SYSTEM_TOTALJOBSINPHASE || {
-          ci/print-test-failures.sh
-          exit 1
-        }
-      "@
-      if (!$?) { exit(1) }
-    displayName: 'Test (parallel)'
-    env:
-      HOME: $(Build.SourcesDirectory)
-      MSYSTEM: MINGW64
-      NO_SVN_TESTS: 1
-      GIT_TEST_SKIP_REBASE_P: 1
-  - powershell: |
-      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
-        cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
-      }
-    displayName: 'Unmount test-cache'
-    condition: true
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-  - task: PublishTestResults@2
-    displayName: 'Publish Test Results **/TEST-*.xml'
-    inputs:
-      mergeTestResults: true
-      testRunTitle: 'windows'
-      platform: Windows
-      publishRunAttachments: false
-    condition: succeededOrFailed()
-  - task: PublishBuildArtifacts@1
-    displayName: 'Publish trash directories of failed tests'
-    condition: failed()
-    inputs:
-      PathtoPublish: t/failed-test-artifacts
-      ArtifactName: failed-test-artifacts
-
-- job: vs_build
-  displayName: Visual Studio Build
-  condition: succeeded()
-  pool:
-    vmImage: windows-latest
-  timeoutInMinutes: 240
-  steps:
-  - powershell: |
-      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
-        net use s: \\gitfileshare.file.core.windows.net\test-cache "$GITFILESHAREPWD" /user:AZURE\gitfileshare /persistent:no
-        cmd /c mklink /d "$(Build.SourcesDirectory)\test-cache" S:\
-      }
-    displayName: 'Mount test-cache'
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-  - powershell: |
-      $urlbase = "https://dev.azure.com/git-for-windows/git/_apis/build/builds"
-      $id = ((Invoke-WebRequest -UseBasicParsing "${urlbase}?definitions=22&statusFilter=completed&resultFilter=succeeded&`$top=1").content | ConvertFrom-JSON).value[0].id
-      $downloadUrl = ((Invoke-WebRequest -UseBasicParsing "${urlbase}/$id/artifacts").content | ConvertFrom-JSON).value[1].resource.downloadUrl
-      (New-Object Net.WebClient).DownloadFile($downloadUrl,"git-sdk-64-minimal.zip")
-      Expand-Archive git-sdk-64-minimal.zip -DestinationPath . -Force
-      Remove-Item git-sdk-64-minimal.zip
-
-      # Let Git ignore the SDK and the test-cache
-      "/git-sdk-64-minimal/`n/test-cache/`n" | Out-File -NoNewLine -Encoding ascii -Append "$(Build.SourcesDirectory)\.git\info\exclude"
-    displayName: 'Download git-sdk-64-minimal'
-  - powershell: |
-      & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
-        make NDEBUG=1 DEVELOPER=1 vcxproj
-      "@
-      if (!$?) { exit(1) }
-    displayName: Generate Visual Studio Solution
-    env:
-      HOME: $(Build.SourcesDirectory)
-      MSYSTEM: MINGW64
-      DEVELOPER: 1
-      NO_PERL: 1
-      GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"
-  - powershell: |
-      $urlbase = "https://dev.azure.com/git/git/_apis/build/builds"
-      $id = ((Invoke-WebRequest -UseBasicParsing "${urlbase}?definitions=9&statusFilter=completed&resultFilter=succeeded&`$top=1").content | ConvertFrom-JSON).value[0].id
-      $downloadUrl = ((Invoke-WebRequest -UseBasicParsing "${urlbase}/$id/artifacts").content | ConvertFrom-JSON).value[0].resource.downloadUrl
-      (New-Object Net.WebClient).DownloadFile($downloadUrl, "compat.zip")
-      Expand-Archive compat.zip -DestinationPath . -Force
-      Remove-Item compat.zip
-    displayName: 'Download vcpkg artifacts'
-  - task: MSBuild@1
-    inputs:
-      solution: git.sln
-      platform: x64
-      configuration: Release
-      maximumCpuCount: 4
-      msbuildArguments: /p:PlatformToolset=v142
-  - powershell: |
-      & compat\vcbuild\vcpkg_copy_dlls.bat release
-      if (!$?) { exit(1) }
-      & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
-        mkdir -p artifacts &&
-        eval \"`$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts | grep ^tar)\"
-      "@
-      if (!$?) { exit(1) }
-    displayName: Bundle artifact tar
-    env:
-      HOME: $(Build.SourcesDirectory)
-      MSYSTEM: MINGW64
-      DEVELOPER: 1
-      NO_PERL: 1
-      MSVC: 1
-      VCPKG_ROOT: $(Build.SourcesDirectory)\compat\vcbuild\vcpkg
-  - powershell: |
-      $tag = (Invoke-WebRequest -UseBasicParsing "https://gitforwindows.org/latest-tag.txt").content
-      $version = (Invoke-WebRequest -UseBasicParsing "https://gitforwindows.org/latest-version.txt").content
-      $url = "https://github.com/git-for-windows/git/releases/download/${tag}/PortableGit-${version}-64-bit.7z.exe"
-      (New-Object Net.WebClient).DownloadFile($url,"PortableGit.exe")
-      & .\PortableGit.exe -y -oartifacts\PortableGit
-      # Wait until it is unpacked
-      while (-not @(Remove-Item -ErrorAction SilentlyContinue PortableGit.exe; $?)) { sleep 1 }
-    displayName: Download & extract portable Git
-  - task: PublishPipelineArtifact@0
-    displayName: 'Publish Pipeline Artifact: MSVC test artifacts'
-    inputs:
-      artifactName: 'vs-artifacts'
-      targetPath: '$(Build.SourcesDirectory)\artifacts'
-  - powershell: |
-      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
-        cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
-      }
-    displayName: 'Unmount test-cache'
-    condition: true
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-
-- job: vs_test
-  displayName: Visual Studio Test
-  dependsOn: vs_build
-  condition: succeeded()
-  pool:
-    vmImage: windows-latest
-  timeoutInMinutes: 240
-  strategy:
-    parallel: 10
-  steps:
-  - powershell: |
-      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
-        net use s: \\gitfileshare.file.core.windows.net\test-cache "$GITFILESHAREPWD" /user:AZURE\gitfileshare /persistent:no
-        cmd /c mklink /d "$(Build.SourcesDirectory)\test-cache" S:\
-      }
-    displayName: 'Mount test-cache'
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-  - task: DownloadPipelineArtifact@0
-    displayName: 'Download Pipeline Artifact: VS test artifacts'
-    inputs:
-      artifactName: 'vs-artifacts'
-      targetPath: '$(Build.SourcesDirectory)'
-  - powershell: |
-      & PortableGit\git-cmd.exe --command=usr\bin\bash.exe -lc @"
-        test -f artifacts.tar.gz || {
-          echo No test artifacts found\; skipping >&2
-          exit 0
-        }
-        tar xf artifacts.tar.gz || exit 1
-
-        # Let Git ignore the SDK and the test-cache
-        printf '%s\n' /PortableGit/ /test-cache/ >>.git/info/exclude
-
-        cd t &&
-        PATH=\"`$PWD/helper:`$PATH\" &&
-        test-tool.exe run-command testsuite --jobs=10 -V -x --write-junit-xml \
-                `$(test-tool.exe path-utils slice-tests \
-                        `$SYSTEM_JOBPOSITIONINPHASE `$SYSTEM_TOTALJOBSINPHASE t[0-9]*.sh)
-      "@
-      if (!$?) { exit(1) }
-    displayName: 'Test (parallel)'
-    env:
-      HOME: $(Build.SourcesDirectory)
-      MSYSTEM: MINGW64
-      NO_SVN_TESTS: 1
-      GIT_TEST_SKIP_REBASE_P: 1
-  - powershell: |
-      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
-        cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
-      }
-    displayName: 'Unmount test-cache'
-    condition: true
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-  - task: PublishTestResults@2
-    displayName: 'Publish Test Results **/TEST-*.xml'
-    inputs:
-      mergeTestResults: true
-      testRunTitle: 'vs'
-      platform: Windows
-      publishRunAttachments: false
-    condition: succeededOrFailed()
-  - task: PublishBuildArtifacts@1
-    displayName: 'Publish trash directories of failed tests'
-    condition: failed()
-    inputs:
-      PathtoPublish: t/failed-test-artifacts
-      ArtifactName: failed-vs-test-artifacts
-
-- job: linux_clang
-  displayName: linux-clang
-  condition: succeeded()
-  pool:
-    vmImage: ubuntu-latest
-  steps:
-  - bash: |
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
-
-       sudo apt-get update &&
-       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin &&
-
-       export CC=clang || exit 1
-
-       ci/install-dependencies.sh || exit 1
-       ci/run-build-and-tests.sh || {
-           ci/print-test-failures.sh
-           exit 1
-       }
-
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
-    displayName: 'ci/run-build-and-tests.sh'
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-  - task: PublishTestResults@2
-    displayName: 'Publish Test Results **/TEST-*.xml'
-    inputs:
-      mergeTestResults: true
-      testRunTitle: 'linux-clang'
-      platform: Linux
-      publishRunAttachments: false
-    condition: succeededOrFailed()
-  - task: PublishBuildArtifacts@1
-    displayName: 'Publish trash directories of failed tests'
-    condition: failed()
-    inputs:
-      PathtoPublish: t/failed-test-artifacts
-      ArtifactName: failed-test-artifacts
-
-- job: linux_gcc
-  displayName: linux-gcc
-  condition: succeeded()
-  pool:
-    vmImage: ubuntu-latest
-  steps:
-  - bash: |
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
-
-       sudo add-apt-repository ppa:ubuntu-toolchain-r/test &&
-       sudo apt-get update &&
-       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2 language-pack-is git-svn gcc-8 || exit 1
-
-       ci/install-dependencies.sh || exit 1
-       ci/run-build-and-tests.sh || {
-           ci/print-test-failures.sh
-           exit 1
-       }
-
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
-    displayName: 'ci/run-build-and-tests.sh'
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-  - task: PublishTestResults@2
-    displayName: 'Publish Test Results **/TEST-*.xml'
-    inputs:
-      mergeTestResults: true
-      testRunTitle: 'linux-gcc'
-      platform: Linux
-      publishRunAttachments: false
-    condition: succeededOrFailed()
-  - task: PublishBuildArtifacts@1
-    displayName: 'Publish trash directories of failed tests'
-    condition: failed()
-    inputs:
-      PathtoPublish: t/failed-test-artifacts
-      ArtifactName: failed-test-artifacts
-
-- job: osx_clang
-  displayName: osx-clang
-  condition: succeeded()
-  pool:
-    vmImage: macOS-latest
-  steps:
-  - bash: |
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
-
-       export CC=clang
-
-       ci/install-dependencies.sh || exit 1
-       ci/run-build-and-tests.sh || {
-           ci/print-test-failures.sh
-           exit 1
-       }
-
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || umount "$HOME/test-cache" || exit 1
-    displayName: 'ci/run-build-and-tests.sh'
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-  - task: PublishTestResults@2
-    displayName: 'Publish Test Results **/TEST-*.xml'
-    inputs:
-      mergeTestResults: true
-      testRunTitle: 'osx-clang'
-      platform: macOS
-      publishRunAttachments: false
-    condition: succeededOrFailed()
-  - task: PublishBuildArtifacts@1
-    displayName: 'Publish trash directories of failed tests'
-    condition: failed()
-    inputs:
-      PathtoPublish: t/failed-test-artifacts
-      ArtifactName: failed-test-artifacts
-
-- job: osx_gcc
-  displayName: osx-gcc
-  condition: succeeded()
-  pool:
-    vmImage: macOS-latest
-  steps:
-  - bash: |
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
-
-       ci/install-dependencies.sh || exit 1
-       ci/run-build-and-tests.sh || {
-           ci/print-test-failures.sh
-           exit 1
-       }
-
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || umount "$HOME/test-cache" || exit 1
-    displayName: 'ci/run-build-and-tests.sh'
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-  - task: PublishTestResults@2
-    displayName: 'Publish Test Results **/TEST-*.xml'
-    inputs:
-      mergeTestResults: true
-      testRunTitle: 'osx-gcc'
-      platform: macOS
-      publishRunAttachments: false
-    condition: succeededOrFailed()
-  - task: PublishBuildArtifacts@1
-    displayName: 'Publish trash directories of failed tests'
-    condition: failed()
-    inputs:
-      PathtoPublish: t/failed-test-artifacts
-      ArtifactName: failed-test-artifacts
-
-- job: gettext_poison
-  displayName: GETTEXT_POISON
-  condition: succeeded()
-  pool:
-    vmImage: ubuntu-latest
-  steps:
-  - bash: |
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
-
-       sudo apt-get update &&
-       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev &&
-
-       export jobname=GETTEXT_POISON || exit 1
-
-       ci/run-build-and-tests.sh || {
-           ci/print-test-failures.sh
-           exit 1
-       }
-
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
-    displayName: 'ci/run-build-and-tests.sh'
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-  - task: PublishTestResults@2
-    displayName: 'Publish Test Results **/TEST-*.xml'
-    inputs:
-      mergeTestResults: true
-      testRunTitle: 'gettext-poison'
-      platform: Linux
-      publishRunAttachments: false
-    condition: succeededOrFailed()
-  - task: PublishBuildArtifacts@1
-    displayName: 'Publish trash directories of failed tests'
-    condition: failed()
-    inputs:
-      PathtoPublish: t/failed-test-artifacts
-      ArtifactName: failed-test-artifacts
-
-- job: linux32
-  displayName: Linux32
-  condition: succeeded()
-  pool:
-    vmImage: ubuntu-latest
-  steps:
-  - bash: |
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
-
-       res=0
-       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" jobname=Linux32 bash -lxc ci/run-docker.sh || res=1
-
-       sudo chmod a+r t/out/TEST-*.xml
-       test ! -d t/failed-test-artifacts || sudo chmod a+r t/failed-test-artifacts
-
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || res=1
-       exit $res
-    displayName: 'jobname=Linux32 ci/run-docker.sh'
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-  - task: PublishTestResults@2
-    displayName: 'Publish Test Results **/TEST-*.xml'
-    inputs:
-      mergeTestResults: true
-      testRunTitle: 'linux32'
-      platform: Linux
-      publishRunAttachments: false
-    condition: succeededOrFailed()
-  - task: PublishBuildArtifacts@1
-    displayName: 'Publish trash directories of failed tests'
-    condition: failed()
-    inputs:
-      PathtoPublish: t/failed-test-artifacts
-      ArtifactName: failed-test-artifacts
-
-- job: static_analysis
-  displayName: StaticAnalysis
-  condition: succeeded()
-  pool:
-    vmImage: ubuntu-latest
-  steps:
-  - bash: |
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
-
-       sudo apt-get update &&
-       sudo apt-get install -y coccinelle libcurl4-openssl-dev libssl-dev libexpat-dev gettext &&
-
-       export jobname=StaticAnalysis &&
-
-       ci/run-static-analysis.sh || exit 1
-
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
-    displayName: 'ci/run-static-analysis.sh'
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-
-- job: documentation
-  displayName: Documentation
-  condition: succeeded()
-  pool:
-    vmImage: ubuntu-latest
-  steps:
-  - bash: |
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
-
-       sudo apt-get update &&
-       sudo apt-get install -y asciidoc xmlto asciidoctor docbook-xsl-ns &&
-
-       export ALREADY_HAVE_ASCIIDOCTOR=yes. &&
-       export jobname=Documentation &&
-
-       ci/test-documentation.sh || exit 1
-
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
-    displayName: 'ci/test-documentation.sh'
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-- 
2.26.0.334.g6536db25bb

