Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9666C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 14:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAEC61042
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 14:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhFVOPd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 10:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhFVOPc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 10:15:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868B2C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 07:13:16 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id w13so6297995wmc.3
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hNmUW+lZXWst6w84tttJNSU4pn2ZaRYphemXShyAdk=;
        b=k3LaNi/TTk5Gcee9Fkk0j4NrfZPqEYRzKmgOHiDYP9mfQajhkzbDJjFrW0Cz0S96dg
         vs4E5L0tb6fF2nNnHgRGRr4OSLmNzryp3iPzqWBIlY/ht19bbuUHsDLKztvOe6ElSLm9
         g7LGFwJel8lIUUplALHSW2mRPQfgxrESNQFXqLIWUljpSyRtUZ0PSlskjulyTqK/XjXk
         +/TJrnMpTf8c5dN0SHmuC6X2u4bPfUtSzbWrx7MFngs8caXsMQImxA8mU+AlTCBr99BO
         N/lP1Fl/smcvT4pD6KigfhqujuL2trcebLwCXEAPTiylljiO45gcPXiUDVZ07nBXnvpI
         QL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hNmUW+lZXWst6w84tttJNSU4pn2ZaRYphemXShyAdk=;
        b=Y9E3ibXlRtD4nImMeyVvY3hb/RkV6ViKGu5S1q/Ddr8Xt4KInMh4RG2mz4opJYorsv
         Xcq3GF7ysa1hAdkIoU2hf/U4mLybSZKEu1JTepPoqqvQQ7WmBf4/tAf7ppsE5dhk58DY
         XaQnY0hIYy0/EfjjGKmtJTE6w0ezVcd+FoEw01iP8ctfLpevC91CsxPoCI+jbGnct7/X
         Kq5D9DdERjhMF3CVTwmTKYSJdTg1zwq0wm+jfiCZ5SvHRTzQAnX9DSx4uH/5CvhFl8HN
         bWkBV5LtQZDcqqBlxs77blblHnSd2eRI1tgcSGrFyncFdIs/U4kok+UcrDesP42vH4H+
         SKjg==
X-Gm-Message-State: AOAM531jLB7upvhfnMf1tLVKZPdYKhSG4jtpUf+t2d64Xw3IkiBElNbZ
        lYBTm1yjwSVddq6QWbqP4WwIxV4yTkpeaQ==
X-Google-Smtp-Source: ABdhPJwvFJs+/Norvf8imlhlHpywQ7ciMVWcHaPD/zsF6/aq4X14BUxAvdeyRUpWAwyoKGe5MapruQ==
X-Received: by 2002:a7b:c30f:: with SMTP id k15mr4823352wmj.128.1624371194877;
        Tue, 22 Jun 2021 07:13:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g15sm3148453wri.75.2021.06.22.07.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 07:13:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Date:   Tue, 22 Jun 2021 16:13:13 +0200
Message-Id: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Extracted from an earlier series of mine[1] which was tangled up with
wider use of the "stuff >$@+ && mv $@+ $@" pattern, which caused that
series not to go forward.

1. https://lore.kernel.org/git/cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com/

 Makefile | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index c3565fc0f8f..20a0fe6e88e 100644
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
-- 
2.32.0.599.g3967b4fa4ac

