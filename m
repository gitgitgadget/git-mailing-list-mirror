Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FB4C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC8B20739
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXwG924Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgGGGFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGGGFF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 02:05:05 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A62C061755
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 23:05:05 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id u12so30867150qth.12
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 23:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kz+B32RAnkGwyFTOficrsLGlVxZI6QmjCoh7Hu/8EmU=;
        b=vXwG924Q+OS7iLJ4UnTwdlvo0raSV35Nwht2fn0GQQfZ6k6FSUN+mrfpoun1FefSQe
         Nj6BlZbvmuTKmA8OUpjo1vnB3/wFBH1Du1qLo4xe+vcOIUviepUAfDibr68JzDiyrd2x
         cY8pi9qWSWuymy77/c7JqnCz3YBvJxR8Dd1ETJT27CUu96d5n91qUjLXQe9H45MleXWv
         2b3ycHFgM+wdqs/rcjmVNNWjz6pb5BwNHdQm8xR7bH5Laq7tKhkts8v4NDiD40uUTrlj
         A2Seq8d8p9qv4G7ZhvAjeq9837n1j5RpBX/cLjaqHDn5vOvUcsPIg07u0iUF5l3VNn5w
         WnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kz+B32RAnkGwyFTOficrsLGlVxZI6QmjCoh7Hu/8EmU=;
        b=hv+VF6ihIx2YBg66TRe7I6v9EVcSWv3yJAFSWWByquDNNy11QcELeKkhL1/KWhWicX
         3I9bHRkod7g0PS8GQh8Bqc48Uguj+0w74AsUjmaT4dXqG6pBb+GAvGb1jhdqLJji3NFi
         mWN0J/Jp+8lbmRyFkIYbFzqk4JBN286uBvigPw647dU9NvAOlVBORZbhFVslzTtQMlAp
         y4Kp7L4IvvtA/xtLvF2YVXeLPLibap17t0BIPFvm5GDhOZTugK/pI2mwdcei8I1h3PWH
         TD+24esaFmUruQx8+pBClyw3c0FJmgQQ++9PM0LyusJKaTf993fnY1KLjQ8xXS0Eba+v
         FY1Q==
X-Gm-Message-State: AOAM531bFTEdn7TX5p5x1XPfIXFGVBwvBu5fxcMb7LcQm8qHULJDCFrG
        uECE1OVRqre98TWI8zcWewXVDFaIXpU=
X-Google-Smtp-Source: ABdhPJyH7EuLJmVK+sAtXXkr1KxHH4Tga5y1+2x0tK6rKI6n1FWQTg22ZMLKM7WiqrYGYAzvAAYTrg==
X-Received: by 2002:ac8:4f50:: with SMTP id i16mr35393122qtw.216.1594101904348;
        Mon, 06 Jul 2020 23:05:04 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id k197sm23446778qke.133.2020.07.06.23.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 23:05:03 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RESEND PATCH v2 1/5] t3701: stop using `env` in force_color()
Date:   Tue,  7 Jul 2020 02:04:34 -0400
Message-Id: <654c864691866f644ff5ec92de5bfa0701645419.1594101831.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <cover.1594101831.git.liu.denton@gmail.com>
References: <cover.1593576601.git.liu.denton@gmail.com> <cover.1594101831.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch, we plan on making the test_must_fail()-family of
functions accept only git commands. Even though force_color() wraps an
invocation of `env git`, test_must_fail() will not be able to figure
this out since it will assume that force_color() is just some random
function which is disallowed.

Instead of using `env` in force_color() (which does not support shell
functions), export the environment variables in a subshell. Write the
invocation as `force_color test_must_fail git ...` since shell functions
are now supported.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3701-add-interactive.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 49decbac71..fb73a847cb 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -31,7 +31,16 @@ diff_cmp () {
 # indicates a dumb terminal, so we set that variable, too.
 
 force_color () {
-	env GIT_PAGER_IN_USE=true TERM=vt100 "$@"
+	# The first element of $@ may be a shell function, as a result POSIX
+	# does not guarantee that "one-shot assignment" will not persist after
+	# the function call. Thus, we prevent these variables from escaping
+	# this function's context with this subshell.
+	(
+		GIT_PAGER_IN_USE=true &&
+		TERM=vt100 &&
+		export GIT_PAGER_IN_USE TERM &&
+		"$@"
+	)
 }
 
 test_expect_success 'setup (initial)' '
@@ -604,7 +613,7 @@ test_expect_success 'detect bogus diffFilter output' '
 	echo content >test &&
 	test_config interactive.diffFilter "sed 1d" &&
 	printf y >y &&
-	test_must_fail force_color git add -p <y
+	force_color test_must_fail git add -p <y
 '
 
 test_expect_success 'diff.algorithm is passed to `git diff-files`' '
-- 
2.27.0.383.g050319c2ae

