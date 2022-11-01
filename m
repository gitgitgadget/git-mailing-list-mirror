Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF03C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiKAWhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiKAWgo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:36:44 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7095A1F9EB
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:36:11 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y14so40788295ejd.9
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AiDSlOSCsG1WOcpWmNBiOt/HYN32uZVq4wOAkmWFu8=;
        b=FWF++rA2NQCSCrV1Lgzxka2OoNoVeis8vfSm2wiNmYjNrvlLQ+XqqkWxhvXlfRUdhg
         Y45FahkYDTpq1RhjYeAUyR3jF0W7a0lKpelCjbkqP3tiKIG6SdXczjXuVe13Pr6w4oMy
         MtUQ9cGM9bkU+yyeZ28YlKMpXZl//K6NALRhC1Kl18wZR+Xq6OA0PP4HzB24Ytdcr+jG
         gBVdIVHZ2aYofNlXVr4nWhaRKYoyyYyfcKZw9Nny+jepprySw2rIIpW6C8wdjHMSZZKS
         MAgGI9N7eVG7zigd/DAHVO0jim36NK7rTGvidU9yKQ7rDk3LuGa9FwUmii7OueHsgRPg
         v8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AiDSlOSCsG1WOcpWmNBiOt/HYN32uZVq4wOAkmWFu8=;
        b=fPqFziEHdJt9XP+o/9eaA3cxfO/yN88sBcWforsVQZ5rXDldzsc375v0EY0mpcR9iJ
         /16PGXYuwJdREiTD1EtpZuH5htqknKl6KqQaFnfIQaua7HZsQIxdw3ApHnGXJUycaa4H
         n9FWXHWYNvh64QkBYomzoU6I8iVnEjk9w/UrNstaqDGttm5c3BzdpvLejDdi78gOosQG
         O82+Qnh+TxH4uBROStOMkNgClEQUkxL/zXewGWno1v1lzLciHPixJ6cTTEHCA6dJsp+l
         b+Qlr9pY7EYidiB+ZKdfcE/sWzn3KAzD/Z9/x9YHqe3X9K+EFFnMIJEWTPjmkcM5devF
         mi0g==
X-Gm-Message-State: ACrzQf1U7X4m8GYIRFfkMEJT8+fWVOZB5k3QUX3x5ZJuhwdxFV0ht87j
        dNkgJ369GOWuBoa+GO6UEqKJT5TfND9OfQ==
