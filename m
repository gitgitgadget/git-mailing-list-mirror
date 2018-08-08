Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A67F208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeHHRne (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:43:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37503 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeHHRne (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:43:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so1459630eds.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GvYfsjUrbIg8SPLe3C1UfKpP76sRGqDwnxsZ2DPM7hM=;
        b=r+jLLz64Bi+zmmg6/E3eWRw2LbY8Txrxnjly4iiI8h0H6iXZeaC2d3w6a/CziGSLsj
         4OkpgovzYWIoBUGC6RFswqBP6sgdy+VN4MKfzb/A42UuiCgO1GnFW2rijw3HvY2K2tvw
         3F0Fr77r1ERZ8iNmdfHT7vPu7GSLkmk3ZIJFhojBqclt3/80sud0E34unxV3TMMoOFn0
         vnIZHG6v8Y87CXkP0iOz9hW167jGhozkqxJ/OXVUCq5gEINPfK36VR82mkV/D0NsokAk
         gbpzqPENux7bH6oNQDitA/zimlwMetYik93W2rND/FfkvRXGY/bdwWQeq5IyX9POhcfU
         UvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GvYfsjUrbIg8SPLe3C1UfKpP76sRGqDwnxsZ2DPM7hM=;
        b=dUQXpiXMthzyIWRrnVIOUz1h3Vv+Dpkrlp80pLQpxmfwskE3qDfCxQq7V8jholuZqX
         Fwle1VyV0Ll4M9aQeo+Vm+/GhNS+6CApXTib01sEeYvBqyHS5WjPgVQZ0iudUoz/ChKB
         XdeWw6782ILPPCSHJYy+77uH4EB68+q5hffgFwviuyje5gRjNnOqM1MrJ2tqVcNX0Sxj
         Qrb9x2wj/d9bj6orJbtxf5+Dof4uLYOL34SSxzXDKRVAs8Mjy9nDRmwObHavXj8iGU0s
         Z0IWJT0mUQ4A8Y8r6wBirbLRk2eqKZcrMul8k+8eFYcnJqypxgFeJr3zydEtljOLD9wl
         3wpg==
X-Gm-Message-State: AOUpUlGQtBOzFXvX3YRA8fj4Y5QHEatSiNBp8KAJb2p/0ZemfSnQi4id
        sioE9BH9Ssd9LIvP8bD7VXK+bJir
X-Google-Smtp-Source: AA+uWPxknluK8BcKV+t3ca1Cju1aojA7SIEvNQVG3ohXea+zWUUJYRwX6mk3X/ahgl41ZaHxDOaslA==
X-Received: by 2002:a50:bec2:: with SMTP id e2-v6mr3871104edk.283.1533741805595;
        Wed, 08 Aug 2018 08:23:25 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:23:24 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 13/18] builtin rebase: support `--allow-empty-message` option
Date:   Wed,  8 Aug 2018 21:06:35 +0545
Message-Id: <20180808152140.14585-14-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit introduces the `--allow-empty-message` option to
`builtin/rebase.c`. The motivation behind this option is: if there are
empty messages (which is not allowed in Git by default, but can be
imported from different version control systems), the rebase will fail.

Using `--allow-empty-message` overrides that behaviour which will allow
the commits having empty messages to continue in rebase operation.

Note: a very recent change made this the default in the shell scripted
`git rebase`, therefore the builtin rebase does the same.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index c9e992b526..dfb1e6c25b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -94,6 +94,7 @@ struct rebase_options {
 	char *gpg_sign_opt;
 	int autostash;
 	char *cmd;
+	int allow_empty_message;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -348,6 +349,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "autosquash", opts->autosquash ? "t" : "");
 	add_var(&script_snippet, "gpg_sign_opt", opts->gpg_sign_opt);
 	add_var(&script_snippet, "cmd", opts->cmd);
+	add_var(&script_snippet, "allow_empty_message",
+		opts->allow_empty_message ?  "--allow-empty-message" : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -598,6 +601,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		.flags = REBASE_NO_QUIET,
 		.git_am_opt = STRBUF_INIT,
 		.allow_rerere_autoupdate  = -1,
+		.allow_empty_message = 1,
 	};
 	const char *branch_name;
 	int ret, flags, total_argc, in_progress = 0;
@@ -697,6 +701,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST('x', "exec", &exec, N_("exec"),
 				N_("add exec lines after each commit of the "
 				   "editable list")),
+		OPT_BOOL(0, "allow-empty-message",
+			 &options.allow_empty_message,
+			 N_("allow rebasing commits with empty messages")),
 		OPT_END(),
 	};
 
-- 
2.18.0

