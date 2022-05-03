Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33BFC433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 13:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbiECN2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 09:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbiECN15 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 09:27:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0475B377C7
        for <git@vger.kernel.org>; Tue,  3 May 2022 06:24:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n8so14940389plh.1
        for <git@vger.kernel.org>; Tue, 03 May 2022 06:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tG5ICUPa3fUcWjgjOfx0hCLuoTVUK8DRmi6sLe2Q1p8=;
        b=Y2VSJUo/ytLHhenOpItv45jYXyIRf985bgFJfdyYWac1xsbJ5BszsPBGpQlQX9es2/
         A5RJAPXoG0GW5hu6fgG/nCGwgwS6e77REb8ri4hnircyVB0asDfDGX5v6s13ECt1Vd34
         zSrD5WQpBZ8IDLbGRxH4BvbdLDGChue7S2ihQBxr2ktGqNBExObMUgBXZhbzNOioM5q0
         RpVI1G8Jbn/73azMAQ9QoYaziO0eoR9mhBn+JxPitnU1l/8OhrquD3OcLV0cMqU/RpoV
         MZ4HLWtXt3KdWuiPDmFrLUHUipd2tPz90EFmiI4c+H2/Gdzv8MjgGtg/so2eOmCzggz8
         UrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tG5ICUPa3fUcWjgjOfx0hCLuoTVUK8DRmi6sLe2Q1p8=;
        b=vbYnKoXzdsIGmP+B/36F3QyzbHxeqPoALQRFhoi5ZozxxM5EQb3SXBpm/ZrwelBt+j
         fgQZXObb9+BJxUCsaqt73W/KodRtcJY3/8CDvL5UlP0n/2pS3GC0+U6BY38/FsV+usuV
         CVVnvYV2Yri721Kc/MZRgfqKzmoJ/WZn6h8DBjgIodtkAb9MzWGWHS4meOQFcRfJvZn3
         ASi44rFlpvHAhfcXr0oj3rtakqB5xROq0WAX4Qrni2g+eCJ1zSfBdaBIihPYWWcEMxWS
         XPrybkjIvQMw9L33xkuSMq3x10sdpaIEO9c1qCXQTR+DvQOl83SvkRBPRxnA08T0Qt+a
         kk7g==
X-Gm-Message-State: AOAM530K8H4m9Jv/e5D2EZe6vPZAv62t28Yh0Ao6l6rJLtp8uvTzpPaa
        Tey/dyjo7+e6luNv1hEog3M=
X-Google-Smtp-Source: ABdhPJyioJOlOdbhOZBu9zoauZrLVsjz+WyiN7rRjziinBXSijCoIIc/iI8cWBmifC/ekS/77iaAdg==
X-Received: by 2002:a17:903:2352:b0:15e:5aad:af5c with SMTP id c18-20020a170903235200b0015e5aadaf5cmr16867812plh.116.1651584264531;
        Tue, 03 May 2022 06:24:24 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78008000000b0050dc76281b3sm6484950pfi.141.2022.05.03.06.24.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2022 06:24:23 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Alexander Shopov <ash@kambanaria.org>,
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
Subject: [PATCH 8/9] Makefile: add "po-init" rule to initialize po/XX.po
Date:   Tue,  3 May 2022 21:23:53 +0800
Message-Id: <20220503132354.9567-9-worldhello.net@gmail.com>
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
---
 Makefile      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 po/.gitignore |  1 +
 shared.mak    |  1 +
 3 files changed, 52 insertions(+)

diff --git a/Makefile b/Makefile
index 7c808b910d..b7b65ac706 100644
--- a/Makefile
+++ b/Makefile
@@ -2799,6 +2799,7 @@ endif
 endif
 	@if test ! -e $(PO_FILE); then \
 		echo >&2 "error: $(PO_FILE) does not exist"; \
+		echo >&2 'To create an initial po file, use: "make po-init PO_FILE=po/XX.po"'; \
 		exit 1; \
 	fi
 	$(QUIET_MSGMERGE)$(MSGMERGE) $(MSGMERGE_FLAGS) $(PO_FILE) po/git.pot
@@ -2806,6 +2807,55 @@ endif
 .PHONY: check-pot
 check-pot: pot
 
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
+ifndef PO_FILE
+	$(error not define variable "PO_FILE")
+else
+ifeq ($(filter po/%.po,$(PO_FILE)),)
+	$(error PO_FILE should match pattern: "po/%.po")
+endif
+endif
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
2.35.1.577.g74cc1aa55f

