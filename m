Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A985C433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 23:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348631AbiEaXMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 19:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348627AbiEaXMk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 19:12:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA718FFA4
        for <git@vger.kernel.org>; Tue, 31 May 2022 16:12:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q7so21415wrg.5
        for <git@vger.kernel.org>; Tue, 31 May 2022 16:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=31DnEc6JkNQXEuRRBsgwpj5jziDg3l6B6CvTP/X6o9I=;
        b=k4ejlva8lBKry+WPf2rxYmKVpNaICeB2fPDrBqc1psDC75WKgvO0rcMRXqhisekIw+
         Y6UsNOHJJpaYo4yHcsG5IE6HrXD9fjHJgAPwr/ZlXIakV/0Hql6bK9oCsaPcwS1LLw8s
         HL9Z9vldgdFtNpB/iArmXxwEshK6zJmK2DqAV036u/0LXI9AUlASjhQBS73CHWumughf
         fVjauvBvEjtdxMUDynfTq4n1Q0cTUvXY7BD1h7wC37XS3IlGoqmjHGSY1d+4v5mNBy6y
         fsQ3rLNgN94yTVs4fcfapLvLYfywnXr+r/jw9MkCjKH+3HmC/WG9NdosIuw64h11+jg7
         0O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=31DnEc6JkNQXEuRRBsgwpj5jziDg3l6B6CvTP/X6o9I=;
        b=gMRYpU488mMALWQ3hOdEhgs6/4Qa7kt1RqBT6gqP6BUSACr21+KZwFXFw+h+zfvUBm
         +rxTF/1CV+Fq0ZvbdTENV2FkjMq24AACGewZEAr8b7J1N1NBzEUiTPozzyt93NMBmbNf
         TYusJItRu1e7eU9ZukhvekXDlmhnO3WhT0n1nRosjNZqbUQOFFn2iCnr4IoWh78ch3AS
         a+5OIw80EY7VKv1szo1OuMGM0BUTEaRo37DzfjA1c20zcLdiknFiRSEhLDEayI1X7nbL
         JlABg6wYrYjKRkRcYGbgN5C3/URS11PjKzGPE/QuGHgCJIB6uaTSDHvO34i5iTJX0/et
         MCng==
X-Gm-Message-State: AOAM533ZqAwh1RUluD7lo+L2EBkkpmmN4YOXKUsoTHRW2fqf6fKfUxv2
        Yp2hv/EdaGNGrc9xvhvV4gfHg0SwuUI=
X-Google-Smtp-Source: ABdhPJwpdb0o7r12GPptKh8gnEkbVxKrnrfiDj7GwMkd6LkBMXMKUyEFL0ssvkB7d0RWibK5bbSxAA==
X-Received: by 2002:a5d:54cc:0:b0:210:3d9f:4770 with SMTP id x12-20020a5d54cc000000b002103d9f4770mr808662wrv.122.1654038757556;
        Tue, 31 May 2022 16:12:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id be5-20020a05600c1e8500b003942a244ee6sm90839wmb.43.2022.05.31.16.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 16:12:36 -0700 (PDT)
Message-Id: <df6e4db6072e90afc92505a73792cf3c3221d5e4.1654038754.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1273.git.git.1654038754.gitgitgadget@gmail.com>
References: <pull.1273.git.git.1654038754.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 May 2022 23:12:33 +0000
Subject: [PATCH 1/2] remote.c: don't BUG() on 0-length branch names
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "Ing. Martin Prantl Ph.D." <perry@ntis.zcu.cz>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

4a2dcb1a08 (remote: die if branch is not found in repository,
2021-11-17) introduced a regression where multiple config entries with
an empty branch name, e.g.

[branch ""]
  remote = foo
  merge = bar

could cause Git to fail when it tries to look up branch tracking
information.

We parse the config key to get (branch name, branch name length), but
when the branch name subsection is empty, we get a bogus branch name,
e.g. "branch..remote" gives (".remote", 0). We continue to use the bogus
branch name as if it were valid, and prior to 4a2dcb1a08, this wasn't an
issue because length = 0 caused the branch name to effectively be ""
everywhere.

However, that commit handles length = 0 inconsistently when we create
the branch:

- When find_branch() is called to check if the branch exists in the
  branch hash map, it interprets a length of 0 to mean that it should
  call strlen on the char pointer.
- But the code path that inserts into the branch hash map interprets a
  length of 0 to mean that the string is 0-length.

This results in the bug described above:

- "branch..remote" looks for ".remote" in the branch hash map. Since we
  do not find it, we insert the "" entry into the hash map.
- "branch..merge" looks for ".merge" in the branch hash map. Since we
  do not find it, we again try to insert the "" entry into the hash map.
  However, the entries in the branch hash map are supposed to be
  appended to, not overwritten.
- Since overwriting an entry is a BUG(), Git fails instead of silently
  ignoring the empty branch name.

Fix the bug by removing the convenience strlen functionality, so that
0 means that the string is 0-length. We still insert a bogus branch name
into the hash map, but this will be fixed in a later commit.

Reported-by: "Ing. Martin Prantl Ph.D." <perry@ntis.zcu.cz>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 remote.c              |  6 ++----
 t/t5516-fetch-push.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index 42a4e7106e1..cf7015ae8ab 100644
--- a/remote.c
+++ b/remote.c
@@ -195,9 +195,6 @@ static struct branch *find_branch(struct remote_state *remote_state,
 	struct branches_hash_key lookup;
 	struct hashmap_entry lookup_entry, *e;
 
-	if (!len)
-		len = strlen(name);
-
 	lookup.str = name;
 	lookup.len = len;
 	hashmap_entry_init(&lookup_entry, memhash(name, len));
@@ -214,7 +211,8 @@ static void die_on_missing_branch(struct repository *repo,
 {
 	/* branch == NULL is always valid because it represents detached HEAD. */
 	if (branch &&
-	    branch != find_branch(repo->remote_state, branch->name, 0))
+	    branch != find_branch(repo->remote_state, branch->name,
+				  strlen(branch->name)))
 		die("branch %s was not found in the repository", branch->name);
 }
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4dfb080433e..a05268952e9 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -598,6 +598,16 @@ test_expect_success 'branch.*.pushremote config order is irrelevant' '
 	check_push_result two_repo $the_commit heads/main
 '
 
+test_expect_success 'push ignores empty branch name entries' '
+	mk_test one_repo heads/main &&
+	test_config remote.one.url one_repo &&
+	test_config branch..remote one &&
+	test_config branch..merge refs/heads/ &&
+	test_config branch.main.remote one &&
+	test_config branch.main.merge refs/heads/main &&
+	git push
+'
+
 test_expect_success 'push with dry-run' '
 
 	mk_test testrepo heads/main &&
-- 
gitgitgadget

