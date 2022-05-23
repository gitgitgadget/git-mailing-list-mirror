Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1A4C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 15:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbiEWPVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 11:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237794AbiEWPVh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 11:21:37 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6B22714D
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:33 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q4so13390394plr.11
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sZw15oQEDbVbfqbg0O0/sB9k6BIUwhEswp7ghKgTbhY=;
        b=AtpjCBHMSD3nbRTg0vXix/a67+UqK8q4KzO8dE/DdotJsxvImZmBwmJv+8Xv/F62Zo
         RZgvkEebDUNPaCgo6NU1jG/oRi/YTjKN8tEvfC7MuBH4eYxZd4S6KeCEqWwUOSOMxmKx
         ZFn/ZZGgdYtcaZ8AcgBqIwcNIS0YCS9O0Q8HsJju6NhOKTtDV7IR+EUAZtzJGy2A/DgB
         0sHHNyB12es9S2kMr4p+DPgBTRDA2VekoRNHbeLk7iwGrd4pNRisLkHo5LtlQsF9Ndwi
         syG51aR3y2sM67Ou9NTx5hZI9BuKJndtiMbca7ISoapLCo6UKvQABlGkzT+LNH/uW7lc
         Bm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sZw15oQEDbVbfqbg0O0/sB9k6BIUwhEswp7ghKgTbhY=;
        b=w6LSoczo0mlZqfNDGA43BztkkNpaGdO5yNn46tUVFyOYSbMuZDqVC2h3UD2yjLtDTa
         nRNM6FQ5iRf9KYGFbEsyL/uqMJZ2VSSgJAPvQ57IHJXm/HEnXx5u1VWdomfdDLsrnZzu
         noJMTw4eOo3LQvvYc6O2++tVNp0BbTTYpVML4CX4BRlDBAQtVw72Bbv9u+ZybUrZPcHR
         SVUdGQu6J+Ri79ok9l0sF8furJpca+x4E2h+9jDc1uBTOpurYldrW1fjD+y5cxP6hOa+
         P9vE6ju8eekLK9v3OW9lyhO32K1TBU/47vsVnajj/swj38HjlWSBxEz/CXIGyYVysqkH
         pcDw==
X-Gm-Message-State: AOAM532h7rwgNprXsbovRsyTNwJqb0CVjm5BGY9b2Xc1T/7/TsBpT8xo
        lnB/HhRRX+hNvhbfzXbeHpA=
X-Google-Smtp-Source: ABdhPJwuYnRricUfOgfn/5yWfKOTI9LGBcCKdjbzZuXWpy/dy/T9iyK6kyGk0T2Dqk4wbVZ9WDkPQw==
X-Received: by 2002:a17:902:e353:b0:161:5096:3038 with SMTP id p19-20020a170902e35300b0016150963038mr23643663plc.24.1653319292859;
        Mon, 23 May 2022 08:21:32 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y13-20020a1709027c8d00b0015e8d4eb2cfsm5280287pll.281.2022.05.23.08.21.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 May 2022 08:21:32 -0700 (PDT)
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
Subject: [PATCH v4 0/9] Incremental po/git.pot update and new l10n workflow
Date:   Mon, 23 May 2022 23:21:19 +0800
Message-Id: <20220523152128.26380-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523012531.4505-1-worldhello.net@gmail.com>
References: <20220523012531.4505-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Changes since v3:

1. Remove Junio's s-o-b introduced in v3.
2. Reword patch 1/9, 2/9 and 3/9.
3. Patch 6/9: should remove "po/git.pot" in "clean" instead of "distclean".
4. Patch 8/9: forget to remove "po/git-core.pot".


