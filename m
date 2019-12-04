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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EEAC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 07:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5589220637
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 07:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPY/qntd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLDHsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:48:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33029 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfLDHsE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 02:48:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so2972742pgk.0
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 23:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m95ZEd8SQdN1wYtZUTVcXRr1rDSCXSexJ4dYAIiyEBc=;
        b=gPY/qntdwQ2yEsFO3tSnG7LwNCbPHpHeO0vOvYm1hq3bE3rh3sL2CVH7kjOoQpUANQ
         1KnEa7JdjptHd5zDbftQaShoCv9RJRstcdgFPf7MhfkpdMDqSRu6UeUefRpeAIKrPXUZ
         eTHcd7b9D31ojJvicG7ITpedn9/qQJWNHzacya0CPpjJMHPCBQHjdKz7yyhZbecwEpOG
         YzsDv+5G9kd1oGiSnuwh2HTtsGC8e3iMIDrzyQkcgcE3HOQVilCBrB2mwahuKcWZ1b6f
         FOUlZHB0EEJHQvjoR1YTcg8KzHkREm/P0ArsMVlS7ju4M6jidrjhdazzrVx8RFV4M5or
         5wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m95ZEd8SQdN1wYtZUTVcXRr1rDSCXSexJ4dYAIiyEBc=;
        b=KhAD8s28pn4nGrEZx8Y+xn4WGFOyonT7cJjur30RGToKLrKGDIbVL/afiz+Layx8iU
         vzKDFm2C97DMOAPP3XilcJol/fnRLHj9mwRYkkaVSaq0cnTXUlHlvKgKb9ee6zrlDjNk
         YS22sslrXnl+4U3HBkiK8bbdcM5wNrQm68j9GNo554hqoyg/XHNcoA80RHwyX5axiYzr
         4uRTwVENeOkKQpsDycf6ZP5x52zgPLXiEI38eEUDC/cxXH/m/KzbSSjuaXI89qTcZDLL
         cFlwmnTiSoI1P48pyI3xczc06YB2pwKPqFZu84mleb4WdzDqlDpO1boghq0Ye/aYL+XE
         pEXQ==
X-Gm-Message-State: APjAAAX/y66aXGYGDRUjrtHOzBvh2MYfThLDXMzBGgfM3OpX3ekflOiP
        toebPVSYy+F4HJZ1LSg9h8lGnZFI
X-Google-Smtp-Source: APXvYqxwbF1TGIEvjFkxRpbqdXxV03DmCQ+LpsUhcX18zUcjoIuaRnFRgOJCgBxfqS8wDs9r6cDe9Q==
X-Received: by 2002:a65:4c06:: with SMTP id u6mr2141826pgq.412.1575445683827;
        Tue, 03 Dec 2019 23:48:03 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id 20sm5887430pgw.71.2019.12.03.23.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 23:48:03 -0800 (PST)
Date:   Tue, 3 Dec 2019 23:48:01 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/5] rebase: fix format.useAutoBase breakage
Message-ID: <eb266aaedcfb346b405a7a7073caa6b6482480fe.1575445583.git.liu.denton@gmail.com>
References: <cover.1574878089.git.liu.denton@gmail.com>
 <cover.1575445582.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575445582.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With `format.useAutoBase = true`, running rebase resulted in an
error when an upstream wasn't set:

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

