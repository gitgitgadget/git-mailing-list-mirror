Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46998C433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 17:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbiEaRqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 13:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346646AbiEaRqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 13:46:25 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFFA986DE
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:46:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k16so15338105wrg.7
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yeSPRVNxzdCQdnh+vjES9Qlj6L2EN16ZeTenP0wCFE8=;
        b=OTpImHV7neAQ+FYhN0/ditA8HjhK60BJLv6BdtUAq52fpSkK/+G72ZpZQvlplYagct
         tLG5JENfrNndIC+/MuV6jeQJNmy6Zp2Z/WNkLHJBKL+cenoUFvnLZrZxmtSpX6hx7Eqe
         +lNPPRvfyxKRPaFTqDk4uw089PeV4iwrh3Drk2T/OHEhX3+A2AsdP67X20zVHssaL/hc
         GuQvH4yAEj59MU5+c1yT/QatI/DKssZpVx92DSWelzNyiaZI8mbq8EfsOPSz/H5HOu5l
         XY2OOs93U+k17Wdx6lgmf5rsTHSwHCGtuOg+1atOyHgRcN+oQG5pF6Hjs9jrqMvKsfHl
         RlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yeSPRVNxzdCQdnh+vjES9Qlj6L2EN16ZeTenP0wCFE8=;
        b=z8NVgcYX4XbSTKk340Jozay7kQcGixO7qFMRwKHRm55h2EBAFYcZJmL/Eplnho3Lre
         61+IgGGZblzdJ1RKVCsxap1INj8qVmNMHdL6j3LNTON0XP8u8nrx/Ks2lLDcr+hPImdX
         ymtyXht5nvdM9oQu4Ob9L888225krk8y3hgFSlvM4Kc4D1WI+RXve6OlzcQ0B3ETCg2s
         V53WdgiSPWAbDeir5BSkeXu6OnJ4Kegv7s4ZnVNT9vD8tGZrGv9PHb0UziBzjx9svCD0
         2Xu2/16Ijaii0atZywoEcS9JV85GnIOpDdqHDppcpWWfq1w+Pgx3HQNCIloV5Z1p8v4c
         9E+Q==
X-Gm-Message-State: AOAM5305K76kqQesKPKjqYGF0N+mm8t9Pf4D5Xf9HHZG6ZE5vqFPQsX2
        Lg49haPMhybBzKs03xavhvwe7KXhq/ZP2g==
X-Google-Smtp-Source: ABdhPJxvEOcKR5jStZYdZHtsqe0I1i3bIfVBYFveyDg0c5oMJKVR+H+9pTZ67TL37qnfDPJyHMCH0g==
X-Received: by 2002:a05:6000:1d97:b0:210:25d6:e125 with SMTP id bk23-20020a0560001d9700b0021025d6e125mr14522639wrb.464.1654019182192;
        Tue, 31 May 2022 10:46:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j26-20020a05600c1c1a00b003973e27b789sm3826656wms.27.2022.05.31.10.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:46:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/7] gitweb: remove "test" and "test-installed" targets
Date:   Tue, 31 May 2022 19:45:58 +0200
Message-Id: <patch-v2-5.7-caf376f3dd9-20220531T173805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.g036c05811b0
In-Reply-To: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com> <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
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
2.36.1.1103.g036c05811b0

