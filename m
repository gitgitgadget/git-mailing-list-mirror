Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 644C51F454
	for <e@80x24.org>; Mon,  4 Nov 2019 09:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfKDJzl (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 04:55:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33379 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfKDJzl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 04:55:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id s1so16288899wro.0
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 01:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fThdO7H8VhiFK0zet78UjAiCxf2NfXeAGVrMSWwQves=;
        b=rECEYrLDrq1z7153Rr9Bi4/Sugq+z+sFNLh6VepLReFbah21232sLVqxMCQW40RoJU
         dj9TOfnBZGUB4/+VbfPX4A5TaG2BrNScO69e9mhnE4llEK8CE2vetTKoHJ+690pbiH6Y
         62PIpSbNJDIc/L5FvQziNf+rBqY+fo+O7qaBg1DjrXDs3Q4aDWCYldU3oOmrx9BP1xcX
         4GAXTO5a5yKhFSCnulujDdnbHrJy7DZnfYiJPzQegT7hlZYMAIlt0+KoMB81q6/G6KGx
         WSgyXnZWdgJuQk8/4nx1NFmnkS3EOOCjIojDMjRi8MD5rnCW8V3TUr7PL+eVnCUnaf0g
         jZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fThdO7H8VhiFK0zet78UjAiCxf2NfXeAGVrMSWwQves=;
        b=Y5cjv8zGdJZAhzLdGb9+5U/w5zp1YSBJgjIYjjYHwrdSkyFPax72O/exFrDT2Qovoo
         EBW0kuwK1lj6ra7pczfg7ZX0qwU7yRP7bk8LNmdkxeLLp8swPFtZ9wok97yEEcdi07RH
         6Ol2h9U/LDQjBWzqXAT5CCmasN+OY5Pv74FLcg634Vn3mNob3fG44D/BCa/1fXjEqL1T
         8IRTdB643KXFY5AxIFmPMfEb0C5HHkr6GD6rU3VT9gQoiDuc4/zDzjBNc9zIx053baIh
         +Bcf9gHPtL6h/AiSnLso0ZRF2oNtSCX+pNUI3CD7M2+B7ZUGRToxkSEDeRUO5KfMzr1t
         Pc8A==
X-Gm-Message-State: APjAAAWtNCF2/p+1DYRMWgiVqxiIOdL5w7GGr8QCtBpftWvG2M7c5xC/
        P0KFTG6WbY2tF+AxF2K8JQQbl8JX
X-Google-Smtp-Source: APXvYqyYjGWcOfQads2dCnKdyiafOZ33bpd0FLL+qvcEC9Q4JFxOTGlHg928VDOaKAgIFhvlpV/cVg==
X-Received: by 2002:adf:d1a3:: with SMTP id w3mr24063962wrc.9.1572861337509;
        Mon, 04 Nov 2019 01:55:37 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-9-104.w86-222.abo.wanadoo.fr. [86.222.152.104])
        by smtp.googlemail.com with ESMTPSA id d16sm19263539wmb.27.2019.11.04.01.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 01:55:37 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v2 0/2] rebase -i: extend rebase.missingCommitsCheck to `--edit-todo'
Date:   Mon,  4 Nov 2019 10:54:47 +0100
Message-Id: <20191104095449.9964-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190717143918.7406-1-alban.gruin@gmail.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To prevent mistakes when editing a branch, rebase features a knob,
rebase.missingCommitsCheck, to warn the user if a commit was dropped.
Unfortunately, this check is only effective for the initial edit, which
means that if you edit the todo list at a later point of the rebase and
dropped a commit, no warnings or errors would be issued.

This adds the ability to check if commits were dropped when editing the
todo list with `--edit-todo'.

