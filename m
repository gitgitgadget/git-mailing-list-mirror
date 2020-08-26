Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054CAC433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 11:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB27A2080C
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 11:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7hy2dl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgHZL5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbgHZL5E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 07:57:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657ADC061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 04:57:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k20so1481372wmi.5
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 04:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=75PiXk4hYwv60HI+b2mIV0yUEPbEJXHPG/kjb85PHRQ=;
        b=c7hy2dl6O59Z5+kM6zDyOtDIR09EG/b/bJSrIarjuk3AiI9Qr+bBGbin7cTMJeoa4v
         c6+8shNVaM+j8WGAJRAfDPIhhOIrx+CZwFSE/EDTH737mQXSJo3fjSsLTEGtcgVJkzL0
         PM522PHLze8e9I6mM5Ai4fGbW2L+0xMdhwP8yZ5v1XlHoWks3HQ9YK67dSyj/OjVHXLQ
         G6NTIZcctTWZE56W4/sMhGRb7yqqA+jPJdZNLT4CqFxBitq0TbP8aF31TJBA82gjo0C2
         xWFEYgYk+7xh6go0hTJrTKb7J+yYRr4Dls6s1h0hfgcfGTzwt3VRIH9i0+b5LUsXjYh4
         SUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=75PiXk4hYwv60HI+b2mIV0yUEPbEJXHPG/kjb85PHRQ=;
        b=J+ulwB4yVMBrTg2fXRJQGzp7z1pPZj98rgqxHD9ImrJiqG5QcxNO5T94mxRTghBWSN
         Icydz3xBadWkf+E8zQYMf8oMRx6dfp/P5TcsL9ymsCdWKD28zUzqzJqVdl8oepCCITCO
         xsGVdZvnJrF39lRRylYTehlT1oNpQGl3t6p2TjMljovqSihr2C9pGV8+b/fbzEYQ3MZ3
         V2LnJsXbLCZNsLI85hGDazvI1blIGj9mTcqAdz7jhWrHs6EwQ5PPXIohOZwbOO8/hPbZ
         wzliYKwy+GtHvcWA2mEeU38aYiHLaharKKmO4uDzuR0j0a8YKO+FsHvD5bPVRB77xZiv
         ROWg==
X-Gm-Message-State: AOAM531BUfiOGqnG4csCBVzzOj46Cp8HZ/XfqH2GZV2ajIgISQ9rkpdy
        Zx6l6nC29u8KSjPiVC5uDBOt39hFeRc=
X-Google-Smtp-Source: ABdhPJyFnx5nid6ModH3y+un/JHR+jKLQiDRp9hTu6eDVpgJUz93YSNEWuNZ6X60aUS3nlLDH5oyeA==
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr6309701wmh.80.1598443019458;
        Wed, 26 Aug 2020 04:56:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm5110697wrn.24.2020.08.26.04.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 04:56:58 -0700 (PDT)
Message-Id: <52deafded50ef99d904d2af39c098028b8714e86.1598443012.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
References: <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
        <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Aug 2020 11:56:51 +0000
Subject: [PATCH v3 2/3] Optionally skip linking/copying the built-ins
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

However, we *do* care about keeping people's scripts working (even if
they were written before the non-dashed form started to be recommended).

Keeping this backwards-compatibility is not necessarily cheap, though:
even so much as amending the tip commit in a git.git checkout will
require re-linking all of those dashed commands. On this developer's
laptop, this makes a noticeable difference:

	$ touch version.c && time make
	    CC version.o
	    AR libgit.a
	    LINK git-bugreport.exe
	    [... 11 similar lines ...]
	    LN/CP git-remote-https.exe
	    LN/CP git-remote-ftp.exe
	    LN/CP git-remote-ftps.exe
	    LINK git.exe
	    BUILTIN git-add.exe
	    [... 123 similar lines ...]
	    BUILTIN all
	    SUBDIR git-gui
	    SUBDIR gitk-git
	    SUBDIR templates
	    LINK t/helper/test-fake-ssh.exe
	    LINK t/helper/test-line-buffer.exe
	    LINK t/helper/test-svn-fe.exe
	    LINK t/helper/test-tool.exe

	real    0m36.633s
	user    0m3.794s
	sys     0m14.141s

	$ touch version.c && time make SKIP_DASHED_BUILT_INS=1
	    CC version.o
	    AR libgit.a
	    LINK git-bugreport.exe
	    [... 11 similar lines ...]
	    LN/CP git-remote-https.exe
	    LN/CP git-remote-ftp.exe
	    LN/CP git-remote-ftps.exe
	    LINK git.exe
	    BUILTIN git-receive-pack.exe
	    BUILTIN git-upload-archive.exe
	    BUILTIN git-upload-pack.exe
	    BUILTIN all
	    SUBDIR git-gui
	    SUBDIR gitk-git
	    SUBDIR templates
	    LINK t/helper/test-fake-ssh.exe
	    LINK t/helper/test-line-buffer.exe
	    LINK t/helper/test-svn-fe.exe
	    LINK t/helper/test-tool.exe

	real    0m23.717s
	user    0m1.562s
	sys     0m5.210s

Also, `.zip` files do not have any standardized support for hard-links,
therefore "zipping up" the executables will result in inflated disk
usage. (To keep down the size of the "MinGit" variant of Git for
Windows, which is distributed as a `.zip` file, the hard-links are
excluded specifically.)

In addition to that, some programs that are regularly used to assess
disk usage fail to realize that those are hard-links, and heavily
overcount disk usage. Most notably, this was the case with Windows
Explorer up until the last couple of Windows 10 versions. See e.g.
https://github.com/msysgit/msysgit/issues/58.

To save on the time needed to hard-link these dashed commands, with the
plan to eventually stop shipping with those hard-links on Windows, let's
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

