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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF17C433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 18:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393E164E1D
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 18:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhA1SZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 13:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhA1SX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 13:23:57 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052BEC061574
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 10:23:17 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id e15so5347283wme.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 10:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HvDxpFpnGPyiTPkfZlhkZiffow7hPbSTOCI2XY/sYw8=;
        b=TSwRqUjJZiKB3IqxbgNAN9632sw05MDwAWaJj7oyO4gI07+POsB7ybfZ2xnizklWUq
         0i4TYvq+MeKpU4au2PJB9zc+SIkNdTCO+0wuiM0JbFhMqN5oH3nU2C+S/8EyGZYSkW3A
         wOidnLTcBLQH0fWJ+G+CgfHGpadOj1r8jAnSBee3e0yzAuC05KQTOmuMVFsp392uiSLQ
         jpCFuv+pyVIF25y4eSYaK/xcD1LbHhYyxp5u9uc3KCA10Tr8VvT/BUExroGTsUgqSbhv
         V8Eoi5X85BEcgc/isZ6hy9Qwme7je2csW75s8auOeMiL17hfe959l/CQjS3vDYOXyeHV
         Cd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HvDxpFpnGPyiTPkfZlhkZiffow7hPbSTOCI2XY/sYw8=;
        b=tLFgv2HFBdN4gX5u0NMQVNepqnf7bFpDDxCfQWfYXkpVfh1q0+w/H7ThNyrVQbtMBH
         Wx4GqIFFQcgC2GQt5issbhaHuxQL8p5+oQarmAtWN23ylSNksVt11iTvTiWVga23OpaD
         A00+GWxSp4z2Kbuem4GROLOZp1Vxge+qDgzOgK9I/dhjwbnEnBj235AQGA/rLFp6lIQe
         /4XDcFhIO3MJ3OAQMk6bJmQx28y5v2SjCo9mZlqBaKxdAVeqSNBYBKJNKdmmwcoGl5Th
         NJpcBtRra5ckIC/Q5KT5pNTGwUQgGtJmJXuJExGJXCT8Jo5frdjOhjaZAEGtW+r8ozPZ
         PS1g==
X-Gm-Message-State: AOAM531rUUEisRvvMhkmnRO9IRWwKB8p+nrtYcieN0EjsUayjeEGtGPL
        mAtWzYtYZMhigoltVX3l+0iqJtEhmTqIdA==
X-Google-Smtp-Source: ABdhPJzuq6BHfhDaMND2ilVNwYHPK3o2m2oY95gVEv5pTYw685ALg7niYBobM7JkzvNMjCyVvR5tuQ==
X-Received: by 2002:a1c:dc83:: with SMTP id t125mr514581wmg.154.1611858195530;
        Thu, 28 Jan 2021 10:23:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14sm7647357wri.48.2021.01.28.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:23:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] Makefile: remove "all" on "$(FUZZ_OBJS)"
Date:   Thu, 28 Jan 2021 19:23:05 +0100
Message-Id: <20210128182310.26787-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <YBCGtd9if0qtuQxx@coredump.intra.peff.net>
References: <YBCGtd9if0qtuQxx@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding this as a dependency was intentionally done in
5e472150800 (fuzz: add basic fuzz testing target., 2018-10-12).

I don't see why we need to prevent bitrot here under "all" for these
in particular, but not e.g. contrib/credential/**/*.c

In any case, these files are rather trivial and from their commit log
it seems the fuzz-all target is run by a few people already.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 4edfda3e009..65e600713c1 100644
--- a/Makefile
+++ b/Makefile
@@ -667,9 +667,6 @@ FUZZ_OBJS += fuzz-commit-graph.o
 FUZZ_OBJS += fuzz-pack-headers.o
 FUZZ_OBJS += fuzz-pack-idx.o
 
-# Always build fuzz objects even if not testing, to prevent bit-rot.
-all:: $(FUZZ_OBJS)
-
 FUZZ_PROGRAMS += $(patsubst %.o,%,$(FUZZ_OBJS))
 
 # Empty...
@@ -3321,4 +3318,4 @@ $(FUZZ_PROGRAMS): all
 	$(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
 		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
 
-fuzz-all: $(FUZZ_PROGRAMS)
+fuzz-all: $(FUZZ_PROGRAMS) $(FUZZ_OBJS)
-- 
2.29.2.222.g5d2a92d10f8

