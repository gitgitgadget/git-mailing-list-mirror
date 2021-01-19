Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A8BC433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 21:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C410822D71
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 21:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbhASV33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 16:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbhASV3K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 16:29:10 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53802C061798
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 13:28:23 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so17683904wrt.5
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 13:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/2PrOHyTI6gxfTo8gpNiD6wTjUB3W3eT/kuLDYeiwMA=;
        b=uQP/zfSeqxE8CH68CnL8m4XYlYoml7DMYpWzzRFzRplPQYgzGAg8k1w3Yql5s4QMnW
         EwBmeUBG3XH1wKq+vrxJ3Aa6ySTv4WRgaHjEU8XROccHA4Bn1OsmOad1QX7dN0Zyj18s
         vx3/easHib6fWCCFsKOOBt262nGUj00jadrXimIBxq62FhRngIvpIblpwqNoJ6t/hLSq
         wZAqtA2daXhEfOCNKZERCBOiLll9bdrn6/YX5jdYuqvAlPDuwI3DsuVy4SYFyXvcOhvZ
         QaPa326OUA/auxrq8uFiwd3T+2SJfxBeULfXcm3+D5rm/AO0OA7j4thpcQMtVJHo626a
         zzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/2PrOHyTI6gxfTo8gpNiD6wTjUB3W3eT/kuLDYeiwMA=;
        b=l1BjMsTStUFRpK5MyLzsOo+JRN9i88zyYVeharJXZUAm60dh1nqbbOakgGg9vz4BPq
         GCYp7Owf8F8/aak73eTNBefGpVJ74SgF7ZhiuYTbYtumEHZq3hroHA9sL1WMtWBJ72+2
         gtBysrmkIrlvjFN7YNpmoeKoQWyXJZeASrJEFY6AbwIypcK1Zq0/4Nh1ebbrdUKPQtZh
         5jN3aJQCR+9FMeAN6h16LbVky3K9xvbimlHpvm/S8gmfroklwPplg3QrtnqLfQnwxpeq
         y9FghwH4X+8vuB0l8SqfYzvel0TV2TSi1aWrw30E7yfzJ8TiL6jnTYc0SlSbdSUvpIQT
         AHCQ==
X-Gm-Message-State: AOAM531fNQ3bUecrcCx7M/J9zIuXmn7LEAT/nbtXCF7P9AFYkR6R/jft
        WzURkK5WlHMjL5OKdaS2HS51LTRhbEI=
X-Google-Smtp-Source: ABdhPJwyukofulQeVlDhDIFXp4I43WdqqAcDmcCISQnNHbBTmVpf9/mrTt8Oilu/ZIqUGJtwvxDgzA==
X-Received: by 2002:a5d:6a05:: with SMTP id m5mr6066653wru.96.1611091701788;
        Tue, 19 Jan 2021 13:28:21 -0800 (PST)
Received: from localhost.localdomain ([212.86.35.161])
        by smtp.gmail.com with ESMTPSA id r2sm39448819wrn.83.2021.01.19.13.28.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 13:28:21 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v3 7/7] worktree: teach `list` verbose mode
Date:   Tue, 19 Jan 2021 22:27:39 +0100
Message-Id: <20210119212739.77882-8-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.421.g32f838e276
In-Reply-To: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
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

Let's teach "git worktree list" a --verbose mode that outputs the reason
why the worktrees are being annotated. The reason is a text that can take
virtually any size and appending the text on the default columned format
will make it difficult to extend the command with other annotations and
not fit nicely on the screen. In order to address this shortcoming the
annotation is then moved to the next line indented followed by the reason
If the reason is not available the annotation stays on the same line as
the worktree itself.

