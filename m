Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94450C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 08:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiESIQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 04:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiESIQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 04:16:26 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B9360AB0
        for <git@vger.kernel.org>; Thu, 19 May 2022 01:16:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n8so4149459plh.1
        for <git@vger.kernel.org>; Thu, 19 May 2022 01:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38OP0OvXq+AWqaFum5f1mwuftot0j+HhO9MbhsLKDUQ=;
        b=bsJEBIE4bhSbU17DqEk+l57u/qaWy/enZ+BMpZzKSG1TIjduC9pAgrvIZh2Clt0C2i
         BRta7NwFp+AyUDTg5Mbk+atTDEGavR5htxIZkBPyIFauEVj8mPF8CuuUbZRG3gIWIok5
         o6AzMR/rWGUF78+kJQ2z+o1FCBpAIr0nZy7y33qqL2oCvtfwULfNbgKGZgof3gmdTuaB
         ll+1z0cXHAr0ChQGzJiwn8CVFkx8XyoSX9VFEwrFNkuSZ1IYNK+MEytttBcO7slX07WX
         Wc0YRnnEn/bX+FyOk3/H2S5v6AP4Esv/LYD2ezT1ExzhXIZnBKDoYSEuhzZ8xC70DG8L
         9Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38OP0OvXq+AWqaFum5f1mwuftot0j+HhO9MbhsLKDUQ=;
        b=jzDOZ13RgSNzxbEbv1j/ir3cW4yh6/JQtqz+SqjdpeoZN9dzm1wX4ah/TFp4GwWAY/
         vyRjqtUQM8dskxckdiq+zWH8bUQKUcd4oU12O2TjYFPnz6BZ+/zklwz6NJktsN8lHpYR
         RaND4jehY/tMmZnb07k1jTdIrXSu+JmZn1IW0MzS8DOKv3hf0Ba8NrS7Tn1TfauIrBcE
         15+OPlc4nNXryo/PjQMnKehbV7PN4xGSKvTp/Xu59UAZe/aOJFqe0muqj2as7+fmt4+7
         35WwdmQCN7/CL8/PhCc8ByF5SRD7wVHOcUXsQQ5GtgOGRqInUddn2MupPJXun3+CjM6N
         c/tg==
X-Gm-Message-State: AOAM533gQyaIJScfi+C+LGYn8l+/OYBKgSAC82CmTvw24BdWanywxMBS
        q7CGbjCkZhhQmedTBDPzptM=
X-Google-Smtp-Source: ABdhPJwXSKpiUlTKu+DvRCui7aV6H5frMQJ3fVjmF4/xV2NXje9X5e8jUVVUqxlXCCPqv5NBMxlDpA==
X-Received: by 2002:a17:903:2445:b0:161:d47e:88cf with SMTP id l5-20020a170903244500b00161d47e88cfmr3413276pls.67.1652948184287;
        Thu, 19 May 2022 01:16:24 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u127-20020a627985000000b0050dc76281d3sm3576687pfc.173.2022.05.19.01.16.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2022 01:16:23 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: [PATCH v2 7/9] Makefile: add "po-update" rule to update po/XX.po
Date:   Thu, 19 May 2022 16:15:46 +0800
Message-Id: <20220519081548.3380-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220503132354.9567-1-worldhello.net@gmail.com>
References: <20220503132354.9567-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Since there is no longer a "po/git.pot" file in tree, a l10n team leader
has to run several commands to update their "po/XX.po" file:

    $ make pot
    $ msgmerge --add-location --backup=off -U po/XX.po po/git.pot

To make this process easier, add a new rule so that l10n team leaders
can update their "po/XX.po" with one command. E.g.:

    $ make po-update PO_FILE=po/zh_CN.po

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile   | 18 ++++++++++++++++++
 shared.mak |  1 +
 2 files changed, 19 insertions(+)

diff --git a/Makefile b/Makefile
index 34904b90d2..edebd44d5c 100644
--- a/Makefile
+++ b/Makefile
@@ -571,6 +571,7 @@ TCLTK_PATH = wish
 XGETTEXT = xgettext
 MSGCAT = msgcat
 MSGFMT = msgfmt
+MSGMERGE = msgmerge
 CURL_CONFIG = curl-config
 GCOV = gcov
 STRIP = strip
@@ -2716,6 +2717,7 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
 MSGCAT_FLAGS = --sort-by-file
+MSGMERGE_FLAGS = --add-location --backup=off --update
 LOCALIZED_C = $(FOUND_C_SOURCES) $(SCALAR_SOURCES) \
 	      $(FOUND_H_SOURCES) $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
@@ -2787,6 +2789,22 @@ po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
 .PHONY: pot
 pot: po/git.pot
 
+define check_po_file_envvar
+	$(if $(PO_FILE), \
+		$(if $(filter po/%.po,$(PO_FILE)), , \
+			$(error PO_FILE should match pattern: "po/%.po")), \
+		$(error PO_FILE is not defined))
+endef
+
+.PHONY: po-update
+po-update: po/git.pot
+	$(check_po_file_envvar)
+	@if test ! -e $(PO_FILE); then \
+		echo >&2 "error: $(PO_FILE) does not exist"; \
+		exit 1; \
+	fi
+	$(QUIET_MSGMERGE)$(MSGMERGE) $(MSGMERGE_FLAGS) $(PO_FILE) po/git.pot
+
 .PHONY: check-pot
 check-pot: $(LOCALIZED_ALL_GEN_PO)
 
diff --git a/shared.mak b/shared.mak
index 50d4596f0d..8cd170a7e7 100644
--- a/shared.mak
+++ b/shared.mak
@@ -63,6 +63,7 @@ ifndef V
 	QUIET_LNCP     = @echo '   ' LN/CP $@;
 	QUIET_XGETTEXT = @echo '   ' XGETTEXT $@;
 	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
+	QUIET_MSGMERGE = @echo '   ' MSGMERGE $@;
 	QUIET_GCOV     = @echo '   ' GCOV $@;
 	QUIET_SP       = @echo '   ' SP $<;
 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
-- 
2.36.0.1.g15c4090757

