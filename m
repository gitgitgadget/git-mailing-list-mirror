Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22592208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeHHRnu (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:43:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41474 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeHHRnu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:43:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id s24-v6so1443340edr.8
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mDNc2+aZIRPN5DkV3QVNB7HcC9eywuQyZ7GdHF1zeiY=;
        b=mJ8iqeIkoWyt/XoBnjrw2AwWSdIpDrchWmqLrTJmD0cWjfuk40V0C5eLDioz4+uDzg
         Du1u5aEKaBp6tOw79ZBnU5rvjeA1hsV345U+olXJ3MJ+3V4sPOATiUjNyRXC7KZOgLnF
         un0YcB6XuYiI4ER2/pmhjXHpAEsTXSMGDOe1Y7vYjTLYW9SUG5zMjmz/igiBg2bSFWgj
         wdGRkMwZkAbCJc/hCTLV+KS/7XCEoo4RxO5baUNzfrxgn8Cg4AGkHQj9v39/INmyF3ef
         fn4nfgho3V+Abj1mGT9MXeScVGPVyBw+Njw3EmEhtQfqMMp7CrnK/Ux3mv7wzDCNHIAZ
         4tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mDNc2+aZIRPN5DkV3QVNB7HcC9eywuQyZ7GdHF1zeiY=;
        b=AF+IiyggAaL5SZFSmmFPWOW5ZFmhFhonpCGDpHPzVKKBHjxaLpI89l0QofdheVEk6L
         Wg/naAVTDwJAQguocYuFud2aV/0n31Ydx5OP7kJs9xEynp5vqgq6YgspsSAe9YYmHZ3g
         bPfNHBHAwUK1ISSwgGnztjM8gOzPzpQ/cmn7JrhMQ1xDF4I4Ggwljk+h4In9AKqi807g
         Zt4+s5y4gn+oaPTOcbJjJj0lrissqjRJVQxzFfaryP+lCM8c4b7b5Vr+Y1kSbOcSjZrC
         IZi6D3lXqSZQ1OQU/Slb/sOyHVIh7vBwHg25YRDdgk3DZoOKcAf9dIz7sXuBv8ktvE0L
         cn5Q==
X-Gm-Message-State: AOUpUlGIXe9PyrWvt4Dj9w3Co1bpiPITHsSsWEJ2TdvpABuuNqp4kqaK
        mIY8yHkobHMoVS1YTeokmeCv5cxg
X-Google-Smtp-Source: AA+uWPwucIDS69ww5wU5ncxy9gzkcj9KhOSGFUCSmh+vsZRHBB9R6ZnML/N92Hkq0ggHSz2lI8W6zQ==
X-Received: by 2002:a50:b8a6:: with SMTP id l35-v6mr3938358ede.273.1533741820631;
        Wed, 08 Aug 2018 08:23:40 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:23:39 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 17/18] builtin rebase: add support for custom merge strategies
Date:   Wed,  8 Aug 2018 21:06:39 +0545
Message-Id: <20180808152140.14585-18-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running a rebase in non-am mode, it uses the recursive merge to
cherry-pick the commits, and the rebase command allows to configure
the merge strategy to be used in this operation.

This commit adds that support to the builtin rebase.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 72e64868b2..65e7be1c48 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -96,6 +96,7 @@ struct rebase_options {
 	char *cmd;
 	int allow_empty_message;
 	int rebase_merges, rebase_cousins;
+	char *strategy, *strategy_opts;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -217,6 +218,22 @@ static int read_basic_state(struct rebase_options *opts)
 		opts->gpg_sign_opt = xstrdup(buf.buf);
 	}
 
+	if (file_exists(state_dir_path("strategy", opts))) {
+		strbuf_reset(&buf);
+		if (read_one(state_dir_path("strategy", opts), &buf))
+			return -1;
+		free(opts->strategy);
+		opts->strategy = xstrdup(buf.buf);
+	}
+
+	if (file_exists(state_dir_path("strategy_opts", opts))) {
+		strbuf_reset(&buf);
+		if (read_one(state_dir_path("strategy_opts", opts), &buf))
+			return -1;
+		free(opts->strategy_opts);
+		opts->strategy_opts = xstrdup(buf.buf);
+	}
+
 	strbuf_release(&buf);
 
 	return 0;
@@ -356,6 +373,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 		opts->rebase_merges ? "t" : "");
 	add_var(&script_snippet, "rebase_cousins",
 		opts->rebase_cousins ? "t" : "");
+	add_var(&script_snippet, "strategy", opts->strategy);
+	add_var(&script_snippet, "strategy_opts", opts->strategy_opts);
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -633,6 +652,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
 	int fork_point = -1;
+	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -717,6 +737,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
 		OPT_BOOL(0, "fork-point", &fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
+		OPT_STRING('s', "strategy", &options.strategy,
+			   N_("strategy"), N_("use the given merge strategy")),
+		OPT_STRING_LIST('X', "strategy-option", &strategy_options,
+				N_("option"),
+				N_("pass the argument through to the merge "
+				   "strategy")),
 		OPT_END(),
 	};
 
@@ -963,6 +989,37 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		imply_interactive(&options, "--rebase-merges");
 	}
 
+	if (strategy_options.nr) {
+		int i;
+
+		if (!options.strategy)
+			options.strategy = "recursive";
+
+		strbuf_reset(&buf);
+		for (i = 0; i < strategy_options.nr; i++)
+			strbuf_addf(&buf, " --%s",
+				    strategy_options.items[i].string);
+		options.strategy_opts = xstrdup(buf.buf);
+	}
+
+	if (options.strategy) {
+		options.strategy = xstrdup(options.strategy);
+		switch (options.type) {
+		case REBASE_AM:
+			die(_("--strategy requires --merge or --interactive"));
+		case REBASE_MERGE:
+		case REBASE_INTERACTIVE:
+		case REBASE_PRESERVE_MERGES:
+			/* compatible */
+			break;
+		case REBASE_UNSPECIFIED:
+			options.type = REBASE_MERGE;
+			break;
+		default:
+			BUG("unhandled rebase type (%d)", options.type);
+		}
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
2.18.0

