Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C033C433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 13:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbiECN1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 09:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbiECN1m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 09:27:42 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A5837010
        for <git@vger.kernel.org>; Tue,  3 May 2022 06:24:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i24so14678103pfa.7
        for <git@vger.kernel.org>; Tue, 03 May 2022 06:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dhjIhsVTEcCSAOf6tNhC4IC//WJawsREaiNVwW/2u9Q=;
        b=YlCebtF2aIPf/lsxaQVBBKW0p3+MFmUqgC8vYzl5/REvcLLU+lNABKVwoPe7FqRSdA
         di8ShfIcVH2zBtqxBg5P8Fz040P28aZ1nwZBEHuD3W+372pPJlHYCGayjdqxZl3DWX9n
         X6DaQ8R7njgPKks/KVmy6up7RihrUGcSRMepAdxWeUQXQuWF77FCY5DT5/G1+hYQbjn+
         MKp8Jid8Uz75wHDv0jaj2MPlkh5JK15MQie3I2KVPo/ik83Fko2okOrbZcPm6LcHfwXQ
         Z1aQ+ukfmFcVPVp+4jfjY9Jb1Y7du7m8RquyAWtvwPXU7yzGbnYPfTEaM3n2RXVi6mw3
         pjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dhjIhsVTEcCSAOf6tNhC4IC//WJawsREaiNVwW/2u9Q=;
        b=JbACEXWJW/gIeRvmQ+JpLtUz8XUQ/UBm5QkocQYFVhd7wAm0rWr4PgPpJGxyN6kdYg
         zuNdJke2Rmmr4DEaPYVZLbR7S14SHNZLTXL4T/ky1pSzVLYRnhf1pLVO4Z08c+DCJFn9
         jB638qZupvqjX5z3HDrIG/q60dDErDcnnG3+tAA69YEB/m3AzFGXJpRyRRh5PElOdlq5
         8fRED5tnw7nVz6jWA6hzSSi9k4VufgsOqH9wMxdN1jY5wXUHDMQgSi1oig3W8zVl8tx7
         SM2gAPtOIUjX1ZeQJB7cBwei/RIteZ/+RHa3zO6pSTAiOqIP4e3lnr2r90INprm9fn3m
         ouiw==
X-Gm-Message-State: AOAM531isOirQDEjh0B7zOfCnK3mSSsHpNqD8ADcAnk7wnm1jgYepHDj
        YXGTSNVirZlMzp9rV39s974=
X-Google-Smtp-Source: ABdhPJwlbGWOWomuzuLHXt/HnoQepFhEre2mAXfB8hBCFEeo9KqUxCQ+A2hlaPPj6gBfBlZEbz5cGg==
X-Received: by 2002:a05:6a00:2187:b0:50c:ef4d:ef3b with SMTP id h7-20020a056a00218700b0050cef4def3bmr15791860pfi.83.1651584246406;
        Tue, 03 May 2022 06:24:06 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78008000000b0050dc76281b3sm6484950pfi.141.2022.05.03.06.24.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2022 06:24:05 -0700 (PDT)
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
Subject: [PATCH 0/9] Incremental po/git.pot update and new l10n workflow
Date:   Tue,  3 May 2022 21:23:45 +0800
Message-Id: <20220503132354.9567-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Ævar and I started discussing this topic (incremental po/git.pot update
and new l10n workflow) on a GitHub issue[^1] a month ago. There are
several improvements to the l10n workflow:

* Variable "LOCALIZED_C" is not stable, that cause the "po/git.pot" file
  generated by different user may have different number of entries.
  This issues is fixed in patch 2/9.

* Generate "po/git.pot" in an incremental way, so we do not need to munge
  source files in-place, do not need a clean checkout, and do not need
  "reset --hard". See patch 3/9.

* Remove file "po/git.pot" from tree. It can be generated at runtime.
  See patch 5/9, 6/9.

* L10n contributors can update theire "po/XX.pot" using:
  "make po-update PO_FILE=po/XX.po". See patch 7/9.

* L10n contributors for new language can initialize "po/XX.pot" using:
  "make po-init PO_FILE=po/XX.po". See patch 8/9.

* L10n contributors can start translations at any time, even before the
  l10n announcing l10n window open. We must have a new l10n workflow,
  see patch 9/9.

@Ævar, range-diff between your worktree[^2] and this.

[^1]: https://github.com/git-l10n/git-po-helper/issues/12
[^2]: https://github.com/avar/git/commits/avar/Makefile-incremental-po-git-pot-rule

