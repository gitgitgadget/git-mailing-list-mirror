Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18F91208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 13:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeHHQLS (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 12:11:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46009 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeHHQLS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 12:11:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id s16-v6so1275318edq.12
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U+tkIKfwGf7uHVP3WtbLHYmHb4cJT/OFTAHyvQ7RZtk=;
        b=JhjktLpgwnZjS8ASYEBLwjrQlOXyj4p8bqOaltmAijRib1bxhBVCtkrt3YKLjeMtwG
         Ti0evgpUTyXWpQBJru5HqABlvL5MmAAgQnSGQXFVxHbOKoIm5XjMX+7GRaMP5ib9Pt9O
         MsAOmexvN8/DDpVmdU1hkTkujxjqZuqpsZ92VJAoxbIicetBHdfr0rOkAH+8WJmuLjxD
         RDAFnyfgcMGi0CcdC0+PmHO3MRdGQmkYfIv9WLpz0yiPBZQ1XX5RM0DL1XRwfqp1KVi0
         3pPUg+hvEUndwKZr6Qz32vr4SGgUKz5YC7FXjFl1MC5gixn08lvSLDfArzose7xqrIcn
         dYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U+tkIKfwGf7uHVP3WtbLHYmHb4cJT/OFTAHyvQ7RZtk=;
        b=GXgee3VG9NH8fcJzHeBDLqsmJhyFftAtuIzgD1Nw8eFspoj08JPR3Wq7Gp6JFFisAd
         kYceEzqJdN2ybxd/OxiuPVfXb5SqwBSyiz4OwFUIbsywlNgSy71uNjYqczVNCL0gQ/Ip
         Ma2d1K6NbO/39AF3JRG9+w1RAbGay5RKS305ol1qWsIu/YFz0vz7Y+Z3AGqL36INGM8D
         T3/BKfvmriOhMGf4qDbgIXhaXpvm8JsE7Uq3vclr0JeBw1Ke919QdkRywWC2OSbfZvup
         V+SfWXNIzSTnVQTTuykhNKliByE+Wu9CGHdqdUUtKg/Ozv6aGlC4+qYWonz6vq7FSvr9
         qGug==
X-Gm-Message-State: AOUpUlGalhcEooEUB27s7ru8YfRZXDYS1F0VQG5hDzH6mYMfYwq4TjdC
        KynF7AAZdAColKhZo9hV922plJdd
X-Google-Smtp-Source: AA+uWPxwZAoCJWoqWGhJUKJBNbAjdxTfMnMz1y7DHvkCB+KTVM5VtszelzOFmAC5icZmiYq1GYuRxQ==
X-Received: by 2002:a50:8607:: with SMTP id o7-v6mr3338049edo.243.1533736291243;
        Wed, 08 Aug 2018 06:51:31 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id u3-v6sm1619420edo.44.2018.08.08.06.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 06:51:30 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 06/11] builtin rebase: require a clean worktree
Date:   Wed,  8 Aug 2018 19:33:25 +0545
Message-Id: <20180808134830.19949-7-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808134830.19949-1-predatoramigo@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit reads the index of the repository for rebase and checks
whether the repository is ready for rebase.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2d3f1d65fb..afef0b0046 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -19,6 +19,7 @@
 #include "parse-options.h"
 #include "commit.h"
 #include "diff.h"
+#include "wt-status.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
@@ -479,6 +480,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("Could not resolve HEAD to a revision"));
 	}
 
+	if (read_index(the_repository->index) < 0)
+		die(_("could not read index"));
+
+	if (require_clean_work_tree("rebase",
+				    _("Please commit or stash them."), 1, 1)) {
+		ret = 1;
+		goto cleanup;
+	}
+
 	/* If a hook exists, give it a chance to interrupt*/
 	if (!ok_to_skip_pre_rebase &&
 	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
@@ -528,6 +538,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	ret = !!run_specific_rebase(&options);
 
+cleanup:
 	strbuf_release(&revisions);
 	free(options.head_name);
 	return ret;
-- 
2.18.0

