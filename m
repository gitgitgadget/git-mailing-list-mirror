Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E9DC433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 08:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiESIQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 04:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiESIQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 04:16:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C3460DB2
        for <git@vger.kernel.org>; Thu, 19 May 2022 01:16:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so8124452pjr.1
        for <git@vger.kernel.org>; Thu, 19 May 2022 01:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9tATN4KvguBXyDpFgZmfN+PN9pf3Ka70B27ItCSQ/Vs=;
        b=OxQsdGQAGWl8YbKjDsjLKW2Pl0yUg36lpzCyYoTOmoaex+K0jxpeF8lzpVk4z+prkO
         J2GDsEwX1hJoB2GBcS6QjVD7gTOOf7SMTGhx69a3lzMtAYq/Th7dVbsf/Fg19osSIBa7
         joI3H4wl+MgZwCfg9oquUxfUysWcoijR680V/8aEhXM56aPWCtIPesIDd4sOJiU05gU8
         Yig6usdP1VBXKYYAFW8EnSvKs1Dj3PU1ITk7V6RYm4uF2/SVD4wEo3sk7CfxrifYxP4X
         fRnx6ifMIYxWGB3YHC3OQJznwIZbQAdhbg9Rwc8fiY5X1kMXn9dijLtaf/vyondgnCAU
         oRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9tATN4KvguBXyDpFgZmfN+PN9pf3Ka70B27ItCSQ/Vs=;
        b=E1mGw36LP/f1kiKrnqE6mHIovGpgG91ayk7xpz9daRcT2CTdsS+ggFjDE8hftNf8OQ
         KkzwzOkQ3ZMRgWCjfjbP70Muoq99EM7XdowKzmn3Dph8P3o9h4jZ7xfqQ6RaQ2xMkJ54
         y9w/Z3q3+NJC2QSTX7ModctR20nwIOS/LJCGlUuNt3aK68rVxtRDlAYslZ1GZruqGFXN
         IlH7fDA0J+GvaGzXbntFCgZWAmsNQ38RN0v4lNnY0cKLvy0sMbiXfyH0fW2lBGIDe0zY
         NvhDkd0vGlJAlNK3sKTXQEcGgF+0AvTlsXGhHYib80Gm3CfkNOEDSN6WusirXMZ9talc
         f1lA==
X-Gm-Message-State: AOAM533rXRH/WifqLWx1RJrwirljHf+FowD7tSlqJArUA0SCB/JcAC58
        WEVk+q8qACPILkW5sBpUeE4=
X-Google-Smtp-Source: ABdhPJyrF9vs0mPUqwcgMN1utKmoteuroRgyTyBVHcoFDmoHDfWeXs9v0XtmyxrshnzKoP4F3Fu72Q==
X-Received: by 2002:a17:90b:4a4a:b0:1df:a250:e583 with SMTP id lb10-20020a17090b4a4a00b001dfa250e583mr3856479pjb.172.1652948186087;
        Thu, 19 May 2022 01:16:26 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u127-20020a627985000000b0050dc76281d3sm3576687pfc.173.2022.05.19.01.16.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2022 01:16:25 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
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
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 8/9] Makefile: add "po-init" rule to initialize po/XX.po
Date:   Thu, 19 May 2022 16:15:47 +0800
Message-Id: <20220519081548.3380-9-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220503132354.9567-1-worldhello.net@gmail.com>
References: <20220503132354.9567-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

The core translation is the minimum set of work that must be done for a
new language translation.

There are over 5000 messages in the template message file "po/git.pot"
that need to be translated. It is not a piece of cake for such a huge
workload. So we used to define a small set of messages called "core
translation" that a new l10n contributor must complete before sending
pull request to the l10n coordinator.

By pulling in some parts of the git-po-helper[^1] logic, we add rule
"core-pot" to create this core translation message "po/git-core.pot":

    make core-pot

To help new l10n contributors to initialized their "po/XX.pot" from
"po/git-core.pot", we also add new rules "po-init":

    make po-init POT_FILE=po/XX.po

