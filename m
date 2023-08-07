Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA8FC41513
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 20:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjHGUmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 16:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjHGUmp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 16:42:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244AF10F5
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 13:42:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-317e14b0935so1139054f8f.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 13:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691440961; x=1692045761;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uv/3lp125NPBuUUjxYRhP87DvfGKDE5dTD+SWK7jvxE=;
        b=b2cTk8986hFdtJJVY2Dzy72l7XlA4bq36qyEhuWVzZG7OdLA01jzLIMmbZj14a490C
         1Y1nvLREooot0lsvWdkp6J2/C0E8EfHrquLDmH8j4xFDldF7r1F5DQKk3Rb9GripM6h4
         Zokv5YvdcKdO6W9tHK47xOd0Jx2eYH4Trubj6t+q2E84SphUx44PK38MKFeDVo2izKCv
         HF/HWJa3fUdIna/KXvHJH4PRYws2YHlFfK5YzqhnFsDPuEQB2RHGBBrWJPy5BUduw4yb
         D05EyjoFPizDqrMqM8MnWLK7FdpjWoYkverKnLzf8w7419yOaSC4D6jRkFVjXOgKFK5o
         rRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691440961; x=1692045761;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uv/3lp125NPBuUUjxYRhP87DvfGKDE5dTD+SWK7jvxE=;
        b=cT8iS78+dGjVIuPfT3LY45yUrt/Ys7gwOxZzXje+hXf3LCEtPEbRIhWfBslWAg0fQi
         5tzkZk9Lc+RDXKW5TxXSr8x6OLRQ1SQy2kADT4+DwzAbOoAFVaso0GFhZxbRkw6/vk3c
         qjx3REL3VBjNixh3a4bOYfREKRMXCLr4qEZQmkwbkJarjQPbsKM/14BQBBKw9M02g1CR
         kOPUNHTmCVDvORd1jswJ1rzF1Mh+Ut//BHI3HoLjKgvbiDpJDD9gXQOfxk4vl/fUQOs5
         nYy0vue7NH/6p4e0z0ZGAcOGt7eoiRxwo06i1Cu4Ab+jEWNxlTWWo+UIRzB3z19XIUXA
         4v6g==
X-Gm-Message-State: AOJu0YwpsBFdukxpbAs/8WiLhM5Ra1NxD6q4u8bdE32BsKs4NhdgLFFU
        UIgjKTTo4K2OxePkzJCsWoMNJzPvFSw=
X-Google-Smtp-Source: AGHT+IFomveD4/ffWi1v6rS8JcRcr4cW9TD6WH8fWm3Wku3cSWwVcaZuh8Ga36p/C0wh7FRy1NWeVQ==
X-Received: by 2002:a5d:5391:0:b0:313:df09:acfb with SMTP id d17-20020a5d5391000000b00313df09acfbmr5942041wrv.11.1691440961664;
        Mon, 07 Aug 2023 13:42:41 -0700 (PDT)
Received: from [192.168.2.52] (225.red-88-14-55.dynamicip.rima-tde.net. [88.14.55.225])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d4f82000000b0031784ac0babsm11594465wru.28.2023.08.07.13.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 13:42:41 -0700 (PDT)
Subject: [PATCH 2/2] branch: error message checking out a branch in use
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <7710c002-0832-d8f6-59b8-30119bd5efe6@gmail.com>
Message-ID: <d217d15f-ddef-d9bf-07fa-464b4025ab3c@gmail.com>
Date:   Mon, 7 Aug 2023 22:42:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7710c002-0832-d8f6-59b8-30119bd5efe6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's update the error message we show when the user tries to check out
a branch which is being used in another worktree, following the
guideline reasoned in 4970bedef2 (branch: update the message to refuse
touching a branch in-use, 2023-07-21).

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 branch.c                | 2 +-
 t/t2400-worktree-add.sh | 3 ++-
 t/t3400-rebase.sh       | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/branch.c b/branch.c
index 3e4684f79f..98c199f7b7 100644
--- a/branch.c
+++ b/branch.c
@@ -838,7 +838,7 @@ void die_if_checked_out(const char *branch, int ignore_current_worktree)
 
 		if (is_shared_symref(worktrees[i], "HEAD", branch)) {
 			skip_prefix(branch, "refs/heads/", &branch);
-			die(_("'%s' is already checked out at '%s'"),
+			die(_("'%s' already used by worktree at '%s'"),
 				branch, worktrees[i]->path);
 		}
 	}
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 051363acbb..89447a4a0c 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -121,7 +121,8 @@ test_expect_success '"add" worktree creating new branch' '
 test_expect_success 'die the same branch is already checked out' '
 	(
 		cd here &&
-		test_must_fail git checkout newmain
+		test_must_fail git checkout newmain 2> actual &&
+		grep "already used by worktree at" actual
 	)
 '
 
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 3ce918fdb8..d3df19a51f 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -421,7 +421,7 @@ test_expect_success 'refuse to switch to branch checked out elsewhere' '
 	git checkout main &&
 	git worktree add wt &&
 	test_must_fail git -C wt rebase main main 2>err &&
-	test_i18ngrep "already checked out" err
+	test_i18ngrep "already used by worktree at" err
 '
 
 test_expect_success MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a symlink' '
-- 
2.42.0.rc0.2.gbb987841e8
