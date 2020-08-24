Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD1C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 15:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A51A20838
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 15:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCgl79KF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgHXPj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgHXPik (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 11:38:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3167C061798
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 08:38:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so8808668wmi.2
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pfQU/UgIwp9s3VOVYJ5vfMVbzyyspSe7E6rfKEJIwfI=;
        b=PCgl79KFQshqXGIUu0woRDj82vDwoIMN0MRqVugivhfu7kdq7EhsBxBl1fxREupDp+
         KaZ/N3fs3Olc5tLgkPa4wFhKe/Bx2NORgIC0cfAb5+iXaGfaZ4FABv7kR1LMDEj3Tnhp
         gWrsO9TZnsr4K9DpmUCRJgK8eMolRXZfz2abOtotUdYK9kREEDS647EM3OUUmPjl+x1n
         WTNsQMHJLm5wUbc4JjZrrxA6E8yw64iAwXVFYcOZtzwdH8wrfvZZ9ykB+sQAgbFMRKEZ
         2+WPGFAhkzDENBzxqlIn2g8maY+z8noAjWxV8COaxJuUT7kMhH8j56ZDbvR3EJiu9iFw
         vxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pfQU/UgIwp9s3VOVYJ5vfMVbzyyspSe7E6rfKEJIwfI=;
        b=NCM5hv4jMlZHFVpC1jNqYNREB+/Vpzwc995S9/qXx9DjN4igPFwIz8aDLdEVJVcp5h
         UQQhU/YDQoRhAdTu4z9wRMsUfS8g2CMUvS/B1aGCNWtUzVkYATVKEw80KEH1W7VNlnUh
         qK8l6pmbWv8FUnBeATYvL/2d9NTw5KMDFp3GDGvIQTKzejn2ifi+siMzG3YV2VSCtzoZ
         dUJ4m6iylNCgubFzrZ1innzzXgAaG8Djnl96NNnUhzlfWzIiWvy6masK92R6iIhkHlyw
         OO4EwiQ4/BIly+p5gou6o7Ewr9BW6cj5z4svIGvhSLWJaHPDUV+jitgsuIROPopDZ4iu
         FrsQ==
X-Gm-Message-State: AOAM532bKGQzqb+U1Rm/2yczrmK3d/Y1ddZgD5W9FCaFH8EERph57hBu
        zJsaolbg9PIdgurQ/d6onSc4iCi1FRE=
X-Google-Smtp-Source: ABdhPJyDmTVjDle1BEMQQefodv7r7OTZJK30Uf5cX6vz34oxrZ6kZM8gxrFy0MC7DTmjCRm27SGT3w==
X-Received: by 2002:a7b:cd0d:: with SMTP id f13mr6087866wmj.122.1598283483961;
        Mon, 24 Aug 2020 08:38:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z66sm25258506wme.16.2020.08.24.08.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:38:03 -0700 (PDT)
Message-Id: <166bd0d8fb699132569aff855de59c7607581adf.1598283480.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
        <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Aug 2020 15:37:59 +0000
Subject: [PATCH v2 2/3] Optionally skip linking/copying the built-ins
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

For a long time already, the non-dashed form of the built-ins is the
recommended way to write scripts, i.e. it is better to call `git merge
[...]` than to call `git-merge [...]`.

While Git still supports the dashed form (by hard-linking the `git`
executable to the dashed name in `libexec/git-core/`), in practice, it
is probably almost irrelevant.

In fact, some platforms (such as Windows) only started gaining
meaningful Git support _after_ the dashed form was deprecated, and
therefore one would expect that all this hard-linking is unnecessary on
those platforms.

In addition to that, some programs that are regularly used to assess
disk usage fail to realize that those are hard-links, and heavily
overcount disk usage. Most notably, this was the case with Windows
Explorer up until the last couple of Windows 10 versions.

To save on the time needed to hard-link these dashed commands, and to
eventually stop shipping with those hard-links on Windows, let's
introduce a Makefile knob to skip generating them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 55 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 66b6e076e2..0a09146fb3 100644
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
+ALL_COMMANDS_TO_INSTALL = $(ALL_PROGRAMS)
+ifeq (,$(SKIP_DASHED_BUILT_INS))
+ALL_COMMANDS_TO_INSTALL += $(BUILT_INS)
+else
+# git-upload-pack, git-receive-pack and git-upload-archive are special: they
+# are _expected_ to be present in the `bin/` directory in their dashed form.
+ALL_COMMANDS_TO_INSTALL += git-receive-pack$(X)
+ALL_COMMANDS_TO_INSTALL += git-upload-archive$(X)
+ALL_COMMANDS_TO_INSTALL += git-upload-pack$(X)
+endif
 
 # what 'all' will build but not install in gitexecdir
 OTHER_PROGRAMS = git$X
@@ -2066,9 +2079,9 @@ profile-fast: profile-clean
 	$(MAKE) PROFILE=USE all
 
 
-all:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
+all:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
 ifneq (,$X)
-	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
+	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
 endif
 
 all::
@@ -2928,7 +2941,7 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' install
 endif
 ifneq (,$X)
-	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
+	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) git$X)), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
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
+artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
 		$(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
@@ -3146,7 +3165,7 @@ endif
 
 ### Check documentation
 #
-ALL_COMMANDS = $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS)
+ALL_COMMANDS = $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB)
 ALL_COMMANDS += git
 ALL_COMMANDS += git-citool
 ALL_COMMANDS += git-gui
@@ -3186,7 +3205,7 @@ check-docs::
 		    -e 's/\.txt//'; \
 	) | while read how cmd; \
 	do \
-		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(EXCLUDED_PROGRAMS)) " in \
+		case " $(patsubst %$X,%,$(ALL_COMMANDS) $(BUILT_INS) $(EXCLUDED_PROGRAMS)) " in \
 		*" $$cmd "*)	;; \
 		*) echo "removed but $$how: $$cmd" ;; \
 		esac; \
-- 
gitgitgadget

