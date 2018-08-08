Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C74C208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeHHRnM (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:43:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34405 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeHHRnM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:43:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id h1-v6so1459982eds.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nxoPhy4rA/BNVE0LixFA9equ7R5aKtOlyAC9tRTBQiY=;
        b=Exz5+nhYyUBwBnKj0zgp+g+3ltDhTezi/xOcvhA6CS2x8uwuK6wygvwfr4kE+HZDdh
         +sbfBRYOk+JiXwKjtGiZK8sc94GVvBRBN4vBs2Xv86NPJMJiwpwQtaaaxaMbqaXAIKN3
         +xBbWeZ3amP8Dq+ncB5/sOtv00qRC9oyqJI4GKhB6oT5iPIGKSy9VnAUnEfnmRi3sz3o
         eCCbopFqivHhO68vlwG7mWcjDqe6WkmumXS7VFV9SMTTdJmC+XADeam1Z1AKbflpltQV
         M5y4kPNYnRXD9HreSfOpY+vyCdK7ktjSmtGuAo+lU6VOB/aoG4pVIwzzU/25jVyuPNzU
         ekng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nxoPhy4rA/BNVE0LixFA9equ7R5aKtOlyAC9tRTBQiY=;
        b=jwGI8YpFVEo2eGM45cmx3GZTXOfgc7TZb1f5l9j2rcETReltWrUyCcTNooYnq85OrI
         kbpaCXGywdxCkYnEwE9VnbNMTtJJ2sw78VTxIKJu+aaOsyo99cFCgbAOcZXQ3jxxPgj+
         8zRbVyMcFHV9aVqLlLLY1GFQ7yY+iKWJ2xhwVt3H5TypCQ7ajdnb7zEgxaEL3WibHMMv
         6hQkVYeCqRsy0tLK/WdziXoFq/29wSi/+HzkxQqzI/Po+jQjMc34yICLe4rdlZOsd/y8
         rw58/NzKiKTmv/TCbGHvD6yNGqX3YkgwBSbgzL9TndrwkhBRDM5bdz0pAhXDK/3L9S+J
         xz3w==
X-Gm-Message-State: AOUpUlG1CgzMnauQQ8BOPdQor+HkDa26TF887wSbOOA/DjYvuGYbyluJ
        9/Lii1Mk4SxUorW0FwMLZ+zwi/Nb
X-Google-Smtp-Source: AA+uWPwqgE2jLkp80r0jK+VH6w6XpuuBTy1EH77HSMeMvRifa7Y6VUdC4GntxmUy+5R6TxzfGLa3VQ==
X-Received: by 2002:a50:f31a:: with SMTP id p26-v6mr3881768edm.68.1533741783091;
        Wed, 08 Aug 2018 08:23:03 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:23:02 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 07/18] builtin rebase: support `keep-empty` option
Date:   Wed,  8 Aug 2018 21:06:29 +0545
Message-Id: <20180808152140.14585-8-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `--keep-empty` option can be used to keep the commits that do not
change anything from its parents in the result.

While the scripted version uses `interactive_rebase=implied` to indicate
that the rebase needs to use the `git-rebase--interactive` backend in
non-interactive mode as fallback when figuring out which backend to use,
the C version needs to use a different route because the backend will
already be chosen during the `parse_options()` call.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 42ee040da3..fd9ad8efae 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -95,6 +95,7 @@ struct rebase_options {
 	const char *action;
 	int signoff;
 	int allow_rerere_autoupdate;
+	int keep_empty;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -103,6 +104,23 @@ static int is_interactive(struct rebase_options *opts)
 		opts->type == REBASE_PRESERVE_MERGES;
 }
 
+static void imply_interactive(struct rebase_options *opts, const char *option)
+{
+	switch (opts->type) {
+	case REBASE_AM:
+		die(_("%s requires an interactive rebase"), option);
+		break;
+	case REBASE_INTERACTIVE:
+	case REBASE_PRESERVE_MERGES:
+		break;
+	case REBASE_MERGE:
+		/* we silently *upgrade* --merge to --interactive if needed */
+	default:
+		opts->type = REBASE_INTERACTIVE; /* implied */
+		break;
+	}
+}
+
 /* Returns the filename prefixed by the state_dir */
 static const char *state_dir_path(const char *filename, struct rebase_options *opts)
 {
@@ -276,6 +294,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 		opts->allow_rerere_autoupdate < 0 ? "" :
 		opts->allow_rerere_autoupdate ?
 		"--rerere-autoupdate" : "--no-rerere-autoupdate");
+	add_var(&script_snippet, "keep_empty", opts->keep_empty ? "yes" : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -588,6 +607,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 &options.allow_rerere_autoupdate,
 			 N_("allow rerere to update index  with resolved "
 			    "conflict")),
+		OPT_BOOL(0, "keep-empty", &options.keep_empty,
+			 N_("preserve empty commits during rebase")),
 		OPT_END(),
 	};
 
@@ -787,6 +808,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.flags |= REBASE_FORCE;
 	}
 
+	if (options.keep_empty)
+		imply_interactive(&options, "--keep-empty");
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
2.18.0

