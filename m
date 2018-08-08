Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD895208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeHHRnF (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:43:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34977 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeHHRnE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:43:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id e6-v6so1462916edr.2
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FO6joYEI6mnaLBwZeOZTBg40QTaf37XiXb3oppGB/XY=;
        b=BaiET/FnCwk6IB/QdkwsrZgC9UC5OeqwALisnYYzRdisNbucnEfETJUjbcgobm0gqv
         /oAWphsfLpPQAKX5FFf6YUBI3nWwR4+auPB7d6BI4Qz3Bxr88yPhzPf4h5AnqJfIUKgL
         dSVaA3K0BpanoGt6RmDJoKY0exPytg7psIsU2DhTetmDchMwP+rxlZ+MsKZQKSr573KQ
         q1QRlE3vdpN+Ck27/KP6w7XggQVoBSHpPApsyAg2HYQg068lMbBbwK92ixFMXk1oX2bC
         8+HRX+wUpoE7+9QglxCWjC799CneCp5rbTSGxuOcoUvQnHmRmcMU8F0RJK2hnNwdkNzu
         RT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FO6joYEI6mnaLBwZeOZTBg40QTaf37XiXb3oppGB/XY=;
        b=d3DAJ9K0y2TPRpnUvNf+NfI86Zwt6dZ62HsO7EFnF18pKGfV8iLw4+o+AGfGhVrQQM
         qoxG8eysb3lvAjFDuT/tNE1nDNhtpnWVeIS3cuOrSjkUrf1dKn5j6xkcsQxAKxrxszZJ
         iik1FLglw5hNXydBVPb7hDhrC1cEx9XmTOvd19VeTuFw+TwUdIyjLWGL/2w2oIuJDYyT
         3Rw5OAewV8Kv/aOIYCO243pycBd+912Jf+WYbz9LfctUkmt9euH3DBnUby+ClpzjMw4m
         lNkPl1qPkFPaQOHrbvnj72J46wcTJVpMNe6sM0zcVOkfMQ7yu/4sx2qrmWCx5+AOGpfV
         jqQw==
X-Gm-Message-State: AOUpUlGrKHISE7mwkoQr0I4CdUQ9pGRtNzOQ7FumkA+VENlQda8Zkfwy
        UI3IAhxkwai74mM+rV5jVw17zs48
X-Google-Smtp-Source: AA+uWPwMTHCJ40amncjA6lYskx++SWvN/vZLfv/v0vFYoaRzq7BYXHMWY+/BGKuAbMuI3cd5z1k3uw==
X-Received: by 2002:a50:a8a6:: with SMTP id k35-v6mr2532715edc.135.1533741775814;
        Wed, 08 Aug 2018 08:22:55 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:22:55 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 05/18] builtin rebase: support `ignore-whitespace` option
Date:   Wed,  8 Aug 2018 21:06:27 +0545
Message-Id: <20180808152140.14585-6-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit adds support for the `--ignore-whitespace` option
of the rebase command. This option is simply passed to the
`--am` backend.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index eef16206c2..7490d215ef 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -527,6 +527,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		ACTION_SHOW_CURRENT_PATCH,
 	} action = NO_ACTION;
 	int committer_date_is_author_date = 0;
+	int ignore_whitespace = 0;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -542,6 +543,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		{OPTION_NEGBIT, 'n', "no-stat", &options.flags, NULL,
 			N_("do not show diffstat of what changed upstream"),
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
+		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
+			 N_("passed to 'git apply'")),
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by: line to each commit")),
 		OPT_BOOL(0, "committer-date-is-author-date",
@@ -773,6 +776,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.flags |= REBASE_FORCE;
 	}
 
+	if (ignore_whitespace)
+		strbuf_addstr(&options.git_am_opt, " --ignore-whitespace");
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
-- 
2.18.0

