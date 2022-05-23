Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37A2C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 15:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbiEWPWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 11:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237816AbiEWPVo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 11:21:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A28928710
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso17812860pjj.4
        for <git@vger.kernel.org>; Mon, 23 May 2022 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J0qzDY/fFQkCzjUyNuDutWggWeDB/lHzSbnGDz1GYrM=;
        b=oFm39Tso/4xZqqit1KWaDtkb1F/3gQIPTMr1HguLzh/PYm1fWoMegbY+/JARpKMTw1
         AqIWRFG7MEn/1EmWZtN/GEkVtejj1hDbeLI12KpvZtMaImCMvuVGOZDsaQGceDvF6wDH
         Ja40wD/9gvAGLhb6T+7pPPDk3LOZt7OBDXZaSOR94+Exg+qQCkjkR5n2uMQpg86wE1IM
         ze3OYa9xAXinxI+wuukEFoJ/Rr8ihzAga19n3GJjhbqU5/bcEGD6eT7t3VQX1FKIF0Mc
         t/qxHmUli46qZE3DkWh8FVp2/V4orL6Dglcy6LKGVP2xDIUVqaUgVoXGs9LSle4wnDJS
         jXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0qzDY/fFQkCzjUyNuDutWggWeDB/lHzSbnGDz1GYrM=;
        b=MuptRK0gQWswjM5r0zJcC6iA6BbmxoDnGhWkcZ+Xsa9NQthzogdoLdazXShtdZ989p
         kQMBoaIqyuUdBWUrpS0Q4DuYSoOuPJU+hyJCvKB/JOXC0dv/nS335opfrSnxAWfo8u6w
         0rN9rzTO2ziQyZXgdZhHeR4o9p+JRv3bExG0DwsBXTT6reQ3+GNR1sSD0x9h0jM89fU2
         SQhlr2O3BrzOlZJnVKNp2fdceSFPJmw9T7Qki+2EdtHgKkrlVfCH8pu9lljHko3PDXW1
         ekdEIwO2/L/q1hpvdwoBVdWnYQxQg7KEC+yD34zOK3cbUhrjbE1K2nmLRs8L0S4UfuFO
         a/Wg==
X-Gm-Message-State: AOAM533PolUwFflVjIMZIxuUourQxJ4YosCWayeN+F4mtw2TIxi5eAEt
        pLVnjvq7HXsrH7Es+YRQphM=
X-Google-Smtp-Source: ABdhPJxWfOh33nKQwKHi80sbGpMIJiksCJXCjGUeOUlIKM0vO16O5m2tGrHiyL6v86J2sEDLtsPjPg==
X-Received: by 2002:a17:902:e484:b0:161:6657:dc5b with SMTP id i4-20020a170902e48400b001616657dc5bmr23636703ple.2.1653319300668;
        Mon, 23 May 2022 08:21:40 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y13-20020a1709027c8d00b0015e8d4eb2cfsm5280287pll.281.2022.05.23.08.21.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 May 2022 08:21:40 -0700 (PDT)
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
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 3/9] Makefile: have "make pot" not "reset --hard"
Date:   Mon, 23 May 2022 23:21:22 +0800
Message-Id: <20220523152128.26380-4-worldhello.net@gmail.com>
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

Before commit fc0fd5b23b (Makefile: help gettext tools to cope with our
custom PRItime format, 2017-07-20), we'd consider source files as-is
with gettext, but because we need to understand PRItime in the same way
that gettext itself understands PRIuMAX, we'd first check if we had a
clean checkout, then munge all of the processed files in-place with
"sed", generate "po/git.pot", and then finally "reset --hard" to undo
our changes.

By generating "pot" snippets in ".build/pot/po" for each source file
and rewriting certain source files with PRItime macros to temporary
files in ".build/pot/po", we can avoid running "make pot" by altering
files in place and doing a "reset --hard" afterwards.

This speed of "make pot" is slower than before on an initial run,
because we run "xgettext" many times (once per source file), but it
can be boosted by parallelization. It is *much* faster for incremental
runs, and will allow us to implement related targets in subsequent
commits.

When the "pot" target was originally added in cd5513a7168 (i18n:
Makefile: "pot" target to extract messages marked for translation,
2011-02-22) it behaved like a "normal" target. I.e. we'd skip the
re-generation of the po/git.pot if nothing had to be done.

Then after po/git.pot was checked in in dce37b66fb0 (l10n: initial
git.pot for 1.7.10 upcoming release, 2012-02-13) the target was broken
until 1f31963e921 (i18n: treat "make pot" as an explicitly-invoked
target, 2014-08-22) when it was made to depend on "FORCE". I.e. the
Makefile's dependency resolution inherently can't handle incremental
building when the target file may be updated by git (or something else
external to "make"). But this case no longer applies, so FORCE is no
longer needed.

