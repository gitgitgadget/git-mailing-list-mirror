Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E2EC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 13:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiKCNeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 09:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiKCNeW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 09:34:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EDA65B1
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 06:34:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso1189620wmp.5
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 06:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVNB6TvmQy8RcaiRWLSgdy7yFPZfMpMiR3RGfOngUpo=;
        b=oIj974TjNE7jVxx6fZS5Bx4EeTSyQmtvSSQqP2A+4OG5+VsiIs0rPO/wpuC1eCHF8B
         s6V4kTPWN6pyyS8BUq5NhAR/Yu/Lae+w/d2VyoKhxJdzErTwKScvFBY8prDPKYp2BSV8
         MEzdWCEyRbmc1FQ+6zKAZKsKVHVlVFUoCI1Usga3Rbc78WWkNcoSLrEkEH7GiuvQgGiW
         wQkugTuNxGfGTcqMKlYw2502rctGld4D68D8K/kULP83dwDsOUrpttxWNX5bGdOG892e
         SuyPTYg05ZBE8q6ko2OBOpev5yHRE3MEFJ/DbcZik+TtavdZngzsN43HYGDjI6HNzLRe
         88lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVNB6TvmQy8RcaiRWLSgdy7yFPZfMpMiR3RGfOngUpo=;
        b=Z3febDM/EPfjsQAX1VKatI+1jtKnytdO++6zZWy7iuCl+zIXd8doJYKVOlpth8xIml
         Xn5FjJ0AOpRu+wnRqVUmvEILAmUOsvPSk6r3+hVfuQ4M43qSRVV8rMu3+746UPYfGmxG
         WyRDqePVFciiqiWiKEzdPwqZvz6tJefJYNTWy03bR3i75hAfHCzQcmdMgYBymto+occS
         PMv1Wp6dpB0VL56oT7CcslyAtvm3Vr0Q0WpAA4Gt8dIldkTtv7JjOuDAQSpx5dWZSKGQ
         G2F2PAIvUZxFFvqVU2s25SqlgZqWSacBW70A/2Opqek+ejDqojU27ezGv/JFz60KivCO
         VFIA==
X-Gm-Message-State: ACrzQf2DeB8KT2W055qoPNzwdABYNbiHtRtjg4ey0PWW2pn9wZeKUosu
        3p2QVQAhpq/3sk1I1vSlrRbMKZ1Fzfw=
X-Google-Smtp-Source: AMsMyM7/eYyt4jrcjs9BEstGOZzggZ91ux4nAO9FOODNaWNEJq/xxE2uedgZ4atnyOki+gWA7e6z8w==
X-Received: by 2002:a05:600c:468e:b0:3c6:f510:735c with SMTP id p14-20020a05600c468e00b003c6f510735cmr19182341wmo.179.1667482459651;
        Thu, 03 Nov 2022 06:34:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d12-20020a5d4f8c000000b0022cdeba3f83sm921890wru.84.2022.11.03.06.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:34:19 -0700 (PDT)
Message-Id: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Nov 2022 13:34:18 +0000
Subject: [PATCH] ci: avoid unnecessary builds
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Whenever a branch is pushed to a repository which has GitHub Actions
enabled, a bunch of new workflow runs are started.

We sometimes see contributors push multiple branch updates in rapid
succession, which in conjunction with the impressive time swallowed by
even just a single CI build frequently leads to many queued-up runs.

This is particularly problematic in the case of Pull Requests where a
single contributor can easily (inadvertently) prevent timely builds for
other contributors.

To help with this situation, let's use the `concurrency` feature of
GitHub workflows, essentially canceling GitHub workflow runs that are
obsoleted by more recent runs:
https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#concurrency

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: avoid unnecessary builds
    
    Just something I noticed recently and only got around to implement
    today.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1404%2Fdscho%2Favoid-unnecessary-ci-builds-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1404/dscho/avoid-unnecessary-ci-builds-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1404

 .github/workflows/check-whitespace.yml | 5 +++++
 .github/workflows/l10n.yml             | 5 +++++
 .github/workflows/main.yml             | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index ad3466ad16e..8a4c4bfbb93 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -9,6 +9,11 @@ on:
   pull_request:
     types: [opened, synchronize]
 
+# Avoid unnecessary builds
+concurrency:
+  group: ${{ github.workflow }}-${{ github.ref }}
+  cancel-in-progress: true
+
 jobs:
   check-whitespace:
     runs-on: ubuntu-latest
diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
index 27f72f0ff34..77d9a416289 100644
--- a/.github/workflows/l10n.yml
+++ b/.github/workflows/l10n.yml
@@ -2,6 +2,11 @@ name: git-l10n
 
 on: [push, pull_request_target]
 
+# Avoid unnecessary builds
+concurrency:
+  group: ${{ github.workflow }}-${{ github.ref }}
+  cancel-in-progress: true
+
 jobs:
   git-po-helper:
     if: >-
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 831f4df56c5..cf47f0ccfed 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -2,6 +2,11 @@ name: CI
 
 on: [push, pull_request]
 
+# Avoid unnecessary builds
+concurrency:
+  group: ${{ github.workflow }}-${{ github.ref }}
+  cancel-in-progress: true
+
 env:
   DEVELOPER: 1
 

base-commit: e7e5c6f715b2de7bea0d39c7d2ba887335b40aa0
-- 
gitgitgadget
