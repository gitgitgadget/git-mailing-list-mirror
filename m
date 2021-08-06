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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B78C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA355610FF
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343524AbhHFMDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 08:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343523AbhHFMC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 08:02:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D578DC061799
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 05:02:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so22423825pjr.1
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 05:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/JDqnGesvhr5cT2Bez5FmdzqVa5gRIdbK+JYER4YI+M=;
        b=iaULtITVdLn9MYXflLifxgwEpF/5jcpzM7AM9FkY2v3w6f1w+yKidVNHusRFL5Y2bM
         FRzxd2x1T2SfLEvG7J8bZgptt0ay2cYTuxSaGovSRwfg6xfXELWBA6o6aXOb69Np6SFv
         p6eoN3bBIkIYB5oICgoCT2lCYEcuSVU1wyiRkK9R0RdTLv4e3YeJbgmEzEtfrAEsYG1J
         O71LVsu8TJFT27jOMX7MULcAY36EKql67LPm1dcTXANOIf1kfsOCsP7SPl1jbMo4kJGt
         qkxCq3Q30Nhaqj+bk9aSVillISkAqPDhQDYwYOewAVEolacRbmkGDqqSsMI0LPd/k5N7
         BVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/JDqnGesvhr5cT2Bez5FmdzqVa5gRIdbK+JYER4YI+M=;
        b=sZEiIRAuvbPBgC7st62/o+YXnEq/vJTePxrQejwiiM9SFKdEMiOicYNTTK00AnJuep
         vWwq0uiX8jAWNLCyP9SZkzI0LOdhLn4e9E8rNqQYsan5qQPP294FC7Mn6umwK4ZFsPH+
         5oF+M5pE2ceS7JSsCQTUS0I391PvVzGolLyMfYE1TQNzz4sjukFNbmNPQXWg99xc49Jg
         z8d6ko3tLgoySHiAgHXmuKyEM1v3FRDCBlCmJJMTzl3LLxFr/wD5sDlV1M9xyYNOqi1z
         yy/Jyq5yPanVsZR/+hgbbsH1HCV+U/KDrydNoFO8xF8y5nqQiAOayI9n8+EOmma6ckk5
         CG2Q==
X-Gm-Message-State: AOAM530MM9OghKFgx+N+11z2IXZDdE9r60p7j3iSxUTncQf8DjH6hKc+
        7r+ZHuTZ1P2sxtTB6I0N0iE=
X-Google-Smtp-Source: ABdhPJzZwp1W9gbKAB8b2pd+NcUcg2QW1ySCzfUSD1nDr+1NZVlcMklqrcqNE4QAAUg6rZ+Fzh3KyQ==
X-Received: by 2002:a17:902:f253:b029:12c:438a:fa7b with SMTP id j19-20020a170902f253b029012c438afa7bmr8407775plc.22.1628251361447;
        Fri, 06 Aug 2021 05:02:41 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id z8sm10338162pfa.113.2021.08.06.05.02.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Aug 2021 05:02:41 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v3 8/8] submodule--helper: remove resolve-relative-url subcommand
Date:   Fri,  6 Aug 2021 17:31:47 +0530
Message-Id: <20210806120147.73349-9-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806120147.73349-1-raykar.ath@gmail.com>
References: <20210805074054.29916-1-raykar.ath@gmail.com>
 <20210806120147.73349-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The shell subcommand `resolve-relative-url` is no longer required, as
its last caller has been removed when it was converted to C.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a858c2be29..9772435959 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -223,25 +223,6 @@ static char *compute_submodule_clone_url(const char *rel_url, const char *up_pat
 	return relurl;
 }
 
-static int resolve_relative_url(int argc, const char **argv, const char *prefix)
-{
-	const char *up_path = NULL;
-	char *res;
-	const char *url;
-
-	if (argc != 2 && argc != 3)
-		die("resolve-relative-url only accepts one or two arguments");
-
-	url = argv[1];
-	if (argc == 3)
-		up_path = argv[2];
-
-	res = compute_submodule_clone_url(url, up_path, 1);
-	puts(res);
-	free(res);
-	return 0;
-}
-
 static int resolve_relative_url_test(int argc, const char **argv, const char *prefix)
 {
 	char *remoteurl, *res;
@@ -3118,7 +3099,6 @@ static struct cmd_struct commands[] = {
 	{"update-clone", update_clone, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
-	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
-- 
2.32.0

