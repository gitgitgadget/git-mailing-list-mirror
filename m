Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC759211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 21:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeK3JGU (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 04:06:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42726 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeK3JGT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 04:06:19 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so2623166lfh.9
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 13:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zWvlYzr0vz67Mhmuy7AmyeNLjG5naZn5znuDUyEFOjM=;
        b=JkRC7OV0GK3uNgK7YrJnV/eZsiStIEevaXa1/WKL9qPdzoYrV+jbBSrDZBRdAVKvWA
         h6ykLlsbTXlYf+iIDmqsJbpec1T2zJCQ6809YJmnXLyteSZypYjgGpIq5+pMkcVgyhJY
         sIySFaG/cGcHkdNndEDXwyMkuRx5xP6OlvfPb/a4WNn4hU9xtSKi92JodW2vAtC0fPPl
         B60rZuq0hDgwUKPUm/hlvATsUd55vTbPcA6pNthY8EV0tO5R8sAoVtrWqWgDQL7dlTUR
         9l2hgcjdnQUAmjP+Tzn0GfsjiEeOyHYxYSUXp/X0jUgVPYj5/YiOXXatuvNMWdGIV2yp
         vVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zWvlYzr0vz67Mhmuy7AmyeNLjG5naZn5znuDUyEFOjM=;
        b=VK50md2SpaQwo7yYfo68Ww9jIY8k6VIvN6/mKOdNoMPxAx22h6FsNOevj84WZGsbW+
         83ag9hzFZLtqUWxP5PQY8B83cMkn0ticExwybGMyxgRODOjBBgs5LHlWC180RcUhBN1O
         zFL9V6qyogaMps7cFJNx52otEOWJ+MfmNsr0alnc8ugU8TfcybD0gp8WeEOIL6nn/DCx
         5RSAT/+4/KJu66VJAw0G1bTcTO+hC6M/FOLiRmebsLfu2mAF7VU0fN7/0JDAJRFmC61F
         r4e18316n8XgCADOuk/VNlxsHqF5bs6WP1tJvNgI4IR9qiOKRmGoTp1IwtEoL9513zM/
         /RtQ==
X-Gm-Message-State: AA+aEWZjPQCbXT4dDtpZ/mHywBBWDP9bAttHS3Ijv0eH+kzDypTZnqJh
        LtYWddOJ6Po8kcM2oHFg0bg=
X-Google-Smtp-Source: AFSGD/WHLKxKIp43kTL7LaNOiQP1w06gbAeWAopKhNoOp+sQ1slyfQDKAaFXXAIA9piAQ2M9Lo/pZA==
X-Received: by 2002:a19:9fcd:: with SMTP id i196mr2114483lfe.82.1543528763902;
        Thu, 29 Nov 2018 13:59:23 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id o17sm489703lff.77.2018.11.29.13.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:59:23 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com
Subject: [PATCH v3 10/14] switch-branch: reject "do nothing" case
Date:   Thu, 29 Nov 2018 22:58:45 +0100
Message-Id: <20181129215850.7278-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.380.g3eb999425c.dirty
In-Reply-To: <20181129215850.7278-1-pclouds@gmail.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git checkout" can be executed without any arguments. What it does is
not exactly great: it switches from HEAD to HEAD and showing worktree
modification as a side effect.

Make switch-branch reject this case. You have to either

- really switch a branch
- (explicitly) detach from the current branch
- create a new branch

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 880030e929..c7ae068d2c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -56,6 +56,7 @@ struct checkout_opts {
 	int show_progress;
 	int dwim_new_local_branch;
 	int accept_pathspec;
+	int switch_branch_doing_nothing_not_ok;
 
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
@@ -1233,6 +1234,13 @@ static int checkout_branch(struct checkout_opts *opts,
 		die(_("Cannot switch branch to a non-commit '%s'"),
 		    new_branch_info->name);
 
+	if (opts->switch_branch_doing_nothing_not_ok &&
+	    !new_branch_info->name &&
+	    !opts->new_branch &&
+	    !opts->new_branch_force &&
+	    !opts->force_detach)
+		die(_("nothing to do"));
+
 	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
 		int flag;
@@ -1475,6 +1483,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
+	opts.switch_branch_doing_nothing_not_ok = 0;
 	opts.accept_pathspec = 1;
 
 	options = parse_options_dup(checkout_options);
@@ -1503,6 +1512,7 @@ int cmd_switch_branch(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
 	opts.accept_pathspec = 0;
+	opts.switch_branch_doing_nothing_not_ok = 1;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.20.0.rc1.380.g3eb999425c.dirty

