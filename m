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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2A3C433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6AE6196E
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhC2Qch (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhC2QcA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 12:32:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1568EC061756
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:32:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x16so13486002wrn.4
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AICi09NDsUABqA5U7BcLjJnZgkFQBrDKkIZgWOBSbTE=;
        b=hiUNAaE5CZssLxirk10FhSdT+vHjYjiMIqclb57JzaRtgEPHPruedRo+pom42ViJst
         gJXHeGCLre3mrdTm5yNrJio1T/vFZ5zaBQF+G1tnLhZZMFjOgqPuclUYuSEwHRdO5AxV
         RPUdP9PYwuUSdGBDZ10jhEISQGnUuEVejaWeaG6QvERjUXGF6EQGcqt6SlZNMPdqQKHJ
         ttFKp4oAIMXeBIlGCwmQd6OGtjaY32tC8ag+1NTuT6bBL/yQX/zAJ4FGfondSz0z5Bye
         VPRN9SBbo+fB4P6wbnxPTeD7YCuZeoMzyn05YJGhoF7nKRVy6lFGE9WXPxbaWFxYzIIt
         WnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AICi09NDsUABqA5U7BcLjJnZgkFQBrDKkIZgWOBSbTE=;
        b=rubUbTrzIB6N3/J1qOBqYJ5XRR0c77x5SDbE4g2nLYCe0m/eVRUYnyRZNH8dvx5SvL
         NbglAox6KRYFVBV0/MygENLvlpeagYPPWjcBkeJXUQAx/SO7+Ip6Rc12Ow1NhkxwZ+Wu
         DjqhBRQddVfGS+qTa/7Pz7+i1XiLSK8cajbqZ+P/PMpUh+c+rthNSOp+se1snh7n8sH+
         ecyXIAjkrvAEHP76HRAfXy5IShf0an4GHjrq9oWOS03CXGAsPKyw1bMynY3YymDs0M2a
         F8in+RzQoff7snF5F/WGOcLmlhnKv4Ag6ZheP5em0gSFGpzjMX/vB+wbCjRWFfGPeWhd
         268w==
X-Gm-Message-State: AOAM532aQgAM5E2FHANr3Du4YWNIa7ox2MCyDBAZ9ZBGc7lFYNLkfRiz
        3x7XWCE5LwmTbLkaKyyoRhzf0ZBHvdbK8w==
X-Google-Smtp-Source: ABdhPJxkaLEhJh72Iet3j91apwprz6B6AnITIJZZSwXvV7CKdhyUuuzi7dyFP+dqk+7WOV0WrkcoyQ==
X-Received: by 2002:adf:8b58:: with SMTP id v24mr28745669wra.160.1617035518534;
        Mon, 29 Mar 2021 09:31:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm25410464wmg.41.2021.03.29.09.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:31:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] Makefile: refactor out "ln || ln -s || cp" pattern
Date:   Mon, 29 Mar 2021 18:31:41 +0200
Message-Id: <patch-3.7-bde9de756b4-20210329T162327Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.461.gd47399f6574
In-Reply-To: <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com> <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor out the hard-to-read and maintain "ln || ln -s || cp"
pattern.

This was initially added in 3e073dc5611 (Makefile: always provide a
fallback when hardlinks fail, 2008-08-25), but since then it's become
a lot more complex as we've added:

 * 3426e34fedd (Add NO_CROSS_DIRECTORY_HARDLINKS support to the
   Makefile, 2009-05-11)

 * NO_INSTALL_HARDLINKS in 70de5e65e8c (Makefile:
   NO_INSTALL_HARDLINKS, 2012-05-02)

 * INSTALL_SYMLINKS in ad874608d8c (Makefile: optionally symlink
   libexec/git-core binaries to bin/git, 2018-03-13)

 * SKIP_DASHED_BUILT_INS 179227d6e21 (Optionally skip linking/copying
   the built-ins, 2020-09-21)

Each of those commits had to add a new special-case to this code,
resulting in quite an unmaintainable mess for adding any sort of new
option.

Let's use the newly introduced ln-or-cp.sh script instead, note that
we only sometimes pass the --no-cross-directory-hardlinks option, per
the previous behavior. The target of the "ln -s" is also another
special snowflake, but we're careful to carry that forward.

As in an earlier commit this also changes the behavior to emit any
errors to stdout. In that earlier case that was done to simplify the
script so that it can use one "ln -s" instead of the two, likewise
we're now unconditionally emitting to stderr if ln (without -s, to
create the hardlink) fails. We always emitted to stderr if "cp"
failed.

As in that earlier commit let's let that pass for now, yes it might be
very verbose in some scenarios, but we're working our way towards a
simpler end-state here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile    | 41 +++++++++++++++++-----------------
 ln-or-cp.sh | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 81 insertions(+), 23 deletions(-)

