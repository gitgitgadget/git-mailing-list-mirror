Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_ABUSE_SURBL,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60903C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 12:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2084A20848
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 12:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2j3b9ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbgCaMsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:48:42 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37672 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730437AbgCaMsl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 08:48:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id de14so24943698edb.4
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 05:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xyl2ynFGN3rKZ2EcK7Et6iQ00fcHKzLguMJ3Ichev/w=;
        b=k2j3b9ll7zHMysKuk5v4sLap0WctyonCmC0bfEBAj3EklrToyJdTcRiO8+2IUU6Dkq
         lLMEebta35ZqeYTWDp0R8mKiSkVOZqZ5csJ4LZDnMRdqOn2VlgXYz5OSzjDoTLnO9LmJ
         YJm4+Lmrw+sJLl0sdGO3AQx4HVAsr+90W3rz2vtQ7+ErN0uSGebBOqayKh57ad3UXzxv
         oL3d6sZZk0cml5/G511F2o7hEfDBdaRJ0onpYq18t75SWfkL935YeJBsgXKp0HBJoXeF
         yroI+kMHce3pqjd35N9R0ovHG57r2usU543CYTLnnBH1ws8NyiIKGksua86xXR5tdZ+c
         O3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xyl2ynFGN3rKZ2EcK7Et6iQ00fcHKzLguMJ3Ichev/w=;
        b=rBYOciFXxroTOfBVtqF4HEjraeKg+Kk9zyRQkzBwkK/VC9fKJkAlbMG6V0QOvqaYOw
         EpOlOj228B/lSvKH2Wd6DvqYX63HFMHlzDfQoxTlNyJxj6hrB7amm/Thqg//rnRSe/Yr
         O75zLyShIvzlIjbpMcEUUYoUI5e47yBRY7PxLEJPAbqo9GycZO8RUlwUblsdNFXqPpqZ
         ty27qM8cGHs7JXJc8T12+cvSKlx/0ktGs32aY2wNM+efckckWt8SBZzxlsLl/Cx9dTW4
         JxSi6xq1e8uVOIUpKhlW+SqLE4D5SVtnmbpxEmvkWJUQzHhRhDTqGnVkp1H0Oo9YJA3f
         yE4A==
X-Gm-Message-State: ANhLgQ1jLFlEF94RVfgnI++Wd5JdVimsm+yDaCiGmBlhwEYY6BuRcEDX
        Ut/IYYa0Brm/9XFynOUg72qv48NV
X-Google-Smtp-Source: ADFU+vvYH5sNyiLnJjfzAhLuCRxWGoCQnfseuf10I2zkpoyi4UcGcc2fxM/YrpK91veG8RPVa3ObNA==
X-Received: by 2002:aa7:c559:: with SMTP id s25mr3733515edr.2.1585658918281;
        Tue, 31 Mar 2020 05:48:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b72sm2268708edf.95.2020.03.31.05.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:48:37 -0700 (PDT)
Message-Id: <1610b296064a8757dc159435fa49b1c59b6f05d7.1585658913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Mar 2020 12:48:33 +0000
Subject: [PATCH 5/5] ci: retire the Azure Pipelines definition
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We have GitHub Actions now. Running the same builds and tests in Azure
Pipelines would be redundant, and a waste of energy.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 README.md           |   1 -
 azure-pipelines.yml | 558 --------------------------------------------
 2 files changed, 559 deletions(-)
 delete mode 100644 azure-pipelines.yml

diff --git a/README.md b/README.md
index e2e00ae2495..eb8115e6b04 100644
--- a/README.md
+++ b/README.md
@@ -1,5 +1,4 @@
 [![Build status](https://github.com/git/git/workflows/CI/PR/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
-[![Build Status](https://dev.azure.com/git/git/_apis/build/status/git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=11)
 
 Git - fast, scalable, distributed revision control system
 =========================================================
diff --git a/azure-pipelines.yml b/azure-pipelines.yml
deleted file mode 100644
index 675c3a43c9c..00000000000
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
-       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-linux32-docker.sh || res=1
-
-       sudo chmod a+r t/out/TEST-*.xml
-       test ! -d t/failed-test-artifacts || sudo chmod a+r t/failed-test-artifacts
-
-       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || res=1
-       exit $res
-    displayName: 'ci/run-linux32-docker.sh'
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
gitgitgadget
