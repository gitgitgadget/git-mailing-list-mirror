Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A390C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 08:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC9C61DD8
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 08:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhF2Ir1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 04:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhF2Ir0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 04:47:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FFBC061574
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 01:44:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p8so8685453wrr.1
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 01:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fAOtn+6w4vUvoDVfmWdGfGPtLmwX+BjWkPNCVfPY0Qo=;
        b=XN18SJpo++D4/ZqBKZy85xWpc+NIpYWm9PtFeZ9UUY6MEFtjzT3XR8kPxdbaKe3Cji
         Qyu7Li2zXw+uJKvAkHFJMUnX+en2TO/lPVp5znhDpsFxZl07T7wVwzYMbwEeWsek+i2B
         lCmKK/Jj9DbgmGqDS4qEBYoPXmnD3WMQ0ERa6PrbCZQmjr7jXU6EpIqEo/R0ccIfegfN
         lZCLNONIUullQhyWl5BAZ8bPrj0S+3cn/0PwoG7TBxv1kkP5ajVoZq2mrRMk5Q2JK2Z0
         KaHc1CC/XIszMyNoUvZHeD6lDCzOUiOMpRtVdilYn0rBizPAzwZf9CV1+mvay5uOezqq
         MQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fAOtn+6w4vUvoDVfmWdGfGPtLmwX+BjWkPNCVfPY0Qo=;
        b=nSjKANKQ7FuwoTXejhaSmdujqYloiBLUvQPyyRBj1Qnjip9sEVeYk3fGQppQYsm/TA
         qaiRmbpM8Bhof8YX343tavH8brffQXnHaS6/pax361/i/Gb3GCGikQ8wB6H7i2nTS7Wv
         EJCbAtwQ4layplNxtQAU+f6JXBh3UoiHALl+Up9aCRpUVekA4e/088ZS279odjOLARZv
         U5cGwvdYTdIIQOm12cq8KteBZTd2PTlmaLlcv/D6WMDB9X1ZgR6qUBeTIm3CUl2BuD7f
         phMEMgwtj3wI643Zh/B1gJUWE9m84gZbLORdpPIkjKb5RIGMdqNPgZsRCKDdO6U82/HI
         9OwA==
X-Gm-Message-State: AOAM5313g7pKEItML2I6j+6+Cm0P9uja48sBI6CV8CdLqA0S2DdZqmAU
        0PMQcnphunAZZNFraGrEuBeHQ6EPPUzfjQ==
X-Google-Smtp-Source: ABdhPJz56586IoSmoXGcrZ8EoHJ8xkCIuWmqrCqhFGVl3XimRfroRULdd/6eTgqcm+aOimAhWFRvaw==
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr11327637wrc.183.1624956298100;
        Tue, 29 Jun 2021 01:44:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t128sm2157642wma.41.2021.06.29.01.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 01:44:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] Makefile: add and use the ".DELETE_ON_ERROR" flag
Date:   Tue, 29 Jun 2021 10:44:50 +0200
Message-Id: <patch-1.1-2557117855-20210629T084356Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.613.g20d5ce26552
In-Reply-To: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the GNU make ".DELETE_ON_ERROR" flag in our main Makefile, as we
already do in the Documentation/Makefile since db10fc6c09f (doc:
simplify Makefile using .DELETE_ON_ERROR, 2021-05-21).

Now if a command to make X fails X will be removed, the default
behavior of GNU make is to only do so if "make" itself is interrupted
with a signal.

E.g. if we now intentionally break one of the rules with:

    -       mv $@+ $@
    +       mv $@+ $@ && \
    +       false

