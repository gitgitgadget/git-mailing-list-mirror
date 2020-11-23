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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D85EC64E69
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E196F20782
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj4xx0L6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbgKWQFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732604AbgKWQFY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 11:05:24 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405E4C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:05:23 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so19131226wrx.5
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IY1B6uiZfAzZi0ImRAXBp02jdsBrK+S+g2vny/GnDWw=;
        b=Aj4xx0L60PQeNJMneDhQ2e5jWS+yI04C/wqbHSX9sqMIZsmXcQHGoYQXVpmjsj3XI6
         +8GZPUcdOS1rkhw9QcE1msQt8qxycb0xvWpKqH6NVuM0JrrAgqnyU9VezHI5FRKfteHK
         tmVV26L7QdEegYYYqkAVSxOUEzwYeg4Gvp0K4KdLRmzXu9oPfRDiOg4dcu4XqaKw8W82
         /0KE0L5+hD+ADnnww4FDox/8JYSFeQuTf8wCf9skYzzB0Xr2lyHqhL6f6FWNb4fTatCs
         EppCGidvvdTQm4N6e9HV0V1chA/UgN9FFOLq5C83JSrnspEPvvjwfD4Xu82D/c157z+e
         Ld5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IY1B6uiZfAzZi0ImRAXBp02jdsBrK+S+g2vny/GnDWw=;
        b=c2YStAV7KpvYMTGzgRNHM57hBryvFAS7EMIbQCRNjJgk/d+ngBmWudNMnxGETkpYm5
         O961j+4Xf95qS9GSgHOkD1vNGcEDt4f6gLWyvDiitkWNuGDj6XvzVKgq0ep5KP7iFkUc
         qEnbaNYd+KYHwOCVa4ozYJis6JXUjzRRsjr62jQFUYVoEiYS/zqcBP/m7kNV6iPAM2oh
         kj4M9mEdC3146o7sjYEbjDs1BYfvDAWFkKj4ykLPkulKMSSMyy9bzJ9w1Zde4/Dri+M3
         yukiXqNwSUsvYtSjuir14BeV9CKi7R903nCUMfqfSDp5AHRgMpFuo33nTKZdFdZJ1sjD
         WTZQ==
X-Gm-Message-State: AOAM533f702BOxDfKRJC1KgvTnMXKcsyM1IRm5w8tPM1+CrD79nAUche
        yh5vdb7vOCuhPCK3sKm5oOshcF1AD8E=
X-Google-Smtp-Source: ABdhPJz2NBdTHMcuWiqnS4CuljnuM6jEw/ErdyHY//RII4pbqaWwjyQFgLaIVosgLxqFbd2pm6zn9w==
X-Received: by 2002:a5d:534e:: with SMTP id t14mr373019wrv.234.1606147521767;
        Mon, 23 Nov 2020 08:05:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d134sm17534811wmd.8.2020.11.23.08.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:05:21 -0800 (PST)
Message-Id: <5a3acf811998bb728ce94c69611c237861775142.1606147507.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 16:05:07 +0000
Subject: [PATCH v2 7/7] maintenance: use 'git config --fixed-value'
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
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When a repository's leading directories contain regex glob characters,
the config calls for 'git maintenance register' and 'git maintenance
unregister' are not careful enough. Use the new --fixed-value option
to direct the config machinery to use exact string matches. This is a
more robust option than excaping these arguments in a piecemeal fashion.

For the test, require that we are not running on Windows since the '+'
character is not allowed on that filesystem.

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
index 20184e96e1..c4e5564c31 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -367,6 +367,18 @@ test_expect_success 'register and unregister' '
 	test_cmp before actual
 '
 
+test_expect_success !MINGW 'register and unregister with glob characters' '
+	GLOB="a+b*c" &&
+	git init "$GLOB" &&
+	git -C "$GLOB" maintenance register &&
+	git config --get-all --show-origin maintenance.repo &&
+	git config --get-all --global --fixed-value \
+		maintenance.repo "$(pwd)/$GLOB" &&
+	git -C "$GLOB" maintenance unregister &&
+	test_must_fail git config --get-all --global --fixed-value \
+		maintenance.repo "$(pwd)/$GLOB"
+'
+
 test_expect_success 'start from empty cron table' '
 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
 
-- 
gitgitgadget
