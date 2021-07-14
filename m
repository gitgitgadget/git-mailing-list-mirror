Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC3FC07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8A461106
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbhGNLx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 07:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhGNLx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 07:53:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808CFC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:50:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j34so1381215wms.5
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KQ6bVbpTCq2Jpc3nU/4yoOcejjzevTpkOtyh3MrE/FA=;
        b=Ve6Fd1zsMsi7CBwnSfwgJ0lOZzzgM90rSCwzc8UMWYq28XDAnSNpKfb7n9Axf245iS
         GDQCgEdGpLPg9l5aaBEAA+WIpzvkiOjwy4xaBh2AhQqWyaxszsUCh/3dYrdhRS15z1rU
         +EURaecHyB593774K9OdJ5wd+Pc1zGq79SAdaFLQcbezUROPn3+yYkMovNn6QWiSP6qi
         QH/YwB/YW18HfR/46fsRIX1u0r9wHq3FLS2YZWl0QG+/jt4d3N5UaoDD0uONkNp62Z52
         laJySIrJeC8NaPL7rdWFLvakDjObE5zNAHV2vFZvBqnKCevDYYWmSS4/g++4Kh48qNBh
         /QNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KQ6bVbpTCq2Jpc3nU/4yoOcejjzevTpkOtyh3MrE/FA=;
        b=KPZiprN7zXqmP37u9ISC8KRRS6J+IZzFT52fXCHjAEBB7zp+lBppGfZcqVFjkhLdif
         0kN1w/B73uh6XhKubKs3HodHmFAPh/3LAVeGC9RE8U6E+v5olLL4EblicCkVOLUISMB5
         KRCyxEP6xSkzO+0V65ABzTICD9dDQW1MOf0xh6Cf/7eZ7TbvNI6nHcxh3sXbChpI+3cr
         glIdFQtzRlhgm8K9NYxH2y9N2FezQiSIxFsLNly5n4YaRZS7zC+CdPpcpDuQQyFKrMG0
         5o09+eZPA8gEP5wX12zieemHgiB3z+6CrmqEkf+c3oOP1n75ghxh+G9o/4owaKjH0+ju
         Ty0A==
X-Gm-Message-State: AOAM531I90ic/IYMdUQTdXeNKpBb3PXanqQVh8yzy2gQAbWVjJLknbuk
        2dEPJDCUe6vgHi9onlsq4BoOeRVi8Yc=
X-Google-Smtp-Source: ABdhPJwhjbnyTTXiAC6ZbRK6PjhzpBLZ38cO4HgZLx/JvO9gzRfZQwdQ5mQywGCQlyCee1mPaD4YMA==
X-Received: by 2002:a1c:143:: with SMTP id 64mr10779022wmb.187.1626263434856;
        Wed, 14 Jul 2021 04:50:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m12sm1781343wms.24.2021.07.14.04.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 04:50:34 -0700 (PDT)
Message-Id: <pull.994.v2.git.1626263433838.gitgitgadget@gmail.com>
In-Reply-To: <pull.994.git.1626177086682.gitgitgadget@gmail.com>
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 11:50:33 +0000
Subject: [PATCH v2] ci: run `make sparse` as part of the GitHub workflow
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Occasionally we receive reviews after patches were integrated, where
`sparse` (https://sparse.docs.kernel.org/en/latest/ has more information
on that project) identified problems such as file-local variables or
functions being declared as global.

By running `sparse` as part of our Continuous Integration, we can catch
such things much earlier. Even better: developers who activated GitHub
Actions on their forks can catch such issues before even sending their
patches to the Git mailing list.

This addresses https://github.com/gitgitgadget/git/issues/345

Note: Not even Ubuntu 20.04 ships with a new enough version of `sparse`
to accommodate Git's needs. The symptom looks like this:

    add-interactive.c:537:51: error: Using plain integer as NULL pointer

To counter that, we download and install the custom-built `sparse`
package from the Azure Pipeline that we specifically created to address
this issue.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: run make sparse as a GitHub workflow
    
    One of the earliest open source static analyzers is called "sparse", and
    occasionally Ramsay Jones sends out mails on the Git mailing list that
    some function or other should be declared static because sparse found
    out that it is only used within the same file.
    
    Let's add a GitHub workflow running "make sparse".
    
    Example run:
    https://github.com/gitgitgadget/git/pull/994/checks?check_run_id=3065255116
    
    Changes since v1:
    
     * The job was folded into main.yml
     * The commit message and a code comment now explain why we have to
       download & install a custom sparse package instead of using Ubuntu's
       default one
     * The commit message now contains a link to the documentation of the
       sparse tool

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-994%2Fdscho%2Fci-enable-sparse-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-994/dscho/ci-enable-sparse-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/994

