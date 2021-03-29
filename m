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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CFDC433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF6261970
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhC2QcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhC2Qb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 12:31:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FCCC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:31:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k8so13505554wrc.3
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZIF5VpYdYM3efNsRkPetV0hHOT254q5eciARxbBdoBc=;
        b=Wj/dnUsN3B7bpxrvqYEkVTmbzT50sV6u7BgxpCunv8fmRlq8JI7OnuO57wkbNz3vc8
         kw2/JOK8LNDaYtyizBB/kSS+g6V/XhS2y+zyBsQ+2Eu3Xnf3jzH+vooukZmizjdwYftI
         tQKfXVx1Q1ZjBvmNibkmzjbaC0HbWH7oHorYoH2NiG4GxUjoV5QaFw9MEVeY3oZMN5RH
         e9gxaKoHu5xSWJuuGaElN0webFO86q81UlkRWar87JNuo/MqhRcgp4i66kP9Jl1Zd24R
         iUdttZuZCgyOtjTmw/F3LUMvI4OWFQ1hXkfRiwq142tR46z6dbR6bUIb08lPBNtNgUSr
         +qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZIF5VpYdYM3efNsRkPetV0hHOT254q5eciARxbBdoBc=;
        b=VHE1yV5eSf18QWMaZHt3xN1MgXdX9z39qTGf4WRKzjS/VjWh4KmoJhi4rBr/YUBKKz
         qaAIuatNl/i9Kk4qBsCwIHMLPWOdJdjz5EO2OJT3zjjqwtIcJPG9OkFgrQbM7FTDBFel
         UUsG8p8+2Kss1xKD1AqsMsPQAa5Qs16qxALh+itwpr1XEZzhrOBhW3opt9e3yu4bMSJY
         z3pReXLRUq1kJu8cz4EMORQ4evq8NwY7N5zA6OHqzrgkgqjyVaZUK1SvLXXlHez07naq
         RqjMNfyh/oNJc1mbe3Uc5iRJfCUGs+pb1vajSrvJJSSvgxMMmfwMwg7HsC2md52lkI12
         JCfg==
X-Gm-Message-State: AOAM531wDrdAwIWMWO2wyQAZS91CccF6F9s9F1hZU/VqG1KAE90oMHla
        mL4453QNdhCq/wB8j42DqEgY9xcd6ByAOQ==
X-Google-Smtp-Source: ABdhPJwd9VdzIWd4pOv8zoSKKtGkvcKuyv4KorC3XOPX0b5I4q6VeqR+JMsLvFgbzCPWbmvpq1vewA==
X-Received: by 2002:adf:9d48:: with SMTP id o8mr29696016wre.183.1617035516746;
        Mon, 29 Mar 2021 09:31:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm25410464wmg.41.2021.03.29.09.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:31:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] Makefile: symlink the same way under "symlinks" and "no hardlinks"
Date:   Mon, 29 Mar 2021 18:31:39 +0200
Message-Id: <patch-1.7-39926acb0d1-20210329T162327Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.461.gd47399f6574
In-Reply-To: <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com> <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the INSTALL_SYMLINKS option was added in ad874608d8c (Makefile:
optionally symlink libexec/git-core binaries to bin/git, 2018-03-13)
we retained bug-for-bug compatibility with how the old
NO_INSTALL_HARDLINKS=Y would selectively fall back on symlinks.

In particular INSTALL_SYMLINKS=Y will result in a link tree like:

    bin/git
    libexec/git -> ../bin/git
    libexec/git-add -> ../bin/git

Whereas NO_INSTALL_HARDLINKS=Y in cases where the "ln" would fail would result in:

    bin/git
    libexec/git
    libexec/git-add -> git

I.e. we duplicated the "git" between the bin/ and libexec/
directories (by default they're hardlinked), and potentially had had
e.g. "git-add" pointing at the libexec/git hardlink (or more likely if
"ln" is failing, a copy), instead of the bin/git.

Now we'll instead use the same symlinks to point to the bindir. I
don't see any reason not to do so, and no breakage related to this has
been reported with INSTALL_SYMLINKS in all this time. I just did it
this way to maintain bug-for-bug compatibility at the time.

There is a behavior change here, if the "ln -s" fails we'll no longer
direct it to stderr. Supporting that edge case would be painful, and
as we'll see in subsequent commits that difference is going away
anyway, so let's proceed for now without retaining it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index ce76c476a3c..1e59d90a8d2 100644
--- a/Makefile
+++ b/Makefile
@@ -334,15 +334,16 @@ all::
 # Define INSTALL_SYMLINKS if you prefer to have everything that can be
 # symlinked between bin/ and libexec/ to use relative symlinks between
 # the two. This option overrides NO_CROSS_DIRECTORY_HARDLINKS and
-# NO_INSTALL_HARDLINKS which will also use symlinking by indirection
-# within the same directory in some cases, INSTALL_SYMLINKS will
+# NO_INSTALL_HARDLINKS. This will not produce any indirect symlinks, we will
 # always symlink to the final target directly.
 #
 # Define NO_CROSS_DIRECTORY_HARDLINKS if you plan to distribute the installed
 # programs as a tar, where bin/ and libexec/ might be on different file systems.
 #
-# Define NO_INSTALL_HARDLINKS if you prefer to use either symbolic links or
-# copies to install built-in git commands e.g. git-cat-file.
+# Define NO_INSTALL_HARDLINKS if you'd like to have programs in bin/
+# and libexec/ either symlinked (we try with INSTALL_SYMLINKS first),
+# or if that fails fall back on a "cp" instead of a "ln". Useful for
+# when you don't want hardlinks at all.
 #
 # Define SKIP_DASHED_BUILT_INS if you do not need the dashed versions of the
 # built-ins to be linked/copied at all.
@@ -3019,33 +3020,30 @@ endif
 	} && \
 	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
 		$(RM) "$$bindir/$$p" && \
-		test -n "$(INSTALL_SYMLINKS)" && \
+		test -n "$(INSTALL_SYMLINKS)" -o "$(NO_INSTALL_HARDLINKS)" && \
 		ln -s "git$X" "$$bindir/$$p" || \
 		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
 		  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
-		  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
 		  cp "$$bindir/git$X" "$$bindir/$$p" || exit; }; \
 	done && \
 	for p in $(BUILT_INS); do \
 		$(RM) "$$execdir/$$p" && \
 		if test -z "$(SKIP_DASHED_BUILT_INS)"; \
 		then \
-			test -n "$(INSTALL_SYMLINKS)" && \
+			test -n "$(INSTALL_SYMLINKS)" -o "$(NO_INSTALL_HARDLINKS)" && \
 			ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/git$X" "$$execdir/$$p" || \
 			{ test -z "$(NO_INSTALL_HARDLINKS)" && \
 			  ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
-			  ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
 			  cp "$$execdir/git$X" "$$execdir/$$p" || exit; }; \
 		fi \
 	done && \
 	remote_curl_aliases="$(REMOTE_CURL_ALIASES)" && \
 	for p in $$remote_curl_aliases; do \
 		$(RM) "$$execdir/$$p" && \
-		test -n "$(INSTALL_SYMLINKS)" && \
+		test -n "$(INSTALL_SYMLINKS)" -o "$(NO_INSTALL_HARDLINKS)" && \
 		ln -s "git-remote-http$X" "$$execdir/$$p" || \
 		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
 		  ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
-		  ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
 		  cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; } \
 	done && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
-- 
2.31.1.461.gd47399f6574

