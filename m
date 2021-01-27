Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08962C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D26120724
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhA0IJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbhA0IF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 03:05:58 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EB3C06178C
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 00:04:15 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id p15so886113wrq.8
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 00:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e84ELbGj/knhNz7TB16fm016R2aWZyi/WZsxJJgA/eE=;
        b=md+I1D+0nhwUNxc8u/4jrQ9KFa8KIMinhcLyPHaCbG72DoSG3esp8BFqkfZvRSbIjL
         inaG7t55jqH57APKPlMTsfxsEv+sEj3Uo5/luodWIM3n8Qxzlr3m7PtMSnC665vx7WE1
         CMLpAjj5gJLVBZfRavyvuKPmZC3Z1WI0GjRlVkQN8LZ5wwT/YfyE4SPBB6CtPfo1mcTx
         raGUGprWwJ07Tfw5CrIV4g8Isx6WATc19t8BKE0RzDjM8yBlcOm/CWuFcADhcYkl8lTK
         cR3NjGy9zD5SrLuqSm4aksI9z/Dn2SXan0WkZtMbWCc6ASkjEg5ucpAZzULy1lbzxkBv
         0Ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e84ELbGj/knhNz7TB16fm016R2aWZyi/WZsxJJgA/eE=;
        b=Cdmh3RCQo4qbog8ZEnUv7XaPXY4ixmzX6lHyj4g6BLfLY2hRAnNpfdLx3i/wCymGI/
         Ic1M94lTKHKelJB9g1gW8wZdryWIZMB9xGJry+nb7zCl+TAYnJjXUvJuWuPPH67OE/LN
         AWOA2k7TFUynFTrwkj6ZsUPR0S4xfHUIFSpH0HIBHrLsAf9UAbhVQiEJB5QfRT+Lb8Qn
         qFYMn0VGMOGQ+3I9QDQW5y+JxjC3k0kljFdSBLVMLmKD6NVVA9yO7blFWl7mDJGwWSMp
         50kwGMAZhSkjTRqkjRUm60OCHIJ8Zd2RBMqFxxP90+jhGEvfK0BuOSlI+X++YglDUVCf
         MhXA==
X-Gm-Message-State: AOAM533im7fr5gCpmkElRl64ysF2Cr0efzGSiWsTjyvFE4eBqw8sHQRc
        xBGpBSk7h5c9guayYbPanDfIzvUdTndZ3XBd
X-Google-Smtp-Source: ABdhPJyat1gN/QrgEOE8qyWQXpq/jDVXqg6+cL5Z8NecEe363uoeDu10tGDBsTEwgRZpi3QH5bSHyA==
X-Received: by 2002:adf:e48b:: with SMTP id i11mr9975141wrm.406.1611734654344;
        Wed, 27 Jan 2021 00:04:14 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.116])
        by smtp.gmail.com with ESMTPSA id m8sm1850237wrv.37.2021.01.27.00.04.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 00:04:13 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v4 6/7] worktree: teach `list` to annotate prunable worktree
Date:   Wed, 27 Jan 2021 09:03:09 +0100
Message-Id: <20210127080310.89639-7-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.395.g7821b4e95a
In-Reply-To: <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
References: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
 <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git worktree list" command shows the absolute path to the worktree,
the commit that is checked out, the name of the branch, and a "locked"
annotation if the worktree is locked, however, it does not indicate
whether the worktree is prunable.

The "prune" command will remove a worktree if it is prunable unless
`--dry-run` option is specified. This could lead to a worktree being
removed without the user realizing before it is too late, in case the
user forgets to pass --dry-run for instance. If the "list" command shows
which worktree is prunable, the user could verify before running
"git worktree prune" and hopefully prevents the working tree to be
removed "accidentally" on the worse case scenario.

Let's teach "git worktree list" to show when a worktree is a prunable
candidate for both default and porcelain format.

In the default format a "prunable" text is appended:

    $ git worktree list
    /path/to/main      aba123 [main]
    /path/to/linked    123abc [branch-a]
    /path/to/prunable  ace127 (detached HEAD) prunable

In the --porcelain format a prunable label is added followed by
its reason:

    $ git worktree list --porcelain
    ...
    worktree /path/to/prunable
    HEAD abc1234abc1234abc1234abc1234abc1234abc12
    detached
    prunable gitdir file points to non-existent location
    ...

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 Documentation/git-worktree.txt | 26 ++++++++++++++++++++++++--
 builtin/worktree.c             | 10 ++++++++++
 t/t2402-worktree-list.sh       | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 426e9b4f76..240c3fd76b 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -97,8 +97,9 @@ list::
 List details of each working tree.  The main working tree is listed first,
 followed by each of the linked working trees.  The output details include
 whether the working tree is bare, the revision currently checked out, the
