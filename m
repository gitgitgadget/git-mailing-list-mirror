Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FC3C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbiDMTz2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbiDMTzP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:55:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795587B12F
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q20so1757961wmq.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uUOquCtDFxghbCgPJPLdp/jLF8/rM7kXCG1dL4CcXUs=;
        b=idkXoN7uMqxXA121f5cuF/Tw7ThRGJE8k8vp9FjRdtpPgq4MF3cvoihZ6uBZMv9ho0
         4UD3C3tUJ2pH80PskhFW/16EGXWzPScXRigfU3ZLvEKWEyC76Qo8aQ6CJc3pxlxEFhDP
         KKIZANCtNOgGqOYBS+XpqyGHNBO2cyQrMs0KRSQLOOQklcAPP9uIew3zewT32Ci194Pg
         X1S0Eu8xW9BP/bq3JusfgbSfoI8dbJ4hZT0U65PvnFC4XssU64jTAUZcn2wezHAmVt0d
         9Odi4HQ+y3Cz7ob7+0jesZb3tl0e/0ulK+5XeuTdXj3ktjFFUk4CEPJupp3+0N5Xyzoh
         mwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uUOquCtDFxghbCgPJPLdp/jLF8/rM7kXCG1dL4CcXUs=;
        b=BEJllewv7UY/H+6T5Zs1mei1CAXE0oXAR3XmBiKoC5o0Gjio3FRecBQoRk8kG5W8fF
         CztdVeW1Sro+Iu5VZIv4BGhnS5ec3dhuawPLcZkWWI5R7RDpMV0XoIWEwvj16IctVYkM
         wIy9QDxHY5FhavjzHiTHGU27SySTISMhdMvQCh9/VJJ5cxEMn6+CZaFb7He6qf8aS/Az
         6cO646kDiiZPhctxvKAbkSvQiXSTIRBpjVel6R4DV4IbX2rXHEcu+2uufty9x7fpnnGt
         TNewSiI37LGuVBi2bFnEOpNPeSC4MxAr2i94XujpBsIkIR7Js/YDqlISyf/9qyNDIQQp
         7+Vg==
X-Gm-Message-State: AOAM532AQqnkm3B2W0CzQSn5B3TM1UGxOYtTxt6Jbk8fnv5UIhAzIcyR
        xK2ApDnhB5a7QWyW1WDjYO39XM2AItgDwA==
X-Google-Smtp-Source: ABdhPJwxIDiQza1qB8mIfs2KoAb88akG6mhsJ8cjHaDupkiUkCwGoAKNFIVcFH93iJW1Ihg0LGEipw==
X-Received: by 2002:a05:600c:35ca:b0:38e:c3cd:9692 with SMTP id r10-20020a05600c35ca00b0038ec3cd9692mr293534wmq.102.1649879541404;
        Wed, 13 Apr 2022 12:52:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:20 -0700 (PDT)
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
Subject: [PATCH v3 28/29] CI: don't use "set -x" in "ci/lib.sh" output
Date:   Wed, 13 Apr 2022 21:51:41 +0200
Message-Id: <patch-v3-28.29-c0ce0fd3a80-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
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
 ci/lib.sh | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index d62cd757ef4..94f83069884 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-set -ex
+set -e
 
 # Helper libraries
 . ${0%/*}/lib-ci-type.sh
@@ -18,15 +18,26 @@ then
 	exit 1
 fi
 
+# Show our configuration
+echo "CONFIG: CI_TYPE=$CI_TYPE" >&2
+echo "CONFIG: jobname=$jobname" >&2
+echo "CONFIG: runs_on_pool=$runs_on_pool" >&2
+echo "CONFIG: GITHUB_ENV=$GITHUB_ENV" >&2
+if test -n "$GITHUB_ENV"
+then
+	echo "CONFIG: GITHUB_ENV=$GITHUB_ENV" >&2
+fi
+
 # Helper functions
 setenv () {
+	local skip=
 	while test $# != 0
 	do
 		case "$1" in
 		--build | --test)
 			if test "$1" != "$mode"
 			then
-				return 0
+				skip=t
 			fi
 
 			;;
@@ -45,10 +56,18 @@ setenv () {
 	val=$2
 	shift 2
 
+	if test -n "$skip"
+	then
+		echo "SKIP '$key=$val'" >&2
+		return 0
+	fi
+
 	if test -n "$GITHUB_ENV"
 	then
 		echo "$key=$val" >>"$GITHUB_ENV"
 	fi
+
+	echo "SET: '$key=$val'" >&2
 }
 
 # Clear variables that may come from the outside world.
-- 
2.36.0.rc2.843.g193535c2aa7

