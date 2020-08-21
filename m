Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404ADC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 09:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195512087D
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 09:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxX3YFMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgHUJ1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHUJ1d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 05:27:33 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D52AC061385
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 02:27:32 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 9so1152336wmj.5
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 02:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qRe/wWn8s8P/F5EzWBWIQ4EpDJyagI9crU0p3zcjRig=;
        b=CxX3YFMwrJWbr1YeR3sFZudO9UqCqK0G5hXMTVbtaPuS4f/b0gJUlkphNTDUkMXPeE
         b4WTsnc224uvOKyi+xnbvhJIkRbUKmW98nyfx6Z/KYC2J+yPvJWz8A/AczNVIPy1A3My
         xuUO0GDTcBBIEuNFiJPG8Maf1azJ46k76dtUJBvg1VIYR1AKERNoIpU8Htde4pdjNQqP
         CJxD/eSAwx0sXJ+/R1YLDLR7voyZ1m98ChPqJ/4c1YvQIH61e3vn1xmWuYlUUvi3eWRV
         NGmVom9W4zbs57otyafUP6k0cQKKCCLtNNoqtmwAXCOyjW4OdIa5IdLb2Sp42u0uhIHm
         6xSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qRe/wWn8s8P/F5EzWBWIQ4EpDJyagI9crU0p3zcjRig=;
        b=Jw1XOBOsG5f9uX89XSZbusCImKWRwHjrdlxDyONRdkxBeijz2NQMIGIZK9YyNuR5ly
         7Ouqv/xiYvL/1dE2N7Vzec3imhTzWFGGBckxZwXTZSWMxeNF0gAjrHbwHAqHDaPlHBOh
         wyeSKat6APfavoaPGZvEoC2z5bsWDP8qxwIbham7b8cIcSkPdS0tREPYM441Do5ot6Bj
         KAzG4pztitj/FhJdjKb+1ZZhgNbT64zeEA3aN4byQedUnP77ynv2h6EBa7EKhO64TlVU
         jB+Idd5EWUTtAJb3A//EWLLNSOGDwmGCpfsdpRjf5qQybjes4kCh5N8CI6ZGF3J6avaN
         KPzw==
X-Gm-Message-State: AOAM5310AHIqhhbHy6uQESdix8XV2cZ3w4abkqecM2Sc5jm21+JQFm8C
        5nK/v2MAxt5kX3FYgoPb8TPJjA48eK0=
X-Google-Smtp-Source: ABdhPJwzBjsvRkk9W6WlcDJiwbOGZ/4GFt6N9nCaQgzb4J0c3NXh1b2CMWOVYcXdeprPOyIjl+121g==
X-Received: by 2002:a1c:56d7:: with SMTP id k206mr2185928wmb.75.1598002048460;
        Fri, 21 Aug 2020 02:27:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r22sm3391142wmh.45.2020.08.21.02.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 02:27:27 -0700 (PDT)
Message-Id: <pull.823.v2.git.git.1598002046754.gitgitgadget@gmail.com>
In-Reply-To: <pull.823.git.git.1597048659983.gitgitgadget@gmail.com>
References: <pull.823.git.git.1597048659983.gitgitgadget@gmail.com>
From:   "Adrian via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 09:27:26 +0000
Subject: [PATCH v2] ci: fix inconsistent indentation
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

While YAML allows different indentation styles as long as each block is
consistent, it is rather unusual to mix different indentations in a
single file.  Therefor I unified the file to use two-space indentation
everywhere.

Signed-off-by: Adrian Moennich <adrian@planetcoding.net>
---
    Fix inconsistent yaml indentation

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-823%2FThiefMaster%2Fpatch-1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-823/ThiefMaster/patch-1-v2
Pull-Request: https://github.com/git/git/pull/823

Range-diff vs v1:

 1:  5301e3842e ! 1:  d398122a6a ci: fix inconsistent indentation
     @@ Metadata
       ## Commit message ##
          ci: fix inconsistent indentation
      
     +    While YAML allows different indentation styles as long as each block is
     +    consistent, it is rather unusual to mix different indentations in a
     +    single file.  Therefor I unified the file to use two-space indentation
     +    everywhere.
     +
          Signed-off-by: Adrian Moennich <adrian@planetcoding.net>
      
       ## .github/workflows/main.yml ##


 .github/workflows/main.yml | 56 +++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 44e0fe5839..30425404eb 100644
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

base-commit: 675a4aaf3b226c0089108221b96559e0baae5de9
-- 
gitgitgadget