Range-diff vs v1:

 1:  d1af618dd73 ! 1:  8b631acfaa2 ci: run `make sparse` as a GitHub workflow
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    ci: run `make sparse` as a GitHub workflow
     +    ci: run `make sparse` as part of the GitHub workflow
      
          Occasionally we receive reviews after patches were integrated, where
     -    `sparse` identified problems such as file-local variables or functions
     -    being declared as global.
     +    `sparse` (https://sparse.docs.kernel.org/en/latest/ has more information
     +    on that project) identified problems such as file-local variables or
     +    functions being declared as global.
      
          By running `sparse` as part of our Continuous Integration, we can catch
          such things much earlier. Even better: developers who activated GitHub
     @@ Commit message
      
          This addresses https://github.com/gitgitgadget/git/issues/345
      
     +    Note: Not even Ubuntu 20.04 ships with a new enough version of `sparse`
     +    to accommodate Git's needs. The symptom looks like this:
     +
     +        add-interactive.c:537:51: error: Using plain integer as NULL pointer
     +
     +    To counter that, we download and install the custom-built `sparse`
     +    package from the Azure Pipeline that we specifically created to address
     +    this issue.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     - ## .github/workflows/run-sparse.yml (new) ##
     -@@
     -+name: Run `sparse`
     -+
     -+on: [push, pull_request]
     -+
     -+jobs:
     + ## .github/workflows/main.yml ##
     +@@ .github/workflows/main.yml: jobs:
     +     - uses: actions/checkout@v1
     +     - run: ci/install-dependencies.sh
     +     - run: ci/run-static-analysis.sh
      +  sparse:
     ++    needs: ci-config
     ++    if: needs.ci-config.outputs.enabled == 'yes'
     ++    env:
     ++      jobname: sparse
      +    runs-on: ubuntu-20.04
      +    steps:
     -+    - name: Download the `sparse` package
     ++    - name: Download a current `sparse` package
     ++      # Ubuntu's `sparse` version is too old for us
      +      uses: git-for-windows/get-azure-pipelines-artifact@v0
      +      with:
      +        repository: git/git
      +        definitionId: 10
      +        artifact: sparse-20.04
     -+    - name: Install the `sparse` package
     ++    - name: Install the current `sparse` package
      +      run: sudo dpkg -i sparse-20.04/sparse_*.deb
     -+    - name: Install a couple of dependencies
     ++    - name: Install other dependencies
      +      run: |
      +        sudo apt-get install -q -y libssl-dev libcurl4-openssl-dev libexpat-dev gettext zlib1g-dev
      +    - uses: actions/checkout@v2
     -+    - name: make sparse
     -+      run: make sparse
     - \ No newline at end of file
     ++    - run: make sparse
     +   documentation:
     +     needs: ci-config
     +     if: needs.ci-config.outputs.enabled == 'yes'


 .github/workflows/main.yml | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 73856bafc9d..1b5c0392079 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -350,6 +350,27 @@ jobs:
     - uses: actions/checkout@v1
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
+  sparse:
+    needs: ci-config
+    if: needs.ci-config.outputs.enabled == 'yes'
+    env:
+      jobname: sparse
+    runs-on: ubuntu-20.04
+    steps:
+    - name: Download a current `sparse` package
+      # Ubuntu's `sparse` version is too old for us
+      uses: git-for-windows/get-azure-pipelines-artifact@v0
+      with:
+        repository: git/git
+        definitionId: 10
+        artifact: sparse-20.04
+    - name: Install the current `sparse` package
+      run: sudo dpkg -i sparse-20.04/sparse_*.deb
+    - name: Install other dependencies
+      run: |
+        sudo apt-get install -q -y libssl-dev libcurl4-openssl-dev libexpat-dev gettext zlib1g-dev
+    - uses: actions/checkout@v2
+    - run: make sparse
   documentation:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'

base-commit: 75ae10bc75336db031ee58d13c5037b929235912
-- 
gitgitgadget
