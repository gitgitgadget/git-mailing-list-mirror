Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B26661F461
	for <e@80x24.org>; Wed, 17 Jul 2019 14:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfGQOlz (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 10:41:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39964 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfGQOlz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 10:41:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so25108531wrl.7
        for <git@vger.kernel.org>; Wed, 17 Jul 2019 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GdMD/fAN+lZwJ82MReeYciRQSDLmINXX7d7VjAd675k=;
        b=n0UxQnJpWlTVM2Lb3Dtlbr/4CGZLU97dIwPl5YjEi6oP3oQMmttjvtdITgiaI0Rp3D
         TQY6LsG8mdXnYQtHLQ5r6rUlAQoYzWXx3hzCjpkyXXbX79UMQQNuZtaQ80lIZRg9WqPt
         ofPlEDaCUNW2hmQCCq+h16+aPGT0WaL1rtGoVlRNWi6BSP7JDzN4PzM+hYFMdGKuAdlz
         qeoOMXiz46AIgRfWIZzjjmpAuK9KSR7ST2UEtBrwaC1wSwmpcsGo1F6Hi9TVlIZSATR6
         UoxtB2BMTxBe7+/25wOShs8qbQWJ2sGVHMMkfcWXdPKMWA4aZ+lBuW2c9/G4zr77vlCp
         00Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GdMD/fAN+lZwJ82MReeYciRQSDLmINXX7d7VjAd675k=;
        b=mWdnL3reqFFRAIHlKvWS8WXK3TiIK9aA7XHZwCsV7r321zleGWbaYg2s5ALH6mkC02
         HTdRF7mXnmSok7KcOhuVTbiaHlY/nymnqSsB09osS2zPzP5sldyb0ELVJMOFwgML0EJW
         CroYeGTCo6zJjyFUFiY0ENUTisq4ybnbWiQ8YPNw8Vgo6lphLqvg6gRv5UULgm8LGjTT
         DJEHej//fjIZOJggrOtFEwZRhvkne3ZmUVSFBZn3tXJ9rK/eUvDTv6ch9ktRs38TqKvV
         /No9CHbBCiILSr6bWytbReQ1/czI7KGZk5nNdH1adqkFbtY28riAYzyiTGv/l1/Pq6lq
         kCxA==
X-Gm-Message-State: APjAAAWOLJZlYxD4X5WJRZdJl6svGZlGiqBDzifgjkvmm4nihUS/Yq0W
        cn+skBw8kMzq/y2mwJSCt+UI9biG
X-Google-Smtp-Source: APXvYqxOipvshELRoFAkh4y6uFQYXldRE0N6Pxigum8RxkmdP0GJxPuMbtIkkogAgrIFFNgIYODf0g==
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr13568106wrs.36.1563374513063;
        Wed, 17 Jul 2019 07:41:53 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-658-1-183-65.w86-199.abo.wanadoo.fr. [86.199.38.65])
        by smtp.googlemail.com with ESMTPSA id p18sm21815968wrm.16.2019.07.17.07.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 07:41:52 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH 1/9] t3404: demonstrate that --edit-todo does not check for dropped commits
Date:   Wed, 17 Jul 2019 16:39:10 +0200
Message-Id: <20190717143918.7406-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190717143918.7406-1-alban.gruin@gmail.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When set to "warn" or "error", `rebase.missingCommitCheck' would make
rebase -i warn if the user removed commits from the todo list to prevent
mistakes.  Unfortunately, rebase --edit-todo and rebase --continue don't
take it into account.

This adds three tests to t3404 to demonstrate this.  The first one is
not broken, as when `rebase.missingCommitsCheck' is not set, nothing in
particular must be done towards dropped commits.  The two others are
broken, demonstrating the problem.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 t/t3404-rebase-interactive.sh | 82 +++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 461dd539ff..f5c0a8d2bb 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1345,6 +1345,88 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'rebase --edit-todo respects rebase.missingCommitsCheck = ignore' '
+	test_config rebase.missingCommitsCheck ignore &&
+	rebase_setup_and_clean missing-commit &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="1 2 bad 3 4" \
+		git rebase -i --root >/dev/null 2>stderr &&
+	FAKE_LINES="1 2 4" git rebase --edit-todo &&
+	git rebase --continue 2>actual &&
+	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
+	test_i18ngrep \
+		"Successfully rebased and updated refs/heads/missing-commit" \
+		actual
+'
+
+cat >expect <<EOF
+error: invalid line 5: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master)
+Warning: some commits may have been dropped accidentally.
+Dropped commits (newer to older):
+ - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
+To avoid this message, use "drop" to explicitly remove a commit.
+
+Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
+The possible behaviours are: ignore, warn, error.
+
+EOF
+
+tail -n 8 <expect >expect.2
+
+test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = warn' '
+	test_config rebase.missingCommitsCheck warn &&
+	rebase_setup_and_clean missing-commit &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="1 2 3 4 bad 5" \
+		git rebase -i --root >/dev/null 2>stderr &&
+	FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual &&
+	test_i18ncmp expect actual &&
+	git rebase --continue 2>actual.2 &&
+	head -n 8 <actual.2 >actual &&
+	test_i18ncmp expect.2 actual &&
+	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
+	test_i18ngrep \
+		"Successfully rebased and updated refs/heads/missing-commit" \
+		actual.2
+'
+
+cat >expect <<EOF
+error: invalid line 3: badcmd $(git rev-list --pretty=oneline --abbrev-commit -1 master~2)
+Warning: some commits may have been dropped accidentally.
+Dropped commits (newer to older):
+ - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
+ - $(git rev-list --pretty=oneline --abbrev-commit -1 master~2)
+To avoid this message, use "drop" to explicitly remove a commit.
+
+Use 'git config rebase.missingCommitsCheck' to change the level of warnings.
+The possible behaviours are: ignore, warn, error.
+
+EOF
+
+tail -n 9 <expect >expect.2
+
+test_expect_failure 'rebase --edit-todo respects rebase.missingCommitsCheck = error' '
+	test_config rebase.missingCommitsCheck error &&
+	rebase_setup_and_clean missing-commit &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="1 2 bad 3 4" \
+		git rebase -i --root >/dev/null 2>stderr &&
+	test_must_fail env FAKE_LINES="1 2 4" \
+		git rebase --edit-todo 2>actual &&
+	test_i18ncmp expect actual &&
+	test_must_fail git rebase --continue 2>actual &&
+	test_i18ncmp expect.2 actual &&
+	cp .git/rebase-merge/git-rebase-todo.backup \
+		.git/rebase-merge/git-rebase-todo &&
+	FAKE_LINES="1 2 drop 3 4 drop 5" \
+		git rebase --edit-todo &&
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
2.22.0

