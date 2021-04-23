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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88493C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D71261404
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhDWHa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhDWHa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:30:26 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE817C06174A
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:29:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x7so47266049wrw.10
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JjIAVZPe/9FsC2UDs3MoIBC2kgFvixkotYhW9Fr0QZg=;
        b=b98/GTHlUClgR/rZ/rRhtZvKAW8Dktvkm1ASNYkAKj1frkm93cnOtuAIgbGbt4A2cq
         K6LSGM/A91Kly4ZaY2yBLE2/iXoqGRwp0iiusy7kV+8mVpVjgFuaEgW71aHEnMaM/t1X
         SBpPKZcEnLZqOFcnROQyNkqzMFzuxbBzJxqEUkEfXB6aoZHj9g9PTQxbt3lPFcYTHFJP
         L3JTr8dwYXOTrBHv9njTKhaTI4jU9wzLdjqZvMoOSAnph3vg2JDpoFOzqhYeQ72Do3B2
         7bN9Bt/GuargSeDBwu91kvl2OToovSxBUwhNyZ8hlJDBbfBWJL/zYc+a2puhreGojoQ8
         lfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjIAVZPe/9FsC2UDs3MoIBC2kgFvixkotYhW9Fr0QZg=;
        b=BZgBXIf/H1Ue/GEU1XPbdV8Wvzn4c8HX6MR6DNtFJKGPtWNGe8GlGhyuEIzeCRwUEt
         1Kb2iEiwuQK2cjtGBusSuI773xmaLkofrSYmK9QNrQFxjkFEjdqEb13fUuCPShvZDVK+
         gAYeMWgY6WAk7SUk8YZE80UnmIRxQSFE0aJofggeHAnihppKxjohtyL/vRSD8vce+xvm
         oZ+YXKnnJEtsc9Sf/nMHHB5rZzxpJJi/skzLWunaNEAKEJiWhetfGApiATQAPZgICEoG
         fNs57LwHBEqL67uSRnRx3XzkbmNqli/pVayt6DcDBNgh7lxPmM7DdU7mSAvEkfN7AyJk
         X/GA==
X-Gm-Message-State: AOAM533iNfosPO9lPf9VadYA0GX3GpExVSF7McCsxDLaBiLiNaxuF9d9
        ZH7CBwYVmrzQDUqN9v2bJeSCAqLvMroWgw==
X-Google-Smtp-Source: ABdhPJw6HVG6JnrC/44RGo8XdHDzS6QV18l8nqnwqcWB4xqtvTWyUwjk2+kttHCpCVmUL8gw2XHs8A==
X-Received: by 2002:adf:fb87:: with SMTP id a7mr2927067wrr.58.1619162989301;
        Fri, 23 Apr 2021 00:29:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r19sm8681648wmq.33.2021.04.23.00.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:29:48 -0700 (PDT)
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
Subject: [PATCH v3 1/4] test-lib-functions: normalize test_path_is_missing() debugging
Date:   Fri, 23 Apr 2021 09:29:43 +0200
Message-Id: <patch-1.4-26a3d552d88-20210423T072824Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.734.gdef39492517
In-Reply-To: <cover-0.4-00000000000-20210423T072824Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com> <cover-0.4-00000000000-20210423T072824Z-avarab@gmail.com>
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
index 213b1988aa4..2914b398470 100644
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
2.31.1.734.gdef39492517

