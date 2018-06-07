Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D59E51F403
	for <e@80x24.org>; Thu,  7 Jun 2018 05:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbeFGFHF (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:07:05 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35080 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbeFGFHD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:07:03 -0400
Received: by mail-oi0-f68.google.com with SMTP id e8-v6so7436090oii.2
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 22:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YSF86hme4A6QMS0K6GQ70VQu0UtwDfe+3zo9i0t+aQ4=;
        b=qO9O026V8sH2/bhq20qtOvlLM8GUGvT7HU9aUI9HrB6XYdCl0+rAAIQdm16qIkJUZK
         kIyAgcyFo9u+yrO2rSvVVVlU9GO2DkYw0Va1mCVnomDlBofPtXZkG59ZRJjwXYegvk8h
         izuQNwYb34caoMakEGmVqIXasdOVNIdqzxOo+G+YG9uhvipuzMhyASX1VgjJBLd3IAN6
         sxf6nINYOcqj2Hh4S+jlzR08HGmWVZsKV/V6UxbXgSmKWlkiIbscXAola8mvOKH86lQQ
         5VARY6UBEu7B9kW6eSX/w+sJO4F/uEcTYS+HAGIASLTQzm+Cs8afm1haw2AKx4FpsMOI
         9KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YSF86hme4A6QMS0K6GQ70VQu0UtwDfe+3zo9i0t+aQ4=;
        b=H068Y+gA0XVhJQN9o8owNaN5033tunWHUSAW5n7u+gPZQOVdAC55KeT0Qku5y09ayR
         j41Qhnbc77zs0xmEpU14ZJqZuS9VeYQWPwtwho8iBDjuFA3E/uObTtwYZm1WRY5QRxSv
         KJ4Y5Ekst3A70Vr6Tf0JDO2bKlO/JOjJ0arqZEBAxeQCZFjtoBezaZItpEnEmnn7uO7V
         tHXJJ9l7YKlUSPDNzL+bUgfJ/nXqEcPBrEo1aCrbaz7kfmuIsClek7MCTgSTwYMVU3ZJ
         nTsrk6xwfTq5Iy34emr1kI/KDISxCzBIrduGEfG+yxjTPqH4Ga79g5xS1RTJ2Xsw6kr2
         CoUQ==
X-Gm-Message-State: APt69E0w/eyp3grF50UobAvnzIVI5dEuwnoZb5cP68i8MZY3kl1nD4O9
        2ILUTASGlrIU3wzFnUwZv+EgLw==
X-Google-Smtp-Source: ADUXVKJ6tgHoQsL8fN/k/EKSTPN5pIB/p8OjftktoTrxDd5nVbzZ5Y8zjQXcT2kLIEqH2dOkP63zVA==
X-Received: by 2002:aca:a88b:: with SMTP id r133-v6mr163372oie.213.1528348021779;
        Wed, 06 Jun 2018 22:07:01 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id v141-v6sm13002019oie.34.2018.06.06.22.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:07:01 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/2] git-rebase: error out when incompatible options passed
Date:   Wed,  6 Jun 2018 22:06:54 -0700
Message-Id: <20180607050654.19663-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.46.g9cee8fce43
In-Reply-To: <20180607050654.19663-1-newren@gmail.com>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607050654.19663-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git rebase has three different types: am, merge, and interactive, all of
which are implemented in terms of separate scripts.  am builds on git-am,
merge builds on git-merge-recursive, and interactive builds on
git-cherry-pick.  We make use of features in those lower-level commands in
the different rebase types, but those features don't exist in all of the
lower level commands so we have a range of incompatibilities.  Previously,
we just accepted nearly any argument and silently ignored whichever ones
weren't implemented for the type of rebase specified.  Change this so the
incompatibilities are documented, included in the testsuite, and tested
for at runtime with an appropriate error message shown.

