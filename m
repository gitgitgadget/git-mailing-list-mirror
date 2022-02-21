Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D677C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378392AbiBUOsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:48:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378341AbiBUOrt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:49 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B490C5FD3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:13 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id f17so2625980wrh.7
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=96GQVmOc+Lp4rHTNgKypfRY7NVX6k42s+v36CMB1BUU=;
        b=Mp26aO4irXEDyG0CxGwORgpLYMfJu+PYHL+IwJHJbOzpC/uAXDeBIo1nYfRhu0gg6w
         wrG4WPoUbkmKEhqFWg8XWPwB7z36AHHXMAZE4NTOQSzRw3sc9DUejYbi2gAEVefPihbl
         4YvBs+Z58Sm+Eko6jqj2DeiY75BTc9P+Zmqk0YArtNIfjjSawS7YryQHTNaehvLcXEL/
         01elDVp82p2H35PUMwhVURc2SjAm1ZIpUuBOrlLEyqrKmV+AXXQHcZxfI5hPsA92LqEJ
         AjfSILz6t6/+FLyfeDaXMjj0Pnj/OGYkiwBzpsl8O4Xuyl5xtEoEYClUoP91s0Ez2cwR
         BFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=96GQVmOc+Lp4rHTNgKypfRY7NVX6k42s+v36CMB1BUU=;
        b=BoHUFUXsmNIebLpfMEe7lXiKi2egOJerIQrmXVCuDqFZnTXhJgdszwfwSOG2IO8im9
         4qBhlnndK8c3vs9PoSUid7VO90EknkL2oC5dwRwdmgGvTgtqrcvnTxP8P4yrS5VOyVGB
         2y+KEHiwBVjuV168d6zsx3xxtBp9tEkXW9rsVxZw2NypgfK9MNWTg4TdIueiPox0rAQm
         7ejGKWx9iQ3LAPcMmItQoseUXg0WVgCJIw8rLwL+zVP4MLLhlzh+f584P88RDZ13Wfnw
         vKr8BxsL1ykiCfbjmrYOroBi2ExFnkgle9qaoRKd4T6V+lX6zsOd7hhuDFh0qTzsJvFv
         eMmQ==
X-Gm-Message-State: AOAM530vZO0F46bsrXf0YgPu/LSx9gJ2P2/nc/pZtzYPrhKHI3DXPIR6
        GQhHv3Uu+4Tf1rg0rEqQcgwbp+b+ywdGmg==
X-Google-Smtp-Source: ABdhPJzpyIFozljz+0zgHrbbO/z0jOmBUG2cbn1BSt31GpWS56v3lSTPMCH3Hy+az8hI9BdzvITaFw==
X-Received: by 2002:a5d:4292:0:b0:1e4:b7fd:eb84 with SMTP id k18-20020a5d4292000000b001e4b7fdeb84mr16217466wrq.657.1645454831571;
        Mon, 21 Feb 2022 06:47:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:47:10 -0800 (PST)
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
Subject: [PATCH 25/25] CI: don't use "set -x" in "ci/lib.sh" output
Date:   Mon, 21 Feb 2022 15:46:37 +0100
Message-Id: <patch-25.25-08a9776c259-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
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
index 36f79eb6a65..f4323a3dd36 100755
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
2.35.1.1132.ga1fe46f8690

