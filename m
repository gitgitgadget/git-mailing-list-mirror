Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B59B1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 19:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163667AbeBOTTZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 14:19:25 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:37368 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161188AbeBOTTY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 14:19:24 -0500
Received: by mail-io0-f193.google.com with SMTP id t126so1756474iof.4
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 11:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e9utlGddVLse4oe3TuX8/XccJCV2q2OZ/PFnSQ/938A=;
        b=B5CjzSWBl9q6Ohd1LNrU4CrMHU//PfM5ZVUwL9QM5pv2mwwRQpAXVM0eurEGwvXB2H
         WeLxrIuuLd/Zxs/2IWp/7WYlPNw/eVVgpF33FfvmhyWUJ3Ys9sJk8GRiwzwJBWIgyzeZ
         rNWePtVf34dMThZS27fwvzLx0srSHkQVnIw90dpT3LL2VeDGBIrtivLlAkby68XWQIE6
         Z1C/miHJ5HKAjfLIV4qnl1elx2FLMqxbHdvqjZncB9ESiOfla9c41WNUE1RspOULabcY
         LkNlaTWUlkPC+I9P3u2agzJkrPuyk/wZP6D9Xkeom0oKHqzl0mdbeUXtHumkH2+jEGAU
         9D1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=e9utlGddVLse4oe3TuX8/XccJCV2q2OZ/PFnSQ/938A=;
        b=CeBZ6wYDYTRVxkgdBb+QE18MEbo2dMOzwId9+sWWnjJqXut9wOFuQQPknkKyAuzNZP
         Hh738y7zXOvDgkTiCqXBsdxedZnJBaDq/VgdXptXe72RKH4fSArQpLUkE3xhJjy7a90w
         IXUaRfql4IJ067dvrv3c6bszP9qUs1606+eMUX5rPHgzrOOrbfI4fkQXzLOcFfJ6WycC
         mU5LGXe0J/0K0pMaTdFwFhqhdSQjz9T3mASo/Wh0nsf28MxcdAfM7mB8pcfYfiMrHPRH
         e4skKd9IAdQa/V6SkU13P++UiSA+TA4J4KHlRH6PxnciVGZ4nfiNKjJMO6oFfp27Kb+E
         RVKQ==
X-Gm-Message-State: APf1xPA2CGQq2XKK4pmMmMVQ2agXnzI4C7m0rZ+ut1lDNLHO9ksY7wWZ
        3+WWSkZGC4K0iRJbds3bGYg++A==
X-Google-Smtp-Source: AH8x225NUHScOav/u/3XCkqBpJam+uyyHoz6d/4XNKTXOCgBAU0Kkp/Kj0nUFTAX0SZHwqBbR5JKcg==
X-Received: by 10.107.139.88 with SMTP id n85mr4971006iod.109.1518722362923;
        Thu, 15 Feb 2018 11:19:22 -0800 (PST)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id h126sm6789879ioe.5.2018.02.15.11.19.22
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 15 Feb 2018 11:19:22 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        matthew.k.gumbel@intel.com, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] worktree: add: fix 'post-checkout' not knowing new worktree location
Date:   Thu, 15 Feb 2018 14:18:41 -0500
Message-Id: <20180215191841.40848-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.16.1.370.g5c508858fb
In-Reply-To: <20180212031526.40039-1-sunshine@sunshineco.com>
References: <20180212031526.40039-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although "git worktree add" learned to run the 'post-checkout' hook in
ade546be47 (worktree: invoke post-checkout hook, 2017-12-07), it
neglected to change to the directory of the newly-created worktree
before running the hook. Instead, the hook runs within the directory
from which the "git worktree add" command itself was invoked, which
effectively neuters the hook since it knows nothing about the new
worktree directory.

Further, ade546be47 failed to sanitize the environment before running
the hook, which means that user-assigned values of GIT_DIR and
GIT_WORK_TREE could mislead the hook about the location of the new
worktree. In the case of "git worktree add" being run from a bare
repository, the GIT_DIR="." assigned by Git itself leaks into the hook's
environment and breaks Git commands; this is so even when the working
directory is correctly changed to the new worktree before the hook runs
since ".", relative to the new worktree directory, does not point at the
bare repository.

Fix these problems by (1) changing to the new worktree's directory
before running the hook, and (2) sanitizing the environment of GIT_DIR
and GIT_WORK_TREE so hooks can't be confused by misleading values.

Enhance the t2025 'post-checkout' tests to verify that the hook is
indeed run within the correct directory and that Git commands invoked by
the hook compute Git-dir and top-level worktree locations correctly.

While at it, also add two new tests: (1) verify that the hook is run
within the correct directory even when the new worktree is created from
a sibling worktree (as opposed to the main worktree); (2) verify that
the hook is provided with correct context when the new worktree is
created from a bare repository (test provided by Lars Schneider).

Implementation Notes:

Rather than sanitizing the environment of GIT_DIR and GIT_WORK_TREE, an
alternative would be to set them explicitly, as is already done for
other Git commands run internally by "git worktree add". This patch opts
instead to sanitize the environment in order to clearly document that
the worktree is fully functional by the time the hook is run, thus does
not require special environmental overrides.

The hook is run manually, rather than via run_hook_le(), since it needs
to change the working directory to that of the worktree, and
run_hook_le() does not provide such functionality. As this is a one-off
case, adding 'run_hook' overloads which allow the directory to be set
does not seem warranted at this time.

