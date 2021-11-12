Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BF0C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF2860F36
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbhKLVv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhKLVv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:51:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C17C061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:07 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r8so17810543wra.7
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/OkUquhE60JoSve4lqRTuuoyN7CNgdMwnAV3IfTo78=;
        b=D8p0SUnBhCVBgHb27jpdoZxbn5g6+rd1RTUJDKeGczF/XF2kkjEeiJJ+BZU+J3yjiN
         kVUt5Sfxm0LypESCGKDF92fUhWyCmcoMFly77b1Jc8Lm/ggqzujWJe6qCVUG0XqCDP/t
         lSrrJcylWQR3ZUBiAy7/z5X2/vJdrEfZozlQ3TMRqhEZnKehDdWZmRulYhfKDCRPJSq8
         Zht4/3VfwnBEUwB9U5yPFe5lX9vhRF6CfTc2C4d7+JypK4YyzrMl6qd6qVXTxGdzesjr
         0W6FeZQr2GEPmpNUFnkn/A1fTnxjQdb3dYcrsUz9G8HXKt57QdEHuzcH95yWRTKAgyt1
         az7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/OkUquhE60JoSve4lqRTuuoyN7CNgdMwnAV3IfTo78=;
        b=u+WFJoyYTEeCef6YMpRwAEx1L73SZGSfWndF4FKLBXs6Okg+Atk3Ci4Uzf8malgusH
         BUt4zb9Pk4GAJOdo2PJiIs5xUCp+3VO25MkKrW1XXNgIAA9MAH5F9ic9kG7GcxdSdzX1
         bdS/Zzxg3k0CSv1dIJVkchfHsjR12DEqb5manivPvguUtVvDssx6+jHAY0B7reK+Sn/K
         0w6EDtMyzeUtC9oHlEM3WsVbLv5m/f1BxsCYGXcMQJHbBKGyhrlqAklpkHsaVVG7Treb
         npGUEmJmKhfm1G9Li4UpNRnWBOhJYooFkiIfk5UX56ZQ2R6uTI19rKZkA/TLDjAqMDvy
         sOlA==
X-Gm-Message-State: AOAM530jy4QvPZkyB1asx1C0NQ6vOMcSpDVg8ob32fOpVB7f63vYj2su
        ZMHZ5I6MRzlOmH9AMVTvbL9th6Z9qB0ZUw==
X-Google-Smtp-Source: ABdhPJyuqfuMOuMGR70hDaCvZnOXDYpaVssCfBXiIVVjEem2C4CmFnc7bkqXtmZmwD4iNvj9n0ypNA==
X-Received: by 2002:adf:e109:: with SMTP id t9mr21456626wrz.387.1636753745067;
        Fri, 12 Nov 2021 13:49:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:49:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/18] Makefiles: dependency correctness & speedup
Date:   Fri, 12 Nov 2021 22:48:44 +0100
Message-Id: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series to correct various issues in the Makefile. This goes
on top of my ab/sh-retire-helper-functions sitting in "next". For a
more (and mostly-up-to-date) generic summary see v1 at [1]. Changes
noted below.

As noted in 18/18 there's a noticable speedup and simplification in
this series.

