Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA342C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 01:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351088AbiEWBZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 May 2022 21:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349652AbiEWBZl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 May 2022 21:25:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652AF37A09
        for <git@vger.kernel.org>; Sun, 22 May 2022 18:25:38 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h9so4208127pgl.4
        for <git@vger.kernel.org>; Sun, 22 May 2022 18:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j3CC5yHgf9t2/0izE2KVWsNRAE2q8VfryxsS1NcD33s=;
        b=H7sGwwroaL+lpBHPyoEX3LQmUZwNnOjgBxS/gIFD0O6fdmr9bNWzUVupiM2XXFaT40
         8zJKk18fIv5Uo5GA04eRxJM/pyuViJAg0JmSPjc+XnEnmB+DqWasfxR1imV6Oi0QPSQV
         RPZzKtsqBN7fhhya8sjU/sJx69TbnM6ZXJBsr/eqcDWZpLRUuO3UHc0tQcZ5bqc4JtLl
         S7GhkQqGCLRV5ALMxxxiwz8IuYFwqmAm/DTRe50MQaW4f3MfrvrM3dq9RhdRsUV+3K0D
         IGy7tYhuQ4OwPUUL/I2E4i/UF1H1mPZf8rD3kqUI0ZyHjyZooehUwpMj3tkOXIVmEMV1
         zCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j3CC5yHgf9t2/0izE2KVWsNRAE2q8VfryxsS1NcD33s=;
        b=07Dcg1t1kQuLBqMfhNUs64tmksj0YJv583N1Ic1VjAxsa7GAOZv+9HHHJvt9a4EuX5
         VnVOnsjrIy8blBddr74SYsg+iBNYyHUsJmG3Tr01Xsf3XzyVJBTRy2Nik1SOAoamvL9/
         5CPiC/AMedGF3cRbhR0ilva8pz9l1qkEvcQA4G4SPDPlgzxt/VmMva/ugepcbpGPpITt
         BziCgZ9+mbUzvtOZ4EnC9vKenqe267WClzJZZW9YCA7mz6148QbdmvFZnzCyc5ldtmv2
         LkYvCI/EBComO3IMVh3cTErdK9Fn++bn96XnI6GoOPV6wy3hqr6FDZM2uXXAu01A5g6t
         sWlA==
X-Gm-Message-State: AOAM533SW2jSxouYcCJZjDD4sAqutMZHiIIgwNjgTTo98l5BOiHT/iXx
        bKbQ9iRliBRSsX7v7oQdXNM=
X-Google-Smtp-Source: ABdhPJwUD0QhOUUGY9hT8LFNGy2Sk5XOGNEzEhhqr/AZwC4t2icdf6kPhRfpNIQ0tApYzXBXfRk/GQ==
X-Received: by 2002:a05:6a00:1807:b0:518:ad18:e514 with SMTP id y7-20020a056a00180700b00518ad18e514mr962097pfa.70.1653269137522;
        Sun, 22 May 2022 18:25:37 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7985a000000b00518142f8c37sm6027566pfq.171.2022.05.22.18.25.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2022 18:25:36 -0700 (PDT)
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
Subject: [PATCH v3 0/9] Incremental po/git.pot update and new l10n workflow
Date:   Mon, 23 May 2022 09:25:22 +0800
Message-Id: <20220523012531.4505-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220519081548.3380-1-worldhello.net@gmail.com>
References: <20220519081548.3380-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

A workflow change for translators are being proposed.

Changes since v2:

 1. Patch 1/9: reword.
 2. Patch 2/9: reword.
 3. Patch 3/9: reword, and add "FORCE" to prerequisites of "po/git.pot".
 4. Patch 6/9: remove "FORCE" from prerequisites of "po/git.pot".
 5. Patch 8/9: reword, and reuse "$(gen_pot_header)" to prepare pot
               header for "po/git-core.pot".
 6. Patch 9/9: various updates on po/README.md.


