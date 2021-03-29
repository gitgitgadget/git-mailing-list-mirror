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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8438DC433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BAB6196C
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhC2Qce (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhC2QcF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 12:32:05 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C085CC061764
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:32:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j9so11776148wrx.12
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grBhtkkdpxxEo3tdbaS++MIc5r/3IQpDNol0/r/2tcs=;
        b=FoUQ94z89Ne+Rv1+xBBnPuHOM39O3aUP/Lq6rZqnhtITpj45S2EnAg3i0yDaAYuD+e
         WbhmXbAlQS3wy0LGBh00L+JiSAyWioooDbuKwV3yMtofULTM7YZDYMx7kZO7t97a7seZ
         2YKmnb3/mjX23Prty+nGCzg1x3XfZJZ2LHlu9TuE0W0mnqPLPnh6fSIw0WoTuIutpQCi
         LhDHBznqcWSB7/i9xGAN9yE0Ti1kr1Pu6vKf28UhISPztj/+U8ILcabIDKCK2PIammSX
         9sGcW4vRdATjBWjBlmh21hPi67wVN5y4x/yygnZDEGscLaLeRvZMdQuJE1LSdK0iRRXE
         bVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grBhtkkdpxxEo3tdbaS++MIc5r/3IQpDNol0/r/2tcs=;
        b=N1G3sFRSXHg6CLN+3xDM9fOApVf88r1f8iMSjJnDpRilRG+wdXGy5BityLR+EYrY7g
         BHf/fWeGai6cq86Yg8dY/i+r4urEIlkPjZpHqwx/kI1OO2ImvVr8aKEtJXwjDi49EBkA
         QlopLPIDtg3lJr8ggTdiYjmywyg7vxBveF4BhK/73rMwS/B6rgzCJFB4cZIXralJjc8o
         l3VUKMEZz0yd3oTKNl+0cR+UdGMyJhuqMl3yVOgOG/zMsJqv6wLFMT3McGWvfq/9sdND
         elKpywc5Itub3R3ZmliNvDAwPaw78i1/bDBeW69U7NSjT3YGxSRz2ZKFQWfFSZS/ctvh
         n8BQ==
X-Gm-Message-State: AOAM531MfqqvIKx/CGXVa2vWWBQAJKIj97I2t+jefl+D0chbLoFRCpJ2
        eA2P7ql1PLw74r6UO/JI8PpfSCTqIEzFnw==
X-Google-Smtp-Source: ABdhPJyawr2tP+QNaQso7mliQBOK3CIg6eoB5fT+5gll13UZ7Ljw/G8BsQEuqIAAlDJri5Ke9DWFXg==
X-Received: by 2002:a5d:4904:: with SMTP id x4mr29201302wrq.69.1617035520307;
        Mon, 29 Mar 2021 09:32:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm25410464wmg.41.2021.03.29.09.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:31:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] Makefile: use "ln -f" instead of "rm && ln"
Date:   Mon, 29 Mar 2021 18:31:43 +0200
Message-Id: <patch-5.7-f81708f6120-20210329T162327Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.461.gd47399f6574
In-Reply-To: <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com> <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the invocations and behavior of "ln-or-cp.sh" to not assume
that we're going to "rm" the file in question beforehand.

This reduces the complexity of these rules, and as a bonus means it's
now safe to "make install" on a system that may have running "git"
programs, before this we'd be racing the "rm && ln/cp" and wouldn't
have a working "git" (or one of the built-ins) in the interim.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile    | 10 ++--------
 ln-or-cp.sh |  5 ++---
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 29d9bade5a8..466df1a8e90 100644
--- a/Makefile
+++ b/Makefile
@@ -2204,8 +2204,7 @@ version.sp version.s version.o: EXTRA_CPPFLAGS = \
 
 $(BUILT_INS): GIT-LNCPFLAGS
 $(BUILT_INS): git$X
-	$(QUIET_BUILT_IN)$(RM) $@ && \
-	./ln-or-cp.sh \
+	$(QUIET_BUILT_IN)./ln-or-cp.sh \
 		--install-symlinks "$(INSTALL_SYMLINKS)" \
 		$< $@
 
@@ -2558,8 +2557,7 @@ git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
 
 $(REMOTE_CURL_ALIASES): GIT-LNCPFLAGS
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
-	$(QUIET_LNCP)$(RM) $@ && \
-	./ln-or-cp.sh \
+	$(QUIET_LNCP)./ln-or-cp.sh \
 		--install-symlinks "$(INSTALL_SYMLINKS)" \
 		$< $@
 
@@ -3021,7 +3019,6 @@ endif
 	destdir_from_execdir_SQ=$$(echo '$(gitexecdir_relative_SQ)' | sed -e 's|[^/][^/]*|..|g') && \
 	{ test "$$bindir/" = "$$execdir/" || \
 	  for p in git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
-		$(RM) "$$execdir/$$p" && \
 		./ln-or-cp.sh \
 			--install-symlinks "$(INSTALL_SYMLINKS)" \
 			--no-install-hardlinks "$(NO_INSTALL_HARDLINKS)" \
@@ -3031,7 +3028,6 @@ endif
 	  done; \
 	} && \
 	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
-		$(RM) "$$bindir/$$p" && \
 		./ln-or-cp.sh \
 			--install-symlinks "$(INSTALL_SYMLINKS)" \
 			--no-install-hardlinks "$(NO_INSTALL_HARDLINKS)" \
@@ -3039,7 +3035,6 @@ endif
 			"$$bindir/git$X" "$$bindir/$$p"; \
 	done && \
 	for p in $(BUILT_INS); do \
-		$(RM) "$$execdir/$$p" && \
 		if test -z "$(SKIP_DASHED_BUILT_INS)"; \
 		then \
 			./ln-or-cp.sh \
@@ -3051,7 +3046,6 @@ endif
 	done && \
 	remote_curl_aliases="$(REMOTE_CURL_ALIASES)" && \
 	for p in $$remote_curl_aliases; do \
-		$(RM) "$$execdir/$$p" && \
 		./ln-or-cp.sh \
 			--install-symlinks "$(INSTALL_SYMLINKS)" \
 			--no-install-hardlinks "$(NO_INSTALL_HARDLINKS)" \
diff --git a/ln-or-cp.sh b/ln-or-cp.sh
index 663ffd0489d..37380993c64 100755
--- a/ln-or-cp.sh
+++ b/ln-or-cp.sh
@@ -40,11 +40,10 @@ link="$2"
 hardlink_or_cp () {
 	if test -z "$no_install_hardlinks" -a -z "$no_cross_directory_hardlinks"
 	then
-		if ! ln "$target" "$link"
+		if ! ln -f "$target" "$link"
 		then
 			cp "$target" "$link"
 		fi
-
 	else
 		cp "$target" "$link"
 	fi
@@ -53,7 +52,7 @@ hardlink_or_cp () {
 main_with_fallbacks () {
 	if test -n "$install_symlinks" -o -n "$no_install_hardlinks"
 	then
-		if ! ln -s "$symlink_target" "$link"
+		if ! ln -f -s "$symlink_target" "$link"
 		then
 			hardlink_or_cp
 		fi
-- 
2.31.1.461.gd47399f6574

