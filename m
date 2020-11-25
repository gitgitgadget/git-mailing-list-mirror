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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15BCC64E90
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F255206D9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlMXfkq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbgKYWNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 17:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732881AbgKYWNI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 17:13:08 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D91C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:13:08 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id e7so6914wrv.6
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kRjRrr+jlp4f+qDklro2hVq4wuNrs892V9EMBcsrKy4=;
        b=VlMXfkq3rPIslWwhC+JHZ/dGg5hjItYUgS+5cNyq8TAwp6aHxMrvGXgQvoU/apJgdf
         gph8UhFY1cA5jfFtnHOfMH//e9Q7DupQt40nIdM2QqXJm5agKI3iYBDFgi1NmTjReSFg
         EZlZGANadH4lHhTznxFFVDbZ8xzhmj3+nDQxIWASTOiZMMOESzqQDUMbd214/Qmrkm4T
         L94y0fhdq/c74OcdqDboVRhSWGuxrQAGJXow3AHRJMcyzW1H4Z5rFsLC1BYIr0X47LU+
         M4CZnCMB45UxNtRiUXMNvORhn9gO+zDC+0ie7F/jCXVgVOa2iPyeq/vFuxXkhdETxtoT
         PwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kRjRrr+jlp4f+qDklro2hVq4wuNrs892V9EMBcsrKy4=;
        b=B0YFDas03mS/4+L8Vxg0M5mgOKJNn4EKnohCQqvblS/xukthzgGoLP6vG+hgiORKRl
         kdlwgWr1kjPP9LwUg9uxLDp0hEL8E0NeFNlfyLDvH58GykD8UHMSbktkasuc4Ule2E8T
         qSZ9QVxW8SYSHMJfIv9/+b29YDJkZLtgKxHBDktancmVI9ylw17Q6KdRUGAoXbORkY1b
         E7EOeaHl9P711flmBGTxyLV0s3CRXZ/nSIxzNiLWHTKsOfH0WHNqTE738Xi0fjtGwP2W
         PA3LuHFFrqSfO4J8UInHUK5Gcv364Kk+kisZLd68XtNakYIrritfOdgqjVZnbW7cwIsr
         romQ==
X-Gm-Message-State: AOAM531IrM9JkTWuVsBFWc3AS9yS2CQE0arMnNpdlygjcxYYgL0cbfTd
        ApbsnFp3Fs1EykSxv26I9To3qkTGdgE=
X-Google-Smtp-Source: ABdhPJytuqoAu+HE/tlHwNCHy0VkVHuQfHwJxZbY44fXBeQKUUainTn56pds3meaH46BL4TFjTL7Ng==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr54365wrp.242.1606342386917;
        Wed, 25 Nov 2020 14:13:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm6488705wrp.44.2020.11.25.14.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 14:13:06 -0800 (PST)
Message-Id: <558775f83d7cbf7ad0e2090ab13be404cdf16b24.1606342377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
References: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
        <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Nov 2020 22:12:56 +0000
Subject: [PATCH v3 8/8] maintenance: use 'git config --fixed-value'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When a repository's leading directories contain regex metacharacters,
the config calls for 'git maintenance register' and 'git maintenance
unregister' are not careful enough. Use the new --fixed-value option
to direct the config machinery to use exact string matches. This is a
more robust option than escaping these arguments in a piecemeal fashion.

For the test, require that we are not running on Windows since the '+'
and '*' characters are not allowed on that filesystem.

Reported-by: Emily Shaffer <emilyshaffer@google.com>
Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c           |  5 +++--
 t/t7900-maintenance.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e3098ef6a1..6dde3ce1bb 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1452,7 +1452,8 @@ static int maintenance_register(void)
 		git_config_set("maintenance.strategy", "incremental");
 
 	config_get.git_cmd = 1;
-	strvec_pushl(&config_get.args, "config", "--global", "--get", "maintenance.repo",
+	strvec_pushl(&config_get.args, "config", "--global", "--get",
+		     "--fixed-value", "maintenance.repo",
 		     the_repository->worktree ? the_repository->worktree
 					      : the_repository->gitdir,
 			 NULL);
@@ -1483,7 +1484,7 @@ static int maintenance_unregister(void)
 
 	config_unset.git_cmd = 1;
 	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
-		     "maintenance.repo",
+		     "--fixed-value", "maintenance.repo",
 		     the_repository->worktree ? the_repository->worktree
 					      : the_repository->gitdir,
 		     NULL);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 20184e96e1..bc2207edd6 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -367,6 +367,18 @@ test_expect_success 'register and unregister' '
 	test_cmp before actual
 '
 
+test_expect_success !MINGW 'register and unregister with regex metacharacters' '
+	META="a+b*c" &&
+	git init "$META" &&
+	git -C "$META" maintenance register &&
+	git config --get-all --show-origin maintenance.repo &&
+	git config --get-all --global --fixed-value \
+		maintenance.repo "$(pwd)/$META" &&
+	git -C "$META" maintenance unregister &&
+	test_must_fail git config --get-all --global --fixed-value \
+		maintenance.repo "$(pwd)/$META"
+'
+
 test_expect_success 'start from empty cron table' '
 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
 
-- 
gitgitgadget
