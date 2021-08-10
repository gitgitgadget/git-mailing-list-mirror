Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F21C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 09:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4240A60EE9
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 09:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbhHJJcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 05:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbhHJJcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 05:32:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFEBC0613D3
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 02:32:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h14so25330361wrx.10
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aoHsLaLvXroLoqaFJt+ljaDNoAaHQugE9clzB7+FviU=;
        b=cEcTEVkzJPmF2aNqT4TgtDEUlk9o4EcBahIgH4ivZsFxxguJH+ldSNiiFGhyGpAj+Y
         eGJQL0GqnbuG/84cVs2KXUqQP7uixacN455wg/oZmW7voWM+1Z58SuQy6dbYyLzhq0xf
         ZCR6nky1urS1U+q65eMOX0ig9lqFFFkQlwaCWm+9ZfnZ4XacoXfYsXvK46LTldVczVRK
         GZkt+EkdQlEEfDFqDXT7+GVDW14f9oiBMJwpYhUzYGNGHqxEEE0iisv31+YJuGQvFc6X
         gn2ooOi0tn92hHCMWKh0+jSjvu9/Mg3yzPE4WA8ZqryPH66Xjap6mFZIcHeKxmqKUPwp
         7Afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aoHsLaLvXroLoqaFJt+ljaDNoAaHQugE9clzB7+FviU=;
        b=VJ1mnnCQTmyhgz6w2XroVXeGaUeQZs4dW1va+q8lfrLqwx3IzFgY3EEk+4f7sgFPqf
         nnognmJwq7yjAb+DT3+AN3gt+aXFE3zIePdYfkr2wW8e6Xd8GQJ3+jXW3QtdHhPdZBX1
         CY2QACkw4CbZ81vdF2pIm49UyE7+N4tBjBb51ARGaNyT8ISa2G9yFKBWU/KYrq6Uk69e
         C4EnYdiHoPFooN49ilRInSo2r66wB4siAsu2KDThvKBBlNyRg0zZFdPekaTOoIE2trFO
         yhiEQvep6XkBlekuMdgR9+ewHmt/Kr8TgINpN9CBvT0Z8+S3caZIpH6BqB4/WyLa4Ld2
         w9kA==
X-Gm-Message-State: AOAM530Ibj7oabdFLZ3l8b5BRxpbrvJbeYcrrF4UYFPT11rMlsTIWde6
        zXZ30fV7IsLyVX1EE5Gdv6d0mAC1vCY=
X-Google-Smtp-Source: ABdhPJwqaZm+HT4cYLO0huNlYQVNbL0ON7W9XZhTcJeY1ihjfl3lT6gnH9FiyPWafq9wyJCsJxdnEA==
X-Received: by 2002:a5d:4ec4:: with SMTP id s4mr12123166wrv.245.1628587922057;
        Tue, 10 Aug 2021 02:32:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm7474004wmi.36.2021.08.10.02.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 02:32:01 -0700 (PDT)
Message-Id: <6a63b657f1313ea6d4141c37a7c24bca691ce107.1628587917.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Aug 2021 09:31:57 +0000
Subject: [PATCH 3/3] rebase --continue: remove .git/MERGE_MSG
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victor Gambier <vgambier@excilys.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the user skips the final commit by removing all the changes from
the index and worktree with 'git restore' (or read-tree) and then runs
'git rebase --continue' .git/MERGE_MSG is left behind. This will seed
the commit message the next time the user commits which is not what we
want to happen.

Reported-by: Victor Gambier <vgambier@excilys.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                |  3 +++
 t/t3403-rebase-skip.sh     |  8 ++++++++
 t/t3418-rebase-continue.sh | 10 ++++++++++
 3 files changed, 21 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 7f07cd00f3f..52c7b461179 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4716,6 +4716,9 @@ static int commit_staged_changes(struct repository *r,
 		    refs_delete_ref(get_main_ref_store(r), "",
 				    "CHERRY_PICK_HEAD", NULL, 0))
 			return error(_("could not remove CHERRY_PICK_HEAD"));
+		if (unlink(git_path_merge_msg(r)) && errno != ENOENT)
+			return error_errno(_("could not remove '%s'"),
+					   git_path_merge_msg(r));
 		if (!final_fixup)
 			return 0;
 	}
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index a44e68d0ffb..f6e48644978 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -20,6 +20,7 @@ test_expect_success setup '
 	git add hello &&
 	git commit -m "hello" &&
 	git branch skip-reference &&
+	git tag hello &&
 
 	echo world >> hello &&
 	git commit -a -m "hello world" &&
@@ -96,6 +97,13 @@ test_expect_success 'moved back to branch correctly' '
 
 test_debug 'gitk --all & sleep 1'
 
+test_expect_success 'skipping final pick removes .git/MERGE_MSG' '
+	test_must_fail git rebase --onto hello reverted-goodbye^ \
+		reverted-goodbye &&
+	git rebase --skip &&
+	test_path_is_missing .git/MERGE_MSG
+'
+
 test_expect_success 'correct advice upon picking empty commit' '
 	test_when_finished "git rebase --abort" &&
 	test_must_fail git rebase -i --onto goodbye \
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index e4cb8be0418..f23996c9be0 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -31,6 +31,16 @@ test_expect_success 'interactive rebase --continue works with touched file' '
 	git rebase --continue
 '
 
+test_expect_success 'rebase --continue removes .git/MERGE_MSG' '
+	git checkout -f --detach topic &&
+
+	test_must_fail git rebase --onto main HEAD^ &&
+	git read-tree --reset -u HEAD &&
+	test_path_is_file .git/MERGE_MSG &&
+	git rebase --continue &&
+	test_path_is_missing .git/MERGE_MSG
+'
+
 test_expect_success 'non-interactive rebase --continue works with touched file' '
 	rm -fr .git/rebase-* &&
 	git reset --hard &&
-- 
gitgitgadget
