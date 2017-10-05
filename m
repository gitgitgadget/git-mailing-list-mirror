Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C0C20370
	for <e@80x24.org>; Thu,  5 Oct 2017 20:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbdJEUct (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:32:49 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33801 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdJEUcs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:32:48 -0400
Received: by mail-wr0-f194.google.com with SMTP id z1so10226762wre.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1vKBr9XmW1+5CUUXsPY05mvMIUWXayXNKN8W026oywg=;
        b=JdhlekZOJCUbf0GDx9C2xL+rYLsQs5LZ+wNw4BAuJ3CGq33ijdLdTAigk+ZHyhxAm3
         b4cowOhGRQdx7LiSfzcZVbuF+aNJbgQnj+Kr0P1TxYl63+e+o+H/kLBhsucaRI8U3+gA
         tNwBeQro1J2iwt1dtPgCxjhKAukSTPH/Xa6rantvye98Ydu+qLHhgxCrBuRkCpLXu8z8
         3ndJRyKyogV5CbksM0Jg99boVc83F9GZ0TSN05rAFDtGNyhvfAZ+c96n1uLWQfd7CRYB
         hlNu+I7jzNPuKwkSMqUOtF08CzqJMh8HmjZylmWs7hHTnSujU9eUdRzfv6rrPfmqVBck
         H1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vKBr9XmW1+5CUUXsPY05mvMIUWXayXNKN8W026oywg=;
        b=NiDZnP4lZOmh22RQuN6eSxYSgUe7SCPoemUk5Gv/f3SzKH1HnrqtEl5Ess/15AIhys
         fua4c5pZqp/96QFTuiHcnAbVWr/6HE6MgeNK/iEgPrSTtuo29RwC8j4FCDrYV0uKT2Tc
         gdmXt1Y4m4sWgoWM546Wcws/O896DaK+Uax3ZrvFZMQ/g+llsSK8whpVpfUTKTZ/B1Ea
         bG2IUpjLeXV9Em0huThOG5V7tzbQsCJ/XHkvtTcBprgkEl8X80cnCD/kkUvqGAI0okQS
         O3U/oqqHLc1oGkHl8PVV8HVQEifOMD4RWpUq3UHHg69Yaj3JagXFrafDTumVkqOsSsCP
         9O7A==
X-Gm-Message-State: AMCzsaWThUXd6vov3LEBPia8MDQp/uPxi/RC2e7Zrs41rnvjr19R65NY
        R3A6Auxw554VQiBL3aLwolIheqSk
X-Google-Smtp-Source: AOwi7QCq5iGL+jjh7DT0pHZfqvf4hn7xjdPTgNtm5V5PwOuP7CRZaTMUSf3Mv4rbu+tUwfFnAxfDmg==
X-Received: by 10.223.130.194 with SMTP id 60mr8561430wrc.50.1507235566524;
        Thu, 05 Oct 2017 13:32:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id i76sm698424wmd.2.2017.10.05.13.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 13:32:45 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/12] cache-tree: simplify locking logic
Date:   Thu,  5 Oct 2017 22:32:08 +0200
Message-Id: <c9c03b3136a2881c393ab6a6712571dee7a498ed.1507228170.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.2.666.gea220ee40
In-Reply-To: <cover.1507228170.git.martin.agren@gmail.com>
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com> <cover.1507228170.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After we have taken the lock using `LOCK_DIE_ON_ERROR`, we know that
`newfd` is non-negative. So when we check for exactly that property
before calling `write_locked_index()`, the outcome is guaranteed.

If we write and commit successfully, we set `newfd = -1`, so that we can
later avoid calling `rollback_lock_file` on an already-committed lock.
But we might just as well unconditionally call `rollback_lock_file()` --
it will be a no-op if we have already committed.

All in all, we use `newfd` as a bool and the only benefit we get from it
is that we can avoid calling a no-op. Remove `newfd` so that we have one
variable less to reason about.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
v2: Identical.

 cache-tree.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 71d092ed5..f646f5673 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -602,11 +602,11 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 
 int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
 {
-	int entries, was_valid, newfd;
+	int entries, was_valid;
 	struct lock_file lock_file = LOCK_INIT;
 	int ret = 0;
 
-	newfd = hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
+	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
 
 	entries = read_index_from(index_state, index_path);
 	if (entries < 0) {
@@ -625,10 +625,7 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 			ret = WRITE_TREE_UNMERGED_INDEX;
 			goto out;
 		}
-		if (0 <= newfd) {
-			if (!write_locked_index(index_state, &lock_file, COMMIT_LOCK))
-				newfd = -1;
-		}
+		write_locked_index(index_state, &lock_file, COMMIT_LOCK);
 		/* Not being able to write is fine -- we are only interested
 		 * in updating the cache-tree part, and if the next caller
 		 * ends up using the old index with unupdated cache-tree part
@@ -650,8 +647,7 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 		hashcpy(sha1, index_state->cache_tree->oid.hash);
 
 out:
-	if (0 <= newfd)
-		rollback_lock_file(&lock_file);
+	rollback_lock_file(&lock_file);
 	return ret;
 }
 
-- 
2.14.2.666.gea220ee40

