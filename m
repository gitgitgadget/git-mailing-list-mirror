Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1BCC433E0
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67B522473
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbhADQXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 11:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbhADQXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 11:23:09 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E86C0617A2
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 08:22:24 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id u19so27948360edx.2
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 08:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2RZGzwRs9W4RciWwOxJSF6Wi5QyeJP9Af4afDA0D/cQ=;
        b=jBBX9isR0CyD/W+PupK0FbVNTH94JSgP0XLnPaVP8GkGP5nDyAlcJ6Q3MGFCQkX1YR
         zjdsEUKcH2XPiJIMnEIZxhOD5QzCHcMciggR9z/jW3pGEAx9eipe6hxEcEIg+VCBlhVL
         5NMDtCbxno2gTCKmYYAbxFq3k2wvR7GMtq56LeBl8qKqX8L4YZLnHdEi57G37PFR3qBZ
         LR5r3ZeM7q4c4+WCEhcLmcroqHoa8Le2n+FZWpLHII+YjEf1D+s8UQmT8JGVZS2fVVoB
         XFaWIfsfMXLmkl840A0ZPtsq4my/djFqpH1N4IKqxs/vHu4xdfVY/tJS6QYJjRAqPHBa
         J0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2RZGzwRs9W4RciWwOxJSF6Wi5QyeJP9Af4afDA0D/cQ=;
        b=l4B/g+8uJ+lg0nVrCEI9kP+oWBlSOBEtRWzo/qAj7eRswYn3gRsTTbOKsLERZt1ojT
         evcMvKg1mCkScF9KzVyGkX3XdOOvz1DEwgbwVSLrFpQoqfrM7i2A78pLuhaFOyYvogdX
         0gU8OxCoixzMj5DDvphzI1fOpIuqagOX/aPfwTHmXXixQBRld0tnTYjSnretMR0XVt26
         0rsJmlWMLJjAdHTZyjOHbZgLVt5axIaMMHewpheMB3ZS8mYUVsAE4gsZVqSLT3ueZI2q
         +S+ZxF5FgwNGGhVGyLrwiTXk0klEQgd63DitoRlN2K+0JmB6/y1nuyrRLewlhuOPFaug
         pAfw==
X-Gm-Message-State: AOAM530nLbehz4gWGI6JlpXxHQm72sA9b+SMmo1GRlWhnv5UmvTwuPrb
        PDY0Y5GmS0+MZMlnwM/vNbLUOfHdico=
X-Google-Smtp-Source: ABdhPJw/kq0fp+JPKbKt/+V4lUR7BjvKMLK9Ig1eCd07nYy4Z6b8kRfQpAb9hwhMFSNxEhBHdc1K6A==
X-Received: by 2002:a05:6402:31b5:: with SMTP id dj21mr73128981edb.90.1609777342825;
        Mon, 04 Jan 2021 08:22:22 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.191])
        by smtp.gmail.com with ESMTPSA id bn21sm23931677ejb.47.2021.01.04.08.22.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 08:22:22 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH 6/7] worktree: add tests for `list` verbose and annotations
Date:   Mon,  4 Jan 2021 17:21:27 +0100
Message-Id: <20210104162128.95281-7-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.391.g469bf2a980
In-Reply-To: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for "git worktree list" verbose mode, prunable and locked
annotations for both default and porcelain format and ensure the
"prunable" annotation is consistent with what "git worktree prune"
command will eventually remove. Additionally, add one test case to
ensure any newline characters are escaped from locked reason for the
porcelain format to prevent breaking the format.

The c57b3367be (worktree: teach `list` to annotate locked worktree,
2020-10-11) introduced a new test to ensure locked worktrees are listed
with "locked" annotation. However, the test does not remove the worktree
as the "git worktree prune" is not going to remove any locked worktrees.
Let's fix that by unlocking the worktree before the "prune" command.

Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 t/t2402-worktree-list.sh | 94 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 795ddca2e4..6c4da438b3 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -62,7 +62,9 @@ test_expect_success '"list" all worktrees --porcelain' '
 '
 
 test_expect_success '"list" all worktrees with locked annotation' '
