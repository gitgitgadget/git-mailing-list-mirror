Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B14DC433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 17:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346669AbiEaRqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 13:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346640AbiEaRqY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 13:46:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A20985B2
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:46:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e2so19705889wrc.1
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I6q9m9TQnGP9XzvW8884GRgEjL5m4u+8ezUBftmqeKU=;
        b=nkZnHnksgy12n1rD/CxBOmMM80nqsWwzcoIuVP7DbviNyCvISHBXpCJYKuGQ7U7Yr7
         U+MPrbGPbe7kIJkpq3sJ/MbrYCVPRPGYXeZDfqNKFXXXs6DENQivtYs6sc2y9rSLJgZz
         kO0D1goZcmvtmOwFWRsAn90psMPimAiroKdocvJgzDtaIPPHUuFQsbH9Z1OLi0zgpEyH
         izvd8L85MJ1jMVNE369hIFfKdSv0aE7ltK3yKTkdZ6xbQ/VqepBBD0D8QpikHrayfZi5
         R4iWi0BK6exnCDeOoIumvBNo/bn48x3Q6PgIvXWCUJoPcYLIKK8PYcbKaNVfppQSw3Xt
         4Yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6q9m9TQnGP9XzvW8884GRgEjL5m4u+8ezUBftmqeKU=;
        b=6F3xROLQUzG4QFvliycu/wZggereLrJTyTLJ2DD6nUrBADMB3ZrUl22/5dEGTsXtzs
         hvn+0QW7s1VCygtSXFJVhujjlcGA1FL1CA3ejy+Eb8PwF4Mdg2ZjCmsPpOAXL7vVjkBJ
         4vKC182uodJf8Q3lGgDCbMJ3c73BtjFGtExg0DjXH+15KOvoPJlZ6Kt2cTXs0edK96UR
         I17LKQO0D3LtNhtMY31dXEiYWcRE2e0WJQR+pMDJB6MRQ1n0Or2uLh5LeRf507ino24v
         n7dSORnfSueR6iRUc9G41NjK6t7v5xUrURn47BjdDwxpnjWK+ZcJOzZR6GOCLpfZQusR
         V6vQ==
X-Gm-Message-State: AOAM531+ANcDk/+RyEk7SZfxDbCT6Ka1FTbk475S2zGyNITcd2bAD57q
        61Gszyxng+PUBiwgwSrjcdpWQV/3AK0k0A==
X-Google-Smtp-Source: ABdhPJwhEyZo3lrOJPWvuZLM4QuQ1Hsyg4gzmbDeKisX1Y/XFpvjfhuc/ZRV1qz4cYog4mFks5I+6A==
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id f15-20020a0560001b0f00b00210313aef2amr10622083wrz.281.1654019180953;
        Tue, 31 May 2022 10:46:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j26-20020a05600c1c1a00b003973e27b789sm3826656wms.27.2022.05.31.10.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:46:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/7] gitweb/Makefile: prepare to merge into top-level Makefile
Date:   Tue, 31 May 2022 19:45:57 +0200
Message-Id: <patch-v2-4.7-02e26ca8ce2-20220531T173805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.g036c05811b0
In-Reply-To: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com> <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the "gitweb/Makefile" was split out from the top-level Makefile
in 62331ef1637 (gitweb: Makefile improvements, 2010-01-30) we've kept
the inter-dependencies between the two, and worse have dealt with a
lot of duplication as a result.

In preparation for merging the two again add a MAK_DIR_GITWEB variable
to various rules in it. This will allow us to set this variable to
"gitweb/" as we include it in the top-level Makefile, which will
minimize the size of the subsequent diff.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 gitweb/Makefile | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index a8752c1f11c..74e896767e9 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -2,6 +2,8 @@
 all::
 .PHONY: all
 
+MAK_DIR_GITWEB =
+
 # Define V=1 to have a more verbose compile.
 #
 # Define JSMIN to point to JavaScript minifier that functions as
