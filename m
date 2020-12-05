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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DA2C18E57
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7DD23122
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgLETyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgLETyA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:54:00 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB977C061A51
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:19 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id b18so8760591ots.0
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GXVjGoem5f0NEAh1LIHoLSM7rqoa25uwUgcRLLmjpIE=;
        b=EhKNPo5D91/KxcsJmsEWxPtfhwJPdZialwKPcQI+e1NZdo6PLRQM1P28MyE+k4YqmR
         4+M1ErXx0WvMFNHu4K/KXAEvBXde/8Dy1WyhIEfxfnr9m0cgLh7hyTPHH4Ubqu+KhsTC
         mhMX0DSwr3WsNxjwB50mF1tWKggVWs1ASJt3W0bBjfvqAGkNlszctrxOhHbs9K3XBych
         OuUYILIvO3AOwGB6VkndYoZmaIHu70ZZwzksC4gtHTExSZO77Cp/xIAN8FyMYVlV43hC
         Iqr1qnK0dHONXX9kssS52X7VabmGXyia/BnUM8FHxBxzqRwIS+TDAS7SE2RWX8nA3QV1
         376g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GXVjGoem5f0NEAh1LIHoLSM7rqoa25uwUgcRLLmjpIE=;
        b=T6ISnLcTNqgHlLBIDWfmn1yjx/7bAaM/uy4LHzuXvE7ocRZjr7uuqGeHZ1G4/gun9M
         465KxjjaD8EbAwPBACpMMv1Qlwy2784iF2vPCZRlBArrHF7AMVyvDs1vcQBCU79iF889
         YIeTIv6YhHiPSDEp7SZLgM+y0sJitssllVUv3jBgw0SX4Ea6E3G7vRyOiC+A6ulDBzYH
         g2xoFerWDi0X+GU8GHxP2zyT4EkG/jqUzHaL7P8Z8r2lPmK8sR9UUW5PIVUNBMCjVnOW
         VTfe4Qg30Dw/vySS1iZC8VQhxLX5lPCkEMxK6J+7tzzuU38RTEu0RO8sPppdoS3YpE0k
         ws4w==
X-Gm-Message-State: AOAM532YxK9MGQubf+jaZrXZgTUArOgDvVjKMi+NfmeLGcv//2rcesBG
        Yh54VgRK8gnW0vIIj/WYI6T8wJq6DYytHQ==
X-Google-Smtp-Source: ABdhPJzlaozsw9jW7BoHKtjCXAL9oqbfX55MYQjX3bq53LqgtuM2KQ7Vb4aiOMrAdlCQmhWqsYRQ9A==
X-Received: by 2002:a9d:1b2:: with SMTP id e47mr8122745ote.45.1607197999104;
        Sat, 05 Dec 2020 11:53:19 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id w64sm1634910oie.49.2020.12.05.11.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:18 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 02/16] pull: improve default warning
Date:   Sat,  5 Dec 2020 13:52:59 -0600
Message-Id: <20201205195313.1557473-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205195313.1557473-1-felipe.contreras@gmail.com>
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to:

1. Be clear about what "specifying" means; merge, rebase, or
   fast-forward.
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
 builtin/pull.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 1034372f8b..d71344fe28 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -345,18 +345,19 @@ static enum rebase_type config_get_rebase(void)
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
+			"you need to specify if you want a merge, a rebase, or a fast-forward.\n"
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

