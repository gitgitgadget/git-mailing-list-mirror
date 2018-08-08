Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52421208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 13:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeHHQLH (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 12:11:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37746 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbeHHQLH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 12:11:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id b10-v6so1306364eds.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 06:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1wa5vq/PaNnWj+S1jofJ/Vs1rg8E3NrlYrMIdE/K4IA=;
        b=hfIKroB7u0PK1QZsNlnTS8sWTWeT9STaI+Hkr35FUVSpFjaCUOxOc33+Bsa0aW2OZ7
         s8eXH/QJLyjayQHvIc9nsQHh9ZWzS2MQg+izCVIwOOsR/K0XPxjiFVKtyGfUbjreOXbt
         S1t6sEeYlOS7WcjvQtReyc55vzldN8yVeEnypOLiTqrq0p4M76XP9/rWOJkkF7kBGh82
         o5PdVldKMoaeWGYxPWaHiQS3lqB0wgRmufVFvVlQqyyoph3CvgVye4V9EFp8Vv9YBG96
         ZuUc1lXMd4AnXb/Z7YM3lgwUkaDwC5UISvoSrjv1OuqoMgFPabpxlWZlr8TYrS0tlLjb
         R1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1wa5vq/PaNnWj+S1jofJ/Vs1rg8E3NrlYrMIdE/K4IA=;
        b=Fewbriwu0ttvCDoAl9+v3ziFEx5tpjFtUW0WgZzmwKe/NB5YQuIJM890dutSXK+pgw
         VJgJkhQdlk8wXMlQdd20aJ5nQzq4Fi584ehT9A1w0dKt4cVwCUoxJgCb2nmNL28p1Yl4
         XPFFENpHnlkU1m80zleeaSATKQYPcWRfsi5x+gOzBbhIbi2QKUhz2SZwad7L1lWLZdo9
         CvYLxrQwJgxHQlCgbleFJjYEz3I7Xgq7sr9n+0S4EPFC9jp4uM9TCrt7XWkHBUuqh9jD
         yYAF370NJkc94cdNtzP1w1hmFsu1hPfMIZxWnq4Kft7CF1P6QDGrYfa9ddIlqpIW/2Fr
         8q6Q==
X-Gm-Message-State: AOUpUlHoHvzBDGkDEI4ymQaudgmQuiIpcIZidxUqHpXcKRj4Xx6yLvVI
        /Cc0u88btvUv1pmpHWWtUimOoMi7
X-Google-Smtp-Source: AA+uWPzThRhFyU+o13uCpop36qbyjLMgMKblxxzuEdySWI9WzudcWsDyMFHfR+9k+ZGtlYPIGMyZzA==
X-Received: by 2002:a50:8921:: with SMTP id e30-v6mr3390957ede.213.1533736280282;
        Wed, 08 Aug 2018 06:51:20 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id u3-v6sm1619420edo.44.2018.08.08.06.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 06:51:19 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 03/11] builtin rebase: handle the pre-rebase hook (and add --no-verify)
Date:   Wed,  8 Aug 2018 19:33:22 +0545
Message-Id: <20180808134830.19949-4-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808134830.19949-1-predatoramigo@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit converts the equivalent part of the shell script
`git-legacy-rebase.sh` to run the pre-rebase hook (unless disabled), and
to interrupt the rebase with error if the hook fails.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 38c496dd10..b79f9b0a9f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -70,6 +70,7 @@ struct rebase_options {
 	const char *state_dir;
 	struct commit *upstream;
 	const char *upstream_name;
+	const char *upstream_arg;
 	char *head_name;
 	struct object_id orig_head;
 	struct commit *onto;
@@ -310,6 +311,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	};
 	const char *branch_name;
 	int ret, flags;
+	int ok_to_skip_pre_rebase = 0;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
 	struct object_id merge_base;
@@ -317,6 +319,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
 			   N_("rebase onto given branch instead of upstream")),
+		OPT_BOOL(0, "no-verify", &ok_to_skip_pre_rebase,
+			 N_("allow pre-rebase hook to run")),
 		OPT_END(),
 	};
 
@@ -382,6 +386,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.upstream = peel_committish(options.upstream_name);
 		if (!options.upstream)
 			die(_("invalid upstream '%s'"), options.upstream_name);
+		options.upstream_arg = options.upstream_name;
 	} else
 		die("TODO: upstream for --root");
 
@@ -430,6 +435,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("Could not resolve HEAD to a revision"));
 	}
 
+	/* If a hook exists, give it a chance to interrupt*/
+	if (!ok_to_skip_pre_rebase &&
+	    run_hook_le(NULL, "pre-rebase", options.upstream_arg,
+			argc ? argv[0] : NULL, NULL))
+		die(_("The pre-rebase hook refused to rebase."));
+
 	strbuf_addf(&msg, "rebase: checkout %s", options.onto_name);
 	if (reset_head(&options.onto->object.oid, "checkout", NULL, 1))
 		die(_("Could not detach HEAD"));
-- 
2.18.0

