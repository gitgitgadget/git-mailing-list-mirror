Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5B1C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 19:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbiGNTkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240612AbiGNTkA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 15:40:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20CE1007
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:39:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c131-20020a1c3589000000b003a2cc290135so3656017wma.2
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VXcQ/XYGJF9+zRwBf2FIM7RUWzPBNwae1i2D7wouGU8=;
        b=hntpwM2c6ub2UsFYm9kd5z6w1XvfnJXIQM7IecNuuVqvgWc3kLVH+Hpg26/nRSuTAk
         xhcCU4ZgmdWecvAmA5jrL6JolbsFoCeInyO0R9ZCtvFV/PhIoyQmUvjGSFqdDynLyW9k
         uF7KFLMxHMTOcnTrdpavZml/DmnsJiU4ItKdwcYabPhKwkrSW27n3bUdAIdFTu6XIpWK
         9Oyl6jyJvtKxkWE9QF5zmDzHDV9fmihEQ0A51rp/fUgVkk4S6jr45eTm6wp++0y/fHps
         764K/P1md0e1RVgBaw9dvuAcgXVcHhoCkKjvR3nsuS4Mq3X3z0ycC5Fnhby4QZPc+b39
         Lqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VXcQ/XYGJF9+zRwBf2FIM7RUWzPBNwae1i2D7wouGU8=;
        b=m5hkIgr4wHYQr4eVryWy2Crhx4Mz9kEVGg5gh8GqloHmKoTxToL45/4sRs88yKwYZB
         d+27UbmwTRTuMFRviTLnBjOqasHkdyVQZDwESll7diHue8GpWdtvNi3hiw40f3kGFEvj
         Nb6qYiy3MvI4MPno/ZPeNJQ86kTkN4I25NofRE7A/+tOUFanKmZodTnqMtoH1fODaKmG
         ul6/sTGI9eXtk4UKWX/qVEgaEWIPDhHN54INFuYOZZ24ExIzhW0L5l10phWQuSirEbff
         B3rFshohpgKbfyWtr0QLinwd7tGf/WeL0BLHwLasTwCH04kYw165XfRzoYUvk5JwxqzG
         mbmg==
X-Gm-Message-State: AJIora8VpuU0Gi4gUSOD/OaDuQ6nuUJmgbjHmhuRUCLSQ2EU9Gm15JQn
        MJDlc++ffz7yMPnVNmISZsqcsM4udAr16A==
X-Google-Smtp-Source: AGRyM1vmcWwx/oubAX3Hqsc7IZFjfInF8eUOBlp5LXFrIv4fJRJAeiFU5Y5fntnXrtBT/8unKPe1JA==
X-Received: by 2002:a7b:c413:0:b0:3a1:8f03:29d0 with SMTP id k19-20020a7bc413000000b003a18f0329d0mr17280628wmi.160.1657827597871;
        Thu, 14 Jul 2022 12:39:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600018c900b0021dac657337sm2145145wrq.75.2022.07.14.12.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 12:39:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/10] CI/lib.sh: stop adding leading whitespace to $MAKEFLAGS
Date:   Thu, 14 Jul 2022 21:39:42 +0200
Message-Id: <patch-05.10-ee36d4eb2a9-20220714T193808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.996.g651fc6e809f
In-Reply-To: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
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
 ci/lib.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 969ba2ff0d0..3591919ba44 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -75,8 +75,11 @@ handle_failed_tests () {
 # GitHub Action doesn't set TERM, which is required by tput
 export TERM=${TERM:-dumb}
 
+# How many jobs to run in parallel?
+NPROC=10
+
 # Clear MAKEFLAGS that may come from the outside world.
-export MAKEFLAGS=
+export MAKEFLAGS=--jobs=$NPROC
 
 if test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
 then
@@ -84,9 +87,8 @@ then
 	# We are running in Azure Pipelines
 	CC="${CC:-gcc}"
 
-	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
+	export GIT_PROVE_OPTS="--timer --jobs $NPROC --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
-	MAKEFLAGS="$MAKEFLAGS --jobs=10"
 	test Windows_NT != "$AGENT_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 elif test true = "$GITHUB_ACTIONS"
@@ -115,9 +117,8 @@ then
 		return 1
 	}
 
-	export GIT_PROVE_OPTS="--timer --jobs 10"
+	export GIT_PROVE_OPTS="--timer --jobs $NPROC"
 	export GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
-	MAKEFLAGS="$MAKEFLAGS --jobs=10"
 	test Windows != "$RUNNER_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 else
-- 
2.37.1.996.g651fc6e809f

