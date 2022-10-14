Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F332C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiJNPcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJNPbn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:31:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DD21D52D1
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bv10so8125299wrb.4
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRt+/yoI9E45KVGiTW5R8rH/AgC0ajGEGQ00fVmHVMs=;
        b=kNPiJ/y77ym2saVcqBxE54aka86IOmM2O7xCk3eOjHgtqu8uodj5TdLX1rjhWq9SyJ
         4qRZuSIL4wGSLLhN+BL2KvPPGuww5MjBXWxh0WHvGZO7HZHxFP3BBMbMVPrhNXwrjPs4
         8lkfHTLQJeudymJfzpZsr3RRwkUkSMsABQHFxDETy/Nsv4v1OnxvfjkLgal9s+5JDyi1
         9l9DJbMUALPWax0Qkt4T7qNZcYT834DpjiHSywKxTHSPGen2to6tipL+KEbMTg09iLHG
         fa25UBH9BXi13ZtV2LIZx5TPv/2LYzisK39T6qNpSYqSwbFxK91QFYFR0GrJEx5df/ci
         z5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRt+/yoI9E45KVGiTW5R8rH/AgC0ajGEGQ00fVmHVMs=;
        b=gSv4WmXG416r8sAuWcoj9iNZS1aXS2fQJumjD6XMmlz4wCUioGFtIPN22MvNmpZesQ
         oO5UE25Efi/XqPc/gP3VNdD0KLoi/1L7BnoCekFPO9z1476jlmJhtsDPzrwZaa2Ql+wu
         LxtCCi4wDbr5q5DHkZTC3dMw/2zUjJvxF8bywkKPgECRTlUg0S5e3VZ2JwJjsefGasxT
         niZSwwD/TvS4MXbCgPNAdyVu9p3wguseyhAMVgK0y3E3M135KSx+uoXTMv4hpceos9O1
         rW8rWNKzWlaRhrHBImglpyt0akuxyli6zutXu8876jmzovohIw08wfRQzEE4ZJFYNsBz
         4U5w==
X-Gm-Message-State: ACrzQf3jsIeXlb9NI/ngY9dKlI1XKZIwI4RYKejs0JgA6ZfgEkK07osx
        u/Ujs1TDFwzVOilFZarCq5lHJ22qdgSGJw==
X-Google-Smtp-Source: AMsMyM6GOR0zzrftTxRqnCu/KK5NVS4Jh4JFDrQYmlBLVWutODowYtEFWFhwBFAgduOHnYGTAyPh6w==
X-Received: by 2002:adf:f804:0:b0:22e:5a9a:15d9 with SMTP id s4-20020adff804000000b0022e5a9a15d9mr3844586wrp.390.1665761497329;
        Fri, 14 Oct 2022 08:31:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b003b47ff307e1sm2219053wmb.31.2022.10.14.08.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:31:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/11] Makefile: split off SPATCH_BATCH_SIZE comment from "cocci" heading
Date:   Fri, 14 Oct 2022 17:31:21 +0200
Message-Id: <patch-v3-05.11-ab25b586f38-20221014T152553Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com> <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split off the "; setting[...]" part of the comment added in In
960154b9c17 (coccicheck: optionally batch spatch invocations,
2019-05-06), and restore what we had before that, which was a comment
indicating that variables for the "coccicheck" target were being set
here.

When 960154b9c17 amended the heading to discuss SPATCH_BATCH_SIZE it
left no natural place to add a new comment about other flags that
preceded it. As subsequent commits will add such comments we need to
split the existing comment up.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d62f2311107..2a106f633b9 100644
--- a/Makefile
+++ b/Makefile
@@ -1298,10 +1298,11 @@ SP_EXTRA_FLAGS = -Wno-universal-initializer
 SANITIZE_LEAK =
 SANITIZE_ADDRESS =
 
-# For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
+# For the 'coccicheck' target
+SPATCH_FLAGS = --all-includes
+# Setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
-SPATCH_FLAGS = --all-includes
 SPATCH_BATCH_SIZE = 1
 
 # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
-- 
2.38.0.1092.g8c0298861b0

