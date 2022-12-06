Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC695C63703
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 08:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiLFIYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 03:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiLFIYN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 03:24:13 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B39CE2C
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 00:24:12 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id a14so9827203pfa.1
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 00:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tyL7QemrvtS9Ws8rK1hRaEYw6rUhFuGwMp4NU/xAWUU=;
        b=hm0wEiIwkiDh7dRxFheMx3TzebLoe8E2kHlH/dduLD0H3YTKhZEVFtEuEzeNW5EE63
         OlIikW5Fj0Y8UP6OH5fgMAbwybdt2aqHcu8J8PCBgTfEa4OP6tcHTj9UckrVBnXKJoRX
         lZc1PiYTzeQ7rr9TYnUnPiT/gY9ugeoFgvAYf0PaQ8lynj5rHx879/jSp6uXRizPg/B6
         2uo6Q6XhkAHahFsEeO4+3ZoQTV8gilXPl9aMUwHevaYvz3dmlJ2WFP6CuIwD44c1A9jx
         foNDg5BYTIi8prlp5CizNSqV/mWwxo4Av66lG7W7y72e9wlmYH6BSy07bAHYC5qZ3Wu6
         Q78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tyL7QemrvtS9Ws8rK1hRaEYw6rUhFuGwMp4NU/xAWUU=;
        b=QD4xoKCtJIM3JD3c3BvdadrjOnpWw59me8M1yXLjur4KX/zQx5kgqsJn9EQOsawd6S
         0MFcWI1Sukksim3rAU8NtnNw/eV4VKFAdWlnf3UkRQMasc3zolNwas1gzPgn38KoHPeR
         2SNSjRC66A822MOxJ+pbPV8Q3YEnjJvZU/Rm/OnSdHcyfiiTnf//63o1ebfXdNVS3UIU
         sNRXUa28/tT6Uwg9phmwlospkFyXXzy6ph8OuiIYQxUjOjaL1BA30YlKd4rPtBCWzfuX
         7kSJnKddKzc3wbcjHttYjWCESyUOuROou9D6gJ5pmfU7j6OWET/jk/N9/8gAok3qkkXN
         zLeA==
X-Gm-Message-State: ANoB5plhOuOsoCR/dKFGb9muV2JXfDuZNehqgdDEJRnS3uP+FRgHLfHN
        OFgB8S0Ov7I4h2UhUhWPD/kzkg5XgP4alg==
X-Google-Smtp-Source: AA0mqf5Nf0Ezes0Pe/milgPwz6b/wGobEd0WDM6r+Ers+/OOxE7zd88TTHMbm+dgwTVwSLJpejsaaw==
X-Received: by 2002:aa7:8b4d:0:b0:56c:411f:b699 with SMTP id i13-20020aa78b4d000000b0056c411fb699mr67720552pfd.48.1670315051943;
        Tue, 06 Dec 2022 00:24:11 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 190-20020a6205c7000000b00573eb4a775esm11521007pff.17.2022.12.06.00.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 00:24:11 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Oscar Dominguez <dominguez.celada@gmail.com>
Subject: [PATCH] ci: use actions/{upload,download}-artifact@v3
References: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>
        <pull.1354.v2.git.git.1670234474721.gitgitgadget@gmail.com>
Date:   Tue, 06 Dec 2022 17:24:11 +0900
Message-ID: <xmqq1qpd9bys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GitHub CI jobs stopped complaining about use of deprecated actions
that requires deprecated Node.js 12 for some steps, thanks to a
recent work by Oscar Dominguez to upgrade actions/checkout from v2
(which required Node.js 12) to v3 (which runs with recommended
Node.js 16).

Upgrade actions/upload-artifact and actions/download-artifact from
v2 to v3, following suit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The CI run hasn't finished, but it seems to be doing well
   https://github.com/git/git/actions/runs/3627513480

   We are also getting complaint about our use of set-output command
   that is deprecated, which will need to be addressed, too.

 .github/workflows/main.yml | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 5262823eb1..7a24c6613e 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -94,7 +94,7 @@ jobs:
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-      uses: actions/upload-artifact@v2
+      uses: actions/upload-artifact@v3
       with:
         name: windows-artifacts
         path: artifacts
@@ -108,7 +108,7 @@ jobs:
         nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
     steps:
     - name: download tracked files and build artifacts
-      uses: actions/download-artifact@v2
+      uses: actions/download-artifact@v3
       with:
         name: windows-artifacts
         path: ${{github.workspace}}
@@ -125,7 +125,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v2
+      uses: actions/upload-artifact@v3
       with:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -177,7 +177,7 @@ jobs:
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-      uses: actions/upload-artifact@v2
+      uses: actions/upload-artifact@v3
       with:
         name: vs-artifacts
         path: artifacts
@@ -192,7 +192,7 @@ jobs:
     steps:
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: download tracked files and build artifacts
-      uses: actions/download-artifact@v2
+      uses: actions/download-artifact@v3
       with:
         name: vs-artifacts
         path: ${{github.workspace}}
@@ -210,7 +210,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v2
+      uses: actions/upload-artifact@v3
       with:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -267,7 +267,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v2
+      uses: actions/upload-artifact@v3
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
-- 
2.39.0-rc2

