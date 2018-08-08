Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20041208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeHHRmu (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:42:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44110 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeHHRmu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:42:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id f23-v6so1431363edr.11
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t0+u3bZ5nec45tcCEHp8C9CoqRPxG5SifuqsIVVAUrY=;
        b=tIL4h1cmSyIIUzPYGoEt+2Q2M1UkEuhLgLGfWydW19Bll/58YInNrGFQCQMIw9G1Np
         7B90MFd9JEwpfbDzgJ7ZvfgA2e8FkdBX0SPTZAgWwJpQZbfZa8rV2cg/KDw+FKgsYjFp
         aklRUrvl2nsUt/U9rqYNu/bNsMizmV0487wOk/HQz8f0wHnCb+NLaJgNzOzkExLXPxt+
         IP0v7TbVmhtGVSKAZQ9PPDs7y++AWHK8YWKxUmn4UIrrSKQghalRpaAtv/zzgKpAmUsY
         FZyLrZ69K4S1FO3dugmM1NvPGDrlhdrBcgBzJ68g/pU9AlbHt3MxpctJLq1e+q92D2Ip
         EDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t0+u3bZ5nec45tcCEHp8C9CoqRPxG5SifuqsIVVAUrY=;
        b=DwJHMoERafvCx675bLNcEev4TW47Dk6h9xyr5FPxaWowPAeWX7RmLFuKiiJjW5oJIK
         2LdccwmiBtrRoEvcljstqx8c8TgG4Gtn8IAieDtiQYSYrDVqe/+zktDCDUZRG+1OA+jb
         44EA7ti4uA86/jemUx7sRs8/st9L73SN77OMUyn4AjDtfiPTMVQHkcw7ZeXdXl/ca08J
         X7s6RrBQI5MwQZk85C217ltj1Alt5LItu6GmAweoHKUzsk3elZSxwtfiN4/2S5VKox9Z
         3ltgIitHznMFX4yNbJ17MgKomYlOLcsMa6hU+5Q82FvnmE50/3AXPv5ue2IpnK7O/Rdw
         415g==
X-Gm-Message-State: AOUpUlFbiia0rjtqxQVP2ml/SjWYOCdZAKMoWnkN4Irbu96vYHvFvKzK
        4CtV+jz7vov6tvcaXMX8EHjdBJnM
X-Google-Smtp-Source: AA+uWPyY6lE9vSgKnmMWPdpXVjOCEKcRqUGct8OAI2G0cVXqJKMbBu/ftIgmbAEIReLGVrK8d7KdFQ==
X-Received: by 2002:a50:b8a6:: with SMTP id l35-v6mr3933478ede.273.1533741760911;
        Wed, 08 Aug 2018 08:22:40 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:22:39 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 01/18] builtin rebase: allow selecting the rebase "backend"
Date:   Wed,  8 Aug 2018 21:06:23 +0545
Message-Id: <20180808152140.14585-2-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With this commit the builtin rebase supports selecting the "rebase
backends" (or "type") `interactive`, `preserve-merges`, and `merge`.

The `state_dir` was already handled according to the rebase type in a
previous commit.

Note that there is one quirk in the shell script: `--interactive`
followed by `--merge` won't reset the type to "merge" but keeps the type
as "interactive". And as t3418 tests this explicitly, we have to support
it in the builtin rebase, too.

Likewise, `--interactive` followed by `--preserve-merges` makes it an
"explicitly interactive" rebase, i.e. a rebase that should show the todo
list, while `--preserve-merges` alone is not interactive (and t5520
tests for this via `git pull --rebase=preserve`).

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 75c4ac66e0..fc9b5a8a60 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -452,6 +452,29 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
 	return res && is_linear_history(onto, head);
 }
 
+/* -i followed by -m is still -i */
+static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
+{
+	struct rebase_options *opts = opt->value;
+
+	if (!is_interactive(opts))
+		opts->type = REBASE_MERGE;
+
+	return 0;
+}
+
+/* -i followed by -p is still explicitly interactive, but -p alone is not */
+static int parse_opt_interactive(const struct option *opt, const char *arg,
+				 int unset)
+{
+	struct rebase_options *opts = opt->value;
+
+	opts->type = REBASE_INTERACTIVE;
+	opts->flags |= REBASE_INTERACTIVE_EXPLICIT;
+
+	return 0;
+}
+
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options = {
@@ -510,6 +533,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "show-current-patch", &action,
 			    N_("show the patch file being applied or merged"),
 			    ACTION_SHOW_CURRENT_PATCH),
+		{ OPTION_CALLBACK, 'm', "merge", &options, NULL,
+			N_("use merging strategies to rebase"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			parse_opt_merge },
+		{ OPTION_CALLBACK, 'i', "interactive", &options, NULL,
+			N_("let the user edit the list of commits to rebase"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			parse_opt_interactive },
+		OPT_SET_INT('p', "preserve-merges", &options.type,
+			    N_("try to recreate merges instead of ignoring "
+			       "them"), REBASE_PRESERVE_MERGES),
 		OPT_END(),
 	};
 
@@ -884,6 +918,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		diff_flush(&opts);
 	}
 
+	if (is_interactive(&options))
+		goto run_rebase;
+
 	/* Detach HEAD and reset the tree */
 	if (options.flags & REBASE_NO_QUIET)
 		printf(_("First, rewinding head to replay your work on top of "
-- 
2.18.0

