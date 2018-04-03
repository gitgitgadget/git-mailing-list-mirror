Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 751B51F424
	for <e@80x24.org>; Tue,  3 Apr 2018 09:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755294AbeDCJZ7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 05:25:59 -0400
Received: from mx.mylinuxtime.de ([148.251.109.235]:33216 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755221AbeDCJZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 05:25:58 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Apr 2018 05:25:58 EDT
Received: from leda.eworm.de (unknown [10.10.4.2])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id B47E726449;
        Tue,  3 Apr 2018 11:20:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de B47E726449
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1522747229; bh=dok+sG2EkQPeup6Uq40iDwAAOfO+aJDwQt8RCez9ASM=;
        h=From:To:Cc:Subject:Date;
        b=fMOt5Nf2RapC7TmpuyYEapJIwgrY3m2ewbGMobHQrkJ8hfSl2yk4NZbBY3mm6SzAA
         9AjxKTqHnSjAY2WOo/7n8QMh3J/VyZ70dtkiupXSnhB1trBQrZDR99RPdA0l1OrWQw
         s46kdgLW3AD+wp1xE+Q0atooAXy7nYCS7AXBV/q4=
Received: by leda.eworm.de (Postfix, from userid 1000)
        id 5C4EA1011CC; Tue,  3 Apr 2018 11:20:24 +0200 (CEST)
From:   Christian Hesse <mail@eworm.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Hesse <mail@eworm.de>
Subject: [PATCH 1/1] perl: fix installing modules from contrib
Date:   Tue,  3 Apr 2018 11:20:08 +0200
Message-Id: <20180403092008.26892-1-mail@eworm.de>
X-Mailer: git-send-email 2.17.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 20d2a30f (Makefile: replace perl/Makefile.PL with simple make rules)
removed a target that allowed Makefiles from contrib/ to get the correct
install path. This introduces a new target for main Makefile and fixes
installation for Mediawiki module.

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 Makefile                   | 2 ++
 contrib/mw-to-git/Makefile | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a1d8775ad..bcaf50495 100644
--- a/Makefile
+++ b/Makefile
@@ -2002,6 +2002,8 @@ GIT-PERL-DEFINES: FORCE
 		echo "$$FLAGS" >$@; \
 	    fi
 
+perllibdir:
+	@echo $(perllibdir_SQ)
 
 .PHONY: gitweb
 gitweb:
diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index a4b6f7a2c..0a6e59579 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -21,8 +21,8 @@ HERE=contrib/mw-to-git/
 INSTALL = install
 
 SCRIPT_PERL_FULL=$(patsubst %,$(HERE)/%,$(SCRIPT_PERL))
-INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/perl \
-                -s --no-print-directory instlibdir)
+INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/ \
+                -s --no-print-directory perllibdir=$(perllibdir) perllibdir)
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 INSTLIBDIR_SQ = $(subst ','\'',$(INSTLIBDIR))
 
