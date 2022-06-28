Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A512C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbiF1KQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344092AbiF1KQO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:16:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DAE2FE66
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:16:13 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so7253934wmb.5
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WfXatAqGe8hJj1hdSsv3xM0z3/D4dnXKR+7SisbeVGM=;
        b=pqvVuh0pYYZkKJYbkxaP2HQxigXC2YVYtgnk6YHiggWHbP0B8yvMN6uCad+PozlJKJ
         3OGKSXjND03Xf+fWPRf1OhGeWF70Hx5K91Ij5tUEsl7ud1Q5HPD4b+LQXHfboWutLPgm
         iu4xgOERl2TzLZOE4vF0xSFAWlitFku4k8fscCvEv1/yfZvKxIRm+DTy3PkDa2FauNQB
         MkzMxfOUWvSSHIBz/PNhkuQT3bVq9NSxVFEluyrQ/EF1GjrOEaAz+8DGSlNmiFvPzt/i
         4FmlAkLEaek2n1+G4PsyrU69uR0709/O+xoGkC5jvyMlLu51gv6P2QK9Mml2fOS7Lt3A
         C2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfXatAqGe8hJj1hdSsv3xM0z3/D4dnXKR+7SisbeVGM=;
        b=oSEyF4jaXsG599Ih6GeWubIiRo7J27/fMAYq3s69RpIzb/X+iOuHVkXGxHjkfDWoOB
         YdDCkyD7/0T2LuyJUzURfk1BlOmNu7PFNOW41fKpeuwTcDe51Ml1mVFDL2ij7FR6VXJ8
         w/vBtmdp7gV3mWYM28CzdlorlK/I3L60qTMVuMCmcObODuLY9cmjBLL1rcn8qohxNweq
         MrrAvl0RdLKDRf/kktBOnzrtbW0jwSH0RnHone9a6Y82KxAvwl1qW/qPFxL2heLi9WKm
         E073hrzN6OtytskB/xa7iedK08RdQuU1Z9hsxnCzH0p91VP+uQToetxd3J8FLfFY4v8l
         9OUQ==
X-Gm-Message-State: AJIora9k0ENC/DhZBvDNtnG4MVMSIkMn2KFRMN+dUJzm6TgTNAlqG0qR
        FXVC1yk1nKXumA24OVDKrRDZb2Oi9fk7jA==
X-Google-Smtp-Source: AGRyM1u3vuDHyFttJ83BgvywQuJ4y/wkkdXawK6+ZfNApWL71qXWOP/C3LGVTPk6m94whmwt7el7Fg==
X-Received: by 2002:a05:600c:4e10:b0:39c:58a8:f828 with SMTP id b16-20020a05600c4e1000b0039c58a8f828mr26434003wmq.44.1656411371270;
        Tue, 28 Jun 2022 03:16:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c2f0100b0039c54bb28f2sm552595wmn.36.2022.06.28.03.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:16:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/8] gitweb: remove "test" and "test-installed" targets
Date:   Tue, 28 Jun 2022 12:15:59 +0200
Message-Id: <patch-v3-5.8-6c2d7b30524-20220628T100936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v3-0.8-00000000000-20220628T100936Z-avarab@gmail.com>
References: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20220628T100936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the special "test" targets for gitweb added in
958a8467216 (gitweb/Makefile: Add 'test' and 'test-installed' targets,
2010-09-26). Unlike e.g. "contrib/scalar" and "contrib/subtree" the
"gitweb" tests themselves live in our top-level t/ directory.

It therefore doesn't make sense to maintain this indirection, no more
than it would to have a "git-send-email-test". By dropping it we'll
also free other tests to use the t95*.sh prefix.

These removed targets are unlikely to be used by anyone, and to the
extent that they are we can easily use an invocation like this
instead:

	make test T='t[0-9]*gitweb*.sh'

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 gitweb/Makefile | 11 -----------
 t/Makefile      |  4 ----
 2 files changed, 15 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 74e896767e9..eaf0cfcf80e 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -183,17 +183,6 @@ $(MAK_DIR_GITWEB)static/gitweb.js: $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_
 	cat $^ >$@+ && \
 	mv $@+ $@
 
-### Testing rules
-
-.PHONY: test
-test:
-	$(MAKE) -C ../t gitweb-test
-
-.PHONY: test-installed
-test-installed:
-	GITWEB_TEST_INSTALLED='$(DESTDIR_SQ)$(gitwebdir_SQ)' \
-		$(MAKE) -C ../t gitweb-test
-
 ### Installation rules
 
 .PHONY: install
diff --git a/t/Makefile b/t/Makefile
index 056ce55dcc9..7f56e52f767 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -35,7 +35,6 @@ TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
 CHAINLINTTMP_SQ = $(subst ','\'',$(CHAINLINTTMP))
 
 T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
-TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
 THELPERS = $(sort $(filter-out $(T),$(wildcard *.sh)))
 TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
@@ -112,9 +111,6 @@ aggregate-results:
 		echo "$$f"; \
 	done | '$(SHELL_PATH_SQ)' ./aggregate-results.sh
 
-gitweb-test:
-	$(MAKE) $(TGITWEB)
-
 valgrind:
 	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
 
-- 
2.37.0.880.gf07d56b18ba

