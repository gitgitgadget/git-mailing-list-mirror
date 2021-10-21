Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9725C43217
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0381611C7
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhJUUAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhJUUAc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 16:00:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FB7C061226
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:58:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d13so1202717wrf.11
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kyPmiV+ewRktgX2NcwmdwYwjMN/jWryjOSfNWbQ7SSs=;
        b=K3lqrJITaSZMlHqCR+BlzQ5oC+KzrIknwYJ5MoDgUZx/Hk473O7sO5zb3FHGCjJqtn
         bB/WaXeaM9anR+D2HCQD1AwdlXfRxZ862EIGn7qvbaZVsgleb8UVss1TUjy7B/z3Xo5V
         JQsw57VLbveY8+lyTjK4SER+1ibjo4AbAK5z0khAflpOozZcFrH4ZnJtItemDDqKkWEI
         U9lUACOES0vOn0VDuvPFIyFGHfhP5057eji3aybVJCDqJS6l+SPE/FKGWe+7nl8yb4fC
         93m0pB4b+i6X1gq9ex5pyKjkQDILgA0msXFlr0JRtCmC3Lg7uYwYrZQ6Ce+Lo3hbPX3V
         DuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kyPmiV+ewRktgX2NcwmdwYwjMN/jWryjOSfNWbQ7SSs=;
        b=3HiagV9pi1QRL/l1jMSdL7MPipSBUg4a0R+ZE8FasX20kKIM9Nl8MA4cdtVm40cwO4
         D0KooMZkk9XlyuQhx+iabw2KP2qOcq59ku4KqbWzwsIpaKwM5N4kzFICQykoMm2gPEYO
         g6t/SnmjcZfu/7Ze9ChlqtR1qmrc8iqjQ+nuneRGxBG2HghUVNxLMMoW+4VdLQwBzsLl
         scH/gCjqsoOIC4NUZfdYy5e4uzBMOke2IIBHdiu/XDgNYwkCfp3kHOdh00L/nDQf+roA
         KzNUGWODFZwiIdNNymq0p9D9ADTiJXSDytL97WheHAiOoHmQkWciASuxaD7yj1TsqsbA
         HjXg==
X-Gm-Message-State: AOAM533I72j3uQeY34pRXg9RMbiPaG+v7pjb0zfbR91qgnj3+gl5EzM0
        2TnM+sTnyxsoftJaTnN9Ati/0/a4JQWJvg==
X-Google-Smtp-Source: ABdhPJxWAeos1m3HbElnwOKViXeFjAQIoE4Jx3DfHpqRiHwOWo70TqiZ7rXhr6h3r1C+mCdWrmqsig==
X-Received: by 2002:adf:bd8a:: with SMTP id l10mr9908197wrh.159.1634846286921;
        Thu, 21 Oct 2021 12:58:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40sm388765wms.10.2021.10.21.12.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:58:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] git-sh-setup: remove "sane_grep", it's not needed anymore
Date:   Thu, 21 Oct 2021 21:58:00 +0200
Message-Id: <patch-6.6-556fa96dde7-20211021T195538Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the sane_grep() shell function in git-sh-setup. The two reasons
for why it existed don't apply anymore:

1. It was added due to GNU grep supporting GREP_OPTIONS. See
   e1622bfcbad (Protect scripted Porcelains from GREP_OPTIONS insanity,
   2009-11-23).

   Newer versions of GNU grep ignore that, but even on older versions
   its existence won't matter, none of these sane_grep() uses care
   about grep's output, they're merely using it to check if a string
   exists in a file or stream. We also don't care about the "LC_ALL=C"
   that "sane_grep" was using, these greps for fixed or ASCII strings
   will behave the same under any locale.

2. The SANE_TEXT_GREP added in 71b401032b9 (sane_grep: pass "-a" if
   grep accepts it, 2016-03-08) isn't needed either, none of these grep
   uses deal with binary data.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                            | 6 +-----
 config.mak.uname                    | 1 -
 configure.ac                        | 8 --------
 contrib/buildsystems/CMakeLists.txt | 1 -
 git-filter-branch.sh                | 2 +-
 git-instaweb.sh                     | 4 ++--
 git-sh-setup.sh                     | 4 ----
 7 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index 50eba522f4e..01585bfebdc 100644
--- a/Makefile
+++ b/Makefile
@@ -305,9 +305,6 @@ all::
 #
 # Define NO_TCLTK if you do not want Tcl/Tk GUI.
 #
-# Define SANE_TEXT_GREP to "-a" if you use recent versions of GNU grep
-# and egrep that are pickier when their input contains non-ASCII data.
-#
 # The TCL_PATH variable governs the location of the Tcl interpreter
 # used to optimize git-gui for your system.  Only used if NO_TCLTK
 # is not set.  Defaults to the bare 'tclsh'.
