Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEF541F404
	for <e@80x24.org>; Mon, 12 Feb 2018 03:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932568AbeBLDRI (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 22:17:08 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:51775 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932492AbeBLDRF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 22:17:05 -0500
Received: by mail-it0-f67.google.com with SMTP id 193so2194124iti.1
        for <git@vger.kernel.org>; Sun, 11 Feb 2018 19:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=USiqYzAN2Sn2049nK/nyEZ4a5g0FeopKNsR+4Jieh7w=;
        b=N/2k9RLrzrVtPtXYQeNYUtR1de+izkq2s/x0D3oSw/kXekVYZN6TUt2A9F/6C1pRq0
         r/gYoO6xWLxtNwDkGNzi4Yy59pQqGwsFg8L38KvdEpKmZgLdeLPohnqln6sfGL04cN/6
         ltSx4S/ZRsMDF5taOZ/T3qH230zODvgPbRTLkzAWvsE+1PecnmAm/QmKOYMN+k91V7g8
         14iAFIAuhOMZ/Pok3NMmcD9Gves6wQKBC0h3PaPdNPzfzraVJyXp/YQD8ASRwHqMquvY
         NEW6oUmtJbajI9StzRNiXvivhRKaGPjCQU8Ch/ryDQLqU/5OSBFbISXb/OWmQZOeeVN6
         iohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=USiqYzAN2Sn2049nK/nyEZ4a5g0FeopKNsR+4Jieh7w=;
        b=ljOIsk3yv6Qij3RqrFCVKov1kuITzn8WHmCqdKQS/snw0uDROExHRXUt37vY8+1vqc
         MtMKKwN1goUmPdga9gJ7LtCqiS9rsrK0SsDuqPibJbZob0qIUKb4mJZay1+gGsfg9TtG
         8ytJ3Q0tHT0u5pCOssOwQdyVcLxhuFlY3Z4DItMewZ1eNL1MolUUzX/P1lV+d45Vl58z
         0UxHR4z5vIVPxFJUEHTvC4dQWj/hw+ORzbTzcGAsQsKoexJJXNtdtutj2NfNw7SMRCGF
         IuZ4vcfoQh2tup+pqsLqfoXP4zfP9si56fHRRMvevaar9jOh5PcvX1JNL4zsMXuwKRTe
         JH8w==
X-Gm-Message-State: APf1xPA60XENL/0RMJzWAkVdOMEfPluVIgElfAcSIGpAoUJ9uE1OOJ6v
        97KnSXDnmh4jJXBdqoyzJgxTxw==
X-Google-Smtp-Source: AH8x225xa1PtMsmU7kTKIhZjNQRLuDCU4WKQqZt4Z41gU5QPiGnYdSv0a6GnvCX/3KiFSewdc++ChQ==
X-Received: by 10.36.98.135 with SMTP id d129mr3799319itc.126.1518405424929;
        Sun, 11 Feb 2018 19:17:04 -0800 (PST)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id 15sm1754139itx.18.2018.02.11.19.17.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 11 Feb 2018 19:17:04 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        matthew.k.gumbel@intel.com, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] worktree: add: change to new worktree directory before running hook
Date:   Sun, 11 Feb 2018 22:15:26 -0500
Message-Id: <20180212031526.40039-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180212031526.40039-1-sunshine@sunshineco.com>
References: <20180210010132.33629-1-lars.schneider@autodesk.com>
 <20180212031526.40039-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although "git worktree add" learned to run the 'post-checkout' hook in
ade546be47 (worktree: invoke post-checkout hook, 2017-12-07), it
neglects to change to the directory of the newly-created worktree
before running the hook. Instead, the hook is run within the directory
from which the "git worktree add" command itself was invoked, which
effectively neuters the hook since it knows nothing about the new
worktree directory.

Fix this by changing to the new worktree's directory before running
the hook, and adjust the tests to verify that the hook is indeed run
within the correct directory.

While at it, also add a test to verify that the hook is run within the
correct directory even when the new worktree is created from a sibling
worktree (as opposed to the main worktree).

Reported-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c      | 11 ++++++++---
 t/t2025-worktree-add.sh | 25 ++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7cef5b120b..b55c55a26c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -345,9 +345,14 @@ static int add_worktree(const char *path, const char *refname,
 	 * Hook failure does not warrant worktree deletion, so run hook after
 	 * is_junk is cleared, but do return appropriate code when hook fails.
 	 */
-	if (!ret && opts->checkout)
-		ret = run_hook_le(NULL, "post-checkout", oid_to_hex(&null_oid),
-				  oid_to_hex(&commit->object.oid), "1", NULL);
+	if (!ret && opts->checkout) {
+		char *p = absolute_pathdup(path);
+		ret = run_hook_cd_le(p, NULL, "post-checkout",
+				     oid_to_hex(&null_oid),
+				     oid_to_hex(&commit->object.oid),
+				     "1", NULL);
+		free(p);
+	}
 
 	argv_array_clear(&child_env);
 	strbuf_release(&sb);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 2b95944973..cf0aaeaf88 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -454,20 +454,29 @@ post_checkout_hook () {
 	test_when_finished "rm -f .git/hooks/post-checkout" &&
 	mkdir -p .git/hooks &&
 	write_script .git/hooks/post-checkout <<-\EOF
-	echo $* >hook.actual
+	{
+		echo $*
+		git rev-parse --show-toplevel
+	} >../hook.actual
 	EOF
 }
 
 test_expect_success '"add" invokes post-checkout hook (branch)' '
 	post_checkout_hook &&
-	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
+	{
+		echo $_z40 $(git rev-parse HEAD) 1 &&
+		echo $(pwd)/gumby
+	} >hook.expect &&
 	git worktree add gumby &&
 	test_cmp hook.expect hook.actual
 '
 
 test_expect_success '"add" invokes post-checkout hook (detached)' '
 	post_checkout_hook &&
-	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
+	{
+		echo $_z40 $(git rev-parse HEAD) 1 &&
+		echo $(pwd)/grumpy
+	} >hook.expect &&
 	git worktree add --detach grumpy &&
 	test_cmp hook.expect hook.actual
 '
@@ -479,4 +488,14 @@ test_expect_success '"add --no-checkout" suppresses post-checkout hook' '
 	test_path_is_missing hook.actual
 '
 
+test_expect_success '"add" within worktree invokes post-checkout hook' '
+	post_checkout_hook &&
+	{
+		echo $_z40 $(git rev-parse HEAD) 1 &&
+		echo $(pwd)/guppy
+	} >hook.expect &&
+	git -C gloopy worktree add --detach ../guppy &&
+	test_cmp hook.expect hook.actual
+'
+
 test_done
-- 
2.16.1.291.g4437f3f132

