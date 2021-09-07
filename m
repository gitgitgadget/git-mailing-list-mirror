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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D161C433FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2ED610CB
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244886AbhIGMBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244546AbhIGMBB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:01:01 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B1EC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 04:59:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x7so7065137pfa.8
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 04:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6++1T30h1iGYOlKKfZKE16nCjyjI8IJhhiJmo/sUrrI=;
        b=NlXyUZvUa8tsZLYhjSCN7qYVNBfrNXu+XTyQHDbrd2hFr0NAcNZ6WFFbRQjgcIyQ5I
         Psg1nDhEPde9hiRwOMdt7aNaQhywbT9JGN1mnlP4U02CvQudHT/46cE4hZebS8q261NF
         h4vlw5yEPFyiOArOyr13du21lVZNfc28iAfNuhGtxXZ0c+sAAWgag0RYCN5ltxuLFWvT
         Nb+yXl8BYDgL08PAXpnEhjkIMywJLbaTR2nThRNrKzO1uA7KJNH8NGWqrlLWZ3SxqaH2
         KlloQYZI7bz+YUn2ROmz2cIuAecAFFzvMdW5/3h2siisRu1CQwPNjjmSQuoAWeWJSiGv
         S+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6++1T30h1iGYOlKKfZKE16nCjyjI8IJhhiJmo/sUrrI=;
        b=tFTaNzD3qW9/p9gSUdZ5uUXb3AXwYkg4ufOWZVwZmatqWaP/eqc2qfhNcrHqEeI6Es
         /Gc0CYB0E6AEjZlVf5GEYcyDsyyWrzcNWUgk4lXUWTw2edi9EySJIgwdoueAJujKD1Nv
         BOPwyGT8j6pWgCqN9X0BSLKSKOoO8vwibKlJWEysxND52FoYo8k/cShFBipHMDHClMA2
         e++keVAKBLv8+9aBzMtq+Z3F6Zff1nhWHmMEYFKeLTqg/QH/xbZBUR3tMjeMVEuDprOQ
         dF1E2QiqQL+3oW/eK1LrbnhZORJZOU8x1Dqa12XxVbSjrPY628vjpRfXHcpPa2DLYrsD
         mfNw==
X-Gm-Message-State: AOAM531HGaODpbr/YZutPDEZIbCp2Y6x8gzfxI5O5k0vaRx6HWm9Jl5i
        z6BBYSGjI5g1GvLxpAur/wIIct6r5Xo=
X-Google-Smtp-Source: ABdhPJyU43yn25Cg3grwz3e17W3FN8OHajeGCjvUDIBrIQ4u2tK7Ettt0mEEvAtsrbi637N1YbD/sA==
X-Received: by 2002:a62:645:0:b0:3f2:23bd:5fc0 with SMTP id 66-20020a620645000000b003f223bd5fc0mr16119234pfg.35.1631015995185;
        Tue, 07 Sep 2021 04:59:55 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id a142sm11248150pfd.172.2021.09.07.04.59.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 04:59:54 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, emilyshaffer@google.com,
        gitster@pobox.com, jrnieder@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com, avarab@gmail.com,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: [PATCH 01/13] submodule--helper: split up ensure_core_worktree()
Date:   Tue,  7 Sep 2021 17:29:20 +0530
Message-Id: <20210907115932.36068-2-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210907115932.36068-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's split up `ensure_core_worktree()` so that we can call it from C
code without needing to deal with command line arguments.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 80619361fc..97512ccf0b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2794,18 +2794,12 @@ static int push_check(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
+static void do_ensure_core_worktree(const char *path)
 {
 	const struct submodule *sub;
-	const char *path;
 	const char *cw;
 	struct repository subrepo;
 
-	if (argc != 2)
-		BUG("submodule--helper ensure-core-worktree <path>");
-
-	path = argv[1];
-
 	sub = submodule_from_path(the_repository, null_oid(), path);
 	if (!sub)
 		BUG("We could get the submodule handle before?");
@@ -2829,6 +2823,17 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 		free(abs_path);
 		strbuf_release(&sb);
 	}
+}
+
+static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
+{
+	const char *path;
+
+	if (argc != 2)
+		BUG("submodule--helper ensure-core-worktree <path>");
+
+	path = argv[1];
+	do_ensure_core_worktree(path);
 
 	return 0;
 }
-- 
2.32.0

