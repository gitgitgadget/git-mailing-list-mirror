Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0512C4363D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E27C208C3
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 22:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrURtn2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgJFWFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 18:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgJFWFT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 18:05:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279FEC0613D4
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 15:05:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j136so353839wmj.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 15:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qHR3+3mHYmznNp1HGoR9hffJqdaCSV+4vNzb0cmV3ms=;
        b=VrURtn2h5D5CL1Y2aTaxFa7Ge3KTbaFLfT3THPQM+SuFLmQhJUWQgDJWlYKyKuZLYz
         oMNsCdJclqbAdzC6gf0oh4uVtuvJNEaNGP3VEcm8r+atUrRYEbYW+dLpoL41HFM2iy75
         IIBUBlXm/WiFWzywS+RM7wuFRxOwEJSsng4a2EEmOakyFa8TgYiglTMhzP+An5/p+788
         V5mHOOcaIcFwDpQm5K5M77S9sYSiscIIq1h1Q3PH8toqs3ju89IUpCwuOkVu2KxFwFuK
         JAeAhlH0Xkb4bvigoEzBjbmYMY2ZzsDtym1gDmTod5r8/KvJcewrrmYeYsdsbNsCmWKt
         7dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qHR3+3mHYmznNp1HGoR9hffJqdaCSV+4vNzb0cmV3ms=;
        b=bdRrm7rgMN5HXNXDTmyMoxPldcA03qrkVsFdowUt19EvPxRWUFFqe61MPtiIuDw2t5
         BK2uJQzi/J8BK48ncnOdx0V9x45vpXnMzry53vsLTxIxwURR0BZhvj4UrXaqfeOYszdn
         sbLTjc4oVWrexHaD1XeBqU503jls1XplCgAY7ky26S8bJHQKEgUEgQ5JD42tch2EGTlM
         kf30ABVWd5RMoHcT1gIHh9IPcgVt90lS4d9x+OwGuPqbPPkXiZa3T0vbqOe/Al6UOqCx
         F/Xtpdo8YAhNWIC2dAnmFVyajkgn5yQ69lc2Xxmkn/p0B9m1EeaLS6nRe3QpSlFa072G
         xfrg==
X-Gm-Message-State: AOAM5308mkJ+o8hA6NMZbXMI2sqBudBd5/xtpLTfyVNAn/siA9au0RNs
        JjJo0xxftbSrxeCv1EAt3fU4QQ15xA0=
X-Google-Smtp-Source: ABdhPJwVxnNktGj5P8TIwMvRwo3csr1Jsb7ZYZuPGV1tQRph8otL9l/ExIP1+xlST5wCOBWM95Kmcg==
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr11316wmr.179.1602021917723;
        Tue, 06 Oct 2020 15:05:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7sm195686wrm.6.2020.10.06.15.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 15:05:17 -0700 (PDT)
Message-Id: <1490ce111463b56eed35016c2e6232eea1faa3db.1602021913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
        <pull.493.v2.git.1602021913.gitgitgadget@gmail.com>
From:   "Tom Clarkson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Oct 2020 22:05:10 +0000
Subject: [PATCH v2 4/7] subtree: add git subtree map command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>, Ed Maste <emaste@freebsd.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tom Clarkson <tom@tqclarkson.com>,
        Tom Clarkson <tom@tqclarkson.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tom Clarkson <tom@tqclarkson.com>

Adds an entry to the subtree cache so that subsequent split runs can skip
any commits that turn out to be problematic.

Signed-off-by: Tom Clarkson <tom@tqclarkson.com>
---
 contrib/subtree/git-subtree.sh | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index c21d620610..1559100c0e 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -15,6 +15,7 @@ git subtree merge --prefix=<prefix> <commit>
 git subtree pull  --prefix=<prefix> <repository> <ref>
 git subtree push  --prefix=<prefix> <repository> <ref>
 git subtree split --prefix=<prefix> <commit>
+git subtree map   --prefix=<prefix> <mainline> <subtree>
 --
 h,help        show the help
 q             quiet
@@ -161,7 +162,7 @@ command="$1"
 shift
 
 case "$command" in
-add|merge|pull)
+add|merge|pull|map)
 	default=
 	;;
 split|push)
@@ -192,7 +193,8 @@ dir="$(dirname "$prefix/.")"
 
 if test "$command" != "pull" &&
 		test "$command" != "add" &&
-		test "$command" != "push"
+		test "$command" != "push" &&
+		test "$command" != "map"
 then
 	revs=$(git rev-parse $default --revs-only "$@") || exit $?
 	dirs=$(git rev-parse --no-revs --no-flags "$@") || exit $?
@@ -793,6 +795,21 @@ cmd_add_commit () {
 	say "Added dir '$dir'"
 }
 
+cmd_map () {
+	oldrev="$1"
+	newrev="$2"
+
+	if test -z "$oldrev"
+	then
+		die "You must provide a revision to map"
+	fi
+
+	cache_setup || exit $?
+	cache_set "$oldrev" "$newrev"
+
+	say "Mapped $oldrev => $newrev"
+}
+
 cmd_split () {
 	debug "Splitting $dir..."
 	cache_setup || exit $?
-- 
gitgitgadget

