Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B448C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3377A61414
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbhKPMHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbhKPMEn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:43 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D14C06122D
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:47 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p18so7327891wmq.5
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1i/4us0fqd5yE4+f5Re9OBE+HeZDqU80Yms9ZrDLOKM=;
        b=ms3Vm36WOeV24gJDYvhpe7ZNyIWwru0pqWOm8ofHZD+jHhxu0gc41BL0cutPOHWjei
         G+3chmSHlPYspkVOmuSI0L+a3KUQyW+MnjDgxjKbovjkc71MahFcPSmIOjrN1SupQigQ
         uQDeEB9ztrsPY2H2GG2gTQawpc9UaQsDDgpU3GWsM0wgwhcldgDLI/5ALWOhQkhZRyqJ
         XgC+ygZKnXQyCDNxbk8SyIbQD7ihcxWnsK6zivmjFb9pGzr974qdK0DvS92wunnZFQI/
         265qowwbNOYiHMc8dfdX5d4k0tvVJ8LW+w8MtPmnuv/d6nftBS7JQtKp9QAecMcAvAU3
         oEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1i/4us0fqd5yE4+f5Re9OBE+HeZDqU80Yms9ZrDLOKM=;
        b=HqoU9IbRhXBATSvH68EiZGFHk5FVq/utbdHLQWxgPMlAGoLFhEzX9IRTo9D+LETGjc
         FBtjFDu0eCgH+aQ09IDDQVvUoESuomp7x0dqxzlZFrMijdOzt418OvxrsnZx4r/bNgiM
         bJRGmUsjOGyHbEgRy70QU/JJXfVw7NmAI2wuKRWsRQsqdwuQ2+5IoUqvvzWXU7TTfN6/
         Ca6rywm5EhxUbu/tHd5x1gDApsiqt/HDpLilqTKQ068VbvJtQL43Zy4/qQF5Xe6WlsCw
         alqtW2G0dIeD+rjbudoRDpN1c2spiB/WOlQp+70cMtv/Hl0U/kowzd9L74lw9y4JMwks
         gUKA==
X-Gm-Message-State: AOAM5327l9CP52Ezcf9FT2HFhc2tJNk3kccIpC5a1qqr3SULHARBgaxM
        KC05oeU1Udap3v+4ZaYuYUZsj1/cCoeRbQ==
X-Google-Smtp-Source: ABdhPJy6FscMfu8SFDfODvQ0Xvxy/rumUGFoaiKOTeLVrmtdmWolPlHcbNLI2HEsuBnOYaxSbWeRuA==
X-Received: by 2002:a05:600c:500b:: with SMTP id n11mr53918065wmr.38.1637064046064;
        Tue, 16 Nov 2021 04:00:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 14/23] Makefile: re-add and use the "shellquote" macros
Date:   Tue, 16 Nov 2021 13:00:14 +0100
Message-Id: <patch-v3-14.23-e811a907b08-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
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
2.34.0.795.g1e9501ab396

