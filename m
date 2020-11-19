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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8C0C64E7A
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B44C246E0
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKORP7zI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgKSPwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbgKSPwb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 10:52:31 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFC3C0613D4
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:52:31 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a186so4858978wme.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nO4OnZKfAXqr/SR7EZdgw2SGUFb0d15DKP99WiXhYtE=;
        b=gKORP7zID494E46kvHvQMSqVFcVMALdScuNp0C24IeuqqdPLN8oW7qZyhtmZ18tFwj
         +JkzvmnijSVTYAaDkSOqfvHnYYkxrFvFtWa57uBDoYKb4yIbKWRYaxmXBNiSddFoIW+r
         D2vBfyJIEXdgEKiFqVmqBczT9zlGIAMZ7raUkBLUH9FzG6RpEAwpxhX8Wok4dxddoPbW
         Upgw1/svF3OYo+f3uAu6SkDunfr9Qw98cwqwCH6gCTiatiRkqBTPBIRqwlOdf/E6hLvD
         1MdrG9kLaMQW75vjmJXH/VVcBX/i2eO5+78vbQ1kx2mieLJnMcBC36NCKD8N7U7hxbo3
         gjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nO4OnZKfAXqr/SR7EZdgw2SGUFb0d15DKP99WiXhYtE=;
        b=PLdnNi+8MH8zmNRmFz6qeXMlCVSow0QERB/QIjlzNEy/9TROCMyFvo0okpatCs9XuS
         Cc3Zmsy8wpRBzyYYFdJ0L17ZqcVy+OHFe5QWDMO1UsACKNdLQIEbS2brUniQ09k5Wfvp
         rho1ceIQJCy8R/BXlgMr37bOCRdiw5TiAXTMvDK7GjASC1vxfdsVigrMYyqUuqlTZ01s
         65X8esAnr0CHE5DBjs+rzFFYmmM5QGcN22kiQ7/9KJ2ecoAUSXlKrps6QvUeQ+akRrfh
         B3tAGjiHJmDmSbajcoKvxAFXpmC90fqIMlJCOtBAA/bmbq8H2unMmNgGOPonDuAYoU7W
         mDxQ==
X-Gm-Message-State: AOAM5324/l7lSctWnAaUUVrJ8wlIKpenPFXiHc3bbGfwhaCieKA3Wooc
        7YByyDUk1GPwQEv7LSYoHtiwun1S5Ws=
X-Google-Smtp-Source: ABdhPJwRJAfTlXpxpUFcJ7xrkyueqSJKzPKbikHqBfru/hjGLQMKwK9gAsRtPEXEOYvV964g0D9Fvg==
X-Received: by 2002:a1c:dc82:: with SMTP id t124mr3344145wmg.94.1605801149737;
        Thu, 19 Nov 2020 07:52:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm216927wrb.53.2020.11.19.07.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:52:29 -0800 (PST)
Message-Id: <1d1c2fd23e805e0f25edd324a614715b1d11a2bb.1605801143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.git.1605801143.gitgitgadget@gmail.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 15:52:23 +0000
Subject: [PATCH 7/7] maintenance: use 'git config --literal-value'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When a repository's leading directories contain regex glob characters,
the config calls for 'git maintenance register' and 'git maintenance
unregister' are not careful enough. Use the new --literal-value option
to direct the config machinery to use exact string matches. This is a
more robust option than excaping these arguments in a piecemeal fashion.

Reported-by: Emily Shaffer <emilyshaffer@google.com>
Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c           |  5 +++--
 t/t7900-maintenance.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e3098ef6a1..0784bbdc6a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1452,7 +1452,8 @@ static int maintenance_register(void)
 		git_config_set("maintenance.strategy", "incremental");
 
 	config_get.git_cmd = 1;
-	strvec_pushl(&config_get.args, "config", "--global", "--get", "maintenance.repo",
+	strvec_pushl(&config_get.args, "config", "--global", "--get",
+		     "--literal-value", "maintenance.repo",
 		     the_repository->worktree ? the_repository->worktree
 					      : the_repository->gitdir,
 			 NULL);
@@ -1483,7 +1484,7 @@ static int maintenance_unregister(void)
 
 	config_unset.git_cmd = 1;
 	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
-		     "maintenance.repo",
+		     "--literal-value", "maintenance.repo",
 		     the_repository->worktree ? the_repository->worktree
 					      : the_repository->gitdir,
 		     NULL);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 20184e96e1..2ee5512158 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -367,6 +367,18 @@ test_expect_success 'register and unregister' '
 	test_cmp before actual
 '
 
+test_expect_success 'register and unregister with glob characters' '
+	GLOB="a+b*c" &&
+	git init "$GLOB" &&
+	git -C "$GLOB" maintenance register &&
+	git config --get-all --show-origin maintenance.repo &&
+	git config --get-all --global --literal-value \
+		maintenance.repo "$(pwd)/$GLOB" &&
+	git -C "$GLOB" maintenance unregister &&
+	test_must_fail git config --get-all --global --literal-value \
+		maintenance.repo "$(pwd)/$GLOB"
+'
+
 test_expect_success 'start from empty cron table' '
 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
 
-- 
gitgitgadget
