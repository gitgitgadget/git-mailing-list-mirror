Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26046C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344478AbiF1KQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243221AbiF1KQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:16:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5952FE5E
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:16:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e28so11779559wra.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o95mXQd/fDRdZYOiPl+blxJU3IJ8FNIioOC6045MADo=;
        b=PJhqGsBJ7nN3NQAClcjXWlXn47avg66E95rkY01YkKZNwd8LAbx7EJK+Fvm1+0TrIJ
         RXnMi5I8KZs+T/rZMzPx7JtK08BQFt8YIxCVvlgAo/vKhsfHf2FY00cRToaZqCVL4CIO
         EzrbB5u5vGVZDwJZnBeTUq0ByyEIK2pB0EX+R+ol1199vUVPEfsKBWhDyDlX7R/5WIdB
         zJk6iyNd5KUcwTMmoHmFOPbhcfTwdd2R+8C6tbGzrADc50J3wfestCgJZzv65YtBOipY
         iUy4TzYF0WiO8BiRcBk1tltZNfdaxk8zeGBM/k97r6o5WnsJ5NQiCBblQki/1MG4DXDd
         jPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o95mXQd/fDRdZYOiPl+blxJU3IJ8FNIioOC6045MADo=;
        b=hUBN+nKNPYO3hwDrJ1nmJyjIyHLjeYhDFPm5SAuQLzyca97utsLg24QPa+MXsmff0K
         XrUgp4WNRgTlciUqRA9ympX9ScbcWh6srJ9ahPWU9xD9+L1z6qFHwLrK37yDTdnkZoZL
         aVex7XlOgstf9ac1q8dXIJcC4QeFoTNZJhR71/R9MJuPGBMthOT8/8KUjI5bHs3P9PGY
         MxTTXcvZ/EZr+h1kco9NmGKFOHjMZFVobnU1zxFAQrYtf3KOE9Yimnyrc+GJUih0IzJ6
         qFXG1s7TFdVBKZeXNY5OVnSLJ9e8s/Y+ZrP1A81O6Af81k6IdlY1hl9+DWtfDSR7ivLj
         75ow==
X-Gm-Message-State: AJIora9/piitJqr7K7gFuURozhFWmxCw6m/V/Zj02l7VDD9nQCQmnQz8
        nBSsFN0EzbySU2Q2ctTJ+QcHtTvVd3FzNA==
X-Google-Smtp-Source: AGRyM1ud38QQrN4qPQ6X4qL44UBdvj4uAdVVFgDqDuhuUx+whfg9TDddbpg1t+/HV1MwWZV5wnxr+A==
X-Received: by 2002:adf:ef0e:0:b0:21b:9fe3:aaa7 with SMTP id e14-20020adfef0e000000b0021b9fe3aaa7mr17524322wro.695.1656411366919;
        Tue, 28 Jun 2022 03:16:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c2f0100b0039c54bb28f2sm552595wmn.36.2022.06.28.03.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:16:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/8] gitweb/Makefile: define all .PHONY prerequisites inline
Date:   Tue, 28 Jun 2022 12:15:55 +0200
Message-Id: <patch-v3-1.8-8e85151cf3d-20220628T100936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v3-0.8-00000000000-20220628T100936Z-avarab@gmail.com>
References: <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com> <cover-v3-0.8-00000000000-20220628T100936Z-avarab@gmail.com>
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
2.37.0.880.gf07d56b18ba

