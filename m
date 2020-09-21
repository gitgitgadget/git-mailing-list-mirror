Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9BEC4727D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A7123A5B
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNhNkHrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgIUW2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUW2W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:28:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829F1C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:28:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a17so14679926wrn.6
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ewoqmQjhDhUdHufb+JGMSOeZBsePINNJlejOyJBct50=;
        b=bNhNkHrxV+9O9IF75P2iATIwdIMeKcIVKaGUWgT/+oQ7dRgK+DQBh1oa3sdAgq+zSG
         KHAV+NpAcbWRsEVf8Rng8vjmZ4cdCGJpr0IioG0pIXYKsDFW1YWpgWj9fiA/Cw+SzYbn
         IobmtAKvQmJJxyC3LHi4SpjTRHk2I0hiyik6aN5NLHDwSVUUzllobX7nDUjBd1D/V37m
         BZkXTWuTIlfqsYKALv4OjlcX3t7epRGl/5ZtAQKq0vMD4TPq/inp4LO6zZYvERHzpQXr
         TQZCgd+A9IuTmzZqbb1XYoKAHsYKCqkBA/2zUUwF6M4JneHRSBSWMdDMRzrTAojW+ujU
         QRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ewoqmQjhDhUdHufb+JGMSOeZBsePINNJlejOyJBct50=;
        b=UnFMz+xrvpTvwYSb5w+Lo11AQCpnfSUmjcJG3C0nYMtcKL9VNM8x5zNQLcvK7+ohhl
         lDs679B6SCmSjzUAyTVG0ts1qexBIM+FW64zZ9+eSS/BWTJjomuhhd9SwCX0CdHyhBh/
         3ETOoYtvK1AGOM6f8GPipdH0aC063UIzeDBTiCYCZwGoeCKxKOtb/I0ZoosGmMs13VMq
         XCNajFueKwToxvM41mVcPzL8MtDS7pV51X6hPryCcVLoKdolC1RH7jqzqiMIx4/nQ3b0
         p0CFwq92GDz3w5qCnlCjA9UJP35xm/LjwrP7baRf/raSQmTXaQarxMokIUy7V4JWSsnA
         86TQ==
X-Gm-Message-State: AOAM5305R2gC1rMYlmEbDhdJYggwMIJxOoqh1Mbx34dX7yrNrFeO1uGr
        k/6muIen+bonoYJzHBvnsnXiggvXUo8=
X-Google-Smtp-Source: ABdhPJyazoNTP3dj8l1sskoxCvu9NzeOot+dFE3AwcskviR9X0ipM7oDv9E3EHKMnrY9yj0DrFcFmw==
X-Received: by 2002:a5d:6ac9:: with SMTP id u9mr1902776wrw.46.1600727300937;
        Mon, 21 Sep 2020 15:28:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10sm1331527wmj.38.2020.09.21.15.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 15:28:20 -0700 (PDT)
Message-Id: <14d6eeefbc997fd7e6cddab89788ccd2eb32b4bd.1600727297.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.411.v4.git.1600727297.gitgitgadget@gmail.com>
References: <pull.411.v3.git.1598443012.gitgitgadget@gmail.com>
        <pull.411.v4.git.1600727297.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 22:28:16 +0000
Subject: [PATCH v4 2/3] Optionally skip linking/copying the built-ins
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
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
index ce072c4fb8..6931ecd45e 100644
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
@@ -774,6 +777,16 @@ BUILT_INS += git-whatchanged$X
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
@@ -2088,9 +2101,9 @@ profile-fast: profile-clean
 	$(MAKE) PROFILE=USE all
 
 
-all:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
+all:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
 ifneq (,$X)
-	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
+	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
 endif
 
 all::
@@ -2950,7 +2963,7 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' install
 endif
 ifneq (,$X)
-	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
+	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) git$X)), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
 endif
 
 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
@@ -2968,21 +2981,27 @@ endif
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
@@ -3076,7 +3095,7 @@ ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
 OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll)
 endif
 
-artifacts-tar:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) \
+artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
 		$(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
@@ -3171,7 +3190,7 @@ endif
 
 ### Check documentation
 #
-ALL_COMMANDS = $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS)
+ALL_COMMANDS = $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB)
 ALL_COMMANDS += git
 ALL_COMMANDS += git-citool
 ALL_COMMANDS += git-gui
@@ -3211,7 +3230,7 @@ check-docs::
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

