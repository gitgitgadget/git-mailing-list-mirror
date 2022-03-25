Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BB3C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiCYTbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiCYTaj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:30:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B691F6350
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:05:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r64so4961151wmr.4
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/zu4Ri0FzFML+LGZrmI+mnsvudSjKmPJ/DnfzzXsn8=;
        b=d7vaIBja9gJIMikPmD8keh8E0NrTLtVspbx9jiPNGgWlZYx6ljmC3tFebEwBbBSIUS
         z8vYmh6gU5FLsfR597ZAhij6r7WFLZQ9PDSK7kiNFXgfWlCg3veduxUsjhG9KxVfjtn8
         e3tgq0opI9Mwx4EmMPYSniDbWz6luNGwBfk9mNt1AR9Ml41xWU7FsJixSu4RSkPgJERy
         ZkTF/AitoelQoOMHhoJamR5UwMM1jfMVY8c3S9FD7Th19OxnUTf8Q8tceJ86aajC7duf
         2g88R0cx/fiC+av9ReFlFtQGjwf6GIKE0PnpttZyjZpQjMvAF0DPMe7/NQemSTgFQobw
         Dt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/zu4Ri0FzFML+LGZrmI+mnsvudSjKmPJ/DnfzzXsn8=;
        b=y7lNEGD6zfTCceBncEZyX9+Z9iEl4Ev1tEtvCPi8bHmi0fpMX9NKVpRACNLD2tY90K
         7d63HG0XOzukpvnfQ5iBH8YIfk0rk6m8R6d3sF6C/rOW1jIjO/FrzFsUfmj6oEMLAzNc
         Haa2YDRXHqXBihAjDQv3/8vKSeUc45WSkYZBKVV/lHibPnzSM+NpMh7uvnCf4TS1VE28
         4Q95xEcaMAQDZ3fdLR6F/Y73lqwlpdAW8VNUWFvoK9MQQV6vx9knh0S47AimhRxM8Wl0
         ITE81lKUScmDi0Jep0k22gMVUJiM6OSOAdEzc6k3uRQCleYwOITHh2DaGz1R929jz8CL
         XNjQ==
X-Gm-Message-State: AOAM532SEHR5KBUn9FPtHHSbLATlfzR4y4J2/ShFOgoLPcyENnT73z/u
        8kSFxW/bUjMO4j8TXh4Zc8OdsRvT36DWuQ==
X-Google-Smtp-Source: ABdhPJzBbvdIVIlhxHLzG7GF9EqGpWwJnHd/VbWp/RdZXlVRrd7LwbN7BrIvyQc98WAER6SqUg5IRQ==
X-Received: by 2002:a05:600c:1e83:b0:38c:b028:9c44 with SMTP id be3-20020a05600c1e8300b0038cb0289c44mr20280920wmb.162.1648233511409;
        Fri, 25 Mar 2022 11:38:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:30 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/25] CI: check ignored unignored build artifacts in "win[+VS] build" too
Date:   Fri, 25 Mar 2022 19:38:04 +0100
Message-Id: <patch-v2-13.25-649ad1ae249-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
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
index c83f6a21ca3..05c5771e7f6 100644
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
2.35.1.1517.g20a06c426a7