We'll get output like:

    $ make git
        CC git.o
        LINK git
    make: *** [Makefile:2179: git] Error 1
    make: *** Deleting file 'git'
    $ file git
    git: cannot open `git' (No such file or directory)

Before this change we'd leave the file in place in under this
scenario.

As in db10fc6c09f this allows us to remove patterns of removing
leftover $@ files at the start of rules, since previous failing runs
of the Makefile won't have left those littered around anymore.

I'm not as confident that we should be replacing the "mv $@+ $@"
pattern entirely, since that means that external programs or one of
our other Makefiles might race and get partial content.

I'm not changing $(REMOTE_CURL_ALIASES) since that uses a ln/ln -s/cp
dance, and would require the addition of "-f" flags if the "rm" at the
start was removed. I've also got plans to fix that ln/ln -s/cp pattern
in another series.

For $(LIB_FILE) and $(XDIFF_LIB) we can rely on the "c" (create) being
present in ARFLAGS.

I'm not changing "$(ETAGS_TARGET)", "tags" and "cscope" because
they've got a messy combination of removing "$@+" not "$@" at the
beginning, or "$@*". I'm also addressing those in another series.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

The large thread on v1 is mostly/entirely a digression about an
earlier patch series of mine not directly applicable to the change
here. Felipe feedback about "why not change these rules too?" which
I've incorporated into the commit message, and fixed the omission of a
change to the $(XDIFF_LIB) rule.

Range-diff against v1:
1:  9420448e74 ! 1:  2557117855 Makefile: add and use the ".DELETE_ON_ERROR" flag
    @@ Commit message
         pattern entirely, since that means that external programs or one of
         our other Makefiles might race and get partial content.
     
    +    I'm not changing $(REMOTE_CURL_ALIASES) since that uses a ln/ln -s/cp
    +    dance, and would require the addition of "-f" flags if the "rm" at the
    +    start was removed. I've also got plans to fix that ln/ln -s/cp pattern
    +    in another series.
    +
    +    For $(LIB_FILE) and $(XDIFF_LIB) we can rely on the "c" (create) being
    +    present in ARFLAGS.
    +
    +    I'm not changing "$(ETAGS_TARGET)", "tags" and "cscope" because
    +    they've got a messy combination of removing "$@+" not "$@" at the
    +    beginning, or "$@*". I'm also addressing those in another series.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    @@ Makefile: endif
      	$(QUIET_GEN)sed -e '1s/^/[/' -e '$$s/,$$/]/' $(compdb_dir)/*.o.json > $@+
      	@if test -s $@+; then mv $@+ $@; else $(RM) $@+; fi
      endif
    +@@ Makefile: $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
    + 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
    + 
    + $(LIB_FILE): $(LIB_OBJS)
    +-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
    ++	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $^
    + 
    + $(XDIFF_LIB): $(XDIFF_OBJS)
    +-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
    ++	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $^
    + 
    + export DEFAULT_EDITOR DEFAULT_PAGER
    + 

 Makefile | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index c3565fc0f8..157293b555 100644
--- a/Makefile
+++ b/Makefile
@@ -2160,6 +2160,16 @@ shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $^
 
+### Flags affecting all rules
+
+# A GNU make extension since gmake 3.72 (released in late 1994) to
+# remove the target of rules if commands in those rules fail. The
+# default is to only do that if make itself receives a signal. Affects
+# all targets, see:
+#
+#    info make --index-search=.DELETE_ON_ERROR
+.DELETE_ON_ERROR:
+
 ### Target-specific flags and dependencies
 
 # The generic compilation pattern rule and automatically
@@ -2243,7 +2253,6 @@ SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
 	$(perllibdir_SQ)
 define cmd_munge_script
-$(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
     -e 's|@@DIFF@@|$(DIFF_SQ)|' \
@@ -2313,7 +2322,7 @@ endif
 PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
 
 $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
-	$(QUIET_GEN)$(RM) $@ $@+ && \
+	$(QUIET_GEN) \
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e '	r GIT-PERL-HEADER' \
@@ -2333,7 +2342,7 @@ GIT-PERL-DEFINES: FORCE
 	    fi
 
 GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
-	$(QUIET_GEN)$(RM) $@ && \
+	$(QUIET_GEN) \
 	INSTLIBDIR='$(perllibdir_SQ)' && \
 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
 	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
@@ -2359,7 +2368,7 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
 	mv $@+ $@
 else # NO_PERL
 $(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
-	$(QUIET_GEN)$(RM) $@ $@+ && \
+	$(QUIET_GEN) \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
 	    unimplemented.sh >$@+ && \
@@ -2373,14 +2382,14 @@ $(SCRIPT_PYTHON_GEN): GIT-BUILD-OPTIONS
 ifndef NO_PYTHON
 $(SCRIPT_PYTHON_GEN): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
 $(SCRIPT_PYTHON_GEN): % : %.py
-	$(QUIET_GEN)$(RM) $@ $@+ && \
+	$(QUIET_GEN) \
 	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
 	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PYTHON
 $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
-	$(QUIET_GEN)$(RM) $@ $@+ && \
+	$(QUIET_GEN) \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@REASON@@|NO_PYTHON=$(NO_PYTHON)|g' \
 	    unimplemented.sh >$@+ && \
@@ -2388,8 +2397,7 @@ $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
 	mv $@+ $@
 endif # NO_PYTHON
 
-CONFIGURE_RECIPE = $(RM) configure configure.ac+ && \
-		   sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+CONFIGURE_RECIPE = sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 			configure.ac >configure.ac+ && \
 		   autoconf -o configure configure.ac+ && \
 		   $(RM) configure.ac+
@@ -2514,7 +2522,6 @@ endif
 ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
 all:: compile_commands.json
 compile_commands.json:
-	@$(RM) $@
 	$(QUIET_GEN)sed -e '1s/^/[/' -e '$$s/,$$/]/' $(compdb_dir)/*.o.json > $@+
 	@if test -s $@+; then mv $@+ $@; else $(RM) $@+; fi
 endif
@@ -2587,10 +2594,10 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
 $(LIB_FILE): $(LIB_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $^
 
 $(XDIFF_LIB): $(XDIFF_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+	$(QUIET_AR)$(AR) $(ARFLAGS) $@ $^
 
 export DEFAULT_EDITOR DEFAULT_PAGER
 
-- 
2.32.0.613.g20d5ce26552

