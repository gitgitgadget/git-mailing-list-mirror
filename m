Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B867C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 09:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0685C2063A
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 09:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYAM40kA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgHQJJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgHQJH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 05:07:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2138C061345
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 02:07:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 88so14199537wrh.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 02:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:in-reply-to:references:date:subject:mime-version
         :content-transfer-encoding:fcc:to;
        bh=vbvISUaPkKc4rrwX+xM60GRWfIbsVasmmRjcKlwh9Vk=;
        b=aYAM40kALf9QIw2R+vLlYzg0IrXyoB6DsRVO9roqOMc9pj3agyTbD69gF+sB8v6Fqy
         mcq7fBstCZ0U52BRdiWT0xMtN5WAJe4Bk+JYmnbLet8CnzAsFoKCU/eCni4JovhBoXQU
         6Yu4LgXAB6tYzFAv+eOalSR/gft7ZMcsGSATXqhVL2MNZgsnm9X4VwvCT5c5y3cAmMLX
         sGZNa6/gpNAy4I643DIqM16l9w/4fHcJAAn1Xqgvy9hi5kEz04TUybSfvkCCIKciicDh
         seVOPU8ntHawfd6ITz2JgEi8UIyWJ84GxVVDCGwoiNauFUE8jGStfzCle0WI16JDBhii
         h6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:in-reply-to:references:date
         :subject:mime-version:content-transfer-encoding:fcc:to;
        bh=vbvISUaPkKc4rrwX+xM60GRWfIbsVasmmRjcKlwh9Vk=;
        b=HMkrbvXtst5ynPrCulhUwva3EZ8H10aCRb1pycVyeNojHOIu+RGGxgdJMna/JprmA0
         aTOw6XUu5GbUUHIaPSekM3b4UCxOHt1AwsbcyUs+Juxhdby5xPs0QEk9OtV5qaPn+Rc5
         fG5i6dgu8mONhiaQf0v91qsE5zsKNiwjl8FNTjyXRP1WCSyc7dmaGDC7vy7lPeK9iUhW
         Lp6Sh5fbeGyOeSiy/9SCEo598gc8pvIMpm6v7F/PFnc8tWDnC2f6zJWfC9wiPPkIGPxJ
         yDKPny7QTzJvckQVhTNNJUZBiFh34gsfOAHYJWbHaEOP8bWcy17zDP9lg/NEJeCFZxmX
         O8pw==
X-Gm-Message-State: AOAM531mkHzapb3pF8XqurIKsuL56VtES1bVyigOs2I8i+qG6MiX4N+s
        Gc9C+LtQPmRwdVNQMfaV7fTrvH6ENVc=
X-Google-Smtp-Source: ABdhPJzJgQqm2fiRCUHDsBwYJb5kLEWjuQmNzQ4aqaokB1n+DCSaAk8G8u5bGDpZVAnfveaoyyZiZA==
X-Received: by 2002:a5d:464a:: with SMTP id j10mr15053639wrs.187.1597655276399;
        Mon, 17 Aug 2020 02:07:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9sm28207038wrm.62.2020.08.17.02.07.55
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:07:55 -0700 (PDT)
From:   Johannes Schindelin <gitgitgadget@gmail.com>
X-Google-Original-From: Johannes Schindelin <johannes.schindelin@gmx.de>
Message-Id: <647f49d62e910fe8392219c3a5c6d86ac98a88e6.1597655273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.411.git.1597655273.gitgitgadget@gmail.com>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 09:07:52 +0000
Subject: [PATCH 2/3] Optionally skip linking/copying the built-ins
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The dashed form of the built-ins is so passé. To save on development
time, and to support the idea of eventually dropping the dashed form
altogether, let's introduce a Makefile knob to skip generating those
hard-links.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 53 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index 3f5ba97b70..2a355a4da8 100644
--- a/Makefile
+++ b/Makefile
@@ -348,6 +348,9 @@ all::
 # Define NO_INSTALL_HARDLINKS if you prefer to use either symbolic links or
 # copies to install built-in git commands e.g. git-cat-file.
 #
