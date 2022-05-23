Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089C0C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 15:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbiEWPVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 11:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbiEWPVv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 11:21:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6454829827
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so2486387pjt.4
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SaMV7BUtsmTAzjcN91ZvTykXcyiKjdC7IYjW++jNcTE=;
        b=M77y+Q55POrYV4zX6qRE6To2nK3wAXf2wCGR/9jXvFAxQsUH/LAksoOsi4sjO1Qdxo
         qsl8Pnx1B9exqrexHDfhsWNR/muIg2cIwx1D8SZP+LzRfJD9WxhObuO5eKJl34NQc0hm
         ztYmv+6cI9rLztrjuy+lyuRnEgunxk412lSJBuYv5uiq3pZePsBBOlzU1rrEJKxfibo2
         kbm75tGjjgVmNzzclRXtwBtDwvZzcIVSPh8rxfqNCSo4y/VC58jqW23c58PxWYKNpNgp
         ADyAgACdEDa0A5BajoKtBNU4ndtkBuq0UBk98pN0u5hHrxInfecVjZrKv/nDxQwmURAZ
         CeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SaMV7BUtsmTAzjcN91ZvTykXcyiKjdC7IYjW++jNcTE=;
        b=kBboOc6zeQZluymhFNL/+jNGIWbk0VQhdI6MYcNG0o9H3h3cvUNHc+HmWW/9nCRY+0
         Ld0oaMjuAHaJPAsaSaeJOAzd54nBSro3CcDJOWhorFliZh/KWauuahA0IImf8IN1I5PS
         k8Fh9SPO2/9Y3y5nuT8aeNGrbrkKhYLSCGtcLhD1LY8GvCH2+wdqFx5K9HduWS3NmJaI
         rFOuBVI53MXEE8gtb0u+iB7tutBCwHJ1tNQiibGQPPnm9kFwG6Ub5FO91tpbnIWMXsiu
         HmFUJOoS+Xq4D3zSDcejGdJmiiezXOmBILNBMqmGOS57pTd4lvPA34sRBWSI1Q4tOB57
         H3kQ==
X-Gm-Message-State: AOAM531qM6zWe8jYfYHAw/C9uqBMmBy6B8w6cgZc11PC5eA7k3YM0DAw
        L0fZB7WZqd7E63EAsRw9YOc=
X-Google-Smtp-Source: ABdhPJxg1UsIYnwOB/TcrjflBQPa0sGwrsNooC+vNQ6HJT4b/Utrg0SA9/tyAr7whBnqAaIh4M5hFQ==
X-Received: by 2002:a17:903:41d0:b0:161:bec6:b33b with SMTP id u16-20020a17090341d000b00161bec6b33bmr23076932ple.21.1653319309952;
        Mon, 23 May 2022 08:21:49 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y13-20020a1709027c8d00b0015e8d4eb2cfsm5280287pll.281.2022.05.23.08.21.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 May 2022 08:21:49 -0700 (PDT)
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
        Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 7/9] Makefile: add "po-update" rule to update po/XX.po
Date:   Mon, 23 May 2022 23:21:26 +0800
Message-Id: <20220523152128.26380-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523012531.4505-1-worldhello.net@gmail.com>
References: <20220523012531.4505-1-worldhello.net@gmail.com>
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
 Makefile   | 18 ++++++++++++++++++
 shared.mak |  1 +
 2 files changed, 19 insertions(+)

diff --git a/Makefile b/Makefile
index 161ebf4ff3..34a64c5fa7 100644
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
 LOCALIZED_C = $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
 	      $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
@@ -2794,6 +2796,22 @@ po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
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

