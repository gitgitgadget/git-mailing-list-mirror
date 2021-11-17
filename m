Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE80C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5600061BF9
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbhKQKYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbhKQKXh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F89C061208
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id az33-20020a05600c602100b00333472fef04so4307209wmb.5
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8u9bMfK9/FBZDFFxq6YiVdA2m6F8RsMYbB/0iz+4l08=;
        b=opqAdFW8zQJOrZKkhqzCqJD1uW1XwFDlZyy6rpqTVdD1noXBH/KsPx9Cwj7GYnuSJW
         0jdYBSb9ZtFm/UE1IkEweOoqfY7llH7FldFRGg6ERTnO0J7IbwTHZkpUNHWHhA2Y6axz
         /H2N6UdhR6CEGkQEZ9LPjuGHVn84eliXQ1ifslDOAFQvNKt0j4Lai0E0uA19pVH5G9kA
         QyBPMg9XvENcLTf2Aj46sWE6nH0uQlxRsVl0SOj0vTT6/bY0kiNfDp/GigSuqOlBLG9J
         EBqDCR2aAZNMHZ2q9lKHnUpGFikn0EUOMWrq11UoT2VKuC1DLSSqmvZgPlqvHAqi0gJL
         mysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8u9bMfK9/FBZDFFxq6YiVdA2m6F8RsMYbB/0iz+4l08=;
        b=JsxQ9OzhJIRw5NIpaUz4YvvMEI9vnvLF/2H3I0y4PvmXM8x3fLsMe2kqeOcAIaXNcM
         8XM+CX4gJJjzWKh51Srx57xxDXcT/UPVuAcRSsvpfKG2ouc+SMnPjAr3ONSmzWuNs5fh
         ETLflyPPQMt3EQ/Qblc/FZeVjzLdROALdfRbcN2zToDCr/T4hTCpsf8p6v0W1j1ky+uM
         KP6VXl3chb8Td6MdqbIj4bzAMOFbGW2fMRYQFCz2fT17qUZjNqqoJtif8D30jpZSBM3o
         aJRQm89RNAxPsRhNjahc+xKdOkR5LRTmfcoNE48oq10ITsIWnzM8adRJr8nJbSpI3Xs2
         Zuyg==
X-Gm-Message-State: AOAM532nEul7pFEumhER1TuMXBGosjLKos04ZjGtHk5vbeCLU9+eDv4B
        kvqd3h7HrBW/rpoLwFNQKByTOyuBeCoOGg==
X-Google-Smtp-Source: ABdhPJxCgHzFaQEhroEgF8kbPJO1GyebQq4ovQ4VwNF4GUwwG/mQ4hYtmxx9Hs0/lu4WUbicl/kGmA==
X-Received: by 2002:a7b:c4c4:: with SMTP id g4mr15846105wmk.93.1637144437259;
        Wed, 17 Nov 2021 02:20:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 14/23] Makefile: re-add and use the "shellquote" macros
Date:   Wed, 17 Nov 2021 11:20:13 +0100
Message-Id: <patch-v4-14.23-13cbb851d32-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-add and use, and expand on "shellquote" macros added in
4769948afe7 (Deal with $(bindir) and friends with whitespaces.,
2005-10-10).

We avoided using them due to the "$(call)" feature of GNU make being
relatively new at the time, but it isn't anymore. We hard depend on
GNU make versions that have it.

The use of "$(call)" was removed in 39c015c556f (Fixes for ancient
versions of GNU make, 2006-02-18) and 7ffe7098dca (Fix installation of
templates on ancient systems., 2006-07-29) due to those
incompatibilities with older GNU make versions, and we've used the
more verbose *_SQ pattern ever since.

The "$(call)" feature was introduced in GNU make version 3.78,
released on the 22nd of September, 1999. That release also introduced
"$(error)" and "$(warning)", which we've been making use of since
f2fabbf76e4 (Teach Makefile to check header dependencies, 2010-01-26).

This extends upon the macros added in 4769948afe7: We now have macros
for quoting a ' inside '', and a ' with no surrounding '' as before.

Additionally provide and use a "shelldquote" macro along with
"shellquote" for the common case of wanting to quote a C string we
pass to the compiler with a -D flag.

This doesn't get rid of all of our shell quoting. We've still got some
in the main Makefile, let's leave most of it to avoid in-flight
conflicts. I've fully converted "templates/Makefile" and "t/Makefile"
though.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile           | 15 +++++----------
 shared.mak         | 14 ++++++++++++++
 t/Makefile         | 34 +++++++++++++++-------------------
 templates/Makefile | 14 +++++---------
 4 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/Makefile b/Makefile
