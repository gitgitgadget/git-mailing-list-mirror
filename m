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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BE8C3526B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F1823B8C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgLRVLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgLRVLN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 16:11:13 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880B1C061285
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:33 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id f132so4253835oib.12
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iblx90t190+ni7k16wu8LQ9RY1VxmlRErEfCbCmp/ZU=;
        b=K/ZWAn/XCp4VVzJpK3wrBYMxW8gKGny4jWBlHpr9KJbzkrRMYHWj56DFSvPrvb3w4z
         Hpkd5XUK4AAJOSRoCPq5DTIcmy24/ROOengEvDxW2Xn094jS5677/VbdC8AAJW1Na5kl
         bkLdtkZm78K5dZ9h2fMaFOGeO/MsE82gQJDqgZPE4lhRGNbTYy9VBgZ4PtGeMcYKI87j
         8JYgMOf0YCI1q/VPDf+IcjSOvJtbTbqdeS6eBJHbG68iHs1A+921PfIMn/sA7FguqNUq
         8ICRKfRAeSrVGbSzqJiW0O1+qsTsQfH2d7C9ooiGkeu8NZBiF/8Ok00bQ7IXGrpjoZbB
         749g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iblx90t190+ni7k16wu8LQ9RY1VxmlRErEfCbCmp/ZU=;
        b=obUhaWKpcuALEFDfukkqB3t9EWYI/2XL78oEBkotE5pvmc4y3ulDNyUYVSNB9c7C2D
         6eCwrpe2QFH196OKjJNCRx4aAq2VhPoX6vv0cAQGhWrQ2VoDOJP6HK3uscL9YHlrass5
         yT/1FbOqp+7y1Dv0EWTDOxY0RCf6KM8tmatZKWWPYwxlkyI0MQPAK/+199W7qNs1tJjg
         nhuw9CRR4AKJyyy/wjvP5VgBW2gjpf4jDLzbS8xuyHrKyUyUNFJRa9RXZbr6G3zgsM6U
         tXImbdfJvgNMOYqK7qwR7r6Wxu4pyZWj/jtBAhR2hZmD+LvlAuZB4t5qLXVf78jw1iuM
         O0KA==
X-Gm-Message-State: AOAM530Ed3F3/0F+y9eDR5Jw0xr/9KPGlogigbcJld4mxuP6jV9sYTrU
        nr7GYgM4Qb0x9L2O/U1LV07kC3yhLzai3w==
X-Google-Smtp-Source: ABdhPJxkWpc5c55dTETJOZgM6Ys8uVuWBC2Cuf4CAfInSyALip4fbDNdv5JU3sPxsKSgidTReQTTVQ==
X-Received: by 2002:a05:6808:10b:: with SMTP id b11mr1849501oie.90.1608325832814;
        Fri, 18 Dec 2020 13:10:32 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k3sm2139848oof.31.2020.12.18.13.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:10:32 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 03/13] pull: cleanup autostash check
Date:   Fri, 18 Dec 2020 15:10:16 -0600
Message-Id: <20201218211026.1937168-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201218211026.1937168-1-felipe.contreras@gmail.com>
References: <20201218211026.1937168-1-felipe.contreras@gmail.com>
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
 builtin/pull.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index a766d9762c..42cd6c38d8 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -949,7 +949,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
-	int autostash;
 	int rebase_unspecified = 0;
 	int can_ff;
 
@@ -984,8 +983,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	autostash = config_autostash;
 	if (opt_rebase) {
+		int autostash = config_autostash;
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
 
@@ -1067,13 +1066,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
 		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
-		if (!autostash) {
-			if (can_ff) {
-				/* we can fast-forward this without invoking rebase */
-				opt_ff = "--ff-only";
-				ran_ff = 1;
-				ret = run_merge();
-			}
+
+		if (can_ff) {
+			/* we can fast-forward this without invoking rebase */
+			opt_ff = "--ff-only";
+			ran_ff = 1;
+			ret = run_merge();
 		}
 		if (!ran_ff)
 			ret = run_rebase(&newbase, &upstream);
-- 
2.30.0.rc0