Range-diff vs v2:

 1:  c45f34f233 !  1:  362cd0cbe1 Makefile: sort "po/git.pot" by file location
    @@ Metadata
      ## Commit message ##
         Makefile: sort "po/git.pot" by file location
     
    -    Before feeding xgettext with more C souce files which may be ignored
    -    by various compiler conditions, add new option "--sort-by-file" to
    -    xgettext program to create stable message template file "po/git.pot".
    +    We will feed xgettext with more C souce files and in different order in
    +    subsequent commit. To generate a stable "po/git.pot" regardless of the
    +    number and order of input source files, we add a new option
    +    "--sort-by-file" to xgettext program.
     
         With this update, the newly generated "po/git.pot" will has the same
    -    entries while in a different order. We won't checkin the newly generated
    -    "po/git.pot", because we will remove it from tree in a later commit.
    +    entries while in a different order.
    +
    +    With the help of a custom diff driver as shown below,
    +
    +        git config --global diff.gettext-fmt.textconv \
    +            "msgcat --no-location --sort-by-file"
    +
    +    and appending a new entry "*.po diff=gettext-fmt" to git attributes,
    +    we can see that there are no substantial changes in "po/git.pot".
    +
    +    We won't checkin the newly generated "po/git.pot", because we will
    +    remove it from tree in a later commit.
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
 2:  7b6e4d6b59 !  2:  096e700171 Makefile: generate "po/git.pot" from stable LOCALIZED_C
    @@ Commit message
              endif
     
         But it is much simpler to use variables "$(FOUND_C_SOURCES)" and
    -    "$(FOUND_C_SOURCES)" to form a stable "LOCALIZED_C".
    +    "$(FOUND_C_SOURCES)" to form a stable "LOCALIZED_C". We also add
    +    "$(SCALAR_SOURCES)" files, which are part of C_OBJ but not included in
    +    "$(FOUND_C_SOURCES)" because they are in the "contrib/" directory.
     
         With this update, the newly generated "po/git.pot" will have 30 new
         entries coming from the following C source files:
    @@ Makefile: XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
      XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
      	--keyword=__ --keyword=N__ --keyword="__n:1,2"
     -LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
    -+LOCALIZED_C = $(FOUND_C_SOURCES) $(SCALAR_SOURCES) \
    -+	      $(FOUND_H_SOURCES) $(GENERATED_H)
    ++LOCALIZED_C = $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
    ++	      $(GENERATED_H)
      LOCALIZED_SH = $(SCRIPT_SH)
      LOCALIZED_SH += git-sh-setup.sh
      LOCALIZED_PERL = $(SCRIPT_PERL)
 3:  868a631c2f !  3:  dff3751260 Makefile: have "make pot" not "reset --hard"
    @@ Commit message
         That out of the way, the main logic change here is getting rid of the
         "reset --hard":
     
    -    We'll generate intermediate .build/pot/po/%.po files from %, which is
    -    handy to see at a glance what strings (if any) in a given file are
    +    We'll generate intermediate ".build/pot/po/%.po" files from "%", which
    +    is handy to see at a glance what strings (if any) in a given file are
         marked for translation:
     
                 $ make .build/pot/po/pretty.c.po
    @@ Commit message
                 $
     
         For these C source files which contain the PRItime macros, we will
    -    create temporary munged *.c files in a tree in ".build/pot/po"
    +    create temporary munged "*.c" files in a tree in ".build/pot/po"
         corresponding to our source tree, and have "xgettext" consider those.
         The rule needs to be careful to "(cd .build/pot/po && ...)", because
         otherwise the comments in the po/git.pot file wouldn't refer to the
         correct source locations (they'd be prefixed with ".build/pot/po").
    +    These temporary munged "*.c” files will be removed immediately after
    +    the corresponding po files are generated, because some development tools
    +    cannot ignore the duplicate source files in the ".build" directory
    +    according to the ".gitignore" file, and that may cause trouble.
     
    -    This changes the output of the generated po/git.pot file in one minor
    +    The output of the generated po/git.pot file is changed in one minor
         way: Because we're using msgcat(1) instead of xgettext(1) to
         concatenate the output we'll now disambiguate where "TRANSLATORS"
         comments come from, in cases where a message is the same in N files,
    @@ Commit message
         understandable, as msgcat(1) is better at handling these edge cases
         than xgettext(1)'s previously used "--join-existing" flag.
     
    -    While we could rename the "pot" snippets without the ".po" extention
    -    to use more intuitive filenames in the comments, but that will
    -    confuse the IDE with lots of invalid C or perl source files in
    +    But filenames in the above disambiguation lines of extracted-comments
    +    have an extra ".po" extension compared to the filenames at the file
    +    locations. While we could rename the intermediate ".build/pot/po/%.po"
    +    files without the ".po" extension to use more intuitive filenames in
    +    the disambiguation lines of extracted-comments, but that will confuse
    +    developer tools with lots of invalid C or other source files in
         ".build/pot/po" directory.
     
         The addition of "--omit-header" option for xgettext makes the "pot"
    -    snippets in ".build/pot/po/*.po" smaller. For the pot header of
    -    "po/git.pot", we use xgettext to generate a "pot" header file
    -    ".build/pot/git.header" from an empty file at runtime, and use this
    +    snippets in ".build/pot/po/*.po" smaller. But as we'll see in a
    +    subsequent commit this header behavior has been hiding an
    +    encoding-related bug from us, so let's carry it forward instead of
    +    re-generating it with xgettext(1).
    +
    +    The "po/git.pot" file should have a header entry, because a proper
    +    header entry will increase the speed of creating a new po file using
    +    msginit and set a proper "POT-Creation-Date:" field in the header
    +    entry of a "po/XX.po" file. We use xgettext to generate a separate
    +    header file at ".build/pot/git.header" from "/dev/null", and use this
         header to assemble "po/git.pot".
     
    -    But as we'll see in a subsequent commit this header behavior has been
    -    hiding an encoding-related bug from us, so let's carry it forward
    -    instead of re-generating it with xgettext(1).
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    @@ Makefile: XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
      XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
      	--keyword=__ --keyword=N__ --keyword="__n:1,2"
     +MSGCAT_FLAGS = --sort-by-file
    - LOCALIZED_C = $(FOUND_C_SOURCES) $(SCALAR_SOURCES) \
    - 	      $(FOUND_H_SOURCES) $(GENERATED_H)
    + LOCALIZED_C = $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
    + 	      $(GENERATED_H)
      LOCALIZED_SH = $(SCRIPT_SH)
     @@ Makefile: LOCALIZED_SH += t/t0200/test.sh
      LOCALIZED_PERL += t/t0200/test.perl
    @@ Makefile: LOCALIZED_SH += t/t0200/test.sh
     +	$(call mkdir_p_parent_template)
     +	$(QUIET_XGETTEXT)$(XGETTEXT) --omit-header \
     +		-o$@ $(XGETTEXT_FLAGS_PERL) $<
    ++
    ++define gen_pot_header
    ++$(XGETTEXT) $(XGETTEXT_FLAGS_C) \
    ++	-o - /dev/null | \
    ++sed -e 's|charset=CHARSET|charset=UTF-8|' \
    ++    -e 's|\(Last-Translator: \)FULL NAME <.*>|\1make by the Makefile|' \
    ++    -e 's|\(Language-Team: \)LANGUAGE <.*>|\1Git Mailing List <git@vger.kernel.org>|' \
    ++    >$@ && \
    ++echo '"Plural-Forms: nplurals=INTEGER; plural=EXPRESSION;\\n"' >>$@
    ++endef
      
     -	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
     -	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_SH) \
    @@ Makefile: LOCALIZED_SH += t/t0200/test.sh
     -		$(LOCALIZED_PERL)
     +.build/pot/git.header: $(LOCALIZED_ALL_GEN_PO)
     +	$(call mkdir_p_parent_template)
    -+	$(QUIET_XGETTEXT)$(XGETTEXT) $(XGETTEXT_FLAGS_C) \
    -+		-o - /dev/null | \
    -+	sed -e 's|charset=CHARSET|charset=UTF-8|g' >$@ && \
    -+	echo '"Plural-Forms: nplurals=INTEGER; plural=EXPRESSION;\\n"' >>$@
    ++	$(QUIET_GEN)$(gen_pot_header)
      
     -	# Reverting the munged source, leaving only the updated $@
     -	git reset --hard
     -	mv $@+ $@
    -+po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
    -+	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
    ++po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO) FORCE
    ++	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $(filter-out FORCE,$^) >$@
      
      .PHONY: pot
      pot: po/git.pot
 4:  31aa6ed373 !  4:  1b7efb21ae i18n CI: stop allowing non-ASCII source messages in po/git.pot
    @@ Makefile: XGETTEXT_FLAGS = \
      XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
      	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
      XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
    -@@ Makefile: po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
    +@@ Makefile: po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO) FORCE
      .PHONY: pot
      pot: po/git.pot
      
 5:  a9e4840571 !  5:  8ce274b31f po/git.pot: this is now a generated file
    @@ Commit message
     
         We no longer keep track of the contents of this file.
     
    +    Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    +
      ## po/git.pot (deleted) ##
     @@
     -# SOME DESCRIPTIVE TITLE.
 6:  1f59007114 !  6:  4585be63f7 po/git.pot: don't check in result of "make pot"
    @@ Commit message
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Makefile ##
    +@@ Makefile: endef
    + 	$(call mkdir_p_parent_template)
    + 	$(QUIET_GEN)$(gen_pot_header)
    + 
    +-po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO) FORCE
    +-	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $(filter-out FORCE,$^) >$@
    ++po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
    ++	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
    + 
    + .PHONY: pot
    + pot: po/git.pot
     @@ Makefile: dist-doc: git$X
      
      distclean: clean
 7:  cb31a4001e !  7:  b8f43b520c Makefile: add "po-update" rule to update po/XX.po
    @@ Makefile: XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
      	--keyword=__ --keyword=N__ --keyword="__n:1,2"
      MSGCAT_FLAGS = --sort-by-file
     +MSGMERGE_FLAGS = --add-location --backup=off --update
    - LOCALIZED_C = $(FOUND_C_SOURCES) $(SCALAR_SOURCES) \
    - 	      $(FOUND_H_SOURCES) $(GENERATED_H)
    + LOCALIZED_C = $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
    + 	      $(GENERATED_H)
      LOCALIZED_SH = $(SCRIPT_SH)
     @@ Makefile: po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
      .PHONY: pot
 8:  f4c58f6184 !  8:  019633c7a4 Makefile: add "po-init" rule to initialize po/XX.po
    @@ Commit message
         To help new l10n contributors to initialized their "po/XX.pot" from
         "po/git-core.pot", we also add new rules "po-init":
     
    -        make po-init POT_FILE=po/XX.po
    +        make po-init PO_FILE=po/XX.po
     
         [^1]: https://github.com/git-l10n/git-po-helper/
     
    @@ Makefile: po-update: po/git.pot
     +
     +.build/pot/git-core.header: $(LOCALIZED_C_CORE_GEN_PO)
     +	$(call mkdir_p_parent_template)
    -+	$(QUIET_XGETTEXT)$(XGETTEXT) $(XGETTEXT_FLAGS_C) \
    -+		-o - /dev/null | \
    -+	sed -e 's|charset=CHARSET|charset=UTF-8|g' >$@ && \
    -+	echo '"Plural-Forms: nplurals=INTEGER; plural=EXPRESSION;\\n"' >>$@
    ++	$(QUIET_GEN)$(gen_pot_header)
     +
     +po/git-core.pot: .build/pot/git-core.header $(LOCALIZED_C_CORE_GEN_PO)
     +	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
 9:  809128ce21 !  9:  334117bf48 l10n: Document the new l10n workflow
    @@ Commit message
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## po/README.md ##
    -@@ po/README.md: for a new language translation. Because there are more than 5000 messages
    - in the template message file "po/git.pot" that need to be translated,
    - this is not a piece of cake for the contributor for a new language.
    +@@ po/README.md: coordinates our localization effort in the l10 coordinator repository:
    + 
    +     https://github.com/git-l10n/git-po/
    + 
    +-The two character language translation codes are defined by ISO\_639-1, as
    +-stated in the gettext(1) full manual, appendix A.1, Usual Language Codes.
    ++We will use XX as an alias to refer to the language translation code in
    ++the following paragraphs, for example we use "po/XX.po" to refer to the
    ++translation file for a specific language. But this doesn't mean that
    ++the language code has only two letters. The language code can be in one
    ++of two forms: "ll" or "ll\_CC". Here "ll" is the ISO 639 two-letter
    ++language code and "CC" is the ISO 3166 two-letter code for country names
    ++and subdivisions. For example: "de" for German language code, "zh\_CN"
    ++for Simplified Chinese language code.
    + 
    + 
    + ## Contributing to an existing translation
    +@@ po/README.md: language, so that the l10n coordinator only needs to interact with one
    + person per language.
    + 
    + 
    +-## Core translation
    ++## Translation Process Flow
    + 
    +-The core translation is the smallest set of work that must be completed
    +-for a new language translation. Because there are more than 5000 messages
    +-in the template message file "po/git.pot" that need to be translated,
    +-this is not a piece of cake for the contributor for a new language.
    ++The overall data-flow looks like this:
      
     -The core template message file which contains a small set of messages
     -will be generated in "po-core/core.pot" automatically by running a helper
     -program named "git-po-helper" (described later).
    -+The "core" set of messages can be generated at "po/git-core.pot" by
    -+running:
    ++    +-------------------+             +------------------+
    ++    | Git source code   | ----(2)---> | L10n coordinator |
    ++    | repository        | <---(5)---- | repository       |
    ++    +-------------------+             +------------------+
    ++                    |                     |    ^
    ++                   (1)                   (3)  (4)
    ++                    V                     v    |
    ++               +----------------------------------+
    ++               |        Language Team XX          |
    ++               +----------------------------------+
      
    - ```shell
    +-```shell
     -git-po-helper init --core XX.po
    -+make core-pot
    - ```
    +-```
    ++- Translatable strings are marked in the source file.
    ++- Language teams can start translation iterations at any time, even
    ++  before the l10n window opens:
      
     -After translating the generated "po-core/XX.po", you can merge it to
     -"po/XX.po" using the following commands:
    --
    ++  + Pull from the master branch of the source (1)
    ++  + Update the message file by running "make po-update PO\_FILE=po/XX.po"
    ++  + Translate the message file "po/XX.po"
    + 
     -```shell
     -msgcat po-core/XX.po po/XX.po -s -o /tmp/XX.po
     -mv /tmp/XX.po po/XX.po
     -git-po-helper update XX.po
     -```
    --
    ++- The L10n coordinator pulls from source and announces the l10n window
    ++  open (2)
    ++- Language team pulls from the l10n coordinator, starts another
    ++  translation iteration against the l10n coordinator's tree (3)
    + 
     -Edit "po/XX.po" by hand to fix "fuzzy" messages, which may have misplaced
     -translated messages and duplicate messages.
    -+And then proceeding with the rest of these instructions on the new
    -+generated "po/git-core.pot" file.
    ++  + Run "git pull --rebase" from the l10n coordinator
    ++  + Update the message file by running "make po-update PO\_FILE=po/XX.po"
    ++  + Translate the message file "po/XX.po"
    ++  + Squash trivial l10n git commits using "git rebase -i"
      
    ++- Language team sends pull request to the l10n coordinator (4)
    ++- L10n coordinator checks and merges
    ++- L10n coordinator asks the result to be pulled (5).
      
    - ## Translation Process Flow
    +-## Translation Process Flow
      
    - The overall data-flow looks like this:
    +-The overall data-flow looks like this:
    ++## Dynamically generated POT files
      
     -    +-------------------+            +------------------+
     -    | Git source code   | ---(1)---> | L10n coordinator |
    @@ po/README.md: for a new language translation. Because there are more than 5000 m
     -                                     +------------------+
     -                                     | Language Team XX |
     -                                     +------------------+
    -+    +-------------------+             +------------------+
    -+    | Git source code   | ----(2)---> | L10n coordinator |
    -+    | repository        | <---(5)---- | repository       |
    -+    +-------------------+             +------------------+
    -+                    |                     |    ^
    -+                   (1)                   (3)  (4)
    -+                    V                     v    |
    -+               +----------------------------------+
    -+               |        Language Team XX          |
    -+               +----------------------------------+
    ++POT files are templates for l10n contributors to create or update their
    ++translation files. We used to have the "po/git.pot" file which was
    ++generated by the l10n coordinator, but this file had been removed from
    ++the tree.
      
    - - Translatable strings are marked in the source file.
    +-- Translatable strings are marked in the source file.
     -- L10n coordinator pulls from the source (1)
     -- L10n coordinator updates the message template "po/git.pot"
     -- Language team pulls from L10n coordinator (2)
     -- Language team updates the message file "po/XX.po"
     -- L10n coordinator pulls from Language team (3)
     -- L10n coordinator asks the result to be pulled (4).
    -+- Language teams can start translation iterations at any time, even
    -+  before the l10n window opens:
    -+
    -+  + Pull from the source (1)
    -+  + Update the message file by running "make po-update PO\_FILE=po/XX.po"
    -+  + Translate the message file "po/XX.po"
    ++The two POT files "po/git.pot" and "po/git-core.pot" can be created
    ++dynamically when necessary.
      
    -+- The L10n coordinator pulls from source and announces the l10n window
    -+  open (2)
    -+- Language team pulls from the l10n coordinator, starts another
    -+  translation iteration against the l10n coordinator's tree (3)
    ++L10n contributors use "po/git.pot" to prepare translations for their
    ++languages, but they are not expected to modify it. The "po/git.pot" file
    ++can be generated manually with the following command:
      
     -## Maintaining the "po/git.pot" file
    -+  + Run "git pull --rebase" from the l10n coordinator
    -+  + Update the message file by running "make po-update PO\_FILE=po/XX.po"
    -+  + Translate the message file "po/XX.po"
    -+  + Squash trivial l10n git commits using "git rebase -i"
    ++```shell
    ++make po/git.pot
    ++```
      
     -(This is done by the l10n coordinator).
    -+- Language team sends pull request to the l10n coordinator (4)
    -+- L10n coordinator checks and merges
    -+- L10n coordinator asks the result to be pulled (5).
    ++The "po/git-core.pot" file is the template for core translations. A core
    ++translation is the minimum set of work necessary to complete a
    ++translation of a new language. Since there are more than 5000 messages
    ++in the full set of template message file "po/git.pot" that need to be
    ++translated, this is not a piece of cake for new language contributors.
      
     -The "po/git.pot" file contains a message catalog extracted from Git's
     -sources. The l10n coordinator maintains it by adding new translations with
    @@ po/README.md: for a new language translation. Because there are more than 5000 m
     -expected to pull from the main git repository at strategic point in
     -history (e.g. when a major release and release candidates are tagged),
     -and then run "make pot" at the top-level directory.
    ++The "core" template file "po/git-core.pot" can be generated manually
    ++by running:
      
     -Language contributors use this file to prepare translations for their
     -language, but they are not expected to modify it.
    -+## Creating the "po/git.pot" file
    -+
    -+The "po/git.pot" file, once generated by the the l10n coordinator had
    -+been removed from the tree. L10n contributors can generated it at
    -+runtime using command:
    -+
     +```shell
    -+make pot
    ++make po/git-core.pot
     +```
    -+
    -+Then language contributors use this file to prepare translations for
    -+their language, but they are not expected to modify it.
      
      
      ## Initializing a "XX.po" file
    @@ po/README.md: If your language XX does not have translated message file "po/XX.p
      
      ```shell
     -msginit --locale=XX
    --```
    --
    ++make po-init PO_FILE=po/XX.po
    + ```
    + 
     -in the "po/" directory, where XX is the locale, e.g. "de", "is", "pt\_BR",
     -"zh\_CN", etc.
     -
    @@ -1,6 +1,6 @@
     -+# Copyright (C) 2010 Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     -+# This file is distributed under the same license as the Git package.
     - # Ævar Arnfjörð Bjarmason <avarab@gmail.com>, 2010.
    -+make po-init PO_FILE=po/XX.po
    - ```
    - 
    +-```
    +-
     -And change references to PACKAGE VERSION in the PO Header Entry to
     -just "Git":
    -+Where XX is the locale, e.g. "de", "is", "pt\_BR", "zh\_CN", etc.
    ++where XX is the locale, e.g. "de", "is", "pt\_BR", "zh\_CN", etc.
      
     -```shell
     -perl -pi -e 's/(?<="Project-Id-Version: )PACKAGE VERSION/Git/' XX.po
    @@ po/README.md: and ask the l10n coordinator to pull from you.
      
     -Once you are done testing the translation (see below), commit the result
     -and ask the l10n coordinator to pull from you.
    -+- Call "make pot" at runtime to generate new "po/git.pot" file
    ++- Call "make po/git.pot" to generate new "po/git.pot" file
     +- Call "msgmerge --add-location --backup=off -U po/XX.po po/git.pot"
     +  to update your "po/XX.po"
     +- The "--add-location" option for msgmerge will add location lines,
    -+  and these location lines will help translation tools to location
    ++  and these location lines will help translation tools to locate
     +  translation context easily.
     +
     +Once you are done testing the translation (see below), it's better
    @@ po/README.md: and ask the l10n coordinator to pull from you.
     +To save a location-less "po/XX.po" automatically in repository, you
     +can:
     +
    -+- Define new attribute for "po/XX.po" by adding new line in
    -+  ".git/info/attributes":
    ++First define a new attribute for "po/XX.po" by appending the following
    ++line in ".git/info/attributes":
     +
    -+        /po/XX.po filter=gettext-no-location
    ++```
    ++/po/XX.po filter=gettext-no-location
    ++```
     +
    -+- Define driver for "gettext-no-location" filter:
    ++Then define the driver for the "gettext-no-location" clean filter to
    ++strip out both filenames and locations from the contents as follows:
     +
    -+        $ git config --global filter.gettext-no-location.clean \
    -+              "msgcat --no-location -"
    ++```shell
    ++git config --global filter.gettext-no-location.clean \
    ++           "msgcat --no-location -"
    ++```
    ++
    ++For users who have gettext version 0.20 or higher, it is also possible
    ++to define a clean filter to preserve filenames but not locations:
    ++
    ++```shell
    ++git config --global filter.gettext-no-location.clean \
    ++           "msgcat --add-location=file -"
    ++```
     +
     +You're now ready to ask the l10n coordinator to pull from you.
      

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