index 7130e32a251..b458c24d95e 100644
--- a/Makefile
+++ b/Makefile
@@ -1996,11 +1996,7 @@ ifneq ("$(PROFILE)","")
 endif
 endif
 
-# Shell quote (do not use $(call) to accommodate ancient setups);
-
-ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
-ETC_GITATTRIBUTES_SQ = $(subst ','\'',$(ETC_GITATTRIBUTES))
-
+# Shell quote, should be changed to use $(call shellquote,...)
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 NO_GETTEXT_SQ = $(subst ','\'',$(NO_GETTEXT))
 bindir_SQ = $(subst ','\'',$(bindir))
@@ -2535,11 +2531,11 @@ builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
 
 config.sp config.s config.o: GIT-PREFIX
 config.sp config.s config.o: EXTRA_CPPFLAGS = \
-	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
+	-DETC_GITCONFIG=$(call shelldquote,$(ETC_GITCONFIG))
 
 attr.sp attr.s attr.o: GIT-PREFIX
 attr.sp attr.s attr.o: EXTRA_CPPFLAGS = \
-	-DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
+	-DETC_GITATTRIBUTES=$(call shelldquote,$(ETC_GITATTRIBUTES))
 
 gettext.sp gettext.s gettext.o: GIT-PREFIX
 gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
@@ -2700,14 +2696,13 @@ perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
 	sed -e 's|@@LOCALEDIR@@|$(perl_localedir_SQ)|g' \
 	    -e 's|@@NO_GETTEXT@@|$(NO_GETTEXT_SQ)|g' \
-	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(NO_PERL_CPAN_FALLBACKS_SQ)|g' \
+	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(call shq,$(NO_PERL_CPAN_FALLBACKS))|g' \
 	< $< > $@
 
 all:: $(LIB_PERL_GEN)
 ifndef NO_PERL_CPAN_FALLBACKS
 all:: $(LIB_CPAN_GEN)
 endif
-NO_PERL_CPAN_FALLBACKS_SQ = $(subst ','\'',$(NO_PERL_CPAN_FALLBACKS))
 endif
 
 # install-man depends on Git.3pm even with NO_PERL=Y
