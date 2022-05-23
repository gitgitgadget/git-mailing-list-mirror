Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD85C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 01:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiEWB1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 May 2022 21:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351841AbiEWBZu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 May 2022 21:25:50 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC2137A09
        for <git@vger.kernel.org>; Sun, 22 May 2022 18:25:49 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id a38so9524789pgl.9
        for <git@vger.kernel.org>; Sun, 22 May 2022 18:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vol77vTJFq6067b+UeYULbASi+cNQuUEHJ62emi0vLU=;
        b=PzqqVuPfIGMrywOe9hx8fGu02q8t+V9fPK44pShaCCzyWSESNWsEYvZ+kq2aergrkQ
         QRfiDgXK+eCYRIusgw928B93OLW1EW9F4xf245abKq3E5yTVsxhGE9RtunZAFl6nXyZ4
         LDUQRQtaY+5qXCK4hPrFPIjOf/Do/PR94efms0EZxkLQEu7pUa4Vea2LzbifK3QkRtq8
         5dIVWb/sU5m5dlKsPECuHUpl6y2uYbKgP5ziDyxE3kRtCKLvm3U++dGHJRP/UrLt37BC
         J33jzWgpQ6h10r0RETS+n/qLF+aoQ2QzRWsEonKssFBUCcX0Wn4fdL5ScDBZd3pBFBBH
         4QCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vol77vTJFq6067b+UeYULbASi+cNQuUEHJ62emi0vLU=;
        b=nBGiod19yR0uqv1sXk9eQrJMtegCtDnvo1K7p5tjY3Vtun3w2wtWG8OvkYY8z2X+kV
         GfqZgxDhkFOT+pRVc2QyBKTe0Q+GOqSCq20HfpP/pSwbcLiDH+uogNmyIKHHV7RvDrU0
         LvQAxRppwBHZzU4XrR9qUVT7A9stm4nJeaB4ZnIzFcr9i8H0ZIa8z3Ax9Dm9fUtVFHFw
         0MhTOwfj7H1PAAHyd+8zohu8EWJqBvL6wynTmtczCKJyYqfGwqhek/iiUK0sJWJ284iG
         ob7ze8PS9MbH9zNX9zkh9IIfpvZDA++PGl1e39EH9u0P19fsBtp9Lqc4rv7mnoSKt77k
         f8dg==
X-Gm-Message-State: AOAM532+XKtHn8shTEfybwAN3G2x1B3UDM9UAZUZneu/Nu9kiuYHzkgF
        qaiY69i6S867TP44c68ooNo=
X-Google-Smtp-Source: ABdhPJwdkfIu/crwKunODaEpKM90UacKA9b+9kiScO5kGdVpjTE1OtYT6XMyyTMSxoZglyu5Sz7gNQ==
X-Received: by 2002:a63:f70d:0:b0:3f6:a9d:281 with SMTP id x13-20020a63f70d000000b003f60a9d0281mr18055242pgh.287.1653269148901;
        Sun, 22 May 2022 18:25:48 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7985a000000b00518142f8c37sm6027566pfq.171.2022.05.22.18.25.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2022 18:25:48 -0700 (PDT)
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
Subject: [PATCH v3 7/9] Makefile: add "po-update" rule to update po/XX.po
Date:   Mon, 23 May 2022 09:25:29 +0800
Message-Id: <20220523012531.4505-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220519081548.3380-1-worldhello.net@gmail.com>
References: <20220519081548.3380-1-worldhello.net@gmail.com>
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
index 3122672263..09cbde4c2a 100644
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

