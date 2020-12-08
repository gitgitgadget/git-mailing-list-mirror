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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E9EC433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E38723A1D
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgLHA1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgLHA1f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:27:35 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BD6C061794
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:26:54 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id w3so13718605otp.13
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q7vfJsdKwpyOOb5B9x65dJX00pCAZfHVrRHwfnSlfxI=;
        b=IA0C/LLGir2Fk2anVfpb6JTwNxyEakNdoL/xGvCd0+YkHPEK7fSb5jFjYj0xQOtIVF
         XdSrwFki+Q+2axzYNdhKOT4Q0OBhw1iNuwiuyYg8ifXequUbN8w9Z+IF/RD+gd/81nVI
         CJ/9OwsdAo2u9x31KUU0e+ESb3KXTY7Kr2UAIvgP0C/RpRIm99SSpDbeeDEwUdWcNPC9
         HESdBLKPR7P2U1+5u9HaZU/ouu/t1x1N9qx8oeZxhNTTMSnTNjpfdyDXq/cqPhiEA1nw
         r30KsW+ZkUYsFb7YV4khezCLmi9gt5u4469aVSwyKOtAj9bPMbKu8wGcDTOChCwBYD6V
         yS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q7vfJsdKwpyOOb5B9x65dJX00pCAZfHVrRHwfnSlfxI=;
        b=eFhR98t4N8eelZIPX4fxYgF2bwTnC93NW28+S8nsqCC2HVUNJ8KYoSEkQvQV/jNnr0
         nnPZYkM4A2LgT1QThp3EFYW+8ErXQ5r6pWnu2P6qBzSJVlOrod9l0BIXF13Ym4bVe1ux
         dOthbdLx88kuymY6HibzGJyMvb6+IE8Kp1U1zOvse7NEO/VvLxpXXlwuCO3HCYvF3wu9
         jOHLnUkH6NXXvzm4Q6PBtFX0mXLTib1qB5WnZJY/706E9cWt/hkjQcRELbG1BM4ieFZd
         BSmOaWP2BmXMgOSqb41fxEbOHLQhRwo1x1FNrVjZBDMTcG4pZ2QEEiRVHGMHBuf+vV2c
         TgKQ==
X-Gm-Message-State: AOAM533Q+8yZEEXRcYC+TOdlLgZIA1mBdylabKZfmnWPZOWcDynarRvF
        pPBvTEbzPMYX+Eih5KrAm7ZkwIt/2fdH5Wrq
X-Google-Smtp-Source: ABdhPJxuTShMlsDmwhtj9F5Th8QKxMlcxWBvEK0tN1aX8vFlb14gzMFR07PtmwMpEB3T3iGvKsfjBQ==
X-Received: by 2002:a9d:6d05:: with SMTP id o5mr14598316otp.158.1607387213985;
        Mon, 07 Dec 2020 16:26:53 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id i82sm3324862oif.33.2020.12.07.16.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:26:53 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 02/19] pull: improve default warning
Date:   Mon,  7 Dec 2020 18:26:31 -0600
Message-Id: <20201208002648.1370414-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to:

1. Be clear about what "specifying" means; merge, or rebase.
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
 builtin/pull.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index aa56ebcdd0..d6e707f8f9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -345,18 +345,18 @@ static enum rebase_type config_get_rebase(void)
 		return parse_config_rebase("pull.rebase", value, 1);
 
 	if (opt_verbosity >= 0 && !opt_ff) {
-		advise(_("Pulling without specifying how to reconcile divergent branches is\n"
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
+		advise(_("Pulling without specifying how to reconcile divergent branches is discouraged;\n"
+			"you need to specify if you want a merge, or a rebase.\n"
+			"You can squelch this message by running one of the following commands:\n"
+			"\n"
+			"  git config pull.rebase false  # merge (the default strategy)\n"
+			"  git config pull.rebase true   # rebase\n"
+			"  git config pull.ff only       # fast-forward only\n"
+			"\n"
+			"You can replace \"git config\" with \"git config --global\" to set a default\n"
+			"preference for all repositories.\n"
+			"If unsure, run \"git pull --no-rebase\".\n"
+			"Read \"git pull --help\" for more information."));
 	}
 
 	return REBASE_FALSE;
-- 
2.29.2

