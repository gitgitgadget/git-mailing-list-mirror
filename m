Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688E6C388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 15:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55CF2177B
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 15:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgotc6M+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444103AbgJUPNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 11:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443906AbgJUPNe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 11:13:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147AEC0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 08:13:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h7so3553142wre.4
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 08:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=gkaXtwAugwBlsqioiSg1yhqDxAJkAyuEK+Tct3v81pw=;
        b=Fgotc6M++2+NGYSueNwsDSpguhLQgMocl19jcncUS6CGC9qfdJC7tWbKDQ8eAbg8XI
         ifHnPpARugp4DiVarrSYJIlBKYfHU/+5nS+hrnLJCKaRd056dDKPv5pV4YlIdgq7pbHF
         nrfyMjdtaU+Gj+plAd6MMLJNzFj32BcGx6IiZrooMbIUFrqpu2d7ReFlJ1v9Qaof2ppQ
         n8tvRVWkQFnlBu30g2O8XkQDESx8UTMawoFa3JJPc/Z1+2TsokQVnlVc2HBXmK1WQkSC
         +rF6d7/EpCblUBkwWDAtcwcoo8wRMPknsHeUc3lE8NI7snYsQqBGO4UivbeNvQwjTyHo
         o1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gkaXtwAugwBlsqioiSg1yhqDxAJkAyuEK+Tct3v81pw=;
        b=mUixW8CFlWHFJPPs6iVa+Qt6+g5mtHYRBnrKud/t9gixa5rZga5192mnq8S/HhKb1k
         cq3hHoY1qNQsv3mIkl36OhokF/tvejrifzBPyNQK1U4P8t73lZVCHTq+R3mqaUztEBop
         Ez4bWituAW4BHEFPzt1VREBZyHCxUVVH8Iq5XKqggAUzviKjwWADTYyQsxIh3rNUyQme
         8HmMeL9LDBRnwAPMAVn4Ws9h9zr01A4eyrkIWSqtcg/nyF8ib4cQ3xFxvuC+mw1fVfL3
         6SZ1Xrez65i6OdixaL8NWzTAlpOdY+tvfId9pj8FqZQEH1MmUfpiPP6c2KFdlcyHnHlV
         8Odw==
X-Gm-Message-State: AOAM530xvNMNedJKSM3A/RbTn3ggr0DxQ9AWd+l5c2f0Z2rEcisXGS3N
        qWqEFUM2s3FGCbsOeh7uh/8wKjEd6Mk=
X-Google-Smtp-Source: ABdhPJwQxW0lWcE0Qj3HXVgemAyXVujfrrSKgJPHN5xVXTGP93+UmjkMk7bHEQ/7BNobZxzuCqt2QQ==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr5371331wrm.295.1603293212606;
        Wed, 21 Oct 2020 08:13:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q8sm4382745wro.32.2020.10.21.08.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 08:13:32 -0700 (PDT)
Message-Id: <pull.768.git.1603293211428.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 15:13:31 +0000
Subject: [PATCH] SKIP_DASHED_BUILT_INS: do not skip the bin/ programs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael Forney <mforney@mforney.org>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The idea of the `SKIP_DASHED_BUILT_INS` option is to stop hard-linking
the built-in commands as separate executables. The patches to do that
specifically excluded the three commands `receive-pack`,
`upload-archive` and `upload-pack`, though: these commands are expected
to be present in the `PATH` in their dashed form on the server side of
any fetch/push.

However, due to an oversight by myself, even if those commands were
still hard-linked, they were not installed into `bin/`.

Noticed-by: Michael Forney <mforney@mforney.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    SKIP_DASHED_BUILT_INS: do not skip the bin/ programs
    
    As reported by Michael in 
    https://lore.kernel.org/git/CAGw6cBsEjOnh-ZqXCPfFha=NYEdy7JDddha=UzAau0Z1tBrWKg@mail.gmail.com
    , the SKIP_DASHED_BUILT_INS feature had a bug I wish we had caught in
    the -rc cycle. But at least SKIP_DASHED_BUILT_INS is still strictly
    opt-in, so the damage is somewhat contained.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-768%2Fdscho%2Fskip-dashed-built-ins-still-must-install-install_bindir_programs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-768/dscho/skip-dashed-built-ins-still-must-install-install_bindir_programs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/768

 Makefile | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 95571ee3fc..1fb0ec1705 100644
--- a/Makefile
+++ b/Makefile
@@ -2981,15 +2981,12 @@ endif
 	} && \
 	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
 		$(RM) "$$bindir/$$p" && \
-		if test -z "$(SKIP_DASHED_BUILT_INS)"; \
-		then \
-			test -n "$(INSTALL_SYMLINKS)" && \
-			ln -s "git$X" "$$bindir/$$p" || \
-			{ test -z "$(NO_INSTALL_HARDLINKS)" && \
-			  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
-			  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
-			  cp "$$bindir/git$X" "$$bindir/$$p" || exit; }; \
-		fi \
+		test -n "$(INSTALL_SYMLINKS)" && \
+		ln -s "git$X" "$$bindir/$$p" || \
+		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
+		  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
+		  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
+		  cp "$$bindir/git$X" "$$bindir/$$p" || exit; }; \
 	done && \
 	for p in $(BUILT_INS); do \
 		$(RM) "$$execdir/$$p" && \

base-commit: a5fa49ff0a8f3252c6bff49f92b85e7683868f8a
-- 
gitgitgadget
