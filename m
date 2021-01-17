Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20D9C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789FC206E3
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbhAQXpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 18:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbhAQXpR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 18:45:17 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FA9C0613CF
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 15:43:52 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a10so4597485ejg.10
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 15:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s4m7NkDtgIh0IrgO1NmV6FFK3XGHDTBWlG2tHRVoM2w=;
        b=Qo9uurKhM0/+C9Sn9WEsQWW72UIVPeu5QEtrJKsFlDKOFcKFrtepwZ0U+rN3dHSI5G
         W1gVijQYvD7G1lufGt3feERPa8VIyHM+dNcMuZChei++tVWy8YrN3ORvoI4oJBAOkY0x
         66lLszoTPyi/7nCQFEB9tM6tLpPSobTp+50FeTpckPESGKVGam4WI9ezQgIddh+Hftci
         B6dk22isTnHTVW+nL5prD4xpF2G7CUei9E8D7svTDyFZGD6SUc6pQtYLEDDNbQpjaZmj
         ZsYRWdZcoYuQl4QCLLDh9/BTHXEYa5Xt35AfCFXnR6i9LrM74suWc/5ifqsL2FV13z5r
         XYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s4m7NkDtgIh0IrgO1NmV6FFK3XGHDTBWlG2tHRVoM2w=;
        b=dsqPS/zvBFOzaEoxx1V5RNI7PRMNgNzUOEj6yR/LcCDCrgJZI5KlpOlfKjGOUhzwdr
         2f1MHtsD2/IZtwNpJkLZQXqgJ5h1M/ff7sAfGktrMptqUoG7PsYsf4dOGpw5v+ar94bR
         YaJ0O07uVthmTstS06FwbvbW5KUuky/KcWAxljPc+CmcfUc9TlCAw2ZvmsEAbq1o8yjw
         aTPNizPDCeBIUVk5oJgKYM8tmJwtVJgU8yaDj9LiHrsvo/APg1gw2TX63sPCLkKwXBcQ
         qUh9qnmnG8g6vvOT2fkG6w/uqbJjI/0mzc41lak7NUwmkXTM4XP9UqKjD+v+eR9J/Kq8
         bBjA==
X-Gm-Message-State: AOAM531+CBMROooS8GvezPnSihWuOo+xjIg85XyXwf3kJiJqtliDNG6K
        kbMUcntHBBFLW0TjIKAIkszDisvDVdU=
X-Google-Smtp-Source: ABdhPJzLPBysuX5htgdUpmnQPodGuMg6tDsWr0HVI5l+7RB6jllWcfnJ31HPdtXzWyY+jPcPZByE7A==
X-Received: by 2002:a17:906:7c49:: with SMTP id g9mr16025699ejp.185.1610927030996;
        Sun, 17 Jan 2021 15:43:50 -0800 (PST)
Received: from localhost.localdomain ([79.140.114.246])
        by smtp.gmail.com with ESMTPSA id f13sm8639932ejf.42.2021.01.17.15.43.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 15:43:50 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v2 5/6] worktree: teach `list` to annotate prunable worktree
Date:   Mon, 18 Jan 2021 00:42:43 +0100
Message-Id: <20210117234244.95106-6-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.372.gbc7e965391
In-Reply-To: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
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
 builtin/worktree.c             | 15 ++++++++++++++-
 t/t2402-worktree-list.sh       | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index d352a002f2..3d8c14dbdf 100644
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
+older than `<mtime>`.
 
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
+/path/to/linked-worktree        abcd1234 [master]
+/path/to/locked-worktreee       acbd5678 (brancha) locked
+/path/to/prunable-worktree      5678abc  (detached HEAD) prunable
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
 
 EXAMPLES
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 37ae277352..fb82d7bb64 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -592,6 +592,10 @@ static void show_worktree_porcelain(struct worktree *wt)
 	} else if (reason)
 		printf("locked\n");
 
+	reason = worktree_prune_reason(wt, expire);
+	if (reason && *reason)
+		printf("prunable %s\n", reason);
+
 	printf("\n");
 }
 
@@ -600,6 +604,7 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 	struct strbuf sb = STRBUF_INIT;
 	int cur_path_len = strlen(wt->path);
 	int path_adj = cur_path_len - utf8_strwidth(wt->path);
+	const char *reason;
 
 	strbuf_addf(&sb, "%-*s ", 1 + path_maxlen + path_adj, wt->path);
 	if (wt->is_bare)
@@ -617,9 +622,14 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 			strbuf_addstr(&sb, "(error)");
 	}
 
-	if (!is_main_worktree(wt) && worktree_lock_reason(wt))
+	reason = worktree_lock_reason(wt);
+	if (reason)
 		strbuf_addstr(&sb, " locked");
 
+	reason = worktree_prune_reason(wt, expire);
+	if (reason)
+		strbuf_addstr(&sb, " prunable");
+
 	printf("%s\n", sb.buf);
 	strbuf_release(&sb);
 }
@@ -663,9 +673,12 @@ static int list(int ac, const char **av, const char *prefix)
 
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
index c522190feb..e9b410b69e 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -103,6 +103,38 @@ test_expect_success '"list" all worktrees --porcelain with locked reason newline
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
2.30.0.372.gbc7e965391

