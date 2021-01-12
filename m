Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA04EC433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999BA23123
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438153AbhALVht (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437050AbhALUvR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:51:17 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AFBC061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:50:36 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m25so5371445lfc.11
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+gF9cWTvZW+Nn8QCQSbUr+DVlwdyZwIRpmtHQ28e8Z4=;
        b=qn/aY5ppEsZxxmjpHO4UJzO6mfSWhy8g2wpSYkXk7QdgmF9a5OKl99rRz11OzyUXfz
         RRJsY6hytTElvYtJLQYrEC7FL78i6l5em2zFRj3ZkUaXGB7XaR1CxBhcKDSzqt6fINmt
         Jt2jau54vKr6aeNuKzAdNQkWg2TF5RR9qagiMFAXzlJH8IDNuf9QQ8xvlDmmGSpwOzqv
         YDb38su7+m4yvaxyOcQ7NbFyajNqDAgS0oVPZxczBUFZDh0s8SPZ6Q4L5uR9LJ/Yy454
         1auNRwiwPhuUTmOLqCVI3s0ywL63QT88yvtw1DHpPPWua8ShqAMcP9OFbqV3yYAxdxUH
         rG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+gF9cWTvZW+Nn8QCQSbUr+DVlwdyZwIRpmtHQ28e8Z4=;
        b=mNovvmqxRlC+iesuC4US1fP+FUBTaCVnbjVB/kG95wg/BWNQxkNG/dbfHNPKAlUa0n
         aFmhmavKpN6T7bIUmxlaskIBY3lOnLcfM9SH4267qz7Nkr/4JQX2BwW2I5UzWtAF26x7
         946jhQP1fq9FcdTSMHVPk3jalD7zDeEf7wA4zzPUlPJtM6nkeBqEv9EYBSgTqfF4Ricd
         wpoig6e7WNkC4qQKi7ZQClO5JssxZOKlYRCswdW4EBaiu+yO7b6I4IB11EeTCHqmnT5R
         neCC8ggae8S0zbEaxndgKuaWqDPDKKme/UGF4AXb7iXKBANm8TkYBRyvluR1f4H+9PBQ
         Bxlg==
X-Gm-Message-State: AOAM533ikcztO5IC6of+YHiK9IaI3yZX0Q+zk5Gg2uWvq0HQNX827+DF
        cDjZkcKUDr8i7Jjp+064Ngs3roAaQno=
X-Google-Smtp-Source: ABdhPJy7jMADy8dImTy1Lf7Y+vKvYT55lFEcSqiFd8Of8HrEagtZ+Jk01+dPlknvlvUsS1r8Gui8bQ==
X-Received: by 2002:a19:8b8b:: with SMTP id n133mr308871lfd.278.1610484635191;
        Tue, 12 Jan 2021 12:50:35 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id a15sm522749lfo.299.2021.01.12.12.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:50:34 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Vojt=C4=9Bch=20Knyttl?= <vojtech@knyt.tl>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] rebase -i: do leave commit message intact in fixup! chains
Date:   Tue, 12 Jan 2021 21:49:39 +0100
Message-Id: <20210112204939.1095-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5ea
In-Reply-To: <pull.818.v2.git.1610123298764.gitgitgadget@gmail.com>
References: <pull.818.v2.git.1610123298764.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com> wrote:
>
> We actually need to actively suppress that clean-up lest a configured
> `commit.cleanup` may interfere with what we want to do: leave the commit
> message unchanged.

>     Changes since v1:>
>      * The fix now works even if commit.cleanup = commit

Indeed. FWIW, this patch looks good to me.

There is the lone remaining user of `CLEANUP_MSG` where we're handling
the skipping of the final fixup in a chain and which is part of a larger
block of code to handle various cases like that around `git rebase
--skip`. I wrote some tests on top of your patch to see what happens and
try to understand what's going on. The tests are below.

I can't say I grok all that's going on in the implementation. By the
time we're finalizing the commit message, it seems to me that we've lost
track of which of the lines that look like comments are indeed comment
lines added by us and which actually originate in the commit messages
we're trying to rebase and which just happen to begin with a comment
character.

Maybe these tests could be simplified a bit, or de-boilerplated to some
extent, but I think they do correctly demonstrate a similar bug that
remains after your fix.

What do you think? Are these test failures useful at all? Would it be
an easy fix? In any case, I don't think the presence of these bugs need
to hold up the fix you've posted here. The bugs look like they're
related, but they are in different parts of the code (to the best of my
understanding).

FWIW, this diff is Signed-off-by me if you want to run with it. Maybe
include some part of it that you agree with in your commit?

(Yes, this diff mentions "master" several times. This file already
mentions that branch name. You have a patch in seen to address that,
but there would be a semantic conflict.)

Martin

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 88040bc435..f80318998f 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -448,4 +448,63 @@ test_expect_success 'fixup does not clean up commit message' '
 	test "$oneline" = "$(git show -s --format=%s)"
 '
 
+test_expect_failure 'fixup does not clean message (conflict in only fixup)' '
+	test_when_finished "git checkout master" &&
+	oneline="#ladder" &&
+	echo version-1 >file &&
+	git add file &&
+	git commit -m version-1 &&
+	git checkout -B fixup-topic HEAD^ &&
+	# Now make two commits (oneline+fixup) that conflict
+	# in the fixup when we rebase them onto master.
+	git commit --allow-empty -m "$oneline" &&
+	echo conflict >file &&
+	git add file &&
+	git commit --fixup HEAD &&
+	test_must_fail git -c commit.cleanup=strip rebase -ki \
+		--autosquash --onto=master HEAD~2 &&
+	git rebase --skip &&
+	test "$oneline" = "$(git show -s --format=%s)"
+'
+
+test_expect_failure 'fixup does not clean message (conflict in non-last fixup)' '
+	test_when_finished "git checkout master" &&
+	oneline="#not-a-comment" &&
+	echo version-2 >file &&
+	git add file &&
+	git commit -m version-2 &&
+	git checkout -B fixup-topic HEAD^ &&
+	# Now make three commits (oneline+fixup+fixup) that conflict
+	# in the first fixup when we rebase them onto master.
+	git commit --allow-empty -m "$oneline" &&
+	echo conflict >file &&
+	git add file &&
+	git commit --fixup HEAD &&
+	git commit --fixup HEAD --allow-empty &&
+	test_must_fail git -c commit.cleanup=strip rebase -ki \
+		--autosquash --onto=master HEAD~3 &&
+	git rebase --skip &&
+	test "$oneline" = "$(git show -s --format=%s)"
+'
+
+test_expect_failure 'fixup does not clean message (conflict in last fixup)' '
+	test_when_finished "git checkout master" &&
+	oneline="#hash" &&
+	echo version-3 >file &&
+	git add file &&
+	git commit -m version-3 &&
+	git checkout -B fixup-topic HEAD^ &&
+	# Now make three commits (oneline+fixup+fixup) that conflict
+	# in the second fixup when we rebase them onto master.
+	git commit --allow-empty -m "$oneline" &&
+	git commit --fixup HEAD --allow-empty &&
+	echo conflict >file &&
+	git add file &&
+	git commit --fixup HEAD &&
+	test_must_fail git -c commit.cleanup=strip rebase -ki \
+		--autosquash --onto=master HEAD~3 &&
+	git rebase --skip &&
+	test "$oneline" = "$(git show -s --format=%s)"
+'
+
 test_done
