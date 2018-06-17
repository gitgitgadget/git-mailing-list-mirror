Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA61D1F403
	for <e@80x24.org>; Sun, 17 Jun 2018 05:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754175AbeFQF7Q (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 01:59:16 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42861 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753691AbeFQF7J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 01:59:09 -0400
Received: by mail-oi0-f65.google.com with SMTP id k190-v6so12190262oib.9
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 22:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g6GDAXOOBV49MXIayrjvJFCuCpDpEyoI833/Csn/H90=;
        b=obI/YtnXSZFcBvMr9nN/9JHyGuh86ZJywklc2N8GG8wDc4hZQpicX5VRx4eZbwemm8
         HEbtGX4fkl+TlNZbPfpiOL5CzwVUZdJ2ifgdRNK5m6PiQgjnnqd0/WNLxqxqzIUufM91
         VvxCH/xIQYO1ek9eiYNHnpbdzKAkiZXTPLd1YJ85qgz2nPOhkPa4o3T0ChMV+5YxSXsq
         QkAtWSGBkGxkxWblHkV92Cvz8qBpi4OVvMnDpHFQ/Ks1Z2sG/tq8p1VXnhOpC5W/Am2F
         wXs2WAD3GUe4SASSVYu0r9z9nWdnIsO9JKfVVkgN7Z1Jc5oTfoyO3hoM3nr5mFJQxmyL
         NeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g6GDAXOOBV49MXIayrjvJFCuCpDpEyoI833/Csn/H90=;
        b=g8Hq/b0Is6TCwSDsGJ1Ng0pYJqgrJ1RK4SpviFhHJhzvYoPgGkzpvyg7sLszH9Uax2
         fgZQcElJat/s+3Knr3yD+qeyF6PDpJ4KkJRwgWvXYP0kNr2n64Gq3n3nNsfjKvloiaEQ
         q41nq4amrm4z/qKxziWrrNC7QWYWTwyizzP93T27k9ipl9TPf9TUjONDdWNmmP5V7wXv
         h+pewdjvl6Cs7JUv+qr5WuV6kva9hEPplrT/3hhUm1w3lhBCmh+1AVzYzT+V0kEQhCB5
         zkXddq1L8X2Ji8+I459lSTuHNaX99RTvuFpOwIfM+HUJmgS/2W0+LyfS+53AIOal2X6D
         X+qA==
X-Gm-Message-State: APt69E1a9Zrfrvp/lopaJhw7UeSw9tuJUfEzoKN67Y4x3TjwJTyDViVL
        si5XZ4NCNQoRXdE0sbzuaqnL1Q==
X-Google-Smtp-Source: ADUXVKISXUVyuWC2FIpNpOqWtzqr6Bh4JGCp3SGw+c7v5CHJpF9CQMNfpMGr7s3LLaoe/cRz8rCabg==
X-Received: by 2002:aca:907:: with SMTP id 7-v6mr4615187oij.300.1529215148236;
        Sat, 16 Jun 2018 22:59:08 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id h12-v6sm5366091oti.4.2018.06.16.22.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 22:59:07 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Cc:     johannes.schindelin@gmx.de, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 4/7] git-rebase: error out when incompatible options passed
Date:   Sat, 16 Jun 2018 22:58:53 -0700
Message-Id: <20180617055856.22838-5-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.7.gab8805c40a
In-Reply-To: <20180617055856.22838-1-newren@gmail.com>
References: <20180607050654.19663-1-newren@gmail.com>
 <20180617055856.22838-1-newren@gmail.com>
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
 git-rebase.sh                          | 17 +++++++++++++++++
 t/t3422-rebase-incompatible-options.sh | 10 +++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index bf71b7fa20..5f891214fa 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -503,6 +503,23 @@ then
 	git_format_patch_opt="$git_format_patch_opt --progress"
 fi
 
+if test -n "$git_am_opt"; then
+	incompatible_opts=$(echo "$git_am_opt" | sed -e 's/ -q//')
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
2.18.0.rc2.1.g5453d3f70b.dirty

