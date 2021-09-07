Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0908BC43219
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 15:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85F561051
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 15:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345313AbhIGPet (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 11:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345287AbhIGPep (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 11:34:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2731DC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 08:33:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i28so3835077wrb.2
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G4hbnf4c8Zr+mX9xys1DDqIp7wq3Kh5Z16ScZwLcP2s=;
        b=KINB2vlg08bpKDN00jJ7pfDuGeHaZQb853ubxsqMUmnNhGFsN6Kaqbdw1eexkmNIpS
         iws97gphH2M5WHw2IjOrt+1g1yZEa4LvS5UDucxJup8k2nPwhuvOFz7Ph3ZiPtgSWW0q
         FJ4IqN6aasygQNZvhkcz4CjF+8LbC+VBORMk3H8SvtAOAYqaHojEznWCCfK9u72ZIrIB
         r5XLExE+fAwRw+W8FuAkfIv0buLWRfwXc5SWDpnhgOhsHJcME2Srb78OuxTN8za+0T4z
         YK8RKbuqcdmznQ6Aw9TBDoJzhzlGYwakdgBvorZHfl6QICOR4NUohEHd5yERRC2zYEdv
         Wdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G4hbnf4c8Zr+mX9xys1DDqIp7wq3Kh5Z16ScZwLcP2s=;
        b=PMrU1k+OHtJl/L8aF+zIdhmIwLsjz71l3ihy/E0z0EWamoLRZoQcwa0RnA0YtIzRxG
         uvp7SGxGGP2OBSdgGaHJCI9jb3YXxfNeO8RagXc2UjkDLpUYGz2Tw8hfqrs5d10G2ff/
         0ZiKxsTpMkGCutz5Rfell1XJdX5knFVUjCQ6OZz3dFmE7ZSmgB4BA4wg6Nsh887fWNYq
         a0TtqQRkL2eQynLNNqHiS1s1fXxlpQXOzeX4UsE8OIoIyqs86giLRUfTlt5/j/Q7JSg+
         JV6MP3kiandhU9Aym+HjYTTejsk3oQX67ss0hsISgj23kRKtZxQHk3LQUHwDPk5GYYPx
         2IwQ==
X-Gm-Message-State: AOAM532owYW2WjFYanvm+zq//qOzl0EEl5qJ1ZF4UfkuR3eOd2xPF39y
        wjgY0it+hV4ZlRZrc2KhPjyXii6PbnMKyg==
X-Google-Smtp-Source: ABdhPJzD09WuE5iGmEnO93lIEERDg244K35mP3u3VRLv5Cl63Zvy0twWMDNEg7c+DXMMSGjXj2XeEQ==
X-Received: by 2002:adf:f747:: with SMTP id z7mr19656738wrp.194.1631028817516;
        Tue, 07 Sep 2021 08:33:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t64sm2568799wma.48.2021.09.07.08.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 08:33:37 -0700 (PDT)
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
Subject: [PATCH v4 2/3] CI: refactor "if" to "case" statement
Date:   Tue,  7 Sep 2021 17:33:30 +0200
Message-Id: <patch-v4-2.3-6aaa60e3759-20210907T151855Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.818.gd2ef2916285
In-Reply-To: <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com>
References: <cover-v3-0.8-00000000000-20210831T132546Z-avarab@gmail.com> <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor an "if" statement for "linux-gcc" and "osx-gcc" to a "case"
statement in preparation for another case being added to them.

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
2.33.0.818.gd2ef2916285

