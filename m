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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D96C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E83386144C
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhENMQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbhENMP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:15:59 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317B0C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:47 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id f184so8049066oig.3
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UteF4PXNqM3a2sDG1d6xPdafs9y23MarhGlVM7jL2l4=;
        b=VyeD7AKu1/LYzSQ4op3nnJqyStH1KZDylH3F6sCFRpZr0QUOl7/kusYBJEeTpqBQIk
         /sMaAjLFjO1o4PvqCxhPPuYmj/iE9eJyQHE6KCxZTd5wYNlSC5+LXa9G+Z8hyt8oJ+V/
         r3HUMSlibrtE4AVT9+Tmqryub3ae0pvFWo9KSs6hn8f4MVPQeieJoHpV47EXEHqrg5jU
         cnBbAYLZt3l3WXjN1Eku8lToRRCH84nrnakPN/8VQM2Esb3DVEVo4Kxkeo+UDE1RNBnl
         XrhMLi5S12i4xY1Z/Wjpie9jEswq96FwV+PpFaBfALpk5hT+bCv6qHYWGqCqJ5mPIuIA
         cI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UteF4PXNqM3a2sDG1d6xPdafs9y23MarhGlVM7jL2l4=;
        b=II74hg3LpeiA2Tzp7sdBaQxznc2aZxaQW2eSr+w9JlnWNDQ6Z3LIr17GSYHAGzNizQ
         hB+SoEPpmQtawOXayLbfmndC46XPFU3xcomZOG6QolRH8kz/WPqFU9Da44C/VXwY7ZEC
         stSqrnr83yC/Afv92rJWC4iz8IaetMo1FXJEbvq6kz5XjJc6NiZEBzTrlprXN8EOF62g
         kGEiUYSi8IoE2eTaA1oAiAPkdwXbUfumN70GJaAT/F/FdmVbDjEBJ0eyTIr7tfWeIRUB
         LUghVJG781AWHs8K2Bn5/KQPv2cGy9sSvES+aB1fK/CFGU3g7NDXzqTjzU6SAjb3Zq2y
         Jj9A==
X-Gm-Message-State: AOAM530FTBJEhKdlHosvVmsmUJs7Lqw9mBs+kTTISA2YnSoVRBaqAwfz
        4bo7+eu1X9RhJUxqgXo1qipmk7k6BmIfhQ==
X-Google-Smtp-Source: ABdhPJy7ZNgrBSAakQpa8UpogZqu5LJP4nVdFl1GddMcGpg1ykmmT1rL/tKP4Rhbk79GFeCS/gjg/A==
X-Received: by 2002:a54:408c:: with SMTP id i12mr24053774oii.77.1620994486436;
        Fri, 14 May 2021 05:14:46 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id p15sm1222996otl.23.2021.05.14.05.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:14:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/11] doc: join mansource and manversion
Date:   Fri, 14 May 2021 07:14:30 -0500
Message-Id: <20210514121435.504423-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514121435.504423-1-felipe.contreras@gmail.com>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no real value in having two fields when one does the trick.

Also, this add the version for asciidoctor generated man pages.

Fixes the doc-diff:

  -Git omitted                       01/01/1970                        GIT-ADD(1)
  +Git                               01/01/1970                        GIT-ADD(1)

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ce9cea0817..a514a4e72c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -137,8 +137,7 @@ ASCIIDOC_HTML = xhtml11
 ASCIIDOC_DOCBOOK = docbook
 ASCIIDOC_CONF = -f asciidoc.conf
 ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
-		-amanversion=$(GIT_VERSION) \
-		-amanmanual='Git Manual' -amansource='Git'
+		-amanmanual='Git Manual' -amansource='Git $(GIT_VERSION)'
 ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
 TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
-- 
2.31.1