1. https://lore.kernel.org/git/cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (18):
  Makefile: don't invoke msgfmt with --statistics
  Makefile: don't set up "perl/build" rules under NO_PERL=Y
  Makefile: use "=" not ":=" for po/* and perl/*
  Makefile: clean perl/build/ even with NO_PERL=Y
  Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
  Makefile: guard Perl-only variable assignments
  Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
  Makefile: adjust Perl-related comments & whitespace
  Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
  Makefile: create a GIT-PYTHON-DEFINES, like "PERL"

I corrected pointed-out issues here, dropped some of the changes to
reduce churn, and split up other things to reduce the diff size.

The issue with perl_localedir_SQ being overridable from the
environment is fixed here.

I also inverted an if condition in v1 so we'd inject the "localedir"
into the Perl scripts in cases where we shouldn't. It didn't end up
mattering since since we'd ignore it anyway with RUN_PREFIX, but let's
not do that.

  Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
  Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
  Makefile: move $(comma), $(empty) and $(space) to shared.mak
  Makefile: re-add and use the "shellquote" macros
  Makefile: add a "TRACK_template" for GIT-*{FLAGS,DEFINES,...}
  Makefile: add "$(QUIET)" boilerplate to shared.mak
  Makefile: use $(wspfx) for $(QUIET...) in shared.mak
  Makefiles: add and use wildcard "mkdir -p" template

 .gitignore             |   2 +-
 Documentation/Makefile |  71 ++----------
 Makefile               | 254 ++++++++++++++---------------------------
 config.mak.uname       |   1 -
 git-cvsserver.perl     |   6 +-
 git-send-email.perl    |   7 +-
 git-svn.perl           |   2 +-
 shared.mak             | 113 ++++++++++++++++++
 t/Makefile             |  34 +++---
 templates/Makefile     |  19 +--
 10 files changed, 235 insertions(+), 274 deletions(-)
 create mode 100644 shared.mak

Range-diff against v1:
16:  7f1081651ed =  1:  75ebf7b04e5 Makefile: don't invoke msgfmt with --statistics
 1:  56acc94dfe7 =  2:  138f60ba37b Makefile: don't set up "perl/build" rules under NO_PERL=Y
 -:  ----------- >  3:  472e1eb74bd Makefile: use "=" not ":=" for po/* and perl/*
 2:  2d8049f792c =  4:  a5ce2dce164 Makefile: clean perl/build/ even with NO_PERL=Y
 3:  fa2f10a0cd1 =  5:  04dbc1d2809 Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
 4:  5affe94b05f !  6:  eea89794493 Makefile: move Perl-only variable assignments under !NO_PERL
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    Makefile: move Perl-only variable assignments under !NO_PERL
    +    Makefile: guard Perl-only variable assignments
     
    -    Move the assignment to perl_localedir_SQ to be guarded by NO_PERL, and
    -    furthermore only assign to it if RUNTIME_PREFIX is in effect. If the
    -    latter isn't being used then we'll default to the empty string, so
    -    there was no need for the second assignment added in
    -    07d90eadb50 (Makefile: add Perl runtime prefix support, 2018-04-10).
    -
    -    Similarly, we can move the PERL_HEADER_TEMPLATE assignment inside the
    -    "!NO_PERL" block, and having simplified all of this let's consolidate
    -    three comments on this control flow into one.
    +    Move the "ifndef NO_PERL" a few lines earlier to encompass the
    +    "perl_localedir_SQ" variable. We'll only use it under !NO_PERL.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Makefile: git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
      # This makes sure we depend on the NO_PERL setting itself.
      $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
      
    --# Used for substitution in Perl modules. Disabled when using RUNTIME_PREFIX
    --# since the locale directory is injected.
    --perl_localedir_SQ = $(localedir_SQ)
    --
    - ifndef NO_PERL
    --PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
    ++ifndef NO_PERL
    + # Used for substitution in Perl modules. Disabled when using RUNTIME_PREFIX
    + # since the locale directory is injected.
    + perl_localedir_SQ = $(localedir_SQ)
    + 
    +-ifndef NO_PERL
    + PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
      PERL_DEFINES =
      PERL_DEFINES += $(PERL_PATH_SQ)
    - PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
    -@@ Makefile: PERL_DEFINES += $(RUNTIME_PREFIX)
    - PERL_DEFINES += $(NO_PERL_CPAN_FALLBACKS)
    - PERL_DEFINES += $(NO_GETTEXT)
    - 
    --# Support Perl runtime prefix. In this mode, a different header is installed
    --# into Perl scripts.
    -+# Under RUNTIME_PREFIX we inject a header into the Perl scripts; If
    -+# NO_GETTEXT is not defined we'll make use of the localedir.
    - ifdef RUNTIME_PREFIX
    --
    - PERL_HEADER_TEMPLATE = perl/header_templates/runtime_prefix.template.pl
    --
    --# Don't export a fixed $(localedir) path; it will be resolved by the Perl header
    --# at runtime.
    --perl_localedir_SQ =
    --
    -+ifndef NO_GETTEXT
    -+perl_localedir_SQ = $(localedir_SQ)
    -+endif
    -+else
    -+PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
    - endif
    - 
    - PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
 -:  ----------- >  7:  e06732d4639 Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
 5:  d8e14cb723d !  8:  a9502a23989 Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
    +    Makefile: adjust Perl-related comments & whitespace
     
    -    Fix several small issues with the dependency graph of the generated
    -    "GIT-PERL-DEFINES" and "GIT-PERL-HEADER" files:
    -
    -    1. Folllow-up my 4070c9e09fc (Makefile: don't re-define PERL_DEFINES,
    -       2021-05-05) and move the rest of the assignments to PERL_DEFINES to
    -       one place, and change it from depending on "localedir_relative_SQ"
    -       instead of "localedir".
    -
    -       The former is what we'll actually use, and while it's unlikely to
    -       matter in practice (we'd just skip re-building these under
    -       RUNTIME_PREFIX if the relative path was the same) it makes it
    -       clearer what's going on here by bringing us to a 1=1 mapping of
    -       these variables and what's subsequently used in the
    -       "GIT-PERL-DEFINES", "GIT-PERL-HEADER" and "perl/build/lib/%.pm"
    -       rules below.
    -
    -    2. We don't need the substitution of " " for ":" added in
    -       07d90eadb50 (Makefile: add Perl runtime prefix support, 2018-04-10),
    -       let's drop it. This doesn't matter for the correctness of these files,
    -       but makes it clear  that (unlike GIT-BUILD-OPTIONS) they are not
    -
    -    3. Don't have "GIT-PERL-HEADER" depend on the "Makefile". That was a
    -       lazy way to over-declare the dependencies added in
    -       f6a0ad4be71 (Makefile: generate Perl header from template file,
    -       2018-04-10), now that our dependency graph is correct we can be
    -       confident in dropping it.
    +    Folllow-up my 4070c9e09fc (Makefile: don't re-define PERL_DEFINES,
    +    2021-05-05) and move the rest of the assignments to PERL_DEFINES to
    +    one place.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    -@@ Makefile: $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
    +@@ Makefile: PERL_DEFINES += $(perllibdir_SQ)
    + PERL_DEFINES += $(RUNTIME_PREFIX)
    + PERL_DEFINES += $(NO_PERL_CPAN_FALLBACKS)
    + PERL_DEFINES += $(NO_GETTEXT)
    ++PERL_DEFINES += $(gitexecdir)
    ++PERL_DEFINES += $(perllibdir)
    ++PERL_DEFINES += $(localedir)
    ++PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
      
    - ifndef NO_PERL
    - PERL_DEFINES =
    -+PERL_DEFINES += $(gitexecdir_relative_SQ)
    -+PERL_DEFINES += $(perllibdir_relative_SQ)
    -+PERL_DEFINES += $(localedir_relative_SQ)
    - PERL_DEFINES += $(PERL_PATH_SQ)
    - PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
    - PERL_DEFINES += $(perllibdir_SQ)
    -@@ Makefile: else
    - PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
    +-# Support Perl runtime prefix. In this mode, a different header is installed
    +-# into Perl scripts.
    + ifdef RUNTIME_PREFIX
    +-
    + PERL_HEADER_TEMPLATE = perl/header_templates/runtime_prefix.template.pl
    + 
    +-# Don't export a fixed $(localedir) path; it will be resolved by the Perl header
    +-# at runtime.
    ++# The RUNTIME_PREFIX header defines $Git::I18N::TEXTDOMAINDIR, so
    ++# $(perl_localedir_SQ) won't be needed
    + perl_localedir_SQ =
    +-
      endif
      
     -PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
    @@ Makefile: $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VE
      GIT-PERL-DEFINES: FORCE
      	@FLAGS='$(PERL_DEFINES)'; \
      	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
    -@@ Makefile: GIT-PERL-DEFINES: FORCE
    - 		echo "$$FLAGS" >$@; \
    - 	    fi
    - 
    --GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
    -+GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES
    - 	$(QUIET_GEN) \
    - 	INSTLIBDIR='$(perllibdir_SQ)' && \
    - 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
 6:  03290125c45 !  9:  c1336fc0a56 Makefile: don't have Perl over-depend on GIT-BUILD-OPTIONS
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    Makefile: don't have Perl over-depend on GIT-BUILD-OPTIONS
    +    Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
     
    -    Change the dependency on "GIT-BUILD-OPTIONS" used by
    -    e.g. "git-send-email" to be on "GIT-PERL-DEFINES instead.
    +    Fix several small issues with the dependency graph of the generated
    +    "GIT-PERL-DEFINES" and "GIT-PERL-HEADER" files:
     
    -    The reason for depending on "GIT-BUILD-OPTIONS" was to trigger a
    -    re-build if NO_PERL=Y was defined, we can instead add that variable to
    -    "PERL_DEFINES", and have "GIT-PERL-DEFINES" created and updated if
    -    "NO_PERL=Y" is defined.
    +    1. Don't have "GIT-PERL-HEADER" depend on the "Makefile". That was a
    +       lazy way to over-declare the dependencies added in
    +       f6a0ad4be71 (Makefile: generate Perl header from template file,
    +       2018-04-10). Let's correct our dependency graph instead.
    +
    +    2. Don't have $(SCRIPT_PERL_GEN) (such as "git-send-email") depend on
    +       GIT-BUILD-OPTIONS. Let's instead use GIT-PERL-DEFINES.
    +
    +       The reason for depending on "GIT-BUILD-OPTIONS" was to trigger a
    +       re-build if NO_PERL=Y was defined. We can instead add that variable
    +       to "PERL_DEFINES", and have "GIT-PERL-DEFINES" created and updated
    +       if "NO_PERL=Y" is defined.
    +
    +    3. Due to #2 we'll need to have GIT-PERL-DEFINES be generated even
    +       under NO_PERL, since that variable will be used by the
    +       "unimplemented.sh" script.
    +
    +    4. Don't depend on $(gitexecdir), $(perllibdir) and $(localedir),
    +       instead depend on the $(*_relative_SQ) versions of those.
    +
    +       The latter is what we'll actually use, while it's unlikely to
    +       matter in practice (we'd just skip re-building these under
    +       RUNTIME_PREFIX if the relative path was the same) it makes the code
    +       easier to read.
    +
    +       That's because this brings us to a 1=1 mapping of these variables
    +       and what's subsequently used in the "GIT-PERL-DEFINES",
    +       "GIT-PERL-HEADER" and "perl/build/lib/%.pm" rules below.
    +
    +    5. We don't need the substitution of " " for ":" added in
    +       07d90eadb50 (Makefile: add Perl runtime prefix support,
    +       2018-04-10), let's drop it. This doesn't matter for the correctness
    +       of these files, because unlike GIT-BUILD-OPTIONS nothing is
    +       consuming them except the Makefile itself.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Makefile: git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
      
     -# This makes sure we depend on the NO_PERL setting itself.
     -$(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
    --
    --ifndef NO_PERL
     +# Under NO_PERL=Y we'll still make GIT-PERL-DEFINES. We need to depend
     +# on NO_PERL=Y itself for creating "unimplemented.sh" scripts.
    - PERL_DEFINES =
    ++PERL_DEFINES =
     +$(SCRIPT_PERL_GEN): GIT-PERL-DEFINES
    -+ifdef NO_PERL
    + 
    + ifdef NO_PERL
     +PERL_DEFINES += $(NO_PERL)
     +
    -+$(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
    -+	$(QUIET_GEN) \
    -+	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
    -+	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
    -+	    unimplemented.sh >$@+ && \
    -+	chmod +x $@+ && \
    -+	mv $@+ $@
    + $(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
    + 	$(QUIET_GEN) \
    + 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
    +@@ Makefile: $(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
    + 	chmod +x $@+ && \
    + 	mv $@+ $@
    + else # NO_PERL
    +-# Used for substitution in Perl modules. Disabled when using RUNTIME_PREFIX
    +-# since the locale directory is injected.
    ++# The localedir is only used in Perl modules if !NO_GETTEXT
    ++ifndef NO_GETTEXT
    + perl_localedir_SQ = $(localedir_SQ)
    ++endif
    + 
    + PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
    +-PERL_DEFINES =
    ++
    + PERL_DEFINES += $(PERL_PATH_SQ)
    + PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
    + PERL_DEFINES += $(perllibdir_SQ)
    + PERL_DEFINES += $(RUNTIME_PREFIX)
    + PERL_DEFINES += $(NO_PERL_CPAN_FALLBACKS)
    + PERL_DEFINES += $(NO_GETTEXT)
    +-PERL_DEFINES += $(gitexecdir)
    +-PERL_DEFINES += $(perllibdir)
    +-PERL_DEFINES += $(localedir)
    +-PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
    ++ifdef RUNTIME_PREFIX
    ++PERL_DEFINES += $(gitexecdir_relative_SQ)
    ++PERL_DEFINES += $(perllibdir_relative_SQ)
    ++PERL_DEFINES += $(localedir_relative_SQ)
     +else
    - PERL_DEFINES += $(gitexecdir_relative_SQ)
    - PERL_DEFINES += $(perllibdir_relative_SQ)
    - PERL_DEFINES += $(localedir_relative_SQ)
    ++PERL_DEFINES += $(perllocaledir_SQ)
    ++endif
    + 
    + ifdef RUNTIME_PREFIX
    + PERL_HEADER_TEMPLATE = perl/header_templates/runtime_prefix.template.pl
     @@ Makefile: $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
      	chmod +x $@+ && \
      	mv $@+ $@
    @@ Makefile: $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VE
     -		echo "$$FLAGS" >$@; \
     -	    fi
     -
    - GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES
    +-GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
    ++GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES
      	$(QUIET_GEN) \
      	INSTLIBDIR='$(perllibdir_SQ)' && \
    + 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
     @@ Makefile: git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
    - 	$(QUIET_GEN)$(cmd_munge_script) && \
    - 	chmod +x $@+ && \
      	mv $@+ $@
    --else # NO_PERL
    --$(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
    --	$(QUIET_GEN) \
    --	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
    --	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
    --	    unimplemented.sh >$@+ && \
    --	chmod +x $@+ && \
    --	mv $@+ $@
      endif # NO_PERL
      
     +GIT-PERL-DEFINES: FORCE
 7:  24c8f42aa7d ! 10:  41f65a12205 Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
    @@ Commit message
         As with Perl, there's no real reason to depend on GIT-BUILD-OPTIONS or
         GIT-CFLAGS when building the Python code, nor did we need
         GIT-PREFIX. Let's instead add those variables we care about to a
    -    "GIT-PYTHON-DEFINES".
    +    "GIT-PYTHON-DEFINES" and depend on that.
     
         This changes code originally added in ca3bcabf118 (auto-detect changed
         prefix and/or changed build flags, 2006-06-15), and adjusted in
    @@ Makefile: GIT-PERL-DEFINES: FORCE
      
     -# This makes sure we depend on the NO_PYTHON setting itself.
     -$(SCRIPT_PYTHON_GEN): GIT-BUILD-OPTIONS
    -+# Under NO_PERL=Y we'll still make GIT-PERL-DEFINES. We need to depend
    -+# on NO_PERL=Y itself for creating "unimplemented.sh" scripts.
    ++# As with NO_PERL=Y we'll still make GIT-PYTHON-DEFINES if "NO_PYTHON"
    ++# is defined, for creating the "unimplemented.sh" scripts.
     +PYTHON_DEFINES =
     +$(SCRIPT_PYTHON_GEN): GIT-PYTHON-DEFINES
    ++
     +ifdef NO_PYTHON
     +PYTHON_DEFINES += $(SHELL_PATH_SQ)
     +PYTHON_DEFINES += $(NO_PYTHON)
    @@ Makefile: $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
      	    unimplemented.sh >$@+ && \
      	chmod +x $@+ && \
      	mv $@+ $@
    --endif # NO_PYTHON
    -+else
    ++else # NO_PYTHON
     +PYTHON_DEFINES += $(PYTHON_PATH_SQ)
     +
    -+$(SCRIPT_PYTHON_GEN): % : %.py
    ++$(SCRIPT_PYTHON_GEN): % : %.py GIT-PYTHON-DEFINES
     +	$(QUIET_GEN) \
     +	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
     +	    $< >$@+ && \
     +	chmod +x $@+ && \
     +	mv $@+ $@
    -+endif # PYTHON
    -+
    + endif # NO_PYTHON
    + 
     +GIT-PYTHON-DEFINES: FORCE
     +	@FLAGS='$(PYTHON_DEFINES)'; \
     +	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
     +		echo >&2 "    * new python-specific parameters"; \
     +		echo "$$FLAGS" >$@; \
     +	    fi
    - 
    ++
      CONFIGURE_RECIPE = sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
      			configure.ac >configure.ac+ && \
    + 		   autoconf -o configure configure.ac+ && \
     @@ Makefile: else
      endif
      	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
 8:  e3b52cf8da5 ! 11:  bfa15059d60 Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    -@@ Makefile: else
    - PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
    +@@ Makefile: PERL_HEADER_TEMPLATE = perl/header_templates/runtime_prefix.template.pl
    + perl_localedir_SQ =
      endif
      
     -$(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 9:  e23663bfb20 = 12:  656d02ab641 Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
10:  67ba72dc2e6 = 13:  6e25ac71cbc Makefile: move $(comma), $(empty) and $(space) to shared.mak
11:  67dbad03c14 = 14:  64296e6e8e5 Makefile: re-add and use the "shellquote" macros
12:  5930a08cb4e ! 15:  5654d7f7f29 Makefile: add a "TRACK_template" for GIT-*{FLAGS,DEFINES,...}
    @@ Makefile: git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
     -	    fi
     +$(eval $(call TRACK_template,GIT-PERL-DEFINES,PERL_DEFINES))
      
    - # Under NO_PERL=Y we'll still make GIT-PERL-DEFINES. We need to depend
    - # on NO_PERL=Y itself for creating "unimplemented.sh" scripts.
    -@@ Makefile: $(SCRIPT_PYTHON_GEN): % : %.py
    + # As with NO_PERL=Y we'll still make GIT-PYTHON-DEFINES if "NO_PYTHON"
    + # is defined, for creating the "unimplemented.sh" scripts.
    +@@ Makefile: $(SCRIPT_PYTHON_GEN): % : %.py GIT-PYTHON-DEFINES
      	mv $@+ $@
    - endif # PYTHON
    + endif # NO_PYTHON
      
     -GIT-PYTHON-DEFINES: FORCE
     -	@FLAGS='$(PYTHON_DEFINES)'; \
13:  d927202fb89 ! 16:  0a348b54491 Makefile: add "$(QUIET)" boilerplate to shared.mak
    @@ config.mak.uname: vcxproj:
      
     
      ## shared.mak ##
    -@@ shared.mak: $(1): FORCE
    - 		echo "$$$$FLAGS" >$(1); \
    - 	fi
    - endef
    -+
    +@@ shared.mak: space = $(empty) $(empty)
    + wspfx = $(space)$(space)$(space)
    + wspfx_sq = $(call shellquote,$(wspfx))
    + 
     +### Quieting
     +## common
     +QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
    @@ shared.mak: $(1): FORCE
     +	export V
     +endif
     +endif
    ++
    + ### Templates
    + 
    + ## Template for making a GIT-SOMETHING, which changes if a
     
      ## templates/Makefile ##
     @@
14:  2966218d6c8 = 17:  34f692144d1 Makefile: use $(wspfx) for $(QUIET...) in shared.mak
15:  412a11f63a3 ! 18:  5b3986bc4a8 Makefiles: add and use wildcard "mkdir -p" template
    @@ Commit message
     
         But as it turns out we can use this neat trick of only doing a "mkdir
         -p" if the $(wildcard) macro tells us the path doesn't exist. A re-run
    -    of the performance test I noted downthread of [1] in [2] shows that
    -    this is faster, in addition to being less verbose and more reliable:
    +    of a performance test similar to thatnoted downthread of [1] in [2]
    +    shows that this is faster, in addition to being less verbose and more
    +    reliable (this uses my "git-hyperfine" thin wrapper for "hyperfine"[3]):
     
    -        $ hyperfine --warmup 5 -m 30 -L s ",~" -p 'git checkout HEAD{s} -- Makefile; rm -rf .build' 'make -j8 lint-docs R={s}'
    -         -c 'git checkout HEAD -- Makefile'
    -        Benchmark #1: make -j8 lint-docs R=
    -          Time (mean ± σ):     537.5 ms ±   7.1 ms    [User: 2.412 s, System: 0.460 s]
    -          Range (min … max):   530.2 ms … 564.9 ms    30 runs
    +        $ git hyperfine -L rev HEAD~0,HEAD~1 -b 'make -C Documentation lint-docs' -p 'rm -rf Documentation/.build' 'make -C Documentation lint-docs'
    +        Benchmark 1: make -C Documentation lint-docs' in 'HEAD~0
    +          Time (mean ± σ):      2.129 s ±  0.011 s    [User: 1.840 s, System: 0.321 s]
    +          Range (min … max):    2.121 s …  2.158 s    10 runs
     
    -        Benchmark #2: make -j8 lint-docs R=~
    -          Time (mean ± σ):     645.7 ms ±   7.1 ms    [User: 3.083 s, System: 0.630 s]
    -          Range (min … max):   637.4 ms … 675.2 ms    30 runs
    +        Benchmark 2: make -C Documentation lint-docs' in 'HEAD~1
    +          Time (mean ± σ):      2.659 s ±  0.002 s    [User: 2.306 s, System: 0.397 s]
    +          Range (min … max):    2.657 s …  2.662 s    10 runs
     
             Summary
    -          'make -j8 lint-docs R=' ran
    -            1.20 ± 0.02 times faster than 'make -j8 lint-docs R=~'
    +          'make -C Documentation lint-docs' in 'HEAD~0' ran
    +            1.25 ± 0.01 times faster than 'make -C Documentation lint-docs' in 'HEAD~1'
     
         So let's use that pattern both for the "lint-docs" target, and a few
         miscellaneous other targets.
    @@ Commit message
     
         1. https://lore.kernel.org/git/211028.861r45y3pt.gmgdl@evledraar.gmail.com/
         2. https://lore.kernel.org/git/211028.86o879vvtp.gmgdl@evledraar.gmail.com/
    +    3. https://gitlab.com/avar/git-hyperfine/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Makefile: all:: $(MOFILES)
     +	$(QUIET_MSGFMT)$(MSGFMT) -o $@ $<
      
      ifndef NO_PERL
    - LIB_PERL := $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
    -@@ Makefile: LIB_CPAN := $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
    - LIB_CPAN_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_CPAN))
    + LIB_PERL = $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
    +@@ Makefile: LIB_CPAN = $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
    + LIB_CPAN_GEN = $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_CPAN))
      
      perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
     -	$(QUIET_GEN)mkdir -p $(dir $@) && \
    @@ shared.mak: ifndef V
      	QUIET_CC       = @echo $(wspfx_sq) CC $@;
      	QUIET_AR       = @echo $(wspfx_sq) AR $@;
     @@ shared.mak: ifndef V
    - 	export V
      endif
      endif
    -+
    + 
     +## Helpers
     +define mkdir_p_parent_template
     +$(if $(wildcard $(@D)),,$(QUIET_MKDIR_P_PARENT)$(shell mkdir -p $(@D)))
     +endef
    ++
    + ### Templates
    + 
    + ## Template for making a GIT-SOMETHING, which changes if a
-- 
2.34.0.rc2.795.g926201d1cc8

