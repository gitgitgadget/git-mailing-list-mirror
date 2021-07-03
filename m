Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D24EC07E98
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 21:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD6F613F4
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 21:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhGCV3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 17:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhGCV3N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 17:29:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFEEC061764
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 14:26:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m18so17043322wrv.2
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 14:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=mVlWdM/mpubrP5VxwHLizK+4CUI7Mineh3KcPUKh1no=;
        b=pUcSJ1me4diam1yEE3uqo7Bjr6KxjmVbe0gsm/UgQbgndEh4zi7IgrvtcWisVU7E5P
         6/ETf3FyHcZe7w7CcV6j1kvyM2fj0nzA0kSZyp19f0Y0oPmGhwfGkWEMoFeN5rl6kpBB
         4zNG3uomVjZOYdA7pllMu1KaCKrPdbZ9QHrNzNgzS42/hWPclWHLMEOEOQVMFvQhD3o4
         0C3Nxr/6eEN6HgnG57nv6YmQqrTx52YOBv56n1SzwEOF5irpsIAXfWnWfsG6iYbqFF1x
         SsDFlhJ+oe997anBZoHaYEHSJBMq5HpuOJKx2l930NMN2qptxo2gGrJuW37xgNL2XiPq
         0N5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=mVlWdM/mpubrP5VxwHLizK+4CUI7Mineh3KcPUKh1no=;
        b=qmvOZNZYQ6K3sRekhZ9CaXD1OF3mPolO0ckAiRiN8XAvugg6u1v+F7X+Qdaewf9Bh7
         4T0hXC16o9eB6hawur/btM6Ka0sM7dPdwVl43l71EZ28uB9EZTT/lfeNniWHjmrzZckS
         MiA5aoqSUGq3GYTCHOtHtks0Wkb7au/E3bILn2NW2HFGR1TFy1WM62Cc4wNjarDGznHD
         ccQZwWw3dAOKZQViuf7wwxC3UNihLAU9zyL9rv5ldmeHoVkxeB1yULUvz8BlyZ+vB0QP
         cXg/d2ntOEB8XEvQkdhGMRQfo1HxZMkO2BY8KIXiWYOwZosABJynHCJnSLgfar1eZjS/
         kPkw==
X-Gm-Message-State: AOAM532L2bqixpILEVWFxZlhcQlzIK396wH4xSaGJzZ8Ys5ohstoTZMY
        JiuhKZgCmHhE68mIrAP0waWMf8EU44U=
X-Google-Smtp-Source: ABdhPJw24TflMO+OFFEh33bwwZgOw8n7WDhxidSPAlU+2hq0juVeHn6PspuC6adx1KAnxbddn+jYfw==
X-Received: by 2002:a5d:4bca:: with SMTP id l10mr6948515wrt.236.1625347596904;
        Sat, 03 Jul 2021 14:26:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm1102129wrx.22.2021.07.03.14.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 14:26:36 -0700 (PDT)
Message-Id: <c31d2e7f44a8b27210dbde9bc6938ce16a9e0c17.1625347592.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
        <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 03 Jul 2021 21:26:30 +0000
Subject: [PATCH v2 5/7] artifacts-tar: respect NO_GETTEXT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We obviously do not want to bundle `.mo` files during `make
artifacts-tar NO_GETTEXT`, but that was the case.

To fix that, go a step beyond just fixing the symptom, and simply
define the lists of `.po` and `.mo` files as empty if `NO_GETTEXT` is
set.

Helped-by: Matthias Aßhauer <mha1993@live.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c3565fc0f8f..04e852be015 100644
--- a/Makefile
+++ b/Makefile
@@ -2675,10 +2675,13 @@ po/git.pot: $(GENERATED_H) FORCE
 .PHONY: pot
 pot: po/git.pot
 
+ifdef NO_GETTEXT
+POFILES :=
+MOFILES :=
+else
 POFILES := $(wildcard po/*.po)
 MOFILES := $(patsubst po/%.po,po/build/locale/%/LC_MESSAGES/git.mo,$(POFILES))
 
-ifndef NO_GETTEXT
 all:: $(MOFILES)
 endif
 
-- 
gitgitgadget

