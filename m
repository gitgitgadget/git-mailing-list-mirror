Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C63C2D0F7
	for <git@archiver.kernel.org>; Tue, 12 May 2020 20:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5030C20747
	for <git@archiver.kernel.org>; Tue, 12 May 2020 20:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw9HlVoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgELUrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 16:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725950AbgELUrO (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 16:47:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2552C061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 13:47:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id v12so17553364wrp.12
        for <git@vger.kernel.org>; Tue, 12 May 2020 13:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=T9Y4EHWV4pmufirmP3U54+jxCRwOgbdWa1obk2PM70A=;
        b=lw9HlVoowX6JoKDckhNiFMKPrh2iSVAuCahWOn7o5q87REHxfXfPrg2DrNzzwIyKF/
         rC4a57jjxEtqhps7C3xY7t7AUgoaoVqfF9GRmH0AXBAdsp46CmGvnlZs2fnUi65Y4AYo
         K4785IreV3u+rgpyDnmPp3YLqezQZNwQHrBw8h6SKgTQFtg38n5T2yn9ojcCSoHOROnv
         h4GdQOLKcdfFnkQe8Ff3cl6xc6Hc4ZgwMPRokbDgk4gkOCHk7OeY1GLJAO7z44UMrvNY
         h03+ZAlYyS5AZ4rafzUz6SB3CZlQ250hwKCm4PUc4788wCQt9uEppYMGzQn79fGyjtGM
         t3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T9Y4EHWV4pmufirmP3U54+jxCRwOgbdWa1obk2PM70A=;
        b=d12Jmo54CqnHLa37Vf16+nW61hIXd1Sdp2UcACicRrmxDv0LlvgA1OoK7EcKuSzhlv
         cM5dF2tPSBprjHsG32hyKp0e6k1i+2eqxs2nw8iY5X6oex7fopBKx9TQKDsThZChhsHN
         HLcdjvd2h8AxYxhVkW+scp8z9CHKQmTp3IYfRSicQ94P2k7DSiw6IJyu5WBSJCblcK/y
         cR0CBgK7O1MyKYTbANYJCU50YWjwWituhfwHClleRHGabFThsg6n5Kuc6so/05hnuS6V
         0m/VcfhhG75YXzpJEOFGiIpPRelqv1dM/vUp9yvSkTt6iJ2mNOwFzADG5d9+TQreTG1G
         y8Fg==
X-Gm-Message-State: AGi0PuZaZcHYtYqAbJQUPdWX4yoXOu7T01NbYn5pRYYWcwAkt44VeGxw
        hFoYRQEkBiT9JOdFlvjiSRwjLIiA
X-Google-Smtp-Source: APiQypLDGCGao5eZ3dwD4fTGcbNPAHylW78zXXkI6xpqVzvSPx+6oBCcTnNpxPnTrBMn82fxKWzgew==
X-Received: by 2002:a5d:65ce:: with SMTP id e14mr26664476wrw.314.1589316431995;
        Tue, 12 May 2020 13:47:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s24sm34129958wmj.28.2020.05.12.13.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 13:47:11 -0700 (PDT)
Message-Id: <pull.632.git.1589316430595.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 20:47:10 +0000
Subject: [PATCH] ci: avoid pounding on the poor ci-artifacts container
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-632%2Fdscho%2Favoid-ci-artifacts-for-now-git.git-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-632/dscho/avoid-ci-artifacts-for-now-git.git-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/632

 .github/workflows/main.yml | 65 +++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 11 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index fd4df939b50..e2e1611aa22 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -12,7 +12,24 @@ jobs:
     - uses: actions/checkout@v1
     - name: download git-sdk-64-minimal
       shell: bash
-      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
+      run: |
+        ## Add `json_pp` to the search path
+        PATH=$PATH:/usr/bin/core_perl
+
+        ## Get artifact
+        urlbase=https://dev.azure.com/git-for-windows/git/_apis/build/builds
+        id=$(curl "$urlbase?definitions=22&statusFilter=completed&resultFilter=succeeded&\$top=1" |
+          json_pp |
+          sed -n 's/^         "id" : \([1-9][0-9]*\).*/\1/p')
+        download_url="$(curl "$urlbase/$id/artifacts" |
+          json_pp |
+          sed -n '/^      {/{:1;N;/\n      }/b2;b1;:2;/"name" : "git-sdk-64-minimal"/{s/.*"downloadUrl" : "\([^\"]*\).*/\1/p}}')"
+        curl --connect-timeout 10 --retry 5 --retry-delay 0 --retry-max-time 240 \
+          -o artifacts.zip "$download_url"
+
+        ## Unzip and remove the artifact
+        unzip artifacts.zip
+        rm artifacts.zip
     - name: build
       shell: powershell
       env:
@@ -30,6 +47,11 @@ jobs:
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
@@ -38,9 +60,6 @@ jobs:
         nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
     steps:
     - uses: actions/checkout@v1
-    - name: download git-sdk-64-minimal
-      shell: bash
-      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
     - name: download build artifacts
       uses: actions/download-artifact@v1
       with:
@@ -49,6 +68,11 @@ jobs:
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
@@ -79,7 +103,24 @@ jobs:
     - uses: actions/checkout@v1
     - name: download git-sdk-64-minimal
       shell: bash
-      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
+      run: |
+        ## Add `json_pp` to the search path
+        PATH=$PATH:/usr/bin/core_perl
+
+        ## Get artifact
+        urlbase=https://dev.azure.com/git-for-windows/git/_apis/build/builds
+        id=$(curl "$urlbase?definitions=22&statusFilter=completed&resultFilter=succeeded&\$top=1" |
+          json_pp |
+          sed -n 's/^         "id" : \([1-9][0-9]*\).*/\1/p')
+        download_url="$(curl "$urlbase/$id/artifacts" |
+          json_pp |
+          sed -n '/^      {/{:1;N;/\n      }/b2;b1;:2;/"name" : "git-sdk-64-minimal"/{s/.*"downloadUrl" : "\([^\"]*\).*/\1/p}}')"
+        curl --connect-timeout 10 --retry 5 --retry-delay 0 --retry-max-time 240 \
+          -o artifacts.zip "$download_url"
+
+        ## Unzip and remove the artifact
+        unzip artifacts.zip
+        rm artifacts.zip
     - name: generate Visual Studio solution
       shell: powershell
       run: |
@@ -119,15 +160,17 @@ jobs:
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
@@ -143,9 +186,9 @@ jobs:
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