The first patch adds new tests demonstrating that the todo list is not
checked with `--edit-todo'.  The second patch implements the check.

This series is pretty much a revamp of the first version.  Some patches
from the original series were rerolled separately and live now in
ag/sequencer-todo-updates.  This version is pretty much brand new, as
you can see in the range diff below.

Changes since v1 are about what the new todo list is compared to, and
when.  The original series compared the todo list against the original
edit, so if a commit was added then deleted, it would go unnoticed.
Now, it is compared against the previous version to avoid that.  This is
highlighted in the new tests.  The original series checked the todo list
after `--edit-todo', but also before continuing a rebase or after having
executed a command.  Now, it only checks it after `--edit-todo', as
suggested by Phillip Wood.

This is based on master (da72936f54, "Git 2.24").

The tip of this series is tagged as "edit-todo-drop-rfc-v2" at
https://github.com/agrn/git.

Alban Gruin (2):
  t3404: demonstrate that --edit-todo does not check for dropped commits
  rebase-interactive: warn if commit is dropped with --edit-todo

 rebase-interactive.c          |  7 ++--
 sequencer.c                   |  5 +--
 t/t3404-rebase-interactive.sh | 75 +++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 8 deletions(-)

Diff-intervalle contre v1 :
 1:  b35f920318 !  1:  6974b6c8f2 t3404: demonstrate that --edit-todo does not check for dropped commits
    @@ Commit message
     
         When set to "warn" or "error", `rebase.missingCommitCheck' would make
         rebase -i warn if the user removed commits from the todo list to prevent
    -    mistakes.  Unfortunately, rebase --edit-todo and rebase --continue don't
    -    take it into account.
    +    mistakes.  Unfortunately, rebase --edit-todo don't take it into account.
     
         This adds three tests to t3404 to demonstrate this.  The first one is
         not broken, as when `rebase.missingCommitsCheck' is not set, nothing in
         particular must be done towards dropped commits.  The two others are
         broken, demonstrating the problem.
     
    +    The tests for `rebase.missingCommitsCheck = warn' and
    +    `rebase.missingCommitsCheck = error' have a similar structure.  First,
    +    we start a rebase with an incorrect command on the first line.  Then, we
    +    edit the todo list, removing the first and the last lines.  This
    +    demonstrates that `--edit-todo' notices dropped commits, but not when
    +    the command is incorrect.  Then, we restore the original todo list, and
    +    edit it to remove the last line.  This demonstrates that if we add a
    +    commit after the initial edit, then remove it, `--edit-todo' will notice
    +    that it has been dropped.  Then, the actual rebase takes place.
    +
         Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
     
      ## t/t3404-rebase-interactive.sh ##
    @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i respects rebase.mi
     +	test_config rebase.missingCommitsCheck ignore &&
     +	rebase_setup_and_clean missing-commit &&
     +	set_fake_editor &&
    -+	test_must_fail env FAKE_LINES="1 2 bad 3 4" \
    -+		git rebase -i --root >/dev/null 2>stderr &&
    -+	FAKE_LINES="1 2 4" git rebase --edit-todo &&
    ++	FAKE_LINES="break 1 2 3 4 5" git rebase -i --root &&
    ++	FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual &&
     +	git rebase --continue 2>actual &&
     +	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
     +	test_i18ngrep \
    @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i respects rebase.mi
     +		actual
     +'
     +
    -+cat >expect <<EOF
    -+error: invalid line 5: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master)
    -+Warning: some commits may have been dropped accidentally.
    -+Dropped commits (newer to older):
    -+ - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
    -+To avoid this message, use "drop" to explicitly remove a commit.
    -+
    -+Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
    -+The possible behaviours are: ignore, warn, error.
    -+
    -+EOF
    -+
    -+tail -n 8 <expect >expect.2
    -+
     +test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
    ++	cat >expect <<-EOF &&
    ++	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
    ++	Warning: some commits may have been dropped accidentally.
    ++	Dropped commits (newer to older):
    ++	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
    ++	To avoid this message, use "drop" to explicitly remove a commit.
    ++	EOF
    ++	tail -n4 expect >expect.2 &&
     +	test_config rebase.missingCommitsCheck warn &&
     +	rebase_setup_and_clean missing-commit &&
     +	set_fake_editor &&
    -+	test_must_fail env FAKE_LINES="1 2 3 4 bad 5" \
    -+		git rebase -i --root >/dev/null 2>stderr &&
    -+	FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual &&
    ++	test_must_fail env FAKE_LINES="bad 1 2 3 4 5" \
    ++		git rebase -i --root &&
    ++	cp .git/rebase-merge/git-rebase-todo.backup orig &&
    ++	FAKE_LINES="2 3 4" git rebase --edit-todo 2>actual.2 &&
    ++	head -n5 actual.2 >actual &&
     +	test_i18ncmp expect actual &&
    -+	git rebase --continue 2>actual.2 &&
    -+	head -n 8 <actual.2 >actual &&
    ++	cp orig .git/rebase-merge/git-rebase-todo &&
    ++	FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual.2 &&
    ++	head -n4 actual.2 >actual &&
     +	test_i18ncmp expect.2 actual &&
    ++	git rebase --continue 2>actual &&
     +	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
     +	test_i18ngrep \
     +		"Successfully rebased and updated refs/heads/missing-commit" \
    -+		actual.2
    ++		actual
     +'
     +
    -+cat >expect <<EOF
    -+error: invalid line 3: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~2)
    -+Warning: some commits may have been dropped accidentally.
    -+Dropped commits (newer to older):
    -+ - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
    -+ - $(git rev-list --pretty=oneline --abbrev-commit -1 master~2)
    -+To avoid this message, use "drop" to explicitly remove a commit.
    -+
    -+Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
    -+The possible behaviours are: ignore, warn, error.
    -+
    -+EOF
    -+
    -+tail -n 9 <expect >expect.2
    -+
     +test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
    ++	cat >expect <<-EOF &&
    ++	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
    ++	Warning: some commits may have been dropped accidentally.
    ++	Dropped commits (newer to older):
    ++	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
    ++	To avoid this message, use "drop" to explicitly remove a commit.
    ++	EOF
    ++	tail -n4 expect >expect.2 &&
     +	test_config rebase.missingCommitsCheck error &&
     +	rebase_setup_and_clean missing-commit &&
     +	set_fake_editor &&
    -+	test_must_fail env FAKE_LINES="1 2 bad 3 4" \
    -+		git rebase -i --root >/dev/null 2>stderr &&
    -+	test_must_fail env FAKE_LINES="1 2 4" \
    -+		git rebase --edit-todo 2>actual &&
    ++	test_must_fail env FAKE_LINES="bad 1 2 3 4 5" \
    ++		git rebase -i --root &&
    ++	cp .git/rebase-merge/git-rebase-todo.backup orig &&
    ++	test_must_fail env FAKE_LINES="2 3 4" \
    ++		git rebase --edit-todo 2>actual.2 &&
    ++	head -n5 actual.2 >actual &&
     +	test_i18ncmp expect actual &&
    -+	test_must_fail git rebase --continue 2>actual &&
    ++	cp orig .git/rebase-merge/git-rebase-todo &&
    ++	test_must_fail env FAKE_LINES="1 2 3 4" \
    ++		git rebase --edit-todo 2>actual.2 &&
    ++	head -n4 actual.2 >actual &&
     +	test_i18ncmp expect.2 actual &&
    -+	cp .git/rebase-merge/git-rebase-todo.backup \
    -+		.git/rebase-merge/git-rebase-todo &&
    -+	FAKE_LINES="1 2 drop 3 4 drop 5" \
    -+		git rebase --edit-todo &&
    ++	cp orig .git/rebase-merge/git-rebase-todo &&
    ++	FAKE_LINES="1 2 3 4 drop 5" git rebase --edit-todo &&
     +	git rebase --continue 2>actual &&
     +	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
     +	test_i18ngrep \
 2:  7410a1bc4b <  -:  ---------- t3429: demonstrate that rebase exec does not check for dropped commits
 3:  f9ef6d5569 <  -:  ---------- sequencer: update `total_nr' when adding an item to a todo list
 4:  049a92dec0 <  -:  ---------- sequencer: update `done_nr' when skipping commands in a todo list
 5:  f7aae0c763 <  -:  ---------- sequencer: move the code writing total_nr on the disk to a new function
 6:  0e41c4c85e <  -:  ---------- sequencer: add a parameter to sequencer_continue() to accept a todo list
 7:  e6f5589f18 <  -:  ---------- rebase-interactive: todo_list_check() also uses the done list
 8:  69a562b0ab <  -:  ---------- rebase-interactive: warn if commit is dropped with --edit-todo
 9:  4656ab11ae <  -:  ---------- sequencer: have read_populate_todo() check for dropped commits
 -:  ---------- >  2:  a4a700ce8b rebase-interactive: warn if commit is dropped with --edit-todo
-- 
2.24.0.2.ga4a700ce8b

