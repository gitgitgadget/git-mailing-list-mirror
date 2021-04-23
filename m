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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372E6C43461
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8E5613DB
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241081AbhDWHWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241042AbhDWHWB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:22:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93068C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l4so72407480ejc.10
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HWPFD3o28WzQ3Wbp4zpIg+jBG+f0FsnCaqvh4pw8C74=;
        b=ClRedicbXNPt5Wola1vijO+R+jCrxwAHJDWjT4c+g5reLV7vWoJWOuCywXWrSUVMep
         81QwphYlUAdF1+n1Mt1O+Cnr5/Z26MFJvN3h7qMyv9mc0BQqEkrozXoUTJIsY+qr95LC
         oneKOk5GT8CsKB4bUwlfjYC7UkiPbAQdxdYQZqgX5cQCwf2rzfAGZ8N9Vl3Tr6SjibBC
         gEuf/dQmdrNgCpt3uRpLyShKYWZSSF8vibzKZuRYg08P9excjxAkiVo+EaIC5AP3GfPI
         2V0qGZ57b+jNkfjlxQtP8gPjuKzKmENKqi0sCNDHY/J4BjmoBgNiOK8vaU5XXK3p/uR7
         m8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HWPFD3o28WzQ3Wbp4zpIg+jBG+f0FsnCaqvh4pw8C74=;
        b=Lfb2bxtP35Hh1YY8YgTG3/sUYvfpVYuDeWH2lioRu2i1GNmCCbVIYu9x16quggzh0I
         Sj9VuOFS9f1C6yXq5UZyJYCip2nIKRv2v+7NsYWyizi3u7AsPJSiuswba+oyyMdUEli+
         dI92/D4bx6nQHEy4AFwUEGQQBsLOGxJtr21rq6oCkzjJFwNfvOAZMIecKOulKlTYlJ4B
         8KbH7VMBt9a5vJ0NgGgFezyh6rOEodZ+Q8NORkFIW2lBBEVPppoYdD9CWiwx8vYhF7bT
         +FCz6FM38w1M5g8/urMP1feNgE7EtZN8TgOOxFDg0ljzOAw/ABuQy+bOS9e08hCe7Tr5
         Qd9Q==
X-Gm-Message-State: AOAM531E8Xsv80F7briVDqg2gv1GFtOgf6GObvGA+WR17Voyu6sVhpAN
        E8MLiWbZayGEiDGnalc+Pzf1mMKrgg3YNg==
X-Google-Smtp-Source: ABdhPJwx87eJ5f6cHeGVIzW7MHsecVKm53+/gpgKDJlg1fuWKPV8VMpAzPmFjRNQ3Ujkz01tGPxV6Q==
X-Received: by 2002:a17:907:9852:: with SMTP id jj18mr2672863ejc.382.1619162484071;
        Fri, 23 Apr 2021 00:21:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e5sm3328892ejq.85.2021.04.23.00.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:21:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 02/11] test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
Date:   Fri, 23 Apr 2021 09:21:06 +0200
Message-Id: <patch-02.11-55c9413f9cd-20210423T072006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.737.g98b508eba36
In-Reply-To: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com> <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop setting the GIT_TEST_FRAMEWORK_SELFTEST variable. This was originally needed
back in 4231d1ba99 (t0000: do not get self-test disrupted by
environment warnings, 2018-09-20).

It hasn't been needed since I deleted the relevant code in test-lib.sh
in c0eedbc009 (test-lib: remove check_var_migration, 2021-02-09), I
just didn't notice that it was set here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0000-basic.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 705d62cc27a..2c6e34b9478 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -84,10 +84,6 @@ _run_sub_test_lib_test_common () {
 		passing metrics
 		'
 
-		# Tell the framework that we are self-testing to make sure
-		# it yields a stable result.
-		GIT_TEST_FRAMEWORK_SELFTEST=t &&
-
 		# Point to the t/test-lib.sh, which isn't in ../ as usual
 		. "\$TEST_DIRECTORY"/test-lib.sh
 		EOF
-- 
2.31.1.737.g98b508eba36