Some exceptions I left out:

  * --merge and --interactive are technically incompatible since they are
    supposed to run different underlying scripts, but with a few small
    changes, --interactive can do everything that --merge can.  In fact,
    I'll shortly be sending another patch to remove git-rebase--merge and
    reimplement it on top of git-rebase--interactive.

  * One could argue that --interactive and --quiet are incompatible since
    --interactive doesn't implement a --quiet mode (perhaps since
    cherry-pick itself does not implement one).  However, the interactive
    mode is more quiet than the other modes in general with progress
    messages, so one could argue that it's already quiet.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt           | 15 +++++++++++++--
 git-rebase.sh                          | 17 +++++++++++++++++
 t/t3422-rebase-incompatible-options.sh | 10 +++++-----
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0e20a66e73..451252c173 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -243,6 +243,10 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 --keep-empty::
 	Keep the commits that do not change anything from its
 	parents in the result.
++
+This uses the `--interactive` machinery internally, and as such,
+anything that is incompatible with --interactive is incompatible
+with this option.
 
 --allow-empty-message::
 	By default, rebasing commits with an empty message will fail.
@@ -324,6 +328,8 @@ which makes little sense.
 	and after each change.  When fewer lines of surrounding
 	context exist they all must match.  By default no context is
 	ever ignored.
+	Incompatible with the --merge and --interactive options, or
+	anything that implies those options or their machinery.
 
 -f::
 --force-rebase::
@@ -355,13 +361,15 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
 --whitespace=<option>::
 	These flag are passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
-	Incompatible with the --interactive option.
+	Incompatible with the --merge and --interactive options, or
+	anything that implies those options or their machinery.
 
 --committer-date-is-author-date::
 --ignore-date::
 	These flags are passed to 'git am' to easily change the dates
 	of the rebased commits (see linkgit:git-am[1]).
-	Incompatible with the --interactive option.
+	Incompatible with the --merge and --interactive options, or
+	anything that implies those options or their machinery.
 
 --signoff::
 	Add a Signed-off-by: trailer to all the rebased commits. Note
@@ -400,6 +408,9 @@ The `--rebase-merges` mode is similar in spirit to `--preserve-merges`, but
 in contrast to that option works well in interactive rebases: commits can be
 reordered, inserted and dropped at will.
 +
+This uses the `--interactive` machinery internally, but it can be run
+without an explicit `--interactive`.
++
 It is currently only possible to recreate the merge commits using the
 `recursive` merge strategy; Different merge strategies can be used only via
 explicit `exec git merge -s <strategy> [...]` commands.
diff --git a/git-rebase.sh b/git-rebase.sh
index 40be59ecc4..f1dbecba18 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -503,6 +503,23 @@ then
 	git_format_patch_opt="$git_format_patch_opt --progress"
 fi
 
+if test -n "$git_am_opt"; then
+	incompatible_opts=`echo "$git_am_opt" | sed -e 's/ -q//'`
+	if test -n "$interactive_rebase"
+	then
+		if test -n "$incompatible_opts"
+		then
+			die "$(gettext "error: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
+		fi
+	fi
+	if test -n "$do_merge"; then
+		if test -n "$incompatible_opts"
+		then
+			die "$(gettext "error: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
+		fi
+	fi
+fi
+
 if test -n "$signoff"
 then
 	test -n "$preserve_merges" &&
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 04cdae921b..66a83363bf 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -34,27 +34,27 @@ test_expect_success 'setup' '
 test_run_rebase () {
 	opt=$1
 	shift
-	test_expect_failure "$opt incompatible with --merge" "
+	test_expect_success "$opt incompatible with --merge" "
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --merge A
 	"
 
-	test_expect_failure "$opt incompatible with --strategy=ours" "
+	test_expect_success "$opt incompatible with --strategy=ours" "
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --strategy=ours A
 	"
 
-	test_expect_failure "$opt incompatible with --strategy-option=ours" "
+	test_expect_success "$opt incompatible with --strategy-option=ours" "
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --strategy=ours A
 	"
 
-	test_expect_failure "$opt incompatible with --interactive" "
+	test_expect_success "$opt incompatible with --interactive" "
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --interactive A
 	"
 
-	test_expect_failure "$opt incompatible with --exec" "
+	test_expect_success "$opt incompatible with --exec" "
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --exec 'true' A
 	"
-- 
2.18.0.rc0.46.g9cee8fce43

