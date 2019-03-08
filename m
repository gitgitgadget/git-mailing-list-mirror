Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72FCD20248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfCHJ7O (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:59:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34113 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCHJ7N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:59:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id u9so13793641pfn.1
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eDFa1bxahrMzL/bSzozwarOFzOtcike6ljSq6Sbn8fo=;
        b=lNjzkhhniZ9JHPP6pTRcZ5SMXtG1IqIQs2Jjcji9LLGthMg7ttzdKVJA5NNe5ejVbe
         eke4nAZypjGmzbBqJXhXvgRysJBbLxlwyNhixQFdTVqpKgyJYzidPnD+aWiA1f7ElssW
         ocDxURn1aJRy48X25wXba491BRm8pgDlubS1JHKYPkfZVXHySq+inPmZWPCjxJ9s1s2i
         EWi5qjr3LUzKaBt4a67DaLNf5hgQ/qJgh41/CprRbdlzDhbHL53BFoJlkGAHqxcyzKWb
         psarnMdtHEzU9ZK2NqPI70GJvy/sI4J4bXQcvTiOP0rSzzRwc1gJdGAyeOLhYvfMIU5/
         bQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eDFa1bxahrMzL/bSzozwarOFzOtcike6ljSq6Sbn8fo=;
        b=LBs6grQlfgkJzrwsPfsYEjQgLNJSiTueSsUOBHNNj1dv1s4HijVyoyXQhHdPWkBlho
         ZjJq8Y0CMmG1VhHLLPkykvDitHO/rRPyIXnBJBJxNg4bgBEpDt18zucXbZZNKIVBb2MG
         zonviA81xZzLGLN7In9rKtWOVa542cx/ezyuOr/y6UHNAy5AoWp5jBpO8IK8DZZXvIu5
         UlzrqIkmuc6J661G1iIdld3obApeebZd12+b4KcaANV2DXSPuqA5K39fhXkGvQ9Dacyp
         nQanr/DeR9Q0MSKd6GTP7wS0BicE2UpDPS1FESi5qgKWU2lI/dzCUZIN1rFtReTKcYPb
         OrXg==
X-Gm-Message-State: APjAAAVt7eofxSHgBrIho2bKqzlyICbuXsc3BJzY0GL9NVQOmpHQXUtN
        kyQ5BUg+ux7wR7JT0XIQ0lY=
X-Google-Smtp-Source: APXvYqxHkEKTjneYz0cmZcGYNfSYnI0BWgHB7OIC7X/2adf1wsOKZ8KT/u/8T/8huHv+gHlQKALtqQ==
X-Received: by 2002:a65:62d4:: with SMTP id m20mr16049320pgv.416.1552039152805;
        Fri, 08 Mar 2019 01:59:12 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id l28sm18691145pfi.186.2019.03.08.01.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:59:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:59:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 14/21] switch: reject "do nothing" case
Date:   Fri,  8 Mar 2019 16:57:45 +0700
Message-Id: <20190308095752.8574-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
MIME-Version: 1.0
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
---
 builtin/checkout.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1b1181b220..f9f7ee2936 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -54,6 +54,7 @@ struct checkout_opts {
 	int overlay_mode;
 	int no_dwim_new_local_branch;
 	int accept_pathspec;
+	int switch_branch_doing_nothing_is_ok;
 
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
@@ -1334,6 +1335,12 @@ static int checkout_branch(struct checkout_opts *opts,
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
@@ -1587,6 +1594,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
+	opts.switch_branch_doing_nothing_is_ok = 1;
 	opts.accept_pathspec = 1;
 
 	options = parse_options_dup(checkout_options);
@@ -1616,6 +1624,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
 	opts.accept_pathspec = 0;
+	opts.switch_branch_doing_nothing_is_ok = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.rc1.337.gdf7f8d0522

