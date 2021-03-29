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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C128AC433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11D56196E
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhC2Qcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhC2QcG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 12:32:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FB4C061765
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:32:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x7so13482642wrw.10
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jkvCA0dVkWiNgRt+3sEDl776FHd+IQgnZObblA0wNSg=;
        b=aIRVI/+ZX3CXdwxA/Hx80USmqzHm7bIP9TOHv6P63yASCUze81gkSZSsmDv53BaJ0y
         qzLVtwON6PBZnNCabK3vqScPUnxBxEYq5W9AwAJ0JEGYU7DZLNHcpsELdfXNoPPUCxC/
         lnZTfBbRbcCN8DMAtV30oQhJnbNihwTXSspNwcTBdSTRovK2OPnVjpXGzley3tBgHnoc
         fuDSdEdbuQndeqq2O/C+LS+OJO88mFeBgY0V4WMGTTyYaMcVoGLMD4zFC2WI5JZYVFzB
         V3ow/2fDnrq0jdzGdDoOttOWNBhj9ztPOC7Ra0RN/IFdgxwdGXOlibYXulRyat2BKjPJ
         9ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jkvCA0dVkWiNgRt+3sEDl776FHd+IQgnZObblA0wNSg=;
        b=r3ZPE2iH2xJ0J2aboIwqk+p88mKuRsnM4uL2rLJ0LhLHHthDRivqKSCZNqR7k6c76U
         aYCdvmmXM3bAkRadkmQj73mYngQ4nln8yp8l93a/xtXDpqUfkVIADML3niEftOhdVux7
         mHF/zvScsYdzCLYFPh8ntm8FovyMZxeEMTJFgYs7vROjK8q6SHnMvMWhHgwrmBaTS2fi
         E4Ze1ziSCBkjRWQOBYpZvzDS4cvjRtLsWTRj1KmGgD5KkU4U/zJn/aianch6eGedj7J1
         WnaBr2cb9sug5vd4EMU+sF0UfJboldFiCw90kcI7xMAgyoMWIRBOE4bdXoV+BwvkJirz
         DYXQ==
X-Gm-Message-State: AOAM5335ixSt54v5Z5OIOgHWVmCs2zAcUIeS6PzRLBcYFuBWE0Ety/Hg
        J+CuOcRsUCB1+Cn3JKEyRtOzEQAgt9r16Q==
X-Google-Smtp-Source: ABdhPJwUbA2tmVLI9Qe/g9JUAdFcbrD5KCOwWstbLqIYF2x+XtyMM7jD1FnM5RQViPuq0j5tr7xG2w==
X-Received: by 2002:a05:6000:18cd:: with SMTP id w13mr29205747wrq.20.1617035521090;
        Mon, 29 Mar 2021 09:32:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm25410464wmg.41.2021.03.29.09.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:32:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] Makefile: add a INSTALL_FALLBACK_LN_CP mode
Date:   Mon, 29 Mar 2021 18:31:44 +0200
Message-Id: <patch-6.7-9ada8979890-20210329T162327Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.461.gd47399f6574
In-Reply-To: <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com> <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the default behavior on "make install" where we fallback
through a chain of "ln || ln -s || cp" to instead error out when we
can't symlink or hardlink, and not then fallback on a "cp" (or from a
symlink to hardlink etc.).

The fallback behavior was introduced in 3e073dc5611 (Makefile: always
provide a fallback when hardlinks fail, 2008-08-25), since then we've
gained the ability to specify e.g. that we'd like symlinks via the
INSTALL_SYMLINKS setting.

It doesn't make sense as a default to silently fall back if we can't
satisfy those settings. We should instead error out, at which point
the developer/builder/sysadmin can set one or more of the relevant
hardlink or symlink settings.

This also changes the behavior for the build (not install!) to always
use the new strict mode. This will theoretically break things for
someone who can't make symlinks or hardlinks in their git checkout
when building.

That part of this change would break building on Windows and other
platforms that don't support symlinks if INSTALL_SYMLINKS were to
become the default, but it's not on by default, so we should be fine
here. If and when INSTALL_SYMLINKS ever becomes the default the right
way to deal with this would be to tweak config.mak.uname
appropriately, not to silently fall back on a copy.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile    | 11 +++++++++++
 ln-or-cp.sh | 29 ++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 466df1a8e90..ccbded79093 100644
