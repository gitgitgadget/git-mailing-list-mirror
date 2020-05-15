Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F31C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 07:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1B1206B6
	for <git@archiver.kernel.org>; Fri, 15 May 2020 07:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCEfppEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgEOHzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 03:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726696AbgEOHzW (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 03:55:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD04C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 00:55:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d207so13218157wmd.0
        for <git@vger.kernel.org>; Fri, 15 May 2020 00:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=eNoTBxUEOgVe/yaRYu88zGe6KPTosgINDnkJXxUAqXw=;
        b=TCEfppEdqdTpEg1JC5yDUh7q17sIK8Iq/y0uVlCQPy95nj6azgGG9Ct0GOepU/QkUm
         zqPeHEY0nk+zZPBCLf7GQsX1+0/w9Fyhv0yyvtmeHpSIA6cle5dr8DMOqO32sg6CpDcl
         XiPa7oKLOKiqWZV1UehTHFJUKyCWJ4cUsCI4IAA8eFbNl+1BP+SKTnoisCZ71LwCyTxc
         lzInqU7+zWMfNQnNZSgSXxPE85AxXX0IxWHu7i6+asKjZ+Mb08R3JsxsDNs8G5nnKw4+
         55xtJ9WHn0tq9Fe46TFRS2FhNQ+IZgL66ryWcKOp5fLYmkLJPKgEVbCXFACPqqoHxy0m
         JuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=eNoTBxUEOgVe/yaRYu88zGe6KPTosgINDnkJXxUAqXw=;
        b=iwSAXM2apzRgJ5ya2UmAY5KFJ0gsCJ2hQ2Cqggv3GbWQszRAxEoRNDNmsqBPCMIkgh
         uTFic6AyejcSCPzkZglqGkc6DEKoL5/YADEmO2R50CSN8VYAQQX90qo9d8NPMUK8rCLL
         3gd9AKKtE6wj7YFyCyZitwDP2Wy4l0ECoC2YNvk0vlqu/a+iv2tEdYOzbIx5VA9M/yRb
         TTv/87HAe9/n4j/hqy/dBtJ8Kop7HqIbWTA+MVKD6gssDgubxcZ2Zoo5MXUgpW96SS1S
         f9r2TzWU44S3BpC5HmENePqRft847UXA/NF89HtcnxbKzHrddKDGYIpYxP/SalIBNhNb
         DFCw==
X-Gm-Message-State: AOAM532jK0W6yCPZ4l+tXJCop+IzNUbPbZF+fhKXiVFGOKAYt5tY3Ow8
        E74aOHIiZ5ULE9ALNF+ubc8mGUEO
X-Google-Smtp-Source: ABdhPJws6rrHR2wqY2gCqo5JHUH/ELYa+M2rpSUoHBT4sYIVV4W60UqnwWNwRFWATkup0sMlYPYcdA==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr2695209wmc.137.1589529320495;
        Fri, 15 May 2020 00:55:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e22sm2454483wrc.41.2020.05.15.00.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 00:55:19 -0700 (PDT)
Message-Id: <pull.632.v2.git.1589529318969.gitgitgadget@gmail.com>
In-Reply-To: <pull.632.git.1589316430595.gitgitgadget@gmail.com>
References: <pull.632.git.1589316430595.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 May 2020 07:55:18 +0000
Subject: [PATCH v2] ci: avoid pounding on the poor ci-artifacts container
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When this developer tested how the git-sdk-64-minimal artifact could be
served to all the GitHub workflow runs that need it, Azure Blobs looked
like a pretty good choice: it is reliable, fast and we already use it in
Git for Windows to serve components like OpenSSL, cURL, etc

It came as an unpleasant surprise just _how many_ times this artifact
was downloaded. It exploded the bandwidth to a point where the free tier
would no longer be enough, threatening to block other, essential Git for
Windows services.

Let's switch back to using the Build Artifacts of our trusty Azure
Pipeline for the time being.

To avoid unnecessary hammering of the Azure Pipeline artifacts, we use
the GitHub Action `actions/upload-artifact` in the `windows-build` job
and the GitHub Action `actions/download-artifact` in the `windows-test`
and `vs-test` jobs (the latter now depends on `windows-build` for that
reason, too).

Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: avoid pounding on the poor ci-artifacts container
    
    I did not think through how I designed the Windows job initializing the
    minimal subset of Git for Windows' SDK (containing e.g. make, gcc etc):
    it currently accesses Azure Blobs and uses way too much bandwidth,
    blowing right through my quota.
    
    So for now, all the Windows/Visual Studio builds will be failing to
    download that SDK subset.
    
    With this patch, we use the (slower) method of downloading the
    git-sdk-64-minimal Build Artifact of our Azure Pipeline again, which
    fixes that particular problem.
    
    To be sure, it is a shame that we now spend around a whole minute
    downloading that SDK subset instead of those sweet, sweet seven seconds.
    But what does not work does not work, and that's that.
    
    Change since v1:
    
     * Simplifying the scripted code by using jq (thanks, Danh!)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-632%2Fdscho%2Favoid-ci-artifacts-for-now-git.git-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-632/dscho/avoid-ci-artifacts-for-now-git.git-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/632

Range-diff vs v1:

 1:  274ae816be6 ! 1:  14606cc2ed7 ci: avoid pounding on the poor ci-artifacts container
     @@ Commit message
          and `vs-test` jobs (the latter now depends on `windows-build` for that
          reason, too).
      
     +    Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
             shell: bash
      -      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
      +      run: |
     -+        ## Add `json_pp` to the search path
     -+        PATH=$PATH:/usr/bin/core_perl
     -+
      +        ## Get artifact
      +        urlbase=https://dev.azure.com/git-for-windows/git/_apis/build/builds
      +        id=$(curl "$urlbase?definitions=22&statusFilter=completed&resultFilter=succeeded&\$top=1" |
     -+          json_pp |
     -+          sed -n 's/^         "id" : \([1-9][0-9]*\).*/\1/p')
     ++          jq -r ".value[] | .id")
      +        download_url="$(curl "$urlbase/$id/artifacts" |
     -+          json_pp |
     -+          sed -n '/^      {/{:1;N;/\n      }/b2;b1;:2;/"name" : "git-sdk-64-minimal"/{s/.*"downloadUrl" : "\([^\"]*\).*/\1/p}}')"
     ++          jq -r '.value[] | select(.name == "git-sdk-64-minimal").resource.downloadUrl')"
      +        curl --connect-timeout 10 --retry 5 --retry-delay 0 --retry-max-time 240 \
      +          -o artifacts.zip "$download_url"
      +
     @@ .github/workflows/main.yml: jobs:
             shell: bash
      -      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
      +      run: |
     -+        ## Add `json_pp` to the search path
     -+        PATH=$PATH:/usr/bin/core_perl
     -+
      +        ## Get artifact
      +        urlbase=https://dev.azure.com/git-for-windows/git/_apis/build/builds
      +        id=$(curl "$urlbase?definitions=22&statusFilter=completed&resultFilter=succeeded&\$top=1" |
     -+          json_pp |
     -+          sed -n 's/^         "id" : \([1-9][0-9]*\).*/\1/p')
     ++          jq -r ".value[] | .id")
      +        download_url="$(curl "$urlbase/$id/artifacts" |
     -+          json_pp |
     -+          sed -n '/^      {/{:1;N;/\n      }/b2;b1;:2;/"name" : "git-sdk-64-minimal"/{s/.*"downloadUrl" : "\([^\"]*\).*/\1/p}}')"
     ++          jq -r '.value[] | select(.name == "git-sdk-64-minimal").resource.downloadUrl')"
      +        curl --connect-timeout 10 --retry 5 --retry-delay 0 --retry-max-time 240 \
      +          -o artifacts.zip "$download_url"
      +


 .github/workflows/main.yml | 55 ++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index fd4df939b50..482df466510 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -12,7 +12,19 @@ jobs:
     - uses: actions/checkout@v1
     - name: download git-sdk-64-minimal
       shell: bash
