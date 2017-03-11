Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B906201C2
	for <e@80x24.org>; Sat, 11 Mar 2017 12:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755424AbdCKMJI (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 07:09:08 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35114 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbdCKMJG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 07:09:06 -0500
Received: by mail-wm0-f65.google.com with SMTP id z63so2789322wmg.2
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 04:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bG9e9Wj0s/czsFXbTAm6vs3to2uGhcUvy4Op4WN0Opo=;
        b=ast6XldgwBKAoeSX6Y7e7GBg907DXKSP1Te5lI8Yf/mJPkVjihEeZIg9aJNlbRetMs
         /DemPJa4KaLCC+47UBwF8mGgl+Vm731ZLmyuQtvqSJxcKzvUUazWZDHSv0lpxL3YeWGt
         Txl+ubZIGgZgagYEqUjIhvOMaFGAuSb52VjTvNRKN/aPEtfBP9+xvjavzBMXOyYHYm0c
         lfOt8t9ciuVCZO967axdofSIZ0M09E7rmYZ+Z/3y1NtKbcVdXxB58dpIK7nLWoFsTGgR
         PE1AplteF0M36Ya23TMbZCET/wvfdEnpPbhb5+2mp3BspojquQSBo/oLrU/ZFV8UGfU3
         ktpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bG9e9Wj0s/czsFXbTAm6vs3to2uGhcUvy4Op4WN0Opo=;
        b=BCmA2ZQERPKcMZ/1EUDY4JqX8AxouhAaAqJl6lAmkaUXQ/yti8nGtVfj0YLo/wXIAw
         XECqFqrUYjYO/402prEiwZjJklNTkniUyIg0UrPngDUa9ac2HMKO8xDYfkU1pSVu/FL5
         moiH5aiMFLptRqDy1qjjqqGR1YAp5Uhz9JgIiMiJIohq53CH/xHMmSedq61RSHWc3YxA
         LlHEBb+3+a08bumx8tUHrStVuOK1PwVc47SyLCT55J0fcnoM4zZJJbaaQf1hPkB8RidX
         DjwvhZTrIl5rGGhDR2eABxdRU75r6GntrZ2CxJSiKCESqMJowBdDcOOLtbA+wTla377V
         6wTA==
X-Gm-Message-State: AFeK/H2PKMYMzo4vgBk9RpuW7wxGBntjrZm+7eanN96LQw0nDwxRCGspuCpLsF+v4QHyzg==
X-Received: by 10.28.11.205 with SMTP id 196mr2673121wml.31.1489234143931;
        Sat, 11 Mar 2017 04:09:03 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s18sm3426976wmb.18.2017.03.11.04.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Mar 2017 04:09:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jake Goulding <goulding@vivisimo.com>,
        Jeff King <peff@peff.net>, Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] tag: Implicitly supply --list given another list-like option
Date:   Sat, 11 Mar 2017 12:08:55 +0000
Message-Id: <20170311120855.16756-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170310124247.jvrmmcz2pbv4qf3o@sigill.intra.peff.net>
References: <20170310124247.jvrmmcz2pbv4qf3o@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change these invocations which currently error out without the -l, to
behave as if though -l was provided:

    git tag -l [--contains|--points-at|--[no-]merged] <commit>

I ran into what turned out to be not-a-bug in "branch" where it,
unlike "tag" before this patch, accepts input like:

    git branch --contains v2.8.0 <pattern>

Jeff King pointed out in
<20170310124247.jvrmmcz2pbv4qf3o@sigill.intra.peff.net> in reply to
that::

    The difference between "branch" and "tag" here is that "branch
    --contains" implies "--list" (and the argument becomes a pattern).
    Whereas "tag --contains" just detects the situation and complains.

    If anything, I'd think we would consider teaching "tag" to behave
    more like "branch".

I agree. This change does that, the only tests that broke as a result
of this were tests that were explicitly checking that this
"branch-like" usage wasn't permitted, i.e. no actual breakages
occurred, and I can't imagine an invocation that would negatively
impact backwards compatibility, i.e. these invocations all just
errored out before.

Spelunking through the history via:

    git log --reverse -p -G'only allowed with' -- '*builtin*tag*c'

