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
	by dcvr.yhbt.net (Postfix) with ESMTP id EF1BE1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 09:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfKDJzm (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 04:55:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41203 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKDJzm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 04:55:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so16232373wrm.8
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 01:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NsRIJYM/jaui44odQPiK6VOUsIHALl87Lgel9xudVss=;
        b=kULWMvzfHtnk/hrt3WKteYt6i5qlBnETC8bKDz5uySjm/L76k7E/5dlH/fff+i9xQB
         OQ6SPjZwhWW/L1Q9cbWwKdTSDoMEJeBzdq5W3QURUokJbdhDKumRFMpbl1eLsFBuYzaq
         rdz7uivN3F+dYTtoTLTH/H+ZOjOulmLcYU3G3QYHmx+MVNYWWOpJe/X8yJZq8/Zwzbq9
         YOtKy1HsAQQKfx3X+u21RFQIql3j8SbmOuxnKJrE1jFMewm2bRPx2Vr9Mn9EsyqkcVHJ
         omjUUUtVUb0v6wgTRXzr1HvylRh+0E1zFxwM+qqrb6WV6QkpQ/n7NNrW84neUNrV1Y1g
         bnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NsRIJYM/jaui44odQPiK6VOUsIHALl87Lgel9xudVss=;
        b=ExwjmjrjrEIYk3p+BZE53cTrPgmn+jidYFUwvrrrUkZhoCAlt+wl1nTT4lud6FCcPc
         2J6XTcFXmWI/bXczuRwxOtEhRE56xzyZrOdu6gZZUaTVWZpKBsVZzeDwIw6hqNjsS/Pw
         NsTybh4JEsGiJ1PCmlDz5cXpK09yUVGjeulCVi0J2NcXkg+DAz1DmOZXqjhTcoGDYmB2
         Whdg/HrJ77wQuVW9rshQiCJR4CQjaOA6SZGEweVQNkZLdO9h0lteEFKmfTmD+tVDvwu7
         Xj7JTkstn3jOqMerluL39HjLp+cPWvE0KqeXawmOIWoHBdZ8rjEIoaeL0EUKrlNH6FtO
         GpmQ==
X-Gm-Message-State: APjAAAWJs8taunAo7Tgo1MvfiKQmCu1XL9h/BchtHCIn1JVH4BC4GsiT
        xjn57dGUUMBEXmtQehbarmOIVEuZ
X-Google-Smtp-Source: APXvYqySPYJjZjkGI1g/1YO2H4K5qXyA/PtMgbi6rRDq+vEIUcQl40MX9HqOaBSFn1rLWHi+t1lqwg==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr11917576wru.30.1572861339319;
        Mon, 04 Nov 2019 01:55:39 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-9-104.w86-222.abo.wanadoo.fr. [86.222.152.104])
        by smtp.googlemail.com with ESMTPSA id d16sm19263539wmb.27.2019.11.04.01.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 01:55:38 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v2 1/2] t3404: demonstrate that --edit-todo does not check for dropped commits
Date:   Mon,  4 Nov 2019 10:54:48 +0100
Message-Id: <20191104095449.9964-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104095449.9964-1-alban.gruin@gmail.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
 <20191104095449.9964-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When set to "warn" or "error", `rebase.missingCommitCheck' would make
rebase -i warn if the user removed commits from the todo list to prevent
mistakes.  Unfortunately, rebase --edit-todo don't take it into account.

This adds three tests to t3404 to demonstrate this.  The first one is
not broken, as when `rebase.missingCommitsCheck' is not set, nothing in
particular must be done towards dropped commits.  The two others are
broken, demonstrating the problem.

The tests for `rebase.missingCommitsCheck = warn' and
`rebase.missingCommitsCheck = error' have a similar structure.  First,
we start a rebase with an incorrect command on the first line.  Then, we
edit the todo list, removing the first and the last lines.  This
demonstrates that `--edit-todo' notices dropped commits, but not when
the command is incorrect.  Then, we restore the original todo list, and
edit it to remove the last line.  This demonstrates that if we add a
commit after the initial edit, then remove it, `--edit-todo' will notice
that it has been dropped.  Then, the actual rebase takes place.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 t/t3404-rebase-interactive.sh | 75 +++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d2dfbe46b9..be8badf7b3 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1353,6 +1353,81 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ignore' '
+	test_config rebase.missingCommitsCheck ignore &&
+	rebase_setup_and_clean missing-commit &&
+	set_fake_editor &&
+	FAKE_LINES="break 1 2 3 4 5" git rebase -i --root &&
+	FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual &&
+	git rebase --continue 2>actual &&
+	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
+	test_i18ngrep \
+		"Successfully rebased and updated refs/heads/missing-commit" \
+		actual
+'
+
+test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
+	cat >expect <<-EOF &&
+	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
+	Warning: some commits may have been dropped accidentally.
+	Dropped commits (newer to older):
+	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
+	To avoid this message, use "drop" to explicitly remove a commit.
+	EOF
+	tail -n4 expect >expect.2 &&
+	test_config rebase.missingCommitsCheck warn &&
+	rebase_setup_and_clean missing-commit &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="bad 1 2 3 4 5" \
+		git rebase -i --root &&
+	cp .git/rebase-merge/git-rebase-todo.backup orig &&
+	FAKE_LINES="2 3 4" git rebase --edit-todo 2>actual.2 &&
+	head -n5 actual.2 >actual &&
+	test_i18ncmp expect actual &&
+	cp orig .git/rebase-merge/git-rebase-todo &&
+	FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual.2 &&
+	head -n4 actual.2 >actual &&
+	test_i18ncmp expect.2 actual &&
+	git rebase --continue 2>actual &&
+	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
+	test_i18ngrep \
+		"Successfully rebased and updated refs/heads/missing-commit" \
+		actual
+'
+
+test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
+	cat >expect <<-EOF &&
+	error: invalid line 1: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~4)
+	Warning: some commits may have been dropped accidentally.
+	Dropped commits (newer to older):
+	 - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
+	To avoid this message, use "drop" to explicitly remove a commit.
+	EOF
+	tail -n4 expect >expect.2 &&
+	test_config rebase.missingCommitsCheck error &&
+	rebase_setup_and_clean missing-commit &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="bad 1 2 3 4 5" \
+		git rebase -i --root &&
+	cp .git/rebase-merge/git-rebase-todo.backup orig &&
+	test_must_fail env FAKE_LINES="2 3 4" \
+		git rebase --edit-todo 2>actual.2 &&
+	head -n5 actual.2 >actual &&
+	test_i18ncmp expect actual &&
+	cp orig .git/rebase-merge/git-rebase-todo &&
+	test_must_fail env FAKE_LINES="1 2 3 4" \
+		git rebase --edit-todo 2>actual.2 &&
+	head -n4 actual.2 >actual &&
+	test_i18ncmp expect.2 actual &&
+	cp orig .git/rebase-merge/git-rebase-todo &&
+	FAKE_LINES="1 2 3 4 drop 5" git rebase --edit-todo &&
+	git rebase --continue 2>actual &&
+	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
+	test_i18ngrep \
+		"Successfully rebased and updated refs/heads/missing-commit" \
+		actual
+'
+
 test_expect_success 'respects rebase.abbreviateCommands with fixup, squash and exec' '
 	rebase_setup_and_clean abbrevcmd &&
 	test_commit "first" file1.txt "first line" first &&
-- 
2.24.0.2.ga4a700ce8b