+# Define SKIP_DASHED_BUILT_INS if you do not need the dashed versions of the
+# built-ins to be linked/copied at all.
+#
 # Define USE_NED_ALLOCATOR if you want to replace the platforms default
 # memory allocators with the nedmalloc allocator written by Niall Douglas.
 #
@@ -775,6 +778,16 @@ BUILT_INS += git-whatchanged$X
 # what 'all' will build and 'install' will install in gitexecdir,
 # excluding programs for built-in commands
 ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
+ALL_PROGRAMS_AND_BUILT_INS = $(ALL_PROGRAMS)
+ifeq (,$(SKIP_DASHED_BUILT_INS))
+ALL_PROGRAMS_AND_BUILT_INS += $(BUILT_INS)
+else
+# git-upload-pack, git-receive-pack and git-upload-archive are special: they
+# are _expected_ to be present in the `bin/` directory in their dashed form.
+ALL_PROGRAMS_AND_BUILT_INS += git-receive-pack$(X)
+ALL_PROGRAMS_AND_BUILT_INS += git-upload-archive$(X)
+ALL_PROGRAMS_AND_BUILT_INS += git-upload-pack$(X)
+endif
 
 # what 'all' will build but not install in gitexecdir
 OTHER_PROGRAMS = git$X
@@ -2066,9 +2079,9 @@ profile-fast: profile-clean
 	$(MAKE) PROFILE=USE all
 
 
-all:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
+all:: $(ALL_PROGRAMS_AND_BUILT_INS) $(SCRIPT_LIB) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
 ifneq (,$X)
-	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
+	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS_AND_BUILT_INS) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
 endif
 
 all::
@@ -2928,7 +2941,7 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' install
 endif
 ifneq (,$X)
-	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
+	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS_AND_BUILT_INS) git$X)), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
 endif
 
 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
@@ -2946,21 +2959,27 @@ endif
 	} && \
 	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
 		$(RM) "$$bindir/$$p" && \
-		test -n "$(INSTALL_SYMLINKS)" && \
-		ln -s "git$X" "$$bindir/$$p" || \
-		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
-		  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
-		  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
-		  cp "$$bindir/git$X" "$$bindir/$$p" || exit; } \
+		if test -z "$(SKIP_DASHED_BUILT_INS)"; \
+		then \
+			test -n "$(INSTALL_SYMLINKS)" && \
+			ln -s "git$X" "$$bindir/$$p" || \
+			{ test -z "$(NO_INSTALL_HARDLINKS)" && \
+			  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
+			  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
+			  cp "$$bindir/git$X" "$$bindir/$$p" || exit; }; \
+		fi \
 	done && \
 	for p in $(BUILT_INS); do \
 		$(RM) "$$execdir/$$p" && \
-		test -n "$(INSTALL_SYMLINKS)" && \
-		ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/git$X" "$$execdir/$$p" || \
-		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
-		  ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
-		  ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
-		  cp "$$execdir/git$X" "$$execdir/$$p" || exit; } \
+		if test -z "$(SKIP_DASHED_BUILT_INS)"; \
+		then \
+			test -n "$(INSTALL_SYMLINKS)" && \
+			ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/git$X" "$$execdir/$$p" || \
+			{ test -z "$(NO_INSTALL_HARDLINKS)" && \
+			  ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
+			  ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
+			  cp "$$execdir/git$X" "$$execdir/$$p" || exit; }; \
+		fi \
 	done && \
 	remote_curl_aliases="$(REMOTE_CURL_ALIASES)" && \
 	for p in $$remote_curl_aliases; do \
@@ -3051,7 +3070,7 @@ ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
 OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll)
 endif
 
-artifacts-tar:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) \
+artifacts-tar:: $(ALL_PROGRAMS_AND_BUILT_INS) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
 		$(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
@@ -3146,7 +3165,7 @@ endif
 
 ### Check documentation
 #
-ALL_COMMANDS = $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS)
+ALL_COMMANDS = $(ALL_PROGRAMS_AND_BUILT_INS) $(SCRIPT_LIB)
 ALL_COMMANDS += git
 ALL_COMMANDS += git-citool
 ALL_COMMANDS += git-gui
-- 
gitgitgadget