-      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
+      run: |
+        ## Get artifact
+        urlbase=https://dev.azure.com/git-for-windows/git/_apis/build/builds
+        id=$(curl "$urlbase?definitions=22&statusFilter=completed&resultFilter=succeeded&\$top=1" |
+          jq -r ".value[] | .id")
+        download_url="$(curl "$urlbase/$id/artifacts" |
+          jq -r '.value[] | select(.name == "git-sdk-64-minimal").resource.downloadUrl')"
+        curl --connect-timeout 10 --retry 5 --retry-delay 0 --retry-max-time 240 \
+          -o artifacts.zip "$download_url"
+
+        ## Unzip and remove the artifact
+        unzip artifacts.zip
+        rm artifacts.zip
     - name: build
       shell: powershell
       env:
@@ -30,6 +42,11 @@ jobs:
       with:
         name: windows-artifacts
         path: artifacts
+    - name: upload git-sdk-64-minimal
+      uses: actions/upload-artifact@v1
+      with:
+        name: git-sdk-64-minimal
+        path: git-sdk-64-minimal
   windows-test:
     runs-on: windows-latest
     needs: [windows-build]
@@ -38,9 +55,6 @@ jobs:
         nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
     steps:
     - uses: actions/checkout@v1
-    - name: download git-sdk-64-minimal
-      shell: bash
-      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
     - name: download build artifacts
       uses: actions/download-artifact@v1
       with:
