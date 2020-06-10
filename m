Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F162C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BEBA2072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0ubuorY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgFJVTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFJVTl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 17:19:41 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C995EC03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u13so3161068wml.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8wj3R1dl3ZUsQbIszwYs/WQOqQca6NeSqMcBFVfSOXA=;
        b=o0ubuorYWufTM/Kkp68eQRYSXNRS62C+4vHAO3qB6uuYtWV621edlpXeAnTboSv4J4
         tqgo2eaJ6m9+ZtA8tpwQ3nMLwHHSC8tBSn6rMHxBAZ/Ltg0NmR58k/4D/cK5ONzZI48n
         M4X60ektvECvv8q43AHYTc5uOCqlR3OaiINRTBBqpoq1z8/Bxk0RafYZ5VuglWwP6Wr4
         qUnCa4QiY1Ti+qNRKonjOddrgFMz1oE9awUQm4ld9vHenxyBHPyZN9v9wKed04HTeRry
         WwiM7MQnAttgQM/FVKxCoF7ev0auP3R96OqH1AoJzdh+k+vfHuRaM9OIQFBzm/XElndm
         LKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8wj3R1dl3ZUsQbIszwYs/WQOqQca6NeSqMcBFVfSOXA=;
        b=GXM4bnxKwjEM0ab5B3pfxfzTMdrqN3FSZBfa9Nv1Gpkkhw2pb8doRto4j/WdOcMcBf
         LB2D8dna2OJPNzP5CJuKcXFNtQ/rLfUyj6BtKhTo/tzjIGjnDfdbDivmCqklgILEQ2zI
         tvwtLZ8VLQw4bDKGflfq68LvnAq7pqnPFAn/Emf13IsYG20RQalaxY4rbDKgJxak/O0z
         G2z6WmeKC5Ju3kISse3VXHSWK12BN8WgSbCl5jGZHR2A6Hhxk73JfrtEDcPFBZluHkue
         gyDvPEilFojomy+z9weHz2vddXPhhdtm8mLyZaQ96IXySpbMuhEtsWxYYyu+9BzXiIXU
         4FWQ==
X-Gm-Message-State: AOAM532r197WLUFfmoKNH4Q5KZB6VvBneBQ6fXWCTt/q7s0uhQCQe3pW
        N8+k5m4DfjzUj1Xq5X8PE3lMzV9o
X-Google-Smtp-Source: ABdhPJwOfiWeADheMUV7CPTgXf9qR5Y/Q23tjnYJOrnWileWfwskVuWlo9MKEoWgRHa8twqtT4gcGQ==
X-Received: by 2002:a1c:6446:: with SMTP id y67mr5215889wmb.156.1591823979343;
        Wed, 10 Jun 2020 14:19:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm1523957wrs.95.2020.06.10.14.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:19:38 -0700 (PDT)
Message-Id: <e849def4a8c5cc291839ef4514a386df0c148b2e.1591823971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.git.1591823971.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Jun 2020 21:19:28 +0000
Subject: [PATCH 7/9] fmt-merge-msg: learn about the possibly-configured
 default branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When formatting the commit message for merge commits, Git appends "into
<branch-name>" unless the current branch is the default branch.

Now that we can configure what the default branch name should be, we
will want to respect that setting in that scenario rather than using the
compiled-in default branch name.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fmt-merge-msg.c          | 6 ++++--
 t/t6200-fmt-merge-msg.sh | 8 ++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 72d32bd73b1..5e5c1d86f1c 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -407,7 +407,7 @@ static void fmt_merge_msg_title(struct strbuf *out,
 				const char *current_branch)
 {
 	int i = 0;
-	char *sep = "";
+	char *sep = "", *default_branch_name;
 
 	strbuf_addstr(out, "Merge ");
 	for (i = 0; i < srcs.nr; i++) {
@@ -451,10 +451,12 @@ static void fmt_merge_msg_title(struct strbuf *out,
 			strbuf_addf(out, " of %s", srcs.items[i].string);
 	}
 
-	if (!strcmp("master", current_branch))
+	default_branch_name = git_default_branch_name(1);
+	if (!strcmp(default_branch_name, current_branch))
 		strbuf_addch(out, '\n');
 	else
 		strbuf_addf(out, " into %s\n", current_branch);
+	free(default_branch_name);
 }
 
 static void fmt_tag_signature(struct strbuf *tagbuf,
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index e4c2a6eca43..a23cd157ffd 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -158,6 +158,14 @@ test_expect_success 'setup FETCH_HEAD' '
 	git fetch . left
 '
 
+test_expect_success 'with overridden default branch name' '
+	test_config core.defaultBranchName default &&
+	test_when_finished "git switch master" &&
+	git switch -c default &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	! grep "into default" actual
+'
+
 test_expect_success 'merge.log=3 limits shortlog length' '
 	cat >expected <<-EOF &&
 	Merge branch ${apos}left${apos}
-- 
gitgitgadget

