Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D59C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B84613B1
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbhHXVyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbhHXVxg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:53:36 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F46EC0617AD
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:52:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x12so33319491wrr.11
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TW6UFTzZ+QULGGc8KN5tLIiTgHZXppX2ImGqtUqI5sQ=;
        b=BtojbLJMna2sw9Sy3puGliRicfg2kB0t99dFEGUu2AMjJyMPfXAw7wmveE3Gn/TMRR
         4QnYxBiGcZQDnH/k5LtRDKOa6hMyAeXZs3SbbxmVIJNA3hOFUPcWciqFYOC8FbZ3l5Tp
         NPefoasBzkYVC11sb3Kl773HjanTYk6Pguj+RQN0VKua/exrpAOyF4mflFWi4tfwLrMT
         iKwT8682dmeFib30HhdkBB+pntLqma2SAS+3deN58rvFdBPQR9CWgtAR+vVYkIa/E5MZ
         iSi9guXTLQhfbXYwkRTf9PoacU2+xGQBxYDUNSlPmYrrPXUMXtqsfnTbbJXMSaYaTZLN
         a9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TW6UFTzZ+QULGGc8KN5tLIiTgHZXppX2ImGqtUqI5sQ=;
        b=r8NsTLw+Ts0mv/TMDM0uHW/mMCOFP/Wnl8lCmKEXjnbSed+O5Wyhs/ezTB16hQPAe/
         /v6n62jAQeQNwb509X+Lb1u9hxbb7zmX1aefjWjNFEyHUugxRiPVFDLu3Y1G2Y6TP71M
         +nmXpNjD95HePyxmU2xerjh0RgUfLeFfSG6ZA/kO9fzFj85yOOYfqUP9F9LfTey1Kn7H
         //JYD/+RHBMFqHPsudfff0r5pUE7eqGGZXs5anObcGtU+vQYwG65xXa63C3POhsYe5Tb
         OLnrYl8n95cjyk9cow6I8wD0b33tzsKS0sla//fZxBGMwfAlKIK6RheX2qCTFGqunn3N
         vOFQ==
X-Gm-Message-State: AOAM532Zk7gmqZUnFuUHEfFjogjmOj9D+7Q9XDhI4qk6FD1P/QWvbEvk
        YrLkgUoqwhI8Zh23jfyAeV5Gmmz6iQM=
X-Google-Smtp-Source: ABdhPJzRDeokGk1fMTUtz2InsFTFBQEHuj9fJ/Q6Ir6r6z1V5ZyAAejAZwKu/7ix1CFjip9FlnGw5A==
X-Received: by 2002:adf:8102:: with SMTP id 2mr20764229wrm.89.1629841969924;
        Tue, 24 Aug 2021 14:52:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h6sm3998610wmq.5.2021.08.24.14.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:52:49 -0700 (PDT)
Message-Id: <90ac85500b822601dd6283bb1fd04406b0e2e461.1629841966.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
        <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:52:44 +0000
Subject: [PATCH v2 5/6] sequencer: ensure full index if not ORT strategy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com, gitster@pobox.com,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The sequencer is used by 'cherry-pick' and 'rebase' to sequence a list
of operations that modify the index. Since we intend to remove the need
for 'command_requires_full_index', we need to ensure the sparse index is
expanded every time it is written to disk between these steps. That is,
unless the merge strategy is 'ort' where the index can remain sparse
throughout.

There are two main places to be extra careful about a full index:

1. Right before calling merge_trees(), ensure the index is full. This
   happens within an 'else' where the 'if' block checks if the 'ort'
   strategy is selected.

2. During read_and_refresh_cache(), the index might be written to disk
   and converted to sparse in the process. Ensure it expands back to
   full afterwards by checking if the strategy is _not_ 'ort'. This
   'if' statement is the logical negation of the 'if' in item (1).

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sequencer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 7f07cd00f3f..228bc089d22 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -652,6 +652,7 @@ static int do_recursive_merge(struct repository *r,
 		merge_switch_to_result(&o, head_tree, &result, 1, show_output);
 		clean = result.clean;
 	} else {
+		ensure_full_index(r->index);
 		clean = merge_trees(&o, head_tree, next_tree, base_tree);
 		if (is_rebase_i(opts) && clean <= 0)
 			fputs(o.obuf.buf, stdout);
@@ -2346,6 +2347,7 @@ static int read_and_refresh_cache(struct repository *r,
 			_(action_name(opts)));
 	}
 	refresh_index(r->index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
+
 	if (index_fd >= 0) {
 		if (write_locked_index(r->index, &index_lock,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED)) {
@@ -2353,6 +2355,13 @@ static int read_and_refresh_cache(struct repository *r,
 				_(action_name(opts)));
 		}
 	}
+
+	/*
+	 * If we are resolving merges in any way other than "ort", then
+	 * expand the sparse index.
+	 */
+	if (opts->strategy && strcmp(opts->strategy, "ort"))
+		ensure_full_index(r->index);
 	return 0;
 }
 
-- 
gitgitgadget

