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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7EFC433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1970961156
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhIUW4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhIUW4u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 18:56:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EF3C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:55:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t8so1327896wri.1
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRhq0BYVxeQoJWKUfr8w0qQjhFzZ3GDEm+N98b7upD4=;
        b=Wgmym1uGimNat/F4pG3KgLm6EXCKtZrebN5GGScbcJb5yG2Vxia/X/hsAtemBNXyXJ
         gfehxhITP3O6RrtPqDJF554pj33d2NNpiSrjLzA5Cw94Q0OWazNVjaD9KuPU9sN6Vghg
         eK6FDC50pqQrBy0qejUkouceu4vUZAoQE4/r+nwSVaydx9c39H4bHPN1azLFr2IgX0AD
         gHF8KpJRC9/GAWVIXkEAgGR9I0bditGaOuxONO5vmjminQ+AsVgaJ9SdHXM9VfYgJdEZ
         tdg2wLDGjgam3rBcKsScSE/zxhw6dMciAaZI4JU9zTxLxpLwFwsHPOXrbpdq3d4QWhOG
         FgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRhq0BYVxeQoJWKUfr8w0qQjhFzZ3GDEm+N98b7upD4=;
        b=6aVqDhaju1CisPLJRNo/FWcW6Rb3cqjc31rGhD0Q4Q6jCFdnj6eXnF1Ki13/7lioqg
         0ncaUNLRkx0IgN0JsetIrijW7DA2GAB0n8YQbf/K5OOd2XK+OCqV1EDG7bYVRqxY7ve/
         PdPzIBgRiDWAnsiOShqbmGGbr4Lrs7OZbj+KJd1Jz05RZVgxTEusJB6w/YIl1XUJrHcp
         pH2jGV/1451dHTSHLTKBr+yLzXrTqyGjYrsrSg6XcsgmctlD/2kdWFLCuTOmkWU3zIO/
         sgcbJNzTcnmIqoaJ55JEeElcl/pEMav91HgFjTMEzYQzonwrkliUr40Ab1xz7gWQks0q
         ozNA==
X-Gm-Message-State: AOAM533sPT/IvkPXv4x5ovuG0VMtFtkHzzH3bZCWJM62/M4KKu3uaxoo
        SbtTUcXgACOhNb9iFr6D048KaJ1Ew3CRBg==
X-Google-Smtp-Source: ABdhPJz4G7SoJ9i1m/JgheYsYNjLIPagEZsQCJHJFr8HRo+cVrVwZbLtdaDfsC1RII49mwaTrMfp7Q==
X-Received: by 2002:a7b:c056:: with SMTP id u22mr7276229wmc.15.1632264919582;
        Tue, 21 Sep 2021 15:55:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s3sm399474wra.72.2021.09.21.15.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:55:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] Makefile: do one append in %.hcc rule
Date:   Wed, 22 Sep 2021 00:55:14 +0200
Message-Id: <patch-2.3-9c4cedacdce-20210921T224944Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a rule added in added b503a2d515e (Makefile: emulate compile in
$(HCO) target better, 2019-09-25) to use one append, instead of ">"
followed by a ">>".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5b09f67aab0..ce4063a031a 100644
--- a/Makefile
+++ b/Makefile
@@ -2914,8 +2914,10 @@ HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
 HCC = $(HCO:hco=hcc)
 
 %.hcc: %.h
-	@echo '#include "git-compat-util.h"' >$@
-	@echo '#include "$<"' >>$@
+	@{ \
+		echo '#include "git-compat-util.h"'; \
+		echo '#include "$<"'; \
+	} >$@
 
 $(HCO): %.hco: %.hcc FORCE
 	$(QUIET_HDR)$(CC) $(ALL_CFLAGS) -o /dev/null -c -xc $<
-- 
2.33.0.1098.gf02a64c1a2d

