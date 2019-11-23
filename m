Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF08EC432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 17:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4EE20674
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 17:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxdYUPgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfKWRVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 12:21:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45470 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfKWRVA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 12:21:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id z10so12356419wrs.12
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 09:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dpg0lI982aAjIugqvlrMyECHvbHWmPTn0VxLcUmmDHk=;
        b=jxdYUPgfeVLGG/87fDVjRXSNFT8P/WQ5J64/2VWYdYrdy0zrI4AoQmZAVNy/8M5D4O
         lJbsLvuknaGWCTEO2wh4xj8qhCfeCw4yrhEjbHQ2z4dG51Ycjc+ZmhsxXiCQ7aGcLVqa
         azOkyMwTXP2lDRrRFq/pzNzo6xUF4UptC2+U3oRj1D0tXq0t9kzIEXLIbYYMSm8mnNah
         OmSN/DErhOxn+9mMVo6XhNsePVY9jkE17zaN50nDsTtErPfsX/PD+bFoRjSPT+os407f
         GYWsxnklbqEUlSqjrGgdtrT8oo0EgXSdEhBty+6pfcuJiAc1ZIY91uFI1a6VCEpkUyrk
         Ch5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dpg0lI982aAjIugqvlrMyECHvbHWmPTn0VxLcUmmDHk=;
        b=FDm6FFSpN745zyZngOOwfeYCYSGB+LBGnyzZI4YmU+wV7hPI2CQreNvV0KuI75tibH
         /c21VSSTZAt6aA9MLnO8cdADCRLtgVSTEvGV7qFUEJfsQHkf18h5zQYAp+Xik+sRq9bQ
         1PCfg6e9DzaMPxS1LBkKHXkF1z0UIHhsmT8Ik+yDsw6IFqYCNL4uQUGV195hDWSYtYWU
         uX4CqDg3Jc9KbvMC/pcrbkPBAoYUwI6lvvte/wZn+CpOBZ457rTCuZTg1JEGeb1LzyyD
         pTjtDxXQfibua4YFYvCf2DymfaC3MBiGZ8Hj30Jvxz8+namr9QvyOM69FE9pBYkUssC+
         qUdg==
X-Gm-Message-State: APjAAAWrZFQNpguFLDdakyXP9KSMh3t3RgrymRSy3P3fnBBQ7C/kEFNl
        K26hVceBvU1uRNiw1yGDnsM=
X-Google-Smtp-Source: APXvYqyeUOtGgshrsQ+363Vdh6VGrrnHe5BXqcCE+171JuOKt4fJsH9yMecOyBIclkE3pBs1q4T42A==
X-Received: by 2002:a5d:61c6:: with SMTP id q6mr23944783wrv.13.1574529656173;
        Sat, 23 Nov 2019 09:20:56 -0800 (PST)
Received: from localhost.localdomain (x4d0c2846.dyn.telefonica.de. [77.12.40.70])
        by smtp.gmail.com with ESMTPSA id f19sm3111725wrf.23.2019.11.23.09.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Nov 2019 09:20:55 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] sequencer: don't re-read todo for revert and cherry-pick
Date:   Sat, 23 Nov 2019 18:20:46 +0100
Message-Id: <20191123172046.16359-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.532.ge18579ded8
In-Reply-To: <e7c01e0f-8466-c2c5-b53a-a93f941dfb1c@gmail.com>
References: <e7c01e0f-8466-c2c5-b53a-a93f941dfb1c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'git revert' or 'git cherry-pick --edit' is invoked with multiple
commits, then after editing the first commit message is finished both
these commands should continue with processing the second commit and
launch another editor for its commit message, assuming there are
no conflicts, of course.

Alas, this inadvertently changed with commit a47ba3c777 (rebase -i:
check for updated todo after squash and reword, 2019-08-19): after
editing the first commit message is finished, both 'git revert' and
'git cherry-pick --edit' exit with error, claiming that "nothing to
commit, working tree clean".

The reason for the changed behaviour is twofold:

  - Prior to a47ba3c777 the up-to-dateness of the todo list file was
    only checked after 'exec' instructions, and that commit moved
    those checks to the common code path.  The intention was that this
    check should be performed after instructions spawning an editor
    ('squash' and 'reword') as well, so the ongoing 'rebase -i'
    notices when the user runs a 'git rebase --edit-todo' while
    squashing/rewording a commit message.

    However, as it happened that check is now performed even after
    'revert' and 'pick' instructions when they involved editing the
    commit message.  And 'revert' by default while 'pick' optionally
    (with 'git cherry-pick --edit') involves editing the commit
    message.

  - When invoking 'git revert' or 'git cherry-pick --edit' with
    multiple commits they don't read a todo list file but assemble the
    todo list in memory, thus the associated stat data used to check
    whether the file has been updated is all zeroed out initially.

    Then the sequencer writes all instructions (including the very
    first) to the todo file, executes the first 'revert/pick'
    instruction, and after the user finished editing the commit
    message the changes of a47ba3c777 kick in, and it checks whether
    the todo file has been modified.  The initial all-zero stat data
    obviously differs from the todo file's current stat data, so the
    sequencer concludes that the file has been modified.  Technically
    it is not wrong, of course, because the file just has been written
    indeed by the sequencer itself, though the file's contents still
    match what the sequencer was invoked with in the beginning.
    Consequently, after re-reading the todo file the sequencer
    executes the same first instruction _again_, thus ending up in
    that "nothing to commit" situation.

The todo list was never meant to be edited during multi-commit 'git
revert' or 'cherry-pick' operations, so perform that "has the todo
file been modified" check only when the sequencer was invoked as part
of an interactive rebase.

Reported-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

On Sat, Nov 23, 2019 at 09:53:51AM +0000, Phillip Wood wrote:
> Thanks, I suspect it's missing an 'if (is_rebase_i(opts))' I'll take a look
> later and come up with a fix

That missing condition was my hunch yesterday evening as well, and
while it did fix my tests and didn't break anything else, it took some
time to wrap my head around some of the subtleties that are going on
in the sequencer.  That's why the commit message ended up this long as
it did.

In the end I decided to add the new tests to
't3429-rebase-edit-todo.sh', because, though these new tests don't
actually check 'rebase', that is the one test script focusing on
(re-)reading the todo file in particular.

 sequencer.c                 |  2 +-
 t/t3429-rebase-edit-todo.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 2adcf5a639..3b05d0277d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3791,7 +3791,7 @@ static int pick_commits(struct repository *r,
 							item->commit,
 							arg, item->arg_len,
 							opts, res, 0);
-		} else if (check_todo && !res) {
+		} else if (is_rebase_i(opts) && check_todo && !res) {
 			struct stat st;
 
 			if (stat(get_todo_path(opts), &st)) {
diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index 8739cb60a7..1679f2563d 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -52,4 +52,34 @@ test_expect_success 'todo is re-read after reword and squash' '
 	test_cmp expected actual
 '
 
+test_expect_success 're-reading todo doesnt interfere with revert --edit' '
+	git reset --hard third &&
+
+	git revert --edit third second &&
+
+	cat >expect <<-\EOF &&
+	Revert "second"
+	Revert "third"
+	third
+	second
+	first
+	EOF
+	git log --format="%s" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 're-reading todo doesnt interfere with cherry-pick --edit' '
+	git reset --hard first &&
+
+	git cherry-pick --edit second third &&
+
+	cat >expect <<-\EOF &&
+	third
+	second
+	first
+	EOF
+	git log --format="%s" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.24.0.532.ge18579ded8