[^1]: https://github.com/git-l10n/git-po-helper/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile      | 44 ++++++++++++++++++++++++++++++++++++++++++++
 po/.gitignore |  1 +
 shared.mak    |  1 +
 3 files changed, 46 insertions(+)

diff --git a/Makefile b/Makefile
index edebd44d5c..0a687a6eb2 100644
--- a/Makefile
+++ b/Makefile
@@ -2801,6 +2801,7 @@ po-update: po/git.pot
 	$(check_po_file_envvar)
 	@if test ! -e $(PO_FILE); then \
 		echo >&2 "error: $(PO_FILE) does not exist"; \
+		echo >&2 'To create an initial po file, use: "make po-init PO_FILE=po/XX.po"'; \
 		exit 1; \
 	fi
 	$(QUIET_MSGMERGE)$(MSGMERGE) $(MSGMERGE_FLAGS) $(PO_FILE) po/git.pot
@@ -2808,6 +2809,49 @@ po-update: po/git.pot
 .PHONY: check-pot
 check-pot: $(LOCALIZED_ALL_GEN_PO)
 
+### TODO FIXME: Translating everything in these files is a bad
+### heuristic for "core", as we'll translate obscure error() messages
+### along with commonly seen i18n messages. A better heuristic would
+### be to e.g. use spatch to first remove error/die/warning
+### etc. messages.
+LOCALIZED_C_CORE =
+LOCALIZED_C_CORE += builtin/checkout.c
+LOCALIZED_C_CORE += builtin/clone.c
+LOCALIZED_C_CORE += builtin/index-pack.c
+LOCALIZED_C_CORE += builtin/push.c
+LOCALIZED_C_CORE += builtin/reset.c
+LOCALIZED_C_CORE += remote.c
+LOCALIZED_C_CORE += wt-status.c
+
+LOCALIZED_C_CORE_GEN_PO = $(LOCALIZED_C_CORE:%=.build/pot/po/%.po)
+
+.PHONY: core-pot
+core-pot: po/git-core.pot
+
+.build/pot/git-core.header: $(LOCALIZED_C_CORE_GEN_PO)
+	$(call mkdir_p_parent_template)
+	$(QUIET_XGETTEXT)$(XGETTEXT) $(XGETTEXT_FLAGS_C) \
+		-o - /dev/null | \
+	sed -e 's|charset=CHARSET|charset=UTF-8|g' >$@ && \
+	echo '"Plural-Forms: nplurals=INTEGER; plural=EXPRESSION;\\n"' >>$@
+
+po/git-core.pot: .build/pot/git-core.header $(LOCALIZED_C_CORE_GEN_PO)
+	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
+
+.PHONY: po-init
+po-init: po/git-core.pot
+	$(check_po_file_envvar)
+	@if test -e $(PO_FILE); then \
+		echo >&2 "error: $(PO_FILE) exists already"; \
+		exit 1; \
+	fi
+	$(QUIET_MSGINIT)msginit \
+		--input=$< \
+		--output=$(PO_FILE) \
+		--no-translator \
+		--locale=$(PO_FILE:po/%.po=%)
+
+## po/*.po files & their rules
 ifdef NO_GETTEXT
 POFILES :=
 MOFILES :=
diff --git a/po/.gitignore b/po/.gitignore
index 37d1301b32..ff0e5176a6 100644
--- a/po/.gitignore
+++ b/po/.gitignore
@@ -1,2 +1,3 @@
 /build
 /git.pot
+/git-core.pot
diff --git a/shared.mak b/shared.mak
index 8cd170a7e7..4330192e9c 100644
--- a/shared.mak
+++ b/shared.mak
@@ -62,6 +62,7 @@ ifndef V
 	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
 	QUIET_LNCP     = @echo '   ' LN/CP $@;
 	QUIET_XGETTEXT = @echo '   ' XGETTEXT $@;
+	QUIET_MSGINIT  = @echo '   ' MSGINIT $@;
 	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
 	QUIET_MSGMERGE = @echo '   ' MSGMERGE $@;
 	QUIET_GCOV     = @echo '   ' GCOV $@;
-- 
2.36.0.1.g15c4090757

