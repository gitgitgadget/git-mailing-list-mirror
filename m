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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC51EC433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 10:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 883AA23609
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 10:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgLJKGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgLJKGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 05:06:25 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5257C061793
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 02:05:45 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id p126so5125506oif.7
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 02:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nlaH2HiQHdcJora12BW7DR1eNVAaESPKLIf3N1gK6YQ=;
        b=BcgXfmaGKKh8Z1UVZPJBHzJii9BhJIiz6kqKZsLpbrCmiT8/U9fYUA8PyrEiKV1DY+
         jnpezF/nVp32eizHibpKhDZVoEKDC6XRomt4rAtleZC8R9j8gVj5b2ruOa0Jd+qwg7X2
         Bv3XfV5Phx8j/F45GxKf8c49FShEn4TcslpitgKUeWphzcJ56lBfTGZuOIrjuzTyIgGJ
         GTKb4PbCM/9Ih433vSXpkfNo8McRsh2rjabw2OtP0UXKq77Zd4f4Ig7LbBdH2fLh8z7o
         mW8j71rJrBrBS5qsoSLELptfAow2acAADXuXJCP5zir8qaROxkJv4BcWvVijbRby/XoB
         bCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nlaH2HiQHdcJora12BW7DR1eNVAaESPKLIf3N1gK6YQ=;
        b=XXaCERSvPT2E6uFh/KltpZ9iwaPnxohXt/N2DR+TUXQHPmwK7enG5pmuKwDtrt5dBn
         fg8FKTnOgkXprBovhQK8d4/WndnCw5oZc+kFNeELwFjsT9G9l5Aw9t/giqsY6py5i3Nx
         Co94pfhd/v7Rlwaw2xXcayjuyT7TdoullnlIOpgaRDtPbQXfyXHJqBOcD30qVI8BYM7v
         ROvx5UZy41LCn3kR0dNmM9+v6lL0TixpXbI4B2t6hUpAU88+mCxuMVrjWj75eCsc2e8p
         8F7vDOe7ZHAqo9eHaOnzhYKyLCGVy00DGtNv1dwpZ5aK6BABsftStQjYTsqKoTeSiWQc
         9Zwg==
X-Gm-Message-State: AOAM531gSgbbq6tREtGgSf6AtwJoOZeVD6bRGCNCt/lB/7ezNYOFafcb
        VGJtlqZwtNlNacc0Uz336oM34yU94WaYyA==
X-Google-Smtp-Source: ABdhPJzJR7xLbUD8EgtASXmcOPEToTpdHOkT9laH411iETsozqnDn2+YzUj/GpxNW0N39qWHeSiz8w==
X-Received: by 2002:a54:4799:: with SMTP id o25mr4832967oic.33.1607594744807;
        Thu, 10 Dec 2020 02:05:44 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id g2sm900996ooh.39.2020.12.10.02.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 02:05:44 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 2/3] pull: move default warning
Date:   Thu, 10 Dec 2020 04:05:37 -0600
Message-Id: <20201210100538.696787-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210100538.696787-1-felipe.contreras@gmail.com>
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eventually we want to be able to display the warning only when
fast-forward merges are not possible.

In order to do so we need to move the default warning up to the point
where we can check if we can fast-forward or not.

Additionally, config_get_rebase() was probably never its true home.

This requires a temporary variable to check if we are in the
"default mode" (no --rebase or --no-rebase specified).

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

