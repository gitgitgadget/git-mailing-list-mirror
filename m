Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5491C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 10:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7498B2072D
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 10:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOgCdqai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLQKlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:41:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36949 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfLQKlN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 05:41:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so10754297wru.4
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 02:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9J6uyGVm2yhh48GhZFu4j+VtolHE3Az7QExglRXOJ6A=;
        b=KOgCdqai4fWpoh4D+nAVMvewLJg9GVEboqQ+B2ycdBHkIv+UfXslaT3u9bt2ncpq0K
         FCFm6oGh5b1iqplad8zEy9v4u849b9+f+icVYv5sHXYt3MmR8jVYyJ7DW+kigX9RTgxw
         k1TuQ6JwYV8vgKXz9NrSV7gfpZh4418OZr5b/0l3guJcB8jmH5xfg/LRSoV0tRQQkwrX
         w+ylY/24mgkJot6e/ME86BrT0nhw0tKXmmQqTEjtPWHidM2K8Ljm5B4yg9I8ewHDXzAq
         Z1ph/AnS5H7PjF478N4OohBiI/0rFH6aKcR1ahdSCxPW0lXvqVyCqNMt8NfEMQpRsh2n
         wifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9J6uyGVm2yhh48GhZFu4j+VtolHE3Az7QExglRXOJ6A=;
        b=SwM9QBmPCge8D+Q8GoWuAKZAIyVLx/RzOqDmr7UZx2RYGtlHStf//n3oooBJgbqjus
         F64d/Xd8kHE1V0q1C3Iceqjk+e0tFToctPo96hGc3ZuIe5IZ+ELk0X2+8005rAHbYIIy
         N/oQCm9ABsXcm1kkJZAb/lrgtuwfcPkhkgVlEUMN1fc1mFnsodhAwtmJk23XwXWYp0M2
         9wOXcWjFGKfWYHwIYWA00ZGAo0Atkvhu4qtgXmbvBFxBj/V9Qi9tteRwtX6SvrB0sBUg
         /XKvbi3DbdcqUCBvHguqVFMZpD2rnJRAz0XDM8WF34WccZcT8WCJwd+/t/4Rn0RlNLHH
         BWBg==
X-Gm-Message-State: APjAAAWo/OlZLPX8XeLvqu41hgNttzBWM9tgU5Og+raF5YpyDRr7ZkxP
        kD0GhM0EJsEDlstNpnBgZa8qhuik
X-Google-Smtp-Source: APXvYqxkP23E935dTwWXHYvbr5pg5mQJ1CblHJmmzg2axfAAe7Px0v0WGHvZeAMn2BdR5o0fv0GDBA==
X-Received: by 2002:adf:9104:: with SMTP id j4mr36460076wrj.221.1576579272235;
        Tue, 17 Dec 2019 02:41:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm2429456wmi.5.2019.12.17.02.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 02:41:11 -0800 (PST)
Message-Id: <7a4c330d03716dac637cc566257647318beb93b4.1576579264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.174.git.1576579264.gitgitgadget@gmail.com>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 10:41:04 +0000
Subject: [PATCH 7/7] commit --interactive: make it work with the built-in `add
 -i`
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
