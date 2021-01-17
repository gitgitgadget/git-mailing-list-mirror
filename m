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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363D9C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090F9206E3
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbhAQXqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 18:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730812AbhAQXpR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 18:45:17 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9298C0613D3
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 15:43:53 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b2so15603290edm.3
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 15:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SOeYEV1l4UGxmmPE1qm8HksHMQZQ1y7UY8p0OvtGauc=;
        b=iOver2l97x3KpEAmmadVkE8euwYrRlmQHc8oXKr5VAVH4qyHxTt27qgVEDDMI86IA7
         bWFaC0cIhSDhY8SUYS9+NmAXmAA+cwsd3DWW9eWdQWNUQxA6UwG0UKDf2Fg0DNGCXs6l
         +QAKNRIf2VBoYN+ylveX0IGf7d0qQyQGAdjS1gRiQ6cDURbiybKiW5clhsOs4Bg02T4e
         T7iSkaoXYX3zjRAuyGiJUjbcAu00s+xv/m/QJCpH3eEEEkJWXCnjdycu8WiI0yzljOD8
         xN8eMPl+gTSxtoKZKOOqzRjnYxcwT2z+PnnWfdXIyS6n5oZ5lJ6iBPfudnzCVykFwvTj
         +Aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SOeYEV1l4UGxmmPE1qm8HksHMQZQ1y7UY8p0OvtGauc=;
        b=BHcX2woVUvL5fdf+rPYfX8c9szfAcL7n+Hecx0umL8xFQpEoQxdtS2jg0YuEH2fb5y
         f2rzyNZ/bWCJYNAIumdrxMVx3UArgizFUTbzSmhiI4aGqLeEQtWrEtyLvZO0dSQIeMGg
         hFMEHc0MXslvPLt/mMlq6h9NRlmZ2mSzIEd4zFGfuntfS3ImeDjHiHTaUEMihj1exVRY
         f9hDcS/5rTmqaBONcdtUQyQu7Q9ZGBVlUfmgXlXLx7QHjzPJK7g4uTShULq+X75dLVN0
         1UGRa0/DM/ZSK00QcdsFGrPj2nwTrbnUbn13jNFldlorFk38I7Ay3dMlG+PbQjZg3ZIg
         l+6g==
X-Gm-Message-State: AOAM533CgOwLx7CX5GfxDLEfd58jDi9zgbaCI3uYPUGgSL3xHlHS7/oP
        wVOz4TCLKLBxo9yaXaKTZZ+54YeOCDI=
X-Google-Smtp-Source: ABdhPJyLSWCiCsibk4aTLM7m4vcSa5lGaJxzrfY+Sdk3FAPev6/oqcRsUJgKASHiiEt2UzBu38YP1Q==
X-Received: by 2002:aa7:c94a:: with SMTP id h10mr17289118edt.247.1610927032143;
        Sun, 17 Jan 2021 15:43:52 -0800 (PST)
Received: from localhost.localdomain ([79.140.114.246])
        by smtp.gmail.com with ESMTPSA id f13sm8639932ejf.42.2021.01.17.15.43.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 15:43:51 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v2 6/6] worktree: teach `list` verbose mode
Date:   Mon, 18 Jan 2021 00:42:44 +0100
Message-Id: <20210117234244.95106-7-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.372.gbc7e965391
In-Reply-To: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git worktree list" annotates each worktree according to its state such
as "prunable" or "locked", however it is not immediately obvious why
these worktrees are being annotated. For prunable worktrees a reason
is available that is returned by should_prune_worktree() and for locked
worktrees a reason might be available provided by the user via `lock`
command.

Let's teach "git worktree list" to output the reason why the worktrees
are being annotated. The reason is a text that can take virtually any
size and appending the text on the default columned format will make it
difficult to extend the command with other annotations and not fit nicely
on the screen. In order to address this shortcoming the annotation is
then moved to the next line indented followed by the reason, if the
reason is not available the annotation stays on the same line as the
worktree itself.

The output of "git worktree list" with verbose becomes like so:

    $ git worktree list --verbose
    ...
    /path/to/locked                acb124 [branch-a] locked
    /path/to/locked-with-reason    acc125 [branch-b]
        locked: worktree with a locked reason
    /path/to/prunable-reason       ace127 [branch-d]
        prunable: gitdir file points to non-existent location
    ...

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 Documentation/git-worktree.txt | 20 ++++++++++++++++++++
 builtin/worktree.c             | 11 +++++++++--
 t/t2402-worktree-list.sh       | 27 +++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 3d8c14dbdf..d34bf121f3 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -232,6 +232,8 @@ This can also be set up as the default behaviour by using the
 -v::
 --verbose::
 	With `prune`, report all removals.
