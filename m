Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB74C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391393AbiDUS1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391238AbiDUS0l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:26:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ABD4B1D9
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c10so7864083wrb.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wXDZk42LlS9I1d/3NLMgr7fvX5h+CpA70Pot+6x9Foo=;
        b=g3Wq2qzBb1Pz7RS7J1gSZNKNYbPjQFkHc+er1elVDgLbIYxSHOQLo5C7cO9XMmN7pL
         +kGJi55AenraME0r/DdInmdcJL1Shlfk5SxVHpDUszuyMw2R++DtUOeuBjCYrWXQ92sM
         rtb6zkl8zIYp467MoJn9mk5XxU85SORMFqAufCjlrz11sO+9bgA+TFUOVnIBwmY3Vp8b
         ML/LBl5cfUltZuQwEPeGjNwhnztQ7Xpa3oFnc8Gk2AYCjrzw+KYsVC2WKPVtJg93YxyC
         OzjSQeD6NuUbANMgdO53CGg5jAPvM1hxAbaEiRiJBaT+f9QmBoPeen7rkUfM2CHEGo5K
         eaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wXDZk42LlS9I1d/3NLMgr7fvX5h+CpA70Pot+6x9Foo=;
        b=wMy89ewZV58OeIG8QUeGjRh3RvwBVk0ZM+yiCPXBPefd7XAVTpbGnxeno/SP+wIatF
         rzXHQuKz4m/ui00i//mA/MBLEvgzTeJbwgXCSViBTB1+uOS0tc6fgfU/U8lgKM7v/Mbm
         uinKX5MVpgDjDJJeFJznOQI5dc4TjpxX6Id/Jql+vVtPKy9GeOQOrl29+s5Sngq1cDI5
         6YEMo2Jeh5FNjOZESLe8t72C3yGI8QQHJLsv+WHEq5pstwHYXtfcp70TpUDxsXVUrqLN
         rdwNL7H+ECgC9Cf0Ry2ZAtWhMzmwoPN6Bb9dJdgotZUwxBv/teX9Edb4WJZxC3ZyzUB4
         oUmA==
X-Gm-Message-State: AOAM530IRy5V3pZMwKSBfZ5V2lEnPX1G9n+WI5gVvgjL0ioPKObcGt30
        tJPXmOiBFz23p3Xzf3qozzMzAe7ehwoCOw==
X-Google-Smtp-Source: ABdhPJxukkOsvtb7rs+/4GqPSM3WWNXVqAZ5VLIMOlYGvgiHsHEuJHKIjt0bHJtZpzIXnb6adnYjiQ==
X-Received: by 2002:adf:f943:0:b0:203:e832:129 with SMTP id q3-20020adff943000000b00203e8320129mr738688wrr.626.1650565429473;
        Thu, 21 Apr 2022 11:23:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 15/29] CI: check ignored unignored build artifacts in "win[+VS] build" too
Date:   Thu, 21 Apr 2022 20:23:10 +0200
Message-Id: <patch-v5-15.29-6044c2b383f-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the newly created "ci/check-unignored-build-artifacts.sh" script
in the "win build" and "win+VS build" steps too. These steps weren't
doing this sanity check of untracked files against .gitignore before,
but as the check passes for them let's keep doing that extra sanity
check.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 57b2db06923..c97fbd0f0b3 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -93,6 +93,9 @@ jobs:
         HOME: ${{runner.workspace}}
         NO_PERL: 1
       run: . /etc/profile && ci/make-test-artifacts.sh artifacts
+    - run: ci/check-unignored-build-artifacts.sh
+      if: success()
+      shell: bash
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
@@ -180,6 +183,9 @@ jobs:
       run: |
         mkdir -p artifacts &&
         eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts NO_GETTEXT=YesPlease 2>&1 | grep ^tar)"
+    - run: ci/check-unignored-build-artifacts.sh
+      if: success()
+      shell: bash
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
-- 
2.36.0.879.g3659959fcca

