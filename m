Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235071F403
	for <e@80x24.org>; Sun, 17 Jun 2018 05:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeFQFhM (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 01:37:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43425 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeFQFhL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 01:37:11 -0400
Received: by mail-oi0-f68.google.com with SMTP id t133-v6so12168819oif.10
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 22:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VoC9X0yLSpjJjZ/tbGTzWj2Q8LG69P2a25wzRVD3cZE=;
        b=CH01I8DdcV5lbCRQ1XsUWi3CZe5EnzpvsYrvqzRJvI/8cZmfnPqv7WzZN0qYIAMA4K
         5J00TxTQ37YR2VRnOT6lxq4VI8vSokTJ6sfehbNObE0pepbCdX/SKr0L5sojDPzU5zSd
         KgHVxlvA+oSxAjD/2rdL1Un1fWdtT76sy21ki+MCcOK1zLBbG6ziTqM9KWL1m6Nbb+Qs
         V8zF2gxXRz0/GHsdAcpn8FcAP1z317dZU6889BORFmYqmND85TmmpHfMOkdSyvM3wTTr
         mbbeyI5vJRo399RQTk2Kb8+6FErtwFlyra2NwcZ+AEFd6KRms1MBTR6e7PyjZU9KmSjp
         Liag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VoC9X0yLSpjJjZ/tbGTzWj2Q8LG69P2a25wzRVD3cZE=;
        b=NXcKD888sfTWMEfPLXZYDX3oBUW37QTFxAY6dXu/PaYeauT2Owg8K4gPL3gJeOXjpU
         4Ox/cJmDgU9MgjvOC3SWUPVucnpz4vIP/r+IDiUAjDXMGFMFPPJxz/+KAA/Qu5/EviMU
         vSKZcIdFSgRWxUZPLO2g9rd+qpHyYFdD5p2gn9NAu/Bz36DQeJSdVd9RVTK4HxaoBBGr
         vjjmwXVHr0fS401H7I3L2MRH1WOHyg1QveRSnraEa9KsNyo5TN3/2LRnutCH0wWG8rmj
         2RTwe7/iruooirEgwCVgkAtCzmqrAkAKril829d/fzesUhvvTR47TT2ykz9sbs1Y+ORz
         Yk+A==
X-Gm-Message-State: APt69E1NQlDdJcSO38Gpj07DfD3LffobMdF95QWytNqemISqLTm/Zi7z
        OjuUrvL3S1B4342crY4jjJU=
X-Google-Smtp-Source: ADUXVKLABBEFvp9qLy3DtAz3zbvtmYrxoQ3m5se+7M4uMGzHhN4xndCUp8thc7Ta9uNuD72iIHikGA==
X-Received: by 2002:aca:d708:: with SMTP id o8-v6mr4104383oig.205.1529213830536;
        Sat, 16 Jun 2018 22:37:10 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id k133-v6sm5222244oia.36.2018.06.16.22.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 22:37:09 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ch <cr@onlinehome.de>, johannes.schindelin@gmx.de,
        git@vger.kernel.org, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2] sequencer: do not squash 'reword' commits when we hit conflicts
Date:   Sat, 16 Jun 2018 22:37:03 -0700
Message-Id: <20180617053703.19856-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.1.g5453d3f70b.dirty
In-Reply-To: <CAPig+cRKxpNrTNSEgB66LBxcJk1b24ViR=T-fkqo07wxMFywpQ@mail.gmail.com>
References: <CAPig+cRKxpNrTNSEgB66LBxcJk1b24ViR=T-fkqo07wxMFywpQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since commit 18633e1a22 ("rebase -i: use the rebase--helper builtin",
2017-02-09), when a commit marked as 'reword' in an interactive rebase
has conflicts and fails to apply, when the rebase is resumed that commit
will be squashed into its parent with its commit message taken.

The issue can be understood better by looking at commit 56dc3ab04b
("sequencer (rebase -i): implement the 'edit' command", 2017-01-02), which
introduced error_with_patch() for the edit command.  For the edit command,
it needs to stop the rebase whether or not the patch applies cleanly.  If
the patch does apply cleanly, then when it resumes it knows it needs to
amend all changes into the previous commit.  If it does not apply cleanly,
then the changes should not be amended.  Thus, it passes !res (success of
applying the 'edit' commit) to error_with_patch() for the to_amend flag.

The problematic line of code actually came from commit 04efc8b57c
("sequencer (rebase -i): implement the 'reword' command", 2017-01-02).
Note that to get to this point in the code:
  * !!res (i.e. patch application failed)
  * item->command < TODO_SQUASH
  * item->command != TODO_EDIT
  * !is_fixup(item->command) [i.e. not squash or fixup]
So that means this can only be a failed patch application that is either a
pick, revert, or reword.  For any of those cases we want a new commit, so
we should not set the to_amend flag.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Differences since v1 (Thanks to Eric Sunshine for the suggestions):
  * Add test_when_finished "reset_rebase" calls
  * Remove unnecessary word from description of test

 sequencer.c              |  2 +-
 t/t3423-rebase-reword.sh | 48 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100755 t/t3423-rebase-reword.sh

diff --git a/sequencer.c b/sequencer.c
index cca968043e..9e6d1ee368 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3217,7 +3217,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			} else if (res && is_rebase_i(opts) && item->commit)
 				return res | error_with_patch(item->commit,
 					item->arg, item->arg_len, opts, res,
-					item->command == TODO_REWORD);
+					0);
 		} else if (item->command == TODO_EXEC) {
 			char *end_of_arg = (char *)(item->arg + item->arg_len);
 			int saved = *end_of_arg;
diff --git a/t/t3423-rebase-reword.sh b/t/t3423-rebase-reword.sh
new file mode 100755
index 0000000000..6963750794
--- /dev/null
+++ b/t/t3423-rebase-reword.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='git rebase interactive with rewording'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'setup' '
+	test_commit master file-1 test &&
+
+	git checkout -b stuff &&
+
+	test_commit feature_a file-2 aaa &&
+	test_commit feature_b file-2 ddd
+'
+
+test_expect_success 'reword without issues functions as intended' '
+	test_when_finished "reset_rebase" &&
+
+	git checkout stuff^0 &&
+
+	set_fake_editor &&
+	FAKE_LINES="pick 1 reword 2" FAKE_COMMIT_MESSAGE="feature_b_reworded" \
+		git rebase -i -v master &&
+
+	test "$(git log -1 --format=%B)" = "feature_b_reworded" &&
+	test $(git rev-list --count HEAD) = 3
+'
+
+test_expect_success 'reword after a conflict preserves commit' '
+	test_when_finished "reset_rebase" &&
+
+	git checkout stuff^0 &&
+
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="reword 2" \
+		git rebase -i -v master &&
+
+	git checkout --theirs file-2 &&
+	git add file-2 &&
+	FAKE_COMMIT_MESSAGE="feature_b_reworded" git rebase --continue &&
+
+	test "$(git log -1 --format=%B)" = "feature_b_reworded" &&
+	test $(git rev-list --count HEAD) = 2
+'
+
+test_done
-- 
2.18.0.rc2.1.g5453d3f70b.dirty
