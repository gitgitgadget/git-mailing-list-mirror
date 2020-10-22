Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31F7C4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 10:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F8722267
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 10:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7DRx1W8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896574AbgJVKiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 06:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896543AbgJVKiR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 06:38:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E96C0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 03:38:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id q5so1519632wmq.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 03:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6EqN5vgfbMFqEku5kj13f887yhPqjZmZr3GYH8PA6CE=;
        b=m7DRx1W8wtoSrg8T4nO2JMGHJ7OpWihzxc/qcVTqVYEBK6z56dwWWuj/NSDHVZ0N06
         wEDLCCK3hHvfQa+pF601ybve6arYLivZYoOD0t84sO3MdYa+F/eDiehMETmzKw7jXR5K
         cpFpbpSybCYHSJEbWnQWIEizpk8WhH68HNu0Pr8nKX3A8InUx1dSI6J+7UJEwvQ9oNQ4
         SXEJ1oMEy7tVSI0lw7/wOQmMnYv1ZPaKagG2qCHkqegyoMDau/RUNZGUutb2SrBYSzWI
         7MuECpPOKnGKdODSTFuIBL3PMsEWwMn+bCjgqCXXo1aXKydK8Qg17Kbpx0Lsn0BldyBw
         +YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6EqN5vgfbMFqEku5kj13f887yhPqjZmZr3GYH8PA6CE=;
        b=lpgIODseYPUm2RP2vvSuKRQUCEhA9jZ5KSdySk2+tTcZGSkxZhEv52WeQLxEtzyk+D
         /3tjH8BG/DgVfRpKUButGOp3feAQqnhY5oMKACK+UxBGzCFbfNWCjhbo2q6ppLz1P7kx
         TRmJLsJANnx/HMqwRvIoIzpsZG+AJnOK3HYNG/D56zLPzVDwM+c0IHndLn4PN8DGeOo4
         /iXXrPG1wUw/K/z3JfAZ9mgBkRXzWcxuGpw6bGl2R8P9CiDq+Z8VXtcbMzNmmVVrLbKi
         AZGBNpx6itQ1/P1yiU1m6eT5vm7yVgvahAhRMexpsGr0iujH7oTfO2uo1OvnT284U4k4
         ev9A==
X-Gm-Message-State: AOAM5313ExKWqyy5y07+O5vrg/HXmPfsBrIAySyloJrY6Wfe/nuctXkN
        paa/7X8tAn2O1TtvURvKSXRKUFIZPQY=
X-Google-Smtp-Source: ABdhPJwA5kRbUe+rYB4YgHpvhMbjeVbiAQvPw0xtC1sCBlYWvUWqLMJ0WU/T/5//jZ124wRYn3JqAg==
X-Received: by 2002:a1c:44e:: with SMTP id 75mr1902842wme.117.1603363095536;
        Thu, 22 Oct 2020 03:38:15 -0700 (PDT)
Received: from localhost.localdomain (92-249-246-148.pool.digikabel.hu. [92.249.246.148])
        by smtp.gmail.com with ESMTPSA id d129sm2974439wmd.5.2020.10.22.03.38.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2020 03:38:14 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] bisect: loosen halfway() check for a large number of commits
Date:   Thu, 22 Oct 2020 12:38:06 +0200
Message-Id: <20201022103806.26680-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.29.0.470.g6462f21d4e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git bisect start ...' and subsequent 'git bisect (good|bad)' commands
can take quite a while when the given/remaining revision range between
good and bad commits is big and contains a lot of merge commits, e.g.
in git.git:

  $ git rev-list --count v1.6.0..v2.28.0
  44284
  $ time git bisect start v2.28.0 v1.6.0
  Bisecting: 22141 revisions left to test after this (roughly 15 steps)
  [e197c21807dacadc8305250baa0b9228819189d4] unable_to_lock_die(): rename function from unable_to_lock_index_die()

  real    0m15.472s
  user    0m15.220s
  sys     0m0.255s

The majority of the runtime is spent in do_find_bisection(), where we
try to find a commit as close as possible to the halfway point between
the bad and good revisions, i.e. a commit from which the number of
reachable commits that are in the good-bad range is half the total
number of commits in that range.  So we count how many commits are
reachable in the good-bad range for each commit in that range, which
is quick and easy for a linear history, even over 300k commits in a
linear range are handled in ~0.3s on my machine.  Alas, handling merge
commits is non-trivial and quite expensive as the algorithm used seems
to be quadratic, causing the long runtime shown above.