diff --git a/Makefile b/Makefile
index cfc87d7734d..a4784f28f5b 100644
--- a/Makefile
+++ b/Makefile
@@ -3007,40 +3007,41 @@ endif
 	{ test "$$bindir/" = "$$execdir/" || \
 	  for p in git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
 		$(RM) "$$execdir/$$p" && \
-		test -n "$(INSTALL_SYMLINKS)" && \
-		ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/$$p" "$$execdir/$$p" || \
-		{ test -z "$(NO_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
-		  ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
-		  cp "$$bindir/$$p" "$$execdir/$$p" || exit; } \
+		./ln-or-cp.sh \
+			--install-symlinks "$(INSTALL_SYMLINKS)" \
+			--no-install-hardlinks "$(NO_INSTALL_HARDLINKS)" \
+			--no-cross-directory-hardlinks "$(NO_CROSS_DIRECTORY_HARDLINKS)" \
+			--symlink-target "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/$$p" \
+			"$$bindir/$$p" "$$execdir/$$p"; \
 	  done; \
 	} && \
 	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
 		$(RM) "$$bindir/$$p" && \
-		test -n "$(INSTALL_SYMLINKS)" -o "$(NO_INSTALL_HARDLINKS)" && \
-		ln -s "git$X" "$$bindir/$$p" || \
-		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
-		  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
-		  cp "$$bindir/git$X" "$$bindir/$$p" || exit; }; \
+		./ln-or-cp.sh \
+			--install-symlinks "$(INSTALL_SYMLINKS)" \
+			--no-install-hardlinks "$(NO_INSTALL_HARDLINKS)" \
+			--symlink-target "git$X" \
+			"$$bindir/git$X" "$$bindir/$$p"; \
 	done && \
 	for p in $(BUILT_INS); do \
 		$(RM) "$$execdir/$$p" && \
 		if test -z "$(SKIP_DASHED_BUILT_INS)"; \
 		then \
-			test -n "$(INSTALL_SYMLINKS)" -o "$(NO_INSTALL_HARDLINKS)" && \
-			ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/git$X" "$$execdir/$$p" || \
-			{ test -z "$(NO_INSTALL_HARDLINKS)" && \
-			  ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
-			  cp "$$execdir/git$X" "$$execdir/$$p" || exit; }; \
+			./ln-or-cp.sh \
+				--install-symlinks "$(INSTALL_SYMLINKS)" \
+				--no-install-hardlinks "$(NO_INSTALL_HARDLINKS)" \
+				--symlink-target "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/git$X" \
+				"$$execdir/git$X" "$$execdir/$$p"; \
 		fi \
 	done && \
 	remote_curl_aliases="$(REMOTE_CURL_ALIASES)" && \
 	for p in $$remote_curl_aliases; do \
 		$(RM) "$$execdir/$$p" && \
-		test -n "$(INSTALL_SYMLINKS)" -o "$(NO_INSTALL_HARDLINKS)" && \
-		ln -s "git-remote-http$X" "$$execdir/$$p" || \
-		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
-		  ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
-		  cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; } \
+		./ln-or-cp.sh \
+			--install-symlinks "$(INSTALL_SYMLINKS)" \
+			--no-install-hardlinks "$(NO_INSTALL_HARDLINKS)" \
+			--symlink-target "git-remote-http$X" \
+			"$$execdir/git-remote-http$X" "$$execdir/$$p"; \
 	done && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
diff --git a/ln-or-cp.sh b/ln-or-cp.sh
index de79cd85a81..663ffd0489d 100755
--- a/ln-or-cp.sh
+++ b/ln-or-cp.sh
@@ -1,8 +1,65 @@
 #!/bin/sh
 
+install_symlinks=
+no_install_hardlinks=
+no_cross_directory_hardlinks=
+symlink_target=
+while test $# != 0
+do
+	case "$1" in
+	--install-symlinks)
+		install_symlinks="$2"
+		shift
+		;;
+	--no-install-hardlinks)
+		no_install_hardlinks="$2"
+		shift
+		;;
+	--no-cross-directory-hardlinks)
+		no_cross_directory_hardlinks="$2"
+		shift
+		;;
+	--symlink-target)
+		symlink_target="$2"
+		shift
+		;;
+	*)
+		break
+		;;
+	esac
+	shift
+done
+
 target="$1"
+if test -z "$symlink_target"
+then
+	symlink_target="$target"
+fi
 link="$2"
 
-ln "$target" "$link" 2>/dev/null ||
-ln -s "$target" "$link" 2>/dev/null ||
-cp "$target" "$link"
+hardlink_or_cp () {
+	if test -z "$no_install_hardlinks" -a -z "$no_cross_directory_hardlinks"
+	then
+		if ! ln "$target" "$link"
+		then
+			cp "$target" "$link"
+		fi
+
+	else
+		cp "$target" "$link"
+	fi
+}
+
+main_with_fallbacks () {
+	if test -n "$install_symlinks" -o -n "$no_install_hardlinks"
+	then
+		if ! ln -s "$symlink_target" "$link"
+		then
+			hardlink_or_cp
+		fi
+	else
+		hardlink_or_cp
+	fi
+}
+
+main_with_fallbacks
-- 
2.31.1.461.gd47399f6574

