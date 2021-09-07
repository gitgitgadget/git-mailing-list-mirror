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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F368DC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D679C610E9
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347192AbhIGVb4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345551AbhIGVby (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:31:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222F4C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:30:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n7-20020a05600c3b8700b002f8ca941d89so341243wms.2
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HuT981S+GT0GpQpXLJ+E5So+fKoK77DZI53Qg9Qvmow=;
        b=IIPTgb9O7KP6m64QttlPO7FBOrDA7k3sxWiB5dqt5IAg0MrwCCwalIGG6nr+zyKnEN
         aLp0hdVBCq9sSr1h5wiKJgQ6cvszM8VHYp6vFV0cjippV/tWd/eFIbIyfoOqtKhRCuC+
         /up8WpuNH2r3VWDrVlaEuKXFHT0XRys1yr2QIOon13Y1sfK0zgu1X5+D6PRxhxLP/EeW
         4ghVo7ayFqTViDDjyHtRoAAjnHACaSoFYUVuEPCOmhcJwTeci20asY+nHmyp0IBqKWIk
         07agSWIcY2Fe2r7h+QJYLjlFa19VBDD00aeUO2EE/7J/zbWMV8nbi/bMcUWjHCO9YvAT
         DRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HuT981S+GT0GpQpXLJ+E5So+fKoK77DZI53Qg9Qvmow=;
        b=Ga1istD15WxEVtdSyV8+V8IUolhJycWWSL4tZt8DirK8WBxyzjNCixnfUAB06UvcEf
         dm2CLSNtd/P17wf47pu03HvLRt2o1MGAFAzjpR69QYMY3uNau3kc3xcRobU8Vglkg4hg
         9dS7bDWcwZ2lvsZs8GYwMa3Sz7siIokHrb5Fgczd0TOxdAglMRZeyX7ObgFApZS+xo6H
         J0bxBwWnze6U/sEnL9aNmsmXwihwclRruAtFqLH94RUkmdETZgOEoRJhXwRYZPMqFSHT
         p4ykovQoezkx3ynnB3Twb+2LBv5rRxx28x8+LSSOr/dWV2VIG8FR6RN/D52TsKZuMmH4
         nwCg==
X-Gm-Message-State: AOAM5317OcaxdzyoBQ/PFFm2BG+mUfcPMvjg1bTpu5/o2a2q//Ds4s1b
        ZWYb4gtAi/wIrClhkc/8j6e/pq43aqZ3JA==
X-Google-Smtp-Source: ABdhPJxUgK+2kZGDEeTgKyPHL5U9oIJ2rA1hcxYr3ntUb5KmPLT85lDYnX+loXtljeNx0t0VIMiSXw==
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr301814wmh.186.1631050245408;
        Tue, 07 Sep 2021 14:30:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g11sm155734wrx.30.2021.09.07.14.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:30:44 -0700 (PDT)
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
Subject: [PATCH v5 2/3] CI: refactor "if" to "case" statement
Date:   Tue,  7 Sep 2021 23:30:38 +0200
Message-Id: <patch-v5-2.3-6aaa60e3759-20210907T212626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.819.g59feb45f5e0
In-Reply-To: <cover-v5-0.3-00000000000-20210907T212626Z-avarab@gmail.com>
References: <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com> <cover-v5-0.3-00000000000-20210907T212626Z-avarab@gmail.com>
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
2.33.0.819.g59feb45f5e0

