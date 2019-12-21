Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F59C2D0D4
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C7C206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uersLQ8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLUV51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 16:57:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44075 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfLUV5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 16:57:24 -0500
Received: by mail-ed1-f66.google.com with SMTP id bx28so11989901edb.11
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 13:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9J6uyGVm2yhh48GhZFu4j+VtolHE3Az7QExglRXOJ6A=;
        b=uersLQ8MKVQAzzJNPzBrWwwqCyh5i7Rj2+7+/M5eh7NMloxgEgtVwRWQi1953WWKFF
         3oL66RDqOMZRyZoQxZsYLco4dEGfxtItqMcaZLRijqTkYfttomaPkjxn7lvaM8q8+3Rs
         90MID56LR6YPwb04RaZ/aS/buvvJO9TVHN/dDtcwgV+QN+TFNLQhH15JHl16b2MsYg1L
         9BNfR7QKlm1wYUf9/oaYk4OKg7CLjvZjk/Ivxb1KR+OojCWfLJaTqfOTUdPDX0nkUhOM
         KH3+xscP2iR7Pnt+Rrlz19oxA/gdFkPhiVH+bLs1GLQT/aqAuNvGp4VJVQ8SryIk6SkY
         0fQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9J6uyGVm2yhh48GhZFu4j+VtolHE3Az7QExglRXOJ6A=;
        b=bnuvRodQsS1gmoRPL/drPck0H4jUo4N/qd0t4x6IQgNWjXKpB7H5QlGLsmZRWlsqrW
         il0VJROXqOuA6iQ91mvKpWAlSQ3DIcrPY2bKQI0ahFHxgPhDtkvJr74SryuZyjyENaix
         V0cGsIjatmqPtPXf5aEGvLe3HgIJ4JHRJn2gRm/NeSdoUDEx7wt4t/IccBetfAsnm+8J
         wEgFpCTJvnH9jONAGFnikCdVvW7miEtVDf+EgLIi7rn4ELZjpW9oLIMyYLh8L9kcie54
         R5CmcBePBQxlNLWljDuJbBaEXFoRG1nqPWItmX3BSAW/tmwhiZJw/L6UXSR21ZGcnNG5
         ImRQ==
X-Gm-Message-State: APjAAAWclp7jLGB5J87T6a1077ji7ojuPR1cCZSL3IORuM6gBwghcE6g
        YiwF2A5Y1XumyCQ28u4DRb9QRiR0
X-Google-Smtp-Source: APXvYqxr8z6xaZL1gEb91s5ogCfrML59nKANFrT4xD53BMCJa+kGgJ48GKnftWZiqWGywMTKTWk4/w==
X-Received: by 2002:aa7:d415:: with SMTP id z21mr24342369edq.264.1576965443344;
        Sat, 21 Dec 2019 13:57:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id va15sm1666032ejb.18.2019.12.21.13.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 13:57:22 -0800 (PST)
Message-Id: <ecb22159d8cf1aab83bafdf7c0cb10a2e2a6a826.1576965436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.174.v2.git.1576965436.gitgitgadget@gmail.com>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
        <pull.174.v2.git.1576965436.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 21:57:16 +0000
Subject: [PATCH v2 7/7] commit --interactive: make it work with the built-in
 `add -i`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The built-in `git add -i` machinery obviously has its `the_repository`
structure initialized at the point where `cmd_commit()` calls it, and
therefore does not look at the environment variable `GIT_INDEX_FILE`.

But when being called from `commit --interactive`, it has to, because
the index was already locked in that case, and we want to ask the
interactive add machinery to work on the `index.lock` file instead of
the `index` file.

Technically, we could teach `run_add_i()`, or for that matter
`run_add_p()`, to look specifically at that environment variable, but
the entire idea of passing in a parameter of type `struct repository *`
is to allow working on multiple repositories (and their index files)
independently.

So let's instead override the `index_file` field of that structure
temporarily.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/commit.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e588bc6ad3..32ffc7beee 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -347,7 +347,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		die(_("index file corrupt"));
 
 	if (interactive) {
-		char *old_index_env = NULL;
+		char *old_index_env = NULL, *old_repo_index_file;
 		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 
 		refresh_cache_or_die(refresh_flags);
@@ -355,12 +355,16 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		if (write_locked_index(&the_index, &index_lock, 0))
 			die(_("unable to create temporary index"));
 
+		old_repo_index_file = the_repository->index_file;
+		the_repository->index_file =
+			(char *)get_lock_file_path(&index_lock);
 		old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
-		setenv(INDEX_ENVIRONMENT, get_lock_file_path(&index_lock), 1);
+		setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
 
 		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
 			die(_("interactive add failed"));
 
+		the_repository->index_file = old_repo_index_file;
 		if (old_index_env && *old_index_env)
 			setenv(INDEX_ENVIRONMENT, old_index_env, 1);
 		else
-- 
gitgitgadget