Reveals that there was no good reason for this in the first place. The
--contains option added in v1.6.1.1-243-g32c35cfb1e made this an
error, and all the other subsequent options I'm changing here just
copy/pasted its pattern.

I've changed the failing tests to check that this invocation mode is
permitted instead, and added extra tests for the list-like options we
weren't testing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Junio: This will merge conflict with my in-flight --no-contains
patch. I can re-send either one depending on which you want to accept
first, this patch will need an additional test for --no-contains. I
just wanted to get this on the ML for review before the --no-contains
patch hit "master".

 Documentation/git-tag.txt |  3 +++
 builtin/tag.c             | 12 ++++++------
 t/t7004-tag.sh            | 25 +++++++++++++++++++++----
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 525737a5d8..c80d9e11ba 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -94,6 +94,9 @@ OPTIONS
 	lists all tags. The pattern is a shell wildcard (i.e., matched
 	using fnmatch(3)).  Multiple patterns may be given; if any of
 	them matches, the tag is shown.
++
+We supply this option implicitly if any other list-like option is
+provided. E.g. `--contains`, `--points-at` etc.
 
 --sort=<key>::
 	Sort based on the key given.  Prefix `-` to sort in
diff --git a/builtin/tag.c b/builtin/tag.c
index ad29be6923..6ab65bcf6b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -454,6 +454,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 	create_tag_object = (opt.sign || annotate || msg.given || msgfile);
 
+	/* We implicitly supply --list with --contains, --points-at,
+	   --merged and --no-merged, just like git-branch */
+	if (filter.with_commit || filter.points_at.nr || filter.merge_commit)
+		cmdmode = 'l';
+
+	/* Just plain "git tag" is like "git tag --list" */
 	if (argc == 0 && !cmdmode)
 		cmdmode = 'l';
 
@@ -486,12 +492,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 	if (filter.lines != -1)
 		die(_("-n option is only allowed with -l."));
-	if (filter.with_commit)
-		die(_("--contains option is only allowed with -l."));
-	if (filter.points_at.nr)
-		die(_("--points-at option is only allowed with -l."));
-	if (filter.merge_commit)
-		die(_("--merged and --no-merged option are only allowed with -l"));
 	if (cmdmode == 'd')
 		return for_each_tag_name(argv, delete_tag, NULL);
 	if (cmdmode == 'v') {
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b4698ab5f5..e0306ee5a8 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1453,6 +1453,11 @@ test_expect_success 'checking that initial commit is in all tags' "
 	test_cmp expected actual
 "
 
+test_expect_success 'checking that --contains can be used in non-list mode' '
+	git tag --contains $hash1 v* >actual &&
+	test_cmp expected actual
+'
+
 # mixing modes and options:
 
 test_expect_success 'mixing incompatibles modes and options is forbidden' '
@@ -1466,8 +1471,10 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 
 # check points-at
 
-test_expect_success '--points-at cannot be used in non-list mode' '
-	test_must_fail git tag --points-at=v4.0 foo
+test_expect_success '--points-at can be used in non-list mode' '
+	echo v4.0 >expect &&
+	git tag --points-at=v4.0 "v*" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '--points-at finds lightweight tags' '
@@ -1744,8 +1751,13 @@ test_expect_success 'setup --merged test tags' '
 	git tag mergetest-3 HEAD
 '
 
-test_expect_success '--merged cannot be used in non-list mode' '
-	test_must_fail git tag --merged=mergetest-2 foo
+test_expect_success '--merged can be used in non-list mode' '
+	cat >expect <<-\EOF &&
+	mergetest-1
+	mergetest-2
+	EOF
+	git tag --merged=mergetest-2 "mergetest*" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '--merged shows merged tags' '
@@ -1765,6 +1777,11 @@ test_expect_success '--no-merged show unmerged tags' '
 	test_cmp expect actual
 '
 
+test_expect_success '--no-merged can be used in non-list mode' '
+	git tag --no-merged=mergetest-2 mergetest-* >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'ambiguous branch/tags not marked' '
 	git tag ambiguous &&
 	git branch ambiguous &&
-- 
2.11.0