Range-diff vs v3:

 1:  362cd0cbe1 !  1:  325868b993 Makefile: sort "po/git.pot" by file location
    @@ Metadata
      ## Commit message ##
         Makefile: sort "po/git.pot" by file location
     
    -    We will feed xgettext with more C souce files and in different order in
    -    subsequent commit. To generate a stable "po/git.pot" regardless of the
    -    number and order of input source files, we add a new option
    +    We will feed xgettext with more C source files and in different order
    +    in subsequent commit. To generate a stable "po/git.pot" regardless of
    +    the number and order of input source files, we pass the option
         "--sort-by-file" to xgettext program.
     
    -    With this update, the newly generated "po/git.pot" will has the same
    +    With this update, the newly generated "po/git.pot" will have the same
         entries while in a different order.
     
         With the help of a custom diff driver as shown below,
    @@ Commit message
             git config --global diff.gettext-fmt.textconv \
                 "msgcat --no-location --sort-by-file"
     
    -    and appending a new entry "*.po diff=gettext-fmt" to git attributes,
    +    and appending a new entry "*.pot diff=gettext-fmt" to git attributes,
         we can see that there are no substantial changes in "po/git.pot".
     
         We won't checkin the newly generated "po/git.pot", because we will
         remove it from tree in a later commit.
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Makefile ##
     @@ Makefile: XGETTEXT_FLAGS = \
 2:  096e700171 !  2:  acf2f62e66 Makefile: generate "po/git.pot" from stable LOCALIZED_C
    @@ Metadata
      ## Commit message ##
         Makefile: generate "po/git.pot" from stable LOCALIZED_C
     
    -    When running "make pot" on different platform, we may get a different
    -    message template file "po/git.pot". This is because the "LOCALIZED_C"
    -    variable may have different C source files on different platforms or
    -    different compiler conditions.
    -
    -    We can make a stable "LOCALIZED_C" variable by applying patch snippets
    -    as follows:
    -
    -         ifdef NO_LIBGEN_H
    -             COMPAT_CFLAGS += -DNO_LIBGEN_H
    -             COMPAT_OBJS += compat/basename.o
    -        +else
    -        +    LOCALIZED_C += compat/basename.c
    -         endif
    -
    -    But it is much simpler to use variables "$(FOUND_C_SOURCES)" and
    -    "$(FOUND_C_SOURCES)" to form a stable "LOCALIZED_C". We also add
    -    "$(SCALAR_SOURCES)" files, which are part of C_OBJ but not included in
    -    "$(FOUND_C_SOURCES)" because they are in the "contrib/" directory.
    +    Different users may generate a different message template file
    +    "po/git.pot". This is because the POT file is generated from
    +    "$(LOCALIZED_C)", which is supposed to list all the sources that we
    +    extract the strings to be translated from. But "$(LOCALIZED_C)"
    +    includes "$(C_OBJ)", which only lists the source files used in the
    +    current build for a specific platform and specific compiler
    +    conditions.
    +
    +    Instead of using "$(C_OBJ)", we use "$(FOUND_C_SOURCES)", which lists
    +    all source files we keep track of (or ship in a tarball extract), to
    +    form a stable "LOCALIZED_C". We also add "$(SCALAR_SOURCES)", which
    +    is part of "$(C_OBJ)" but not included in "$(FOUND_C_SOURCES)".
     
         With this update, the newly generated "po/git.pot" will have 30 new
         entries coming from the following C source files:
    @@ Commit message
          * compat/simple-ipc/ipc-win32.c
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Makefile ##
     @@ Makefile: XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 3:  dff3751260 !  3:  775c37bc69 Makefile: have "make pot" not "reset --hard"
    @@ Commit message
         Makefile: have "make pot" not "reset --hard"
     
         Before commit fc0fd5b23b (Makefile: help gettext tools to cope with our
    -    custom PRItime format, 2017-07-20) we'd consider source files as-is
    +    custom PRItime format, 2017-07-20), we'd consider source files as-is
         with gettext, but because we need to understand PRItime in the same way
    -    that gettext itself understands PRIuMAX we'd first check if we had a
    +    that gettext itself understands PRIuMAX, we'd first check if we had a
         clean checkout, then munge all of the processed files in-place with
         "sed", generate "po/git.pot", and then finally "reset --hard" to undo
         our changes.
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## .gitignore ##
     @@
 4:  1b7efb21ae !  4:  55ee049b0a i18n CI: stop allowing non-ASCII source messages in po/git.pot
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Makefile ##
     @@ Makefile: XGETTEXT_FLAGS = \
 5:  8ce274b31f =  5:  69338521aa po/git.pot: this is now a generated file
 6:  4585be63f7 !  6:  6f80bd0461 po/git.pot: don't check in result of "make pot"
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Makefile ##
     @@ Makefile: endef
    @@ Makefile: endef
      
      .PHONY: pot
      pot: po/git.pot
    -@@ Makefile: dist-doc: git$X
    +@@ Makefile: cocciclean:
      
    - distclean: clean
    - 	$(RM) configure
    + clean: profile-clean coverage-clean cocciclean
    + 	$(RM) -r .build
     +	$(RM) po/git.pot
    - 	$(RM) config.log config.status config.cache
    - 	$(RM) config.mak.autogen config.mak.append
    - 	$(RM) -r autom4te.cache
    + 	$(RM) *.res
    + 	$(RM) $(OBJECTS)
    + 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
     
      ## po/.gitignore ##
     @@
 7:  b8f43b520c !  7:  5cd2c0741d Makefile: add "po-update" rule to update po/XX.po
    @@ Commit message
             $ make po-update PO_FILE=po/zh_CN.po
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Makefile ##
     @@ Makefile: TCLTK_PATH = wish
 8:  019633c7a4 !  8:  246720695a Makefile: add "po-init" rule to initialize po/XX.po
    @@ Commit message
         [^1]: https://github.com/git-l10n/git-po-helper/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    -    Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Makefile ##
     @@ Makefile: po-update: po/git.pot
    @@ Makefile: po-update: po/git.pot
      ifdef NO_GETTEXT
      POFILES :=
      MOFILES :=
    +@@ Makefile: cocciclean:
    + 
    + clean: profile-clean coverage-clean cocciclean
    + 	$(RM) -r .build
    +-	$(RM) po/git.pot
    ++	$(RM) po/git.pot po/git-core.pot
    + 	$(RM) *.res
    + 	$(RM) $(OBJECTS)
    + 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
     
      ## po/.gitignore ##
     @@
 9:  334117bf48 !  9:  131f52ac3a l10n: Document the new l10n workflow
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## po/README.md ##
     @@ po/README.md: coordinates our localization effort in the l10 coordinator repository:

---

Jiang Xin (4):
  Makefile: sort "po/git.pot" by file location
  Makefile: generate "po/git.pot" from stable LOCALIZED_C
  po/git.pot: this is now a generated file
  Makefile: add "po-update" rule to update po/XX.po

Ævar Arnfjörð Bjarmason (5):
  Makefile: have "make pot" not "reset --hard"
  i18n CI: stop allowing non-ASCII source messages in po/git.pot
  po/git.pot: don't check in result of "make pot"
  Makefile: add "po-init" rule to initialize po/XX.po
  l10n: Document the new l10n workflow

 .gitignore                  |     1 +
 Makefile                    |   148 +-
 builtin/submodule--helper.c |     2 +-
 ci/run-static-analysis.sh   |     2 +
 po/.gitignore               |     2 +
 po/README.md                |   230 +-
 po/git.pot                  | 25151 ----------------------------------
 shared.mak                  |     2 +
 8 files changed, 250 insertions(+), 25288 deletions(-)
 delete mode 100644 po/git.pot

-- 
2.36.0.1.g15c4090757

