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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121F0C433E0
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA95020769
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbhADQXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 11:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbhADQXH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 11:23:07 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A30C06179F
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 08:22:21 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id w1so37497497ejf.11
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 08:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=20MuWJcDUdUJggPiKq2RTg+GTfdVam2cdrzyU6abDoY=;
        b=ehUqYfDkfOmLY3EL8+SI1BAnqyfMbT1yns135wpkKCHte4uaNRy0y6hWW+DsTL1aCu
         YGJYRP5XggfSJn+80OEZmNd5rreFwlrK866R0Vrc3SpR0oUrmDEi07wnfwB8Dmx+BFNr
         FP6KI8QghokWNbPtdo8hj3AeAsc3HDwJSSRpop0o03/jSleqiNryfyyWCgCzgfMGGs0Z
         4iEB/ZH1TAd+SUZt5Gu6hXe5G1fseeZ/XIbw11AAMx1BsOlMWvEDnx965Gm/2iCujOMa
         c4OKwqxiib41TdOudzDMMa1N0bZYGhJkJvDCPjAw5TWFkKrTQE/39KeOGREDpjhoQ3WH
         tfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20MuWJcDUdUJggPiKq2RTg+GTfdVam2cdrzyU6abDoY=;
        b=lMMknarFnP/eJ1CjrQMrh4/aRfT2z8QycleZFyqCWSgeFEyeiY0FbSCI1p2FC7ydiy
         q1jLZfnIB8znBzj7hKu0ElTnVdq++RgYdjBz+xB4qlqpMezoHDgCBkg67aY3a/LFiTjT
         zt38VdS3AnTDH09jKxOt1RgjNS56AmELiPi/0jlawVKYLPgdLY44/nMEcGVXrgZDMgV8
         UbvZHdBjOm6n50iTXyJL/gXwsyL2FwqcuDZU0PXPbbUcY2rgqk7vRom8MviILMlrvRZU
         aTKncmsAplrNQ6HZ5D3qoPnUQz6JAuC6fGiqrSDopPmfXjShAw+YwCtKiy4oCP6yqk6Z
         n47w==
X-Gm-Message-State: AOAM5307/KbPo1wgECSHAXOxV1QkDs7rl5lXuvGU75eFeUQ9ToWLZw6w
        Olei+2ffp93tCSHu3ZRdTAWXyJoc/Tw=
X-Google-Smtp-Source: ABdhPJx5d4x0yOZTPl6k087xmKiC5mpxE0GMyf6tJWmNHbZXW2qi5pbcIWTxQW/9UciY1cjHp5FEHg==
X-Received: by 2002:a17:906:f1c8:: with SMTP id gx8mr68266587ejb.524.1609777339708;
        Mon, 04 Jan 2021 08:22:19 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.191])
        by smtp.gmail.com with ESMTPSA id bn21sm23931677ejb.47.2021.01.04.08.22.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 08:22:19 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH 4/7] worktree: teach `list` prunable annotation and verbose
Date:   Mon,  4 Jan 2021 17:21:25 +0100
Message-Id: <20210104162128.95281-5-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.391.g469bf2a980
In-Reply-To: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git worktree list" command shows the absolute path to the worktree,
the commit that is checked out, the name of the branch, and a "locked"
annotation if the worktree is locked. It is not clear whether a worktree,
if any, is prunable. The "prune" command will remove a worktree in case
is a prunable candidate unless --dry-run option is specified. This could
lead to a worktree being removed without the user realizing before is to
late, in case the user forgets to pass --dry-run for instance.

If the "list" command shows which worktree is prunable, the user could
verify before running "git worktree prune" and hopefully prevents the
working tree to be removed "accidently" on the worse case scenario.

Let's teach "git worktree list" to show when a worktree is prunable by
appending "prunable" text to its output by default and show a prunable
label for the porcelain format followed by the reason, if the avaiable.
While at it, let's do the same for the "locked" annotation.

