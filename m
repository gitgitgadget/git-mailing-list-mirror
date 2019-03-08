Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E199F20248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCHJ7S (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:59:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34127 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfCHJ7S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:59:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id u9so13793786pfn.1
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfqafhQZEHMs36KxlujD7peHTHzTqojo2JkYmbrLMi4=;
        b=bMakgobkPwDwV8lDs7SbiZS4qqwr9QAzGYCwsZb8Y3dlzyhBhpTGVYDTspCaktSxyJ
         YqV5FDKVIl0CRnQDzWG0FEWBelz+VjDdoAox3yvL7abnJULsjJ1MFz9Z990N360+g1m4
         CrrKtJO5qo7XYCGjh7J6X8NFVy/WsoNVOuZDn4GOiPCkuD4WYlOWZ3bhQaih9mP14lue
         E9pg3aeeH/2GYH97+AI0TlgOtVkIdSSmZncOhUnWEkdoUzgBJcPbC+PNUSzOlmSefi1o
         a3lNMVNAzR/HfpfSvGiB3lR3B4UziBmSjmqbNvLzjWeW5q89XHZ3gt0sYRNT/T8D4xuw
         0aKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfqafhQZEHMs36KxlujD7peHTHzTqojo2JkYmbrLMi4=;
        b=cHwBc2RMNGZZpALIrsgmKZfM+rgKq03ZeAFEhLSpEKutbcryiVSBNHEeJA6hzyFZJk
         YgOLduuUNKHoqRqgX5txSsq2yJ6hUQRQOlGzo/7j1HJPq16zvxyaLbyheLCkDQEGD88u
         HYbESf55ojsccmpLfswlq5A/dIEJk3iC2y2AGaPTb1MinjnhRyAE1dcvwb27TXybGYWl
         x40dQlzgFpE5kVJS3Vu264IDbMegZGQuH3BvlfdRnM/dioc/OizqtODD93smQTQq0sKX
         b3igL+6rw/LcWuXxBiYxI7JrGVRPL9UDc++llPz1h+Cqkpu7XdrPemTvd/+vPYwABtFG
         xLOg==
X-Gm-Message-State: APjAAAX3PReuiZZETdjtULUmNsY4u8A/UFlGtd8+fXrT6KozktF7iZCM
        2fg+ZsF86kvuyd3JQl97uiA=
X-Google-Smtp-Source: APXvYqwe85MyaRf2A72rwy9L5/MAc9aMcAw3+UFcVjQ40aHHCgXFVJ3c9EqAskDXtKPlgY8XBBT2aA==
X-Received: by 2002:aa7:8459:: with SMTP id r25mr18253262pfn.65.1552039157699;
        Fri, 08 Mar 2019 01:59:17 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id i126sm16523579pfb.15.2019.03.08.01.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:59:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:59:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 15/21] switch: only allow explicit detached HEAD
Date:   Fri,  8 Mar 2019 16:57:46 +0700
Message-Id: <20190308095752.8574-16-pclouds@gmail.com>
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

"git checkout <commit>" will checkout the commit in question and
detach HEAD from the current branch. It is naturally a right thing to
do once you get git references. But detached HEAD is a scary concept
to new users because we show a lot of warnings and stuff, and it could
be hard to get out of (until you know better).

To keep switch a bit more friendly to new users, we only allow
entering detached HEAD mode when --detach is given. "git
switch" must take a branch (unless you create a new branch,
then of course switch can take any commit-ish)
---
 builtin/checkout.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f9f7ee2936..2e150f0175 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -45,6 +45,7 @@ struct checkout_opts {
 	int merge;
 	int force;
 	int force_detach;
+	int implicit_detach;
 	int writeout_stage;
 	int overwrite_ignore;
 	int ignore_skipworktree;
@@ -1341,6 +1342,14 @@ static int checkout_branch(struct checkout_opts *opts,
 	    !opts->force_detach)
 		die(_("missing branch or commit argument"));
 
+	if (!opts->implicit_detach &&
+	    !opts->force_detach &&
+	    !opts->new_branch &&
+	    !opts->new_branch_force &&
+	    new_branch_info->name &&
+	    !new_branch_info->path)
+		die(_("a branch is expected, got %s"), new_branch_info->name);
+
 	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
 		int flag;
@@ -1596,6 +1605,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.no_dwim_new_local_branch = 0;
 	opts.switch_branch_doing_nothing_is_ok = 1;
 	opts.accept_pathspec = 1;
+	opts.implicit_detach = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1625,6 +1635,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	opts.no_dwim_new_local_branch = 0;
 	opts.accept_pathspec = 0;
 	opts.switch_branch_doing_nothing_is_ok = 0;
+	opts.implicit_detach = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.rc1.337.gdf7f8d0522

