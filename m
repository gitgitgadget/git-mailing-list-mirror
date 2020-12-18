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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F269C2D0E4
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5181423B8A
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgLRVLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgLRVLM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 16:11:12 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151BEC061282
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:32 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id p126so4296993oif.7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qeZueia3JmAKGtXPiZEnwXas/1iWvyNIvfXqqhCkiJo=;
        b=a1h1Y8r8ry7rmLCoG5r7edxw5OU5UTignZptUGqzGn1XlD3UyDwjnGLKO/e3RW7/sm
         +6q89RFVFGe+Vwf33l/Zio5ZtrDnCIMtRtGxVHIOrwDE9rBFnqUF6n4QIfVOr9qXAeYh
         HohwXVrSewsJwLe0Y87+jF+q2G0e6X/5qRdDX3CoBD8aXWUmTIkqaatrUEdzLs2xilUF
         HrzBN253cnC6LZI62Rn0WwnMTukFJjgbgWhSSCKM4d2yEY8cboMTX8CPvIRQsw1d/OEn
         raYeVVSoKJRQuZnIl6fJbkFIMFOsgI3upMap08Tnvp0c1lzp3dtHzdQAEh0amBCvLuTe
         uu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qeZueia3JmAKGtXPiZEnwXas/1iWvyNIvfXqqhCkiJo=;
        b=rkl18pGD/2HXD3BKqM08ljINmvQwT1ukpM4EnlqXi0sovpipMIczlqZkXgYRs1+3+/
         /yrYqNyTCwBnu+cWmMyi+BBJYcWDYDxDrx1OObRAJFm3m0obhn8FCbOuC5C9dWdyFz7/
         urL0JqueUCgjQQPaIe1jbk90+jaJLGdXmNhGcjpdotQbq6ttlO6PtOv/lQtX8MzKL6bR
         WDjHldqDWCGWpM1Rx2s3uMgXRovcpLzbj0rL9Pj9VRkMk7qWyEue2Sz0EQfFqLvg3nii
         QjsC5rjA0l+ETMLb2DxBH8W244IIQ6sJ9N4JVE75BoPX18iG7TR6Jk8u08zwoFcMvNuM
         D3eQ==
X-Gm-Message-State: AOAM5336pBljBrIZgLsj6x/BEYFUeLqVVegYLUoH9pKoeZHdcbudn1fC
        7NmDfLfH2IUPtbEp4esWYsvfKRq2tf9UKA==
X-Google-Smtp-Source: ABdhPJzxKrr9lVuYh90zlIs8zBka8EJSoj350JQ5JssFTxwAgFwJT2gY4EII0IzYLlum9oFDRaBaAg==
X-Received: by 2002:aca:130a:: with SMTP id e10mr3932031oii.163.1608325831216;
        Fri, 18 Dec 2020 13:10:31 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id i25sm2121586oto.56.2020.12.18.13.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:10:30 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 02/13] pull: improve default warning
Date:   Fri, 18 Dec 2020 15:10:15 -0600
Message-Id: <20201218211026.1937168-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201218211026.1937168-1-felipe.contreras@gmail.com>
References: <20201218211026.1937168-1-felipe.contreras@gmail.com>
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
 builtin/pull.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index e8927fc2ff..a766d9762c 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -927,18 +927,20 @@ static int get_can_ff(struct object_id *orig_head, struct object_id *orig_merge_
 
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
+		 "If unsure, run \"git pull --no-rebase\".\n"
+		 "Read \"git pull --help\" for more information."));
 }
 
 int cmd_pull(int argc, const char **argv, const char *prefix)
-- 
2.30.0.rc0

