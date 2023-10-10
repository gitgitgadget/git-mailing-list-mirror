Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB869CD80C1
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 12:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjJJMjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjJJMj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 08:39:26 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE50ADA
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so53983295e9.3
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 05:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696941555; x=1697546355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jR1XyF6IYB0kqtD7JZ+p7VDCFKX9AOIuEefk+PYcg0=;
        b=DwgGsoqnVoyFf4//3QM6YpT3JdsjuKwSQu4VBWXwirtKyVPxm7ELrBgmKar7dkbx9H
         sM3qJMFGw8MyG2ZjnokU8KCHOJp3SQ0KgajED6eLhmmFMZLchJMYwio8RH85l5w8cOlu
         IgCuDTGioWn6uRMzgnNiZfKB7ZS8YyR6bd35kbzeKmdw6OX6kv5GQsIRbcz4/pp/2iWe
         Mqpkdoat1DVmbENvqKNA/GcS8rf0WuNgZ6PWcZgOBJDXPCAajVa+sl/KdYIAOU1FhQHA
         3SIiYFlrprKHk07PKrS0+xlauTzBDCqHMQMws941hL/xQJL3/yXktXLR4NW6s2fbN0bA
         gy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941555; x=1697546355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jR1XyF6IYB0kqtD7JZ+p7VDCFKX9AOIuEefk+PYcg0=;
        b=C+KUk4bY5T1L9PyJk2p1iL2nCf/hsjbL/iuairhThgrodibKilHpLMW4tEEYPc7yQ2
         NDim/ErqMksx8bBh4miwcuCjkl8vEx9RGUIHECFMKKqbq1VBWUE934zJ4F3yqTtXIjy4
         PFfNUxpyD557wQUTxDzWDzVzzOYnMGC5UpLIyoKlxMslY1Zl0FYTTmQRFhhrBpwq4YPT
         FAKF2cuDzuyUaPAhvaoNdh6vVxaXUtt/xu8gU9GIyRj2WAOdvKQGYG7LRG+TAvVKMAwA
         xy5w4NtrOMyFe4uw9eYzfwJ6Tq9bpqEy4C1oW0688FbUJ5eUgP1mABUoiUnsSVONde66
         6WzQ==
X-Gm-Message-State: AOJu0YxB5MfBd3N7nIUD+WWxdyl+4RPqKxbtSGnxO6Cz3RRbtChPUeAA
        mBIjcaXQbYNqLD4Y7YuNMuzRENT+4L/0Ww==
X-Google-Smtp-Source: AGHT+IFpAwQBSUwZ3BRZYjnkRep9kmuL+eTxIMAIQY+Anarx8/wXxG+Q29SMN63q9aXWFHSsgHKvNA==
X-Received: by 2002:a05:600c:ac7:b0:403:b6bc:d90d with SMTP id c7-20020a05600c0ac700b00403b6bcd90dmr16245464wmr.20.1696941554560;
        Tue, 10 Oct 2023 05:39:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:516d:299b:cbff:be05])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcc8f000000b003fee6e170f9sm14071689wma.45.2023.10.10.05.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:39:13 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Dragan Simic <dsimic@manjaro.org>,
        Linus Arver <linusa@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 08/14] replay: remove progress and info output
Date:   Tue, 10 Oct 2023 14:38:41 +0200
Message-ID: <20231010123847.2777056-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.339.g663cbc8ab1
In-Reply-To: <20231010123847.2777056-1-christian.couder@gmail.com>
References: <20230907092521.733746-1-christian.couder@gmail.com>
 <20231010123847.2777056-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The replay command will be changed in a follow up commit, so that it
will not update refs directly, but instead it will print on stdout a
list of commands that can be consumed by `git update-ref --stdin`.

We don't want this output to be polluted by its current low value
output, so let's just remove the latter.

In the future, when the command gets an option to update refs by
itself, it will make a lot of sense to display a progress meter, but
we are not there yet.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index dbadf3b9b4..08a7f68420 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -195,7 +195,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 	init_merge_options(&merge_opt, the_repository);
 	memset(&result, 0, sizeof(result));
-	merge_opt.show_rename_progress = 1;
+	merge_opt.show_rename_progress = 0;
 	merge_opt.branch1 = "HEAD";
 	head_tree = repo_get_commit_tree(the_repository, onto);
 	result.tree = head_tree;
@@ -203,9 +203,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	while ((commit = get_revision(&revs))) {
 		struct commit *pick;
 
-		fprintf(stderr, "Rebasing %s...\r",
-			oid_to_hex(&commit->object.oid));
-
 		if (!commit->parents)
 			die(_("replaying down to root commit is not supported yet!"));
 		if (commit->parents->next)
@@ -224,7 +221,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		exit(128);
 
 	if (result.clean) {
-		fprintf(stderr, "\nDone.\n");
 		strbuf_addf(&reflog_msg, "finish rebase %s onto %s",
 			    oid_to_hex(&last_picked_commit->object.oid),
 			    oid_to_hex(&last_commit->object.oid));
@@ -238,7 +234,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
 	} else {
-		fprintf(stderr, "\nAborting: Hit a conflict.\n");
 		strbuf_addf(&reflog_msg, "rebase progress up to %s",
 			    oid_to_hex(&last_picked_commit->object.oid));
 		if (update_ref(reflog_msg.buf, "HEAD",
-- 
2.42.0.339.g663cbc8ab1

