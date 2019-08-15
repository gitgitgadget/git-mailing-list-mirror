Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED7AA1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733100AbfHOVlq (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:41:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36738 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733027AbfHOVli (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:41:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id w2so1991458pfi.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0GdlyzOw+6qrpmuXbLra+wuiooFYZ8BhaCWHPEQNvl8=;
        b=T4Yrn0mREuDeWZscbhxLSpfM4T09MEqriGsaOgWIo8IOQV3MrQ4texqHVJD4sG9dHo
         x0FiydWPE2Z6J9DltOin+9mrShwYvF6ntfGVnEYCwnDf8z2UCBV7NSAviZ7R9cQ8n1Bo
         rWDKvRNs1QEpnzOjQJafC09mkWuBRZdJTxYnbam+iFc5ODvn+Q6GHaa8TZ4D3/BAUW80
         QoddWRowiVWXB9RwxV5uIZWYXKzA9f2XpxiWCoHsHWBoDs10hul9ygtBPj1fswd+/FvP
         9GKqwjcCgF3j0VJ7Xid8fY8JwRzk765tPyo2/DSV1ImdcM2avJT9ztA6oQMi5bqF/XwD
         CcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0GdlyzOw+6qrpmuXbLra+wuiooFYZ8BhaCWHPEQNvl8=;
        b=VFr7CH3U92wceUtP1NwofNA57as+hAhX0bpR86eHmJRqajoLU6M+Q6k2llB70PHnOT
         lmoh0w7qCOQBslZ0UF6civ48AGTIQ+nF8KoXkHApf+ChZo+HAWhlG1yqcbPrKDgZbwzk
         6OQ3fPxHfulg+pUE+MOxtLMjVRC0xIXtxKGw6g77MH14IkbOGfAmnum4WBShq8ThTCXX
         y/MxooQAz3sgQlplN4RV7KZCcyzBOkuB8uQzrMyvvqGfnUGIAWot3NW5p+YfJGRcpKp+
         1z3hm4xPkEIw/3oVq1hPPreNImfftOL7I2DE5KXMrVlNMrr38r0geZX8FR4jmiNOqtj8
         mcFQ==
X-Gm-Message-State: APjAAAV53y4eGcKC8XI6K0LgslOLLtPjtgmCaujYfXdEOpw9isAHjUyL
        9Zi9aIYaeYoOkqDrITz05ZA4Yg/N
X-Google-Smtp-Source: APXvYqyc194dTHltj7gCGzc9nNB1mWwfIk965ulyhENnZE9kV/Q1iw6waYg1KEV9H+1d32sXvXtYjA==
X-Received: by 2002:a17:90a:8991:: with SMTP id v17mr3984331pjn.120.1565905297904;
        Thu, 15 Aug 2019 14:41:37 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id i124sm4131966pfe.61.2019.08.15.14.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:41:37 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 23/24] merge-recursive: add sanity checks for relevant merge_options
Date:   Thu, 15 Aug 2019 14:40:52 -0700
Message-Id: <20190815214053.16594-24-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.32.g2123e9e4e4
In-Reply-To: <20190815214053.16594-1-newren@gmail.com>
References: <20190726155258.28561-1-newren@gmail.com>
 <20190815214053.16594-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are lots of options that callers can set, yet most have a limited
range of valid values, some options are meant for output (e.g.
opt->obuf, which is expected to start empty), and callers are expected
to not set opt->priv.  Add several sanity checks to ensure callers
provide sane values.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 23 +++++++++++++++++++++++
 merge-recursive.h |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 647b1f25c3..bc0da608c4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3620,6 +3620,29 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 {
 	struct strbuf sb = STRBUF_INIT;
 
+	/* Sanity checks on opt */
+	assert(opt->repo);
+
+	assert(opt->branch1 && opt->branch2);
+
+	assert(opt->detect_renames >= -1 &&
+	       opt->detect_renames <= DIFF_DETECT_COPY);
+	assert(opt->detect_directory_renames >= MERGE_DIRECTORY_RENAMES_NONE &&
+	       opt->detect_directory_renames <= MERGE_DIRECTORY_RENAMES_TRUE);
+	assert(opt->rename_limit >= -1);
+	assert(opt->rename_score >= 0 && opt->rename_score <= MAX_SCORE);
+
+	assert(opt->xdl_opts >= 0);
+	assert(opt->recursive_variant >= MERGE_VARIANT_NORMAL &&
+	       opt->recursive_variant <= MERGE_VARIANT_THEIRS);
+
+	assert(opt->verbosity >= 0 && opt->verbosity <= 5);
+	assert(opt->buffer_output >= 0 && opt->buffer_output <= 2);
+	assert(opt->obuf.len == 0);
+
+	assert(opt->priv == NULL);
+
+	/* Sanity check on repo state; index must match head */
 	if (repo_index_has_changes(opt->repo, head, &sb)) {
 		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
 		    sb.buf);
diff --git a/merge-recursive.h b/merge-recursive.h
index 978847e672..d201ee80fb 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -27,7 +27,7 @@ struct merge_options {
 	} detect_directory_renames;
 	int rename_limit;
 	int rename_score;
-	int show_rename_progress;
+	int show_rename_progress : 1;
 
 	/* xdiff-related options (patience, ignore whitespace, ours/theirs) */
 	long xdl_opts;
-- 
2.23.0.rc2.32.g2123e9e4e4