The output of "git worktree list" with verbose becomes like so:

    $ git worktree list --verbose
    ...
    /path/to/locked-no-reason    acb124 [branch-a] locked
    /path/to/locked-with-reason  acc125 [branch-b]
        locked: worktree with a locked reason
    /path/to/prunable-reason     ace127 [branch-d]
        prunable: gitdir file points to non-existent location
    ...

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 Documentation/git-worktree.txt | 20 ++++++++++++++++++++
 builtin/worktree.c             | 14 ++++++++++++--
 t/t2402-worktree-list.sh       | 30 ++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index e0dd291e30..27f79ce638 100644
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
 /path/to/prunable-worktree  5678abc  (detached HEAD) prunable
 ------------
 
+For these annotations, a reason might also be available and this can be
+seen using the verbose mode. The annotation is then moved to the next line
+indented followed by the additional information.
+
+------------
+$ git worktree list --verbose
+/path/to/linked-worktree              abcd1234 [master]
+/path/to/locked-worktree-no-reason    abcd5678 (detached HEAD) locked
+/path/to/locked-worktree-with-reason  1234abcd (brancha)
+	locked: working tree path is mounted on a portable device
+/path/to/prunable-worktree            5678abc1 (detached HEAD)
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
index 20944c266e..1cd5c2016e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -604,6 +604,7 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 	struct strbuf sb = STRBUF_INIT;
 	int cur_path_len = strlen(wt->path);
 	int path_adj = cur_path_len - utf8_strwidth(wt->path);
+	const char *reason;
 
 	strbuf_addf(&sb, "%-*s ", 1 + path_maxlen + path_adj, wt->path);
 	if (wt->is_bare)
@@ -621,10 +622,16 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 			strbuf_addstr(&sb, "(error)");
 	}
 
-	if (worktree_lock_reason(wt))
+	reason = worktree_lock_reason(wt);
+	if (verbose && reason && *reason)
+		strbuf_addf(&sb, "\n\tlocked: %s", reason);
+	else if (reason)
 		strbuf_addstr(&sb, " locked");
 
-	if (worktree_prune_reason(wt, expire))
+	reason = worktree_prune_reason(wt, expire);
+	if (verbose && reason)
+		strbuf_addf(&sb, "\n\tprunable: %s", reason);
+	else if (reason)
 		strbuf_addstr(&sb, " prunable");
 
 	printf("%s\n", sb.buf);
@@ -670,6 +677,7 @@ static int list(int ac, const char **av, const char *prefix)
 
 	struct option options[] = {
 		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
+		OPT__VERBOSE(&verbose, N_("show extended annotations and reasons, if available")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
 				N_("add 'prunable' annotation to worktrees older than <time>")),
 		OPT_END()
@@ -679,6 +687,8 @@ static int list(int ac, const char **av, const char *prefix)
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (ac)
 		usage_with_options(worktree_usage, options);
+	else if (verbose && porcelain)
+		die(_("--verbose and --porcelain are mutually exclusive"));
 	else {
 		struct worktree **worktrees = get_worktrees();
 		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 9e342d6c66..6346cd38a8 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -134,6 +134,36 @@ test_expect_success '"list" all worktrees with prunable consistent with "prune"'
 	test_i18ngrep ! "^Removing worktrees/unprunable" out
 '
 
+test_expect_success '"list" --verbose and --porcelain mutually exclusive' '
+	test_must_fail git worktree list --verbose --porcelain
+'
+
+test_expect_success '"list" all worktrees --verbose with locked' '
+	test_when_finished "rm -rf locked1 locked2 out actual expect && git worktree prune" &&
+	git worktree add locked1 --detach &&
+	git worktree add locked2 --detach &&
+	git worktree lock locked1 &&
+	git worktree lock locked2 --reason "with reason" &&
+	test_when_finished "git worktree unlock locked1 && git worktree unlock locked2" &&
+	echo "$(git -C locked2 rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >expect &&
+	printf "\tlocked: with reason\n" >>expect &&
+	git worktree list --verbose >out &&
+	grep "/locked1  *[0-9a-f].* locked$" out &&
+	sed -n "s/  */ /g;/\/locked2  *[0-9a-f].*$/,/locked: .*$/p" <out >actual &&
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
2.30.0.421.g32f838e276

