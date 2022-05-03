Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE82C433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 13:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbiECN2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 09:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiECN1z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 09:27:55 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2529037010
        for <git@vger.kernel.org>; Tue,  3 May 2022 06:24:23 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 15so14012339pgf.4
        for <git@vger.kernel.org>; Tue, 03 May 2022 06:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJ1MGBRgQe2dGcNXMI4X+W24SsfDIF1l3mn4JZdqSIQ=;
        b=CLXZ/FhKycVBxz49tnc2+nSfX8jKhwIR9Omoi1fe/QsDBRXj1hcECINwJUYYLtdlf3
         VdF2S3WCgaVDSNxqUd982Qo/pBI5G4u5tNmpXSm5EO9PWKHWS9Xq2yMaLZMjMe9J/92Y
         KmvYJpb06E3ZmourDFGR//E7Fk3VE+HsylipUbkffHuAdaXwuL6pNP4H60Nn19X0MKTi
         1mEqrcXikCO1Z3QMkHHTrCG2zsweQirgy2JZldJnr3FjVesYA2hu74hLGoLt120m4Rg4
         eejEGmcTuoOzRimr/nizDqdsn+bfnjSQcvGY8jQL6rEYVLlxzpUj5p6CSL8zyVICFHAz
         Eynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJ1MGBRgQe2dGcNXMI4X+W24SsfDIF1l3mn4JZdqSIQ=;
        b=KSa4eKiu8pQ7Z9JQcH+2Tjj/4JPjyhkLWGrwgJaOsGeCAb/RhyYFkc4l46d5v3FXY7
         nbT1OyUpDu9AuF6HcbILTCB6sE10bIrcIYx7iehxNCJEw+vGMFDocAxwNdKRQ75rj/Vc
         vEN9mBWHxzkgjN2c+SzBYaM1lzy9A5GBRxpqqJycMaf8AuOBClrvb9YL4zTY/+VCmLpA
         Tb5PdzFTBh3DfYkcMPeybmRxbfMNf8UvOcqAD69iAsWJTX8WssdnL/+2KAFvTBoaHJGN
         JACBbBKSU5sA2sfm0OtTT6he3qAcAZRlbFKP5retEaEpFy9y9CR30yhFLc2J9Y4fLP/7
         /tow==
X-Gm-Message-State: AOAM532QL6CthoPAZeXv0dvI7fl3OTlCyVk5ykWnH+3minttts/hTU5R
        TQOJMeyNAPj6BwydMcYJSn0=
X-Google-Smtp-Source: ABdhPJxeVYqIG6ew41jI7uMm7R0xRs2VGiG2ne+HVRPlhCyKjIz5k9A0gqjs8/C5F+FWxNvJqfP8ZQ==
X-Received: by 2002:a05:6a00:1f0b:b0:50a:8181:fecb with SMTP id be11-20020a056a001f0b00b0050a8181fecbmr15859802pfb.12.1651584262635;
        Tue, 03 May 2022 06:24:22 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78008000000b0050dc76281b3sm6484950pfi.141.2022.05.03.06.24.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2022 06:24:21 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
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
Subject: [PATCH 7/9] Makefile: add "po-update" rule to update po/XX.po
Date:   Tue,  3 May 2022 21:23:52 +0800
Message-Id: <20220503132354.9567-8-worldhello.net@gmail.com>
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
---
 Makefile   | 16 ++++++++++++++++
 shared.mak |  1 +
 2 files changed, 17 insertions(+)

diff --git a/Makefile b/Makefile
index 2f28648900..7c808b910d 100644
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
@@ -2787,6 +2789,20 @@ po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
 .PHONY: pot
 pot: po/git.pot
 
+po-update: po/git.pot
+ifndef PO_FILE
+	$(error not define variable "PO_FILE")
+else
+ifeq ($(filter po/%.po,$(PO_FILE)),)
+	$(error PO_FILE should match pattern: "po/%.po")
+endif
+endif
+	@if test ! -e $(PO_FILE); then \
+		echo >&2 "error: $(PO_FILE) does not exist"; \
+		exit 1; \
+	fi
+	$(QUIET_MSGMERGE)$(MSGMERGE) $(MSGMERGE_FLAGS) $(PO_FILE) po/git.pot
+
 .PHONY: check-pot
 check-pot: pot
 
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
2.35.1.577.g74cc1aa55f

