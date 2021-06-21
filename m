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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25358C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 17:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12BFF613E8
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 17:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhFUR4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhFURzK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:55:10 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661C4C0611DD
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 10:52:40 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id d19so20792810oic.7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lclz4iAH94Mv4J1ozZVX7OsOWpxPPAPrA45f2ONaKGg=;
        b=SwbSSBia8O6fFuX5FdyupozrHykPmULOnC3o5pBLBudxxAocneOIWyJ2kc+RsF7Egx
         xs4T6S+R7x845z2mOaamP/lWLBFot6IEcdu3eLLzZB+D8/loQtebF8BeJsgkcrU2i+1A
         qECKnLpDRCOI9AqwIbxAywAY3ekIZ7pGWJ4NqU/xXb59YvDml/vo+fGCSbplFHCv5lte
         DPySyO4gorh7RJKfo0+WZzT3wFjQVkofhiQI+XoiWsIf8kWUMC1VmX8YL/vDPH6hV4hf
         FMh8xpJX4+JfhvUw+ay+HlqYUaJatC972DFPl87RQRmt6pF88wX6DwhO1ubXsdDx/YZZ
         XWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lclz4iAH94Mv4J1ozZVX7OsOWpxPPAPrA45f2ONaKGg=;
        b=YYskqhzVJNdwNHzovqvjXh1YeGarHUnIEJ5megUDIbh472wlw2YzUczLK8NThAlXnk
         4ZltjE1kacRIbw5se2D3TvGE/7wRLdKXZ4i7vroQkIB39h9Lr46RzNEjGsqBvIp/GDGd
         /VxkOc1B70ylGMgGO09N917cqQsilDUo6tc+BbHb9P2bKevEa3VhpwMvm/DmERZwN9ZY
         gBTKiyKY4a+vi9UiwePQuvIBkpWWTBo9lqe90YDtLhtM3D0pRH78+ZupLOWochUIRDvZ
         kBNbq607EjqF1L5pAdj/tdDTnMfWjzQ0l1m7Lyj8/wvcOfq5YWklu36Zqu5DyGHp97Mw
         mwBw==
X-Gm-Message-State: AOAM532stX0NdldViosvhF6IZC1RnGHlgJ1PYNpekFC9MTFcyg/DWcLA
        ++sh+3RdEPR/EAJK7GYl4SZF2r+zeiZVbA==
X-Google-Smtp-Source: ABdhPJxLQKZ4UpVqsVlVr7vwJ+U4s7RfvTOXUXMBa9qCi1jeic6+/LKxwADkI/M2QahlzB9iVb42Sg==
X-Received: by 2002:a05:6808:1388:: with SMTP id c8mr23420913oiw.68.1624297959607;
        Mon, 21 Jun 2021 10:52:39 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id g38sm4148233otg.28.2021.06.21.10.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 10:52:39 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] pull: improve default warning
Date:   Mon, 21 Jun 2021 12:52:34 -0500
Message-Id: <20210621175234.1079004-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621175234.1079004-1-felipe.contreras@gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
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
index 3e13f81084..48e25a5061 100644
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
2.32.0