@@ -3021,7 +3016,7 @@ else
 	$(INSTALL) $(vcpkg_dbg_bin)/*.pdb '$(DESTDIR_SQ)$(bindir_SQ)'
 endif
 endif
-	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
+	$(MAKE) -C templates DESTDIR=$(call shellquote,$(DESTDIR)) install
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 ifndef NO_GETTEXT
diff --git a/shared.mak b/shared.mak
index 2d597ef7603..ef03c2bc094 100644
--- a/shared.mak
+++ b/shared.mak
@@ -8,6 +8,20 @@
 #    info make --index-search=.DELETE_ON_ERROR
 .DELETE_ON_ERROR:
 
+### Quoting helpers
+
+## Quote a ' inside a '': FOO='$(call shq,$(BAR))'
+shq = $(subst ','\'',$(1))
+
+## Quote a ' and provide a '': FOO=$(call shq,$(BAR))
+shellquote = '$(call shq,$(1))'
+
+## Quote a " inside a ""
+shdq = $(subst ",\",$(1))
+
+## Quote ' for the shell, and embedded " for C: -DFOO=$(call shelldquote,$(BAR))
+shelldquote = '"$(call shdq,$(call shq,$(1)))"'
+
 ### Global variables
 
 ## comma, empty, space: handy variables as these tokens are either
diff --git a/t/Makefile b/t/Makefile
index 882d26eee30..4168b5c6ce6 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -1,3 +1,6 @@
+# Import tree-wide shared Makefile behavior and libraries
+include ../shared.mak
+
 # Run tests
 #
 # Copyright (c) 2005 Junio C Hamano
@@ -24,13 +27,6 @@ TEST_RESULTS_DIRECTORY = test-results
 CHAINLINTTMP = chainlinttmp
 endif
 
-# Shell quote;
-SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
-TEST_SHELL_PATH_SQ = $(subst ','\'',$(TEST_SHELL_PATH))
-PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
-TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
-CHAINLINTTMP_SQ = $(subst ','\'',$(CHAINLINTTMP))
-
 T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
 TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
 THELPERS = $(sort $(filter-out $(T),$(wildcard *.sh)))
@@ -44,38 +40,38 @@ test: pre-clean check-chainlint $(TEST_LINT)
 	$(MAKE) aggregate-results-and-cleanup
 
 failed:
-	@failed=$$(cd '$(TEST_RESULTS_DIRECTORY_SQ)' && \
+	@failed=$$(cd $(call shellquote,$(TEST_RESULTS_DIRECTORY)) && \
 		grep -l '^failed [1-9]' *.counts | \
 		sed -n 's/\.counts$$/.sh/p') && \
 	test -z "$$failed" || $(MAKE) $$failed
 
 prove: pre-clean check-chainlint $(TEST_LINT)
-	@echo "*** prove ***"; $(PROVE) --exec '$(TEST_SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
+	@echo "*** prove ***"; $(PROVE) --exec $(call shellquote,$(SHELL_PATH)) $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
 	$(MAKE) clean-except-prove-cache
 
 $(T):
-	@echo "*** $@ ***"; '$(TEST_SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
+	@echo "*** $@ ***"; $(call shellquote,$(SHELL_PATH)) $@ $(GIT_TEST_OPTS)
 
 pre-clean:
-	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
+	$(RM) -r $(call shellquote,$(TEST_RESULTS_DIRECTORY))
 
 clean-except-prove-cache: clean-chainlint
-	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
+	$(RM) -r 'trash directory'.* $(call shellquote,$(TEST_RESULTS_DIRECTORY))
 	$(RM) -r valgrind/bin
 
 clean: clean-except-prove-cache
 	$(RM) .prove
 
 clean-chainlint:
-	$(RM) -r '$(CHAINLINTTMP_SQ)'
+	$(RM) -r $(call shellquote,$(CHAINLINTTMP))
 
 check-chainlint:
-	@mkdir -p '$(CHAINLINTTMP_SQ)' && \
+	@mkdir -p $(call shellquote,$(CHAINLINTTMP)) && \
 	err=0 && \
 	for i in $(CHAINLINTTESTS); do \
 		$(CHAINLINT) <chainlint/$$i.test | \
-		sed -e '/^# LINT: /d' >'$(CHAINLINTTMP_SQ)'/$$i.actual && \
-		diff -u chainlint/$$i.expect '$(CHAINLINTTMP_SQ)'/$$i.actual || err=1; \
+		sed -e '/^# LINT: /d' >$(call shellquote,$(CHAINLINTTMP))/$$i.actual && \
+		diff -u chainlint/$$i.expect $(call shellquote,$(CHAINLINTTMP))/$$i.actual || err=1; \
 	done && exit $$err
 
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
@@ -92,7 +88,7 @@ test-lint-executable:
 		echo >&2 "non-executable tests:" $$bad; exit 1; }
 
 test-lint-shell-syntax:
-	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS) $(TPERF)
+	@$(call shellquote,$(PERL_PATH)) check-non-portable-shell.pl $(T) $(THELPERS) $(TPERF)
 
 test-lint-filenames:
 	@# We do *not* pass a glob to ls-files but use grep instead, to catch
@@ -107,9 +103,9 @@ aggregate-results-and-cleanup: $(T)
 	$(MAKE) clean
 
 aggregate-results:
-	for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
+	for f in $(call shellquote,$(TEST_RESULTS_DIRECTORY))/t*-*.counts; do \
 		echo "$$f"; \
-	done | '$(SHELL_PATH_SQ)' ./aggregate-results.sh
+	done | $(call shellquote,$(SHELL_PATH)) ./aggregate-results.sh
 
 gitweb-test:
 	$(MAKE) $(TGITWEB)
diff --git a/templates/Makefile b/templates/Makefile
index d22a71a3999..c9251a96622 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -1,3 +1,6 @@
+# Import tree-wide shared Makefile behavior and libraries
+include ../shared.mak
+
 # make and install sample templates
 
 ifndef V
@@ -18,13 +21,6 @@ ifndef PERL_PATH
 	PERL_PATH = perl
 endif
 
-SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
-PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
-
-# Shell quote (do not use $(call) to accommodate ancient setups);
-DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
-template_instdir_SQ = $(subst ','\'',$(template_instdir))
-
 all: boilerplates.made custom
 
 # Put templates that can be copied straight from the source
@@ -61,6 +57,6 @@ clean:
 	$(RM) -r blt boilerplates.made
 
 install: all
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
+	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(template_instdir))
 	(cd blt && $(TAR) cf - .) | \
-	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xof -)
+	(cd $(call shellquote,$(DESTDIR)$(template_instdir)) && umask 022 && $(TAR) xof -)
-- 
2.34.0.796.g2c87ed6146a

