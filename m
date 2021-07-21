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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2F0C6377C
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DCBC6121E
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhGUWmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhGUWmj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:42:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38844C0613C1
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:23:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso1875139wmj.4
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xEXRrfodZNQGLYknSjPsw7pg16wJ036yuEIBjtz0cs=;
        b=C4OMb8eos6vav6BI034MrvwNBRINCO+xn2rxI3clcVpyvB1gyRMuZrWgWBZ6OgMTgj
         hVfRjFKlxk3SHdLOM7/USqq8dNtaGWfy91xpA6JHC+eDpZgbS4uzxRyV0uMk/GGWWCDg
         Pz8Dd5YcpVEF51Wv9LhCIbkaEO5Qg6EkcZQ4YJwdsdHy5gZwT8EWKeT3bb91RpZn2QVR
         /POu68sbZwStjxOjeANEwsqLa/sHvzZHoZn+Cy9pQvQmckx7XbKvvvvqgb3egXmE6oQu
         hL2bPKl7OP3qgCRFEuVj6Ubl7Ywj46NS814pqhKhFO6LnssL3ZgQRUgOOuBNXpZfZDqo
         2BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xEXRrfodZNQGLYknSjPsw7pg16wJ036yuEIBjtz0cs=;
        b=be7ErLbzGdC9eVp+cG6nteVLEJ9bk4sMYXhEXHUtiM7NifZZyNRQPCySD+MUl583L+
         NFBNEkGIeFl/lB79gVH4bWwLgn4HdNXT6F7Po2ZUPwqVqMWymeSuNlKP0aTVk4VnSwVU
         0JWLAQdNmS500DXxAQ5ESaNF7iPwtDQaCa7nt9aA79ircLKkF8go/rqE7j2gA7pVnm4N
         x8SY66q2sEkHCA+jyYxi8Le/vhioPPbKFQg8H1Hjny5yJ1TS9negI8rnCD3LL1d6ovjg
         heMUX3bT9myzeKj/Tv5MUQSjSsARnzRjrPpXhyIlJ6mnDSbdeC759l4Xeij7Y94O720n
         EJug==
X-Gm-Message-State: AOAM533WXpAq3VU8UsUa59h+ZS+PF36Sq3SufG9HemweivWgoI4WK+DL
        NDBvJ3LJH+CuzXPyejXt8JUXPxcxBmd+uA==
X-Google-Smtp-Source: ABdhPJxvH/pGUXknDCbMHycvqquAjPrvV2/Wa7xUsbQ+fvjE+ZFWMJsay88cRGgo78+tQJwP33Tp2Q==
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr6393087wml.34.1626909793646;
        Wed, 21 Jul 2021 16:23:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v11sm27690260wrs.4.2021.07.21.16.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:23:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/5] Makefile: don't use "FORCE" for tags targets
Date:   Thu, 22 Jul 2021 01:23:04 +0200
Message-Id: <patch-3.5-9dd69d68178-20210721T231900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
References: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com> <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "FORCE" dependency from the "tags", "TAGS" and "cscope"
targets, instead make them depend on whether or not the relevant
source files have changed.

For the cscope target we need to change it to depend on the actual
generated file while we generate while we're at it, as the next commit
will discuss we always generate a cscope.out file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 69410095949..18895d94ffa 100644
--- a/Makefile
+++ b/Makefile
@@ -2739,20 +2739,24 @@ FIND_SOURCE_FILES = ( \
 		| sed -e 's|^\./||' \
 	)
 
-$(ETAGS_TARGET): FORCE
+FOUND_SOURCE_FILES = $(shell $(FIND_SOURCE_FILES))
+
+$(ETAGS_TARGET): $(FOUND_SOURCE_FILES)
 	$(QUIET_GEN)$(RM) "$(ETAGS_TARGET)+" && \
-	$(FIND_SOURCE_FILES) | xargs etags -a -o "$(ETAGS_TARGET)+" && \
+	echo $(FOUND_SOURCE_FILES) | xargs etags -a -o "$(ETAGS_TARGET)+" && \
 	mv "$(ETAGS_TARGET)+" "$(ETAGS_TARGET)"
 
-tags: FORCE
+tags: $(FOUND_SOURCE_FILES)
 	$(QUIET_GEN)$(RM) tags+ && \
-	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
+	echo $(FOUND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
 	mv tags+ tags
 
-.PHONY: cscope
-cscope:
+cscope.out: $(FOUND_SOURCE_FILES)
 	$(QUIET_GEN)$(RM) cscope* && \
-	$(FIND_SOURCE_FILES) | xargs cscope -b
+	echo $(FOUND_SOURCE_FILES) | xargs cscope -b
+
+.PHONY: cscope
+cscope: cscope.out
 
 ### Detect prefix changes
 TRACK_PREFIX = $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
@@ -2936,7 +2940,7 @@ check: config-list.h command-list.h
 		exit 1; \
 	fi
 
-FOUND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
+FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
 COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
-- 
2.32.0.955.ge7c5360f7e7

