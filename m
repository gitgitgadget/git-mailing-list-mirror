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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F45FC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA4022583
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgLDGRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgLDGRP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:17:15 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAE9C061A52
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:16:29 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id t205so4996359oib.12
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F6j4zcz+F8jnl8C6sJDoj9Jj9aLIQONW+a1m1oL90yU=;
        b=lr6rNBQwKZrnTVT1c8Hufwk7kJZ8VkwN2qEq8VbJ4NQ7evK7igtSqFIFzMPH5Mpqok
         ExgnYHEHnp4TDAWkmbdYIzGRuELeIhjgbzmPOMECiM60338emfc4rD3ziI5MVBvW7Jad
         S1/RiuxcHATxohaWbqie87PNNCJYrR4hzVqPcrSi73KfHNfNQ7h9nOA7GQo8FI3WirOT
         OpWROXY9Dtd/Ckv9f6duSjwvTLk/0QtVTypnC8fjWXVznIVBeqhYcyUZdiV67NFM0yh9
         2uWUVfHu5Y+3R3npEeU9uvFW99JZFQ212RBusK59gaZt6zwFvQsa/gZWuNahXgPV9KdA
         p/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F6j4zcz+F8jnl8C6sJDoj9Jj9aLIQONW+a1m1oL90yU=;
        b=h7BzGUZXX3mydbNHmx60rnYnOWyj/NA5AlOiPS+Xs7m6wH7M6t/UoM6kk4kvOAq9iC
         3X19IXeESgC/N0y4hDcSRv87zRaLf/O014FgsoL7yxL+kGPCibjyw/e6TqrQWnk2LTQd
         dHPr65cZBc4OTe/hMicU+dV/748xgPdO0WuPxE8w3wDB+Zo22FukwOuwHsyz33nLH7SW
         5g7MGqbOU1+i+XeRJEfUbm2uFIBlBL916axDrLS+CMWO22u8h8vCK3UOIxPlIP9WvLoA
         xopVWSChz82XXGZW/TgRPQd5VkclKBncCHvu6bs6Dm6K2GF0FnP/cOs8giFSuQSW3brG
         3yYQ==
X-Gm-Message-State: AOAM530VZlhPTwedg1Wmlv9vGuB09o1SqZIybKclKHNK8w/ZEWpq2eL4
        DkvLXVQb5hpV3tvrT3CEqUxD18q6bF5Oaw==
X-Google-Smtp-Source: ABdhPJwi6tcj73TgPyhIFUfVd0tRhQR7V1/VrMq4fP/0eVgcvG9OYnbPSdWASqM2rMXJFgJ54mqhHA==
X-Received: by 2002:aca:5402:: with SMTP id i2mr2161260oib.38.1607062588713;
        Thu, 03 Dec 2020 22:16:28 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id a21sm449751otr.36.2020.12.03.22.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:16:28 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 02/14] pull: improve default warning
Date:   Fri,  4 Dec 2020 00:16:11 -0600
Message-Id: <20201204061623.1170745-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204061623.1170745-1-felipe.contreras@gmail.com>
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to:

1. Be clear about what "specifying" means; merge or rebase.
2. Mention a direct shortcut for people that just want to get on with
   their lives: git pull --no-rebase.
3. Have a quick reference for users to understand what this
   "fast-forward" business means.

This patch does all three.

Thanks to the previous patch now "git pull --help" explains what a
fast-forward is, and a further patch changes --no-rebase to --merge so
it's actually user friendly.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 1034372f8b..22a9ffcade 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -346,17 +346,18 @@ static enum rebase_type config_get_rebase(void)
 
 	if (opt_verbosity >= 0 && !opt_ff) {
 		advise(_("Pulling without specifying how to reconcile divergent branches is\n"
-			 "discouraged. You can squelch this message by running one of the following\n"
-			 "commands sometime before your next pull:\n"
-			 "\n"
-			 "  git config pull.rebase false  # merge (the default strategy)\n"
-			 "  git config pull.rebase true   # rebase\n"
-			 "  git config pull.ff only       # fast-forward only\n"
-			 "\n"
-			 "You can replace \"git config\" with \"git config --global\" to set a default\n"
-			 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
-			 "or --ff-only on the command line to override the configured default per\n"
-			 "invocation.\n"));
+			"discouraged; you need to specify if you want a merge, or a rebase.\n"
+			"You can squelch this message by running one of the following commands:\n"
+			"\n"
+			"  git config pull.rebase false  # merge (the default strategy)\n"
+			"  git config pull.rebase true   # rebase\n"
+			"  git config pull.ff only       # fast-forward only\n"
+			"\n"
+			"You can replace \"git config\" with \"git config --global\" to set a default\n"
+			"preference for all repositories.\n"
+			"If unsure, run \"git pull --no-rebase\".\n"
+			"Read \"git pull --help\" for more information."
+			));
 	}
 
 	return REBASE_FALSE;
-- 
2.29.2

