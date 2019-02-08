Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36E611F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfBHJFg (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:05:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35360 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfBHJFf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:05:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so1316746pgs.2
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rlh8yO6YPTG3lRKWtVQOiuMuc7ylW5jHbM1Z+mqHyko=;
        b=ZQsaDgHV5FO5/UxIcqEbGwKJIJNw8RzHdX18ZEAB/uuzm7yQIsK0H6SgBtd1ZpZKGW
         N13uaiMz05PrjKFNowF6vioCFxrBAHZuvbL6W9LyxK9NHMDRoT4C3wDs8APhLyulLsQ7
         Ke9s8ANKXstUj4CCoj/a3ncVdoLTnKHTagED9DoWbIzABXmZoe+U0OmI7bbgG0kp23+G
         61xTM4SLWmfQvaxYqeSP1UxfCSbU5kHGz7YIuCqDtX/qlx4k4judnZTaFRMuXVCRMFl+
         FoszyrJVe9PYYWu8fYPn9S0kTsFwBB8GQrX8sn33k7C1OVmRe2scoab0URKHLJckp/84
         qfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rlh8yO6YPTG3lRKWtVQOiuMuc7ylW5jHbM1Z+mqHyko=;
        b=hj98Nha6MW+WXMZEvprcoJelc34gVZBKsaM77EZULpqu4ZPlZ4MYWHi2KBsG83uijC
         l5Ao1kaoeDCcXR7SQH4MMw40nMhSDJock3jhpIjy82Q6s+ciERxRRs4onTDnJTBVnQV8
         rR28r24uicjdm7WJIXkPEDFzUOvNexsSNfV8s9Vhoowo+rgP2cEoQSvKAaBrBWii8iHc
         KNaNdU4OvMt9kicuOc04GWmaPtvMQP3hr/Md/5Q9zk/T0oa9m/h15k667ikaYDnnJ8OB
         mcRgbb2kTC7L8GxXtfASzbbEvCXgHwO/g9AeRSiFHzOBUgw54mhAokLnoAFkSQtg08D0
         exaQ==
X-Gm-Message-State: AHQUAuaQNb4jyKGBqL8OFNovOkOfwATsqQTNcDFfNQi/0+ALJj4z3Qqj
        XoH8Iipwxt5ta0J8USveSVo=
X-Google-Smtp-Source: AHgI3IaHgnyxbhQRb6BHcVPj6bofFnIuzhwLiFPxFtTjKC0VuuWso2L2sR1mIq51SKxfYSFIK348+g==
X-Received: by 2002:a65:6150:: with SMTP id o16mr17179780pgv.434.1549616735011;
        Fri, 08 Feb 2019 01:05:35 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id t5sm2447698pfb.60.2019.02.08.01.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:05:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:05:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/19] switch: only allow explicit detached HEAD
Date:   Fri,  8 Feb 2019 16:03:55 +0700
Message-Id: <20190208090401.14793-14-pclouds@gmail.com>
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

"git checkout <commit>" will checkout the commit in question and
detach HEAD from the current branch. It is naturally a right thing to
do once you get git references. But detached HEAD is a scary concept
to new users because we show a lot of warnings and stuff, and it could
be hard to get out of (until you know better).

To keep switch a bit more friendly to new users, we only allow
entering detached HEAD mode when --detach is given. "git
switch" must take a branch (unless you create a new branch,
then of course switch can take any commit-ish)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 86e524f7c1..d6c968f5f3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -44,6 +44,7 @@ struct checkout_opts {
 	int merge;
 	int force;
 	int force_detach;
+	int implicit_detach;
 	int writeout_stage;
 	int overwrite_ignore;
 	int ignore_skipworktree;
@@ -1326,6 +1327,14 @@ static int checkout_branch(struct checkout_opts *opts,
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
@@ -1581,6 +1590,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.no_dwim_new_local_branch = 0;
 	opts.switch_branch_doing_nothing_is_ok = 1;
 	opts.accept_pathspec = 1;
+	opts.implicit_detach = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1610,6 +1620,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	opts.no_dwim_new_local_branch = 0;
 	opts.accept_pathspec = 0;
 	opts.switch_branch_doing_nothing_is_ok = 0;
+	opts.implicit_detach = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.20.1.682.gd5861c6d90