That out of the way, the main logic change here is getting rid of the
"reset --hard":

We'll generate intermediate ".build/pot/po/%.po" files from "%", which
is handy to see at a glance what strings (if any) in a given file are
marked for translation:

	$ make .build/pot/po/pretty.c.po
	[...]
	$ cat .build/pot/po/pretty.c.po
	#: pretty.c:1051
	msgid "unable to parse --pretty format"
	msgstr ""
	$

For these C source files which contain the PRItime macros, we will
create temporary munged "*.c" files in a tree in ".build/pot/po"
corresponding to our source tree, and have "xgettext" consider those.
The rule needs to be careful to "(cd .build/pot/po && ...)", because
otherwise the comments in the po/git.pot file wouldn't refer to the
correct source locations (they'd be prefixed with ".build/pot/po").
These temporary munged "*.c” files will be removed immediately after
the corresponding po files are generated, because some development tools
cannot ignore the duplicate source files in the ".build" directory
according to the ".gitignore" file, and that may cause trouble.

The output of the generated po/git.pot file is changed in one minor
way: Because we're using msgcat(1) instead of xgettext(1) to
concatenate the output we'll now disambiguate where "TRANSLATORS"
comments come from, in cases where a message is the same in N files,
and either only one has a "TRANSLATORS" comment, or they're
different. E.g. for the "Your edited hunk[...]" message we'll now
apply this change (comment content elided):

	+#. #-#-#-#-#  add-patch.c.po  #-#-#-#-#
	 #. TRANSLATORS: do not translate [y/n]
	[...]
	+#. #-#-#-#-#  git-add--interactive.perl.po  #-#-#-#-#
	 #. TRANSLATORS: do not translate [y/n]
	[...]
	 #: add-patch.c:1253 git-add--interactive.perl:1244
	 msgid ""
	 "Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
	 msgstr ""

There are six such changes, and they all make the context more
understandable, as msgcat(1) is better at handling these edge cases
than xgettext(1)'s previously used "--join-existing" flag.

But filenames in the above disambiguation lines of extracted-comments
have an extra ".po" extension compared to the filenames at the file
locations. While we could rename the intermediate ".build/pot/po/%.po"
files without the ".po" extension to use more intuitive filenames in
the disambiguation lines of extracted-comments, but that will confuse
developer tools with lots of invalid C or other source files in
".build/pot/po" directory.

The addition of "--omit-header" option for xgettext makes the "pot"
snippets in ".build/pot/po/*.po" smaller. But as we'll see in a
subsequent commit this header behavior has been hiding an
encoding-related bug from us, so let's carry it forward instead of
re-generating it with xgettext(1).

The "po/git.pot" file should have a header entry, because a proper
header entry will increase the speed of creating a new po file using
msginit and set a proper "POT-Creation-Date:" field in the header
entry of a "po/XX.po" file. We use xgettext to generate a separate
header file at ".build/pot/git.header" from "/dev/null", and use this
header to assemble "po/git.pot".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 .gitignore |  1 +
 Makefile   | 80 ++++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/.gitignore b/.gitignore
index e81de1063a..a452215764 100644
--- a/.gitignore
+++ b/.gitignore
@@ -200,6 +200,7 @@
 *.[aos]
 *.o.json
 *.py[co]
+.build/
 .depend/
 *.gcda
 *.gcno
diff --git a/Makefile b/Makefile
index 46914dcd80..1962999c18 100644
--- a/Makefile
+++ b/Makefile
@@ -569,6 +569,7 @@ INSTALL = install
 TCL_PATH = tclsh
 TCLTK_PATH = wish
 XGETTEXT = xgettext
+MSGCAT = msgcat
 MSGFMT = msgfmt
 CURL_CONFIG = curl-config
 GCOV = gcov
@@ -2706,6 +2707,7 @@ XGETTEXT_FLAGS = \
 	--force-po \
 	--add-comments=TRANSLATORS: \
 	--msgid-bugs-address="Git Mailing List <git@vger.kernel.org>" \
+	--package-name=Git \
 	--sort-by-file \
 	--from-code=UTF-8
 XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
@@ -2714,6 +2716,7 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
+MSGCAT_FLAGS = --sort-by-file
 LOCALIZED_C = $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
 	      $(GENERATED_H)
 LOCALIZED_SH = $(SCRIPT_SH)
@@ -2726,34 +2729,68 @@ LOCALIZED_SH += t/t0200/test.sh
 LOCALIZED_PERL += t/t0200/test.perl
 endif
 
-## Note that this is meant to be run only by the localization coordinator
-## under a very controlled condition, i.e. (1) it is to be run in a
-## Git repository (not a tarball extract), (2) any local modifications
-## will be lost.
+## We generate intermediate .build/pot/po/%.po files containing a
+## extract of the translations we find in each file in the source
+## tree. We will assemble them using msgcat to create the final
+## "po/git.pot" file.
+LOCALIZED_ALL_GEN_PO =
+
+LOCALIZED_C_GEN_PO = $(LOCALIZED_C:%=.build/pot/po/%.po)
+LOCALIZED_ALL_GEN_PO += $(LOCALIZED_C_GEN_PO)
+
+LOCALIZED_SH_GEN_PO = $(LOCALIZED_SH:%=.build/pot/po/%.po)
+LOCALIZED_ALL_GEN_PO += $(LOCALIZED_SH_GEN_PO)
+
+LOCALIZED_PERL_GEN_PO = $(LOCALIZED_PERL:%=.build/pot/po/%.po)
+LOCALIZED_ALL_GEN_PO += $(LOCALIZED_PERL_GEN_PO)
+
 ## Gettext tools cannot work with our own custom PRItime type, so
 ## we replace PRItime with PRIuMAX.  We need to update this to
 ## PRIdMAX if we switch to a signed type later.
+$(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: %
+	$(call mkdir_p_parent_template)
+	$(QUIET_XGETTEXT) \
+	    if grep -q PRItime $<; then \
+		(\
+			sed -e 's|PRItime|PRIuMAX|g' <$< \
+				>.build/pot/po/$< && \
+			cd .build/pot/po && \
+			$(XGETTEXT) --omit-header \
+				-o $(@:.build/pot/po/%=%) \
+				$(XGETTEXT_FLAGS_C) $< && \
+			rm $<; \
+		); \
+	    else \
+		$(XGETTEXT) --omit-header \
+			-o $@ $(XGETTEXT_FLAGS_C) $<; \
+	    fi
 
-po/git.pot: $(GENERATED_H) FORCE
-	# All modifications will be reverted at the end, so we do not
-	# want to have any local change.
-	git diff --quiet HEAD && git diff --quiet --cached
+$(LOCALIZED_SH_GEN_PO): .build/pot/po/%.po: %
+	$(call mkdir_p_parent_template)
+	$(QUIET_XGETTEXT)$(XGETTEXT) --omit-header \
+		-o$@ $(XGETTEXT_FLAGS_SH) $<
 
-	@for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \
-	do \
-		sed -e 's|PRItime|PRIuMAX|g' <"$$s" >"$$s+" && \
-		cat "$$s+" >"$$s" && rm "$$s+"; \
-	done
+$(LOCALIZED_PERL_GEN_PO): .build/pot/po/%.po: %
+	$(call mkdir_p_parent_template)
+	$(QUIET_XGETTEXT)$(XGETTEXT) --omit-header \
+		-o$@ $(XGETTEXT_FLAGS_PERL) $<
+
+define gen_pot_header
+$(XGETTEXT) $(XGETTEXT_FLAGS_C) \
+	-o - /dev/null | \
+sed -e 's|charset=CHARSET|charset=UTF-8|' \
+    -e 's|\(Last-Translator: \)FULL NAME <.*>|\1make by the Makefile|' \
+    -e 's|\(Language-Team: \)LANGUAGE <.*>|\1Git Mailing List <git@vger.kernel.org>|' \
+    >$@ && \
+echo '"Plural-Forms: nplurals=INTEGER; plural=EXPRESSION;\\n"' >>$@
+endef
 
-	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
-	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_SH) \
-		$(LOCALIZED_SH)
-	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_PERL) \
-		$(LOCALIZED_PERL)
+.build/pot/git.header: $(LOCALIZED_ALL_GEN_PO)
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)$(gen_pot_header)
 
-	# Reverting the munged source, leaving only the updated $@
-	git reset --hard
-	mv $@+ $@
+po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO) FORCE
+	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $(filter-out FORCE,$^) >$@
 
 .PHONY: pot
 pot: po/git.pot
@@ -3292,6 +3329,7 @@ cocciclean:
 	$(RM) contrib/coccinelle/*.cocci.patch*
 
 clean: profile-clean coverage-clean cocciclean
+	$(RM) -r .build
 	$(RM) *.res
 	$(RM) $(OBJECTS)
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
-- 
2.36.0.1.g15c4090757