@@ -49,6 +63,11 @@ jobs:
     - name: extract build artifacts
       shell: bash
       run: tar xf artifacts.tar.gz
+    - name: download git-sdk-64-minimal
+      uses: actions/download-artifact@v1
+      with:
+        name: git-sdk-64-minimal
+        path: ${{github.workspace}}/git-sdk-64-minimal/
     - name: test
       shell: powershell
       run: |
@@ -79,7 +98,19 @@ jobs:
     - uses: actions/checkout@v1
     - name: download git-sdk-64-minimal
       shell: bash
-      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
+      run: |
+        ## Get artifact
+        urlbase=https://dev.azure.com/git-for-windows/git/_apis/build/builds
+        id=$(curl "$urlbase?definitions=22&statusFilter=completed&resultFilter=succeeded&\$top=1" |
+          jq -r ".value[] | .id")
+        download_url="$(curl "$urlbase/$id/artifacts" |
+          jq -r '.value[] | select(.name == "git-sdk-64-minimal").resource.downloadUrl')"
+        curl --connect-timeout 10 --retry 5 --retry-delay 0 --retry-max-time 240 \
+          -o artifacts.zip "$download_url"
+
+        ## Unzip and remove the artifact
+        unzip artifacts.zip
+        rm artifacts.zip
     - name: generate Visual Studio solution
       shell: powershell
       run: |
@@ -119,15 +150,17 @@ jobs:
         path: artifacts
   vs-test:
     runs-on: windows-latest
-    needs: [vs-build]
+    needs: [vs-build, windows-build]
     strategy:
       matrix:
         nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
     steps:
     - uses: actions/checkout@v1
-    - name: download git-64-portable
-      shell: bash
-      run: a=git-64-portable && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
+    - name: download git-sdk-64-minimal
+      uses: actions/download-artifact@v1
+      with:
+        name: git-sdk-64-minimal
+        path: ${{github.workspace}}/git-sdk-64-minimal/
     - name: download build artifacts
       uses: actions/download-artifact@v1
       with:
@@ -143,9 +176,9 @@ jobs:
         NO_SVN_TESTS: 1
         GIT_TEST_SKIP_REBASE_P: 1
       run: |
-        & git-64-portable\git-cmd.exe --command=usr\bin\bash.exe -lc @"
+        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
           # Let Git ignore the SDK and the test-cache
-          printf '%s\n' /git-64-portable/ /test-cache/ >>.git/info/exclude
+          printf '%s\n' /git-sdk-64-minimal/ /test-cache/ >>.git/info/exclude
 
           cd t &&
           PATH=\"`$PWD/helper:`$PATH\" &&

base-commit: f72f328bc57e1b0db380ef76e0c1e94a9ed0ac7c
-- 
gitgitgadget
