Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3C5C433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 17:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346637AbiEaRqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 13:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiEaRqT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 13:46:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17478985B6
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:46:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u3so19667050wrg.3
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N08A60A/ws1ot8Zrmi4UbjX/QCYfvgihV9sugKyTtH8=;
        b=JgbaFur3fOOdHPrOQuSAAtPnd5cW+niPbe68mRP+K1nT7ZItY6uIcz6Rp/m5elL6iZ
         RYz3QFjQIG1LW4bcgsKzHsX+5c0U2MtN+Hg25N8WJDBNMMLNlWFuWGjaIsXv/rHbbF5q
         zPLWoesNsbQHc8/1ThJWME/NnYd1UCiek3deM83XECm3dr7sBbjDYpRfXc/Y+MMBS26s
         bn/5JFwINpISyx8CJSdBK9XgQCanIMbjWo45KTu8ZGunjFat8A/5IkqcyS0PENORcEUV
         azzgURV8/h08NZNdAfXSeoZBBI/nhsUt5dDDuqOHsY5IBbNdk3qew/gCAYBQ4zS4r+ZN
         tfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N08A60A/ws1ot8Zrmi4UbjX/QCYfvgihV9sugKyTtH8=;
        b=6p/puqIm4eO4utbniiJ/uJnNxKVvh5ZyIEk/JFdih05+Gzguh5Kb3bxxJApKpKzeeq
         vpSCfqFIGA48WCeq3ehj9hlBpKC3/EEgIO09iSfZg+0agnOn3vEmVzMwOv8/BJ7fPS3R
         gBabSZWSugCHZrx4RYhjWwwKF5H3vUX+1mKBVqOKGFwTLXMhOLpDWgz7GCOZNAqU1ahW
         ebyl3Qk2hVUpuYYCdj36W688lYY/cHIHlnJo9lYN4BG7WaTeJag1bRJgPMI/tE1YudTq
         KQlBT4jonUol2wUWMcH/kDZjkhKGyeEMRgbUjIbgZF7WbnHwT0bMWze8wCf9VOEs2Edj
         tk8A==
X-Gm-Message-State: AOAM531apvn0SAlfW4KVv2gf7vPXSFJHCL+F3Jbi1AdT4OUiYQv//qr0
        UBrzdXln7ItGlB0Qg8oA9eXUBrkypwwW9w==
X-Google-Smtp-Source: ABdhPJyVbajsrFlwbnsFkHR7CHt79gp2kA+cuvXwoshPuArayX+ymPoF4PuqSdmXPRJeJx82+Li/Pw==
X-Received: by 2002:a5d:5917:0:b0:210:353b:db0e with SMTP id v23-20020a5d5917000000b00210353bdb0emr8636532wrd.469.1654019175343;
        Tue, 31 May 2022 10:46:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j26-20020a05600c1c1a00b003973e27b789sm3826656wms.27.2022.05.31.10.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:46:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/7] gitweb/Makefile: define all .PHONY prerequisites inline
Date:   Tue, 31 May 2022 19:45:54 +0200
Message-Id: <patch-v2-1.7-14361617ca6-20220531T173805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.g036c05811b0
In-Reply-To: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com> <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the '.PHONY' definition so that it's split up and accompanies the
relevant as they're defined. This will make a subsequent diff smaller
as we'll remove some of these, and won't need to re-edit the
now-removed '.PHONY' line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 gitweb/Makefile | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index f13e23c4de4..abb5c9f9ab6 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -1,5 +1,6 @@
 # The default target of this Makefile is...
 all::
+.PHONY: all
 
 # Define V=1 to have a more verbose compile.
 #
@@ -45,6 +46,7 @@ HIGHLIGHT_BIN = highlight
 -include config.mak
 
 # determine version
+.PHONY: .FORCE-GIT-VERSION-FILE
 ../GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	$(QUIET_SUBDIR0)../ $(QUIET_SUBDIR1) GIT-VERSION-FILE
 
@@ -152,6 +154,7 @@ GITWEB_REPLACE = \
 	-e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
 	-e 's|++HIGHLIGHT_BIN++|$(HIGHLIGHT_BIN)|g'
 
+.PHONY: FORCE
 GITWEB-BUILD-OPTIONS: FORCE
 	@rm -f $@+
 	@echo "x" '$(PERL_PATH_SQ)' $(GITWEB_REPLACE) "$(JSMIN)|$(CSSMIN)" >$@+
@@ -171,15 +174,18 @@ static/gitweb.js: $(GITWEB_JSLIB_FILES)
 
 ### Testing rules
 
+.PHONY: test
 test:
 	$(MAKE) -C ../t gitweb-test
 
+.PHONY: test-installed
 test-installed:
 	GITWEB_TEST_INSTALLED='$(DESTDIR_SQ)$(gitwebdir_SQ)' \
 		$(MAKE) -C ../t gitweb-test
 
 ### Installation rules
 
+.PHONY: install
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
@@ -188,10 +194,8 @@ install: all
 
 ### Cleaning rules
 
+.PHONY: clean
 clean:
 	$(RM) gitweb.cgi static/gitweb.js \
 		static/gitweb.min.js static/gitweb.min.css \
 		GITWEB-BUILD-OPTIONS
-
-.PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE FORCE
-
-- 
2.36.1.1103.g036c05811b0

