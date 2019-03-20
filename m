Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA66420248
	for <e@80x24.org>; Wed, 20 Mar 2019 03:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfCTDzC (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 23:55:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36188 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfCTDzC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 23:55:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id v10so983425lji.3
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 20:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=5kzIzTrLpgKMb0/tEIQ5ktUwIqxILe7pOXi8LS1YKVc=;
        b=V14kVQxIythpq/1JfQjCx2tcdHCWpr832t4Pxz8gcIKDmkdsnHGd50B0E0FGV/fUuC
         4dfTfBszJTzmgMzIAzzMQ0Y1BChyTyhk6ZtSd4ezHySwh9egZIRr4bFOeggqxWL5EXFV
         IM66hli868X24DYvKAFm3I/wrODR/2UqSQq7ZcUD8kGds9lOvNCsr5UB94v4dM9s8uU+
         zk0qQcnvZPOfrm+91FoSOVPc1rGOW3qDiDPOAtXEx1CQvpVempyp94CUyvpWxZ0xfZL/
         3qoDUkrTyUwXFGPjHHdgFLeaxgGdEmZt4ccd2k9rrBy1Wyf0lRBhx6CxR4JkvNL1yOy2
         ++/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5kzIzTrLpgKMb0/tEIQ5ktUwIqxILe7pOXi8LS1YKVc=;
        b=M9QynV/fw8JFNWP8UobZSg/zSQlfv3dC8DUsPvlP1zHyRRtT6V/LvpoXV4SFT791HO
         1iwY58laNrWgtNYRKo9xVs4KfFNMibDPBDqLG5iHi9Mu17hHS54Yb734yCBejipyuZs4
         lGy4XPIxomOmQ78yxnnOfv90WwV/Up4o1fKDMbRip0pqx5+ugotAuOoBev92LF0pz48f
         Ae8WxsO2odTQd8SzwPY3xoAmq3QHDkxuJf5dXTRljkOcUjoDdrvlEdW7TY9EjtG1Ntm9
         9i6UJJy6oVOXM+f0nCp0qWPYfNECPgi1hVzyDAl+f2B7zarNdLh2RiL98S/k50UKp6CD
         /u1g==
X-Gm-Message-State: APjAAAVhCcE/LqwwFkgaBCyWAEM30KB4m0wBlMlvBLZi0jhGJrh06BJO
        2vebfKyC0u7ssltVRMppa+GoKpbP1kkp7Ociy2RYVXLN
X-Google-Smtp-Source: APXvYqyO0AjNna96LHP0+g5FL1Z5YcCxjQhXicr1BDpcaZ+uxSTF+NCU3HJq20z+prRQYyvYqjgcL2pkv3egCHexwfk=
X-Received: by 2002:a2e:8eda:: with SMTP id e26mr15006336ljl.157.1553054099404;
 Tue, 19 Mar 2019 20:54:59 -0700 (PDT)
MIME-Version: 1.0
From:   "C.J. Jameson" <cjcjameson@gmail.com>
Date:   Tue, 19 Mar 2019 20:54:48 -0700
Message-ID: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
Subject: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From fbb0e1fef08a2abd7f1620134925788f7a0e011f Mon Sep 17 00:00:00 2001
From: "C.J. Jameson" <cjcjameson@gmail.com>
Date: Tue, 19 Mar 2019 17:57:31 -0700
Subject: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1

When cherry-picking from a standard merge commit, the parent should
always be 1, as it has the meaningful new changes which were added to
the mainline. If the source commit is unique in some way and a user
wants to specify a value other than 1, they still can, but it's up to
them to be aware of which parent is which.

This builds on commit 37897bfc27 ("cherry-pick: do not error on
non-merge commits when '-m 1' is specified", 2018-12-14) which tolerated
`--mainline` for non-merge commits

Signed-off-by: C.J. Jameson <cjcjameson@gmail.com>
---
 Documentation/git-cherry-pick.txt |  6 +++---
 Documentation/git-revert.txt      |  6 +++---
 builtin/revert.c                  |  4 ++--
 t/t3502-cherry-pick-merge.sh      | 19 ++++++++++++++++++-
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt
b/Documentation/git-cherry-pick.txt
index b8cfeec67e..ec526d4cb8 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -76,13 +76,13 @@ OPTIONS
  described above, and `-r` was to disable it.  Now the
  default is not to do `-x` so this option is a no-op.

--m parent-number::
---mainline parent-number::
+-m [parent-number]::
+--mainline [parent-number]::
  Usually you cannot cherry-pick a merge because you do not know which
  side of the merge should be considered the mainline.  This
  option specifies the parent number (starting from 1) of
  the mainline and allows cherry-pick to replay the change
- relative to the specified parent.
+ relative to the specified parent. The default parent-number is 1.

 -n::
 --no-commit::
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 837707a8fd..57192a7c34 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -46,13 +46,13 @@ OPTIONS
  message prior to committing the revert. This is the default if
  you run the command from a terminal.

--m parent-number::
---mainline parent-number::
+-m [parent-number]::
+--mainline [parent-number]::
  Usually you cannot revert a merge because you do not know which
  side of the merge should be considered the mainline.  This
  option specifies the parent number (starting from 1) of
  the mainline and allows revert to reverse the change
- relative to the specified parent.
+ relative to the specified parent. The default parent-number is 1.
 +
 Reverting a merge commit declares that you will never want the tree changes
 brought in by the merge.  As a result, later merges will only bring in tree
diff --git a/builtin/revert.c b/builtin/revert.c
index a47b53ceaf..280d1f00a9 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -105,8 +105,8 @@ static int run_sequencer(int argc, const char
**argv, struct replay_opts *opts)
  OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
  OPT_NOOP_NOARG('r', NULL),
  OPT_BOOL('s', "signoff", &opts->signoff, N_("add Signed-off-by:")),
- OPT_CALLBACK('m', "mainline", opts, N_("parent-number"),
-      N_("select mainline parent"), option_parse_m),
+ { OPTION_INTEGER, 'm', "mainline", &opts->mainline, N_("parent-number"),
+ N_("select mainline parent"), PARSE_OPT_OPTARG, NULL, 1 },
  OPT_RERERE_AUTOUPDATE(&opts->allow_rerere_auto),
  OPT_STRING(0, "strategy", &opts->strategy, N_("strategy"), N_("merge
strategy")),
  OPT_CALLBACK('X', "strategy-option", &opts, N_("option"),
diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index 8b635a196d..4f248be582 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -34,7 +34,6 @@ test_expect_success setup '
 test_expect_success 'cherry-pick -m complains of bogus numbers' '
  # expect 129 here to distinguish between cases where
  # there was nothing to cherry-pick
- test_expect_code 129 git cherry-pick -m &&
  test_expect_code 129 git cherry-pick -m foo b &&
  test_expect_code 129 git cherry-pick -m -1 b &&
  test_expect_code 129 git cherry-pick -m 0 b
@@ -67,6 +66,15 @@ test_expect_success 'cherry pick a merge (1)' '

 '

+test_expect_success 'cherry pick a merge with default parent (1)' '
+
+ git reset --hard &&
+ git checkout a^0 &&
+ git cherry-pick -m c &&
+ git diff --exit-code c
+
+'
+
 test_expect_success 'cherry pick a merge (2)' '

  git reset --hard &&
@@ -111,6 +119,15 @@ test_expect_success 'revert a merge (1)' '

 '

+test_expect_success 'revert a merge with default parent (1)' '
+
+ git reset --hard &&
+ git checkout c^0 &&
+ git revert -m 1 c &&
+ git diff --exit-code a --
+
+'
+
 test_expect_success 'revert a merge (2)' '

  git reset --hard &&
-- 
2.21.0
