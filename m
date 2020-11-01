Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E60CC4742C
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059DF20B1F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh3ssEP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgKATeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbgKATeV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:21 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D1DC061A47
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:19 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id t13so12602705ljk.12
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0S/9aSkb4vHujavlerag9xYD5gdMVALanWm3rUMyrNY=;
        b=hh3ssEP+Zaqam5ylsMVK0ct7bbAZaohUzUASGwpk82iXBJI6JJGSujcXRgdbCviTM+
         cvP4k0B6XlesVGOMEPZ0qtsXKH58xKn6SUmZjm7tcq9p0ZQaKazFalXnihvjYRNoyo7b
         iKkbbjC+Wguy2I0KgsSzLyNr9LSlhnwk8p0Eqw/qhDm8yiAAXf1iDzmwiLJKmF7fBGr6
         AWAx5svP4zQkLe0Cb6DPe9/sFYLOtb3l1xTdYMxCyxUbDzWKFjU0mfpwmWVu1mDps+4h
         mW1kSes4dDrHQcLjaesJV+dvVq6JrFiJRNdkwo2t+ZGufcTSSa4ytaWNf9ZtpAgYC0eR
         5C1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0S/9aSkb4vHujavlerag9xYD5gdMVALanWm3rUMyrNY=;
        b=SoxhrC2BX9Lasx0Ss4Lch/A+bLYsYek0Z9wh4xhiQsHkETEmduIkX/YU5ZpUxyTBJo
         JWNaMzy2o6mejQ7TNI5tEl/qq9aKl14Gj3luUAi8/hOWTQg0BwwCTxvDU0ivp/hn5xOf
         RpA0Np6z+1OJDagcvVLm/Z9Aj5af5vxkEahdnm8LR5UZIhJNOyjr2YQlxMSRJDaTxm92
         DfNgGSJX+AszXT+VIEJejaztoid1iN9CGEZmZE5AselwFLQYd9WubQi683LWPsFQXTV6
         5PDHKAqqQFgI/rQE0iUQhtXWzv4bxEsGNRTlnbQidZfGsqV9i+/pg8qQ8XJ9gP6N0fH8
         QKQQ==
X-Gm-Message-State: AOAM533AU67ujncP03SZiWpY/3hZ6Bef3+KUeJvqeH2JWrRr2TEepdIU
        T5rVgr+020FTG30fB/sYpPWD99edBq8=
X-Google-Smtp-Source: ABdhPJzgZ5QdsrhAEOGTKhoufFsJVvds8ptwbiCPE6Qb0uu0i7eO/oqWUo73N9ekSGpvKYvPvV/ybQ==
X-Received: by 2002:a2e:9159:: with SMTP id q25mr5568315ljg.264.1604259258396;
        Sun, 01 Nov 2020 11:34:18 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:17 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 16/26] diff-merges: fix -m to properly override -c/--cc
Date:   Sun,  1 Nov 2020 22:33:20 +0300
Message-Id: <20201101193330.24775-17-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Logically, -m, -c, --cc specify 3 different formats for representing
merge commits, yet -m doesn't in fact override -c or --cc, that makes
no sense.

Fix -m to properly override -c/--cc, and change the tests accordingly.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c           | 1 +
 t/t4013-diff-various.sh | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index a30c730a457f..f2b9ed789ca8 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -29,6 +29,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 	const char *arg = argv[0];
 
 	if (!strcmp(arg, "-m")) {
+		suppress(revs);
 		/*
 		 * To "diff-index", "-m" means "match missing", and to the "log"
 		 * family of commands, it means "show full diff for merges". Set
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 64d9fce44614..8d8178a8a616 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -329,8 +329,8 @@ log --first-parent --diff-merges=off -p master
 log -p --first-parent master
 log -m -p --first-parent master
 log -m -p master
-:failure log --cc -m -p master
-:failure log -c -m -p master
+log --cc -m -p master
+log -c -m -p master
 log -SF master
 log -S F master
 log -SF -p master
-- 
2.25.1

