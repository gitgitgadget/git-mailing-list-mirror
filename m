Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF3FC46467
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiLOJtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiLOJsY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:48:24 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B8F16494
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:48:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id a16so26251532edb.9
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olJQKL9TqTGrOrUL+vKYll7Hi9WvDdR4cxWu0HGyV+g=;
        b=o0gTZ63Pj6c3DCFbtIjzdx+zLOWB02qViuLvKf1n+1IEAFqi5MgGYKANRjmvWx6oOw
         OO/HVjS8f8UsgGX0v7IGrsZHB8Zvdtn92tGlNiTbRKaVh89+2hcUoLMbk+THhBcFHo3r
         G9NiFcy/SKJvpJq0C3ElKKHNCYxjI6vKSRoCXmXpx+moSYhEbyJ4Yu4TxFwojTBlD8Zc
         9SRit/h7nM9EwdwnGyUKZUc+r18qSAeles3dEBvuTLWrdwOJEL+48NY9A/YKMXNpBlML
         SnKjrAMzN9sUOCeZR8Ov0N/rPJCHdEQjLDGSXm0ZUMOnlshO+H3o9QI5OiZPq9op8d0Y
         i/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olJQKL9TqTGrOrUL+vKYll7Hi9WvDdR4cxWu0HGyV+g=;
        b=KXU2QILCCFl6pudG6x4Kleq+xhUmRe5WtScA+ADITOmV6/r2oZNZRrt18+hIZC5uPY
         86mx8LtoWu6NLx5YQQnkv8GAvCFmXD426qvFk/nmSlSJpF0hJOa5yNmRQe7j+Lrspb9m
         VwdArUmgwIQckQBgy+Eh6Zf2lo61t5LI9HDIo7OMUG4o3GVLxYlWSD/2FwupPfEP84RR
         1KywNGXQch4VyT+BOhx4gE4vqRNvSuOSmGz32BCqwzDwS2KO58rHSDI+cW6ynNwl88iq
         xYeFwZDq2g1ckeN2NFL8s/Xq/aJ8UZxLskb6S6MRuPnjj5H9bb0LI9bryhYjOwb8OS8j
         uITw==
X-Gm-Message-State: ANoB5pkoequR1ZEO+8GbpNl6VDBshMTOWOSkRGGBWsmhdeFkAUDRN+1r
        jLLDPPomoau6t7I/idHVdcXQ7lLR08zTKQ==
X-Google-Smtp-Source: AA0mqf6I4wEYa3Vsqd4/kP4dmbqnp+kTPQAbTMTn4nOQQNITKmXb9OJtTtDmPzC8rzMD1/LaUZpzdQ==
X-Received: by 2002:a05:6402:1cce:b0:470:49a2:ad7d with SMTP id ds14-20020a0564021cce00b0047049a2ad7dmr8077121edb.25.1671097678313;
        Thu, 15 Dec 2022 01:47:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fd0f000000b0046b4e0fae75sm7189155eds.40.2022.12.15.01.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:47:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] bisect: no longer try to clean up left-over `.git/head-name` files
Date:   Thu, 15 Dec 2022 10:47:49 +0100
Message-Id: <patch-6.6-2ad89aca728-20221215T094038Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As per the code comment, the `.git/head-name` files were cleaned up for
backwards-compatibility: an old version of `git bisect` could have left
them behind.

Now, just how old would such a version be? As of 0f497e75f05 (Eliminate
confusing "won't bisect on seeked tree" failure, 2008-02-23), `git
bisect` does not write that file anymore. Which corresponds to Git
v1.5.4.4.

Even if the likelihood is non-nil that there might still be users out
there who use such an old version to start a bisection, but then decide
to continue bisecting with a current Git version, it is highly
improbable.

So let's remove that code, at long last.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bisect.c                    | 3 ---
 t/t6030-bisect-porcelain.sh | 1 -
 2 files changed, 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index ec7487e6836..ef5ee5a6436 100644
--- a/bisect.c
+++ b/bisect.c
@@ -472,7 +472,6 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
-static GIT_PATH_FUNC(git_path_head_name, "head-name")
 
 static void read_bisect_paths(struct strvec *array)
 {
@@ -1188,8 +1187,6 @@ int bisect_clean_state(void)
 	unlink_or_warn(git_path_bisect_run());
 	unlink_or_warn(git_path_bisect_terms());
 	unlink_or_warn(git_path_bisect_first_parent());
-	/* Cleanup head-name if it got left by an old version of git-bisect */
-	unlink_or_warn(git_path_head_name());
 	/*
 	 * Cleanup BISECT_START last to support the --no-checkout option
 	 * introduced in the commit 4796e823a.
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 0a62ea2b3ce..3ba4fdf6153 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1158,7 +1158,6 @@ test_expect_success 'git bisect reset cleans bisection state properly' '
 	test_path_is_missing ".git/BISECT_LOG" &&
 	test_path_is_missing ".git/BISECT_RUN" &&
 	test_path_is_missing ".git/BISECT_TERMS" &&
-	test_path_is_missing ".git/head-name" &&
 	test_path_is_missing ".git/BISECT_HEAD" &&
 	test_path_is_missing ".git/BISECT_START"
 '
-- 
2.39.0.rc2.1048.g0e5493b8d5b