X-Google-Smtp-Source: AMsMyM7dtlvF/iJZDdCqxiQGFIjCMffeuM3xZBGmL29jr8Ya76BEs4TmpaJczEAWOEtWTI4Lc+3lFA==
X-Received: by 2002:a17:906:4717:b0:7ad:c606:349f with SMTP id y23-20020a170906471700b007adc606349fmr14916938ejq.214.1667342170618;
        Tue, 01 Nov 2022 15:36:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id rp7-20020a170906d96700b0078dd4c89781sm4693845ejb.35.2022.11.01.15.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:36:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 10/13] Makefile: copy contrib/coccinelle/*.cocci to build/
Date:   Tue,  1 Nov 2022 23:35:52 +0100
Message-Id: <patch-v5-10.13-56ca8f5720a-20221101T222616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
References: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20221101T222616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "coccinelle" rule so that we first copy the *.cocci source
in e.g. "contrib/coccinelle/strbuf.cocci" to
".build/contrib/coccinelle/strbuf.cocci" before operating on it.

For now this serves as a rather pointless indirection, but prepares us
for the subsequent commit where we'll be able to inject generated
*.cocci files. Having the entire dependency tree live inside .build/*
simplifies both the globbing we'd need to do, and any "clean" rules.

It will also help for future targets which will want to act on the
generated patches or the logs, e.g. targets to alert if we can't parse
certain files (or, less so than usual) with "spatch", and e.g. a
replacement for "ci/run-static-analysis.sh". Such a replacement won't
care about placing the patches in the in-tree, only whether they're
"OK" (and about the diff).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile   | 27 +++++++++++++++++++++------
 shared.mak |  1 +
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index c7c96d284dd..44c906b65d5 100644
--- a/Makefile
+++ b/Makefile
@@ -3164,8 +3164,11 @@ check: $(GENERATED_H)
 	fi
 
 COCCI_GLOB = $(wildcard contrib/coccinelle/*.cocci)
-COCCI_RULES = $(COCCI_GLOB)
-COCCI_NAMES = $(COCCI_RULES:contrib/coccinelle/%.cocci=%)
+COCCI_RULES_TRACKED = $(COCCI_GLOB:%=.build/%)
+COCCI_RULES =
+COCCI_RULES += $(COCCI_RULES_TRACKED)
+COCCI_NAMES =
+COCCI_NAMES += $(COCCI_RULES:.build/contrib/coccinelle/%.cocci=%)
 
 COCCICHECK_PENDING = $(filter %.pending.cocci,$(COCCI_RULES))
 COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_RULES))
@@ -3173,6 +3176,9 @@ COCCICHECK = $(filter-out $(COCCICHECK_PENDING),$(COCCI_RULES))
 COCCICHECK_PATCHES = $(COCCICHECK:%=%.patch)
 COCCICHECK_PATCHES_PENDING = $(COCCICHECK_PENDING:%=%.patch)
 
+COCCICHECK_PATCHES_INTREE = $(COCCICHECK_PATCHES:.build/%=%)
+COCCICHECK_PATCHES_PENDING_INTREE = $(COCCICHECK_PATCHES_PENDING:.build/%=%)
+
 # It's expensive to compute the many=many rules below, only eval them
 # on $(MAKECMDGOALS) that match these $(COCCI_RULES)
 COCCI_RULES_GLOB =
@@ -3180,10 +3186,16 @@ COCCI_RULES_GLOB += cocci%
 COCCI_RULES_GLOB += .build/contrib/coccinelle/%
 COCCI_RULES_GLOB += $(COCCICHECK_PATCHES)
 COCCI_RULES_GLOB += $(COCCICHEC_PATCHES_PENDING)
+COCCI_RULES_GLOB += $(COCCICHECK_PATCHES_INTREE)
+COCCI_RULES_GLOB += $(COCCICHECK_PATCHES_PENDING_INTREE)
 COCCI_GOALS = $(filter $(COCCI_RULES_GLOB),$(MAKECMDGOALS))
 
 COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 
+$(COCCI_RULES_TRACKED): .build/% : %
+	$(call mkdir_p_parent_template)
+	$(QUIET_CP)cp $< $@
+
 .build/contrib/coccinelle/FOUND_H_SOURCES: $(FOUND_H_SOURCES)
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN) >$@
@@ -3197,7 +3209,7 @@ define cocci-rule
 # $(1) = e.g. "free.cocci"
 # $(2) = e.g. "grep.c"
 # $(3) = e.g. "grep.o"
-COCCI_$(1:contrib/coccinelle/%.cocci=%) += .build/$(1).patch/$(2)
+COCCI_$(1:.build/contrib/coccinelle/%.cocci=%) += .build/$(1).patch/$(2)
 .build/$(1).patch/$(2): GIT-SPATCH-DEFINES
 .build/$(1).patch/$(2): $(if $(and $(SPATCH_USE_O_DEPENDENCIES),$(wildcard $(3))),$(3),.build/contrib/coccinelle/FOUND_H_SOURCES)
 .build/$(1).patch/$(2): $(1)
@@ -3225,12 +3237,15 @@ endif
 
 define spatch-rule
 
-contrib/coccinelle/$(1).cocci.patch: $$(COCCI_$(1))
+.build/contrib/coccinelle/$(1).cocci.patch: $$(COCCI_$(1))
 	$$(QUIET_SPATCH_CAT)cat $$^ >$$@ && \
 	if test -s $$@; \
 	then \
 		echo '    ' SPATCH result: $$@; \
 	fi
+contrib/coccinelle/$(1).cocci.patch: .build/contrib/coccinelle/$(1).cocci.patch
+	$$(QUIET_CP)cp $$< $$@
+
 endef
 
 ifdef COCCI_GOALS
@@ -3254,11 +3269,11 @@ $(COCCI_TEST_RES_GEN): .build/contrib/coccinelle/tests/%.res : contrib/coccinell
 coccicheck-test: $(COCCI_TEST_RES_GEN)
 
 coccicheck: coccicheck-test
-coccicheck: $(COCCICHECK_PATCHES)
+coccicheck: $(COCCICHECK_PATCHES_INTREE)
 
 # See contrib/coccinelle/README
 coccicheck-pending: coccicheck-test
-coccicheck-pending: $(COCCICHECK_PATCHES_PENDING)
+coccicheck-pending: $(COCCICHECK_PATCHES_PENDING_INTREE)
 
 .PHONY: coccicheck coccicheck-pending
 
diff --git a/shared.mak b/shared.mak
index f437073e48c..a34b66c926d 100644
--- a/shared.mak
+++ b/shared.mak
@@ -60,6 +60,7 @@ ifndef V
 	QUIET_AR       = @echo '   ' AR $@;
 	QUIET_LINK     = @echo '   ' LINK $@;
 	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
+	QUIET_CP       = @echo '   ' CP $< $@;
 	QUIET_LNCP     = @echo '   ' LN/CP $@;
 	QUIET_XGETTEXT = @echo '   ' XGETTEXT $@;
 	QUIET_MSGINIT  = @echo '   ' MSGINIT $@;
-- 
2.38.0.1280.g8136eb6fab2