-branch currently checked out (or "detached HEAD" if none), and "locked" if
-the worktree is locked.
+branch currently checked out (or "detached HEAD" if none), "locked" if
+the worktree is locked, "prunable" if the worktree can be pruned by `prune`
+command.
 
 lock::
 
@@ -234,6 +235,9 @@ This can also be set up as the default behaviour by using the
 
 --expire <time>::
 	With `prune`, only expire unused working trees older than `<time>`.
++
+With `list`, annotate missing working trees as prunable if they are
+older than `<time>`.
 
 --reason <string>::
 	With `lock`, an explanation why the working tree is locked.
@@ -372,6 +376,19 @@ $ git worktree list
 /path/to/other-linked-worktree  1234abc  (detached HEAD)
 ------------
 
+The command also shows annotations for each working tree, according to its state.
+These annotations are:
+
+ * `locked`, if the working tree is locked.
+ * `prunable`, if the working tree can be pruned via `git worktree prune`.
+
+------------
+$ git worktree list
+/path/to/linked-worktree    abcd1234 [master]
+/path/to/locked-worktreee   acbd5678 (brancha) locked
+/path/to/prunable-worktree  5678abc  (detached HEAD) prunable
+------------
+
 Porcelain Format
 ~~~~~~~~~~~~~~~~
 The porcelain format has a line per attribute.  Attributes are listed with a
@@ -405,6 +422,11 @@ HEAD 3456def3456def3456def3456def3456def3456b
 branch refs/heads/locked-with-reason
 locked reason why is locked
 
+worktree /path/to/linked-worktree-prunable
+HEAD 1233def1234def1234def1234def1234def1234b
+detached
+prunable gitdir file points to non-existent location
+
 ------------
 
 If the lock reason contains "unusual" characters such as newline, they
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 98177f91d4..20944c266e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -592,6 +592,10 @@ static void show_worktree_porcelain(struct worktree *wt)
 	} else if (reason)
 		printf("locked\n");
 
+	reason = worktree_prune_reason(wt, expire);
+	if (reason)
+		printf("prunable %s\n", reason);
+
 	printf("\n");
 }
 
@@ -620,6 +624,9 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 	if (worktree_lock_reason(wt))
 		strbuf_addstr(&sb, " locked");
 
+	if (worktree_prune_reason(wt, expire))
+		strbuf_addstr(&sb, " prunable");
+
 	printf("%s\n", sb.buf);
 	strbuf_release(&sb);
 }
@@ -663,9 +670,12 @@ static int list(int ac, const char **av, const char *prefix)
 
 	struct option options[] = {
 		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
+		OPT_EXPIRY_DATE(0, "expire", &expire,
+				N_("add 'prunable' annotation to worktrees older than <time>")),
 		OPT_END()
 	};
 
+	expire = TIME_MAX;
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (ac)
 		usage_with_options(worktree_usage, options);
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 39596e4aa9..69342b7280 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -104,6 +104,38 @@ test_expect_success '"list" all worktrees --porcelain with locked reason newline
 	test_cmp expect actual
 '
 
+test_expect_success '"list" all worktrees with prunable annotation' '
+	test_when_finished "rm -rf prunable unprunable out && git worktree prune" &&
+	git worktree add --detach prunable &&
+	git worktree add --detach unprunable &&
+	rm -rf prunable &&
+	git worktree list >out &&
+	grep "/prunable  *[0-9a-f].* prunable$" out &&
+	! grep "/unprunable  *[0-9a-f].* prunable$"
+'
+
+test_expect_success '"list" all worktrees --porcelain with prunable' '
+	test_when_finished "rm -rf prunable out && git worktree prune" &&
+	git worktree add --detach prunable &&
+	rm -rf prunable &&
+	git worktree list --porcelain >out &&
+	sed -n "/^worktree .*\/prunable$/,/^$/p" <out >only_prunable &&
+	test_i18ngrep "^prunable gitdir file points to non-existent location$" only_prunable
+'
+
+test_expect_success '"list" all worktrees with prunable consistent with "prune"' '
+	test_when_finished "rm -rf prunable unprunable out && git worktree prune" &&
+	git worktree add --detach prunable &&
+	git worktree add --detach unprunable &&
+	rm -rf prunable &&
+	git worktree list >out &&
+	grep "/prunable  *[0-9a-f].* prunable$" out &&
+	! grep "/unprunable  *[0-9a-f].* unprunable$" out &&
+	git worktree prune --verbose >out &&
+	test_i18ngrep "^Removing worktrees/prunable" out &&
+	test_i18ngrep ! "^Removing worktrees/unprunable" out
+'
+
 test_expect_success 'bare repo setup' '
 	git init --bare bare1 &&
 	echo "data" >file1 &&
-- 
2.30.0.373.geade8fefe8

