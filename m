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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AD4C433FE
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 16:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F0F22475
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 16:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391571AbgLLQxJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 11:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407687AbgLLQwy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Dec 2020 11:52:54 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1076AC0613D6
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 08:52:14 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id i6so11377183otr.2
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 08:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3PT9LCslgiY/W+NqHL+fY1JTdNNRFQb5v7N6kfp9sSM=;
        b=gc6jREnC1PDNIiXm3HGDgTbgHN4jPXquPs88d7fdCeONI1MI4Fn+wvdvdvwQDiTJNY
         6DcjPRgJid/284Uf3I3jM1zUiRmfsnoXb7d5AxoGhUELl7bCmBETd7ALttPwZduh4kM5
         gfCNQ5YU6kVsLx2iMVKqSqGmFatTL+LENEVpNbyk3JiPYPgaPYwY5HgYybBngRw/n3iz
         Y1wzhkb58zb9hhQX7evTfCatn8VA0qwk5q3c0xoQXE6RLsd04jgEZt3guj1NTHP/IxyW
         2yv1fAo2j/dUAcx7kqYe0e8g+FEjhwpoq5/M5bOmffCBVpP7ssf02aA6PIAYgbAXKypr
         smIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PT9LCslgiY/W+NqHL+fY1JTdNNRFQb5v7N6kfp9sSM=;
        b=kzmQ3zehL9whm7hkWq+JO2TRnisGKVrICekpssaRceK98Z+kpPX2Ls6w3XNOGCJ33X
         CxovlKfQ36hl+cLy3KEusEV0mP9oavtoYL4pGt1OQrOFBZ7BYdklvHO1WS+5f6fgOwJa
         JWwgSXgZRQw/gZNOnZDERnQ/mkm4wjXAvhOqGtiXI7uqMEPE0t9F75XhceJfQ8oIdd/G
         jEVSLF93VSVzJC7Ksw4y4iaSF2edrzVa7qDs7nNGwcUyNPe1RpTZrGG2L35KYinm8cfW
         k6QjHrXge/MeyOgAutFdiU8sLgcasPnUM99Aynkd6UZI9zyWDN43FcZjDXFtj1G/ec52
         1ymg==
X-Gm-Message-State: AOAM531CBhnXF/ikS7LgHCKU4HZ3gwnk+OG6fU0Rx8pKaB/uuCTX2jsY
        BXXELk5IVCjT7tSiSLAVHbY8o8qsg0Ju3Q==
X-Google-Smtp-Source: ABdhPJyDENwvSxTd4cNVbGHvtycv8hVFFELPI3U7HqQET24WgnlkRzZoGvYpfS+Y9O0i+hdWDNNsPA==
X-Received: by 2002:a05:6830:240d:: with SMTP id j13mr14108809ots.319.1607791933154;
        Sat, 12 Dec 2020 08:52:13 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t19sm2863840otp.36.2020.12.12.08.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 08:52:12 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 2/3] pull: move default warning
Date:   Sat, 12 Dec 2020 10:52:07 -0600
Message-Id: <20201212165208.780798-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201212165208.780798-1-felipe.contreras@gmail.com>
References: <20201212165208.780798-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eventually we want to be able to display the warning only when
fast-forward merges are not possible.

In order to do so, we need to move the default warning up to the point
where we can check if we can fast-forward or not.

Additionally, config_get_rebase() was probably never its true home.

This requires a temporary variable to check if we are in the
"default mode" (no --rebase or --no-rebase specified). But this variable
can be removed later on with further code reorganization.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 03e6d53243..ff8e3ce137 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -27,6 +27,8 @@
 #include "commit-reach.h"
 #include "sequencer.h"
 
+static int default_mode;
+
 /**
  * Parses the value of --rebase. If value is a false value, returns
  * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
@@ -344,20 +346,7 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
-	if (opt_verbosity >= 0 && !opt_ff) {
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
-	}
+	default_mode = 1;
 
 	return REBASE_FALSE;
 }
@@ -1040,6 +1029,21 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_rebase && merge_heads.nr > 1)
 		die(_("Cannot rebase onto multiple branches."));
 
+	if (default_mode && opt_verbosity >= 0 && !opt_ff) {
+		advise(_("Pulling without specifying how to reconcile divergent branches is\n"
+			 "discouraged. You can squelch this message by running one of the following\n"
+			 "commands sometime before your next pull:\n"
+			 "\n"
+			 "  git config pull.rebase false  # merge (the default strategy)\n"
+			 "  git config pull.rebase true   # rebase\n"
+			 "  git config pull.ff only       # fast-forward only\n"
+			 "\n"
+			 "You can replace \"git config\" with \"git config --global\" to set a default\n"
+			 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
+			 "or --ff-only on the command line to override the configured default per\n"
+			 "invocation.\n"));
+	}
+
 	if (opt_rebase) {
 		int ret = 0;
 		int ran_ff = 0;
-- 
2.29.2

