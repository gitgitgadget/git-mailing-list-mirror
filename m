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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBD6C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC9A611C2
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbhDQM7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbhDQM7G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:59:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D21C061756
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:58:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a4so29271038wrr.2
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MGcWP45k2WAjNwv4oQ0Ie6n/41rPtb/wowIrZc4fcHM=;
        b=nxh6dxGHFBD2vHLK6pNfTvXbyF34OC6N+aPIBGaIl1QWPjyRN75vafBDendhVe1eYm
         x4Tyzc6gtxmyTMmgtaNrT18v9hViGXE8vSMfbOK9ffwJlYj5AzBYGylseGMCSTKpbwER
         XNxMTUs1N7Q0xV2CJ62Khlui0Hav8ZOpk1qVdJwL36LCDQforXN2WqwvrRqgv+IBIm3M
         Mv1wZaDI8ZT4EsA+Or+620KYsms3pU6fRqEWrwHkiwPBZtnhNdZEFdNMoUyX83S+BdzQ
         8k2U+73o5DWdvuHukhKlJr6qwwmm3u0ui3I4QPWxS+uwcgm+eHxoRb2Xtlx0a19XS/QX
         rkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MGcWP45k2WAjNwv4oQ0Ie6n/41rPtb/wowIrZc4fcHM=;
        b=ZvHf4I57HpKU1ZZmgEt+FPFV+kahFpepY6FqQPlKNHivSAIkJG5D7JEGrSlsAvhuSw
         DASIDuWDcMdMKjsCJfl0k/xTUz8rzf/1Jz6LN1AQxts/EUpFO2EaDO/8tJLmfFf+oz9i
         ZH0j1Qjcma7tPWSUeGGcJfO++LXK8raFtBaIUt7/4HwvAJ0uNeXpeZlqIp0jC7DuY1pm
         +ARNp9yM5HkAqufjNIPOhQlkujGJLIjU6WDdUK6XXDRlYoTvMJiubNjUJr/wQ8LjTT4G
         PqlP+loCk7gHvV/VM+XZTj0rgCKdhxrUUrRnca13kHdD9Vd9UEtaBlsJaJFE5Eg7U6g2
         uaBA==
X-Gm-Message-State: AOAM5322kROnPY8MFCUFonRVbBCHqQLz/yELm2UJJuPua1VwxZ1SGVnO
        MzH7G1S9c7pwnYMmZ8N8/t05VYL7hJ/dNg==
X-Google-Smtp-Source: ABdhPJw49vSkqRf1MzrGtHSLy0CAT2UHoqSd8wpd3Cz4JAF82dGBDaSrRtntnVJyC7vdW9cthOK2SA==
X-Received: by 2002:a5d:4043:: with SMTP id w3mr4233352wrp.320.1618664317597;
        Sat, 17 Apr 2021 05:58:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i12sm12452909wmd.3.2021.04.17.05.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 05:58:37 -0700 (PDT)
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
Subject: [PATCH 1/3] test-lib-functions: normalize test_path_is_missing() debugging
Date:   Sat, 17 Apr 2021 14:58:25 +0200
Message-Id: <patch-1.3-c22e3f7764f-20210417T125540Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.g7084a9d5a2d
In-Reply-To: <cover-0.3-00000000000-20210417T125539Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com> <cover-0.3-00000000000-20210417T125539Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test_path_is_missing() to be consistent with related
functions. Since 2caf20c52b7 (test-lib: user-friendly alternatives to
test [-d|-f|-e], 2010-08-10) we've been ls -ld-ing the bad path and
echo-ing $* if it exists. Let's just say that it exists instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index bd64a15c731..0232cc9f46d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -810,12 +810,7 @@ test_path_is_missing () {
 	test "$#" -ne 1 && BUG "1 param"
 	if test -e "$1"
 	then
-		echo "Path exists:"
-		ls -ld "$1"
-		if test $# -ge 1
-		then
-			echo "$*"
-		fi
+		echo "Path $1 exists!"
 		false
 	fi
 }
-- 
2.31.1.722.g788886f50a2

