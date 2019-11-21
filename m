Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125B9C43215
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 15:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF90F20692
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 15:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBZjnjHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKUPwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:52:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38203 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUPwB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 10:52:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id z19so4288173wmk.3
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 07:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/QyY279sZLZB4OrbtVh4TZ7H0m5WH572NfxLyQ1N6Zw=;
        b=JBZjnjHJkIioDJuQ0EPM/8sG4UCJkI1WnzndR+wAMTrB8XLbwbqErdmzXEK4ILF6+v
         o7+U6xFHTEiFsWDXVDnFjnK+DQHz/eYvRsm5+2FBzZuwl2CdjucOvxCbP4lULDkD1jL+
         0HmBioImstvpojlIXe6YrPftoqNs2rArpo4KQ3phPQHLA7yyE3EqMCefIL6wekcw5uJt
         TlQRZo+gAUlNbaXDHRujQ8qQvCM+hcZ1lA9SmDRm9tUHzAUxvU38TeiVW/qkywLu5YhR
         93Rpl+/flVA+Bmxwzgh7TGOQ4T1jtG3FLlK0y539dwx9FWgEOCcnsuS+XltL1Zaa39fJ
         yMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/QyY279sZLZB4OrbtVh4TZ7H0m5WH572NfxLyQ1N6Zw=;
        b=BDZ9B7vq/yWNMX8MVZmhmaWnFfivyWqom66K3Dj68GfTdkkR7f6S6/kTflqHu9lpWu
         NEKyCY14TZ3bUXad/g2CAzE2BbEYZV9dzFrfQaKcRuO2NFn7VyGmZsLnV1i/KOQHNHWn
         7M/VrVRBOCKfsP97EKqME0lXQIkv/wD7DiuRujHeDOTTPKkJnB3u5kTYYKoxES3DWgwn
         C8458PlGcSiSrFkXSkN/6Gx9KHZk09t/nNlNmNYdhpW8b4SAWBMQUB97Jcd0RGE9FIWl
         qYgN9CWjjPPOkEGoChzzaORZhSQ2pjEwEu4YKHYp0Rk1aa0Ay963GU1Ik+ke/maoAslp
         hScQ==
X-Gm-Message-State: APjAAAVeVXEGiBwtSnf/peSZeVbG09VlgcWof9ViRCYRcTdGZr/WzpRd
        9LqyTEN9ng5z6gYSZ2BrD9poTeCQ
X-Google-Smtp-Source: APXvYqzMenR3NL0hrZEx5IFFlzuXAt7mVeK7CPdt6ARjuwplwLk5rqgqmOMkngM6MJhZbw6OWbvRiw==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr11028643wml.29.1574351519396;
        Thu, 21 Nov 2019 07:51:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm30438wmh.40.2019.11.21.07.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:51:58 -0800 (PST)
Message-Id: <e62dcc1ce503311c6c11452862f384492965a35f.1574351516.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.450.v4.git.1574351516.gitgitgadget@gmail.com>
References: <pull.450.v3.git.1573148818.gitgitgadget@gmail.com>
        <pull.450.v4.git.1574351516.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 15:51:56 +0000
Subject: [PATCH v4 2/2] commit-graph: use start_delayed_progress()
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
to use GIT_PROGRESS_DELAY=0 to force the expected output. However, there
is one test in t6500-gc.sh that uses the test_terminal method. This
mechanism does not preserve the GIT_PROGRESS_DELAY environment variable,
so we need to modify check on the output. We still watch for the
"Enumerating objects" progress but no longer look for "Computing
commit graph generation numbers".

Reported-by: ryenus <ryenus@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 2 +-
 t/t6500-gc.sh  | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

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
index 7f79eedd1c..c68177510b 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -111,8 +111,7 @@ test_expect_success 'gc --no-quiet' '
 test_expect_success TTY 'with TTY: gc --no-quiet' '
 	test_terminal git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
 	test_must_be_empty stdout &&
-	test_i18ngrep "Enumerating objects" stderr &&
-	test_i18ngrep "Computing commit graph generation numbers" stderr
+	test_i18ngrep "Enumerating objects" stderr
 '
 
 test_expect_success 'gc --quiet' '
-- 
gitgitgadget