Also, the worktree_prune_reason() stores the reason why git is selecting
the worktree to be pruned, so let's leverage that and also display this
information to the user. However, the reason is human readable text that
can take virtually any size which might make harder to extend the "list"
command with additional annotations and not fit nicely on the screen.

In order to address this shortcoming, let's teach "git worktree list" to
take a verbose option that will output the prune reason on the next line
indented, if the reason is available, otherwise the annotation is kept on
the same line. While at it, let's do the same for the "locked"
annotation.

The output of "git worktree list" with verbose becomes like so:

    $ git worktree list --verbose
    /path/to/main	      aba123 [main]
    /path/to/locked           acb124 [branch-a] locked
    /path/to/locked-reason    acc125 [branch-b]
        locked: worktree with locked reason
    /path/to/prunable         acd126 [branch-c] prunable
    /path/to/prunable-reason  ace127 [branch-d]
        prunable: gitdir file points to non-existent location

And the output of the "git worktree list --porcelain" becomes like so:

    $ git worktree list --porcelain
    worktree /path/to/main
    HEAD abc1234abc1234abc1234abc1234abc1234abc12
    branch refs/heads/main

    worktree /path/to/linked
    HEAD 123abc456def789abc1234def5678abc9123abce
    branch refs/heads/linked

    worktree /path/to/locked
    HEAD 123abcdea123abcd123acbd123acbda123abcd12
    detached
    locked lock reason

    worktree /path/to/prunable
    HEAD def1234def1234def1234def1234def1234def1a
    detached
    prunable prunable reason

Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 builtin/worktree.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index eeb3ffaed0..dedd4089e5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -578,6 +578,20 @@ static void show_worktree_porcelain(struct worktree *wt)
 			printf("detached\n");
 		else if (wt->head_ref)
 			printf("branch %s\n", wt->head_ref);
+
+		if (worktree_lock_reason(wt)) {
+			if (*wt->lock_reason)
+				printf("locked %s\n", wt->lock_reason);
+			else
+				printf("locked\n");
+		}
+
+		if (worktree_prune_reason(wt, expire)) {
+			if (*wt->prune_reason)
+				printf("prunable %s\n", wt->prune_reason);
+			else
+				printf("prunable\n");
+		}
 	}
 	printf("\n");
 }
@@ -604,8 +618,19 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 			strbuf_addstr(&sb, "(error)");
 	}
 
-	if (!is_main_worktree(wt) && worktree_lock_reason(wt))
-		strbuf_addstr(&sb, " locked");
+	if (worktree_lock_reason(wt)) {
+		if (verbose && *wt->lock_reason)
+			strbuf_addf(&sb, "\n\tlocked: %s", wt->lock_reason);
+		else
+			strbuf_addstr(&sb, " locked");
+	}
+
+	if (worktree_prune_reason(wt, expire)) {
+		if (verbose && *wt->prune_reason)
+			strbuf_addf(&sb, "\n\tprunable: %s", wt->prune_reason);
+		else
+			strbuf_addstr(&sb, " prunable");
+	}
 
 	printf("%s\n", sb.buf);
 	strbuf_release(&sb);
@@ -650,12 +675,18 @@ static int list(int ac, const char **av, const char *prefix)
 
 	struct option options[] = {
 		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
+		OPT__VERBOSE(&verbose, N_("show extended annotations and reasons, if available")),
+		OPT_EXPIRY_DATE(0, "expire", &expire,
+				N_("show working trees that is candidate to be pruned older than <time>")),
 		OPT_END()
 	};
 
+	expire = TIME_MAX;
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (ac)
 		usage_with_options(worktree_usage, options);
+	else if (verbose && porcelain)
+		die(_("--verbose and --porcelain are mutually exclusive"));
 	else {
 		struct worktree **worktrees = get_worktrees();
 		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
-- 
2.30.0.391.g469bf2a980

