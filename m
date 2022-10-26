Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932C7C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiJZOVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbiJZOVC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:21:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD431349A6
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:21:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r14so41743348edc.7
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGd8v9hyxJgQw9vW30YT1BwCWL+CCxp+Ku025BeaXCI=;
        b=nDEJ5vyizj572VX4nmaCGiAM/ywbcvyKW29mual43Zf/ExPRmWMYdjhNoDoIvxGiG6
         eODuYu1zJdAymN53KNAzIVeAGDcqzkz7BsA6CbDdF6b2gFx85McyMLgzxO9VBjedpRMJ
         pxA/bdJIPckthcwZh3cBibu7VNoFOnthOsICpxyXZcRaxaVhbyBhVkJSyzjr58QJNDbD
         1FyEX4mQ8rf20crCBvRHqKjPcObhjuUBqhCLHkTYhCBxCgHu/HRTjLJsuy39UVxb4/Y6
         5umPDow581eSQ4cSiXInWgNk0V1dJKGVDHFxHbazucrCFYCOt7oommHCBMrLR3ZpHFIM
         lMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGd8v9hyxJgQw9vW30YT1BwCWL+CCxp+Ku025BeaXCI=;
        b=JZ5MUzowZIJ1W8d/JwfW/pMMfhCvA4P1WpXDQGY70U13qa5WJ/X6e0frm9+ELx8sT1
         OD/utJ3M5pfZVq402DuIyJ4phtx+Os0Q64rlzdgHsAUdWoP/ookb7DFQyKmaLnIY1Kg8
         5lrSPz1q8XzmbkmiLcFZIyLM5Okqehw2dRaawV41CBUzd3jp1c1VVmsbngHRDgBuXSHC
         n18g5ZRnwODgukWwFcVCKeoJYXgtm8VFW+y6xfhMrwsKHzlH+Y8UdI22MqsaS0af7FgW
         ibkCVF3XpLMQbPmVCyEg0Us6knBDcZtQ6Coi/3PDLY3AQc+Cv/kJlQltOXOf8CmY2vWR
         mL9w==
X-Gm-Message-State: ACrzQf35YZQ95wc9KgbHrNk6Vh3F7xGUmMHoalGzhaDLr6IOLc4jhwp0
        m8KyKBqPrZccM6DhuXnN9lN70OnqLAA=
X-Google-Smtp-Source: AMsMyM7Uf/YJTB5F8YLdminZiLKOHzRP2Gl/za6dPeEWOuwhYbdYM0lPJ2tQxnPoITgxrWANzjuITw==
X-Received: by 2002:a05:6402:350f:b0:45d:1d86:9ec9 with SMTP id b15-20020a056402350f00b0045d1d869ec9mr42085832edd.266.1666794059833;
        Wed, 26 Oct 2022 07:20:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11-20020a50ea8b000000b004619f024864sm3605565edo.81.2022.10.26.07.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:20:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/12] Makefile: split off SPATCH_BATCH_SIZE comment from "cocci" heading
Date:   Wed, 26 Oct 2022 16:20:32 +0200
Message-Id: <patch-v4-05.12-11b9227722b-20221026T141005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
References: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
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

The wrapping for the "SPATCH_BATCH_SIZE" is now a bit odd, but
minimizes the diff size. As a subsequent commit will remove that
feature altogether this is worth it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 7d4518653ce..585d259c841 100644
--- a/Makefile
+++ b/Makefile
@@ -1299,10 +1299,11 @@ SP_EXTRA_FLAGS = -Wno-universal-initializer
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
2.38.0.1251.g3eefdfb5e7a

