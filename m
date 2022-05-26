Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBDDC433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 14:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347802AbiEZOvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 10:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347851AbiEZOuu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 10:50:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BDC5003F
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o10-20020a17090a4e8a00b001df2fcdc165so4644317pjh.0
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P/DicxfJyrhdWtWJobVLtkTcCD+jEZ5GWfGfeF52Iro=;
        b=lusKASX6Gel8jVAzssGRR0v6mY1D+f6NNoi5Sf/PLb/ULKTe+7m/8Iq6m3m7xvNUiq
         AAOc9zOXwz2Lq4m67nlPL1R2u7XdaTTjYsTfTrUYysLkpKqtTh7c8+sbBVqxQ+HFVnMG
         W5WI98EpAC3EQf/EmpnLGJAXkawLCgRHPdpVXYNya8JV9pi5kLFS23oXLsbuE/w7Z9Fb
         UUcTn8R4mZeP9I6kpNF9HaZNewiEZvgpGMIdxeVRfZ1jvwEqc4MHUZA24I1hvLApLijA
         B5xKiFLyJ0xdtGijsXpFnH/HlQ0KaU4wuetT2K6wc8EXjeNIHZp16CH5/0jMeyZGLYco
         pb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P/DicxfJyrhdWtWJobVLtkTcCD+jEZ5GWfGfeF52Iro=;
        b=3oxhN9v2IGhKWqEyGqHgEBJShNidLTWRGo68NQ+aaHYACrBS0yxkWbAmvfSDOwNspi
         U3pjlZrJ8k95J1eha+01cNOdlrd3QeNMkFFbfWxRlvBPYmcFb6ghbyMFSpjReFiSFzv7
         AOMGxM4DAyN1mx7dfH3JCXezULxXD4GUAKR3KJPO1VbkSDmPpNKTjY4/XxGoqgOX37qa
         HjC4ZddViw5STV5O+rsmqA1dHBnD8WTCmqOenir4IBlOVKtLwCxLxXKEwJaNllcMhyBy
         mHCGkzpf/t8r5f4X52ImeoEpbMi4xPyLLjmXjTOkq5Bk9pwMaaYZJubUuuepM/9vsfyY
         K8qQ==
X-Gm-Message-State: AOAM532X3CxvvgkWSioRt/NS1FC8XVq3bd4mnbfStxzmUC/ZRYw1prfK
        2KCUUjazTfC6TAoc2OZqR6Y=
X-Google-Smtp-Source: ABdhPJxQze/9tGzd7VtZtM2bBRiaTWi4xLBhT9RV153yf7alC93h60VeCVQpXGh6h3rEr4jxDt5Ung==
X-Received: by 2002:a17:90a:e543:b0:1e0:8961:302d with SMTP id ei3-20020a17090ae54300b001e08961302dmr3052018pjb.129.1653576648825;
        Thu, 26 May 2022 07:50:48 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i16-20020a056a00005000b00518382bceaesm1597480pfk.57.2022.05.26.07.50.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 May 2022 07:50:48 -0700 (PDT)
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
Subject: [PATCH v5 08/10] Makefile: add "po-update" rule to update po/XX.po
Date:   Thu, 26 May 2022 22:50:33 +0800
Message-Id: <20220526145035.18958-9-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523152128.26380-1-worldhello.net@gmail.com>
References: <20220523152128.26380-1-worldhello.net@gmail.com>
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
index cc3eb856b2..efd242b255 100644
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
@@ -2715,6 +2716,7 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
+MSGMERGE_FLAGS = --add-location --backup=off --update
 LOCALIZED_C = $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
 	        $(GENERATED_H))
 LOCALIZED_SH = $(sort $(SCRIPT_SH) git-sh-setup.sh)
@@ -2792,6 +2794,22 @@ po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
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

