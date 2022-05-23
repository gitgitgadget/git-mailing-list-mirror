Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F4FC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 15:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbiEWPX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 11:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbiEWPVx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 11:21:53 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF30F2A70E
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id m12so13410497plb.4
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZFUzfFAW6xFPRFK0IiAHdHdMUM2ECxYKp7kX5F1bqGU=;
        b=R+chum4tqQK62gu+3IPCqPphuZh3TgggTG3MisSY6dBq9dvbx8E0b0JPu65ufLl7ny
         QoDR0X55hDB8gC5C7fINNWANt0XHaxoPkq1gAGxA6aHYWJPgmXMxzJyPD77Y0UyVUGho
         lkiOCWIwSyvVEGmT+RyCJznf3DkyxKsD6rHo30IhFbPU4f61FdrYDdaHO+R9sZwVZ5cn
         cqLxBtWS8CeJ9McqJqkcyamxLNrF//EhY2jlimBUU6rcOSAxthMUrNj/Tuv5u72UPjNP
         8rMk9c7uDShZUgCwtsx2Cj5QMali8V9l0nxofHcdC8OIiLyDRbvIYFoqPDajvXPqdWWl
         OR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZFUzfFAW6xFPRFK0IiAHdHdMUM2ECxYKp7kX5F1bqGU=;
        b=0wY+1awUpx1Vrhs2vqjMIL1HZhuWddE9trZ9uORir68ol2vO35DVXRQzNDctmNHIbB
         dE+w4R8aD+C98Zz/BBCeg6EXGZ4DS1LaKreub4KsiEZRav5+4H8PFQVWv/P08D5YAEqM
         5fvezqT7Bbot3qgxfoIhTL4fg0A5ye0mJZcn0NXofx2Oa5d/lLuyaEVDOm/0GmrcSQjC
         +NYUs0NduFAUqZf3MwbZvovd+mOIA+6ot+mDSGgK6jMWumJh5su1WxL5o8afcft2v5DW
         9ZPvOsPwxPBjc98deuSeUnqeLguAxO8ayxEhDOtpBVekvXEMOiMGtmjdsjwem3rNvmQY
         Yq/g==
X-Gm-Message-State: AOAM530Vs+36WUjpFdZHqi/skras0Yo9wmbDdtu795ICShHd4QOan5rH
        eK66E816tMpdv5ZVzjau5uQ=
X-Google-Smtp-Source: ABdhPJyAw3WzqF+euxlTuz52r6aCJbKHHu3Lh+k8x8Aomq3sDCU3zKtbgP41tRKy53/tIr8uU1Qdig==
X-Received: by 2002:a17:90a:4148:b0:1df:6811:8633 with SMTP id m8-20020a17090a414800b001df68118633mr26762920pjg.94.1653319311369;
        Mon, 23 May 2022 08:21:51 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y13-20020a1709027c8d00b0015e8d4eb2cfsm5280287pll.281.2022.05.23.08.21.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 May 2022 08:21:51 -0700 (PDT)
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
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 8/9] Makefile: add "po-init" rule to initialize po/XX.po
Date:   Mon, 23 May 2022 23:21:27 +0800
Message-Id: <20220523152128.26380-9-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523012531.4505-1-worldhello.net@gmail.com>
References: <20220523012531.4505-1-worldhello.net@gmail.com>
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

    make po-init PO_FILE=po/XX.po

[^1]: https://github.com/git-l10n/git-po-helper/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile      | 43 ++++++++++++++++++++++++++++++++++++++++++-
 po/.gitignore |  1 +
 shared.mak    |  1 +
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 34a64c5fa7..a3f8446de9 100644
--- a/Makefile
+++ b/Makefile
@@ -2808,6 +2808,7 @@ po-update: po/git.pot
 	$(check_po_file_envvar)
 	@if test ! -e $(PO_FILE); then \
 		echo >&2 "error: $(PO_FILE) does not exist"; \
+		echo >&2 'To create an initial po file, use: "make po-init PO_FILE=po/XX.po"'; \
 		exit 1; \
 	fi
 	$(QUIET_MSGMERGE)$(MSGMERGE) $(MSGMERGE_FLAGS) $(PO_FILE) po/git.pot
@@ -2815,6 +2816,46 @@ po-update: po/git.pot
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
+	$(QUIET_GEN)$(gen_pot_header)
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
@@ -3350,7 +3391,7 @@ cocciclean:
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build
-	$(RM) po/git.pot
+	$(RM) po/git.pot po/git-core.pot
 	$(RM) *.res
 	$(RM) $(OBJECTS)
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
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

