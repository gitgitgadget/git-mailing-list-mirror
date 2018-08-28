Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB2C1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeH2BOX (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:14:23 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34092 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeH2BOW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:14:22 -0400
Received: by mail-io0-f193.google.com with SMTP id c22-v6so2733347iob.1
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ELO8TvCfTYaBuKXSWCrfWIu+9klK6JTOD9ZKXf6wFx0=;
        b=Fj7onqoMXnK8nwDIdcwGvoMNdm+XQG2w9J/dSsq3REJXop47WKxrzxexs8Y6vzjhqj
         SDwk/NKJWVGOEqHnJ5Pt1w5uKGcJtxrIwEbcBcztmYc3M4GBvW7PoXSZ7ATNHRHafaTz
         XK1JKt3ynn9/8MPfZXBRBaCG4LICnCpfXOvqQlv68A7IvqLX1lW9BCiLFj/9vGhLwpTL
         0TLZw0A3qYyUs6EBHsmc01VmP7YEf76HlENtAE5jl++aE/eEX2ECP7x6ZY3iThNFOouz
         U4vjxKQ72JCGoOOF/bvq/ONLGZ043BGZT06JIEAWlDQ1v6QXQYpgFWRJEVUv4BzLDs0u
         aXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ELO8TvCfTYaBuKXSWCrfWIu+9klK6JTOD9ZKXf6wFx0=;
        b=CBGSSvJI7YL+kuz0ha5Hgh0YGAZb2dQKoq3OV07f5Y/PyF3/PO0jY0/PC4AnTVFXYA
         AffCa9o2hajb5rEFbs2wLEHr+ExxlBVi/4uh0g55areMOxxGap1vVL3FbCTDB8xhuivC
         8G4+OkJAlZIJ7D6NCQWMoJ3k2pSBXOX4B4vbTeWq2hRV/aNoI6AvZU6I9MMxgmyTYLtY
         iiTcaZKX5igI4D2b6xBt9WZ8w6x+cC3N1AfFrXkj4/rVEzsq37Cco4R8nNDBPAmNC5xl
         sY3db4Dwy7rhJ3H/Nw26v9kmw69ckCt7Tui1MJpzI+MuP4Z/w1tNFXu05vCTMkVmEhD9
         hTaA==
X-Gm-Message-State: APzg51Bma32X9K0CnC+vd9i+kHQNKDNitiiFvS/5wCjh7zpjWAPzC7li
        +V6wxWY+KqKTT86MLZ9yvjlh4NJj
X-Google-Smtp-Source: ANB0VdbGi/34hIEUF/psdlfuoRV4Aajn7jWSFVIKh9ZxBOTjP0nctUVDyPNPMG6KEoulwyOxCd1gXA==
X-Received: by 2002:a6b:5a01:: with SMTP id o1-v6mr3124482iob.73.1535491251862;
        Tue, 28 Aug 2018 14:20:51 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id o1-v6sm1090344iop.12.2018.08.28.14.20.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 14:20:51 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 6/9] worktree: teach 'add' to respect --force for registered but missing path
Date:   Tue, 28 Aug 2018 17:20:23 -0400
Message-Id: <20180828212026.21989-7-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180828212026.21989-1-sunshine@sunshineco.com>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For safety, "git worktree add <path>" will refuse to add a new
worktree at <path> if <path> is already associated with a worktree
entry, even if <path> is missing (for instance, has been deleted or
resides on non-mounted removable media or network share). The typical
way to re-create a worktree at <path> in such a situation is either to
prune all "broken" entries ("git worktree prune") or to selectively
remove the worktree entry manually ("git worktree remove <path>").

However, neither of these approaches ("prune" nor "remove") is
especially convenient, and they may be unsuitable for scripting when a
tool merely wants to re-use a worktree if it exists or create it from
scratch if it doesn't (much as a tool might use "mkdir -p" to re-use
or create a directory).

Therefore, teach 'add' to respect --force as a convenient way to
re-use a path already associated with a worktree entry if the path is
non-existent. For a locked worktree, require --force to be specified
twice.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt |  8 ++++++--
 builtin/worktree.c             | 10 ++++++++--
 t/t2025-worktree-add.sh        | 13 ++++++++++++-
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 29a5b7e252..8537692f05 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -120,8 +120,12 @@ OPTIONS
 --force::
 	By default, `add` refuses to create a new working tree when
 	`<commit-ish>` is a branch name and is already checked out by
-	another working tree and `remove` refuses to remove an unclean
-	working tree. This option overrides these safeguards.
+	another working tree, or if `<path>` is already assigned to some
+	working tree but is missing (for instance, if `<path>` was deleted
+	manually). This option overrides these safeguards. To add a missing but
+	locked working tree path, specify `--force` twice.
++
+`remove` refuses to remove an unclean working tree unless `--force` is used.
 
 -b <new-branch>::
 -B <new-branch>::
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1122f27b5f..3eb2f89b0f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -241,10 +241,16 @@ static void validate_worktree_add(const char *path, const struct add_opts *opts)
 		goto done;
 
 	locked = !!is_worktree_locked(wt);
+	if ((!locked && opts->force) || (locked && opts->force > 1)) {
+		if (delete_git_dir(wt->id))
+		    die(_("unable to re-add worktree '%s'"), path);
+		goto done;
+	}
+
 	if (locked)
-		die(_("'%s' is a missing but locked worktree;\nuse 'unlock' and 'prune' or 'remove' to clear"), path);
+		die(_("'%s' is a missing but locked worktree;\nuse 'add -f -f' to override, or 'unlock' and 'prune' or 'remove' to clear"), path);
 	else
-		die(_("'%s' is a missing but already registered worktree;\nuse 'prune' or 'remove' to clear"), path);
+		die(_("'%s' is a missing but already registered worktree;\nuse 'add -f' to override, or 'prune' or 'remove' to clear"), path);
 
 done:
 	free_worktrees(worktrees);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 67fccc6591..286bba35d8 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -556,7 +556,18 @@ test_expect_success '"add" an existing but missing worktree' '
 	git worktree add --detach pneu &&
 	test_must_fail git worktree add --detach pneu &&
 	rm -fr pneu &&
-	test_must_fail git worktree add --detach pneu
+	test_must_fail git worktree add --detach pneu &&
+	git worktree add --force --detach pneu
+'
+
+test_expect_success '"add" an existing locked but missing worktree' '
+	git worktree add --detach gnoo &&
+	git worktree lock gnoo &&
+	test_when_finished "git worktree unlock gnoo || :" &&
+	rm -fr gnoo &&
+	test_must_fail git worktree add --detach gnoo &&
+	test_must_fail git worktree add --force --detach gnoo &&
+	git worktree add --force --force --detach gnoo
 '
 
 test_done
-- 
2.19.0.rc1.350.ge57e33dbd1

