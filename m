Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E039E1F404
	for <e@80x24.org>; Sat, 31 Mar 2018 15:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbeCaPPE (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 11:15:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40603 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeCaPOv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 11:14:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id x4so20597366wmh.5
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 08:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JQLaB+fVQn3iOqdFj9NPneWsDVR9KK3EZqApIFmvYlE=;
        b=tj3dlFEp+W8huZHyp1eaJV2neJZ6UA2KgLfjoRyophM0wjjFwEavmvTrg0zsX33KZQ
         ZMX/HAtIVkJNu74taT9ikW6F7vtBP6SmLOARwWOEiTnMcCHRG6BqkDptTWxbke3n9oT+
         S0TwfSTEfPGYdFWLma+twtq2WW6ogEzJ1g5/i9TH6wgs6LcKvhIYAeEXuXUV7Maro4BL
         rtkt3H60uVXLxiie8hqvG/VH2mK7QgdhbbR54CbGTcwn9+9wpNhbtAxLJMKZkfe97yE0
         TsGpIU53+M6/0B4CqykEwzpdBH27KzWlea2Kxu2LNPwMsLgSTju3ACFagLJ/LnC9Assq
         o1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JQLaB+fVQn3iOqdFj9NPneWsDVR9KK3EZqApIFmvYlE=;
        b=lCc1PpQD+Y3Ic5IJY5k1h3rCPseuP2At4Rq3VhtMeFd7OZJZ61EQT09jkGd2M5HFki
         uoRS4rUuN7XZOgRl1bg4FXiND//aPioqoWyde9+LGySk0PQfy/C4MwqNNRJv3lyf8ElI
         C43vjtj3RBqx/+3l3aNCJUjLlOP5lJtSn5bW1DPyPpJUV3K/G8uvf4snTOcnxkSw/TjB
         bZhtPXv0UB3Oq6pB9e4vQ3I/2loVPkJwaZdbrki9DvuQXu31++JwJOhrlduKiies1jDY
         SSLbUhZ4Dzn+RKs5tOOtX2xEaLL0txBQjeZs7awX+Ncny16HkxdjtzkS03OICd10grOQ
         j3RQ==
X-Gm-Message-State: AElRT7FP+tobdUV2GQbUIaFpRkwCqxwPrjbEsOyjbTb9foQ4NgNjigu5
        DNh5Xh8dI+rSyxiGtvWFhcVlZYao
X-Google-Smtp-Source: AIpwx49Zo6oPHFqUEHIYKvsC/2R79UO/CjpbNX4br9U4419Ky+PguTRR0zV57ReVjaJr2gE4Ue4/TA==
X-Received: by 10.28.234.207 with SMTP id g76mr5155366wmi.149.1522509290276;
        Sat, 31 Mar 2018 08:14:50 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id f22sm1015010wmc.3.2018.03.31.08.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Mar 2018 08:14:49 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 4/6] worktree: be clearer when "add" dwim-ery kicks in
Date:   Sat, 31 Mar 2018 16:18:02 +0100
Message-Id: <20180331151804.30380-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.78.ga2082135d8
In-Reply-To: <20180331151804.30380-1-t.gummerer@gmail.com>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180331151804.30380-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently there is no indication in the "git worktree add" output that
a new branch was created.  This would be especially useful information
in the case where the dwim of "git worktree add <path>" kicks in, as the
user didn't explicitly ask for a new branch, but we create one for them.

Print some additional output showing that a branch was created and the
branch name to help the user.

This will also be useful in a subsequent commit, which introduces a new
kind of dwim-ery of checking out the branch if it exists instead of
refusing to create a new worktree in that case, and where it's nice to
tell the user which kind of dwim-ery kicked in.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/worktree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index cc94325886..f686ee1440 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -444,6 +444,8 @@ static int add(int ac, const char **av, const char *prefix)
 
 	if (new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
+
+		fprintf_ln(stderr, _("Creating branch '%s'"), new_branch);
 		cp.git_cmd = 1;
 		argv_array_push(&cp.args, "branch");
 		if (new_branch_force)
-- 
2.16.1.78.ga2082135d8