Interestingly, look at what a big difference one additional commit
can make:

  $ git rev-list --count v1.6.0^..v2.28.0
  44285
  $ time git bisect start v2.28.0 v1.6.0^
  Bisecting: 22142 revisions left to test after this (roughly 15 steps)
  [565301e41670825ceedf75220f2918ae76831240] Sync with 2.1.2

  real  0m5.848s
  user  0m5.600s
  sys   0m0.252s

The difference is caused by one of the optimizations attempting to cut
down the runtime added in 1c4fea3a40 (git-rev-list --bisect:
optimization, 2007-03-21):

    Another small optimization is whenever we find a half-way commit
    (that is, a commit that can reach exactly half of the commits),
    we stop giving counts to remaining commits, as we will not find
    any better commit than we just found.

In this second 'git bisect start' command we happen to find a commit
exactly at the halfway point and can return early, but in the first
case there is no such commit, so we can't return early and end up
counting the number of reachable commits from all commits in the
good-bad range.

However, when we have thousands of commits it's not all that important
to find the _exact_ halfway point, a few commits more or less doesn't
make any real difference for the bisection.

So let's loosen the halfway check to consider commits within about
0.1% of the exact halfway point as halfway as well.  This will allow
us to return early on a bigger good-bad range, even when there is no
commit exactly at the halfway point, thereby reducing the runtime of
the first command above considerably, from ~15s to 4.901s.
Furthermore, even if there is a commit exactly at the halfway point,
we might still stumble upon a commit within that 0.1% range before
finding the exact halfway point, allowing us to return a bit earlier,
slightly reducing the runtime of the second command from 5.848s to
5.058s.  Note that this change doesn't affect good-bad ranges
containing ~2000 commits or less, because that 0.1% tolerance becomes
zero due to integer arithmetic; however, if the range is that small
then counting the reachable commits for all commits is already fast
enough anyway.

Naturally, this will likely change which commits get picked at each
bisection step, and, in turn, might change how many bisection steps
are necessary to find the first bad commit.  If the number of
necessary bisection steps were to increase often, then this change
could backfire, because building and testing at each step might take
much longer than the time spared.  OTOH, if the number of steps were
to decrease, then it would be a double win.

So I ran some tests to see how often that happens: picked random good
and bad starting revisions at least 50k commits apart and a random
first bad commit in between in git.git, and used 'git bisect run git
merge-base --is-ancestor HEAD $first_bad_commit' to check the number
of necessary bisection steps.  After repeating all this 1000 times
both with and without this patch I found that:

  - 146 cases needed one more bisection step than before, 149 cases
    needed one less step, while in the remaining 705 cases the number
    of steps didn't change.  So the number of bisection steps does
    indeed change in a non-negligible number of cases, but it seems
    that the average number of steps doesn't change in the long run.

  - The first 'git bisect start' command got over 3x faster in 456
    cases, so this "no commit at the exact halfway point" case seems
    to be common enough to care about.

[TODO:
  - Update comments at callsites mentioning "exact halfway".
  - Rename function to approx_halfway(), perhaps?]
---
 bisect.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index f5b1368128..1857ce4c75 100644
--- a/bisect.c
+++ b/bisect.c
@@ -105,6 +105,8 @@ static int count_interesting_parents(struct commit *commit, unsigned bisect_flag
 
 static inline int halfway(struct commit_list *p, int nr)
 {
+	int diff;
+
 	/*
 	 * Don't short-cut something we are not going to return!
 	 */
@@ -113,13 +115,22 @@ static inline int halfway(struct commit_list *p, int nr)
 	if (DEBUG_BISECT)
 		return 0;
 	/*
-	 * 2 and 3 are halfway of 5.
+	 * For small number of commits 2 and 3 are halfway of 5, and
 	 * 3 is halfway of 6 but 2 and 4 are not.
 	 */
-	switch (2 * weight(p) - nr) {
+	diff = 2 * weight(p) - nr;
+	switch (diff) {
 	case -1: case 0: case 1:
 		return 1;
 	default:
+		/*
+		 * For large number of commits we are not so strict, it's
+		 * good enough if it's within ~0.1% of the halfway point,
+		 * e.g. 5000 is exactly halfway of 10000, but we consider
+		 * the values [4996, 5004] as halfway as well.
+		 */
+		if (abs(diff) < nr / 1024)
+			return 1;
 		return 0;
 	}
 }
-- 
2.29.0.470.g6462f21d4e

