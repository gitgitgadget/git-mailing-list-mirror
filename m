Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300EAC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391434AbiDUS2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391358AbiDUS1R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:27:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEF04B861
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:24:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t6so4408058wra.4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ON6D6lRakahV8Zg3e4cgHJbiblHbaUon+oceq5fedTU=;
        b=dDAWrQ4MqujZXc4igqBgdcfuHauRcP06IYW2veHHOqFJNUpJtSmqNjMai89t3NbiNT
         Lh1hzuo5KpKCs1I/7AEgGhc1LSPZ6uHOK/K+E3r+hCGic1W8n4I4WRP7no4uCP69QVR0
         ZuuNEnjUkrhKNrvNEB0QYgyBhlcEbPjsT5phs03iP24Uy+6ZpA9T7UltBwKvTwKxPwFy
         2OKWwyd5GO5DdDJk4NLDF3Ej88VYMRcAfaewfLptOyHtJnuGlfPh2ioLOh/u+TAx2WSe
         m8yWmqOH3nJh2aCiHK+HZz4KnmvQ/mfqYnm5ONV4T0eaWW6pNj+z5k9+7HWxwYOSNI5Z
         VcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ON6D6lRakahV8Zg3e4cgHJbiblHbaUon+oceq5fedTU=;
        b=i5sEqoAoi4+GV68reJZ/b8sNr4gFVWPAZ5p3aINgR05YE3KN68ruI21ei4m7fv59nN
         L1DwuZ1uX3gq5tUdm1dcGNoC+cv7G6rw9kDkKkjAD45XoRhbWn3tm//TLXJfCNlgm5Em
         wIWyzJvxZEIgGsVi7zzfykT8h5E1vMAKYH5xqJHbA7m7MRxj0jd+NvEsdBDbk1DsQGf1
         7f3ggJA+gfFj/2o7DrijqO5ooCoBGwyPl1qalZpOeQK2AM64MOR59gkHxQlsE0vMLVza
         tmmluygxpvqwjpnfg4gewI5m6RstjSCr4Lsz+9AmFINq7cl3cMSzkQItkbOQYNUFiqVJ
         t+Eg==
X-Gm-Message-State: AOAM533bV5Un8UwTDCGP5gQdmaxCWB7q/2Ppjz+7rs+nVUKk1DFmHMDV
        Oa076sJQ0Ai7hH/rbrghlz/RIykElPS0Dw==
X-Google-Smtp-Source: ABdhPJw5VtAEmFxolSFGluAlfj1SeqLAHC/6vXO0xM8hV4RJpscVSpGHFkWOJ6fCTfWyTqeC1t7ODg==
X-Received: by 2002:a5d:49c1:0:b0:20a:a65b:4648 with SMTP id t1-20020a5d49c1000000b0020aa65b4648mr715746wrs.707.1650565438374;
        Thu, 21 Apr 2022 11:23:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:57 -0700 (PDT)
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
Subject: [PATCH v5 24/29] CI: add more variables to MAKEFLAGS, except under vs-build
Date:   Thu, 21 Apr 2022 20:23:19 +0200
Message-Id: <patch-v5-24.29-a4e3a9d2c28-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's clearer that "DEVELOPER" is a flag that affects the Makefile
itself in particular if it's put into "MAKEFLAGS than" if it
generically sits in the environment. Let's move both it and
"SKIP_DASHED_BUILT_INS" to "MAKEFLAGS".

We can't do this under vs-build, since that invokes cmake. Let's have
only that job set these in the environment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index c875208817f..c8cc37c50b4 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -89,6 +89,13 @@ COMMON_MAKEFLAGS=--jobs=$NPROC
 # Clear MAKEFLAGS that may come from the outside world.
 MAKEFLAGS=$COMMON_MAKEFLAGS
 
+# Use common options for "make" (cmake in "vs-build" below uses the
+# intermediate variables directly)
+DEVELOPER=1
+MAKEFLAGS="$MAKEFLAGS DEVELOPER=$DEVELOPER"
+SKIP_DASHED_BUILT_INS=YesPlease
+MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
+
 case "$CI_TYPE" in
 github-actions)
 	CC="${CC:-gcc}"
@@ -105,10 +112,8 @@ github-actions)
 	;;
 esac
 
-setenv --build DEVELOPER 1
 setenv --test DEFAULT_TEST_TARGET prove
 setenv --test GIT_TEST_CLONE_2GB true
-setenv --build SKIP_DASHED_BUILT_INS YesPlease
 
 case "$runs_on_pool" in
 ubuntu-latest)
@@ -145,6 +150,9 @@ windows-test)
 	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
 	;;
 vs-build)
+	setenv --build DEVELOPER $DEVELOPER
+	setenv --build SKIP_DASHED_BUILT_INS $SKIP_DASHED_BUILT_INS
+
 	setenv --build NO_PERL NoThanks
 	setenv --build NO_GETTEXT NoThanks
 	setenv --build ARTIFACTS_DIRECTORY artifacts
-- 
2.36.0.879.g3659959fcca

