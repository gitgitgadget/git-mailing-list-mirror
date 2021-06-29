Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B504C11F69
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 11:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E631461DC7
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 11:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhF2LPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 07:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhF2LPu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 07:15:50 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA203C061766
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 04:13:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j1so25295520wrn.9
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 04:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WtYYs0RwYic7jbOL/GtwKgPTP3BJixB6SOTsC7cax3Q=;
        b=jWqhfDvoibiX2evRBfG1HDGZo/CMabrwZKjMiuAlJYeaDEdx8H6dJj86FLxim52dpC
         nnARtqI6veVZytzI8oBFo1qS3phhOFgiXyJ7xxSw2w8qtrUd5zUXFduXiZeNcr4UjS3c
         ySh0idzZrTaOoHEXH4t5J07h5xG5PpKfLKGykoDZHt4WPTZaSmQcPHgiIz0rxFkhtPGh
         iK/jhfWhu6HnNuGyrUKv1xgQS4wicAuymuZl3TgkcGneBpVIeuB4vBbDMhmGZI++iWnq
         zZ1BGt/nQQHh6/2znYs/Cfqg1pLvYwax6VOUn7u690GRcXNs1mEVtxtbnOA3p5vMykvt
         IHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WtYYs0RwYic7jbOL/GtwKgPTP3BJixB6SOTsC7cax3Q=;
        b=FaLdksDNNAmXhlhuyRv6X4743ENoxxxQoVSzJGMXe5BJqpYURLEhDaUlQwDwDAQupD
         o/Mir/25tbWj0KQYqoXvmtuniQagDxSMnDK1z583RTWyga/YmLidrsQosdDNduFlXYru
         2jEZSQCHazdWm0LqUOVr4JdYZ46+4VKpL24H++jROH+kLB3Whc813peakoe83XGPEj74
         XhXHKjy6QeBCZwUCCD7eArRWkqztTVwJ6KhUCo8N3q6ds+gX6jxGbZxt9qa8Ud5x5UL0
         xPotVuS1mGsdsskwzxtfYp18ts4bLMQDjzCGbGzSqte1BB7bJqvsXTWHPRI4/YJGVmzm
         yOpA==
X-Gm-Message-State: AOAM532upmN/o5DmX5Co3Dc3oIuOAXbCpi7C4pQekR4F8YKrUogC4bxD
        7QKe4DWhny2lpbat9PnqmAWU1q6X4ndp6A==
X-Google-Smtp-Source: ABdhPJxOCh44lcibX2jfOOP6r/NjOjxDpKWzDjSldT0UD8+54uJR+y7iN+LyYHCIdQQrMbpgrzYCDA==
X-Received: by 2002:a5d:4b90:: with SMTP id b16mr29849610wrt.123.1624965200293;
        Tue, 29 Jun 2021 04:13:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1sm2499370wmn.10.2021.06.29.04.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 04:13:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] Makefile: move ".PHONY: cscope" near its target
Date:   Tue, 29 Jun 2021 13:12:55 +0200
Message-Id: <patch-1.5-dd6cfd6022-20210629T110837Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.613.g20d5ce26552
In-Reply-To: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com> <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the ".PHONY: cscope" rule to live alongside the "cscope" target
itself, not to be all the way near the bottom where we define the
"FORCE" rule.

That line was last modified in 2f76919517e (MinGW: avoid collisions
between "tags" and "TAGS", 2010-09-28).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c3565fc0f8..4dd9711a65 100644
--- a/Makefile
+++ b/Makefile
@@ -2737,6 +2737,7 @@ tags: FORCE
 	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
 	mv tags+ tags
 
+.PHONY: cscope
 cscope:
 	$(RM) cscope*
 	$(FIND_SOURCE_FILES) | xargs cscope -b
@@ -3245,7 +3246,7 @@ endif
 
 .PHONY: all install profile-clean cocciclean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-.PHONY: FORCE cscope
+.PHONY: FORCE
 
 ### Check documentation
 #
-- 
2.32.0.613.g20d5ce26552

