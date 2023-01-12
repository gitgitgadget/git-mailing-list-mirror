Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8D3C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 15:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbjALP1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 10:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239292AbjALP0O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 10:26:14 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141E3E0C7
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:19:23 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u19so45510355ejm.8
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 07:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQBppmkjnEU9rXnp2INgkkZByoXEMjRuQLd4wJVbvrk=;
        b=I2S9HYR0Wn5wGFUkGuIbnt9/iWn4RyhDJocvWh+X+9kmh9D/uCnvkPd0lj0/6tbUu0
         wg1dxtU14rb8JfwRncGu0JkTcoJ+sCT78wjr6IkXER1sat9nX6b/luAWyd5lg5Rh1La7
         996Iw31Ze2RaVviYCE81BY4FK9HqvZrbRlR5IMDJymf1MXc8UKTjdvjmzqcgk1YNnIAF
         CZnsXekSm8sOIKN2S/dfZTz84g9fX1Ts2BjPHigiGqgr7fYdK7XgbKowGK+SXGYkRUDc
         3xt+WkDK9I3fB+DNTJe+h5ccU9DV5v2WYn3CZ/BpWuCu4QrumOVRhYqkjxXBQR7LBZlI
         7ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQBppmkjnEU9rXnp2INgkkZByoXEMjRuQLd4wJVbvrk=;
        b=FjZZdohg17ZrLU1LkMDmHzwX/ZcG4KDXczqf5Omgu6mz+DKf80+7W6FNSYQsk0/Abh
         zJpZOZlm5odMWBaZg4+iDriu/dl5IhhM2cqbBKT8xsCO9NSeEbD5vlGm+G2WQSUHzvxi
         ammEkWvedeBUAL9ANmU5WkiYuRvEvNrngBRWUB4J3MKyNG/pBLSsHPTzkk5ItqeXCg+9
         kwRBg+wd4XIZD4SNVNyd49e8chECd16OXZJeOqa965pjNATVc6YMnMIwJDpt+P7lHxcn
         lrgeuOUjN1KZb8cJu78SQKzXd1/1XQuD91fP/0tBjCqbB+V6Ijih9n8GPF2qsJBAPGIQ
         Pq+g==
X-Gm-Message-State: AFqh2kqxmdFiDgxQJEBdqUUqPGUwiO5F9fyqkBPlfsmq4JpkR0uEN3O4
        bhQ6/qNfWzwtGRcbi10M1hS7a78z2DaKKg==
X-Google-Smtp-Source: AMrXdXuq/2t2A1cnB2TYe0csVD/qmH/EnftDqVsyACNUxj/bLLmGdcUqjC2M5MhkwO8gOS8EHV+DhA==
X-Received: by 2002:a17:906:c2c9:b0:7b2:c227:126d with SMTP id ch9-20020a170906c2c900b007b2c227126dmr65517513ejb.20.1673536762341;
        Thu, 12 Jan 2023 07:19:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id kr12-20020a1709079a0c00b0084d44553af9sm5493291ejc.215.2023.01.12.07.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:19:21 -0800 (PST)
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
Subject: [PATCH v2 6/6] bisect: no longer try to clean up left-over `.git/head-name` files
Date:   Thu, 12 Jan 2023 16:19:14 +0100
Message-Id: <patch-v2-6.6-817fe726b4b-20230112T151651Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1215.g1ba3f685d4f
In-Reply-To: <cover-v2-0.6-00000000000-20230112T151651Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230112T151651Z-avarab@gmail.com>
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
2.39.0.1215.g1ba3f685d4f

