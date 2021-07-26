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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE7FC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FF260F6E
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbhGZTqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhGZTqv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 15:46:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8C9C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 13:27:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n12so8989312wrr.2
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 13:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t/46yLFfB6eWi6NjJPXUGNud8zF42gep95Qf/tATfA4=;
        b=oqTZsyLsx9zaHBeigeqhBKp7NFptrRWaTGWNcHQI0IufL17tEcYSf0bdR9vZig+Ocx
         KhD8Djk3hYLeel2rTbuh/yw+p6svtxwqTau7ZDEMwhcjYmoQWKj4vSrySEuS8ekuGna6
         Vyo0+LAGozHf3VfMkQgYelmA7IuBgbOhugbkPpba0Ebvv/JXBB4+23ctRw1Gzs6+g16J
         PSq7ASBljcJl9eZKMpIGjWa1/E6gC9a1wIb7PnqOcF009B+J5bSSFGSJJz/VTNfx/krf
         bYvDWuSsIw9Hnzuj2sKNHmiI8GccwiwbRbLmxZT2BuEj9JqbJ66Z4R0a2GVU8XFuoERh
         IDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t/46yLFfB6eWi6NjJPXUGNud8zF42gep95Qf/tATfA4=;
        b=PrBIGIevkdfOS/jNYN97IFmFp871gT0MOBU6BsboBwlnjchVDlS9IBU6HwzP1jAmu5
         aoO5bs9bgwq/uT1vGUP/ORqFvfvU8eV16NfksSibuCnVv4V1iT2Cj4dsEtBHW65PGzBm
         dGXN7eDuoS2pOyVg+T2aRQftsuyJz8KdAKPI/k7AavIzYPyAalpHLESDAOj/8RKowX6G
         +Bg6aw4SV+f7YQEdqDl9CtrKDYChpsFYPTO1V2RLl5gOkzYSC+nm7O3GzLcvqyrryJji
         bnpDpzQS03kwgbnc2zHb9tbFBp57ULTisx2Ek5O6THI+llGm951Pbe6ogNCEBvQqqSya
         mSpQ==
X-Gm-Message-State: AOAM53153jIYDkKOUfmbRmIhLut0T/sQIZG5ZDz1kxRD5J0c0envxLT2
        CeMB2VOaGPrRcuZ4yeDK+BJi3BMXea8=
X-Google-Smtp-Source: ABdhPJzY28wZRGIzuwpeJXJjVHFrJvsgotkS/c0n03b2rMoxZVNr9qqAUIY9VAnJMCaf0YxoeciVqg==
X-Received: by 2002:adf:f143:: with SMTP id y3mr10756311wro.122.1627331237805;
        Mon, 26 Jul 2021 13:27:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4sm861784wrt.24.2021.07.26.13.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 13:27:17 -0700 (PDT)
Message-Id: <pull.994.v3.git.1627331236817.gitgitgadget@gmail.com>
In-Reply-To: <pull.994.v2.git.1626263433838.gitgitgadget@gmail.com>
References: <pull.994.v2.git.1626263433838.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 20:27:16 +0000
Subject: [PATCH v3] ci: run `make sparse` as part of the GitHub workflow
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
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

Helped-by: Jeff King <peff@peff.net>
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
    
    Changes since v2:
    
     * We're now reusing the ci/install-dependencies.sh script even in the
       sparse job.
    
    Changes since v1:
    
     * The job was folded into main.yml
     * The commit message and a code comment now explain why we have to
       download & install a custom sparse package instead of using Ubuntu's
       default one
     * The commit message now contains a link to the documentation of the
       sparse tool

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-994%2Fdscho%2Fci-enable-sparse-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-994/dscho/ci-enable-sparse-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/994

Range-diff vs v2:

 1:  8b631acfaa2 ! 1:  762c4cbb6e2 ci: run `make sparse` as part of the GitHub workflow
     @@ Commit message
          package from the Azure Pipeline that we specifically created to address
          this issue.
      
     +    Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
      +        artifact: sparse-20.04
      +    - name: Install the current `sparse` package
      +      run: sudo dpkg -i sparse-20.04/sparse_*.deb
     -+    - name: Install other dependencies
     -+      run: |
     -+        sudo apt-get install -q -y libssl-dev libcurl4-openssl-dev libexpat-dev gettext zlib1g-dev
      +    - uses: actions/checkout@v2
     ++    - name: Install other dependencies
     ++      run: ci/install-dependencies.sh
      +    - run: make sparse
         documentation:
           needs: ci-config
           if: needs.ci-config.outputs.enabled == 'yes'
     +
     + ## ci/install-dependencies.sh ##
     +@@ ci/install-dependencies.sh: StaticAnalysis)
     + 	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
     + 		libexpat-dev gettext make
     + 	;;
     ++sparse)
     ++	sudo apt-get -q update -q
     ++	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
     ++		libexpat-dev gettext zlib1g-dev
     ++	;;
     + Documentation)
     + 	sudo apt-get -q update
     + 	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make


 .github/workflows/main.yml | 20 ++++++++++++++++++++
 ci/install-dependencies.sh |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 73856bafc9d..224c46b6d6a 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -350,6 +350,26 @@ jobs:
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
+    - uses: actions/checkout@v2
+    - name: Install other dependencies
+      run: ci/install-dependencies.sh
+    - run: make sparse
   documentation:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 67852d0d37f..5772081b6e5 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -65,6 +65,11 @@ StaticAnalysis)
 	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
 		libexpat-dev gettext make
 	;;
+sparse)
+	sudo apt-get -q update -q
+	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
+		libexpat-dev gettext zlib1g-dev
+	;;
 Documentation)
 	sudo apt-get -q update
 	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make

base-commit: 75ae10bc75336db031ee58d13c5037b929235912
-- 
gitgitgadget
