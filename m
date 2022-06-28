Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3B7C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344792AbiF1KQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243221AbiF1KQN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:16:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F872FE61
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:16:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v14so16934881wra.5
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=APuxNPNzg94idcymdgxQt/f73d7xVkHBTpcmuwOwUDA=;
        b=B8QdBXegzNM8Hx+YGVAHOODvPemMYHmNWiny4CpqjTXC3fnQ3sTFf0Bl9q0TzUx+MU
         JNdN3FhEyGLyL5YHCBn5BsiPcmSxJhc26qD+N5tIarwHebrIb4yqdi3+JcZVtY1cHOsO
         g/IV6uN035vkVLTvyfCu44YNI3VvP2Cw8OjBRAhguS1xtFisOFCVOg+68KoB5O0XiyN1
         lUObZQSI1bhPNHq3BXQwiHEXrBl9OoNRWuGfXqJ0vMqMg65Af5Vj+B0Q5+bXxs3B0+9d
         odORrYLh3xh4uPSL61jmoXUMYs6bAHTYoYdXexYYHeCFVLHPJMWObK0qsQmRmdmmmel6
         IbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APuxNPNzg94idcymdgxQt/f73d7xVkHBTpcmuwOwUDA=;
        b=NnrYrAq5ppzd+avykftQoW/PWaHRlyc+/mo/i39DBg8uBlxXAMO0bAkjBjkHhv9x/c
         uEAdAj1j40009b1hrWrTKdwArFm35lBlFohGdQjXiXXVAEOhLHgU623ciA5ml0bJCuP6
         qguWR7EclmX89LE7VEt5zx/dSCHnPwSpY7QjGXAeMUXOD7FvALD2PH/DGfSGzOGQaGlI
         Pzln5QUAR+V/2EhCqx272kpyLGm6KWLiB62JWCWP1LWFdRVN2pqDK25C+0qfexK+qs+O
         8c0gm3ryvu+gIbG5XtJQSP+3qB2L9xX6YjEsXVf//KtaYTQDmcnH/GyWNCRk/kv0+THk
         MyDw==
X-Gm-Message-State: AJIora8qmO8eA7vwWrH6UURaMYotp8vlDg2YPHQsTMFejjAErE0MmNxW
        x/YprSAwWZEfnDbuYivtQOtiHX79sW92Pg==
X-Google-Smtp-Source: AGRyM1vpa8G+SKD49++C1WQreVk7KT764B2qMFmjit1fe6TeLCXVhj0FiBfijauUvYv5mLpzoTM6TA==
X-Received: by 2002:a5d:6d09:0:b0:21d:21d2:3e03 with SMTP id e9-20020a5d6d09000000b0021d21d23e03mr861219wrq.673.1656411370113;
        Tue, 28 Jun 2022 03:16:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c2f0100b0039c54bb28f2sm552595wmn.36.2022.06.28.03.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:16:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/8] gitweb/Makefile: prepare to merge into top-level Makefile
Date:   Tue, 28 Jun 2022 12:15:58 +0200
Message-Id: <patch-v3-4.8-d38b553a2e6-20220628T100936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v3-0.8-00000000000-20220628T100936Z-avarab@gmail.com>
References: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20220628T100936Z-avarab@gmail.com>
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
2.37.0.880.gf07d56b18ba

