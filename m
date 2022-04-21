Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33A4C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391344AbiDUS1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391296AbiDUS0f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:26:35 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062EC4B1FF
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r4-20020a05600c35c400b0039295dc1fc3so3975005wmq.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1UZG2+FDX/SsTVNX2KhVttTMLEQMgCP4/6H+sdKR6IE=;
        b=YnqfQUsNVMVabBGK6GZFiHI4mQFeRXmJ+PJLnVbTT7AN7m9n1tC9rEanX7z33B+x3G
         GYgSrz4BlFuSL79ibNZ+hYIOPFpJGstCfeWhpcQceoFJUuZovOMwr+BkJ17sET1UWpbx
         SxURpj+ZBTE2TMcgxamXRjl9boIglvkEK5mcWbGkRiU8qXgzS+nOd/6V03ToOeTuTNQ6
         EZ9BoiQzsfKauftxYNzYKhaq4DtUz6ux5SsBhzfGBagBsaTVo5tIEHsa2y1cy58RuvLY
         esF3y1fq48laN1CnuWBYdwVtYNS4+1KgI2vktLsd2lWliT1/bgDZhPdQlbgEDXRdJ1fB
         aAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1UZG2+FDX/SsTVNX2KhVttTMLEQMgCP4/6H+sdKR6IE=;
        b=1k9OxNOey3Yn29Xgq+qvo0lPkxdZtZow4nbbmbNCSsYABxr3DV8/naITv2KOWLJSdb
         yLLFOUTpcaSgxP1qr8Xi4LENB2Jekzpzc49luA9rDXM983DB5usHiWnX78MkXGlLwsWI
         cB2feUoTpBeC+CaMlu4FpbUUCxxN4efmF84Hll3+nI7l+RZ6FcTNl1aojiUMtPeEsdIR
         LDRMtzDqVLQXusV0s19otL4bPqBppg7xZNNa5F5KpRNeGIMyrAeEuaUbI1MykUALLus7
         vwWUlvnj5I2Bb8JUoj6UTbsNDk6Ojb6HGq3R4/VpZaLwe3QC5ixwIuK07SDJSHJOifg7
         eHtw==
X-Gm-Message-State: AOAM5330BkLR3jhJtFqHpSvWstcssNHQvpUo2BAiWFyrWVeeCn2Gs0OB
        sIXGjof7w0qm8ZAM+83sviwpcpHqGWhuNA==
X-Google-Smtp-Source: ABdhPJzZwm0g5za1GGFcyGEe9ks2R7mya9CDhVcmmAmRIdYap6ReVqr225NkminwyXffvpbE78WTzQ==
X-Received: by 2002:a05:600c:1d12:b0:391:3cf6:243e with SMTP id l18-20020a05600c1d1200b003913cf6243emr565593wms.137.1650565420336;
        Thu, 21 Apr 2022 11:23:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:39 -0700 (PDT)
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
Subject: [PATCH v5 06/29] CI/lib.sh: stop adding leading whitespace to $MAKEFLAGS
Date:   Thu, 21 Apr 2022 20:23:01 +0200
Message-Id: <patch-v5-06.29-45ea80d0495-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
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
index a6cdcfa014b..edf26984aeb 100755
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
2.36.0.879.g3659959fcca

