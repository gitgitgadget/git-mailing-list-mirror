Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE3CC43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 14:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54CA2078B
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 14:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCkCvI7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgCaOqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:46:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41369 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgCaOqx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 10:46:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id b1so10427345pgm.8
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iiPW1B5NZfn/bjBnbs6rwrs9eHXA7/W31bE6TEioMC0=;
        b=iCkCvI7hNEs1PrGx7Pkkmal2PTR7DVdeREiQqFQqVMClv5jZjz9TbwnEemRshvWUNW
         LKCWPux58xMG8FCVCr1+LDQSRMtgNDKxCEYOmY1LTE5HLGZh10FqvIBDBUtJthLUPlad
         qdhGL4FbW7FLCcc4ZFBpyZ0mTP4sG9SyTDdgIfcRtfCTUzbCdbrumiaXEx+lCUZ4f1vV
         7YiL/IDiKdf03z0OvP2qXMyx3hLuQFEmT09aE+CZyWKD7qCVtKYsqgiI/Pmy+NXvPxG1
         6/bxN6tRWSB1WMIYViLJb87gZHdsZCnPEAnbXmUjSnAhimC1q1bMh0yqfGFlYLEXsqze
         as/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iiPW1B5NZfn/bjBnbs6rwrs9eHXA7/W31bE6TEioMC0=;
        b=VsyRJX8X6IzLoACewebyGVN9c2XE1w6W5I2EhBPPqVyFAo2ug6jtwMdOPz1Iu+zXKE
         gMjuDe6tr8UyxhC5yF4+yTRevIRgUxGfSywChPy2/IzHkdLo/bAaqtl+54wfPVk7IKB7
         m+N55aZeZ63NoEDpaThQiDiNqH0bCXYrdARF0ZVYyTP2gTHtFrZVCvFJWt999g+muz6F
         KElUYC5BdXnOqL/VSmvn7BNWc8rWRD2p0S6z+ObZ9VGnzz8TbHONcP5SxTA1AbE8f1nO
         WquIF2vEi7KHG9tD3c5+rV4JGKgcmd9acMWNy+8mQkpYeLUFGnZkQewdrRducwozGOVD
         9q3g==
X-Gm-Message-State: AGi0Pua+t0AmYZhMynd7bCY4lU/xKUXvhWPCrRfUsHk1bRSQs6NZV/aP
        fJJc+XUmcxscAsNuym5ZFXc=
X-Google-Smtp-Source: APiQypKkFw3/RlkcfFo4gUIYrFgv+n4dN+KlJvuGtNtG5r2VjziJuEqF1j4EpvB31G5W//nVYg6CFQ==
X-Received: by 2002:a63:c212:: with SMTP id b18mr4342208pgd.92.1585666011357;
        Tue, 31 Mar 2020 07:46:51 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id i189sm12672105pfc.148.2020.03.31.07.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:46:50 -0700 (PDT)