Reported-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This is a re-roll of [1] which fixes "git worktree add" to provide
proper context to the 'post-checkout' hook so that the hook knows the
location of the newly-created worktree. Thanks to Junio for his review
comments and to Lars for pointing out bare repository failure and for
providing a test case.

Changes since v1:

* Sanitize environment so user-assigned GIT_DIR and GIT_WORK_TREE don't
  confuse hook. (Junio)

* Fix failure of Git commands run by hook when "git worktree add" is
  invoked from within a bare repository. (Lars)

* Run hook manually in builtin/worktree.c rather than adding new
  'run_hook' overloads to 'run-command' which allow the directory to be
  set. This one-off case doesn't warrant adding 'run_hook' overloads at
  this time.

No interdiff since almost everything changed.

[1]: https://public-inbox.org/git/20180212031526.40039-1-sunshine@sunshineco.com/

builtin/worktree.c      | 20 ++++++++++++---
 t/t2025-worktree-add.sh | 54 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7cef5b120b..604a0292b0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -345,9 +345,23 @@ static int add_worktree(const char *path, const char *refname,
 	 * Hook failure does not warrant worktree deletion, so run hook after
 	 * is_junk is cleared, but do return appropriate code when hook fails.
 	 */
-	if (!ret && opts->checkout)
-		ret = run_hook_le(NULL, "post-checkout", oid_to_hex(&null_oid),
-				  oid_to_hex(&commit->object.oid), "1", NULL);
+	if (!ret && opts->checkout) {
+		const char *hook = find_hook("post-checkout");
+		if (hook) {
+			const char *env[] = { "GIT_DIR", "GIT_WORK_TREE" };
+			cp.git_cmd = 0;
+			cp.no_stdin = 1;
+			cp.stdout_to_stderr = 1;
+			cp.dir = path;
+			cp.env = env;
+			cp.argv = NULL;
+			argv_array_pushl(&cp.args, absolute_path(hook),
+					 oid_to_hex(&null_oid),
+					 oid_to_hex(&commit->object.oid),
+					 "1", NULL);
+			ret = run_command(&cp);
+		}
+	}
 
 	argv_array_clear(&child_env);
 	strbuf_release(&sb);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 2b95944973..d0d2e4f7ec 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -451,32 +451,68 @@ test_expect_success 'git worktree --no-guess-remote option overrides config' '
 '
 
 post_checkout_hook () {
-	test_when_finished "rm -f .git/hooks/post-checkout" &&
-	mkdir -p .git/hooks &&
-	write_script .git/hooks/post-checkout <<-\EOF
-	echo $* >hook.actual
+	gitdir=${1:-.git}
+	test_when_finished "rm -f $gitdir/hooks/post-checkout" &&
+	mkdir -p $gitdir/hooks &&
+	write_script $gitdir/hooks/post-checkout <<-\EOF
+	{
+		echo $*
+		git rev-parse --git-dir --show-toplevel
+	} >hook.actual
 	EOF
 }
 
 test_expect_success '"add" invokes post-checkout hook (branch)' '
 	post_checkout_hook &&
-	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
+	{
+		echo $_z40 $(git rev-parse HEAD) 1 &&
+		echo $(pwd)/.git/worktrees/gumby &&
+		echo $(pwd)/gumby
+	} >hook.expect &&
 	git worktree add gumby &&
-	test_cmp hook.expect hook.actual
+	test_cmp hook.expect gumby/hook.actual
 '
 
 test_expect_success '"add" invokes post-checkout hook (detached)' '
 	post_checkout_hook &&
-	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
+	{
+		echo $_z40 $(git rev-parse HEAD) 1 &&
+		echo $(pwd)/.git/worktrees/grumpy &&
+		echo $(pwd)/grumpy
+	} >hook.expect &&
 	git worktree add --detach grumpy &&
-	test_cmp hook.expect hook.actual
+	test_cmp hook.expect grumpy/hook.actual
 '
 
 test_expect_success '"add --no-checkout" suppresses post-checkout hook' '
 	post_checkout_hook &&
 	rm -f hook.actual &&
 	git worktree add --no-checkout gloopy &&
-	test_path_is_missing hook.actual
+	test_path_is_missing gloopy/hook.actual
+'
+
+test_expect_success '"add" in other worktree invokes post-checkout hook' '
+	post_checkout_hook &&
+	{
+		echo $_z40 $(git rev-parse HEAD) 1 &&
+		echo $(pwd)/.git/worktrees/guppy &&
+		echo $(pwd)/guppy
+	} >hook.expect &&
+	git -C gloopy worktree add --detach ../guppy &&
+	test_cmp hook.expect guppy/hook.actual
+'
+
+test_expect_success '"add" in bare repo invokes post-checkout hook' '
+	rm -rf bare &&
+	git clone --bare . bare &&
+	{
+		echo $_z40 $(git --git-dir=bare rev-parse HEAD) 1 &&
+		echo $(pwd)/bare/worktrees/goozy &&
+		echo $(pwd)/goozy
+	} >hook.expect &&
+	post_checkout_hook bare &&
+	git -C bare worktree add --detach ../goozy &&
+	test_cmp hook.expect goozy/hook.actual
 '
 
 test_done
-- 
2.16.1.370.g5c508858fb
