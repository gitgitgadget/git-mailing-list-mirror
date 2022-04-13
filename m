Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46405C433FE
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiDMTyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238470AbiDMTyX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB892FFED
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i20so4096212wrb.13
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/yGc/HrvdckN1BUvUV+axxJi8hTlsjJOnGca9LoC2ck=;
        b=Ap6btNONvszB0zRzMUidDHMZ0qeLO9urqFUpG6knMt3aRsKrr7gBUUQoQF/zK4+mbz
         XCdCjRRh5chOLsf49Oy13aYJnfqOYXsTXzutozQ2Vp5KgYLqxKJIEaMCywQGq3e59Ga9
         DiClBvwc7o/1yGzrehn8KMsHKKzVI4milbpmGZ+5CePMgPvbJatiEmaBGWwYvoXGyPuY
         Aiw20W9tUfOJmsdJ6YqRZ7z01UnpVTyUopwN3QthdpC7UyzcpcTn+/6D3xWZbsxPTcAP
         shtAoa8IrCT+gtIItf6Meln3nWB4hmd7jlE7Or7DGq8wRwaHBmeQQodfEnnSdHylBkwZ
         YTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/yGc/HrvdckN1BUvUV+axxJi8hTlsjJOnGca9LoC2ck=;
        b=n0az3aeciWE2pwskrUBsrM9rjjjQ+xa6B3LcLiRxWgXm6T47NtQNkTmlI0H5e9BS1c
         JBrrtgnmPJ5qF/sTfClfGqCUv4TjKOso4KfySrGzPeVFqB6qTdMrrZllsTSEFBkT+jav
         ikj1UbKeHPfJXANmUQzjjlAMdKZ8nOa+ptHWSpL2jOcXsquXtiJ3WEVKqh6iIOYE24TF
         AaL3jJ3aRxCQgGIET9EL6Vk+tgMsK+CANIDib7O5HJLjplnzxDmK3iKK3dIydBgwdhwU
         /8SN/MLIUMVuInmFsbunbWl2QeU3+uYB6zIssNB9zXo6v349OiF8LFP/SDW42lrbV7/v
         zfTQ==
X-Gm-Message-State: AOAM5302hvm4vn8xbLgqQuBl0sbIcAwwzGLFD+ZOJMkSWhHXtKNgPiCP
        L2MvX52N0QZ5SgLqV8mp9gljyvYsDTAdhw==
X-Google-Smtp-Source: ABdhPJz7amvG2x2NIwVQM8mVRCXuhy56bf3VDQE75K3cSCxNRBuq9a5fmmzYyHBCI8jnYNaUD1WhSg==
X-Received: by 2002:adf:9bd5:0:b0:207:a2a6:636a with SMTP id e21-20020adf9bd5000000b00207a2a6636amr343384wrc.480.1649879519627;
        Wed, 13 Apr 2022 12:51:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:51:59 -0700 (PDT)
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
Subject: [PATCH v3 06/29] CI/lib.sh: stop adding leading whitespace to $MAKEFLAGS
Date:   Wed, 13 Apr 2022 21:51:19 +0200
Message-Id: <patch-v3-06.29-30968e36bdd-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a8c51f77d16 (ci: clear and mark MAKEFLAGS exported just once,
2019-02-07) the assignment of MAKEFLAGS was done up-front to
future-proof this code for the bug fixed in 406f93ae488 (ci: make sure
we build Git parallel, 2019-02-07).

But since 4a6e4b96026 (CI: remove Travis CI support, 2021-11-23) the
--jobs=10 has been an invariant here, so let's assign --jobs=$NPROC to
the MAKEFLAGS right away, this gets rid of the leading whitespace from
the $MAKEFLAGS variable, as it would previously be empty on the first
assignment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index c4b829c1eed..21c009757f4 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -26,17 +26,19 @@ check_unignored_build_artifacts ()
 # GitHub Action doesn't set TERM, which is required by tput
 export TERM=${TERM:-dumb}
 
+# How many jobs to run in parallel?
+NPROC=10
+
 # Clear MAKEFLAGS that may come from the outside world.
-export MAKEFLAGS=
+export MAKEFLAGS=--jobs=$NPROC
 
 if test "$GITHUB_ACTIONS" = "true"
 then
 	CI_TYPE=github-actions
 	CC="${CC:-gcc}"
 
-	export GIT_PROVE_OPTS="--timer --jobs 10"
+	export GIT_PROVE_OPTS="--timer --jobs $NPROC"
 	export GIT_TEST_OPTS="--verbose-log -x"
-	MAKEFLAGS="$MAKEFLAGS --jobs=10"
 	test Windows != "$RUNNER_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 else
-- 
2.36.0.rc2.843.g193535c2aa7