## range-diff avar/Makefile-incremental-po-git-pot-rule...HEAD

 1:  6f3483eb63 <  -:  ---------- po/git: regenerate with "make pot"
 -:  ---------- >  1:  88470f57b8 Makefile: sort "po/git.pot" by file location
 -:  ---------- >  2:  1f6ef16028 Makefile: generate "po/git.pot" from stable LOCALIZED_C
 2:  6cf9c1f702 !  3:  a991919bfb Makefile: have "make pot" not "reset --hard"
    @@ Metadata
      ## Commit message ##
         Makefile: have "make pot" not "reset --hard"
     
    -    Change "make pot" to work on copies of the working tree files in a new
    -    ".build/pot/" directory, instead of altering them in place and doing a
    -    "reset --hard" afterwards.
    -
    -    This both speeds up the "make pot" target on an initial run, and makes
    -    it *much* faster for incremental runs, and will allow us to implement
    -    related targets in subsequent commits.
    +    Before commit fc0fd5b23b (Makefile: help gettext tools to cope with our
    +    custom PRItime format, 2017-07-20) we'd consider source files as-is
    +    with gettext, but because we need to understand PRItime in the same way
    +    that gettext itself understands PRIuMAX we'd first check if we had a
    +    clean checkout, then munge all of the processed files in-place with
    +    "sed", generate "po/git.pot", and then finally "reset --hard" to undo
    +    our changes.
    +
    +    By generating "pot" snippets in ".build/pot/po" for each source file
    +    and rewriting certain source files with PRItime macros to temporary
    +    files in ".build/pot/po", we can avoid running "make pot" by altering
    +    files in place and doing a "reset --hard" afterwards.
    +
    +    This speed of "make pot" is slower than before on an initial run,
    +    because we run "xgettext" many times (once per source file), but it
    +    can be boosted by parallelization. It is *much* faster for incremental
    +    runs, and will allow us to implement related targets in subsequent
    +    commits.
     
         When the "pot" target was originally added in cd5513a7168 (i18n:
         Makefile: "pot" target to extract messages marked for translation,
    @@ Commit message
         target, 2014-08-22) when it was made to depend on "FORCE". I.e. the
         Makefile's dependency resolution inherently can't handle incremental
         building when the target file may be updated by git (or something else
    -    external to "make").
    -
    -    So we still need a FORCE on po/git.pot, but now we'll have that target
    -    copy ".build/pot/git.pot" to "po/git.pot", and the former doesn't need
    -    FORCE.
    -
    -    I think 1f31963e921 was confused in the rationale for adding "FORCE"
    -    though, it's needed for the reasons noted above, but it's got nothing
    -    to do with how we do C compilation or find headers, which it suggest
    -    is the case. It was also made as a preparatory change for
    -    d85b0dff729 (Makefile: use `find` to determine static header
    -    dependencies, 2014-08-25).
    -
    -    Unlike the compiler, when we generate the "pot "file we won't recurse
    -    from one header file to another, we only consider the specific targets
    -    we're given, so if we miss a bar.h included via foo.h $(LOCALIZED_C)
    -    the FORCE won't help us.
    +    external to "make"). But this case no longer applies, so FORCE is no
    +    longer needed.
     
         That out of the way, the main logic change here is getting rid of the
         "reset --hard":
     
    -    Before fc0fd5b23bc we'd consider source files as-is with gettext, but
    -    because we need to understand PRItime in the same way that gettext
    -    itself understands PRIuMAX we'd first check if we had a clean
    -    checkout, then munge all of the processed files in-place with "sed",
    -    generate "po/git.pot, and then finally "reset --hard" to undo our
    -    changes.
    -
    -    We didn't need to do this for the *.perl and *.sh files, so let's
    -    skip that and only do it for the *.[ch] files.
    -
    -    Let's then create these munged *.[ch] files in a tree in .build/pot/"
    -    corresponding to our source tree, and have "xgettext" consider
    -    those. The rule needs to be careful to "(cd .build/pot && ...)",
    -    because otherwise the comments in the po/git.pot file wouldn't refer
    -    to the correct source locations (they'd be prefixed with
    -    ".build/git/").
    -
    -    We'll then generate intermediate .build/pot/po/% files from %, which
    -    is handy to see at a glance what strings (if any) in a given file are
    +    We'll generate intermediate .build/pot/po/%.po files from %, which is
    +    handy to see at a glance what strings (if any) in a given file are
         marked for translation:
     
    -            $ make .build/pot/po/pretty.c
    +            $ make .build/pot/po/pretty.c.po
                 [...]
    -            $ cat .build/pot/po/pretty.c
    +            $ cat .build/pot/po/pretty.c.po
                 #: pretty.c:1051
                 msgid "unable to parse --pretty format"
                 msgstr ""
                 $
     
    +    For these C source files which contain the PRItime macros, we will
    +    create temporary munged *.c files in a tree in ".build/pot/po"
    +    corresponding to our source tree, and have "xgettext" consider those.
    +    The rule needs to be careful to "(cd .build/pot/po && ...)", because
    +    otherwise the comments in the po/git.pot file wouldn't refer to the
    +    correct source locations (they'd be prefixed with ".build/pot/po").
    +
         This changes the output of the generated po/git.pot file in one minor
         way: Because we're using msgcat(1) instead of xgettext(1) to
         concatenate the output we'll now disambiguate where "TRANSLATORS"
    @@ Commit message
         different. E.g. for the "Your edited hunk[...]" message we'll now
         apply this change (comment content elided):
     
    -            +#. #-#-#-#-#  add-patch.c  #-#-#-#-#
    +            +#. #-#-#-#-#  add-patch.c.po  #-#-#-#-#
                  #. TRANSLATORS: do not translate [y/n]
                 [...]
    -            +#. #-#-#-#-#  git-add--interactive.perl  #-#-#-#-#
    +            +#. #-#-#-#-#  git-add--interactive.perl.po  #-#-#-#-#
                  #. TRANSLATORS: do not translate [y/n]
                 [...]
                  #: add-patch.c:1253 git-add--interactive.perl:1244
    @@ Commit message
                  "Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
                  msgstr ""
     
    -    There are three such changes, and they all make the context more
    +    There are six such changes, and they all make the context more
         understandable, as msgcat(1) is better at handling these edge cases
         than xgettext(1)'s previously used "--join-existing" flag.
     
    -    The removal of the "--msgid-bugs-address" here and the addition of
    -    "--omit-header" and ".build/pot/pot.header" is because we'll now
    -    always carry forward the existing po/git.pot header.
    +    While we could rename the "pot" snippets without the ".po" extention
    +    to use more intuitive filenames in the comments, but that will
    +    confuse the IDE with lots of invalid C or perl source files in
    +    ".build/pot/po" directory.
     
    -    We'd previously generate the header with xgettext(1), but now we'll be
    -    carrying forward whatever header we find in po/git.pot. Right now this
    -    doesn't matter, we'll even update the timestamp in the header as
    -    before when running "make pot".
    +    The addition of "--omit-header" option for xgettext makes the "pot"
    +    snippets in ".build/pot/po/*.po" smaller. For the pot header of
    +    "po/git.pot", we use xgettext to generate a "pot" header file
    +    ".build/pot/git.header" from an empty file at runtime, and use this
    +    header to assemble "po/git.pot".
     
    -    But as we'll see in a subsequent commit our previous header behavior
    -    has been hiding an encoding-related bug from us, so let's carry it
    -    forward instead of re-generating it with xgettext(1).
    +    But as we'll see in a subsequent commit this header behavior has been
    +    hiding an encoding-related bug from us, so let's carry it forward
    +    instead of re-generating it with xgettext(1).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## .gitignore ##
     @@
    @@ .gitignore
      *.gcno
     
      ## Makefile ##
    -@@ Makefile: pdf:
    - XGETTEXT_FLAGS = \
    +@@ Makefile: INSTALL = install
    + TCL_PATH = tclsh
    + TCLTK_PATH = wish
    + XGETTEXT = xgettext
    ++MSGCAT = msgcat
    + MSGFMT = msgfmt
    + CURL_CONFIG = curl-config
    + GCOV = gcov
    +@@ Makefile: XGETTEXT_FLAGS = \
      	--force-po \
      	--add-comments=TRANSLATORS: \
    --	--msgid-bugs-address="Git Mailing List <git@vger.kernel.org>" \
    --	--from-code=UTF-8
    -+	--from-code=UTF-8 \
    -+	--omit-header
    -+
    + 	--msgid-bugs-address="Git Mailing List <git@vger.kernel.org>" \
    ++	--package-name=Git \
    + 	--sort-by-file \
    + 	--from-code=UTF-8
      XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
    - 	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
    - XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
    +@@ Makefile: XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
    + 	--keyword=gettextln --keyword=eval_gettextln
    + XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
    + 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
    ++MSGCAT_FLAGS = --sort-by-file
    + LOCALIZED_C = $(FOUND_C_SOURCES) $(SCALAR_SOURCES) \
    + 	      $(FOUND_H_SOURCES) $(GENERATED_H)
    + LOCALIZED_SH = $(SCRIPT_SH)
     @@ Makefile: LOCALIZED_SH += t/t0200/test.sh
      LOCALIZED_PERL += t/t0200/test.perl
      endif
    @@ Makefile: LOCALIZED_SH += t/t0200/test.sh
     -## under a very controlled condition, i.e. (1) it is to be run in a
     -## Git repository (not a tarball extract), (2) any local modifications
     -## will be lost.
    -+## We generate intermediate .build/pot/po/% files containing a extract
    -+## of the translations we find in each file in the source tree. The
    -+## files have the same basename as the source due xgettext(1) not
    -+## having a way to override the basename inserted into comments.
    ++## We generate intermediate .build/pot/po/%.po files containing a
    ++## extract of the translations we find in each file in the source
    ++## tree. We will assemble them using msgcat to create the final
    ++## "po/git.pot" file.
     +LOCALIZED_ALL_GEN_PO =
     +
    -+LOCALIZED_C_GEN_PO = $(LOCALIZED_C:%=.build/pot/po/%)
    ++LOCALIZED_C_GEN_PO = $(LOCALIZED_C:%=.build/pot/po/%.po)
     +LOCALIZED_ALL_GEN_PO += $(LOCALIZED_C_GEN_PO)
     +
    -+LOCALIZED_SH_GEN_PO = $(LOCALIZED_SH:%=.build/pot/po/%)
    ++LOCALIZED_SH_GEN_PO = $(LOCALIZED_SH:%=.build/pot/po/%.po)
     +LOCALIZED_ALL_GEN_PO += $(LOCALIZED_SH_GEN_PO)
     +
    -+LOCALIZED_PERL_GEN_PO = $(LOCALIZED_PERL:%=.build/pot/po/%)
    ++LOCALIZED_PERL_GEN_PO = $(LOCALIZED_PERL:%=.build/pot/po/%.po)
     +LOCALIZED_ALL_GEN_PO += $(LOCALIZED_PERL_GEN_PO)
     +
      ## Gettext tools cannot work with our own custom PRItime type, so
      ## we replace PRItime with PRIuMAX.  We need to update this to
      ## PRIdMAX if we switch to a signed type later.
    -+LOCALIZED_C_GEN	= $(LOCALIZED_C:%=.build/pot/in/%)
    -+$(LOCALIZED_C_GEN): .build/pot/in/%: %
    ++$(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: %
     +	$(call mkdir_p_parent_template)
    -+	$(QUIET_GEN)sed -e 's|PRItime|PRIuMAX|g' <$< >$@
    -+
    -+$(LOCALIZED_C_GEN_PO): .build/pot/po/%: .build/pot/in/%
    -+	$(call mkdir_p_parent_template)
    -+	$(QUIET_XGETTEXT)(\
    -+		cd .build/pot/in && \
    -+		$(XGETTEXT) -o $(@:.build/pot/po/%=../po/%) \
    -+			$(XGETTEXT_FLAGS_C) \
    -+			$(<:.build/pot/in/%=%) \
    -+	)
    ++	$(QUIET_XGETTEXT) \
    ++	    if grep -q PRItime $<; then \
    ++		(\
    ++			sed -e 's|PRItime|PRIuMAX|g' <$< \
    ++				>.build/pot/po/$< && \
    ++			cd .build/pot/po && \
    ++			$(XGETTEXT) --omit-header \
    ++				-o $(@:.build/pot/po/%=%) \
    ++				$(XGETTEXT_FLAGS_C) $< && \
    ++			rm $<; \
    ++		); \
    ++	    else \
    ++		$(XGETTEXT) --omit-header \
    ++			-o $@ $(XGETTEXT_FLAGS_C) $<; \
    ++	    fi
      
     -po/git.pot: $(GENERATED_H) FORCE
     -	# All modifications will be reverted at the end, so we do not
     -	# want to have any local change.
     -	git diff --quiet HEAD && git diff --quiet --cached
    -+$(LOCALIZED_SH_GEN_PO): .build/pot/po/%: %
    ++$(LOCALIZED_SH_GEN_PO): .build/pot/po/%.po: %
     +	$(call mkdir_p_parent_template)
    -+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@ $(XGETTEXT_FLAGS_SH) $<
    ++	$(QUIET_XGETTEXT)$(XGETTEXT) --omit-header \
    ++		-o$@ $(XGETTEXT_FLAGS_SH) $<
      
     -	@for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \
     -	do \
     -		sed -e 's|PRItime|PRIuMAX|g' <"$$s" >"$$s+" && \
     -		cat "$$s+" >"$$s" && rm "$$s+"; \
     -	done
    -+$(LOCALIZED_PERL_GEN_PO): .build/pot/po/%: %
    -+	$(call mkdir_p_parent_template)
    -+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@ $(XGETTEXT_FLAGS_PERL) $<
    -+
    -+.build/pot/pot.header:
    ++$(LOCALIZED_PERL_GEN_PO): .build/pot/po/%.po: %
     +	$(call mkdir_p_parent_template)
    -+	$(QUIET_GEN)sed -n -e '/^$$/q' -e 'p' <po/git.pot >$@
    ++	$(QUIET_XGETTEXT)$(XGETTEXT) --omit-header \
    ++		-o$@ $(XGETTEXT_FLAGS_PERL) $<
      
     -	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
     -	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_SH) \
     -		$(LOCALIZED_SH)
     -	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_PERL) \
     -		$(LOCALIZED_PERL)
    -+.build/pot/git.pot: .build/pot/pot.header $(LOCALIZED_ALL_GEN_PO)
    -+	$(QUIET_GEN)msgcat $^ >$@
    ++.build/pot/git.header: $(LOCALIZED_ALL_GEN_PO)
    ++	$(call mkdir_p_parent_template)
    ++	$(QUIET_XGETTEXT)$(XGETTEXT) $(XGETTEXT_FLAGS_C) \
    ++		-o - /dev/null | \
    ++	sed -e 's|charset=CHARSET|charset=UTF-8|g' >$@ && \
    ++	echo '"Plural-Forms: nplurals=INTEGER; plural=EXPRESSION;\\n"' >>$@
      
     -	# Reverting the munged source, leaving only the updated $@
     -	git reset --hard
     -	mv $@+ $@
    -+po/git.pot: .build/pot/git.pot FORCE
    -+	$(QUIET_CP)cp $< $@
    ++po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
    ++	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
      
      .PHONY: pot
      pot: po/git.pot
    @@ Makefile: cocciclean:
      	$(RM) *.res
      	$(RM) $(OBJECTS)
      	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
    -
    - ## shared.mak ##
    -@@ shared.mak: ifndef V
    - 	QUIET_AR       = @echo '   ' AR $@;
    - 	QUIET_LINK     = @echo '   ' LINK $@;
    - 	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
    -+	QUIET_CP       = @echo '   ' CP $@;
    - 	QUIET_LNCP     = @echo '   ' LN/CP $@;
    - 	QUIET_XGETTEXT = @echo '   ' XGETTEXT $@;
    - 	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
 3:  91d55d2894 <  -:  ---------- po/git: regenerate with "make pot"
 4:  a7f8122d43 !  4:  a54e33dbff i18n CI: stop allowing non-ASCII source messages in po/git.pot
    @@ Commit message
            gettext, 2011-11-18)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## Makefile ##
    -@@ Makefile: pdf:
    - XGETTEXT_FLAGS = \
    - 	--force-po \
    +@@ Makefile: XGETTEXT_FLAGS = \
      	--add-comments=TRANSLATORS: \
    --	--from-code=UTF-8 \
    - 	--omit-header
    - 
    + 	--msgid-bugs-address="Git Mailing List <git@vger.kernel.org>" \
    + 	--package-name=Git \
    +-	--sort-by-file \
    +-	--from-code=UTF-8
    ++	--sort-by-file
      XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
    -@@ Makefile: po/git.pot: .build/pot/git.pot FORCE
    + 	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
    + XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
    +@@ Makefile: po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
      .PHONY: pot
      pot: po/git.pot
      
     +.PHONY: check-pot
    -+check-pot: .build/pot/git.pot
    ++check-pot: pot
     +
      ifdef NO_GETTEXT
      POFILES :=
 5:  a42d04749f <  -:  ---------- po/git: regenerate with "make pot"
 6:  545d65554d !  5:  d9709a5b56 po/git.pot: don't check in result of "make pot"
    @@ Commit message
             $ git log -p --oneline -- po/git.pot|wc -l
             553743
     
    -    We can instead have the i18n tooling either read an OID from which to
    -    generate the po/git.pot, or the i18n coordinator could add and commit
    -    a po/git.pot to a branch in his fork.
    +    We can instead let l10n contributors to generate "po/git.pot" in runtime
    +    to update their own "po/XX.po", and the l10n coordinator can check
    +    pull requests using CI pipeline.
     
         This reverts to the schema introduced initially in cd5513a7168 (i18n:
         Makefile: "pot" target to extract messages marked for translation,
    @@ Commit message
         commit, to make this change easier to review, and to preempt the
         mailing list from blocking it due to it being too large.
     
    -    We'll probably want to adjust the header, but for now it's moved over
    -    as-is from po/git.pot.
    -
    -    Even though this makes .build/po/git.pot strictly redundant to
    -    po/git.pot let's keep the former, and have the rule for the latter
    -    copy it over, just not depending on FORCE now. We still need a
    -    po/*.pot so that "msginit(1)" in the gettext tooling does what we mean
    -    by default, but for other targets we can create things only in
    -    ".build" without littering the rest of the working copy.
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## Makefile ##
    -@@ Makefile: $(LOCALIZED_PERL_GEN_PO): .build/pot/po/%: %
    - 	$(call mkdir_p_parent_template)
    - 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@ $(XGETTEXT_FLAGS_PERL) $<
    - 
    --.build/pot/pot.header:
    --	$(call mkdir_p_parent_template)
    --	$(QUIET_GEN)sed -n -e '/^$$/q' -e 'p' <po/git.pot >$@
    --
    --.build/pot/git.pot: .build/pot/pot.header $(LOCALIZED_ALL_GEN_PO)
    -+.build/pot/git.pot: po/pot.header $(LOCALIZED_ALL_GEN_PO)
    - 	$(QUIET_GEN)msgcat $^ >$@
    - 
    --po/git.pot: .build/pot/git.pot FORCE
    -+po/git.pot: .build/pot/git.pot
    - 	$(QUIET_CP)cp $< $@
    - 
    - .PHONY: pot
     @@ Makefile: dist-doc: git$X
      
      distclean: clean
    @@ po/.gitignore
     @@
      /build
     +/git.pot
    -
    - ## po/git.pot ##
    -@@
    --# SOME DESCRIPTIVE TITLE.
    --# Copyright (C) YEAR THE PACKAGE'S COPYRIGHT HOLDER
    --# This file is distributed under the same license as the PACKAGE package.
    --# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
    --#
    --#, fuzzy
    --msgid   ""
    --msgstr  "Project-Id-Version: PACKAGE VERSION\n"
    --        "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
    --        "POT-Creation-Date: 2022-04-19 17:54+0200\n"
    --        "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
    --        "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
    --        "Language-Team: LANGUAGE <LL@li.org>\n"
    --        "Language: \n"
    --        "MIME-Version: 1.0\n"
    --        "Content-Type: text/plain; charset=UTF-8\n"
    --        "Content-Transfer-Encoding: 8bit\n"
    --        "Plural-Forms: nplurals=INTEGER; plural=EXPRESSION;\n"
    --#
    - # File: add-interactive.c, line: 382
    - #, c-format
    - msgid   "Huh (%s)?"
    -
    - ## po/pot.header (new) ##
    -@@
    -+# SOME DESCRIPTIVE TITLE.
    -+# Copyright (C) YEAR THE PACKAGE'S COPYRIGHT HOLDER
    -+# This file is distributed under the same license as the PACKAGE package.
    -+# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
    -+#
    -+#, fuzzy
    -+msgid ""
    -+msgstr ""
    -+"Project-Id-Version: PACKAGE VERSION\n"
    -+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
    -+"POT-Creation-Date: 2022-04-19 17:54+0200\n"
    -+"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
    -+"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
    -+"Language-Team: LANGUAGE <LL@li.org>\n"
    -+"Language: \n"
    -+"MIME-Version: 1.0\n"
    -+"Content-Type: text/plain; charset=UTF-8\n"
    -+"Content-Transfer-Encoding: 8bit\n"
    -+"Plural-Forms: nplurals=INTEGER; plural=EXPRESSION;\n"
 7:  8bcf497fad !  6:  7810b16fc4 po/git.pot: remove this now generated file, see preceding commit

     (Ignored...)

 8:  987a5b80f1 <  -:  ---------- Makefile: always declare [PM]OFILES variables
 9:  3da73392a9 <  -:  ---------- po/*.po: filter through msgcat --no-location
10:  4add92aa92 <  -:  ---------- po/*.po: don't check in files with --add-location=full
 -:  ---------- >  7:  3981f16d30 Makefile: add "po-update" rule to update po/XX.po
 -:  ---------- >  8:  e6548a7a89 Makefile: add "po-init" rule to initialize po/XX.po
11:  72ed0c8b2e !  9:  4bd525fa86 i18n: migrate to line-number-less i18n workflow
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    i18n: migrate to line-number-less i18n workflow
    +    l10n: Document the new l10n workflow
     
         Change the "flow" of how translators interact with the l10n repository
         at [1] to adjust it for a new workflow of not having a po/git.pot file
    @@ Commit message
         "master" is usually pretty small, so perhaps translators can just work
         on "master" instead.
     
    -    This also required pulling in some parts of the git-po-helper[1]
    -    logic, in particular the creation of the "core pot" added in its
    -    9efa9a5 (New option --core for init to create core po/pot file,
    -    2021-04-26). As the Makefile changes here show doing so is rather
    -    trivial now that the po/git.pot is generated in the ".build"directory.
    -
    -    We also need to add a new "po-init" target, which replaces both the
    -    "git-po-helper init" and the the instructions for manually munging the
    -    msginit'd file that I added in 5e9637c6297 (i18n: add infrastructure
    -    for translating Git with gettext, 2011-11-18). Now to e.g. create a
    -    new Faroese translation:
    -
    -        make po-init PO_FILE=po/fo.po
    -
    -    We can furthermore delete the po/pot.header file. We've been relying
    -    on the git.pot to provide a template for us (which msginit implicitly
    -    picks up), but now we don't need to carry it around anymore. We'll
    -    instead munge the msginit'd output appropriately.
    -
    -    1. https://github.com/git-l10n/git-po-helper/
    +    1. https://github.com/git-l10n/git-po/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    -
    - ## Makefile ##
    -@@ Makefile: $(LOCALIZED_PERL_GEN_PO): .build/pot/po/%: %
    - 	$(call mkdir_p_parent_template)
    - 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@ $(XGETTEXT_FLAGS_PERL) $<
    - 
    --.build/pot/git.pot: po/pot.header $(LOCALIZED_ALL_GEN_PO)
    -+.build/pot/git.pot: $(LOCALIZED_ALL_GEN_PO)
    - 	$(QUIET_GEN)msgcat $^ >$@
    - 
    - po/git.pot: .build/pot/git.pot
    -@@ Makefile: pot: po/git.pot
    - .PHONY: check-pot
    - check-pot: .build/pot/git.pot
    - 
    -+### TODO FIXME: Translating everything in these files is a bad
    -+### heuristic for "core", as we'll translate obscure error() messages
    -+### along with commonly seen i18n messages. A better heuristic would
    -+### be to e.g. use spatch to first remove error/die/warning
    -+### etc. messages.
    -+LOCALIZED_C_CORE =
    -+LOCALIZED_C_CORE += builtin/checkout.c
    -+LOCALIZED_C_CORE += builtin/clone.c
    -+LOCALIZED_C_CORE += builtin/index-pack.c
    -+LOCALIZED_C_CORE += builtin/push.c
    -+LOCALIZED_C_CORE += builtin/reset.c
    -+LOCALIZED_C_CORE += remote.c
    -+LOCALIZED_C_CORE += wt-status.c
    -+### This "clean" target is only needed for the dependency-busting
    -+### core-pot target
    -+clean-pot:
    -+	$(RM) -r .build/pot
    -+.PHONY: core-pot
    -+core-pot: clean-pot
    -+	$(MAKE) pot LOCALIZED_C="$(LOCALIZED_C_CORE)" LOCALIZED_SH= LOCALIZED_PERL=
    -+
    -+## Managing *.po files
    -+PO_INIT_FLAGS = \
    -+	--input=.build/pot/git.pot \
    -+	--output=$@ \
    -+	--no-translator \
    -+	--locale=$(PO_LANG)
    -+
    -+.build/po-init/$(PO_FILE).gen: .build/pot/git.pot
    -+	$(call mkdir_p_parent_template)
    -+	$(QUIET_MSGINIT)msginit $(PO_INIT_FLAGS)
    -+
    -+### We need some Po-Revision-Date or e.g. Emacs's po-mode.el will
    -+### replace the header entirely.
    -+.build/po-init/$(PO_FILE).head: .build/po-init/$(PO_FILE).gen
    -+	$(QUIET_GEN)\
    -+	echo "# This file is distributed under the same license as the Git package." >$@ && \
    -+	sed -n -e '1,/^$$/p' <$< | \
    -+		sed \
    -+			-e '/^$$/d' \
    -+			-e 's/PACKAGE VERSION/Git/' \
    -+			-e 's/Automatically generated/make by the Makefile/' \
    -+			-e 's/none/Git Mailing List <git@vger.kernel.org>/' \
    -+			-e 's/charset=ASCII/charset=UTF-8/' \
    -+		>>$@ && \
    -+	printf "\"PO-Revision-Date: 2022-04-11 11:05+0200\\\n\"\n" >>$@
    -+	echo >>$@
    -+
    -+.build/po-init/$(PO_FILE).tail: .build/po-init/$(PO_FILE).gen
    -+	$(QUIET_GEN)sed -n -e '1,/^$$/d' -e 'p' <$< >$@
    -+
    -+PO_LANG = $(PO_FILE:po/%.po=%)
    -+
    -+# TODO?: Prune out the "automatically generated" etc?
    -+
    -+.PHONY: po-init
    -+po-init: .build/po-init/$(PO_FILE).head .build/po-init/$(PO_FILE).tail
    -+	$(QUIET_PO_INIT)if test -e $(PO_FILE); then \
    -+		echo error: $(PO_FILE) exists already >&2; \
    -+		exit 1; \
    -+	fi && \
    -+	cat $^ >$(PO_FILE)
    -+
    - ## po/*.po files & their rules
    - POFILES = $(wildcard po/*.po)
    - 
    +    Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## po/README.md ##
     @@ po/README.md: for a new language translation. Because there are more than 5000 messages
    @@ po/README.md: for a new language translation. Because there are more than 5000 m
     -The core template message file which contains a small set of messages
     -will be generated in "po-core/core.pot" automatically by running a helper
     -program named "git-po-helper" (described later).
    -+The "core" set of messages can be generated by running:
    ++The "core" set of messages can be generated at "po/git-core.pot" by
    ++running:
      
      ```shell
     -git-po-helper init --core XX.po
    @@ po/README.md: for a new language translation. Because there are more than 5000 m
     -
     -Edit "po/XX.po" by hand to fix "fuzzy" messages, which may have misplaced
     -translated messages and duplicate messages.
    --
    -+And then proceeding with the rest of these instructions (butdon't run
    -+the full `make pot`!).
    ++And then proceeding with the rest of these instructions on the new
    ++generated "po/git-core.pot" file.
    + 
      
      ## Translation Process Flow
      
      The overall data-flow looks like this:
      
    -     +-------------------+            +------------------+
    +-    +-------------------+            +------------------+
     -    | Git source code   | ---(1)---> | L10n coordinator |
    -+    | Git source code   | ---(3)---> | L10n coordinator |
    -     | repository        | <---(4)--- | repository       |
    -     +-------------------+            +------------------+
    +-    | repository        | <---(4)--- | repository       |
    +-    +-------------------+            +------------------+
     -                                          |      ^
     -                                         (2)    (3)
     -                                          V      |
     -                                     +------------------+
     -                                     | Language Team XX |
     -                                     +------------------+
    -+                      |                ^
    -+                     (1)              (3)
    -+                      V                |
    -+                     +------------------+
    -+                     | Language Team XX |
    -+                     +------------------+
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
      
      - Translatable strings are marked in the source file.
     -- L10n coordinator pulls from the source (1)
     -- L10n coordinator updates the message template "po/git.pot"
     -- Language team pulls from L10n coordinator (2)
    -+- Language team pulls new sources (1)
    - - Language team updates the message file "po/XX.po"
    +-- Language team updates the message file "po/XX.po"
     -- L10n coordinator pulls from Language team (3)
    -+- L10n coordinator re-pulls from upstream (3), merges & adjusts
    - - L10n coordinator asks the result to be pulled (4).
    +-- L10n coordinator asks the result to be pulled (4).
    ++- Language teams can start translation iterations at any time, even
    ++  before the l10n window opens:
    ++
    ++  + Pull from the source (1)
    ++  + Update the message file by running "make po-update PO\_FILE=po/XX.po"
    ++  + Translate the message file "po/XX.po"
      
    ++- The L10n coordinator pulls from source and announces the l10n window
    ++  open (2)
    ++- Language team pulls from the l10n coordinator, starts another
    ++  translation iteration against the l10n coordinator's tree (3)
      
     -## Maintaining the "po/git.pot" file
    --
    ++  + Run "git pull --rebase" from the l10n coordinator
    ++  + Update the message file by running "make po-update PO\_FILE=po/XX.po"
    ++  + Translate the message file "po/XX.po"
    ++  + Squash trivial l10n git commits using "git rebase -i"
    + 
     -(This is done by the l10n coordinator).
    -+## Creating the "po/git.pot" file
    ++- Language team sends pull request to the l10n coordinator (4)
    ++- L10n coordinator checks and merges
    ++- L10n coordinator asks the result to be pulled (5).
      
    - The "po/git.pot" file contains a message catalog extracted from Git's
    +-The "po/git.pot" file contains a message catalog extracted from Git's
     -sources. The l10n coordinator maintains it by adding new translations with
     -msginit(1), or update existing ones with msgmerge(1).  In order to update
     -the Git sources to extract the messages from, the l10n coordinator is
     -expected to pull from the main git repository at strategic point in
     -history (e.g. when a major release and release candidates are tagged),
     -and then run "make pot" at the top-level directory.
    -+sources, it is created by running:
    -+
    -+	make pot
    -+
    -+The l10ncoordintor announces a target release to translate, which is
    -+expected to be a strategic point in history (e.g. when a major release
    -+and release candidates are tagged).
    -+
    -+Language contributors are then expected to work on translations
    -+against this release, i.e. to `make pot` by doing e.g.:
      
     -Language contributors use this file to prepare translations for their
     -language, but they are not expected to modify it.
    -+    git worktree add /tmp/git-pot v2.35.0
    -+    make -C /tmp/git-pot pot
    - 
    -+And to then follow the instructions in "Updating a "XX.po" file" below
    -+using this generated `/tmp/git-pot/po/git.pot` file. After the
    -+`msgmerge` described there the temporary worktree can be removed:
    ++## Creating the "po/git.pot" file
     +
    -+    git worktree remove --force /tmp/git-pot
    ++The "po/git.pot" file, once generated by the the l10n coordinator had
    ++been removed from the tree. L10n contributors can generated it at
    ++runtime using command:
    ++
    ++```shell
    ++make pot
    ++```
    ++
    ++Then language contributors use this file to prepare translations for
    ++their language, but they are not expected to modify it.
      
    - ## Initializing a "XX.po" file
      
    + ## Initializing a "XX.po" file
     @@ po/README.md: If your language XX does not have translated message file "po/XX.po" yet,
      you add a translation for the first time by running:
      
    @@ -1,6 +1,6 @@
      
     -And change references to PACKAGE VERSION in the PO Header Entry to
     -just "Git":
    --
    ++Where XX is the locale, e.g. "de", "is", "pt\_BR", "zh\_CN", etc.
    + 
     -```shell
     -perl -pi -e 's/(?<="Project-Id-Version: )PACKAGE VERSION/Git/' XX.po
     -```
    -+Where XX is the locale, e.g. "de", "is", "pt\_BR", "zh\_CN", etc.
    ++The newly generated message file "po/XX.po" is based on the core pot
    ++file "po/git-core.pot", so it contains only a minimal set of messages
    ++and it's a good start for a new language contribution.
      
      Once you are done testing the translation (see below), commit the result
      and ask the l10n coordinator to pull from you.
    @@ po/README.md: and ask the l10n coordinator to pull from you.
     -of the l10n coordinator has newer "po/git.pot" file, you would need to first
     -pull from the l10n coordinator (see the beginning of this document for its
     -URL), and then update the existing translation by running:
    -+If there's an existing "XX.po" file for your language, but the l10n
    -+coordinator announced a new target release forthe "po/git.pot" file,
    -+you would need to first `make pot` against that release. See "Creating the "po/git.pot" file" above.
    -+
    -+Then update the existing translation by running, in the "po/"
    -+directory, where "XX.po" is the file you want to update:
    ++If you want to find new translatable strings in source files of upstream
    ++repository and propagate them to your "po/XX.po", run command:
      
      ```shell
     -msgmerge --add-location --backup=off -U XX.po git.pot
    -+msgmerge --no-location --backup=off -U XX.po git.pot
    ++make po-update PO_FILE=po/XX.po
      ```
      
     -in the "po/" directory, where "XX.po" is the file you want to update.
    -+Or, in the case of the temporary worktree described above:
    ++It will:
      
     -Once you are done testing the translation (see below), commit the result
     -and ask the l10n coordinator to pull from you.
    -+```shell
    -+msgmerge --no-location --backup=off -U XX.po /tmp/git-pot/po/git.pot
    -+```
    ++- Call "make pot" at runtime to generate new "po/git.pot" file
    ++- Call "msgmerge --add-location --backup=off -U po/XX.po po/git.pot"
    ++  to update your "po/XX.po"
    ++- The "--add-location" option for msgmerge will add location lines,
    ++  and these location lines will help translation tools to location
    ++  translation context easily.
     +
    -+Or, if you use translation software such as Emacs's `po-mode.el` which
    -+allows you to open source code references skip the `--no-location` and
    -+instead add do:
    ++Once you are done testing the translation (see below), it's better
    ++to commit a location-less "po/XX.po" file to save repository space
    ++and make a user-friendly patch for review.
     +
    -+```shell
    -+msgmerge --backup=off -U XX.po git.pot
    -+```
    ++To save a location-less "po/XX.po" automatically in repository, you
    ++can:
     +
    -+Once you are done testing the translation (see below) remove the line
    -+generated numbers (if any) from the translation. You can skip this if
    -+you used `--no-location` above.
    - 
    -+To do this safely first commit your work in `XX.po`. Then:
    ++- Define new attribute for "po/XX.po" by adding new line in
    ++  ".git/info/attributes":
     +
    -+```shell
    -+msgcat --no-location XX.po >XX.po.tmp && mv -v XX.po.tmp XX.po
    -+```
    ++        /po/XX.po filter=gettext-no-location
    ++
    ++- Define driver for "gettext-no-location" filter:
     +
    -+This should result in a file where all the auto-generated line numbers
    -+have been removed, and `make check-po` should now pass. Now either
    -+commit it, or amend it into the commit you made earlier.
    ++        $ git config --global filter.gettext-no-location.clean \
    ++              "msgcat --no-location -"
     +
     +You're now ready to ask the l10n coordinator to pull from you.
      
    + 
      ## Fuzzy translation
    +@@ po/README.md: common errors, e.g. missing printf format strings, or translated
    + messages that deviate from the originals in whether they begin/end
    + with a newline or not.
      
    -@@ po/README.md: tag in the comment.
    - Before you submit your changes go back to the top-level and do:
    ++L10n coordinator will check your contributions using a helper program
    ++(see "PO helper" section below):
    ++
    ++```shell
    ++git-po-helper check-po po/XX.po
    ++git-po-helper check-commits <rev-list-opts>
    ++```
    ++
      
    - ```shell
    --make
    -+make all check-po
    - ```
    + ## Marking strings for translation
    + 
    +@@ po/README.md: l10n workflow.
    + To build and install the helper program from source, see
    + [git-po-helper/README][].
    + 
    +-Usage for git-po-helper:
    +-
    +-- To start a new language translation:
    +-
    +-  ```shell
    +-  git-po-helper init XX.po
    +-  ```
    +-
    +-- To update your "XX.po" file:
    +-
    +-  ```shell
    +-  git-po-helper update XX.po
    +-  ```
    +-
    +-- To check commit log and syntax of "XX.po":
    +-
    +-  ```shell
    +-  git-po-helper check-po XX.po
    +-  git-po-helper check-commits
    +-  ```
    +-
    +-Run "git-po-helper" without arguments to show usage.
    +-
    + 
    + ## Conventions
      
    - On systems with GNU gettext (i.e. not Solaris) this will compile your
     @@ po/README.md: additional conventions:
      - Initialize proper filename of the "XX.po" file conforming to
        iso-639 and iso-3166.
    @@ po/README.md: additional conventions:
      
      - Add a new entry in the "po/TEAMS" file with proper format, and check
        the syntax of "po/TEAMS" by running the following command:
    -
    - ## po/pot.header (deleted) ##
    -@@
    --# SOME DESCRIPTIVE TITLE.
    --# Copyright (C) YEAR THE PACKAGE'S COPYRIGHT HOLDER
    --# This file is distributed under the same license as the PACKAGE package.
    --# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
    --#
    --#, fuzzy
    --msgid ""
    --msgstr ""
    --"Project-Id-Version: PACKAGE VERSION\n"
    --"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
    --"POT-Creation-Date: 2022-04-19 17:54+0200\n"
    --"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
    --"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
    --"Language-Team: LANGUAGE <LL@li.org>\n"
    --"Language: \n"
    --"MIME-Version: 1.0\n"
    --"Content-Type: text/plain; charset=UTF-8\n"
    --"Content-Transfer-Encoding: 8bit\n"
    --"Plural-Forms: nplurals=INTEGER; plural=EXPRESSION;\n"
    -
    - ## shared.mak ##
    -@@ shared.mak: ifndef V
    - 	QUIET_CP       = @echo '   ' CP $@;
    - 	QUIET_LNCP     = @echo '   ' LN/CP $@;
    - 	QUIET_XGETTEXT = @echo '   ' XGETTEXT $@;
    -+	QUIET_MSGINIT  = @echo '   ' MSGINIT $@;
    - 	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
    - 	QUIET_GCOV     = @echo '   ' GCOV $@;
    - 	QUIET_SP       = @echo '   ' SP $<;
    -@@ shared.mak: ifndef V
    - ## Used in "Makefile" for po/
    - 	QUIET_CHECK_MSGCAT	= @echo '   ' MSGCAT $(MSGCAT_CHECK_FLAGS) $< \>$@;
    - 	QUIET_CHECK_PO		= @echo '   ' CHECK PO $@;
    -+	QUIET_PO_INIT		= @echo '   ' PO INIT $@;
    - 
    - ## Used in "Documentation/Makefile"
    - 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
12:  22434ef36a <  -:  ---------- Makefile: avoid "sed" on C files that don't need it
---

Jiang Xin (3):
  Makefile: sort "po/git.pot" by file location
  Makefile: generate "po/git.pot" from stable LOCALIZED_C
  Makefile: add "po-update" rule to update po/XX.po

Ævar Arnfjörð Bjarmason (6):
  Makefile: have "make pot" not "reset --hard"
  i18n CI: stop allowing non-ASCII source messages in po/git.pot
  po/git.pot: don't check in result of "make pot"
  po/git.pot: remove this now generated file, see preceding commit
  Makefile: add "po-init" rule to initialize po/XX.po
  l10n: Document the new l10n workflow

 .gitignore                  |     1 +
 Makefile                    |   148 +-
 builtin/submodule--helper.c |     2 +-
 ci/run-static-analysis.sh   |     2 +
 po/.gitignore               |     2 +
 po/README.md                |   191 +-
 po/git.pot                  | 25151 ----------------------------------
 shared.mak                  |     2 +
 8 files changed, 221 insertions(+), 25278 deletions(-)
 delete mode 100644 po/git.pot

-- 
2.35.1.577.g74cc1aa55f

