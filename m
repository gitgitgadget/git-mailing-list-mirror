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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0226FC433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8616147F
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhEJPN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbhEJPNn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:13:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C403C0515E6
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o127so9314550wmo.4
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJ2LpRPOEO7UW22DomSt2mFfa4VaeIucPRqAnQEbTPA=;
        b=MQFZnazs5ye8LFghlcM2pvMsOCvZTo0Z1QtW9cyF2eTNpAeDLK75m4tpbiMeRmrzUw
         0TBWhuIOfD1OdMJCZOCa9BwxwJEqRZtuDIX4gL4Npz5nV78iKlS3/vW1vh0C5Rykdqfk
         hBcgrnEiMhFGneZEA4X+orgqLD+PF0Qf+zAwxPb3gDj/VRixCMAvZ122z2O2oskY9e6W
         ry3KcQrUOQvLF4oY+tXeul52cwFdrDSSX41wRzkUnDnDUpRI3IqmrQ2nV7uazqlnRomI
         +dKN7c3awVMvCLlgGxWVlMoJLUQ0ZzkTEDP3Ck8n2k/o7uZS0wAs9FfTM9fwyktjiYgt
         cxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJ2LpRPOEO7UW22DomSt2mFfa4VaeIucPRqAnQEbTPA=;
        b=MXczTdz84DVpvftJtXhxcQwDHI64+45BGbSzQ6lt1PrU6jYe+aZhZ0vNNPB69XWcZL
         oz3EKSq9N4FTFHtZkufahD4Nk09/BS4szSQaNyQgzpkxW76ZA1WLg7TdNPJHiyMgR7gb
         RD74UVom3RgIi7OOCDkrH8mjiB5367E3ZdxcKb09CtJgeSTLwMY9tBkFwwyv9uV3/Dzb
         m3Ag4HD0nP77833AXCOmH/K7JuxhKnqkZ31chBHVkOzzDY3i61hhTYYlhNXTvZ2yPknV
         aztlBzzTQ5VqXyWOX2GlFMW82HaLdKzgV2fRt9c8PyAQmXjTBhHBju/jbC8WKmKUGQfN
         mJ0g==
X-Gm-Message-State: AOAM531EpQYh130gQwpnhQ1+W4Q2r85F2r0hV1Oa2ioQbX5zRBnfRVij
        JgZP0YWW3pvQGLk/wTNIlI+qJOcmt2MCdA==
X-Google-Smtp-Source: ABdhPJy0wDtN5fdk65QZcU18ANW1hBcEJAcp4P/gaUX4WJiZGKu8gDkVdJa/am/wjoC9WGkL78bJAA==
X-Received: by 2002:a1c:4e0f:: with SMTP id g15mr26971730wmh.184.1620657135799;
        Mon, 10 May 2021 07:32:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q10sm22421839wre.92.2021.05.10.07.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:32:15 -0700 (PDT)
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
Subject: [PATCH v6 02/11] test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
Date:   Mon, 10 May 2021 16:19:01 +0200
Message-Id: <patch-02.11-6f360e37e84-20210510T141055Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com> <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
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
2.31.1.838.g924d365b763

