Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF137C433EF
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 14:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiGEOCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 10:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiGEOBs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 10:01:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F5521804
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 06:47:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bk26so2570408wrb.11
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=20SPYJDiXJLgbC2z/wHRs6L/sACxHH4171tQuHO/8zg=;
        b=HfYYm3PfzS5foHAKHwDjW6gE3eJHbhP0wAejxe6rhUlw9XAH/oev9yV0Yl7j8/q8OY
         5YNSM0d5IsBJ8agyQz6tzgDKO+KGlwCwzfjWXnd3K798W4rdj6fpz+FvkuFBNW4y9+gy
         PvtiTx5DhIdnMoOHxf5OMHsMCZrWiw4lhY1x0xyus4mc2p7FAn5c039crvWoeGJCKXJL
         TYVHqkpyYKuZp9dIB9KUnLGL7/xgAwyJoVgYRJBS/j+mRPigZjSVMJ8euJeCnnwUdKfL
         Gy0zG3GsD1fOyVezvalq6JtiORVIzxlPc7puD4kR5Eb4TpuFGLifqdOISxPJBGQfZdKe
         Gwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20SPYJDiXJLgbC2z/wHRs6L/sACxHH4171tQuHO/8zg=;
        b=UktebJ9TwFLogt9ayIzOcSD8ROK6MaRdCQKKqcA6AL7gldRjsU04bV6hsxd87QvIPe
         HvbfJdvgA+EHFxaFw2YgU+pzLacPdb10APldfwKgcTkAnqHu+bUZHOvLSPjZqdTO1u//
         fKwA5M4ucYYF8+53ZkRb8G3y1FFm5Blte6r1jjpd55l3sjLvq/uw5kCbxn/PzJ0jLMgG
         UGnStk7b2xz0ru/5cVdqvERuwiTVRS285L/CpEQ4/9MLDUkYlw35uzoMTi+fpdL9J67C
         8Cyx75zfwu687GPScclio0HNB8ONp16dauDdUoyG064cMXrzHFD/vHMiL7tUCWSpi1Me
         ea6Q==
X-Gm-Message-State: AJIora9Mn0F77JQvPE/qjYuetDPNDCitwyPnUp9+vLwA0e5/FIk3zrmY
        9knZ87aX/rIqIO6NfPdDYsVRM/s51HQ=
X-Google-Smtp-Source: AGRyM1sqr8ZhmxFBdHuwC1XD2+V0AuxvGN/PQYOwAySANI7JY0LzHmx3H8X1+VHfZikm2GzFTcCNVQ==
X-Received: by 2002:adf:d1c2:0:b0:21b:e465:1e36 with SMTP id b2-20020adfd1c2000000b0021be4651e36mr33786237wrd.271.1657028828408;
        Tue, 05 Jul 2022 06:47:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x11-20020adff0cb000000b0021b92171d28sm40786942wro.54.2022.07.05.06.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:47:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/6] Makefile: remove mandatory "spatch" arguments from SPATCH_FLAGS
Date:   Tue,  5 Jul 2022 15:46:55 +0200
Message-Id: <patch-v4-1.6-fbdc2c3d66b-20220705T134033Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g50625c3f077
In-Reply-To: <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
References: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "--patch ." part of SPATCH_FLAGS added in f57d11728d1 (coccinelle:
put sane filenames into output patches, 2018-07-23) should have been
added unconditionally to the "spatch" invocation instead, using it
isn't optional.

Let's also move the other mandatory flag to come after
$(SPATCH_FLAGS), to ensure that our "--sp-file" overrides any provided
in the environment, both --sp-file <arg> and --patch <arg> are
last-option-wins as far as spatch(1) option parsing is concerned.

The environment variable override was initially added in
a9a884aea57 (coccicheck: use --all-includes by default,
2016-09-30). In practice there's probably nobody that's using
SPATCH_FLAGS to try to intentionally break our invocations, but since
we're changing this let's make it clear what (if anything) we expect
to be overridden by user-supplied flags.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 04d0fd1fe60..c1d02f04499 100644
--- a/Makefile
+++ b/Makefile
@@ -1286,7 +1286,7 @@ SANITIZE_ADDRESS =
 # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
-SPATCH_FLAGS = --all-includes --patch .
+SPATCH_FLAGS = --all-includes
 SPATCH_BATCH_SIZE = 1
 
 include config.mak.uname
@@ -3131,7 +3131,8 @@ check: $(GENERATED_H)
 		limit='-n $(SPATCH_BATCH_SIZE)'; \
 	fi; \
 	if ! echo $(COCCI_SOURCES) | xargs $$limit \
-		$(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
+		$(SPATCH) $(SPATCH_FLAGS) \
+		--sp-file $< --patch . \
 		>$@+ 2>$@.log; \
 	then \
 		cat $@.log; \
-- 
2.37.0.913.g50625c3f077

