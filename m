Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A3EC07E96
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 12:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB0A611CB
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 12:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhGMMEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 08:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbhGMMEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 08:04:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71020C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 05:01:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f17so30134626wrt.6
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=IdoovwX3N7CwhT5RHzJXKYJUu2gcGrEbWoUvC4K9R4A=;
        b=aiO1c2BxnWiCqOFwABwF9IVITtdWtEh5KDGR3WsuwxLZ6XBQ9KbNS7IWyz2RQpIjgl
         M/IaBEcvj+N44Ei0rejamb6iagtZRFaYCkWhJviD94f1ciNaHu8X3YSRaJ2s80ubGwL+
         8rG2Ukx0hi6YOiFfGTY5aeubf10qohnkVD2OxFX4t0YOKRYpbipHXIhKENfJr+PvJh23
         Rxbz7oLNpyaFxy3TBv9i60Kr3c0zhz7l4Dgfh3f1VpjtbNncOa/lIh+MaeN6hchcR6+Q
         ICWdAswGrfFKFrOOY2twjswpSVUzpDmFRE8ujD9xTscgmyP8FpTEBJkZrhC1KrYOyNDi
         2J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IdoovwX3N7CwhT5RHzJXKYJUu2gcGrEbWoUvC4K9R4A=;
        b=XBaURyqk93K6alB/nVa0PQsXGviTQcbFuAZ97KvWYIotv0imwM9NxzEx9onS13EBYx
         V0HiMXPWgtbVfEv9DBTQD8Dlv3Oc4ZxL1ESy+DaQZp0HWS0XyC7HMzD64cUofi2KBkEA
         pCxgVwGsKHMCFvQO8vb4lJ7VVwQwJu2dCVhPNW80io51d6ajqKguODIN3yuP0RLJFVGi
         c5BjNlx/Ue+rJg7N+5ZHKkqYKRGRSijosZQhlpHH9Xw8AYxGtulEcZ6LpitYY5uIq2IF
         p72bnpz3TjbGmBJFewOvhgkcNDmicN1CA82gpiXkhWqQomzHs/MmJp7mltqQG8ZdtWgb
         lKaA==
X-Gm-Message-State: AOAM5305jxkLpU/ylIjwDXLQPuhF6OtzkKre1vHjWY8yir9IAW2e4vDC
        AXVjxMUFfHx1yvtFBuu9wiHuYRjij5Y=
X-Google-Smtp-Source: ABdhPJwWxRB5cxFoGJAR/htbIMJ9S5OpDpdfSnNTnZqb3hLaFG52s/qM9IZEKRRC/MxWeuB5cQdKZw==
X-Received: by 2002:a5d:4a4c:: with SMTP id v12mr5105325wrs.256.1626177678118;
        Tue, 13 Jul 2021 05:01:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17sm2194567wmq.13.2021.07.13.05.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 05:01:17 -0700 (PDT)
Message-Id: <pull.1045.git.git.1626177676801.gitgitgadget@gmail.com>
From:   "Jordi Mas via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Jul 2021 12:01:16 +0000
Subject: [PATCH] l10n: allows to translate diff messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jordi Mas <jmas@softcatala.org>, Jordi Mas <jmas@softcatala.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jordi Mas <jmas@softcatala.org>

Allows to translate the diff messages shown when the
user commits, indicating the number of insertions,
deletions and files changed.

Signed-off-by: Jordi Mas <jmas@softcatala.org>
---
    Allow to translate diff message

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1045%2Fjordimas%2Flocalize-msg-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1045/jordimas/localize-msg-v1
Pull-Request: https://github.com/git/git/pull/1045

 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 52c791574b..29db9ce079 100644
--- a/diff.c
+++ b/diff.c
@@ -2593,7 +2593,7 @@ static void print_stat_summary_inserts_deletes(struct diff_options *options,
 	}
 
 	strbuf_addf(&sb,
-		    (files == 1) ? " %d file changed" : " %d files changed",
+		    Q_(" %d file changed", " %d files changed", files),
 		    files);
 
 	/*
@@ -2606,13 +2606,13 @@ static void print_stat_summary_inserts_deletes(struct diff_options *options,
 	 */
 	if (insertions || deletions == 0) {
 		strbuf_addf(&sb,
-			    (insertions == 1) ? ", %d insertion(+)" : ", %d insertions(+)",
+			    Q_(", %d insertion(+)", ", %d insertions(+)", insertions),
 			    insertions);
 	}
 
 	if (deletions || insertions == 0) {
 		strbuf_addf(&sb,
-			    (deletions == 1) ? ", %d deletion(-)" : ", %d deletions(-)",
+			    Q_(", %d deletion(-)", ", %d deletions(-)", deletions),
 			    deletions);
 	}
 	strbuf_addch(&sb, '\n');

base-commit: d486ca60a51c9cb1fe068803c3f540724e95e83a
-- 
gitgitgadget
