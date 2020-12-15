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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E626C2BB48
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 08:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4395A20702
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 08:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgLOIr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 03:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgLOIrH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 03:47:07 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30274C0617B0
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 00:46:27 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id j21so2047319oou.11
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 00:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KkYrVv2KHmTz7s4ZgMh7yIFtmkXt+jX3Cnc0G5u+1L8=;
        b=Fi3oR8FhthsO+oz+7anY+k0TFaTRghb3Rc0YU5sexmp77EoasRjivtA0EH8d83Pj0q
         iJg94utfRfSsfImwELVfUZ7/pcPJB/uGdJk9N4TN/eIJb0gXYBu1z2a8mkAhMV4idiGM
         YkWZltlDcYtydcuM8kFLKR4rSV0odBHQckMd4x6Wf5rJpB1TtwfvqKlwiY5u3MbGXs4G
         L+HOpi1XTwxZELyMLWu/WxgDLOwWBfacaM0du8MwH3e7e9iQ3EgyvzWjeEPZMCfjMLwp
         yP6IJoFWVyl0Z9QQ2g5YpJz4dGRekwGjmKs3erDc4koiRkaEgJgV3y+lunEM+6rHxvM9
         TZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KkYrVv2KHmTz7s4ZgMh7yIFtmkXt+jX3Cnc0G5u+1L8=;
        b=deZ240WfKyV1BbPvDPv4ADHE1OmJu4BYdvz1iTrrYXQnpORY36/aX3qx+mkHJ1UoFb
         IHL5pvktZXtIDCArWc0wDIJy+M4aFDOnvJ7ZY4xl+lXsK0OkjK0hNaTlRV6/TVQu2FlR
         xugeQg7IOit9RjvgSiZ83vW/eVHjF3dN0GQ92jX5yR7ajVRW5lgUx361FreLeGcUyNkm
         FprRDUhWyOjZXfcqt1OidwBLgiLGGnGvoFNriUXME8RDhvh5M0v8nwGNFm+Uf5+Yrg2C
         asLeqV8rESnwleT3hcFZ8LMOPqjDrs8drgWRKKSMe5MDUOQBEW81WYcpyuFPNWyjlRsN
         F64g==
X-Gm-Message-State: AOAM530lXOSevTK8GWjCn4kl8XzAHBEcD2TH5AEcIOsNyyis4k/iEo3T
        9/+rKHzjr8LoC1vr11S9ds0a6YYVfdFvRA==
X-Google-Smtp-Source: ABdhPJy+y7c9InlXpDFqlr/hU0X/nX66dADnDqDrNKa3FJ0PJFhpJJAAf4UCEodgkKx4BqFPtFBz0w==
X-Received: by 2002:a4a:9c5:: with SMTP id 188mr12794810ooa.77.1608021986392;
        Tue, 15 Dec 2020 00:46:26 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t24sm4584105oou.4.2020.12.15.00.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 00:46:25 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 3/3] pull: cleanup autostash check
Date:   Tue, 15 Dec 2020 02:46:19 -0600
Message-Id: <20201215084619.1631180-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215084619.1631180-1-felipe.contreras@gmail.com>
References: <20201215084619.1631180-1-felipe.contreras@gmail.com>
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
2.29.2

