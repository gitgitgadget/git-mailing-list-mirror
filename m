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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABBCC2B9F4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 00:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C94E76135A
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 00:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFWAup (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 20:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhFWAuo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 20:50:44 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB54C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 17:48:27 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u11so1478665oiv.1
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 17:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2vpSXRWD/YYiN50XEwaHSmWo1XTViahuEbuyhrh1exc=;
        b=CoWv/0E+wobf00ZCSBCMmOZyaIW0sejQWBawJQUreNm92QxAdCEgwEcdkYymO6kav0
         2YTsiJCaox4iGwCtfWR4QmhfhCHUKmuYUFPcZeUJRR7WNS/CF257Y7fdvb4XxDG7ih+C
         62hM6kCl+EVRJq2yhvjlwZHM3GHXs+w5ZdhJTJMJfBashnQEwF/Lq3LHDUbgLoC8AedP
         dMxXbK8wrfQF8dFzx+pZimwLBXM9VkCQtWeBc2PFHG97+Qd/9y1Bc0STdcvr3P9IVgZY
         zadId1U/Pw/gNJLE0bFHaPm8rVbt5tUDAX7JLMKbvyVh0J3p5uNAlsgVhNwsqYS6OXWV
         69hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2vpSXRWD/YYiN50XEwaHSmWo1XTViahuEbuyhrh1exc=;
        b=dfb/cOFFQCIWSINkSnlnGz1kN5bUi+ixxry0qpMkd5zTdVrQD8I9tD5M5KGws1b12x
         SENs+gfhkCact2txtMZl/vrf5bmPrRu/a5IpBxcdsYk52y6eLhuPyQrzoYYOqa4cQeEw
         HtXNNYzdi5R7ocaIZ2UFU20rMKNoPbx+ZOGPJLHm0jlcG2mUc4zO/1zWUtxO76E6s8Fb
         28rxUF3dZWrYT/ytzRcX+K1aUrakxjEJGGIhnbEA2m8RoZ5mQDayDe+xKfspOODhAhpP
         VtaKAPk8Ut7P92jYYi8/geGjSWJO5ZEsHlHfbZsthy4aZahVrc5Ei7XYNBcrROkQPIB0
         AD4Q==
X-Gm-Message-State: AOAM530w5QmaVdz0G5Pql9fDDLvyBH7fCOqQJpFTNDDhdtUitSy7363m
        gupzswYwADvTzh1vtb3BF/pK+fa6d7vEUw==
X-Google-Smtp-Source: ABdhPJzvstzElj4f9zpQSVWKTJIED1rz/xKSOG0fcIIYR/XOjfd7capISSfiHwovXpeAvSH1hnbM1g==
X-Received: by 2002:a05:6808:a9a:: with SMTP id q26mr1170588oij.53.1624409306497;
        Tue, 22 Jun 2021 17:48:26 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id l7sm219182otu.76.2021.06.22.17.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 17:48:26 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/2] pull: improve default warning
Date:   Tue, 22 Jun 2021 19:48:15 -0500
Message-Id: <20210623004815.1807-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623004815.1807-1-felipe.contreras@gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210623004815.1807-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to feedback from GitHub trainers [1], most newcomers don't
understand what a rebase is. So in the default warning we want to
provide our users with a command that does the most sensible thing,
fixes the divergence, gets rid of the warning, with the minimum mental
effort, and happens to be the default:

  git pull --no-rebase (later --merge)

In addition, we don't want to start by recommending a permanent
configuration, but a temporary solution so they start training their
fingers and maybe learn how to do a rebase. So we start with the commands.

Also, we need to be clear about what we mean by "specifying"; merge, or
rebase.

Moreover, thanks to the previous patch now "git pull --help" explains
what a fast-forward is, let's mention that reference.

And finally, use --global in the configuration commands like we did with
push.default.

[1] https://lore.kernel.org/git/20130909201751.GA14437@sigill.intra.peff.net/

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 3e13f81084..ede2895ecd 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -927,18 +927,19 @@ static int get_can_ff(struct object_id *orig_head, struct object_id *orig_merge_
 
 static void show_advice_pull_non_ff(void)
 {
-	advise(_("Pulling without specifying how to reconcile divergent branches is\n"
-		 "discouraged. You can squelch this message by running one of the following\n"
-		 "commands sometime before your next pull:\n"
+	advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
+		 "you need to specify if you want a merge, or a rebase.\n"
 		 "\n"
-		 "  git config pull.rebase false  # merge (the default strategy)\n"
-		 "  git config pull.rebase true   # rebase\n"
-		 "  git config pull.ff only       # fast-forward only\n"
+		 "  git pull --no-rebase # the default (merge)\n"
+		 "  git pull --rebase\n"
 		 "\n"
-		 "You can replace \"git config\" with \"git config --global\" to set a default\n"
-		 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
-		 "or --ff-only on the command line to override the configured default per\n"
-		 "invocation.\n"));
+		 "You can squelch this message by running one of the following commands:\n"
+		 "\n"
+		 "  git config --global pull.rebase false  # merge\n"
+		 "  git config --global pull.rebase true   # rebase\n"
+		 "  git config --global pull.ff only       # fast-forward only\n"
+		 "\n"
+		 "Read \"git pull --help\" for more information."));
 }
 
 int cmd_pull(int argc, const char **argv, const char *prefix)
-- 
2.32.0