++
+With `list`, output additional information about worktrees (see below).
 
 --expire <time>::
 	With `prune`, only expire unused working trees older than `<time>`.
@@ -389,6 +391,24 @@ $ git worktree list
 /path/to/prunable-worktree      5678abc  (detached HEAD) prunable
 ------------
 
+For these annotations, a reason might also be available and this can be
+seen using the verbose mode. The annotation is then moved to the next line
+indented followed by the additional information.
+
+------------
+$ git worktree list --verbose
+/path/to/linked-worktree        abcd1234 [master]
+/path/to/locked-worktreee       acbd5678 (brancha)
+	locked: working tree path is mounted on a removable device
+/path/to/locked-no-reason       abcd578  (detached HEAD) locked
+/path/to/prunable-worktree      5678abc  (detached HEAD)
+	prunable: gitdir file points to non-existent location
+------------
+
+Note that the annotation is moved to the next line if the additional
+information is available, otherwise it stays on the same line as the
+working tree itself.
+
 Porcelain Format
 ~~~~~~~~~~~~~~~~
 The porcelain format has a line per attribute.  Attributes are listed with a
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fb82d7bb64..a59cbfa0d2 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -623,11 +623,15 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 	}
 
 	reason = worktree_lock_reason(wt);
-	if (reason)
+	if (verbose && reason && *reason)
+		strbuf_addf(&sb, "\n\tlocked: %s", reason);
+	else if (reason)
 		strbuf_addstr(&sb, " locked");
 
 	reason = worktree_prune_reason(wt, expire);
-	if (reason)
+	if (verbose && reason && *reason)
+		strbuf_addf(&sb, "\n\tprunable: %s", reason);
+	else if (reason)
 		strbuf_addstr(&sb, " prunable");
 
 	printf("%s\n", sb.buf);
@@ -673,6 +677,7 @@ static int list(int ac, const char **av, const char *prefix)
 
 	struct option options[] = {
 		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
+		OPT__VERBOSE(&verbose, N_("show extended annotations and reasons, if available")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
 				N_("add 'prunable' annotation to worktrees older than <time>")),
 		OPT_END()
@@ -682,6 +687,8 @@ static int list(int ac, const char **av, const char *prefix)
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (ac)
 		usage_with_options(worktree_usage, options);
+	else if (verbose && porcelain)
+		die(_("--verbose and --porcelain are mutually exclusive"));
 	else {
 		struct worktree **worktrees = get_worktrees();
 		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index e9b410b69e..4de37f896c 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -135,6 +135,33 @@ test_expect_success '"list" all worktrees with prunable consistent with "prune"'
 	test_i18ngrep ! "^Removing worktrees/unprunable" out
 '
 
+test_expect_success '"list" --verbose and --porcelain mutually exclusive' '
+	test_must_fail git worktree list --verbose --porcelain
+'
+
+test_expect_success '"list" all worktrees --verbose with locked' '
+	test_when_finished "rm -rf locked out actual expect && git worktree prune" &&
+	git worktree add locked --detach &&
+	git worktree lock locked --reason "with reason" &&
+	test_when_finished "git worktree unlock locked" &&
+	echo "$(git -C locked rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >expect &&
+	printf "\tlocked: with reason\n" >>expect &&
+	git worktree list --verbose >out &&
+	sed -n "s/  */ /g;/\/locked  *[0-9a-f].*$/,/locked: .*$/p" <out >actual &&
+	test_cmp actual expect
+'
+
+test_expect_success '"list" all worktrees --verbose with prunable' '
+	test_when_finished "rm -rf prunable out actual expect && git worktree prune" &&
+	git worktree add prunable --detach &&
+	echo "$(git -C prunable rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >expect &&
+	printf "\tprunable: gitdir file points to non-existent location\n" >>expect &&
+	rm -rf prunable &&
+	git worktree list --verbose >out &&
+	sed -n "s/  */ /g;/\/prunable  *[0-9a-f].*$/,/prunable: .*$/p" <out >actual &&
+	test_i18ncmp actual expect
+'
+
 test_expect_success 'bare repo setup' '
 	git init --bare bare1 &&
 	echo "data" >file1 &&
-- 
2.30.0.372.gbc7e965391

