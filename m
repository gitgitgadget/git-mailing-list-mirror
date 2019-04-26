Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93FCD1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 10:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfDZKcr (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 06:32:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34952 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZKcr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 06:32:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so3693690wmd.0
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 03:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=aj603BbP3dcJD6v107ySMoM2YytB74mKpA7jCVmeJ8k=;
        b=o9roK5LYZnilJbA5JL0xL2nGeFFkXrWPQDXCh38MpC9qcrrAMofof5ZJYxMD9X34VA
         6o25Nckobua3k+tqg6frF0R8HfcELSWft0aHPo3ybXeQBoQ1yaj5FyImECZ5RUp3ijbC
         5owhzOThrZPaCXVgJYhxmxxN6BjMaBvApCIh+Beffsio0TtiVF0MKnDANZetKzkHdKKe
         ZpnGoTq/JyMadvAuEd1MwY7T3AOJBY0AFxjsllQiYItDGRjYmEcOJmi8GqjsbbCewRDG
         PVGHEQ7FR2+GXj65akWYW90anKbZ4n8mehoDaov33RF0pa8nIHmau7Spp7FW56PpwZKh
         Hlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=aj603BbP3dcJD6v107ySMoM2YytB74mKpA7jCVmeJ8k=;
        b=l50I21FHULQ58bFn5VPpy2C1KWJXwxQxgR4I1WjLkYaBtOlTNh1H3ErSoOzqksPryP
         UHADyta91DJHsSWkYMknw/bd1OAA+kykhG4d9dlGGMhRNaNrlAAcx90GeH1Wjsdv5IxJ
         /5LVJhcj/jOJgWO2oNjb6GV+sxlFZQumj6FnoWbd1hOAQXx6l5xibaBjE9D8XhzwY10t
         0Uqic2hiSsDnvdFczRPvF2OXg3pAO5jc8/AVxocKx098uUmjqOMVDF1dPfxjsjVAeGZf
         fWOlK4AQMXJljkACW7xfCuSrQiFQe/dLITXq0PcUjYJLARWQwdPf72AEx2Z6Sm3pPKT+
         r2yQ==
X-Gm-Message-State: APjAAAUb5ozFvcd39GlnUJp4aBIjemo9WhpJITzvC3HPdFuPgtQpBYEV
        FJ8w6UNPZZAkjoYv6fmvQPkxByRMdgc=
X-Google-Smtp-Source: APXvYqyzUNsxZv/YCTs5Hy1o4Ey3BVyFm/+9jckujdCoDUzvlVgLwuQCdmVfrxoKmrxTA4rUt5wnYQ==
X-Received: by 2002:a1c:4602:: with SMTP id t2mr7029995wma.120.1556274765429;
        Fri, 26 Apr 2019 03:32:45 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id q8sm21543910wmq.35.2019.04.26.03.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 03:32:44 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] rebase --abort: cleanup refs/rewritten
Date:   Fri, 26 Apr 2019 11:32:12 +0100
Message-Id: <20190426103212.8097-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When `rebase -r` finishes it removes any refs under refs/rewritten
that it has created. However if the rebase is aborted these refs are
not removed. This can cause problems for future rebases. For example I
recently wanted to merge a updated version of a topic branch into an
integration branch so ran `rebase -ir` and removed the picks and label
for the topic branch from the todo list so that
    merge -C <old-merge> topic
would pick up the new version of topic. Unfortunately
refs/rewritten/topic already existed from a previous rebase that had
been aborted so the rebase just used the old topic, not the new one.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    This is based on pw/rebase-i-internal, it would be nicer to base it on
    maint but there are function name clashes adding sequencer.h to rebase.c
    an maint. Those clashes are fixed in pw/rebase-i-internal

 builtin/rebase.c         | 13 ++++++++++---
 t/t3430-rebase-merges.sh |  8 ++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 82bd50a1b4..e2e49c8239 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -761,9 +761,16 @@ static int finish_rebase(struct rebase_options *opts)
 	 * user should see them.
 	 */
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
-	strbuf_addstr(&dir, opts->state_dir);
-	remove_dir_recursively(&dir, 0);
-	strbuf_release(&dir);
+	if (opts->type == REBASE_INTERACTIVE) {
+		struct replay_opts replay = REPLAY_OPTS_INIT;
+
+		replay.action = REPLAY_INTERACTIVE_REBASE;
+		sequencer_remove_state(&replay);
+	} else {
+		strbuf_addstr(&dir, opts->state_dir);
+		remove_dir_recursively(&dir, 0);
+		strbuf_release(&dir);
+	}
 
 	return 0;
 }
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 4c69255ee6..6ebebf7098 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -224,6 +224,14 @@ test_expect_success 'refs/rewritten/* is worktree-local' '
 	test_cmp_rev HEAD "$(cat wt/b)"
 '
 
+test_expect_success '--abort cleans up refs/rewritten' '
+	git checkout -b abort-cleans-refs-rewritten H &&
+	GIT_SEQUENCE_EDITOR="echo break >>" git rebase -ir @^ &&
+	git rev-parse --verify refs/rewritten/onto &&
+	git rebase --abort &&
+	test_must_fail git rev-parse --verify refs/rewritten/onto
+'
+
 test_expect_success 'post-rewrite hook and fixups work for merges' '
 	git checkout -b post-rewrite &&
 	test_commit same1 &&
-- 
2.21.0

