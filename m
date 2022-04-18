Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58746C433FE
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346217AbiDRQed (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346308AbiDRQca (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD26F31232
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:42 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so9080566wmn.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9v7DXqDJoPnvFC/66ybS0FcFM8dXGwI9fCsChdrbke4=;
        b=gA+MPQ5SmulYA/j9fWqhqG6c1V56djkFfSFEpgycD0L4cRM0V5JEEFlu9Pin+pYoqE
         y/pyPpfLltlQyaIT9HqSnCxQ9VBwVx+YURtq6tDdIGH0DvcB9yXezX6jizHMPmD77OyP
         gJ4SROHMVVERQ4wLZxhu8N0BF0qmUxRbb4x74zZARCezN0Ey04TJf/GVGGQMuheS6tCx
         V+g4kNk2M/mVGUYwdJAEwkxZGvuOUKYGdrQko4zLdI6i4EfYM4K9spbgvzImwKBcPuth
         3Tfac0OPnl3bdgXsof01sdZvRAS5YlUpqJESRzVhcnx+2Jh8PRnNcNsnq1BRmmvh89Ha
         cJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9v7DXqDJoPnvFC/66ybS0FcFM8dXGwI9fCsChdrbke4=;
        b=ZfzH6ywtHc21yfg88uvmJAuSMQUFtMYJki4surCzt9LxIO8F/GXRcOUuVQzvIzadLz
         bAwOsFZEenZYw42f2VwGlU2pD2I4IW2rRaqwetcPEyKOasTcSZVv0CpgOHmJFFLjFYiO
         btl6BJhE9ubAXsLJHPzuaqoe+GCtJTY25lQzwDLDB4AyYip9zX9Y+KevpldPdOkX5eb4
         dBO3KCYEWOVAJcnNJMkoK+KmFP0KApHi35a9XwJvhe//JWSFw3Q1rPAlr/BQaWQz5cLD
         dvwwsLZkYV0ffpJ4i2Qm0R0zd+BUHYZ63h6hiC3pQkDJ7rMu0hnOfG6U33Kuyf218TUt
         591Q==
X-Gm-Message-State: AOAM533BLgX37+b7qCr4cArOTufrYuvGhanY2547cCXdgL3xJaP7juNL
        OK3Q1ZrtwvjCeDCqhZcKWmKu6/AODnpmCg==
X-Google-Smtp-Source: ABdhPJzAQCpTgm0wWKwO8VEwWfA43z5S5sdrEACEk9x10JwmR+6kQHVzYFSRT/fNAVuPUqCMAC8IRA==
X-Received: by 2002:a7b:cc12:0:b0:37c:1ae:100a with SMTP id f18-20020a7bcc12000000b0037c01ae100amr15670211wmh.54.1650299381194;
        Mon, 18 Apr 2022 09:29:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:40 -0700 (PDT)
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
Subject: [PATCH v4 30/31] CI: have osx-gcc use gcc, not clang
Date:   Mon, 18 Apr 2022 18:29:07 +0200
Message-Id: <patch-v4-30.31-94abb826627-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in 707d2f2fe86 (CI: use "$runs_on_pool", not
"$jobname" to select packages & config, 2021-11-23). In that commit I
changed CC=gcc from CC=gcc-9, but on OSX the "gcc" in $PATH points to
clang, we need to use gcc-9 instead.

Reported-by: Carlo Arenas <carenas@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index ab7546800e0..8f80be4c3df 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -179,7 +179,7 @@ linux-TEST-vars)
 	;;
 osx-gcc)
 	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
-	CC=gcc
+	CC=gcc-9
 	;;
 osx-clang)
 	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
-- 
2.36.0.rc2.898.gdf6bbac50ff

