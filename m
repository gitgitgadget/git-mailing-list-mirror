Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD2CC433FE
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 13:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbiAENPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 08:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236967AbiAENP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 08:15:27 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB3CC061761
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 05:15:27 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j18so82934895wrd.2
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 05:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/nI6qC7B1rGxNyhj/NwQWyrn9om5wjrkO16t+RRZOSA=;
        b=O1hG7FZhNQRpsr7K1PJNhhVth4dt39SFehKHmXAIknJacGpOMeMti2A9SOX5GZ8Dmg
         9ALMY5ocxdDLnl72+Rwv8mSFi3bKUc8XSICIyP4uZdP4wZ2UGe9LGo2+KvcA9PqhCQS+
         KTnvbqPMRUsWkFDq8z7dzixrbvQa7KndREu6sVoLZ7Z5UsIrJGwnewJvDkUqjsJvek/L
         wDUz3l47fdq3P78l7G0CI8yMmZINHb4hAhDi4iXJSpf6gnE7HoqXFZ2M5qfUVo49g44z
         JUHsniqcF/YOX+HRTdmT4TwC8hEHyIZmeTZ/xGZSxiW7ply0Ti4MYiaJSaf9yZtuccko
         PEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/nI6qC7B1rGxNyhj/NwQWyrn9om5wjrkO16t+RRZOSA=;
        b=3lXthkdZUNto0pIVhpKyVu1Ma1GZwe5SkHJuXfsQAR59slcrhasAZTQe/JhDvq22e4
         Jc1sz5Wt/z3Q7fFyISjCpexHHKQW9gcHZ8y73Blk2pqOfoDKMU/2I9pYi60ldcTk3CLL
         ZaKkr6MaQ3RrZDLnLvU+s6CVSrAbuPH6G6DO+CIyfSRBooSwCkev1D2Kz4WmwV11S4hN
         ngbZLBJnX8GnkeLo4BSYCyVCij/BHrX82E3W5+rI6dOS1warD1n9MBFEFfySvhDxbjDM
         UebY3Kqv4UwwBwhw+s3uhfzRU8Dj/L6eWJ+UKAJx7qERWgI6oFAQ1osNsg+byY3KGt+H
         gGNg==
X-Gm-Message-State: AOAM532th4Pklbatsb1HXQwFO1cBVBiEKHJo6zbA1fYopTQ9FrwOUSnk
        yhc4lU80BDuUI4V2lcmjEjidg2Tjndo=
X-Google-Smtp-Source: ABdhPJzpveOECr6JxYkIaZy43h5yKNUhGR3l+qlmi3EvGw6wnB1xKkuoFw7biVnelOuKUZFZ1VNuKw==
X-Received: by 2002:a5d:6803:: with SMTP id w3mr23493006wru.673.1641388525893;
        Wed, 05 Jan 2022 05:15:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5sm2498387wmc.39.2022.01.05.05.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 05:15:25 -0800 (PST)
Message-Id: <7d58f80611193f8696d99e317fe6b1e53ac740f7.1641388523.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1105.v2.git.1641388523.gitgitgadget@gmail.com>
References: <pull.1105.git.1640181390841.gitgitgadget@gmail.com>
        <pull.1105.v2.git.1641388523.gitgitgadget@gmail.com>
From:   "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 13:15:22 +0000
Subject: [PATCH v2 1/2] t7508: add tests capturing racy timestamp handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marc Strapetz <marc.strapetz@syntevo.com>

"git status" fixes racy timestamps regardless of the worktree being
dirty or not. The new test cases capture this behavior.

Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
 t/t7508-status.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 05c6c02435d..652cbb5ed2e 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1656,4 +1656,32 @@ test_expect_success '--no-optional-locks prevents index update' '
 	! grep ^1234567890 out
 '
 
+test_expect_success 'racy timestamps will be fixed for clean worktree' '
+	echo content >racy-dirty &&
+	echo content >racy-racy &&
+	git add racy* &&
+	git commit -m "racy test files" &&
+	# let status rewrite the index, if necessary; after that we expect
+	# no more index writes unless caused by racy timestamps; note that
+	# timestamps may already be racy now (depending on previous tests)
+	git status &&
+	test-tool chmtime =1234567890 .git/index &&
+	test-tool chmtime --get .git/index >out &&
+	grep ^1234567890 out &&
+	git status &&
+	test-tool chmtime --get .git/index >out &&
+	! grep ^1234567890 out
+'
+
+test_expect_success 'racy timestamps will be fixed for dirty worktree' '
+	echo content2 >racy-dirty &&
+	git status &&
+	test-tool chmtime =1234567890 .git/index &&
+	test-tool chmtime --get .git/index >out &&
+	grep ^1234567890 out &&
+	git status &&
+	test-tool chmtime --get .git/index >out &&
+	! grep ^1234567890 out
+'
+
 test_done
-- 
gitgitgadget