Date:   Tue, 31 Mar 2020 21:46:48 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/5] ci: replace our Azure Pipeline by GitHub Actions
Message-ID: <20200331144648.GC15850@danh.dev>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2020-03-31 12:48:28+0000, Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com> wrote:
> Our Azure Pipeline has served us well over the course of the past year or
> so, steadily catching issues before the respective patches hit the next 
> branch.
> 
> There is a GitHub-native CI system now, though, called "GitHub Actions"
> [https://github.com/features/actions] which is essentially on par with Azure
> Pipelines as far as our needs are concerned, and it brings a couple of
> advantages:
> 
>  * It is substantially easier to set up than Azure Pipelines: all you need
>    is to add the YAML-based build definition, push to your fork on GitHub,
>    and that's it.
>  * The syntax is a bit easier to read than Azure Pipelines'.
>  * We get more concurrent jobs (Azure Pipelines is limited to 10 concurrent
>    jobs).
> 
> With this change, users also no longer need to open a PR at 
> https://github.com/git/git or at https://github.com/gitgitgadget/git just to
> get the benefit of a CI build. They just push to their fork on GitHub and
> monitor the build. Easier than making apple pie.
> 
> The only caveat is that this will only work once the patch series makes it
> to master.

Github Actions also works in other branches, at least in pu:
https://github.com/sgn/git/runs/548975243?check_suite_focus=true

Anyway, this series will conflicts with my series for linux-musl CI.
And, Github Actions' Documentation job in pu failed because of missing
"curl-config".

Attached patches can be used to merge this series into pu.

-- 
Danh

--qlTNgmc+xy1dBmNv
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: inline;
	filename="0001-github-actions-fixup-to-dd-musl-libc-travis-ci.patch"
Content-Transfer-Encoding: 8bit

From dfc8e913c9878a1b5a9e58d1c69884a1b7bd7864 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=
 <congdanhqx@gmail.com>
Date: Tue, 31 Mar 2020 21:21:23 +0700
Subject: [PATCH 1/2] github-actions: fixup to dd/musl-libc-travis-ci
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .github/workflows/main.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 14025c8a7e..19e831c45e 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -240,10 +240,10 @@ jobs:
     runs-on: ubuntu-latest
     steps:
     - uses: actions/checkout@v1
-    - name: ci/run-linux32-docker.sh
+    - name: jobname=Linux32 ci/run-docker.sh
       run: |
         res=0
-        sudo GITHUB_ACTIONS="$GITHUB_ACTIONS" RUNNER_OS="$RUNNER_OS" GITHUB_REF="$GITHUB_REF" GITHUB_SHA="$GITHUB_SHA" GITHUB_REPOSITORY="$GITHUB_REPOSITORY" GITHUB_RUN_ID="$GITHUB_RUN_ID" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-linux32-docker.sh || res=1
+        sudo GITHUB_ACTIONS="$GITHUB_ACTIONS" RUNNER_OS="$RUNNER_OS" GITHUB_REF="$GITHUB_REF" GITHUB_SHA="$GITHUB_SHA" GITHUB_REPOSITORY="$GITHUB_REPOSITORY" GITHUB_RUN_ID="$GITHUB_RUN_ID" CC=$CC MAKEFLAGS="$MAKEFLAGS" jobname=Linux32 bash -lxc ci/run-docker.sh || res=1
   static-analysis:
     runs-on: ubuntu-latest
     steps:
-- 
2.26.0.334.g6536db25bb


--qlTNgmc+xy1dBmNv
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: inline;
	filename="0002-github-actions-enable-linux-musl-check.patch"
Content-Transfer-Encoding: 8bit

From 48d4247a8c70a6b99171a863a43fc40c925351b4 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=
 <congdanhqx@gmail.com>
Date: Tue, 31 Mar 2020 21:23:16 +0700
Subject: [PATCH 2/2] github-actions: enable linux-musl check
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .github/workflows/main.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 19e831c45e..2f7c77afad 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -236,6 +236,14 @@ jobs:
           ci/print-test-failures.sh
           exit 1
         }
+  linux-musl:
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v1
+    - name: jobname=linux-musl ci/run-docker.sh
+      run: |
+        res=0
+        sudo GITHUB_ACTIONS="$GITHUB_ACTIONS" RUNNER_OS="$RUNNER_OS" GITHUB_REF="$GITHUB_REF" GITHUB_SHA="$GITHUB_SHA" GITHUB_REPOSITORY="$GITHUB_REPOSITORY" GITHUB_RUN_ID="$GITHUB_RUN_ID" CC=$CC MAKEFLAGS="$MAKEFLAGS" jobname=linux-musl bash -lxc ci/run-docker.sh || res=1
   linux32:
     runs-on: ubuntu-latest
     steps:
-- 
2.26.0.334.g6536db25bb


--qlTNgmc+xy1dBmNv--
