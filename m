Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EE8C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 10:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiF3KTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 06:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbiF3KS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 06:18:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96E6183A9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 03:18:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so1370107wmp.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/x7feBh2xmPiVpFxAHUxj9ZZVsDk4UVzlJX+3RDN2gQ=;
        b=qpetWkL22pU3u9kS0Lbgj+ATj8XQ+ixr5AdDLbhjhHR028vkahTAXe8FNLMP3t8/Zy
         6MKabWqXkj5O9rVcNTPK1LAd0cMiI+AYQ9VBQHYUykpV0NACQgbt5gpH71/Ytr7uP8En
         Ma9CXnDpT988Kp5wNC3oKfzoy6tDJlqk1tMbiwGNqdh7laBDjb+lNKmmiweOms/utNmG
         S5guw2uzkFDPS2xZMv6J0oSPyuygSc6Dnk0y5pY4yY19jpMV+nZ+O87s/s4FEStcjzXd
         Ic1aCJAIpBGUySbAXtaK1ePPSZDSmqd2XOwlFGUeHnquioHVxTKUbNofs8AzVuDmuj7h
         ID0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/x7feBh2xmPiVpFxAHUxj9ZZVsDk4UVzlJX+3RDN2gQ=;
        b=F0TVSSwg/PXBsla/hcnVcLiZXMS5mZoTFcb69pfo1sAOe4RLeD6bvjWJhx25nXpfpa
         CzltTukK3xOGwd0r1fcwL9FTlSCjoDbeEqf2ssl0KM1xhSiVtDDzltmwWlJaihIdkRhH
         Y0EFSFnT8Zy9l8CZKMpACMzuX/lDFpTC4KkXuj6X4fKk4h9sWJpRm1TBz2HUBOeUGYJX
         ruMVaj3Wner08KM9sLnRDRVDAHD1lNOUwQLar49q0P8jc3b/I5WcZac0m1Co/iYyIYcx
         v7RU9ULIt4ChAELQiM3HC2kZ4cgBAJ6+ZwLTFUIthoPX14t8Ou+yr78hfiQOMJqC/Z1H
         2x1Q==
X-Gm-Message-State: AJIora8GmKYsH1EUZCUzoMF1G9xD8BEaG34FeIH7FwpcYhyifirMs9sm
        rMDsy7qDUOKaiXMslFvkW3Q5hzfK4yDA1g==
X-Google-Smtp-Source: AGRyM1s8v+L74a8KaAuPIg3CCWXa1W3kZxV2vpVyNDjK+CN8Als0436QN3eUp3ILp/AZx2hfp3nz1w==
X-Received: by 2002:a05:600c:a14c:b0:3a0:4ddc:f710 with SMTP id ib12-20020a05600ca14c00b003a04ddcf710mr10882477wmb.38.1656584335045;
        Thu, 30 Jun 2022 03:18:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bcb81000000b003a05621dc53sm5978427wmi.29.2022.06.30.03.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 03:18:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] test-lib.sh: fix prepend_var() quoting issue
Date:   Thu, 30 Jun 2022 12:18:35 +0200
Message-Id: <patch-v2-2.3-b56ededf1b8-20220630T101646Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v2-0.3-00000000000-20220630T101646Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20220630T101646Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a quoting issue in the function introduced in
b9638d7286f (test-lib: make $GIT_BUILD_DIR an absolute path,
2022-02-27), running the test suite where the git checkout was on a
path with e.g. a space in it would fail.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 55857af601b..8cabb4d10f9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -57,14 +57,14 @@ fi
 #
 #	prepend_var VAR : VALUE
 prepend_var () {
-	eval "$1=$3\${$1:+${3:+$2}\$$1}"
+	eval "$1=\"$3\${$1:+${3:+$2}\$$1}\""
 }
 
 # If [AL]SAN is in effect we want to abort so that we notice
 # problems. The GIT_SAN_OPTIONS variable can be used to set common
 # defaults shared between [AL]SAN_OPTIONS.
 prepend_var GIT_SAN_OPTIONS : abort_on_error=1
-prepend_var GIT_SAN_OPTIONS : strip_path_prefix=\"$GIT_BUILD_DIR/\"
+prepend_var GIT_SAN_OPTIONS : strip_path_prefix="$GIT_BUILD_DIR/"
 
 # If we were built with ASAN, it may complain about leaks
 # of program-lifetime variables. Disable it by default to lower
-- 
2.37.0.880.gf07d56b18ba