-	test_when_finished "rm -rf locked unlocked out && git worktree prune" &&
+	test_when_finished "rm -rf locked unlocked out &&
+		git worktree unlock locked &&
+		git worktree prune" &&
 	git worktree add --detach locked master &&
 	git worktree add --detach unlocked master &&
 	git worktree lock locked &&
@@ -71,6 +73,96 @@ test_expect_success '"list" all worktrees with locked annotation' '
 	! grep "/unlocked  *[0-9a-f].* locked$" out
 '
 
+test_expect_success '"list" all worktrees with prunable annotation' '
+	test_when_finished "rm -rf prunable unprunable out && git worktree prune" &&
+	git worktree add --detach prunable &&
+	git worktree add --detach unprunable &&
+	rm -rf prunable &&
+	git worktree list >out &&
+	grep "/prunable  *[0-9a-f].* prunable$" out &&
+	! grep "/unprunable  *[0-9a-f].* prunable$"
+'
+
+test_expect_success '"list" all worktrees with prunable consistent with "prune"' '
+	test_when_finished "rm -rf prunable out && git worktree prune" &&
+	git worktree add --detach prunable &&
+	rm -rf prunable &&
+	git worktree list >out &&
+	grep "/prunable  *[0-9a-f].* prunable$" out &&
+	git worktree prune --verbose >out &&
+	test_i18ngrep "^Removing worktrees/prunable" out
+'
+
+test_expect_success '"list" all worktrees --porcelain with locked' '
+	test_when_finished "rm -rf locked1 locked2 out actual expect &&
+		git worktree unlock locked1 &&
+		git worktree unlock locked2 &&
+		git worktree prune" &&
+	echo "locked" >expect &&
+	echo "locked with reason" >>expect &&
+	git worktree add locked1 --detach &&
+	git worktree add locked2 --detach &&
+	git worktree lock locked1 &&
+	git worktree lock locked2 --reason "with reason" &&
+	git worktree list --porcelain >out &&
+	grep "^locked" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list" all worktrees --porcelain with newline escaped locked reason' '
+	test_when_finished "rm -rf locked_lf locked_crlf reason_lf reason_crlf out actual expect reason &&
+		git worktree unlock locked_lf &&
+		git worktree unlock locked_crlf &&
+		git worktree prune" &&
+	printf "locked locked\\\\r\\\\nreason\n" >expect &&
+	printf "locked locked\\\\nreason\n" >>expect &&
+	git worktree add locked_lf --detach &&
+	git worktree add locked_crlf --detach &&
+	printf "locked\nreason\n\n" >reason_lf &&
+	printf "locked\r\nreason\n\n" >reason_crlf &&
+	git worktree lock locked_lf --reason "$(cat reason_lf)" &&
+	git worktree lock locked_crlf --reason "$(cat reason_crlf)" &&
+	git worktree list --porcelain >out &&
+	grep "^locked" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list" all worktrees --porcelain with prunable' '
+	test_when_finished "rm -rf prunable list out && git worktree prune" &&
+	git worktree add --detach prunable &&
+	rm -rf prunable &&
+	git worktree list --porcelain >out &&
+	test_i18ngrep "^prunable gitdir file points to non-existent location$" out
+'
+
+test_expect_success '"list" all worktrees --verbose and --porcelain mutually exclusive' '
+	test_must_fail git worktree list --verbose --porcelain
+'
+
+test_expect_success '"list" all worktrees --verbose with locked' '
+	test_when_finished "rm -rf locked out actual expect &&
+		git worktree unlock locked &&
+		git worktree prune" &&
+	git worktree add locked --detach &&
+	git worktree lock locked --reason "with reason" &&
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
2.30.0.391.g469bf2a980

