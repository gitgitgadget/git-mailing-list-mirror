Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8065C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiKAWhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiKAWgm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:36:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4128D1EC7E
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:36:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ud5so40815848ejc.4
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xExwtgC3Cf4QzawXzrNZJGVKj2Rmiwedkn0aG/AC7+U=;
        b=iveiPrGkiLA+6xvJ1gqF4rU1v1j51OyYaQMBkzf/NGk21klWX0nmpjb7BTgVdO/3qO
         ki+111MPdFpA33GMeLQTclyaRB65HkC2auTKZIVzdWjdnYwe1/ivDJlIs26Yb4+CCjk2
         NH/0iRzaYa87XW7MgTruIkJYYChYnZjbhxpPC6bgXMqcVCWMS9JGqy0Q9RDb2Ug9JRRJ
         7zxvbBIijdUS+B0N0K3dwX+S4lWraDXDK1Am2HSsjnjgbYxCCOZlib34i5rmjXGNJ5UB
         a3WXAIAwTt3NYvhJRJlHEjfksUne/A3/79RjNq12cL/3PAUN2L/sIML+LerYuRnye+MF
         +QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xExwtgC3Cf4QzawXzrNZJGVKj2Rmiwedkn0aG/AC7+U=;
        b=rQf5fnpy4cQgIbZVSzaB9LJus16+ruIWEBrGHhTucedklf8mJCRq6YiQkXtV/F5FlA
         hMgACC+kvTexu9bDT9ZL0Vww3YFtLBcKcqNO4HixS9dzAASUaKKFSjrvtAe+eP3jqIJu
         5QO7YncjqA0ApPWapiq7Y679qWf3+4khaJisQArQ2TsfyphKCRehU6ji72m4HAQLH9U+
         vWwG4TyXQ41Q3HrcD9RQCpMsllru8GOYTJ1Qx/8EOZ33NF/WI35s1eN1oKFy3o2j2a3C
         EapO8G1s54X26jVgYrl7R65RJL6R0/9yGswsVAB7LN9N8Is8EdxUqzuYRwUk7mpJpW52
         HvZg==
X-Gm-Message-State: ACrzQf254sI1sveOIGXgukq5QbPvKDS1KUWqLdIBU6db5E5fTekmL/tr
        8H/+slQOAenhaNie+T1r7uq/AHMYNWCH1A==
X-Google-Smtp-Source: AMsMyM7zfaog+3L5pdppjUvBJhh6enQUbTJGtX4h1xam2rZpQiCLi5ZkgVNrfcKgJK9/LdcOAwmKIQ==
X-Received: by 2002:a17:907:1dc7:b0:7ad:83d5:6abd with SMTP id og7-20020a1709071dc700b007ad83d56abdmr19599639ejc.412.1667342167466;
        Tue, 01 Nov 2022 15:36:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id rp7-20020a170906d96700b0078dd4c89781sm4693845ejb.35.2022.11.01.15.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:36:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 07/13] cocci: split off "--all-includes" from SPATCH_FLAGS
Date:   Tue,  1 Nov 2022 23:35:49 +0100
Message-Id: <patch-v5-07.13-cae46461ebf-20221101T222616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
References: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per the rationale in 7b63ea57500 (Makefile: remove mandatory "spatch"
arguments from SPATCH_FLAGS, 2022-07-05) we have certain flags that
are truly mandatory, such as "--sp-file" and "--patch .". The
"--all-includes" flag is also critical, but per [1] we might want to
ad-hoc tweak it occasionally for testing or one-offs.

But being unable to set e.g. SPATCH_FLAGS="--verbose-parsing" without
breaking how our "spatch" works isn't ideal, i.e. before this we'd
need to know about the default include flags, and specify:
SPATCH_FLAGS="--all-includes --verbose-parsing".

If we were then to change the default include flag (e.g. to
"--recursive-includes") in the future any such one-off commands would
need to be correspondingly updated.

Let's instead leave the SPATCH_FLAGS for the user, while creating a
new SPATCH_INCLUDE_FLAGS to allow for ad-hoc testing of the include
strategy itself.

1. https://lore.kernel.org/git/20220823095733.58685-1-szeder.dev@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6785e8175b5..25f0c7e837d 100644
--- a/Makefile
+++ b/Makefile
@@ -1303,7 +1303,8 @@ SANITIZE_LEAK =
 SANITIZE_ADDRESS =
 
 # For the 'coccicheck' target
-SPATCH_FLAGS = --all-includes
+SPATCH_INCLUDE_FLAGS = --all-includes
+SPATCH_FLAGS =
 SPATCH_TEST_FLAGS =
 # Setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
@@ -1313,6 +1314,7 @@ SPATCH_BATCH_SIZE = 1
 # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
 TRACK_SPATCH_DEFINES =
 TRACK_SPATCH_DEFINES += $(SPATCH)
+TRACK_SPATCH_DEFINES += $(SPATCH_INCLUDE_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_TEST_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_BATCH_SIZE)
@@ -3182,6 +3184,7 @@ $(COCCI_PATCHES): %.patch: %
 	fi; \
 	if ! echo $(COCCI_SOURCES) | xargs $$limit \
 		$(SPATCH) $(SPATCH_FLAGS) \
+		$(SPATCH_INCLUDE_FLAGS) \
 		--sp-file $< --patch . \
 		>$@+ 2>$@.log; \
 	then \
-- 
2.38.0.1280.g8136eb6fab2