@@ -2254,7 +2251,7 @@ hook-list.h: generate-hooklist.sh Documentation/githooks.txt
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):\
 	$(localedir_SQ):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
-	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
+	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(PAGER_ENV):\
 	$(perllibdir_SQ)
 GIT-SCRIPT-DEFINES: FORCE
 	@FLAGS='$(SCRIPT_DEFINES)'; \
@@ -2272,7 +2269,6 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e $(BROKEN_PATH_FIX) \
     -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
     -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
-    -e 's|@@SANE_TEXT_GREP@@|$(SANE_TEXT_GREP)|g' \
     -e 's|@@PAGER_ENV@@|$(PAGER_ENV_SQ)|g' \
     $@.sh >$@+
 endef
diff --git a/config.mak.uname b/config.mak.uname
index 3236a4918a3..d0701f9beb0 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -58,7 +58,6 @@ ifeq ($(uname_S),Linux)
 	# -lrt is needed for clock_gettime on glibc <= 2.16
 	NEEDS_LIBRT = YesPlease
 	HAVE_GETDELIM = YesPlease
-	SANE_TEXT_GREP=-a
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	BASIC_CFLAGS += -DHAVE_SYSINFO
 	PROCFS_EXECUTABLE_PATH = /proc/self/exe
diff --git a/configure.ac b/configure.ac
index 031e8d3fee8..5ee25ec95c8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -507,14 +507,6 @@ if test -n "$ASCIIDOC"; then
 	esac
 fi
 
-if grep -a ascii configure.ac >/dev/null; then
-  AC_MSG_RESULT([Using 'grep -a' for sane_grep])
-  SANE_TEXT_GREP=-a
-else
-  SANE_TEXT_GREP=
-fi
-GIT_CONF_SUBST([SANE_TEXT_GREP])
-
 ## Checks for libraries.
 AC_MSG_NOTICE([CHECKS for libraries])
 #
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index fd1399c440f..86b46114464 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -781,7 +781,6 @@ foreach(script ${git_shell_scripts})
 	string(REPLACE "@@USE_GETTEXT_SCHEME@@" "" content "${content}")
 	string(REPLACE "# @@BROKEN_PATH_FIX@@" "" content "${content}")
 	string(REPLACE "@@PERL@@" "${PERL_PATH}" content "${content}")
-	string(REPLACE "@@SANE_TEXT_GREP@@" "-a" content "${content}")
 	string(REPLACE "@@PAGER_ENV@@" "LESS=FRX LV=-c" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
 endforeach()
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index cb893728136..3a51d4507c7 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -579,7 +579,7 @@ if [ "$filter_tag_name" ]; then
 				git hash-object -t tag -w --stdin) ||
 				die "Could not create new tag object for $ref"
 			if git cat-file tag "$ref" | \
-			   sane_grep '^-----BEGIN PGP SIGNATURE-----' >/dev/null 2>&1
+			   grep '^-----BEGIN PGP SIGNATURE-----' >/dev/null 2>&1
 			then
 				warn "gpg signature stripped from tag object $sha1t"
 			fi
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 54094fbe8de..4349566c891 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -49,7 +49,7 @@ resolve_full_httpd () {
 	*apache2*|*lighttpd*|*httpd*)
 		# yes, *httpd* covers *lighttpd* above, but it is there for clarity
 		# ensure that the apache2/lighttpd command ends with "-f"
-		if ! echo "$httpd" | sane_grep -- '-f *$' >/dev/null 2>&1
+		if ! echo "$httpd" | grep -- '-f *$' >/dev/null 2>&1
 		then
 			httpd="$httpd -f"
 		fi
@@ -399,7 +399,7 @@ EOF
 		# plain-old CGI
 		resolve_full_httpd
 		list_mods=$(echo "$full_httpd" | sed 's/-f$/-l/')
-		$list_mods | sane_grep 'mod_cgi\.c' >/dev/null 2>&1 || \
+		$list_mods | grep 'mod_cgi\.c' >/dev/null 2>&1 || \
 		if test -f "$module_path/mod_cgi.so"
 		then
 			echo "LoadModule cgi_module $module_path/mod_cgi.so" >> "$conf"
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 758520f5a61..1eb79458b48 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -173,10 +173,6 @@ git_pager() {
 	eval "$GIT_PAGER" '"$@"'
 }
 
-sane_grep () {
-	GREP_OPTIONS= LC_ALL=C grep @@SANE_TEXT_GREP@@ "$@"
-}
-
 is_bare_repository () {
 	git rev-parse --is-bare-repository
 }
-- 
2.33.1.1494.g88b39a443e1

