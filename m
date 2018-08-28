Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53E791F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeH2BOW (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:14:22 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40052 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeH2BOV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:14:21 -0400
Received: by mail-io0-f194.google.com with SMTP id l14-v6so2706777iob.7
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yb0TvKYMedHoseMD4RDwMgdGvgEkgVOmoD3TSEri4Ms=;
        b=S3pACT+gL+uVeLHzWbvHwp2mAgrnkNQjHBmc2vxlRRyRqzI5h60HuVTWadWFmHH4NC
         RbusPerL+rq5wOzYrV0Z/HMtGbw7IsFWN1hQBmMmRbSJkKgVfExmtY6oov4oB8qa/Eir
         Om0LUlUkzzKnWYW2vNGcOrCvN/zsIXaLG56D5+0stH9mk+9K0909NfAHmftk8AlS/QN6
         5T2aRU4LZ2fBXXcBn+CWosjs/Ytv90cJKjSRAz8tqU6XTWnDp/u3VsRMtXUKFtfNeVc3
         RIKwTugBtgmo/qy3QGYxUEUR4pxfp4ScelTlRAUaHXbf8GjVH5lPdGjA0iPeT6r1KSLP
         VTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yb0TvKYMedHoseMD4RDwMgdGvgEkgVOmoD3TSEri4Ms=;
        b=m6khldnSLL0RzMc0ick+WgRxnwK5Eoc+LauXYszUFOxELuVqFjp4vM0yV/7/8OGznh
         nr3Jk2QMPiTL+4zEqh7agbycHUaGlgyIqSxZQKaQO4Lr/bBYd7LWur+G6l3PTZU/RKvc
         kJNaFVX+3xz/Nzkn8OTQ2e7Jd9BdecwbzIF8sBc8fgTBXbnsCTsFa6pJDkjljX3ssyWW
         Xbp1svsLrKjt/Yv9jzYIBupKRWqpCOOu7p/9iEvCfjeRnWBV0/WVNAADLv+QRomJyo9P
         3ryec9syNcCKqvhP4KjNy670M3YgEok/h/Wo/5SokbvAIpev+1iDvPTRWVb5hpdWVQNt
         AH8Q==
X-Gm-Message-State: APzg51A4GFp8b23JMLk1R0TdU3dfGRBDjSZZvQ+/s8U2odsyJKqQN/t7
        cI1o/uxJcuJVB49XecfiP1b/nx5v
X-Google-Smtp-Source: ANB0VdZL5/6gIyUMZsZjuTUmaJEY+lU3jEw0/nSPzhOvhpfPUVdqnl4jzuhZj2TTL524oQck2SIzSw==
X-Received: by 2002:a6b:750a:: with SMTP id l10-v6mr2890487ioh.87.1535491250958;
        Tue, 28 Aug 2018 14:20:50 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id o1-v6sm1090344iop.12.2018.08.28.14.20.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 14:20:50 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 5/9] worktree: disallow adding same path multiple times
Date:   Tue, 28 Aug 2018 17:20:22 -0400
Message-Id: <20180828212026.21989-6-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180828212026.21989-1-sunshine@sunshineco.com>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A given path should only ever be associated with a single registered
worktree. This invariant is enforced by refusing to create a new
worktree at a given path if that path already exists. For example:

    $ git worktree add -q --detach foo
    $ git worktree add -q --detach foo
    fatal: 'foo' already exists

However, the check can be fooled, and the invariant broken, if the
path is missing. Continuing the example:

    $ rm -fr foo
    $ git worktree add -q --detach foo
    $ git worktree list
    ...      eadebfe [master]
    .../foo  eadebfe (detached HEAD)
    .../foo  eadebfe (detached HEAD)

This "corruption" leads to the unfortunate situation in which the
worktree can not be removed:

    $ git worktree remove foo
    fatal: validation failed, cannot remove working tree: '.../foo'
    does not point back to '.git/worktrees/foo'

Nor can the bogus entry be pruned:

    $ git worktree prune -v
    $ git worktree list
    ...      eadebfe [master]
    .../foo  eadebfe (detached HEAD)
    .../foo  eadebfe (detached HEAD)

without first deleting the worktree directory manually:

    $ rm -fr foo
    $ git worktree prune -v
    Removing .../foo: gitdir file points to non-existent location
    Removing .../foo1: gitdir file points to non-existent location
    $ git worktree list
    ...  eadebfe [master]

or by manually deleting the worktree entry in .git/worktrees.

To address this problem, upgrade "git worktree add" validation to
allow worktree creation only if the given path is not already
associated with an existing worktree (even if the path itself is
non-existent), thus preventing such bogus worktree entries from being
created in the first place.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c      | 25 +++++++++++++++++++++++++
 t/t2025-worktree-add.sh |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 46c93771e8..1122f27b5f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -221,8 +221,33 @@ static const char *worktree_basename(const char *path, int *olen)
 
 static void validate_worktree_add(const char *path, const struct add_opts *opts)
 {
+	struct worktree **worktrees;
+	struct worktree *wt;
+	int locked;
+
 	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
+
+	worktrees = get_worktrees(0);
+	/*
+	 * find_worktree()'s suffix matching may undesirably find the main
+	 * rather than a linked worktree (for instance, when the basenames
+	 * of the main worktree and the one being created are the same).
+	 * We're only interested in linked worktrees, so skip the main
+	 * worktree with +1.
+	 */
+	wt = find_worktree(worktrees + 1, NULL, path);
+	if (!wt)
+		goto done;
+
+	locked = !!is_worktree_locked(wt);
+	if (locked)
+		die(_("'%s' is a missing but locked worktree;\nuse 'unlock' and 'prune' or 'remove' to clear"), path);
+	else
+		die(_("'%s' is a missing but already registered worktree;\nuse 'prune' or 'remove' to clear"), path);
+
+done:
+	free_worktrees(worktrees);
 }
 
 static int add_worktree(const char *path, const char *refname,
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 07d292317c..67fccc6591 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -552,4 +552,11 @@ test_expect_success '"add" in bare repo invokes post-checkout hook' '
 	test_cmp hook.expect goozy/hook.actual
 '
 
+test_expect_success '"add" an existing but missing worktree' '
+	git worktree add --detach pneu &&
+	test_must_fail git worktree add --detach pneu &&
+	rm -fr pneu &&
+	test_must_fail git worktree add --detach pneu
+'
+
 test_done
-- 
2.19.0.rc1.350.ge57e33dbd1

