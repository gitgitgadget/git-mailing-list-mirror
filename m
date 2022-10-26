Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4B4C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiJZOVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbiJZOVE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:21:04 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DD610F882
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:21:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d26so21591512eje.10
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qOpBFbV/KrIebqK2HIZy45rrzEiZyulYyPhpFuyZxc=;
        b=iDeW9MqohhFwymOrlE5z56hPWPgz7Z8SCNTQcCol/zM3ljdBbE6dqmXZybFY42hsFR
         nKDk5SuGJEcnDnt4Pkg4vY2wDXzrrXF1xf+kJr5CJJVLDcVEfrkiqF6fDh4ozvZLyNjJ
         2dSsNhbz1Spt0u7MHsbpw0xPl+cefZnEQiw8M1p+aOdYjdxjansRwEKELZMZAdY6wdtT
         sqv5GbFzptlOiINxst6B61/d5v57BWTHTqCwGbc1P2eg/TDyJbeyxjAE2LIod3BDaPKW
         6fItBbdiDXEIvRnBQB9AWcTzlt59r3JUVJognCR7Zkcw9jP3RjTce0iZubpMGNIDjbTX
         LGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qOpBFbV/KrIebqK2HIZy45rrzEiZyulYyPhpFuyZxc=;
        b=jdOkQ71EMcC/Dq5/GOaHNgBEPHKma2otQ/CfKBFO2Q2WkT+J0q+6/NVr1nMzLt4A7O
         4AuABPtTs7fT5+KrcpWho+innic0Rg5DmtSikfXtDrEgYogwUq+kpL5ZlG8NPznJsSxo
         QX/d1AGOifYebjlYziqTvOKHaJS0rJMFncpAEh1HYgKV8LuUScXgdTfJ68shZAbF2IwA
         5q8mRtxZ8bNkiuYD//gdByjSWQVnltcfNXcH6mn3va6TQPaLw08Iwx1N4eyGLJqp+1b6
         o0krJ7TZ4lD1d71dDW1n221wypkna7dh11C5FqVzNLu8Vqqn9tDAcQPQP3DNqK3bPHwF
         9vhg==
X-Gm-Message-State: ACrzQf0wdjICi3CK7DU0jS5+MheY4maDLrGahW5t4QPg0M1R/yq9OLwT
        +DQxgeKBtfV1GFZ/quczc8m4vvgyXgyDtg==
X-Google-Smtp-Source: AMsMyM7ymhgyUQ35Oz1mSDT0nYplyOPOnsWF7/CJpVUo7VdfVM/RdiyFrVQPIh9RVRq4GntoBc6pFQ==
X-Received: by 2002:a17:907:2c44:b0:7a9:6e50:4c42 with SMTP id hf4-20020a1709072c4400b007a96e504c42mr13106040ejc.768.1666794062329;
        Wed, 26 Oct 2022 07:21:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11-20020a50ea8b000000b004619f024864sm3605565edo.81.2022.10.26.07.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:21:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 07/12] cocci: split off "--all-includes" from SPATCH_FLAGS
Date:   Wed, 26 Oct 2022 16:20:34 +0200
Message-Id: <patch-v4-07.12-86827388627-20221026T141005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
References: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
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
index 9d04b18a5b5..b153a9db0ac 100644
--- a/Makefile
+++ b/Makefile
@@ -1300,7 +1300,8 @@ SANITIZE_LEAK =
 SANITIZE_ADDRESS =
 
 # For the 'coccicheck' target
-SPATCH_FLAGS = --all-includes
+SPATCH_INCLUDE_FLAGS = --all-includes
+SPATCH_FLAGS =
 SPATCH_TEST_FLAGS =
 # Setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
@@ -1310,6 +1311,7 @@ SPATCH_BATCH_SIZE = 1
 # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
 TRACK_SPATCH_DEFINES =
 TRACK_SPATCH_DEFINES += $(SPATCH)
+TRACK_SPATCH_DEFINES += $(SPATCH_INCLUDE_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_TEST_FLAGS)
 TRACK_SPATCH_DEFINES += $(SPATCH_BATCH_SIZE)
@@ -3178,6 +3180,7 @@ $(COCCI_PATCHES): %.patch: %
 	fi; \
 	if ! echo $(COCCI_SOURCES) | xargs $$limit \
 		$(SPATCH) $(SPATCH_FLAGS) \
+		$(SPATCH_INCLUDE_FLAGS) \
 		--sp-file $< --patch . \
 		>$@+ 2>$@.log; \
 	then \
-- 
2.38.0.1251.g3eefdfb5e7a

