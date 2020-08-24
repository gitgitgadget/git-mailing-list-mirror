Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C9AC433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 15:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5B420738
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 15:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFT9GLvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgHXPne (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgHXPie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 11:38:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ED6C061795
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 08:38:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r15so9137069wrp.13
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 08:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vRSngp32cPW/HWango1ypUcRZTexoFBQnurwDzAfnaA=;
        b=RFT9GLvZBS2CKM94w0eOkS/x6a6iiKS+9qSatih7iMRS4p8i+3JUprgcA5e/lkTbhh
         Vggyo3Fh6wDy7LHSyqhocOK7owdkTJ3xxlRud2g2DS7WdJ0kS24JablOtCzmwEe0+B89
         Azn+OL4TIiOGAPw5E0bextBQXGdGrmR2oJRIAhFOzWPN5CGTqTytil85R/21DhbKAc0k
         R5JgC2mJ/zwD33ONGtsUvx3+KFE6fm0HJivUA91vw93f0fMZB/dYroBqv3lfQYYuAIVs
         FrLv9QKld0mxPrcfe1QUDKW0I3nsNrcO+NbEVVN7gCMBnnpnb6m2kQcoTBBp98U9tpRM
         nKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vRSngp32cPW/HWango1ypUcRZTexoFBQnurwDzAfnaA=;
        b=T7tsfz0E/fF6WL1PiilMW/9pyCL+WVRG1mHu1Q+SxwfJ75BvLSpBZl8vnQSbZ9d3zU
         3vYbKhIXoAqruvDCMuBfyVaGQ5KdcR4cIQb0nOkNRiqB4+Y6PGT4O/jy0/BSGuMvTw5a
         TySdDJuuNmz9d4zVA2vE0wEnjfh5hSr1mJ09/x6TsmIw5w8iMbf3vbRUS0umIGsIH9mW
         7DnqjTTs3qwOPGH6xVkIfaUAEP0RsVOUsyOTxZbVjwCTlyV71XOpbcyNHCWlj+V0P6x8
         meqX2/t/7wqoQjqqnAJ892zMa8P9aHl9DHEjsmXNEErePjsGxLC6BhsFbpI4jNv13K5+
         mJYg==
X-Gm-Message-State: AOAM531pXNw5UEe74FcTTNAetsD/HljCSoptx1xNL+8jPPZTJZYSexMl
        8fA80/q6sZbGhNg5V1xtr3IQPYOU7NI=
X-Google-Smtp-Source: ABdhPJwRs3cxDHLdCViSjaPLBXetNffbjpsKEdTBu98s23iogycE4mNSSuQF6chBz246cz6tZx9yYA==
X-Received: by 2002:adf:84a2:: with SMTP id 31mr1310789wrg.421.1598283482235;
        Mon, 24 Aug 2020 08:38:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1sm7570380wru.6.2020.08.24.08.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:38:01 -0700 (PDT)
Message-Id: <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
In-Reply-To: <pull.411.git.1597655273.gitgitgadget@gmail.com>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Aug 2020 15:37:57 +0000
Subject: [PATCH v2 0/3] Optionally skip linking/copying the built-ins
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The dashed form of the built-ins is so passé.

Incidentally, this also handles the .pdb issue in MSVC's install Makefile
target that Peff pointed out in the context of the "slimming down" patch
series
[https://lore.kernel.org/git/20200813145719.GA891370@coredump.intra.peff.net/]
.

This addresses https://github.com/gitgitgadget/git/issues/406

Changes since v1:

 * Fixed check-docs under SKIP_DASHED_BUILT_INS
 * Renamed ALL_PROGRAMS_AND_BUILT_INS to ALL_COMMANDS_TO_INSTALL to reflect
   its purpose better.
 * Revamped the commit message of patch 2/3 and 3/3.

Johannes Schindelin (3):
  msvc: copy the correct `.pdb` files in the Makefile target `install`
  Optionally skip linking/copying the built-ins
  ci: stop linking built-ins to the dashed versions

 Makefile                  | 71 +++++++++++++++++++++------------------
 ci/run-build-and-tests.sh |  2 +-
 2 files changed, 40 insertions(+), 33 deletions(-)


base-commit: 878e727637ec5815ccb3301eb994a54df95b21b8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-411%2Fdscho%2Foptionally-skip-dashed-built-ins-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-411/dscho/optionally-skip-dashed-built-ins-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/411

Range-diff vs v1:

 1:  120d2bb3e4 = 1:  1880a0e4bf msvc: copy the correct `.pdb` files in the Makefile target `install`
 2:  647f49d62e ! 2:  166bd0d8fb Optionally skip linking/copying the built-ins
     @@ Metadata
       ## Commit message ##
          Optionally skip linking/copying the built-ins
      
     -    The dashed form of the built-ins is so passé. To save on development
     -    time, and to support the idea of eventually dropping the dashed form
     -    altogether, let's introduce a Makefile knob to skip generating those
     -    hard-links.
     +    For a long time already, the non-dashed form of the built-ins is the
     +    recommended way to write scripts, i.e. it is better to call `git merge
     +    [...]` than to call `git-merge [...]`.
     +
     +    While Git still supports the dashed form (by hard-linking the `git`
     +    executable to the dashed name in `libexec/git-core/`), in practice, it
     +    is probably almost irrelevant.
     +
     +    In fact, some platforms (such as Windows) only started gaining
     +    meaningful Git support _after_ the dashed form was deprecated, and
     +    therefore one would expect that all this hard-linking is unnecessary on
     +    those platforms.
     +
     +    In addition to that, some programs that are regularly used to assess
     +    disk usage fail to realize that those are hard-links, and heavily
     +    overcount disk usage. Most notably, this was the case with Windows
     +    Explorer up until the last couple of Windows 10 versions.
     +
     +    To save on the time needed to hard-link these dashed commands, and to
     +    eventually stop shipping with those hard-links on Windows, let's
     +    introduce a Makefile knob to skip generating them.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ Makefile: BUILT_INS += git-whatchanged$X
       # what 'all' will build and 'install' will install in gitexecdir,
       # excluding programs for built-in commands
       ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
     -+ALL_PROGRAMS_AND_BUILT_INS = $(ALL_PROGRAMS)
     ++ALL_COMMANDS_TO_INSTALL = $(ALL_PROGRAMS)
      +ifeq (,$(SKIP_DASHED_BUILT_INS))
     -+ALL_PROGRAMS_AND_BUILT_INS += $(BUILT_INS)
     ++ALL_COMMANDS_TO_INSTALL += $(BUILT_INS)
      +else
      +# git-upload-pack, git-receive-pack and git-upload-archive are special: they
      +# are _expected_ to be present in the `bin/` directory in their dashed form.
     -+ALL_PROGRAMS_AND_BUILT_INS += git-receive-pack$(X)
     -+ALL_PROGRAMS_AND_BUILT_INS += git-upload-archive$(X)
     -+ALL_PROGRAMS_AND_BUILT_INS += git-upload-pack$(X)
     ++ALL_COMMANDS_TO_INSTALL += git-receive-pack$(X)
     ++ALL_COMMANDS_TO_INSTALL += git-upload-archive$(X)
     ++ALL_COMMANDS_TO_INSTALL += git-upload-pack$(X)
      +endif
       
       # what 'all' will build but not install in gitexecdir
     @@ Makefile: profile-fast: profile-clean
       
       
      -all:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
     -+all:: $(ALL_PROGRAMS_AND_BUILT_INS) $(SCRIPT_LIB) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
     ++all:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
       ifneq (,$X)
      -	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
     -+	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS_AND_BUILT_INS) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
     ++	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
       endif
       
       all::
     @@ Makefile: ifndef NO_TCLTK
       endif
       ifneq (,$X)
      -	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
     -+	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS_AND_BUILT_INS) git$X)), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
     ++	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) git$X)), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
       endif
       
       	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
     @@ Makefile: ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
       endif
       
      -artifacts-tar:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) \
     -+artifacts-tar:: $(ALL_PROGRAMS_AND_BUILT_INS) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
     ++artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
       		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
       		$(MOFILES)
       	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
     @@ Makefile: endif
       ### Check documentation
       #
      -ALL_COMMANDS = $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS)
     -+ALL_COMMANDS = $(ALL_PROGRAMS_AND_BUILT_INS) $(SCRIPT_LIB)
     ++ALL_COMMANDS = $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB)
       ALL_COMMANDS += git
       ALL_COMMANDS += git-citool
       ALL_COMMANDS += git-gui
     +@@ Makefile: check-docs::
     + 		    -e 's/\.txt//'; \
     + 	) | while read how cmd; \
     + 	do \
     +-		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(EXCLUDED_PROGRAMS)) " in \
     ++		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(BUILT_INS) $(EXCLUDED_PROGRAMS)) " in \
     + 		*" $$cmd "*)	;; \
     + 		*) echo "removed but $$how: $$cmd" ;; \
     + 		esac; \
 3:  1269d7ace8 ! 3:  ea23ba5e26 ci: stop linking built-ins to the dashed versions
     @@ Commit message
          This backwards-compatibility was needed to support scripts that called
          the dashed form, even if we deprecated that a _long_ time ago.
      
     -    In preparation for eventually dropping those hard-links, teach the CI
     +    For that reason, we just introduced a Makefile knob to skip linking
     +    them. TO make sure that this keeps working, teach the CI
          (and PR) builds to skip generating those hard-links.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

-- 
gitgitgadget
