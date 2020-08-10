Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1996C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 08:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945602065C
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 08:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9QSKYXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgHJIhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgHJIhn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 04:37:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC85AC061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 01:37:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 184so7514795wmb.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 01:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EoC7xg61J0mESswap9BtXSTBRg73SqUhtx/lLXmFu+Y=;
        b=Z9QSKYXr+A5OczteiBSGvlQaOifNW8GRPn1R3nWR+v4qF7/29NyyDgiCVjdxOLgAAW
         EQpG86lALjsfybBO0Huykbd5R5abrKOuekgH86nqUhgacfF6RW/brTcuxoLecdZUf5rt
         8ZcEANpo7Fym7SAdYvjSfpK3fpST8W3614+9xxmTrEUYHd7LseymwXt6VpIJW+32/sQw
         7zfERBkkgeozfIuQzYwKDB5BUE0aEUmTTtk5phMzV6Axcyi5La82ZDAy07i+GMtS0khb
         gfZAmd94lApuz5X7VlquL95Bw4KUaAppWUAvasmVPeaYjIPFTZDjXS4qm31lQHNIq3YM
         ClYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EoC7xg61J0mESswap9BtXSTBRg73SqUhtx/lLXmFu+Y=;
        b=PRAzS5L+qYCsvBURS7TThvsaSFeOqL0k/MFmdt9q3I0QAKpaV8S1e6giFC5Xk4XDaf
         M1iRRkobD2lmx/ktx+dSiobI9qJ2MUCxKoarKgj4I0MT7laYObXIy45p3Cv3T7WTZDbH
         zexoeXANIMey1hdO6JAPsdSgJweK41/FkTP40IggqTeDcq5hhYJmxtAI6RkJNI+XNG8V
         EsAgHac70SJh4qxSVYII0SPMYbqs4lzaTDEPnJh9K9vmUUhdpKMbC30rHccSmRzsIPjf
         mm8pEWOyoOlZ+sgHVhq+4JzDIkqPfzIlaMtLqqc2CyeVwq33SqXAB/eOpjIW+HLjlWcI
         B8+w==
X-Gm-Message-State: AOAM533a0K3y3M3bdlOacwnOUVXwftUSv+jD9aQ3jMsXqLhSwKQkEwCa
        vANb6u8Z0gutTXEp2IC7YgaDefoG
X-Google-Smtp-Source: ABdhPJxf/9zdPN9+jnVK+12skc6WtVi7K2snRqwzKtElse8h8Y2CEgtLakqffRY7mT2w3TY6kuF4Xw==
X-Received: by 2002:a05:600c:2157:: with SMTP id v23mr23267149wml.38.1597048661287;
        Mon, 10 Aug 2020 01:37:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10sm19422513wrw.79.2020.08.10.01.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 01:37:40 -0700 (PDT)
Message-Id: <pull.823.git.git.1597048659983.gitgitgadget@gmail.com>
From:   "Adrian via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Aug 2020 08:37:39 +0000
Subject: [PATCH] ci: fix inconsistent indentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Adrian <adrian@planetcoding.net>,
        Adrian Moennich <adrian@planetcoding.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Adrian Moennich <adrian@planetcoding.net>

Signed-off-by: Adrian Moennich <adrian@planetcoding.net>
---
    Fix inconsistent yaml indentation

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-823%2FThiefMaster%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-823/ThiefMaster/patch-1-v1
Pull-Request: https://github.com/git/git/pull/823

 .github/workflows/main.yml | 56 +++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 84a5dcff7a..5bd321e5e1 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -7,34 +7,34 @@ env:
 
 jobs:
   ci-config:
-      runs-on: ubuntu-latest
-      outputs:
-        enabled: ${{ steps.check-ref.outputs.enabled }}
-      steps:
-        - name: try to clone ci-config branch
-          continue-on-error: true
-          run: |
-            git -c protocol.version=2 clone \
-              --no-tags \
-              --single-branch \
-              -b ci-config \
-              --depth 1 \
-              --no-checkout \
-              --filter=blob:none \
-              https://github.com/${{ github.repository }} \
-              config-repo &&
-              cd config-repo &&
-              git checkout HEAD -- ci/config
-        - id: check-ref
-          name: check whether CI is enabled for ref
-          run: |
-            enabled=yes
-            if test -x config-repo/ci/config/allow-ref &&
-               ! config-repo/ci/config/allow-ref '${{ github.ref }}'
-            then
-              enabled=no
-            fi
-            echo "::set-output name=enabled::$enabled"
+    runs-on: ubuntu-latest
+    outputs:
+      enabled: ${{ steps.check-ref.outputs.enabled }}
+    steps:
+      - name: try to clone ci-config branch
+        continue-on-error: true
+        run: |
+          git -c protocol.version=2 clone \
+            --no-tags \
+            --single-branch \
+            -b ci-config \
+            --depth 1 \
+            --no-checkout \
+            --filter=blob:none \
+            https://github.com/${{ github.repository }} \
+            config-repo &&
+            cd config-repo &&
+            git checkout HEAD -- ci/config
+      - id: check-ref
+        name: check whether CI is enabled for ref
+        run: |
+          enabled=yes
+          if test -x config-repo/ci/config/allow-ref &&
+             ! config-repo/ci/config/allow-ref '${{ github.ref }}'
+          then
+            enabled=no
+          fi
+          echo "::set-output name=enabled::$enabled"
 
   windows-build:
     needs: ci-config

base-commit: dc04167d378fb29d30e1647ff6ff51dd182bc9a3
-- 
gitgitgadget
