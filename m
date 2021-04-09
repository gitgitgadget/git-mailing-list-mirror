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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9648AC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F682610CF
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbhDIPDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbhDIPDN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:03:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2025C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 08:02:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e12so5934089wro.11
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNx4XBEHzST1L/CV5MgMN2FhGlp1yrFPSbC7R8pfJkY=;
        b=I630HR36N571g2dPm9bq4T2/nB53kVioOeNII26H5a838hNgVzjPKkA/fUjP/bUbbj
         ldowWosfE6MOsJQDAN/XxDT+FoeErru7kPgj39iHgaJG8RTA6+1Y0op6JqyRmIvPNqik
         CQzQjvrUlqjcb6pw3K3F6glPkp6LQ10SX4CVzQ4j636aRyHaf4IKQUXKybKX2ebaicFy
         maLD+JRHq/fh7+9BN2Wd31wPGYgMcaXKe/iCVUSYdITgZakAVGLPM836zW+Jj80NpCj0
         3LujQZDHoK0cwHL1hmGJ05wFQgd+sO1drr4Vo0m17xDwXuhah85q7MMFiJt0msm3gW0c
         Mk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNx4XBEHzST1L/CV5MgMN2FhGlp1yrFPSbC7R8pfJkY=;
        b=WDtE0XWk0tP8VkBnx6Gjtt9Ew82f5cI5VFoYmNVXHCfOtlVSZYdR+ETc3WHFrA89so
         vnoe+XPB3PB1vYt2zC7Kxrfm2W6YuEVyovqAVATjzkrHvbVTjtVQJ8Z1sNHOBHF5frkf
         eM9pcoM+Ogib2/gpd2d3OhMRv3HO1wGmm1bWXIC+ih+6WmIhZ/U+bwVN6XWqfkM/1ysA
         t1xqZtYDpVvmNKfewHALn39yVeQTxhK+qQHLo4ZproDjTzWiLk9DpXnPW2dHCEYLWPsK
         09B4pKZf2KyUo12STD0sRMd5tjzQWNHTrGvRDaMrtFlN/cPY37UX15ST0shPFl8iu4Dn
         tB1g==
X-Gm-Message-State: AOAM5300Iks5aiOpF8/DGNpId6EePCYyJUBl6wpeBZDP0H+qKE3yXLhY
        vW9ZF8iEO95X1zfdY+7s6kkoG3lr4LCoUA==
X-Google-Smtp-Source: ABdhPJwSwU9guEQmz8ylW7mf5Uk5a0QHHiq9A1UzNvUGclp9est+QNBUd5qPmOe4Hr9rSaUk0w5mpg==
X-Received: by 2002:a5d:66c9:: with SMTP id k9mr17796678wrw.278.1617980577188;
        Fri, 09 Apr 2021 08:02:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4sm4334022wmh.8.2021.04.09.08.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:02:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/7] Documentation/Makefile: make doc.dep dependencies a variable again
Date:   Fri,  9 Apr 2021 17:02:45 +0200
Message-Id: <patch-2.7-8046e7941e-20210409T145728Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.622.g1b8cc22e65
In-Reply-To: <cover-0.7-0000000000-20210409T145728Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com> <cover-0.7-0000000000-20210409T145728Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-introduce a variable to declare what *.txt files need to be
considered for the purposes of scouring files to generate a dependency
graph of includes.

When doc.dep was introduced in a5ae8e64cf (Fix documentation
dependency generation., 2005-11-07) we had such a variable called
TEXTFILES, but it was refactored away just a few commits after that in
fb612d54c1 (Documentation: fix dependency generation.,
2005-11-07). I'm planning to add more wildcards here, so let's bring
it back.

I'm not calling it TEXTFILES because we e.g. don't consider
Documentation/technical/*.txt when generating the graph (they don't
use includes). Let's instead call it DOC_DEP_TXT.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f0597777b9..164d5ff2f9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -3,6 +3,7 @@ MAN1_TXT =
 MAN5_TXT =
 MAN7_TXT =
 HOWTO_TXT =
+DOC_DEP_TXT =
 TECH_DOCS =
 ARTICLES =
 SP_ARTICLES =
@@ -45,6 +46,9 @@ MAN7_TXT += gitworkflows.txt
 
 HOWTO_TXT += $(wildcard howto/*.txt)
 
+DOC_DEP_TXT += $(wildcard *.txt)
+DOC_DEP_TXT += $(wildcard config/*.txt)
+
 ifdef MAN_FILTER
 MAN_TXT = $(filter $(MAN_FILTER),$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
 else
@@ -288,7 +292,7 @@ docdep_prereqs = \
 	mergetools-list.made $(mergetools_txt) \
 	cmd-list.made $(cmds_txt)
 
-doc.dep : $(docdep_prereqs) $(wildcard *.txt) $(wildcard config/*.txt) build-docdep.perl
+doc.dep : $(docdep_prereqs) $(DOC_DEP_TXT) build-docdep.perl
 	$(QUIET_GEN)$(RM) $@+ $@ && \
 	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
 	mv $@+ $@
-- 
2.31.1.622.g1b8cc22e65

