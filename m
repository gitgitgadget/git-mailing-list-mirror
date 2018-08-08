Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85841208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeHHRnI (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:43:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41428 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeHHRnI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:43:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id s24-v6so1442377edr.8
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DvxLA92pwEio8qnprSwwxgKEzr9Wj3PRn44BUG3ZwHY=;
        b=WPsZrW/oUgJFjyjszvj2oAvvm4OE3WBETin0Ir+WntmzaVX+ttkUAPhHoFxhJdfDRO
         qNyAzs5rd8R2oLYrpt4Og0wO/LvuLHwjHi/LgtQvMDELnkREDQBoCNV0uDZTe1N2Xz9O
         Ieia6Qv+SvpQ+k67eFB2YJtBXCPKSJG6LIyypSlPspOwlEVM/1q/Qf3WGpfxtlXZUwrT
         8E/cCwjF5MnB2jFWWMPuFi5xxNOl+1uvmGwFze94bhXbO/nSupyziFxA3NtMi04/tBgw
         VtQO6mRdJTRG9CNgjUXBqqWpUJBYm4GIr568qjvBKCAAMWeFs4tbxkAigal/Dav4WyUL
         99RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DvxLA92pwEio8qnprSwwxgKEzr9Wj3PRn44BUG3ZwHY=;
        b=Bworfdsc0u1s937D+Ubr7/bFPWA7jdPI3pZtU9fkzwaHGI2RTV2ZR1qoMFJs+dOAcD
         HqLynMmtkbHuOlwei68PTfQQqPYNBjeSoRO6EcyPpP3hECowIZneYVQiQa7njhLEB+Ns
         fUloxZMqHaw7wKfdUJ8k5rQt55kLThsxKmR6b1yHMJSyVcb5igvvmWeIXX3XKkOUL+R4
         hlAWyPupedZAjljq3s5RNq8kBhIdbcudz0avtH4oQAuefoMFi8RSmnq79mZicW+G6MOz
         IVC6lQRs9eeYKSDfrJGB+m84vL16/Wyh+8JComo60erk3AmEyeFcWXsKmyqv05xOhucR
         /v1g==
X-Gm-Message-State: AOUpUlEL6UmXeStoyh0BLFQacLBka6JJW71ZftxOvthLLFhWrJYKgaJy
        RYEhDJbA+5+tDKs1z3mNC9GcUSuU
X-Google-Smtp-Source: AA+uWPysWAHQLEFfMqHEHFey35BBQz70Uqo5ZqIN4V2CudRD8Ub2iJUHLpZSwk/nxl5DDJN/5eo88w==
X-Received: by 2002:a50:d51d:: with SMTP id u29-v6mr3733986edi.51.1533741779459;
        Wed, 08 Aug 2018 08:22:59 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:22:58 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 06/18] builtin rebase: support `ignore-date` option
Date:   Wed,  8 Aug 2018 21:06:28 +0545
Message-Id: <20180808152140.14585-7-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit adds support for `--ignore-date` which is passed to `git am`
to easily change the dates of the rebased commits.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7490d215ef..42ee040da3 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -527,6 +527,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		ACTION_SHOW_CURRENT_PATCH,
 	} action = NO_ACTION;
 	int committer_date_is_author_date = 0;
+	int ignore_date = 0;
 	int ignore_whitespace = 0;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
@@ -550,6 +551,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &committer_date_is_author_date,
 			 N_("passed to 'git am'")),
+		OPT_BOOL(0, "ignore-date", &ignore_date,
+			 N_("passed to 'git am'")),
 		OPT_BIT('f', "force-rebase", &options.flags,
 			N_("cherry-pick all commits, even if unchanged"),
 			REBASE_FORCE),
@@ -779,6 +782,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (ignore_whitespace)
 		strbuf_addstr(&options.git_am_opt, " --ignore-whitespace");
 
+	if (ignore_date) {
+		strbuf_addstr(&options.git_am_opt, " --ignore-date");
+		options.flags |= REBASE_FORCE;
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
2.18.0

