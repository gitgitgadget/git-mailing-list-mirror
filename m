Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD3EC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 14:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347837AbiEZOun (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 10:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243651AbiEZOul (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 10:50:41 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828875003F
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:39 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e66so1494960pgc.8
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kiM+13ROG/Dp82g1X5jy0l90hBRgoNX21qGUsT1JgOU=;
        b=MD77ll3W6NX80MPfaZqxrhgV2dzcIf/ORdYikwHiRZjTrtDyYsELjNOTbVb5QBs2IT
         5FRZoPiOGjpAhfJYYemaQ5JNKipDiwJMgutWfUCXt62Pr2voXA+qFkoH+1AJ1AjpS8Ve
         ibA6QSfaBZVm8loa2bwOoCxZ19ehgKoq5k1aOa1b2FlGWXYAObsF9zlJqIl9xB4q2/59
         Zj+HPQpBXTybzoP95FO8A8lyRwm1fubVbwfOwwxrC3/E9Kz/S8xtglQYbFXvKt9ntXHQ
         n5FPbfShtzySOdqz/ua+UimhqQ1hrGRJ/nS+fkWG5W8azn7odngGFVpcrSBSUqnfkM+v
         mAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kiM+13ROG/Dp82g1X5jy0l90hBRgoNX21qGUsT1JgOU=;
        b=7iJ1q81BBM1SzNSYQbq8e+10FI+JYvhfw8Ab2c4dN+fptPJJSKjFviG7rkNqkhr0WR
         pKOQlpcqtFUImc6etIoHmq49ggD0rwCEinIlYxCCun09ugxad8POuxVSqo0hZiVUhATq
         zdyVfhz7TZfhdrXFS+K7og00QOfteNLcvYuES6g26wLDVunL/5Kn1ZCbKwnjWjm5+hXE
         KOiHcZRwBcSScVkk5wCgljitzCecDBdNNknq7w68d74nhC1cD9pX/AdJAiUzxKXLDVwC
         vtRjTH4asHyUJrGKmnMBrq8On7H/dvpE1rAhwKnADC8l++JONIja5FE1Np88/46rTfBz
         2mjA==
X-Gm-Message-State: AOAM532EgKbXgRNDLDAzPQG7ibU83EY+C+kjEhsth0Ke4jPaKwNJ+Z7p
        SJ1F4Ep/odNMB3ldiQItmvI=
X-Google-Smtp-Source: ABdhPJwwj5Zyt8Wi/75bLCcUzGurfQ73yFYH5HRowfocP79z27Qkcw3iSOH5F6uyGQY6di8fwolBTA==
X-Received: by 2002:a65:6c08:0:b0:3f2:6a6a:98d with SMTP id y8-20020a656c08000000b003f26a6a098dmr33109738pgu.30.1653576638891;
        Thu, 26 May 2022 07:50:38 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i16-20020a056a00005000b00518382bceaesm1597480pfk.57.2022.05.26.07.50.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 May 2022 07:50:38 -0700 (PDT)
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
Subject: [PATCH v5 00/10] Incremental po/git.pot update and new l10n workflow
Date:   Thu, 26 May 2022 22:50:25 +0800
Message-Id: <20220526145035.18958-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523152128.26380-1-worldhello.net@gmail.com>
References: <20220523152128.26380-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Changes since v4:

1. Patch 1/10: use sort function instead of passing option "--sort-by-file".
2. Patch 3/10: when finding source files, ignore ".build" directory.
3. New patch 5/10: remove duplicate and unwanted files in FOUND_SOURCE_FILES
4. Patch 7/10: no "--sort-by-file" option $(MSGCAT_FLAGS) for msgcat.
5. Patch 9/10: no "--sort-by-file" option $(MSGCAT_FLAGS) for msgcat,
               and remove unused "core-pot" target.


Range-diff vs v4:

 1:  325868b993 ! 1:  6a5409fd4f Makefile: sort "po/git.pot" by file location
    @@ Metadata
     Author: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## Commit message ##
    -    Makefile: sort "po/git.pot" by file location
    +    Makefile: sort source files before feeding to xgettext
     
         We will feed xgettext with more C source files and in different order
         in subsequent commit. To generate a stable "po/git.pot" regardless of
    -    the number and order of input source files, we pass the option
    -    "--sort-by-file" to xgettext program.
    +    the number and order of input source files, we sort the c, perl, and
    +    shell source files in groups before feeding them to xgettext.
    +
    +    Ævar suggested that we should not pass the option "--sort-by-file" to
    +    xgettext to sort the translatable strings, as it will mix the three
    +    groups of source files (c, perl and shell) in the file "po/git.pot",
    +    and change the order of translatable strings in the same line of a file.
     
         With this update, the newly generated "po/git.pot" will have the same
         entries while in a different order.
    @@ Commit message
         We won't checkin the newly generated "po/git.pot", because we will
         remove it from tree in a later commit.
     
    +    Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## Makefile ##
    -@@ Makefile: XGETTEXT_FLAGS = \
    - 	--force-po \
    - 	--add-comments=TRANSLATORS: \
    - 	--msgid-bugs-address="Git Mailing List <git@vger.kernel.org>" \
    -+	--sort-by-file \
    - 	--from-code=UTF-8
    - XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
    - 	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
    +@@ Makefile: XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
    + 	--keyword=gettextln --keyword=eval_gettextln
    + XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
    + 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
    +-LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
    +-LOCALIZED_SH = $(SCRIPT_SH)
    +-LOCALIZED_SH += git-sh-setup.sh
    +-LOCALIZED_PERL = $(SCRIPT_PERL)
    ++LOCALIZED_C = $(sort $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H))
    ++LOCALIZED_SH = $(sort $(SCRIPT_SH) git-sh-setup.sh)
    ++LOCALIZED_PERL = $(sort $(SCRIPT_PERL))
    + 
    + ifdef XGETTEXT_INCLUDE_TESTS
    + LOCALIZED_C += t/t0200/test.c
 2:  acf2f62e66 ! 2:  976f75ce00 Makefile: generate "po/git.pot" from stable LOCALIZED_C
    @@ Makefile: XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
      	--keyword=gettextln --keyword=eval_gettextln
      XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
      	--keyword=__ --keyword=N__ --keyword="__n:1,2"
    --LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
    -+LOCALIZED_C = $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
    -+	      $(GENERATED_H)
    - LOCALIZED_SH = $(SCRIPT_SH)
    - LOCALIZED_SH += git-sh-setup.sh
    - LOCALIZED_PERL = $(SCRIPT_PERL)
    +-LOCALIZED_C = $(sort $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H))
    ++LOCALIZED_C = $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
    ++	        $(GENERATED_H))
    + LOCALIZED_SH = $(sort $(SCRIPT_SH) git-sh-setup.sh)
    + LOCALIZED_PERL = $(sort $(SCRIPT_PERL))
    + 
 3:  775c37bc69 !  3:  c881176a8f Makefile: have "make pot" not "reset --hard"
    @@ Makefile: INSTALL = install
      MSGFMT = msgfmt
      CURL_CONFIG = curl-config
      GCOV = gcov
    +@@ Makefile: SOURCES_CMD = ( \
    + 		-o \( -name '[tp][0-9][0-9][0-9][0-9]*' -prune \) \
    + 		-o \( -name contrib -type d -prune \) \
    + 		-o \( -name build -type d -prune \) \
    ++		-o \( -name .build -type d -prune \) \
    + 		-o \( -name 'trash*' -type d -prune \) \
    + 		-o \( -name '*.[hcS]' -type f -print \) \
    + 		-o \( -name '*.sh' -type f -print \) \
     @@ Makefile: XGETTEXT_FLAGS = \
      	--force-po \
      	--add-comments=TRANSLATORS: \
      	--msgid-bugs-address="Git Mailing List <git@vger.kernel.org>" \
     +	--package-name=Git \
    - 	--sort-by-file \
      	--from-code=UTF-8
      XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
    -@@ Makefile: XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
    - 	--keyword=gettextln --keyword=eval_gettextln
    - XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
    - 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
    -+MSGCAT_FLAGS = --sort-by-file
    - LOCALIZED_C = $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
    - 	      $(GENERATED_H)
    - LOCALIZED_SH = $(SCRIPT_SH)
    + 	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
     @@ Makefile: LOCALIZED_SH += t/t0200/test.sh
      LOCALIZED_PERL += t/t0200/test.perl
      endif
    @@ Makefile: LOCALIZED_SH += t/t0200/test.sh
     -	git reset --hard
     -	mv $@+ $@
     +po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO) FORCE
    -+	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $(filter-out FORCE,$^) >$@
    ++	$(QUIET_GEN)$(MSGCAT) $(filter-out FORCE,$^) >$@
      
      .PHONY: pot
      pot: po/git.pot
 4:  55ee049b0a !  4:  672c91c341 i18n CI: stop allowing non-ASCII source messages in po/git.pot
    @@ Commit message
     
      ## Makefile ##
     @@ Makefile: XGETTEXT_FLAGS = \
    + 	--force-po \
      	--add-comments=TRANSLATORS: \
      	--msgid-bugs-address="Git Mailing List <git@vger.kernel.org>" \
    - 	--package-name=Git \
    --	--sort-by-file \
    +-	--package-name=Git \
     -	--from-code=UTF-8
    -+	--sort-by-file
    ++	--package-name=Git
      XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
      	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
      XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 -:  ---------- >  5:  475680c594 Makefile: remove duplicate and unwanted files in FOUND_SOURCE_FILES
 5:  69338521aa =  6:  9023b94c65 po/git.pot: this is now a generated file
 6:  6f80bd0461 !  7:  a46dca5e0d po/git.pot: don't check in result of "make pot"
    @@ Makefile: endef
      	$(QUIET_GEN)$(gen_pot_header)
      
     -po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO) FORCE
    --	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $(filter-out FORCE,$^) >$@
    +-	$(QUIET_GEN)$(MSGCAT) $(filter-out FORCE,$^) >$@
     +po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
    -+	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
    ++	$(QUIET_GEN)$(MSGCAT) $^ >$@
      
      .PHONY: pot
      pot: po/git.pot
 7:  5cd2c0741d !  8:  2077310e57 Makefile: add "po-update" rule to update po/XX.po
    @@ Makefile: TCLTK_PATH = wish
      GCOV = gcov
      STRIP = strip
     @@ Makefile: XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
    + 	--keyword=gettextln --keyword=eval_gettextln
      XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
      	--keyword=__ --keyword=N__ --keyword="__n:1,2"
    - MSGCAT_FLAGS = --sort-by-file
     +MSGMERGE_FLAGS = --add-location --backup=off --update
    - LOCALIZED_C = $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
    - 	      $(GENERATED_H)
    - LOCALIZED_SH = $(SCRIPT_SH)
    + LOCALIZED_C = $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
    + 	        $(GENERATED_H))
    + LOCALIZED_SH = $(sort $(SCRIPT_SH) git-sh-setup.sh)
     @@ Makefile: po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
      .PHONY: pot
      pot: po/git.pot
 8:  246720695a !  9:  bd810adb20 Makefile: add "po-init" rule to initialize po/XX.po
    @@ Commit message
         translation" that a new l10n contributor must complete before sending
         pull request to the l10n coordinator.
     
    -    By pulling in some parts of the git-po-helper[^1] logic, we add rule
    -    "core-pot" to create this core translation message "po/git-core.pot":
    +    By pulling in some parts of the git-po-helper[^1] logic, we add a new
    +    rule to create this core translation message "po/git-core.pot":
     
    -        make core-pot
    +        make po/git-core.pot
     
         To help new l10n contributors to initialized their "po/XX.pot" from
         "po/git-core.pot", we also add new rules "po-init":
    @@ Makefile: po-update: po/git.pot
     +
     +LOCALIZED_C_CORE_GEN_PO = $(LOCALIZED_C_CORE:%=.build/pot/po/%.po)
     +
    -+.PHONY: core-pot
    -+core-pot: po/git-core.pot
    -+
     +.build/pot/git-core.header: $(LOCALIZED_C_CORE_GEN_PO)
     +	$(call mkdir_p_parent_template)
     +	$(QUIET_GEN)$(gen_pot_header)
     +
     +po/git-core.pot: .build/pot/git-core.header $(LOCALIZED_C_CORE_GEN_PO)
    -+	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
    ++	$(QUIET_GEN)$(MSGCAT) $^ >$@
     +
     +.PHONY: po-init
     +po-init: po/git-core.pot
 9:  131f52ac3a = 10:  38ab065c55 l10n: Document the new l10n workflow
---

Jiang Xin (5):
  Makefile: sort source files before feeding to xgettext
  Makefile: generate "po/git.pot" from stable LOCALIZED_C
  Makefile: remove duplicate and unwanted files in FOUND_SOURCE_FILES
  po/git.pot: this is now a generated file
  Makefile: add "po-update" rule to update po/XX.po

Ævar Arnfjörð Bjarmason (5):
  Makefile: have "make pot" not "reset --hard"
  i18n CI: stop allowing non-ASCII source messages in po/git.pot
  po/git.pot: don't check in result of "make pot"
  Makefile: add "po-init" rule to initialize po/XX.po
  l10n: Document the new l10n workflow

 .gitignore                  |     1 +
 Makefile                    |   153 +-
 builtin/submodule--helper.c |     2 +-
 ci/run-static-analysis.sh   |     2 +
 po/.gitignore               |     2 +
 po/README.md                |   230 +-
 po/git.pot                  | 25151 ----------------------------------
 shared.mak                  |     2 +
 8 files changed, 250 insertions(+), 25293 deletions(-)
 delete mode 100644 po/git.pot

-- 
2.36.0.1.g15c4090757

