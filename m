Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C0DB1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfA3Jtg (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:49:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42590 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfA3Jtf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:49:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so11163921pfr.9
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m8JBLntTWOBkAbkZhV5h0lAVUZl4Ao1ffYaYROjX5Qw=;
        b=UrrbsSysxjsMGlkUCU2qsIRJ5o22yokv56aPmDOnUOUXztWwKEfDfjTGtNv5/QTRQC
         t96XGjmnaUrb2rNwqPUtex31Tp40lj6W/2ByOYDSw3ilPDPc2feGqJUSueZbWsBJ2KBq
         b3rxIUyWpbhyGNGqzMn1GH66NTzKLGocs/qnfClwhK+6UX3UmCvMxJvLm1jxp2hjAQi9
         wZthlKo6SVyCG5r8X+lXWQp/m3nS5vApqvot8Vsc6InEpncU1suJ6v2tp47hbOhuRdTJ
         5Oj2QtVpKVsMoi4dRXUpH6YCjexcBhxthN9BmjoWjWYtvyVNOqwUITj8j0bKwjS9/QJv
         LuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m8JBLntTWOBkAbkZhV5h0lAVUZl4Ao1ffYaYROjX5Qw=;
        b=dMMDoBEYbPgm1SiWi8kdvN3eVc7kFYypmCPLf1IdUYAFBQkwZkQuVaKpfO103tKOI3
         ow2Lfiz8+SQYnWbT4H/4FIShQt6QgZ5uNJ/RTfF0YEkfamDtBJnygUIOy8sAe/OqIqJW
         ci/ClYkF4FD2fqqcVxq8iYbJm3nji0LCSBT7m+JUC/IJILwedCPF8a2XHi4XZcPVkSNe
         b/g9Txn3qSa5oUCeguaeKM7BotIebGGHVGnlHFu+sD1ziF+h+/INcdPAwQWcEQPE2p7B
         jwBkAj/ueabtEhUI9Xa3AR7P18/duf3AonOuT0iTY1DDmrL8qIop+lmJzB8w6xDuwHXk
         SzSw==
X-Gm-Message-State: AJcUukfDGHqJY7qeSH6dldh0BgCAgWdXPorkna1PZDBv9mVveRdm7si2
        r3pQ5f9ak/JxP3nPHwGS8L8dq4V/
X-Google-Smtp-Source: ALg8bN6I2wche09acGMZH2lv73WebnkAXSG1kHcc9J1/AITg+pQGONTFguAcUynXtZbXivsUQlg4hw==
X-Received: by 2002:a65:4b82:: with SMTP id t2mr26999517pgq.189.1548841774652;
        Wed, 30 Jan 2019 01:49:34 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id s190sm1632943pfb.103.2019.01.30.01.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:49:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:49:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/19] switch: reject "do nothing" case
Date:   Wed, 30 Jan 2019 16:48:24 +0700
Message-Id: <20190130094831.10420-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
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
index 7906e07352..9a58fccd71 100644
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
+		die(_("nothing to do"));
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