--- a/Makefile
+++ b/Makefile
@@ -350,6 +350,13 @@ all::
 # or if that fails fall back on a "cp" instead of a "ln". Useful for
 # when you don't want hardlinks at all.
 #
+# Define INSTALL_FALLBACK_LN_CP if you'd like your
+# "INSTALL_SYMLINKS=Y" to fall back on hardlinks if we can't run "ln
+# -s", and for "ln" to fall back on "NO_INSTALL_HARDLINKS=Y" if we
+# can't perform a "ln" and need to fall-back to a "cp". This used to
+# be the default behavior, but we'll now error if we can't satisfy
+# your INSTALL_SYMLINKS, NO_INSTALL_HARDLINKS etc. settings.
+#
 # Define SKIP_DASHED_BUILT_INS if you do not need the dashed versions of the
 # built-ins to be linked/copied at all.
 #
@@ -3020,6 +3027,7 @@ endif
 	{ test "$$bindir/" = "$$execdir/" || \
 	  for p in git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
 		./ln-or-cp.sh \
+			--install-fallback-ln-cp "$(INSTALL_FALLBACK_LN_CP)" \
 			--install-symlinks "$(INSTALL_SYMLINKS)" \
 			--no-install-hardlinks "$(NO_INSTALL_HARDLINKS)" \
 			--no-cross-directory-hardlinks "$(NO_CROSS_DIRECTORY_HARDLINKS)" \
@@ -3029,6 +3037,7 @@ endif
 	} && \
 	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
 		./ln-or-cp.sh \
+			--install-fallback-ln-cp "$(INSTALL_FALLBACK_LN_CP)" \
 			--install-symlinks "$(INSTALL_SYMLINKS)" \
 			--no-install-hardlinks "$(NO_INSTALL_HARDLINKS)" \
 			--symlink-target "git$X" \
@@ -3038,6 +3047,7 @@ endif
 		if test -z "$(SKIP_DASHED_BUILT_INS)"; \
 		then \
 			./ln-or-cp.sh \
+				--install-fallback-ln-cp "$(INSTALL_FALLBACK_LN_CP)" \
 				--install-symlinks "$(INSTALL_SYMLINKS)" \
 				--no-install-hardlinks "$(NO_INSTALL_HARDLINKS)" \
 				--symlink-target "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/git$X" \
@@ -3047,6 +3057,7 @@ endif
 	remote_curl_aliases="$(REMOTE_CURL_ALIASES)" && \
 	for p in $$remote_curl_aliases; do \
 		./ln-or-cp.sh \
+			--install-fallback-ln-cp "$(INSTALL_FALLBACK_LN_CP)" \
 			--install-symlinks "$(INSTALL_SYMLINKS)" \
 			--no-install-hardlinks "$(NO_INSTALL_HARDLINKS)" \
 			--symlink-target "git-remote-http$X" \
diff --git a/ln-or-cp.sh b/ln-or-cp.sh
index 37380993c64..f77dad71bdb 100755
--- a/ln-or-cp.sh
+++ b/ln-or-cp.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 
+install_fallback_ln_cp=
 install_symlinks=
 no_install_hardlinks=
 no_cross_directory_hardlinks=
@@ -7,6 +8,10 @@ symlink_target=
 while test $# != 0
 do
 	case "$1" in
+	--install-fallback-ln-cp)
+		install_fallback_ln_cp="$2"
+		shift
+		;;
 	--install-symlinks)
 		install_symlinks="$2"
 		shift
@@ -61,4 +66,26 @@ main_with_fallbacks () {
 	fi
 }
 
-main_with_fallbacks
+main_no_fallbacks () {
+	if test -n "$no_install_hardlinks" -a -z "$install_symlinks"
+	then
+		cp "$target" "$link"
+	elif test -n "$install_symlinks" -o -n "$no_cross_directory_hardlinks"
+	then
+		ln -f -s "$symlink_target" "$link"
+	elif test -n "$no_install_hardlinks"
+	then
+		cp "$target" "$link"
+	else
+		ln -f "$target" "$link"
+	fi
+}
+
+if test -z "$install_fallback_ln_cp"
+then
+	# The stricter mode, where we know what we want
+	main_no_fallbacks
+else
+	main_with_fallbacks
+
+fi
-- 
2.31.1.461.gd47399f6574

