Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C889C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiJNPc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiJNPbq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:31:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BC281103
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:42 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bp11so8116249wrb.9
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xe56/qlZnntAEt3Jsb5FEbGmYbsBNvTRubi0B8DX2p0=;
        b=B38B6tboRIufuQFQKAmWXOScay9Qwlf84eVTCDVX7lbSwpLVELO5q6gzqtwGWAv1No
         CtEdVPUGFFulrLwAS8dhCycnYW0YHOeMwmzqmVFMdCGQElLWMoIRo79kHnGczhRxFSTe
         88zcnvqVeKKuN+IXFfXXVp8haLMzsFrmHpZNJCnvaCmvWC58OsbLxCBP8bF/FRDaiQz9
         Kl+1N9RbQXojFTGlzYfcfIj9twVewDBnozg0+JqKPZH1jUaMyQFie5AsPZMDtDZhA4WJ
         Rfe45ybdrV1/OlloKSdMOt0smwpiUshxO3F2M6RF6Q13cSenjv/62wvd3U9qF4BlIJWw
         FbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xe56/qlZnntAEt3Jsb5FEbGmYbsBNvTRubi0B8DX2p0=;
        b=L3smHeEAiUrwB0AK9efn2DcMho5gx1AA/Oq2cwWHRvy6jBR71V5wV4C5Z2SoDcFHXu
         fsMXD9kT+8W3AoPnolw0ZXEFmW0bl7l1npBbqToLccepHySGWy/OSBAye/MnSZpJo1Cy
         efM3qKTnNwEkFl0nGeB7SQr/gACV7jrXdYfr5mn8gSvUiI3FM9wXteyPVs0loSO4KWxi
         wf31QzreZg/F/Vp4MMKOWokhiHlNEiWK41dzhOf/CSFaKraoH09HLT7NqGtLd4isr7HG
         DcTsPJbMW3+9X4amxA2YB0k4M6NMZb6qNqV7SxO8WwsH0fRn6HTY56IW96/nbuFqlNs4
         /GHw==
X-Gm-Message-State: ACrzQf0ufWGV8YgP/c8dHLGFk74nDabqycRecSF0dFF+fu3qx0u2CurR
        ol8heFM+Bn2y8KoYckqo7qZIeXbvsMQcPA==
X-Google-Smtp-Source: AMsMyM5+Xqh7PADTLie5OCZnkovrWASnZMDw8Hrm1X7zfBB08z1JqM158p+U0oeRUJmgIqNwdx24ow==
X-Received: by 2002:a5d:64ab:0:b0:231:44c1:32b0 with SMTP id m11-20020a5d64ab000000b0023144c132b0mr3809419wrp.255.1665761499911;
        Fri, 14 Oct 2022 08:31:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b003b47ff307e1sm2219053wmb.31.2022.10.14.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:31:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/11] cocci: split off "--all-includes" from SPATCH_FLAGS
Date:   Fri, 14 Oct 2022 17:31:23 +0200
Message-Id: <patch-v3-07.11-2ca5ea5beca-20221014T152553Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com> <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
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
index 535dece5d48..f79697053bc 100644
--- a/Makefile
+++ b/Makefile
@@ -1299,7 +1299,8 @@ SANITIZE_LEAK =
 SANITIZE_ADDRESS =
 
 # For the 'coccicheck' target
-SPATCH_FLAGS = --all-includes
+SPATCH_INCLUDE_FLAGS = --all-includes
+SPATCH_FLAGS =
 SPATCH_TEST_FLAGS =
 # Setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
@@ -1309,6 +1310,7 @@ SPATCH_BATCH_SIZE = 1
 # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
 TRACK_SPATCH_DEFINES =
 TRACK_SPATCH_DEFINES += $(SPATCH)
+TRACK_SPATCH_DEFINES += $(SPATCH_INCLUDE_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_TEST_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_BATCH_SIZE)
@@ -3174,6 +3176,7 @@ $(COCCI_PATCHES): %.patch: %
 	fi; \
 	if ! echo $(COCCI_SOURCES) | xargs $$limit \
 		$(SPATCH) $(SPATCH_FLAGS) \
+		$(SPATCH_INCLUDE_FLAGS) \
 		--sp-file $< --patch . \
 		>$@+ 2>$@.log; \
 	then \
-- 
2.38.0.1092.g8c0298861b0

