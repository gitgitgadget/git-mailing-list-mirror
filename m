Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D26881F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfBHJFa (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:05:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41045 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfBHJFa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:05:30 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so1305126pgq.8
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dVaMCpsyCd+ofTHCnE3NqGmUgXwnXAVp7hAbtkujs5k=;
        b=amV50eOzyMbMcP132fpAvBsPIHvxiuFLPW49/HszMbDaq341Na8j5J6kwxkwjnR+A2
         Pe4yWi6bjASIq7D9+7dLRghrUQAwtb19KvfoMgaQuKsvuz051yWZfb82IHhHVN7ZCKat
         8U9IITGmxOcmp7a9p6K14/F4sAxcyCOvXxG9MyXqajs+UfULnIghamb8zUzxa9P7yqSB
         C7PSBREERFX3FlYFQJnNoos1TKAzqDproSOme5GhX54YaAlr2tg1I57Z2cF24pG8EB6G
         Zc6tE1irNjvs1dUg+a4An/ZCCaqnvdImvKmaLWMth2FS9NdMWOhgA13Q/IjvG++EhuhO
         SiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dVaMCpsyCd+ofTHCnE3NqGmUgXwnXAVp7hAbtkujs5k=;
        b=SHXB0JVJRMS9WPKx7McQFu9tuOZhRwDvsqZANS7evDfFA5Aa9W67LKWYyXHUFLXJuW
         YT+Oim7/iOSTDfy0lWzs/01TO0bf/2/wCpqLf+7kJu7APxRjDJ3XYd2jFyC0NYIwezA6
         w0KkxuvQMFuMd+7piRrn5FkhwpZsWgfd+5C33oqpzk/VC8PnxdpeNnNXv/Su6MFTYgxx
         Q7PT8Xa0FhueYsQmZU2b7UJsi91dAEMDquqYembMZgCOqo3541YG1L0hH/Av/qKEJ58R
         sR7zSYWLUb0909Pp6UVgSO2vOa/QGMjAnfGb5nhM1joupEulwlFcFY7qwxZhDdDqteY8
         v3Dg==
X-Gm-Message-State: AHQUAuYQFy5CPHsem3rvSFY2+Hn7vTyk0YuJqIod0Fya3daMvY0Hwb1x
        DXC5QJdD+/Blw88cYi/izRQ=
X-Google-Smtp-Source: AHgI3Ib7mjRO3HsByOlm+eEpEz7cCriprTbgM71heDbIeh9ZrOStltJhTbSKSclclsLoWsMWyeiwNA==
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr4217101pgc.25.1549616729751;
        Fri, 08 Feb 2019 01:05:29 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id j197sm4254318pgc.76.2019.02.08.01.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:05:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:05:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/19] switch: reject "do nothing" case
Date:   Fri,  8 Feb 2019 16:03:54 +0700
Message-Id: <20190208090401.14793-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190208090401.14793-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190208090401.14793-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git checkout" can be executed without any arguments. What it does is
not exactly great: it switches from HEAD to HEAD and shows worktree
modification as a side effect.

Make switch reject this case. Just use "git status" if you want
that side effect. For switch, you have to either

- really switch a branch
- (explicitly) detach from the current branch
- create a new branch

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4822d5c5d7..86e524f7c1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -53,6 +53,7 @@ struct checkout_opts {
 	int overlay_mode;
 	int no_dwim_new_local_branch;
 	int accept_pathspec;
+	int switch_branch_doing_nothing_is_ok;
 
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
@@ -1319,6 +1320,12 @@ static int checkout_branch(struct checkout_opts *opts,
 		die(_("Cannot switch branch to a non-commit '%s'"),
 		    new_branch_info->name);
 
+	if (!opts->switch_branch_doing_nothing_is_ok &&
+	    !new_branch_info->name &&
+	    !opts->new_branch &&
+	    !opts->force_detach)
+		die(_("missing branch or commit argument"));
+
 	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
 		int flag;
@@ -1572,6 +1579,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
+	opts.switch_branch_doing_nothing_is_ok = 1;
 	opts.accept_pathspec = 1;
 
 	options = parse_options_dup(checkout_options);
@@ -1601,6 +1609,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
 	opts.accept_pathspec = 0;
+	opts.switch_branch_doing_nothing_is_ok = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.20.1.682.gd5861c6d90

