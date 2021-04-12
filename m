Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986F0C43460
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A2A61249
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbhDLLJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbhDLLJc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:09:32 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69812C06138C
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f12so12520679wro.0
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nKj6+4mXMs95f/EB7TGBgYMSs41twH9ljnu5PXsWqyc=;
        b=IY0WJsQJhlxPoqNa9imPufKn6/hLYgNokjIvT2chitUCAFUfxLRUUjpxFR4N/6p82A
         GW8bL5PzhNFTthEVdsKs5IfWI4JPUZCNKm6HjFCBjuqfufJluVEK/68lvEZVeNTbrRIS
         Z7LubMKkd+6okZ4GmgjjFgnhs1bBqpDKWtdxDlEi4SyvvbcaA9fb4DMLN759ml5Soc4P
         sjvETbZMhD8eBZ6daIth/GRpYaw3WCUnz6olrsBytOWlWpuOFvlAapiejE4KEsAf9oRm
         2OBpiXqtFu36j2GZO+Ee0wd310ZiK5MeRGMEtFbn9DsDBKyh2IgOFkrwVUGUkrDR+2mz
         jDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nKj6+4mXMs95f/EB7TGBgYMSs41twH9ljnu5PXsWqyc=;
        b=ohukkFKPhAaHylSQiPYA1YTjgdi2cWxM0g+mVtnzlbYv714cHRx5ZkYhY75tn4Tx0J
         nMBR141CnP96fuw3zhhd0RtrN7opCsZoqafskDuJwSRQmkw+vxa9IpunpvvbvRYWfpC7
         Xc6vCSU2h+S/rCK+aMXHZKHl2zzqt1I4RLPPbELQIwj4imvNIiKeBJ35wvkMGKWzipv0
         Wn4tz2Y98fUQUKGKwQddigIKvEmrQ6bIOWZNkIWuzGBqXfXxb7fxX3Cbgmi3wPxhPGO+
         KUJEHmCMmwBl29XGgIEU9zNO7JssTQeAFD2vSP6RmaYxAKDzpo0wKHh7rprZJCqftWq3
         bdVA==
X-Gm-Message-State: AOAM530ZHKrofBjj0BCJqzOhCXN+w1Q9MDF+UOr91W5o0TbCzXO2K+xl
        EGRgYb88ue42XmwyHtseQiLcyH69tduQfA==
X-Google-Smtp-Source: ABdhPJyRELbWU/kRtBo0BV2BmyRcY23w9HvyYXLZODn+kcKRPc80RHWU0iR/m0FVDaeufeelm6bjXA==
X-Received: by 2002:a05:6000:1549:: with SMTP id 9mr31140949wry.192.1618225752890;
        Mon, 12 Apr 2021 04:09:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm18158744wrh.91.2021.04.12.04.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:09:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/16] test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
Date:   Mon, 12 Apr 2021 13:08:52 +0200
Message-Id: <patch-03.16-3d04553d710-20210412T110456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
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
2.31.1.634.gb41287a30b0

