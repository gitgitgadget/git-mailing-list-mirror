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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32705C4320A
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1701060C41
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhHDWzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbhHDWzB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 18:55:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B57C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 15:54:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l18so3962692wrv.5
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 15:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ths9J2yVNYJW6di0dSwgHFL7o8LtpPYnkPUSZoZ9dFg=;
        b=izqGoZZT+HtaYwGQk/OcQPgVDqBVd0XIr8FdduGmq6O7CKTIgtTxKev5TyO/QMzFjU
         AyATJto9ZE3I+JmpHQhggqaC99Np3EiNnxFBcyI+9XtWAoF+V17Y1ZQHxnQrdomF6Imm
         l6WwZEsuZ1YTAgEEz8z42dFnd5aWefk/YuWWBqYrZN6pUSfeCOUqzPJ3wd/g4GHmNrW4
         Uz6PO8K0EUGl+798HXtxdrBQBTEXwZAl3bR1kM3UNfMUxM7jlPY1b/+Nw5lXAXa27Mnu
         YvYBx2O2g/8JRHR31vlF0JFr7zbHgvGPCSI0t5QHNk5BKwkY1o6HFPmG1xqakWhmfSSX
         sTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ths9J2yVNYJW6di0dSwgHFL7o8LtpPYnkPUSZoZ9dFg=;
        b=ksoLLpW2a4YpAy5Eb+5fvmd9A7ALYtqmAOwrwQ2dETn4ySOZPEy9QzTRU5WmCkRNti
         m//y65r6uWpnlelSLal18gry26eUzNOP4USug54NdACb7Rhp5572FHaATADyr22Xmorc
         0jwPW2zG0jP5RfjlL5nKTUF9haEe9kOw+cDnoESIJCPfLbX20apaBj/X1zpG9BQ7kSa9
         Ojqjy6uoT0v8bfHRzl9lFZxZDn6qepktYYm3HyCNuEWkjXbKbr2xudXbC6u4+k4+3tTI
         u+TyqsschYG4DI7hmXz9ivkHcFSg20tD1eDb0CGjg6X7suFuZtnW7JJw4RVP7YHjDnjX
         EOaA==
X-Gm-Message-State: AOAM532bddLix0FLrJ9fqavQwtOWLXxUAHHP3NhPE/xTTv/9fuRjSHKK
        /7wYK2xwfpJJhhPnmyCUhnR1henCtrnfuQ==
X-Google-Smtp-Source: ABdhPJxMe7V6XCeb7NLyatBY1cz2sC5adkppmWFqQsqTFLDCjTquaPgCaTNphT8tilT7g4w15P3cTg==
X-Received: by 2002:a5d:58c1:: with SMTP id o1mr1634936wrf.6.1628117685752;
        Wed, 04 Aug 2021 15:54:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u11sm3968190wrt.89.2021.08.04.15.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 15:54:45 -0700 (PDT)
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
Subject: [PATCH v4 3/5] Makefile: don't use "FORCE" for tags targets
Date:   Thu,  5 Aug 2021 00:54:38 +0200
Message-Id: <patch-v4-3.5-8649716772b-20210804T225222Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-v4-0.5-00000000000-20210804T225222Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20210804T225222Z-avarab@gmail.com>
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
index 59c2e98795b..d1012cf71d2 100644
--- a/Makefile
+++ b/Makefile
@@ -2746,20 +2746,24 @@ FIND_SOURCE_FILES = ( \
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
@@ -2943,7 +2947,7 @@ check: config-list.h command-list.h
 		exit 1; \
 	fi
 
-FOUND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
+FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
 COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
-- 
2.33.0.rc0.597.gc569a812f0a

