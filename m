Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C58ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiHaU60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiHaU6L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:58:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB115D398C
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso294248wmb.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=huE2oZFXgMg3JaRAnVD36R6fKzt6QOzSgs5fCZyEW8A=;
        b=oCjd4zUWOCHmerHL/5BXs+7OKgmH8vcdkHHIxKwBQ57cUa3KZf+/Vsor1/k5cKEtoa
         dcopnyKcvccRusuPYozNe/ZR1uAldiW+eBKD8Uv44YJOCkcgM5uYHcWgKJq2oLNbEDt9
         Kzl0Z3vLYcVycYUX2DBHynfH27kZZEZ5Uq7/Rsk7fGI42bPNfuUYRVTUBBh5SwXqVsst
         J/JVAdo19VHFSyZqf4ZuDhzlgGSaGB7K9LtHsTMmf79qMavXl/8fwqGcBqie4F4hz3zm
         zkhmwaD8Wtf1UQhgdpQRcAZBtkGN5CbCVv5Dr+IuPO+oiwg9sBzhDzViYcKXcWJRmjQ2
         ADsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=huE2oZFXgMg3JaRAnVD36R6fKzt6QOzSgs5fCZyEW8A=;
        b=MlQ4mcK/wP+Tl5oZ9Zoq8eQA8Z7EDrvj09oldtVy5s7v4uvfjMqimBGo7+vzi7n4DB
         vVPpTfcUqLYxtAAaiD6FTDILhbQBRiNEtXslwBXTQtxyXIXIw8pU60rL60y5QBELN9KO
         nIzQ4WLPF72dsU6125cuJGo1j4/BL3L8MTCtdS9c0mKRNBMICqBoben3VgMyuefQud1f
         XABa5qClRs2a1iHgm7kzH4+ofQ9U8xaI06p3Cy2IglUnGjrzZpfi/B/+r4C/k1VKC63f
         Oktwo9TVNO0IZi4CfTaa/w3uU6/UCYNcMRZoA5/FM0TyfE94+uh0ZlWX5+oYbQYK1co3
         Q6bg==
X-Gm-Message-State: ACgBeo0UEdzKIx+JINBLZ5rxjlUI85zKfZkmRvFuOoyphHYRImAmur6n
        4GouJdQ3GqgVW8trkoGvg1gqmxI3Lil4Jg==
X-Google-Smtp-Source: AA6agR7mgHnmRbD9hV/i0C1fessgEw1TepPV6kc5UDCPPYGk/2g4mfI10vzYJzK5rrJ+WxVr9NwVaw==
X-Received: by 2002:a1c:7708:0:b0:3a5:5543:cec4 with SMTP id t8-20020a1c7708000000b003a55543cec4mr3136676wmi.47.1661979488094;
        Wed, 31 Aug 2022 13:58:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i16-20020adffc10000000b002253af82fa7sm15766955wrr.9.2022.08.31.13.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:58:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/9] cocci: split off include-less "tests" from SPATCH_FLAGS
Date:   Wed, 31 Aug 2022 22:57:52 +0200
Message-Id: <patch-v2-5.9-4f165bf6128-20220831T205130Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the "coccicheck-test" rule added in f7ff6597a75 (cocci: add a
"coccicheck-test" target and test *.cocci rules, 2022-07-05) to stop
using "--all-includes". The flags we'll need for the tests are
different than the ones we'll need for our main source code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index fa2e2193e99..143c012b3be 100644
--- a/Makefile
+++ b/Makefile
@@ -1296,6 +1296,7 @@ SANITIZE_ADDRESS =
 
 # For the 'coccicheck' target
 SPATCH_FLAGS = --all-includes
+SPATCH_TEST_FLAGS =
 # Setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
@@ -1305,6 +1306,7 @@ SPATCH_BATCH_SIZE = 1
 TRACK_SPATCH_DEFINES =
 TRACK_SPATCH_DEFINES += $(SPATCH)
 TRACK_SPATCH_DEFINES += $(SPATCH_FLAGS)
+TRACK_SPATCH_DEFINES += $(SPATCH_TEST_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_BATCH_SIZE)
 GIT-SPATCH-DEFINES: FORCE
 	@FLAGS='$(TRACK_SPATCH_DEFINES)'; \
@@ -3188,7 +3190,7 @@ $(COCCI_TEST_RES_GEN): .build/%.res : %.c
 $(COCCI_TEST_RES_GEN): .build/%.res : %.res
 $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinelle/%.cocci
 	$(call mkdir_p_parent_template)
-	$(QUIET_SPATCH_T)$(SPATCH) $(SPATCH_FLAGS) \
+	$(QUIET_SPATCH_T)$(SPATCH) $(SPATCH_TEST_FLAGS) \
 		--very-quiet --no-show-diff \
 		--sp-file $< -o $@ \
 		$(@:.build/%.res=%.c) && \
-- 
2.37.3.1420.g76f8a3d556c

