Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410C8C433E6
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA0A2074A
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbhA0INF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbhA0IEr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 03:04:47 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E98AC061756
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 00:04:07 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 6so906006wri.3
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 00:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqj6Y+/ybIFdAb+x+Qh0z9wl1WIicT2yrNJbXtx3hMQ=;
        b=aM1rqp7lM4YMZcHtiuztPFcXArWssRx49ZDsPSxvUTvJGtCZeZanfe9Ay/wDzsE6QH
         e8s+JUp4VbNNzV1sRmy2KwxrWGf8+B8zDmJj8wQ8JrxPo+ihAi7H7rtQkcm3juPSyZAd
         oUWy6qSN2KME1JoWpSoISV9Yr2PYqw+T07xhcs6FQ9cI9vsvO0+Uz18DavTWlZT7PbB2
         jam4WZocRnAGl7lLddDzEuCV7BWGyzZfLAU71CIw2eAvp1/zBmKtZqMLiNR931iGkU1M
         XyuzGU06PWFRm9V+ZPh+vR2Zu6QorqUxZ6t7jMq7s6rx5fv5eKl0Rour4n7v/sk70oXp
         iIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqj6Y+/ybIFdAb+x+Qh0z9wl1WIicT2yrNJbXtx3hMQ=;
        b=IbJYLnC0h8/xdkzH/yvNEGpTHdJvIN62qMgnaU1pcR+IboalBxs/mxPp4Mo56fPQ1G
         mLae5xF4tbQv0PMAN0zBU0a7jX7NwIQ1OC1l/cxCEkVkpr+GHY5s1R57WSS3wptZI/rp
         szdrW+gFkfd8GdselGyJEVYvcpRv/6Rfc3JIRtvkfG+0MnHh3ZfsZrT03/hsfv0scR3M
         HJv5V1aBe+HRjI6i/V3vfqPACknWba03GIN4ffCUEQKDJyF22YDPAmXSlKTaZQFYFffG
         iiJji5naNEvh7iCkGRB4Xe8yH+oJ5M17ZwnsMrOAGRB+4AZT7bqF8LjlcwrAeIeJT993
         vEaA==
X-Gm-Message-State: AOAM5323FTdvFq0PFcCPkR5eq7xto+t2l5lEP/Ljh+IbrKi/uYM0eAkc
        S2vlYr1+CbHosTdyGW2t1vEI/SQvQ1lQ6GN6
X-Google-Smtp-Source: ABdhPJw513BrPwuOd5v9nrQ4Mv+cm9wTgAHPyozEYkjjqhhHAzaX+wnRY4VGFA8rZBrWfpTzKqyIWw==
X-Received: by 2002:adf:ec52:: with SMTP id w18mr9825765wrn.65.1611734645664;
        Wed, 27 Jan 2021 00:04:05 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.116])
        by smtp.gmail.com with ESMTPSA id m8sm1850237wrv.37.2021.01.27.00.04.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 00:04:04 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v4 4/7] t2402: ensure locked worktree is properly cleaned up
Date:   Wed, 27 Jan 2021 09:03:07 +0100
Message-Id: <20210127080310.89639-5-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.395.g7821b4e95a
In-Reply-To: <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
References: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
 <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

c57b3367be (worktree: teach `list` to annotate locked worktree,
2020-10-11) introduced a new test to ensure locked worktrees are listed
with "locked" annotation. However, the test does not clean up after
itself as "git worktree prune" is not going to remove the locked worktree
in the first place. This not only leaves the test in an unclean state it
also potentially breaks following tests that rely on the
"git worktree list" output.

Let's fix that by unlocking the worktree before the "prune" command.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 t/t2402-worktree-list.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 795ddca2e4..1866ea09f6 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -66,6 +66,7 @@ test_expect_success '"list" all worktrees with locked annotation' '
 	git worktree add --detach locked master &&
 	git worktree add --detach unlocked master &&
 	git worktree lock locked &&
+	test_when_finished "git worktree unlock locked" &&
 	git worktree list >out &&
 	grep "/locked  *[0-9a-f].* locked$" out &&
 	! grep "/unlocked  *[0-9a-f].* locked$" out
-- 
2.30.0.373.geade8fefe8

