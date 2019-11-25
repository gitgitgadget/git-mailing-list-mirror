Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E62C43215
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 21:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086702082F
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 21:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGk1kAWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfKYV23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 16:28:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50525 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfKYV23 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 16:28:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id l17so930354wmh.0
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 13:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nVhI0We5j/ozMNOLMLjp4b1G0baNaF3hKGWhldXspAQ=;
        b=CGk1kAWeXk0g7Enb+2kKA3KrewfTC/SRCqh/PYdaO69vGtd7ZVhd50zfKrplahc6Dt
         1+B1OS21Y1vLzs3iZJST+m33Ti7p/+sAQ3XeycmyMbYqLqBSodvhOH36VPV2N45X8mn2
         x2Pg3wfVc6JnZkvTONiJyJyv+ua4uUYorZ3UNRE/+rHmkTLvvVsozF4awSzmGo4BoDKp
         dx4F7plaf+pp2Y1aU6kYTIJ3dsyuMXgDYQ/atv5JU95qMjaf/t3TZQedUZcpYdA/iOwn
         95m8D+pvt4WbqVrl8ttsHb6ae0fq2Vw6D5Q5S7ba+7pS/TO5nSJkSMy3Fa9MV9glotJD
         JtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nVhI0We5j/ozMNOLMLjp4b1G0baNaF3hKGWhldXspAQ=;
        b=ssuej0bpUtVJUGW+MnxBKlD/EsnZEYhYN5ABoiI4jlpciOLH82ve163qfRaYjk4hC6
         /u6uPUwROmkfDMvL+hgBU7AsLaK+AMc5Z/Ms8IphjmvirFJFjAQk04R+cLpoh0JsML10
         fw30Tj/QO/bvGau059yeut6haltzgPVn9vpKOWvBPVWvPElLLqZkOPmuXg0O8Wbn8fqJ
         V8OG479jGgc6jhzthdkfbXHIgXwTgYIxMsEyKgA4Iba3eeAbQPyIxeFvqJNXVmtwELVM
         HfeeEIa8e3DwyDuohnMoZrW38XK3Eh2MJzfi91bGvtgKPOsWuXkLAFsbKxPxaGw82s4j
         l7VA==
X-Gm-Message-State: APjAAAVs05Tk2mbtnMwMABIJSQPN5DheFPKjsJtexx34rkRjfS+6z7i5
        Nfq2KCRbSD9OdQ66nLDi4i6MOJts
X-Google-Smtp-Source: APXvYqxAI9S8qxnNWha/wStrqyhgm4AKisAE0D943V8sg9H3BNbRPd0HWITVrpvo3/5U0mv53WsJJg==
X-Received: by 2002:a05:600c:2144:: with SMTP id v4mr798684wml.29.1574717306721;
        Mon, 25 Nov 2019 13:28:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17sm11309980wrp.40.2019.11.25.13.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 13:28:26 -0800 (PST)
Message-Id: <efe1419dc6cfd18f5a91061a4a61cc7228406f93.1574717303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.450.v5.git.1574717303.gitgitgadget@gmail.com>
References: <pull.450.v4.git.1574351516.gitgitgadget@gmail.com>
        <pull.450.v5.git.1574717303.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Nov 2019 21:28:23 +0000
Subject: [PATCH v5 2/2] commit-graph: use start_delayed_progress()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ryenus@gmail.com, stolee@gmail.com, peff@peff.net,
        szeder.dev@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When writing a commit-graph, we show progress along several commit
walks. When we use start_delayed_progress(), the progress line will
only appear if that step takes a decent amount of time.

However, one place was missed: computing generation numbers. This is
normally a very fast operation as all commits have been parsed in a
previous step. But, this is showing up for all users no matter how few
commits are being added.

The tests that check for the progress output have already been updated
to use GIT_PROGRESS_DELAY=0 to force the expected output.

Helped-by: Jeff King <peff@peff.net>
Reported-by: ryenus <ryenus@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 2 +-
 t/t6500-gc.sh  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0aea7b2ae5..071e1c6e9b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1103,7 +1103,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 	struct commit_list *list = NULL;
 
 	if (ctx->report_progress)
-		ctx->progress = start_progress(
+		ctx->progress = start_delayed_progress(
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 7f79eedd1c..0a69a67117 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -109,7 +109,8 @@ test_expect_success 'gc --no-quiet' '
 '
 
 test_expect_success TTY 'with TTY: gc --no-quiet' '
-	test_terminal git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
+	test_terminal env GIT_PROGRESS_DELAY=0 \
+		git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
 	test_must_be_empty stdout &&
 	test_i18ngrep "Enumerating objects" stderr &&
 	test_i18ngrep "Computing commit graph generation numbers" stderr
-- 
gitgitgadget
