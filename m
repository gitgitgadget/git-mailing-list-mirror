Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ED6C43217
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiDRQcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346259AbiDRQcL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF9530F6C
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t1so19146527wra.4
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ODOnnzz65rgW/ttu9uH0kNNaOTMsoOW9ZZC6NMN824=;
        b=ipfSsmxvbczHw9/wfa7rGyDQPo62HO1pg4DrxiJm4mGh4DlnyaYwmJK/OD25NatJNC
         1OUD1QRX6Fkwg5wGsg34pvoBbpArfzO5CqzwVAx9PBfQyMFSDvpoE78mzEwvy47iha/8
         DD5SOFm+R7Au6+XZjeT9Vipfazt2brK+KNduLXch1j9lFrZH8vRrbI+EDUL6ZvjpUPNa
         sBw4Q6hxjbsuWntDhW2U4rLYIZg62MWwEy7ZRmtsSFF5gKmjzpXVCxkO1kXTBLF7ZM6q
         zOu9R2+TDKeADX3p1nhsgg3nw8mfmZtanwC7rx0OP+nAsgwy71gZmM79pmMTnsDMsz4C
         T/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ODOnnzz65rgW/ttu9uH0kNNaOTMsoOW9ZZC6NMN824=;
        b=WqwxsqW7uoXUhRgMKseN09kwd2pZtBdGXyX2fZ5w3cHH1kz05LS9q6gJUTjU6FBklx
         uH+Tf3kiFdE6XGtO+HlUhjzJTggwhKbTc1hd6qpacAIOfdUHO6Fr7SM9IhAbPhj9Hny/
         IQjK/KE47VGOHUVgCTb5wIchSKoX3dSgMEi3CKijJglAqjTGC//YRQ1fF5ySERwsrSnX
         xW5P5ckYRjn3bKzs4VWaLChhILHugdPlZ2S+ZeUid7lDc0ga4hNwLAHUhsQRog/w3zkD
         Wf475uNeZLz8m7QBpO5JD6p7KlYKqGrF1wVsgt0I1qACJ5KcdxpPkWczpuyFRaaTxeGy
         M9tQ==
X-Gm-Message-State: AOAM5314zgqq74sZc6F8ljqhhb0c+8o+QvetXrW2JBqNWDJ7IBXKFu/W
        66DC2s4QT8ADreZyHahjhhSxbTnjdQSWDw==
X-Google-Smtp-Source: ABdhPJxW1m9czFRXdIVBEb5/DxanCInL02oAmj8CFSHeRcB0kVd+0BnPLBi0sHTfrhcvIXXoT/jgNw==
X-Received: by 2002:a5d:59af:0:b0:20a:8428:1902 with SMTP id p15-20020a5d59af000000b0020a84281902mr9334576wrr.282.1650299366765;
        Mon, 18 Apr 2022 09:29:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:26 -0700 (PDT)
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
Subject: [PATCH v4 15/31] CI: check ignored unignored build artifacts in "win[+VS] build" too
Date:   Mon, 18 Apr 2022 18:28:52 +0200
Message-Id: <patch-v4-15.31-bb335d1c0ca-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
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
2.36.0.rc2.898.gdf6bbac50ff

