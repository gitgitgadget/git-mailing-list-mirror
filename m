Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86166C433EF
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 14:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiGEOCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 10:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiGEOBv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 10:01:51 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E753121816
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 06:47:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o4so17662436wrh.3
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dMW9k3Bz7d8JVlelpCU8ANLR617i9+i7Ca7rmhIuW50=;
        b=P1wSJBzRxBy7S9+DhFU2Fq+Z64r7PJ9lZtRaJYaLhhOwxkgtBRhv4Cr4EmaKgWHv8P
         p+6lRoZqFL+XDl+J1G3tL+P7OiRweymVUdNxmvo9gFZ+ZNBXJZlA2H1D7T99Ttgivyzw
         nO8GrXLlDdqOMHyg3XFTXHnBFFbups9WPeMHLJrRtyRJVz+nggXn0SdjZJh0QoDDmOJY
         qnSWwTuBh1GjgLczaiLsldYyTXc0NXQpFV9Zsda3THAVMDntcqqY2j3sNwb5XEEU0PAl
         EHRCn5zEjjvBkTPVnmGKhdSwRi/eDXJ3P8yX+y4x7Poz6oxL6aZ0jHDIIwILkwQKBQI6
         9Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dMW9k3Bz7d8JVlelpCU8ANLR617i9+i7Ca7rmhIuW50=;
        b=G0m6JIhS7c20BFINrTXxszcBK+wHt2HAMdnjPmfqZBhSDE/9P6lOqMyPc1Mg3RIc3u
         TBhkPiehDNFo60ybzsFpPvgqPhMn+fLeABVioafHhe4uTuc9rUbKXLLVpFWSTImMlrwP
         +aqjG+p7HQuBRvR7t+SUed3qXAxoAONQz0DKBGE7+0VJhaY/Koi67fC3oKgieMte9n2z
         45S7FPT5aAeS88k8UYCchJuYRAM5gBhBAWs67+eevDs2zOwmvVjNoE6V4D5cUU/ozXkM
         3rydR/SdNuXdD9KD33R4Ghe8qcqfTntPM0Fo8QY+ikbk6Q0aU7Vj9Q4vqDbWFj74JELT
         YVEw==
X-Gm-Message-State: AJIora9iSwzr2g5c+DAe8jCAHLlCwL3i4q2y03JfjypM5Y/o+VhLnVKS
        pSsGvrqQ6Uor5SkKSNTTyQ9xb9j1csQDjQ==
X-Google-Smtp-Source: AGRyM1sibEJbtddTHaAgMExZgcY6hG4f/U4VYT2VJ8OaXhU0RsvxfrSBgk+AhRXeUGF2QzJiZcvBcQ==
X-Received: by 2002:a5d:6888:0:b0:21b:b983:de53 with SMTP id h8-20020a5d6888000000b0021bb983de53mr33668568wru.0.1657028831246;
        Tue, 05 Jul 2022 06:47:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x11-20020adff0cb000000b0021b92171d28sm40786942wro.54.2022.07.05.06.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:47:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/6] cocci: have "coccicheck{,-pending}" depend on "coccicheck-test"
Date:   Tue,  5 Jul 2022 15:46:58 +0200
Message-Id: <patch-v4-4.6-48810f7390c-20220705T134033Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g50625c3f077
In-Reply-To: <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
References: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the newly introduced "coccicheck-test" target run implicitly when
"coccicheck" itself is run. As with e.g. the "check-chainlint"
target (see [1]) it makes sense to run this unconditionally before we
run other "spatch" rules as a basic sanity check. See

1. 803394459d4 (t/Makefile: add machinery to check correctness of
   chainlint.sed, 2018-07-11)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index c4064f8394f..669828a2a6b 100644
--- a/Makefile
+++ b/Makefile
@@ -3161,9 +3161,11 @@ $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinell
 .PHONY: coccicheck-test
 coccicheck-test: $(COCCI_TEST_RES_GEN)
 
+coccicheck: coccicheck-test
 coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/coccinelle/*.cocci)))
 
 # See contrib/coccinelle/README
+coccicheck-pending: coccicheck-test
 coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.pending.cocci))
 
 .PHONY: coccicheck coccicheck-pending
-- 
2.37.0.913.g50625c3f077

