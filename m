Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1F4C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241582AbiEYKHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbiEYKFC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:05:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860916E8FB
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso3019844wmn.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0/F7LWIF1Lp7TZ18EzMuiXw18x5YsnrFO3fUgX76E8Q=;
        b=MTG/KvrOWdTM3WXSACGQp93W/hclhxSVmPvnkpWvUVUmMczzRm5smA1hREQhd7eA5D
         irrNur0z+DfKNWDx8pze8B48Ri6gjSmL7YbAiXbuhZxKw00sEEFjCEzCWLU3ewur+Ntd
         VbktV0/iZ6An+pKtjduI/lDPkUe3CxaSAM9+BEcPfynlE7I6e/a8nn/Di81dFfPhMgOy
         D1M8SeZOP+BU88lP+MmCuiCyq9pYeYD+06wAaVNhbcpctkdJZhtZ2hCSU0H1I/aMTEWT
         RtBCL7epnjMB8ewpT5LbJ5JKdWo7oEmkFTY79jg/qWfK6gkByYflsPdUiivsZSmpVa32
         b4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0/F7LWIF1Lp7TZ18EzMuiXw18x5YsnrFO3fUgX76E8Q=;
        b=EJj1kblSGttVa8ObhFUWMpmF+qw1ZzA9Of8pfG18T2d1oGc7CwgpIoTGYuAyjvTTAU
         DV6CGKLjErMTr7F1ipVEXmZhffkjJU5EvdNFIZS6xgJqb7TyWcPEkW1cezDl96GEZoFn
         V3nHTFfdJllD9OfuvLPvqKUQNZPSp5tXT7Tu/w3uJSI+D/iLIy0A3ZyhR2ujDGJ20K9h
         ib0lJNsItBRBk7zx9rDqygkMLDknztC5yCEA0ieBmvfZsr0O0yy8oldFhcwcvHx5UI/I
         siLUsVRYSKbGf4H9uK9nJEV33mVunmxTeLTHuykVW5gIdc/ZiBBx4rcQqPh1szEBiHQP
         cBYw==
X-Gm-Message-State: AOAM5308HRai6RWj0rnpUes7VlpLlPBr5p31h2R8hw9XDcqk95ZO7/Gu
        jOWUZCoKGn1BxsnWD8Tjcj8VYAgDODu98Q==
X-Google-Smtp-Source: ABdhPJzdoJuVANgGbFk8cRiStrPNrDaTrbomuVZgBW1E5fI4/iLlrWZdKteMK5rbi9igZ/WogGKA8g==
X-Received: by 2002:a05:600c:3b02:b0:397:5cfb:b849 with SMTP id m2-20020a05600c3b0200b003975cfbb849mr6142877wms.183.1653473097884;
        Wed, 25 May 2022 03:04:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:04:57 -0700 (PDT)
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
Subject: [PATCH v6 15/29] CI: check ignored unignored build artifacts in "win[+VS] build" too
Date:   Wed, 25 May 2022 12:03:54 +0200
Message-Id: <patch-v6-15.29-f7ac6c33044-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
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
2.36.1.1045.gf356b5617dd

