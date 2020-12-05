Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5139DC4361B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2854023128
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgLETyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgLETyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:54:09 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA441C061A53
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:22 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id o11so6045048ote.4
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WnIyT7njW7HfFDcj0vGojFOZxzUAKjNyd8U81ofpohY=;
        b=nYHvGVtpyDkmfLaUN0JBEI7ZNYhKYtY1EzX6fmG3oK/KQ5dJ4DLVqrvQDbnTIRERFY
         tNrU2+kPErAeJ6Q3RMRF1R33OdEJlpslz4/3J9EwK6bvZqTLSvi6BJcMMQzX4BAeLaIv
         9e5Ey7uTJ1SChcJx+xvjzwsdDHKnuhjf/TzCXrbCOET9bCH37q1BobNYhso41OHIqLZZ
         ePpXFlKFTmkJpdlK48gDGOczJICAkf8Ct3aTEv7rvLKB5AVmjtPoQD8pVDrYxbZ9qg9j
         cyZidvVhKt2Mh0zVkJylKuymh4ZnUbtJW6+6AsYS9xoUZBrCA37YhfHx6PlTRkLz2azE
         j97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WnIyT7njW7HfFDcj0vGojFOZxzUAKjNyd8U81ofpohY=;
        b=CAHaJddfb4aNWVwphEm7saSnsOUGQ5CIYN0ljUTPWrT8U4m+KIXF/qI50OX8/ysYrs
         tsKXlqtpTJ0yFm9Dj0sJm6IahR+IgoKHX8ks5YZ7PwwWSm39jjlEJeR+DTnU3BcVMo7H
         SR3Gyui80rIkO6r5dy2h7b+zQY+gA249URkeaJOClAQlGCPQVcHiSoBu6tj5ysI0V7rV
         qq7JiEmWYWuu98wgD2Bi00QePsMm5GjjfwUlPaJBSFBYhUw6+cC+AjsLuk92GQukiF+T
         D/fmmXLi68hbm2oETlksOXodKsvGU0j6FFaszGEHvJxEOTH7KuJgoWanA0l6bUpCzlXC
         vu2Q==
X-Gm-Message-State: AOAM5317f4wKXAfcocOa+JQ0BW/QMNhx0Wu1S4w3ZVzqT2WnuhRj0KjV
        +JXkWTcr2OizT+K245w1HFp/QyKRCuZjrw==
X-Google-Smtp-Source: ABdhPJy7qdr0/Lvjjp4F0B6i731FH0ukLIDw2EZCse8LVyKqk/RA1exzDL7G6cQoDXmPlOER3LEkPw==
X-Received: by 2002:a05:6830:1e1c:: with SMTP id s28mr1704937otr.82.1607198002069;
        Sat, 05 Dec 2020 11:53:22 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id e1sm1045213oib.11.2020.12.05.11.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:21 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 04/16] pull: cleanup autostash check
Date:   Sat,  5 Dec 2020 13:53:01 -0600
Message-Id: <20201205195313.1557473-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205195313.1557473-1-felipe.contreras@gmail.com>
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently "git pull --rebase" takes a shortcut in the case a
fast-forward merge is possible; run_merge() is called with --ff-only.

However, "git merge" didn't have an --autostash option, so, when "git
pull --rebase --autostash" was called *and* the fast-forward merge
shortcut was taken, then the pull failed.

This was fixed in commit f15e7cf5cc (pull: ff --rebase --autostash
works in dirty repo, 2017-06-01) by simply skipping the fast-forward
merge shortcut.

Later on "git merge" learned the --autostash option [a03b55530a
(merge: teach --autostash option, 2020-04-07)], and so did "git pull"
[d9f15d37f1 (pull: pass --autostash to merge, 2020-04-07)].

Therefore it's not necessary to skip the fast-forward merge shortcut
anymore when called with --rebase --autostash.

Let's always take the fast-forward merge shortcut by essentially
reverting f15e7cf5cc.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 7a5b343fe2..d2f80e8615 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -927,7 +927,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
-	int autostash;
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -960,8 +959,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	autostash = config_autostash;
 	if (opt_rebase) {
+		int autostash = config_autostash;
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
 
@@ -1030,13 +1029,11 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
 		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
-		if (!autostash) {
-			if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
-				/* we can fast-forward this without invoking rebase */
-				opt_ff = "--ff-only";
-				ran_ff = 1;
-				ret = run_merge();
-			}
+		if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
+			/* we can fast-forward this without invoking rebase */
+			opt_ff = "--ff-only";
+			ran_ff = 1;
+			ret = run_merge();
 		}
 		if (!ran_ff)
 			ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
-- 
2.29.2

