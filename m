Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7F9C4320A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB9860462
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbhHaNgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbhHaNgp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:36:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32594C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so2632160wma.0
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+uQqfMk30ReBKcI9toiWoTbuAOCXFdtzq1CGzD8Yec=;
        b=q9x/AWYeXuoZwm4t3PyQw5HdsV4M/JkLaoYEzqjP0elDXPg7mgecG+L0hSZCg4TgPA
         1DXltOViW/uiCuSoV+97wTXpEHbUp25lFHqsR6QITRZFHARWpJUhoR5LB/0JnWNKpHeJ
         bhxYR+xm5NaZtDdON3dS7nDbw+kut7X3E0C2zuftZfGsApM/xs3UGaU0jNdpOtVcCs+k
         padvB94SjCatP1ppB7S9l8IBXI2Y5pqPY4/YbHDhNRr2peJ/Zjt+Ey/q1N1kIoccHPoj
         6Zz4PNGL8CPejI8nuMz8n7Y0kwpWMRlZOM5RrdAIYwSuYUbujORK6K7M+425FXA8Vj+e
         aFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+uQqfMk30ReBKcI9toiWoTbuAOCXFdtzq1CGzD8Yec=;
        b=MIw/FLG4MRpAMuiida4s8IVhmXuv6gijr46L2SBlCk/rvioOu9gyx/Ue2PcMnJ/i7p
         beoSqK0m6pHuMNYCQ7Y8zpYtpFtjbZnNamOX0dBiUO5Lqbo39cqjQMU7ZZe3fCD0Sxyf
         315hyZow85Qb680x288UgK8Mc/Rkx5+euWBBysR4RTqqp1utTVjuzwjsJBrwD2AaWf+y
         K4xxDUGaH59zm+ivid0468FXxKZbsdrZJV1Wx/kDpxRzUcCXbr8sZ9Xn6UCdmfeXnTZa
         6TFV8nkFCHT/j0ECKg76nhb9O++DncZ4db2r193ve2kleFYhFI17SKz1HeqHeFNSPjzb
         P89Q==
X-Gm-Message-State: AOAM531vGTqBc8Lb8UMFk8af/nYDUHWpLgpiGP4T98eGKAcR1Fg4MGp6
        /yR5JtivjI9Mv1JCv3GNqHN1BMAs92cplg==
X-Google-Smtp-Source: ABdhPJwv/8c6p08odA+w3m05PCuMv68CNjRVq7oKMTV9PHdRMRb+IYVa7FrD/4J2kqXvVkW6KYzAoA==
X-Received: by 2002:a05:600c:4304:: with SMTP id p4mr4281393wme.18.1630416948188;
        Tue, 31 Aug 2021 06:35:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u27sm19073451wru.2.2021.08.31.06.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:35:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/8] CI: refactor "if" to "case" statement
Date:   Tue, 31 Aug 2021 15:35:36 +0200
Message-Id: <patch-v3-2.8-91c36b94eaa-20210831T132607Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.805.g739b16c2189
In-Reply-To: <cover-v3-0.8-00000000000-20210831T132607Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20210831T132607Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor an "if" statement for "linux-gcc" to a "case" statement in
preparation for another case being added to it, and do the same for
the "osx-gcc" just below it for consistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 476c3f369f5..33b9777ab7e 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -184,13 +184,15 @@ export SKIP_DASHED_BUILT_INS=YesPlease
 
 case "$jobname" in
 linux-clang|linux-gcc)
-	if [ "$jobname" = linux-gcc ]
-	then
+	case "$jobname" in
+	linux-gcc)
 		export CC=gcc-8
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
-	else
+		;;
+	*)
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
-	fi
+		;;
+	esac
 
 	export GIT_TEST_HTTPD=true
 
@@ -207,13 +209,15 @@ linux-clang|linux-gcc)
 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
 	;;
 osx-clang|osx-gcc)
-	if [ "$jobname" = osx-gcc ]
-	then
+	case "$jobname" in
+	osx-gcc)
 		export CC=gcc-9
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
-	else
+		;;
+	*)
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
-	fi
+		;;
+	esac
 
 	# t9810 occasionally fails on Travis CI OS X
 	# t9816 occasionally fails with "TAP out of sequence errors" on
-- 
2.33.0.805.g739b16c2189

