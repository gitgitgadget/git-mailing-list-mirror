Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51C1E208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeHHRni (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:43:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37507 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeHHRni (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:43:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so1459730eds.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cZLtTgrqUbJRLtQntCPu2GLRxdVDHLB/MfZY8Z0Ng5c=;
        b=YIehc+9aUFaUOrLF6NW8vu7dqX851CKuGVlmi1m+AVm3crKZtkyE29Pz0JO5Vgt8Yw
         fqhw32vSnQGPLPx20D0lBfjme+CFk3OX29JR0sOVrmQmTJx3GwaRiGmAb3RjCiC+jSE5
         jThUeVO5lTAIA/HO+ePPA4RIL5mOKyrIWxYJzz9YcK1W/Fg4xFkWz1BJaz6BL38OVjaV
         piF1prDPEcrIzCTnfZeXpDtihqUofP57QoLERml0Xh7aMcQGrUGlnILJATvv+hrqn2vx
         ntDWREYU6qPQqtW63Cx7BdgUYGXyvHqPvwcz8HuPjUVDNp/RAp9zPsmJUx10bKJ4kWtO
         41VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cZLtTgrqUbJRLtQntCPu2GLRxdVDHLB/MfZY8Z0Ng5c=;
        b=GZVoAg6MS7DjSkhYT4oiq2nhgFqoU3dK1V5Lp92SuGqUP/iIoarRMckAgeD8ZQvx/c
         x5JpsxuEtWWSFjxgP7FNsMgyaQGnUbTV4zHrjkGYDOWaOB5pDKxZ1FlDCEjayEoWe/mn
         hMlhOaYjcHnzLsBng/6M4nk51Oe81du8iWj8H5nFgGMPBRp8IvT4sWZISV7tYwuJQFYg
         kArR38ALZfSauIaBmr92/73mgt817O0/sKe1AVWIh8Se5xmjZOc/M2G4id7b5Kc7EJdg
         pSoKWbI4NOl03oEZBjlOpZLkPEFp5Ea9KmtYcGr0c0PVFNazR9T2mxuBLDJB/5C/4jQr
         6L9A==
X-Gm-Message-State: AOUpUlHhlPGQHZVaGjCFMprApA4fz8qj3vBAhHYKNHmne3PpFiKK93zt
        Hucsbw/kIK3q3u7piGCsu6auupEp
X-Google-Smtp-Source: AA+uWPyCvgooGF2jIM8Px9VZm8akTDtgIbZmoa/MzKwEPaSnY/GIsaKBckcHUJw+6mXZxUXZL1l9Nw==
X-Received: by 2002:a50:c101:: with SMTP id l1-v6mr3756897edf.126.1533741809296;
        Wed, 08 Aug 2018 08:23:29 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:23:28 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 14/18] builtin rebase: support --rebase-merges[=[no-]rebase-cousins]
Date:   Wed,  8 Aug 2018 21:06:36 +0545
Message-Id: <20180808152140.14585-15-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The mode to rebase non-linear branches is now supported by the builtin
rebase, too.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index dfb1e6c25b..0b94d2daaa 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -95,6 +95,7 @@ struct rebase_options {
 	int autostash;
 	char *cmd;
 	int allow_empty_message;
+	int rebase_merges, rebase_cousins;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -351,6 +352,10 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "cmd", opts->cmd);
 	add_var(&script_snippet, "allow_empty_message",
 		opts->allow_empty_message ?  "--allow-empty-message" : "");
+	add_var(&script_snippet, "rebase_merges",
+		opts->rebase_merges ? "t" : "");
+	add_var(&script_snippet, "rebase_cousins",
+		opts->rebase_cousins ? "t" : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -626,6 +631,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	int opt_c = -1;
 	struct string_list whitespace = STRING_LIST_INIT_NODUP;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
+	const char *rebase_merges = NULL;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -704,6 +710,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "allow-empty-message",
 			 &options.allow_empty_message,
 			 N_("allow rebasing commits with empty messages")),
+		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
+			N_("mode"),
+			N_("try to rebase merges instead of skipping them"),
+			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
 		OPT_END(),
 	};
 
@@ -939,6 +949,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.cmd = xstrdup(buf.buf);
 	}
 
+	if (rebase_merges) {
+		if (!*rebase_merges)
+			; /* default mode; do nothing */
+		else if (!strcmp("rebase-cousins", rebase_merges))
+			options.rebase_cousins = 1;
+		else if (strcmp("no-rebase-cousins", rebase_merges))
+			die(_("Unknown mode: %s"), rebase_merges);
+		options.rebase_merges = 1;
+		imply_interactive(&options, "--rebase-merges");
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
2.18.0

