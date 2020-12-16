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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DF2C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1175F2342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732249AbgLPSwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732248AbgLPSwD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:03 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6F1C0619D7
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:54 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o17so48051383lfg.4
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OeyXcDlj//79BfoPP0BqwvCMF5eH4ec16q5FSajBpOk=;
        b=rizME4yZ7Qu4OQOBUv+tjlGMaL0RbLgBNXnioj0kZupao6oau2HBCCueGHMZ7IS9Ab
         JYz3B3KiWxKg1zU9YzgJ6fvsYs2kzjQAbdRWvpk3wYE4nb4fq3GbrVOBGAW+T14KTJuW
         4azDSYGe2ZMklaz35o/iRXGhSA3qVl5swSev/eHToqJExQaX3ah55ja3PbIN6Babz9lX
         q8bKivZRU2sT7gaha8IRFnMDTjpNbkbsQuPn9j2t6TuRYfRaHbuDB/mZ9VblIUsNnXCQ
         I8hsxJgD27etLknJUmApU4oXujiDmU58roQkboLqQFQo2npaTnoUbhfL4eQ6ui5nTRrz
         Bj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OeyXcDlj//79BfoPP0BqwvCMF5eH4ec16q5FSajBpOk=;
        b=FSj24LVjB0OXzi9A97eZcNDQSwZrfdV8TmyIO9wWyiiQAen3OPdFeHWEtYVH/FTBR1
         gBPoafbqZgxi1IAdQC9Ef/UAU7kx1fDDG1Kga8eckePP2pRnJ9MBvvqlNvZU/loWmGNE
         VfBETZ93vBsVJfa+cNGYsQ1q+sCspPL+TSk+R4j3RdkZ2azQnPjR8OsW6/dUkFIJuLFR
         8d8z22FK2aDX8hgm2Q1TW7H31wYqx49bgfKp0mKHpimRrBUB7DjDqDg5tPGWQa6v54XW
         pXNuMXZNfZ3zEvBeO0nEoY/QRid4vqg5fFepea0WDUIhBjTwDLY6vvnYHPnI47+FZX3K
         2JJw==
X-Gm-Message-State: AOAM533nKIdU+6UJYplmSouMCh3h4FK8ePgEeqzByV7bhbOdjoUZZKQB
        dFUhLpL2nZ8hoQFyYlJ7kII=
X-Google-Smtp-Source: ABdhPJwON4IfXkHBBM3RSz6ueFzJ2bD4gKUQvi83EMpl43ORjrvOJRWYJBcR/tV72NzCi2QV09G6nA==
X-Received: by 2002:a2e:2a46:: with SMTP id q67mr14354717ljq.331.1608144652091;
        Wed, 16 Dec 2020 10:50:52 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:51 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 24/33] diff-merges: handle imply -p on -c/--cc logic for log.c
Date:   Wed, 16 Dec 2020 21:49:20 +0300
Message-Id: <20201216184929.3924-25-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move logic that handles implying -p on -c/--cc from
log_setup_revisions_tweak() to diff_merges_setup_revs(), where it
belongs.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/log.c | 4 ----
 diff-merges.c | 7 ++++++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 63875c3aeec9..c3caf0955b2b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -723,10 +723,6 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 	    rev->prune_data.nr == 1)
 		rev->diffopt.flags.follow_renames = 1;
 
-	/* Turn --cc/-c into -p --cc/-c when -p was not given */
-	if (!rev->diffopt.output_format && rev->combine_merges)
-		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
-
 	if (rev->first_parent_only)
 		diff_merges_default_to_first_parent(rev);
 }
diff --git a/diff-merges.c b/diff-merges.c
index 0165fa22fcd1..2ac25488d53e 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -127,6 +127,11 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		revs->first_parent_merges = 0;
 	if (revs->combined_all_paths && !revs->combine_merges)
 		die("--combined-all-paths makes no sense without -c or --cc");
-	if (revs->combine_merges)
+	if (revs->combine_merges) {
 		revs->diff = 1;
+		/* Turn --cc/-c into -p --cc/-c when -p was not given */
+		if (!revs->diffopt.output_format)
+			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
+	}
+
 }
-- 
2.25.1

