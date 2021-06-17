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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0469C49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 16:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79FD361185
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 16:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhFQQUL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 12:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbhFQQTY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 12:19:24 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C545C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 09:17:15 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s23so7082157oiw.9
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c24Ox0/bSsimtusx1FwnsjZ6u0xEkq52lZzV9m3iDis=;
        b=Ejgo+mjnEq5dF/FtHIqqWbhf3HMAd1Flh307pmra76raMhwaIlrhLdzbmbu28IeNga
         f77v1CkkGuOIH5uAUUrVOPqDq5gaBYVIZTu3PreLyAD72TecvD+XlbYcMSFlKeaF3jB8
         xIk9np27QfTQAXyI9Ejn1FSpU2UAiyyH8l3hMRGAKhbz1GOzMmIhg/NxtH36vMB3z6KD
         3ukCRHsS4Ire6RrGL1mp4n7poT9PoyF+MkmxgKkrH75W+IGhju958vg9OWxpDfrPKsqX
         5KNFw8sheCPxkk6fFxbuT+4dwr+DsnomNea7+dD896SC1EkoDwtj8lbFJ3461muys2/L
         GWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c24Ox0/bSsimtusx1FwnsjZ6u0xEkq52lZzV9m3iDis=;
        b=LSa3R7rqTXYbJdDTiqK9g8XZgqL/Y/s9PqMwkIi6vZpCvHwHncBGFnxTlYgb98lxQh
         EO6181gy3jYP2EiI1ksdNVQYye3Bv3hunFUpItQhNamLK+rTyFjiRzh3raksyLTFmkj6
         BX6TrkhS1r/I6MKHS2Ub/CUG8NCmFZiurUTz3VJffPEhQHT+vG/bN9xsz/WsueKnxuix
         bX4LL3eknqrTtbMZITrlVS6KNpbV0OPniuUhRKKRHKYyezbPzDsJ7A0fwM+lMAbqGQea
         C+lLVMvjweDPFuq7hI5IIiWu2uoDtc1NmRr3AM6FLG66nNowXVW4RAy/f93HtkQgutl6
         wClA==
X-Gm-Message-State: AOAM533UhWIyk9qnh8BcVM9janqU7pfDW4MYG2p/XLIDUdUmR2Z/vBuU
        ONEFN1upET94KteHjk9Y+UDgU/uRpmaYqw==
X-Google-Smtp-Source: ABdhPJyU0Ygvi1uNJn/mdXhj+43q2EL5c+s4N4TS/EPDtdo/2iHwmxkNEc6WKH2iEpnFcbkMrlhLBA==
X-Received: by 2002:aca:b145:: with SMTP id a66mr3853508oif.177.1623946634314;
        Thu, 17 Jun 2021 09:17:14 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id h1sm1377072otq.59.2021.06.17.09.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 09:17:13 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/3] pull: cleanup autostash check
Date:   Thu, 17 Jun 2021 11:17:08 -0500
Message-Id: <20210617161710.81730-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617161710.81730-1-felipe.contreras@gmail.com>
References: <20210613045949.255090-1-felipe.contreras@gmail.com>
 <20210617161710.81730-1-felipe.contreras@gmail.com>
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

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index e8927fc2ff..a22293b7db 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -947,7 +947,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct oid_array merge_heads = OID_ARRAY_INIT;
 	struct object_id orig_head, curr_head;
 	struct object_id rebase_fork_point;
-	int autostash;
 	int rebase_unspecified = 0;
 	int can_ff;
 
@@ -982,8 +981,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_oid("HEAD", &orig_head))
 		oidclr(&orig_head);
 
-	autostash = config_autostash;
 	if (opt_rebase) {
+		int autostash = config_autostash;
 		if (opt_autostash != -1)
 			autostash = opt_autostash;
 
@@ -1065,13 +1064,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
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
2.32.0

