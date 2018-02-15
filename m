Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 824251F404
	for <e@80x24.org>; Thu, 15 Feb 2018 23:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756568AbeBOXKO (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 18:10:14 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:39132 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756565AbeBOXKN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 18:10:13 -0500
Received: by mail-io0-f193.google.com with SMTP id b198so2423442iof.6
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 15:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5mZ1AOuJ+NgsNlf1mFUl7TAzUdyAg+QiVDjtcM9xRp4=;
        b=mrxdwdOh7Ldztlq5+YeagS5VF4cLDtO+sqLF74Viyqb/HHW6EaY3a26kinN2n7oKEV
         zWLGokpbRNUjsuJFW+RYfu1dcNCrJqRblq+56tc15j16o67rAvx3raRXbxl0eOk/R/F1
         O2ygqtRlrWzgVr10lyUSsk0SDA14Pl3+oMOs0yXvCt0NRmYvZXAhukpTNIA2swIrhtO5
         rJmg1QGMWjNPq6NUibXCoAhwzuKIb5RYQnHsHCg2A8zAhrTTdK/fYtxQEp9mpA2lAoti
         n8pZIzP49HxM/8jKl0paqfKB4nsPwTckpaCqutm6DinBohYaQR1N9fbV2aKO6YdVGa8F
         r/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=5mZ1AOuJ+NgsNlf1mFUl7TAzUdyAg+QiVDjtcM9xRp4=;
        b=rhg3UJMskA2C4CT1HkySNwQulRqZjb2dv8iX3OhX4Damzr2h+lR+YyhRlcDzwkd7K0
         eW0alE8MbjguOvBlj6+6UK/kcr2sea4XKM4CFMgNYyf0GW9NDuVXrJXTvwXcjsC9agqO
         pvmKKN1z19RmsCfqRIy3TcTsNwLm95uwlgVK5XhdYbTJf6SseGluZtky+fh18XBN15j7
         6SvabH4wH3OfWiLSKQ3S1cIRdjFvwuBlfC8aFdht9MnEsumO7KWWh7sLBOfpQcjDsywx
         XzI91Qarxlt2VeCb98XO2K37xYV2Wld3bBYgXRd4l8hyKWC3n6nuJ92SYDFOeID3lOSv
         Nu1A==
X-Gm-Message-State: APf1xPBdABA2xmGTtblg0wPsmHMXpRNdPsVKp7XhDSQ6ZPT/UtzSWuL3
        speJik8yYIHXuL6TJMWfbV7u3w==
X-Google-Smtp-Source: AH8x224eE2Tr3GuShYMGlydUOXQBQw7ZuuOIcMiG6FqtqdhTj9B3RLwvt2jpuaPD8QY8tkUciX2lhQ==
X-Received: by 10.107.13.143 with SMTP id 137mr5591377ion.265.1518736211335;
        Thu, 15 Feb 2018 15:10:11 -0800 (PST)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id h2sm1058590ioa.77.2018.02.15.15.10.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 15 Feb 2018 15:10:10 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        matthew.k.gumbel@intel.com, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3] worktree: add: fix 'post-checkout' not knowing new worktree location
Date:   Thu, 15 Feb 2018 18:09:52 -0500
Message-Id: <20180215230952.51887-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.16.1.370.g5c508858fb
In-Reply-To: <20180215191841.40848-1-sunshine@sunshineco.com>
References: <20180215191841.40848-1-sunshine@sunshineco.com>
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
location of the newly-created worktree.

Changes since v2:

* Fix crash due to missing NULL-terminator on 'env' list passed to
  run_command().

[1]: https://public-inbox.org/git/20180215191841.40848-1-sunshine@sunshineco.com/

builtin/worktree.c      | 20 ++++++++++++---
 t/t2025-worktree-add.sh | 54 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7cef5b120b..f69f862947 100644
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
+			const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
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

