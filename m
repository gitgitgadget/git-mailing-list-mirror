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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6BCC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063F8610FF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343572AbhIGMBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343694AbhIGMBl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:01:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95B1C06129F
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:00:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gp20-20020a17090adf1400b00196b761920aso1923246pjb.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bcqeJD0tPfZy9idd41wYtUZfDBgAzWfTVjg39tfKUhc=;
        b=LBNZA+/+Uho2QoyaZ1mdVeybZirCV/ygnlAERDeJonWwYqEx44uTNQja7c+aUOEDMa
         cJKRIyBQxGngNSy87XSGX331h7j8xfl/yaOKUu+SxkCY9R/lFkRl6o7aplzB6D5szJqw
         wN78wmEDxqQ7Qx9pQwwB6S/kz+Q6kM4kVM+aywIFbyalPp3hZYWA4W0HjPSIKgpiuXbD
         PoJCF03gtUZUBWivQ+lHwBn+WzZL2g422AeXaM9Qxi6ya9w+8Ud6S4x+hxzuaHfHyMX6
         ifjKhsyck8a3Aub3xehX7C4XlL6cQYQIMZUGdqi8dZLAfIwYptB+XwUyTW0mczlJmcsQ
         6XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bcqeJD0tPfZy9idd41wYtUZfDBgAzWfTVjg39tfKUhc=;
        b=Qprsq5IMOZQ7fgbdiq4Rz3aaiDf9nthUuMEreU52jG1n15H/+Mi+BXI6DKi40zz3lD
         nH2EEduv4kGuE2WiZpAZ2SBuB9lseHrLlL1HFIv8ife2v78Ve9tK1H2/GF+cdkfez1kB
         YR8kWxNaZ1g5CO7WXUI52BO78qNYrP/ui4csGFyc7WIL96pmaLkZk7OXQOf541hlitL8
         TwiZishw2B07T1lkphWXBK3IC5lUVC/6vN7XxHikLAuOWBiY7PhCrfQilvG4+zfPWARD
         ARhQriw/QB1yY4vO8e9n/ddMAsaLIIVUriIVaMwQmGkUzI6vJ2yWYds4LPFpAawh8xFP
         LrLA==
X-Gm-Message-State: AOAM533Ag5R9WiIrqshF5X6Y2dcDaJHhA4LpwYBKyonKz1xzYmJtmgs7
        ObQ9R1PIGMKubuRDNrFZTUGSxZAnNg4=
X-Google-Smtp-Source: ABdhPJz/iMDOhuQadP1qgjgHk4y2WywfurZJdIOi5RKpY3ZY9IKDB4J9oeU5hggySLXqld+0W/qB+g==
X-Received: by 2002:a17:902:b193:b029:11a:a179:453a with SMTP id s19-20020a170902b193b029011aa179453amr14494588plr.69.1631016030968;
        Tue, 07 Sep 2021 05:00:30 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id a142sm11248150pfd.172.2021.09.07.05.00.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 05:00:30 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, emilyshaffer@google.com,
        gitster@pobox.com, jrnieder@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com, avarab@gmail.com,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: [PATCH 11/13] submodule--helper: remove print-default-remote subcommand
Date:   Tue,  7 Sep 2021 17:29:30 +0530
Message-Id: <20210907115932.36068-12-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210907115932.36068-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This subcommand was once useful for submodule functionality, but after
the various conversions of shell code to C, it is no longer used.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 597e303889..9470ff3de0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -73,21 +73,6 @@ static char *get_default_remote(void)
 	return repo_get_default_remote(the_repository, refname);
 }
 
-static int print_default_remote(int argc, const char **argv, const char *prefix)
-{
-	char *remote;
-
-	if (argc != 1)
-		die(_("submodule--helper print-default-remote takes no arguments"));
-
-	remote = get_default_remote();
-	if (remote)
-		printf("%s\n", remote);
-
-	free(remote);
-	return 0;
-}
-
 static int starts_with_dot_slash(const char *str)
 {
 	return str[0] == '.' && is_dir_sep(str[1]);
@@ -3434,7 +3419,6 @@ static struct cmd_struct commands[] = {
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"status", module_status, SUPPORT_SUPER_PREFIX},
-	{"print-default-remote", print_default_remote, 0},
 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
 	{"deinit", module_deinit, 0},
 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
-- 
2.32.0

