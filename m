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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41DEC43462
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964C1613BC
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhEEMWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 08:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbhEEMWo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 08:22:44 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6CCC06138A
        for <git@vger.kernel.org>; Wed,  5 May 2021 05:21:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h4so1595657wrt.12
        for <git@vger.kernel.org>; Wed, 05 May 2021 05:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/w3a/5YsJ3EmhbRx2MTgM28KbQdXmXa4ynjfE/V1HPk=;
        b=stY57UmqmAub6DO2cvvs/T9joGqFSKn3UzLu9InCtujvRtnJ4ecnjFY3AjwxGqF0d1
         WEnf8sXvxK/sdcyFRps8cTbb/mfKrKfQhpe17Jfzul3qA4vHw++xGpkb+GOxkCTvkO6i
         Q7ZxxCQVf+2EJAUBBPjgNRloI2gNoyWH+mvzZTj9q5Jr5o1y/42EqLmBIQmuSgh7ke0b
         AxXjeBDavvQoQ1Fj5jv5XO09mMGzy+rvUGMihd0S0qwncbUh0Fi5OdSXBJf7SGuawOyU
         W5LBUFaUQpCenGPJm6gU1E6W0nVsy89CGAO2DLN0B8YqCjHSIrvrA4YW2eSiU8/1W4eb
         NXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/w3a/5YsJ3EmhbRx2MTgM28KbQdXmXa4ynjfE/V1HPk=;
        b=fogXxkFpp5u4Mb1/miclnZd2IkMD+hgaD2Au8xtmxivyibzlurnAs0tivkLN5gBj82
         xJ9rcLlGvf6KJxl5ql45YFgaS3vEZEMcNzuiD16giyh2/WZpwy5xgX4os7nZj76pY3by
         6Ir2n7/X77DeDbeBH+9SNo1umEL0pKQ+vWs8N8QSic1aZOQitoYMMMuca+SWxWwcYZ55
         Fq0qDIFoelSr65Q7OIeYSJq05e1kLmTHBj0V63BAQtD+k98wd5taXEG7Yu7oYrVQzIXi
         PdhDC6hPMOKDyidtbxnTzoDNnMgPbLVnYfzIXPRYpI9QWXNst1ppJZKkmK446/XLnW3g
         fMtA==
X-Gm-Message-State: AOAM533hx67repZuMSP2ZERGx7GxpawAfAfi4w3Z2uB0w+A0/gA+nhuG
        BaCnRyE5ANC2zSM6oOpHY52mO6o9tWY7IA==
X-Google-Smtp-Source: ABdhPJw5W6uj7fjTilpFMsCqMu9dlo4kk+qZ9BjeRbVTWaZpXnvZeA7u1QpgoJ0VNoe9ua60y8vtEw==
X-Received: by 2002:a5d:4ac6:: with SMTP id y6mr10985337wrs.414.1620217304600;
        Wed, 05 May 2021 05:21:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k15sm19886643wro.87.2021.05.05.05.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:21:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] Makefile: don't re-define PERL_DEFINES
Date:   Wed,  5 May 2021 14:21:38 +0200
Message-Id: <patch-1.4-ed2005a2fbf-20210505T121857Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g7ac6e98bb53
In-Reply-To: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 07d90eadb50 (Makefile: add Perl runtime prefix support,
2018-04-10) we have been declaring PERL_DEFINES right after assigning
to it, with the effect that the first PERL_DEFINES was ignored.

That bug didn't matter in practice since the first line had all the
same variables as the second, so we'd correctly re-generate
everything. It just made for confusing reading.

Let's remove that first assignment, and while we're at it split these
across lines to make them more maintainable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 93664d67146..1d4c02e59d9 100644
--- a/Makefile
+++ b/Makefile
@@ -2270,9 +2270,10 @@ perl_localedir_SQ = $(localedir_SQ)
 
 ifndef NO_PERL
 PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
-PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ):$(perllibdir_SQ)
-
-PERL_DEFINES := $(PERL_PATH_SQ) $(PERLLIB_EXTRA_SQ) $(perllibdir_SQ)
+PERL_DEFINES :=
+PERL_DEFINES += $(PERL_PATH_SQ)
+PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
+PERL_DEFINES += $(perllibdir_SQ)
 PERL_DEFINES += $(RUNTIME_PREFIX)
 
 # Support Perl runtime prefix. In this mode, a different header is installed
-- 
2.31.1.838.g7ac6e98bb53

