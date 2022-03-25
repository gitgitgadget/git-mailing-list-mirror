Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317F9C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiCYTdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiCYTdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:33:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A42421FF64
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:08:05 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k21so14936117lfe.4
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ni/60Mv4uWKLKflXE0xZb42bD94anDEk7EcD3shqoOo=;
        b=n4kSApmW2pjQmHuEDXtcHfAIGeKYVlXWlhWsayKbtzFeZkgKHQTGD8MI396NbzdJom
         YEYl3m8z/MFbK/HifmJCV3SC/1Kquen1QP+uWIiKne535s8L5OjkxE/1EsmTwpq3GhjU
         h+jstjfEkcq75WqknyUnUAY7MPMHiFBx+n2pV34Dxw6cBkOAWpFtuZv2FYwPxr3hMw3G
         G0XNawYN+2KTJUcPOLoTvLEEVaQWLdE1noyRSTdO5+zvU8WRyKfDwHdd0kdKILIqT46G
         5Vy476K8eKL/29gxhJU8KYULmrSg8WGoa+Z7U7cHjCKiEwdsbXXCG6CBPLBluVJ15Pcg
         C0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ni/60Mv4uWKLKflXE0xZb42bD94anDEk7EcD3shqoOo=;
        b=NKS/cl8ucVxszX9OIYx5T8ozRuLlnK5UAvYct7qCfE2ZQbi8lVCSLNPMuV5hc1Vyqa
         zXzKi30i1hPlwhEq/WE30GfgETYfzyHUrQK0yrQUcHn+Az628hj0HZz/oDH7eewmUAB4
         WZn0xyOqUILviZq/NcZ5y0EVFHQM1ETHYZTYexMrCIjijgsEwI5HRCq7bz67325aiEZP
         11Qunh8MgYsbB7s309jYkIGQbhJpKmhqU8KMPcIxinMuaY3uLiTjNB7yueQqcDjtUxxV
         E7dI98uxw5T+18RIhm5kRww3pzJ3Qi55mCAjpHKQYYtSBv3X9avp0bhuEec5srmd/IcY
         ib9w==
X-Gm-Message-State: AOAM532d3LT5gv51UJyUryjBlN0vbwL7UiaJa4iVD43n/k2O9eTJ4XgA
        i4Gde3shFGwGkRpEG3Hv00yM04c5SSn7cQ==
X-Google-Smtp-Source: ABdhPJy9usVQeCeylj2/7fwix7XmF65mTsS9MfLhgh5bpdhshN+PnATwK+nmS/JRLklIDKf6E9BLKQ==
X-Received: by 2002:a5d:6c6f:0:b0:204:555:73cf with SMTP id r15-20020a5d6c6f000000b00204055573cfmr9939312wrz.24.1648233522392;
        Fri, 25 Mar 2022 11:38:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:41 -0700 (PDT)
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
Subject: [PATCH v2 25/25] CI: don't use "set -x" in "ci/lib.sh" output
Date:   Fri, 25 Mar 2022 19:38:16 +0100
Message-Id: <patch-v2-25.25-6dc96ba8b82-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "set -x" from the "ci/lib.sh" output. Before preceding
commits the logic in that file was much more complex, and likely to
fail in some scenarios.

Now we only task "ci/lib.sh" with setting various variables for
subsequent steps in our jobs, so we can start emitting more tailored
debugging output, which makes what it's doing easier to read.

This change also changes the output of the "ci/print-test-failures.sh"
script, since it's the only other user of "ci/lib-ci-type.sh". In that
case it's also helpful to know what "$CI_TYPE" we're using, as that
script doesn't "set -x" and will act differently depending on the
$CI_TYPE.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib-ci-type.sh | 2 ++
 ci/lib.sh         | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/ci/lib-ci-type.sh b/ci/lib-ci-type.sh
index bd6e093c8f4..6cfe58596d2 100644
--- a/ci/lib-ci-type.sh
+++ b/ci/lib-ci-type.sh
@@ -6,3 +6,5 @@ else
 	env >&2
 	exit 1
 fi
+
+echo "CONFIG: CI_TYPE=$CI_TYPE" >&2
diff --git a/ci/lib.sh b/ci/lib.sh
index 663cbdef9d1..304380958bd 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-set -ex
+set -e
 
 # Helper libraries
 . ${0%/*}/lib-ci-type.sh
@@ -11,12 +11,16 @@ then
 	echo "need a $0 mode, e.g. --build or --test"
 	exit 1
 fi
+echo "CONFIG: mode=$mode" >&2
 
 if test -z "$jobname"
 then
 	echo "must set a CI jobname" >&2
 	exit 1
 fi
+echo "CONFIG: jobname=$jobname" >&2
+echo "CONFIG: runs_on_pool=$runs_on_pool" >&2
+echo "CONFIG: GITHUB_ENV=$GITHUB_ENV" >&2
 
 # Helper functions
 setenv () {
@@ -39,6 +43,7 @@ setenv () {
 
 	if test -n "$skip"
 	then
+		echo "SKIP '$key=$val'" >&2
 		return 0
 	fi
 
@@ -50,6 +55,8 @@ setenv () {
 		# itself.
 		eval "export $key=\"$val\""
 	fi
+
+	echo "SET: '$key=$val'" >&2
 }
 
 # Clear variables that may come from the outside world.
-- 
2.35.1.1517.g20a06c426a7

