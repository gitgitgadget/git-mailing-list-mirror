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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA66C2BB9A
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 08:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241EC206C3
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 08:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgLOIre (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 03:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbgLOIrF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 03:47:05 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667ACC0617A7
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 00:46:25 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id d203so1352858oia.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 00:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYDiKYX/5IAMfGrlhEdxXBHLvJIRGCS8whMuAeHVwi4=;
        b=YYWmotE234DNWoQwuw0zeKplEESpaeGFGqYhq+Mc1tJikAKg8zdy495Ne5Ofxrc7zc
         sx6pKgYzkXuEUgEqVWiNjo1HbOaKCrnJSxxK/EmcOA+wmgGfPlT8ozhVZeSV0AgfNSOq
         OP+/sanFfIK+lmMKXFGFs44HWqvfrLx/VWhix9UBB7m44YioL3jJKTu/QHNgWjgigLIZ
         LewsBP5IPA7gum0WDUMPyFen5MTRR5l9WZt9l9UQARosQFVTKV9vZXvzMpamhGKt3/ka
         OPlsJ0QBGOMG44BZjBzKicMqefflYlJL8wWRDk/MR7+2pO6dVfgdOmHrhYtMURcjHZml
         2uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYDiKYX/5IAMfGrlhEdxXBHLvJIRGCS8whMuAeHVwi4=;
        b=r0+t287PmRxlsGOdHVSYtRVSGZB/J55THmrV9451iM7W5uBuT9+iJBTfJ6JVLgnQ1Y
         tJkP8pP1s6hFOCBNMD4iq5S1BlS7P535aoi0Sh6ECKhpU8etFZb3BJSy2XjzRqWcl/bH
         zRNIkeWRmyQditxoFn569avZa2IffAmhNMFnznhE50wN9bn9xWWxp/+8zT+XPjT2jMqH
         vhZfWIWDhsLSRTeupDa11IpQeC3lEdJzoGOn7BBtYpD4DQHLgW5i4ZVhGCZS5Ccg//oV
         DDBU5u+upMgR88GL5L3uuQrSpwZVOe3NpM8jxhge0YawGP/Vvx4mgrB+JnsfDRzZOX4G
         wEZA==
X-Gm-Message-State: AOAM532tEw/yO+iG86np27TlnfNJVF9Xmbvz2SaUFrK3b/Ms1Z2+EIGc
        ArUemGIFI590TrFJ5K798hzspmhqPoMS4Q==
X-Google-Smtp-Source: ABdhPJx9VMYK9U1vwVLAOhM68wdREkhjw28N7F1khWooQLDJnssui6pLyDIWT5CxHv8978fWfCWPdw==
X-Received: by 2002:aca:b789:: with SMTP id h131mr12896286oif.83.1608021984540;
        Tue, 15 Dec 2020 00:46:24 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id e81sm4928519oia.30.2020.12.15.00.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 00:46:24 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 2/3] pull: improve default warning
Date:   Tue, 15 Dec 2020 02:46:18 -0600
Message-Id: <20201215084619.1631180-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215084619.1631180-1-felipe.contreras@gmail.com>
References: <20201215084619.1631180-1-felipe.contreras@gmail.com>
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
2.29.2

