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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B839AC4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89316230FA
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 19:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgLETyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 14:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgLETyp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 14:54:45 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A300C08E860
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 11:53:40 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id t205so10469279oib.12
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 11:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KF/sZs7wabdButTQPfO4KCzOkeZsQTzfYeXG+Uhr3sM=;
        b=GL1JmF0m6f+JwPbeSmrrAPG05MPqJU/mASjV9JbkXWnqeFy1d6PWkkfERV1MWQvZX3
         bk0BfIAWZX9EuhwCllzvIbEi/kAEqSky1Sh2TNm4p9gZRx9y7hh9JjDSFKSxh3yDxsoO
         MGyQgDEQ3mqEn4iUsd62FW5Wd7CQc7YAWG98U1rKMzkFExUxYtj8f66De8ckbHLGkd2e
         cIF8QZfJ4pmvEnp0nhyQj6gAkK1P3obDCF6yowT8PtjBsOuP4m+rospm5CW4OjrN7Oxa
         txi/TmIdB5iTo79RbH1lK5iow0QAYfKlBBjeu5eiTs7fXEl4m9BWgSUx9kDvJ+VCv/jg
         /Shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KF/sZs7wabdButTQPfO4KCzOkeZsQTzfYeXG+Uhr3sM=;
        b=OnGTsrb9o+X3ha9m4uRUGQy9oPcET3Z/eT7W9NKUKCa6aHa3FldY+6EJ+Jvp+A4ZTI
         icm+Q0jcsIc6Rawnh9ts4C1MCsoUjrjpePReuFgCSD9jtFXO/i+e6LVyYRftTF/qlyTc
         b/K6oY/Kw0BaeLIYwF7kMB4/Gnv6N3s2rKhn5YY1t1d4IopUeu7ipCXp+OHbydEFzLW7
         bV9b62u+T8kX4Kmu/l0ggJLOhvFPdbG8/vVV+SluJo4ExzHgWpUZwDdqq4yd3wv5npda
         N/aTTo5jhub1oVBYFKDjCpnTyTgOjUJUWYr47Xd3W4pP3OVNRbOHU+GnKoHTC4fCstu1
         MqaQ==
X-Gm-Message-State: AOAM532G7Spelose3tuBoJPvx3oPPwjL8IT3GjfkR/tca9n2H4Z/Pd4t
        v/uDXBL+e76i65ytqpR0vtTKHTXoznGGbw==
X-Google-Smtp-Source: ABdhPJyHfk4+bhFUKkQ1kHUb7apsFYf+awWhIgNCSlUT+sWkC7tySsBDuyb8t6JErFVCGTFVRNs+Cw==
X-Received: by 2002:a54:4012:: with SMTP id x18mr7484945oie.20.1607198019736;
        Sat, 05 Dec 2020 11:53:39 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k1sm1520046ood.4.2020.12.05.11.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:53:39 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 12/16] pull: move configurations fetches
Date:   Sat,  5 Dec 2020 13:53:09 -0600
Message-Id: <20201205195313.1557473-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201205195313.1557473-1-felipe.contreras@gmail.com>
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have FETCH_DEFAULT we can fetch the configuration before
parsing the argument options.

The options will override the configuration, and if they don't;
opt_rebase will remain being FETCH_DEFAULT.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 347ac89eee..e0157d013f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -915,6 +915,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct object_id rebase_fork_point;
 	int can_ff;
 
+	opt_ff = xstrdup_or_null(config_get_ff());
+	opt_rebase = config_get_rebase();
+
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
 
@@ -931,12 +934,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
-	if (!opt_ff)
-		opt_ff = xstrdup_or_null(config_get_ff());
-
-	if (!opt_rebase)
-		opt_rebase = config_get_rebase();
-
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
 
-- 
2.29.2

