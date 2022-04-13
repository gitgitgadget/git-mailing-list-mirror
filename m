Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C599DC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbiDMTy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238507AbiDMTyc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E285DA2F
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:10 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m14so4139632wrb.6
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=60nuax5qO5z26fsccBFDrD10fZ/skSnVsCvFVqk18V0=;
        b=dpNmaWMK4SXgA6Vq1ia4Mtl9B61XJFGaAoww3w4CpOyHk2Fn8mQqNVcjfqk/kXMp7d
         zhwO0ufChPzKim5RHb0tZa5ld6RF8b4PnlGRJdJ4h5OkUoSAzcX1lZoIeDH1ueZN/Loq
         3wAkrzmyR7i+JV0fvLZ88NfbwWxGQurRqMHwyZZ8YwhNCutFhTN+FZpmBZIlp0f51MZv
         rTSMUvwfYtB2Y93wRwqi6RJOXgZpVB5JweOoZO7Hp7PNcIuCgIWZTAVD6NSISRzghAh8
         71J7p5aKJX13AJRDpZHZ4G0Uu4ameSSyqd4Kk+WkQFcVecHebi6owGntJ1ko5JSrZsU4
         GRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=60nuax5qO5z26fsccBFDrD10fZ/skSnVsCvFVqk18V0=;
        b=nsmkpVQ72AoV8kQK9z3eU4S8VPT3QS52Woa8CNoFcRpHlaTgMmzdc6PP7N7Iw7CWBX
         WTxhbwUW+qQapqDQlVuOmuLUARPlw7h2n9DZnMRgJAAFZ/KXqkW73++srVcAxpOkFxPQ
         +ICFYSMpqQ72tI4cY81X5/G7W1sFhcPW5Efom09eoNRKpoVmD0iOrSOlxiz0o0G0sd9F
         kCRrB1FZSUZACYjwWubyZzfDdIJ/EA9htowKGQr4B9fyAb4I979G7pfrXY+EMCJ6oK/y
         w8SeH/rIcFKrDcobz3bwWcbHtIKEGRf9OpYy52CSYKJh83PdHFMfrAWtSBFifg2l9eMp
         2BCQ==
X-Gm-Message-State: AOAM530wb42fW7UBq4oGw4yVGVPRYmxTtetEzbwF2/bo3y691pHoUXz2
        b0t0UphmH0aMITVG37r7aB8CE7diOfu9DA==
X-Google-Smtp-Source: ABdhPJw2WPQt0uixF5hFFzuCHEbhOsT6HcbKhnRsDY4tOQEZp5ELMASH/Q6/IRIlpnRMbWpfj59Bnw==
X-Received: by 2002:a5d:5144:0:b0:207:9a13:ca73 with SMTP id u4-20020a5d5144000000b002079a13ca73mr348951wrt.268.1649879528592;
        Wed, 13 Apr 2022 12:52:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:08 -0700 (PDT)
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
Subject: [PATCH v3 15/29] CI: check ignored unignored build artifacts in "win[+VS] build" too
Date:   Wed, 13 Apr 2022 21:51:28 +0200
Message-Id: <patch-v3-15.29-d63a689eae0-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
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
2.36.0.rc2.843.g193535c2aa7

