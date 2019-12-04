Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B8EC2D0BE
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C721721835
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bguk2Udr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfLDVZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:25:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37343 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfLDVZR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 16:25:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id bb5so260212plb.4
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 13:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kb4cQuMYaVmmiyEtZuL05lzGUbcsfaDlmC1YhhlEG5Y=;
        b=bguk2UdrfqXBJ3kEKAXaqBiAzmu2q4oLFhoJoWs407de+a1JOkrKLe4x2t6ThZKoo+
         bjT/NYX7zgQtFoNSgTcM+ZV2a2gcLiAxCwoof2W+N0loYw2jcjXrckEg7hEUPMAn5wwn
         v2BU+qVQCOdBijjoES1EgMS+Kpau88sykq+mMfi3b/InXEzgJzL/+e0ELJMXrvj9MFlC
         uhVkLDMKir8G1NTgPhnw+kfA6AhjLCc5mijC60O6QYs+px5pboRDbM8QtA29w7l/eZfI
         IvwLWJz08RtB2nw7p9TylURd7J/+ERzUuzOpksxTvTzOAV1sZK8/DCZz4HS+vwrLgKBV
         DraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kb4cQuMYaVmmiyEtZuL05lzGUbcsfaDlmC1YhhlEG5Y=;
        b=qNw9REHWkLxmwVAsGEM/KZwcKxej43cD2HDxH6Zf0uFBTjJZGETtcn37522FA0g/uu
         5G4EQdxoR+jBpB4+njzD1V2qgWEBhJrxc9zr9q6+F2A9igTj6X1Yx1OAVgB7B26Je8ca
         tYsu8oT6NsGD/7o8gRyWUNZRk+JHa0xSCQG6XPY2xVbHkW+wGKZuPfUGDIrajrTnRMea
         Qg0hw3GHS+OBnxMFjcpUCKAqiFVDq3DQmcxuzw//6UHlBYsUQj1FJ8HaKt1af7315NNp
         l8wCFIDAma64KLZsim4W9fztbRpDVyjbmy3fMEyIcjv+L5OrI153xTue8p4Pa3osHICD
         o2dA==
X-Gm-Message-State: APjAAAX62rid3qgs/Uo/46+xt3zoyZjA92DQxzdvdgvBdpX4i2Z6RTVb
        Uu2StlJT83c4LRI6bLqvNckGCDxH
X-Google-Smtp-Source: APXvYqzsA0CgV5dkEtgeT9m3UVTUzZ2xPbHSaZ0C/O8OD9mtAij5RgR11uFRs2LdKF9fD0q59IAsuw==
X-Received: by 2002:a17:902:6502:: with SMTP id b2mr5459976plk.182.1575494716415;
        Wed, 04 Dec 2019 13:25:16 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id k5sm7569509pju.14.2019.12.04.13.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 13:25:15 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:25:11 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 5/5] rebase: fix format.useAutoBase breakage
Message-ID: <210905f16303e9ce7ae3845e252bc07e288f70c1.1575494618.git.liu.denton@gmail.com>
References: <cover.1575445582.git.liu.denton@gmail.com>
 <cover.1575494617.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575494617.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With `format.useAutoBase = true`, running rebase resulted in an
error:

	fatal: failed to get upstream, if you want to record base commit automatically,
	please use git branch --set-upstream-to to track a remote branch.
	Or you could specify base commit by --base=<base-commit-id> manually
	error:
	git encountered an error while preparing the patches to replay
	these revisions:

	    ede2467cdedc63784887b587a61c36b7850ebfac..d8f581194799ae29bf5fa72a98cbae98a1198b12

	As a result, git cannot rebase them.

Fix this by always passing `--no-base` to format-patch from rebase so
that the effect of `format.useAutoBase` is negated.

Reported-by: Christian Biesinger <cbiesinger@google.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c  | 3 ++-
 t/t3400-rebase.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e755087b0f..51980ab63d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1012,7 +1012,8 @@ static int run_am(struct rebase_options *opts)
 	argv_array_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
 			 "--full-index", "--cherry-pick", "--right-only",
 			 "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
-			 "--no-cover-letter", "--pretty=mboxrd", "--topo-order", NULL);
+			 "--no-cover-letter", "--pretty=mboxrd", "--topo-order",
+			 "--no-base", NULL);
 	if (opts->git_format_patch_opt.len)
 		argv_array_split(&format_patch.args,
 				 opts->git_format_patch_opt.buf);
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index ca99e8c6c4..1323f30fee 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -159,7 +159,7 @@ test_expect_success 'fail when upstream arg is missing and not configured' '
 	test_must_fail git rebase
 '
 
-test_expect_failure 'rebase works with format.useAutoBase' '
+test_expect_success 'rebase works with format.useAutoBase' '
 	test_config format.useAutoBase true &&
 	git checkout topic &&
 	git rebase master
-- 
2.24.0.578.g4820254054

