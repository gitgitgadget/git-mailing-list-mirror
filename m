Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A2621F404
	for <e@80x24.org>; Tue, 10 Apr 2018 13:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeDJNhB (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 09:37:01 -0400
Received: from mx.mylinuxtime.de ([148.251.109.235]:60456 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752912AbeDJNg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 09:36:56 -0400
Received: from leda.eworm.de (unknown [10.10.4.2])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 5C951266FA;
        Tue, 10 Apr 2018 15:36:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de 5C951266FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1523367415; bh=9WulqQDkpZ/zjxUMzGTMaRt/8Tqf1b7ixkBdLfytUEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=o0blJ1EME5FekTprVLU2nHhmK4tGfWj2zG51ChOtGqlemM7Zn/gNYGFEYc0V/FMSb
         RzhG+Qd2CxyUTQXGq0YeLVmyAkfgHyO9uP2LGBOgTkk5mIdMWHr7H5ZtqV6vbMjRBm
         U4Uk6MzBLeD9jz6PVv5nKf/VC+TuyN9XiS730XqA=
Received: by leda.eworm.de (Postfix, from userid 1000)
        id 0F67A102940; Tue, 10 Apr 2018 15:36:50 +0200 (CEST)
From:   Christian Hesse <mail@eworm.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Dan Jacques <dnj@chromium.org>,
        Christian Hesse <mail@eworm.de>
Subject: [PATCH v2 1/1] perl: fix installing modules from contrib
Date:   Tue, 10 Apr 2018 15:36:41 +0200
Message-Id: <20180410133641.18861-1-mail@eworm.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <xmqqpo39569k.fsf@gitster-ct.c.googlers.com>
References: <xmqqpo39569k.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 20d2a30f (Makefile: replace perl/Makefile.PL with simple make rules)
removed a target that allowed Makefiles from contrib/ to get the correct
install path. This introduces a new target for main Makefile and fixes
installation for Mediawiki module.

v2: Pass prefix as that can have influence as well, add single quotes
    for _SQ variant.

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 Makefile                   | 2 ++
 contrib/mw-to-git/Makefile | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 96f6138f6..19ca5e8de 100644
--- a/Makefile
+++ b/Makefile
@@ -2011,6 +2011,8 @@ GIT-PERL-DEFINES: FORCE
 		echo "$$FLAGS" >$@; \
 	    fi
 
+perllibdir:
+	@echo '$(perllibdir_SQ)'
 
 .PHONY: gitweb
 gitweb:
diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index a4b6f7a2c..4e603512a 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -21,8 +21,9 @@ HERE=contrib/mw-to-git/
 INSTALL = install
 
 SCRIPT_PERL_FULL=$(patsubst %,$(HERE)/%,$(SCRIPT_PERL))
-INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/perl \
-                -s --no-print-directory instlibdir)
+INSTLIBDIR=$(shell $(MAKE) -C $(GIT_ROOT_DIR)/ \
+                -s --no-print-directory prefix=$(prefix) \
+                perllibdir=$(perllibdir) perllibdir)
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 INSTLIBDIR_SQ = $(subst ','\'',$(INSTLIBDIR))
 
