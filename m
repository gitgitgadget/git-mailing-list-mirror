Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B2C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 09:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiDVJQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 05:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445860AbiDVJKm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 05:10:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF5F51E6F
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:07:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b19so10066557wrh.11
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+bQhLruQfu0QMEBdy0MLoIlVUUI5gfHyK6CrPxfQVU=;
        b=jX4iNOQVo4QZoHgs8MFA+TQBnHazEwPoqICcbd1mKyx/cpvYjA+6e7P5d0oe1ADkHO
         ep3+E0Be3sEQoTaX0sIiCtiteONk1PZnHA4vK0kO9y4DrcsTre/kzdG7OMd2xBuzYlHE
         GGhmd8n6qH2S22aL1j56vQ31Ptit5WHU/F9dUodf18MEkqTeiABUZG+A8bG1i9+owsrC
         43COy3v72RGR61wGtj7R3gag9wI97Xg5IH1PcgzwFqPWygjSFT+1Ft8tQjbiIgqMndAT
         SVfiBJVTIZ+J8dINqjvHE8MByb0fV1rzVWNSSPYKC+G4/tmRx2ZXMXMZtgD72sp+UcQJ
         QFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y+bQhLruQfu0QMEBdy0MLoIlVUUI5gfHyK6CrPxfQVU=;
        b=voXM4vpNATMPz5ufQhMLE2zkJi4mWYD8+IfzexFQxM2pfVFXVdSdTYXROoh+T0ur76
         AFdvSO1OwRlqnvJkZqxfQVccOd8Ee0bOoUW7UW8wZ97KCsE3HiKHKPLBjXKMeh+kHfuD
         5Z4u6589RIt7uQEntemjT6qXJYm8sM0/qCNiYcelJ/kREIDizI24Bfq1f43YygR4dn5x
         JXmljvk6Z41hz4WV0GM2bFCwSUkX8JpqdEgiyEdYSBDaPkjCVKJ7E8Yp/91dYT1N5eMT
         4wxdoPIkk6EeHgWVFaYgQl9XqaOCY+0kfmXq3tH3roLorbBp4ymJEWiJaB91C5s/Sd8q
         YChA==
X-Gm-Message-State: AOAM530EMgWY8+TC8Rcz/aVc6/NENKgJYpOgsUEF/z+v+BPvhDxd9TJz
        Yk3653P0gSAFqMsSSjJudeYWiLOfebp7yA==
X-Google-Smtp-Source: ABdhPJxi1ifm0mXGpQrrt7n9x2b7ZIjvw9apFD3IH352UwUv2qhzrSpZi3Cqbm04U5Cuw3FzdF5sqQ==
X-Received: by 2002:adf:fb82:0:b0:207:8b12:8d15 with SMTP id a2-20020adffb82000000b002078b128d15mr2813952wrr.1.1650618465871;
        Fri, 22 Apr 2022 02:07:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n68-20020a1c2747000000b0038e6b4d5395sm1282700wmn.16.2022.04.22.02.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:07:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] CI: use https, not http to download binaries from perforce.com
Date:   Fri, 22 Apr 2022 11:07:39 +0200
Message-Id: <patch-v2-3.3-3fdd54aa8df-20220422T085958Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g56a83971f3f
In-Reply-To: <cover-v2-0.3-00000000000-20220422T085958Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20220422T085958Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 522354d70f4 (Add Travis CI support, 2015-11-27) the CI has used
http://filehost.perforce.com/perforce/ to download binaries from
filehost.perforce.com, they were then moved to this script in
657343a602e (travis-ci: move Travis CI code into dedicated scripts,
2017-09-10).

Let's use https instead for good measure. I don't think we need to
worry about the DNS or network between the GitHub CI and perforce.com
being MitM'd, but using https gives us extra validation of the payload
at least, and is one less thing to worry about when checking where
else we rely on non-TLS'd http connections.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index cab6e04a358..00154a8ef45 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -5,7 +5,7 @@
 
 . ${0%/*}/lib.sh
 
-P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
+P4WHENCE=https://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
 UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
-- 
2.36.0.879.g56a83971f3f