@@ -106,8 +108,9 @@ GITWEB_PROGRAMS = gitweb.cgi
 GITWEB_JS_MIN = static/gitweb.min.js
 ifdef JSMIN
 GITWEB_JS = $(GITWEB_JS_MIN)
-all:: $(GITWEB_JS_MIN)
-$(GITWEB_JS_MIN): $(GITWEB_JS_IN) GITWEB-BUILD-OPTIONS
+all:: $(MAK_DIR_GITWEB)$(GITWEB_JS_MIN)
+$(MAK_DIR_GITWEB)$(GITWEB_JS_MIN): $(MAK_DIR_GITWEB)GITWEB-BUILD-OPTIONS
+$(MAK_DIR_GITWEB)$(GITWEB_JS_MIN): $(MAK_DIR_GITWEB)$(GITWEB_JS_IN)
 	$(QUIET_GEN)$(JSMIN) <$< >$@
 endif
 GITWEB_FILES += $(GITWEB_JS)
@@ -115,8 +118,9 @@ GITWEB_FILES += $(GITWEB_JS)
 GITWEB_CSS_MIN = static/gitweb.min.css
 ifdef CSSMIN
 GITWEB_CSS = $(GITWEB_CSS_MIN)
-all:: $(GITWEB_CSS_MIN)
-$(GITWEB_CSS_MIN): $(GITWEB_CSS_IN) GITWEB-BUILD-OPTIONS
+all:: $(MAK_DIR_GITWEB)$(GITWEB_CSS_MIN)
+$(MAK_DIR_GITWEB)$(GITWEB_CSS_MIN): $(MAK_DIR_GITWEB)GITWEB-BUILD-OPTIONS
+$(MAK_DIR_GITWEB)$(GITWEB_CSS_MIN): $(MAK_DIR_GITWEB)$(GITWEB_CSS_IN)
 	$(QUIET_GEN)$(CSSMIN) <$< >$@
 endif
 GITWEB_FILES += $(GITWEB_CSS)
@@ -161,19 +165,20 @@ GITWEB_REPLACE = \
 	-e 's|++HIGHLIGHT_BIN++|$(HIGHLIGHT_BIN)|g'
 
 .PHONY: FORCE
-GITWEB-BUILD-OPTIONS: FORCE
+$(MAK_DIR_GITWEB)GITWEB-BUILD-OPTIONS: FORCE
 	@rm -f $@+
 	@echo "x" '$(PERL_PATH_SQ)' $(GITWEB_REPLACE) "$(JSMIN)|$(CSSMIN)" >$@+
 	@cmp -s $@+ $@ && rm -f $@+ || mv -f $@+ $@
 
-gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
+$(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)GITWEB-BUILD-OPTIONS
+$(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)gitweb.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 		$(GITWEB_REPLACE) $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
-static/gitweb.js: $(GITWEB_JSLIB_FILES)
+$(MAK_DIR_GITWEB)static/gitweb.js: $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_FILES))
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	cat $^ >$@+ && \
 	mv $@+ $@
@@ -194,14 +199,16 @@ test-installed:
 .PHONY: install
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebdir_SQ)'
-	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
+	$(INSTALL) -m 755 $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_PROGRAMS)) \
+		'$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
-	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
+	$(INSTALL) -m 644 $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_FILES)) \
+		'$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 
 ### Cleaning rules
 
 .PHONY: clean
 clean:
-	$(RM) gitweb.cgi $(GITWEB_JS_IN) \
+	$(RM) $(addprefix $(MAK_DIR_GITWEB),gitweb.cgi $(GITWEB_JS_IN) \
 		$(GITWEB_JS_MIN) $(GITWEB_CSS_MIN) \
-		GITWEB-BUILD-OPTIONS
+		GITWEB-BUILD-OPTIONS)
-- 
2.36.1.1103.g036c05811b0

