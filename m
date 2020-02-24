Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596DAC11D2A
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 09:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DAF20870
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 09:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNJrmoju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgBXJMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:12:53 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37910 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgBXJKA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 04:10:00 -0500
Received: by mail-yb1-f193.google.com with SMTP id x9so2219767ybl.5
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 01:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a/1lnoWGl3+VqZhXRx/qjVg7EIou0SwzOjIR1WqLLhU=;
        b=QNJrmojuEaxpbPUu21qorIcHrhFgUBOdo7SPBqEBpeSvuwHjQwL87shtFgGxYLXP0Z
         2lfkDL3bYoIK3EtAxG5Y4kZCcC20Gn58ZaYbgoPf/xaC8P7VVN1jlaPu+WUwZQvVTmBm
         fd6LqQEEGaH60c6nZA8vFTxzMTbR3hYECMVbF8D+tPJ/qWMDA7AMn2KUMncPpeNKfaaM
         6/CdCB/ve7/zijae7Se3HnIHLoRIyy51ONoSO0nkhD8OP+bAv0LBNG8uomBqUfGX3gXo
         HcvOSIAzTwJ/tbVLkwvYPpDxq8qJaM0E3UurBtLclP1Iwg0zjhJD7AnPjyeQzE31gUME
         +Uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=a/1lnoWGl3+VqZhXRx/qjVg7EIou0SwzOjIR1WqLLhU=;
        b=qSu7PZ+pEmY2eJVF2dAp8Uf1emQ4z1rvsTKfLfEJV/L5KBBYGyDnBZElygxJBmZCey
         QVQsOZZd8hthxIkI6E9BxIqqzoY9XqGKZfaBWQBZojjPhSf5yxQmZUy7pa3zumBuc+AF
         hIqQqDUteY6yujZxAYXjvgNRO3srAoKz2cjwh+6tehwRuApd1VM0akyBIxmU2zoiEDjI
         h5geBf/EN2RdCGMtg2XmgpmmJTcoAfohHGJnzzIFvGjHPL8xP8NKS7bKkEMH/mHNI3pI
         LGAN7IkhX44xR/+tbEsYPsHI5bVxKy03yRL8Jiu1irtzOcNBrsX1vOJVhXPHgJOx0JZE
         p4IQ==
X-Gm-Message-State: APjAAAVqbDvDPgFkGAAAqTRIQ9hhUC6uMly8WTO3mS7ZblUTgSNKRvmS
        MQukV34xzG8QJekqyvsd5Wlw7/xl
X-Google-Smtp-Source: APXvYqzArT0lpX1gus3cf8sMcCGjWx+CCdB3FOVvPbwCYJtN6WAgGQc/ZC6tH8qXy7SuhcGOTOHVqQ==
X-Received: by 2002:a25:d6d1:: with SMTP id n200mr42937118ybg.488.1582535398397;
        Mon, 24 Feb 2020 01:09:58 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id g29sm5045988ywk.31.2020.02.24.01.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 01:09:57 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Cameron Gunnin <cameron.gunnin@synopsys.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/3] worktree: don't allow "add" validation to be fooled by suffix matching
Date:   Mon, 24 Feb 2020 04:08:48 -0500
Message-Id: <20200224090848.54321-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.25.1.526.gf05a752211
In-Reply-To: <20200224090848.54321-1-sunshine@sunshineco.com>
References: <CAPig+cQh8hxeoVjLHDKhAcZVQPpPT5v0AUY8gsL9=qfJ7z-L2A@mail.gmail.com>
 <20200224090848.54321-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git worktree add <path>" performs various checks before approving
<path> as a valid location for the new worktree. Aside from ensuring
that <path> does not already exist, one of the questions it asks is
whether <path> is already a registered worktree. To perform this check,
it queries find_worktree() and disallows the "add" operation if
find_worktree() finds a match for <path>. As a convenience, however,
find_worktree() casts an overly wide net to allow users to identify
worktrees by shorthand in order to keep typing to a minimum. For
instance, it performs suffix matching which, given subtrees "foo/bar"
and "foo/baz", can correctly select the latter when asked only for
"baz".

"add" validation knows the exact path it is interrogating, so this sort
of heuristic-based matching is, at best, questionable for this use-case
and, at worst, may may accidentally interpret <path> as matching an
existing worktree and incorrectly report it as already registered even
when it isn't. (In fact, validate_worktree_add() already contains a
special case to avoid accidentally matching against the main worktree,
precisely due to this problem.)

Avoid the problem of potential accidental matching against an existing
worktree by instead taking advantage of find_worktree_by_path() which
matches paths deterministically, without applying any sort of magic
shorthand matching performed by find_worktree().

Reported-by: Cameron Gunnin <cameron.gunnin@synopsys.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c      | 9 +--------
 t/t2400-worktree-add.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d6bc5263f1..24f22800f3 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -234,14 +234,7 @@ static void validate_worktree_add(const char *path, const struct add_opts *opts)
 		die(_("'%s' already exists"), path);
 
 	worktrees = get_worktrees(0);
-	/*
-	 * find_worktree()'s suffix matching may undesirably find the main
-	 * rather than a linked worktree (for instance, when the basenames
-	 * of the main worktree and the one being created are the same).
-	 * We're only interested in linked worktrees, so skip the main
-	 * worktree with +1.
-	 */
-	wt = find_worktree(worktrees + 1, NULL, path);
+	wt = find_worktree_by_path(worktrees, path);
 	if (!wt)
 		goto done;
 
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index b5ece19460..5a7495474a 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -570,6 +570,15 @@ test_expect_success '"add" an existing locked but missing worktree' '
 	git worktree add --force --force --detach gnoo
 '
 
+test_expect_success '"add" not tripped up by magic worktree matching"' '
+	# if worktree "sub1/bar" exists, "git worktree add bar" in distinct
+	# directory `sub2` should not mistakenly complain that `bar` is an
+	# already-registered worktree
+	mkdir sub1 sub2 &&
+	git -C sub1 --git-dir=../.git worktree add --detach bozo &&
+	git -C sub2 --git-dir=../.git worktree add --detach bozo
+'
+
 test_expect_success FUNNYNAMES 'sanitize generated worktree name' '
 	git worktree add --detach ".  weird*..?.lock.lock" &&
 	test -d .git/worktrees/---weird-.-
-- 
2.25.1.526.gf05a752211

