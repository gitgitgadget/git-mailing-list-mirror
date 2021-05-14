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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE01BC43460
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57146144C
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhENMPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhENMPv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:15:51 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F8EC06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:39 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so19953984oth.8
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYs7BMRj1obWvw1DLh1in2k6rfxujAKOs6KmlKeI2wk=;
        b=eftQEtJ//oH3p8isrvHLrua/EQyfNGzAdXZXDb+6fGxDYoK49cmt3Y+LvTZyBOyOKy
         6uwnkJYD3umdLV8/763ba31ppRPq1NINLqfIoMLkvzSiMah0ZOXo+98YDCRHcX4dXALn
         uT2lj9L9sDShBerHZTcqzoG/SyiPzhtxSd0HNPuauS0s5saj9/+wnd0tqSjTe63Wrw25
         2NDy1WSCa09w9BI6zDACg8sAlk+zW308oqT7luv1grj7QZbWM+05ArqqTm0ff9UOwniu
         M2Nt1SiULUMO4lKqhs1cCTq2ge/DI36PkmgiXIL0Mu+Fdld8RJmwPcEJm1ZBtLabMeh5
         l6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYs7BMRj1obWvw1DLh1in2k6rfxujAKOs6KmlKeI2wk=;
        b=W1P+P5m4Mry9gt/E6NeWF/e7N3png7ARkFTBR/KG9yeW4iEItTOYB0Vx+Pn/wxBUHa
         pSfdjKQ6hRW3HUlUPCyQrrD/b2fXkEVyioY1vKN3FUb7aF91SZnki/EmhGmySNCE82Ff
         VEepgkcf1FcP9N8juo4bOKWUpao34L/3GAFz9u/fV0WisJKbZIgrdagk7g1b11RK+nMV
         2wYzljLOKdpoKibh4xEaldSDCLzU5mdiFptc7/Z+kXSougMsHSqUketulP20+l6Urvbb
         /pW7btzs8opfDSi6Nsc0uuJovdvQtawZyp9rjTmb9z8f6w5B0FljS888pbysHUWB+sja
         iBlg==
X-Gm-Message-State: AOAM530xC4KVhqFWxYDRfn54ncN492lr92wCpaXuyCQ8auValS96maUR
        PIpAs1yoQKMB432ZreQcVUzYbizQXv1HVA==
X-Google-Smtp-Source: ABdhPJwkzY3NQ2BYnNSBmqF7y5KFGvdR0LQCXQOr5ZWvwiHXyoLU3eOq2EE75mlAtgw6oNVITbu/pg==
X-Received: by 2002:a9d:5a5:: with SMTP id 34mr40462454otd.353.1620994478721;
        Fri, 14 May 2021 05:14:38 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id j66sm1313057otj.50.2021.05.14.05.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:14:38 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/11] doc: allow the user to provide ASCIIDOC_EXTRA
Date:   Fri, 14 May 2021 07:14:25 -0500
Message-Id: <20210514121435.504423-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514121435.504423-1-felipe.contreras@gmail.com>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without `override` all additions will be ignored by make.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f5605b7767..981e322f18 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -191,9 +191,9 @@ ASCIIDOC = asciidoctor
 ASCIIDOC_CONF =
 ASCIIDOC_HTML = xhtml5
 ASCIIDOC_DOCBOOK = docbook5
-ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
-ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
-ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
+override ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
+override ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
+override ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
 ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
@@ -206,12 +206,12 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 
 ifdef DEFAULT_PAGER
 DEFAULT_PAGER_SQ = $(subst ','\'',$(DEFAULT_PAGER))
-ASCIIDOC_EXTRA += -a 'git-default-pager=$(DEFAULT_PAGER_SQ)'
+override ASCIIDOC_EXTRA += -a 'git-default-pager=$(DEFAULT_PAGER_SQ)'
 endif
 
 ifdef DEFAULT_EDITOR
 DEFAULT_EDITOR_SQ = $(subst ','\'',$(DEFAULT_EDITOR))
-ASCIIDOC_EXTRA += -a 'git-default-editor=$(DEFAULT_EDITOR_SQ)'
+override ASCIIDOC_EXTRA += -a 'git-default-editor=$(DEFAULT_EDITOR_SQ)'
 endif
 
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
@@ -375,7 +375,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
 	technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
 	$(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
 
-technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
+technical/%.html: override ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt \
 	asciidoc.conf GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
@@ -425,7 +425,7 @@ $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 
 WEBDOC_DEST = /pub/software/scm/git/docs
 
-howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
+howto/%.html: override ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
 $(patsubst %.txt,%.html,$(HOWTO_TXT)): %.html : %.txt GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC) \
 	sed -e '1,/^$$/d' $< | \
-- 
2.31.1

