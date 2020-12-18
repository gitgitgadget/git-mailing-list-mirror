Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57169C2BBD5
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C7C23B8C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgLRVLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgLRVLw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 16:11:52 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDC6C0611CF
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:52 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 11so3224457oty.9
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YiPxE17V8hJz9o3ZjklqM7GvBtwPNsM6SC1G7fOVRRE=;
        b=CEXeVd/4nWeN0OgqlNZJsf7Rp8+oRI9CwvVFJaiT8GSEMaIKmzR/BNA52REbSuh+7l
         /PBrPSdHcsdc61zhvlH131utPIaKetKrHvWiQLWqQz67d4v7XSjVtolLALXlDDVXc4O2
         FcP+YY4uizYoWDXj3t9Wr07lheioSDLIML28HnLJ2JHfsWqaaeUxqUeYx1jgXff3l1Ll
         GGyVCHIY4e7AHlwq8VtatUQWDVrkukcEYpg2cLkSXCrdjkgGcw8y6+YIhpZws8QPAku5
         SOi9cYLhp4Z4cRDVrrCkE2jqjJqFd263JbW6DVVs/SoJab9jAeoxT5y337z23DdTuF+U
         1UZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YiPxE17V8hJz9o3ZjklqM7GvBtwPNsM6SC1G7fOVRRE=;
        b=QBuZ1d1wJGhfKP6RkDzq/fBTXC+V9KYEjpRuMdVmY/67Z0i2dPOnsG1D4+/6sUiKup
         gsjaXClVVjFHCJgVNXUv649e0zms9mX0inqTf7lQT2eo/kcsurZ3czHj/G4TFQnvhtNN
         odCFl/NRXZRml8y9DArB7EArCVVVmD6WL1EYv/w+82AkEK6BvBUUsNaZIHbhdM11B4yg
         Oo9QG7dqFPPdaX9Jua501NdF2GwuT8nKsmkNkdvIvix3rCLFXSRiLcN8mV/1vXuJMKoI
         Z0QTJ+d6ayzm+ud3EUoiBajXDlKobFEbq9RqFqc8/b8n7zN8m/5m3Jj1h3nAV6F5HGCJ
         8HSg==
X-Gm-Message-State: AOAM532F9p05xHeCmP1a7EXnWbgGQ5CTAduzS0WWSb7ba+OadgPH/O0a
        DI0b+SFrTpHrviMclAvBlFONax10N1rlMw==
X-Google-Smtp-Source: ABdhPJyVZuyqG5fzuBGddRJQ8mFsXKM5sc9jZmqk068C64Pq3iWOUPxhJ5GEYS2SAYhrpGy+LSdOFw==
X-Received: by 2002:a05:6830:22eb:: with SMTP id t11mr4495332otc.114.1608325851675;
        Fri, 18 Dec 2020 13:10:51 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t13sm2014515oih.26.2020.12.18.13.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:10:51 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 13/13] pull: improve --rebase and pull.rebase interaction
Date:   Fri, 18 Dec 2020 15:10:26 -0600
Message-Id: <20201218211026.1937168-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201218211026.1937168-1-felipe.contreras@gmail.com>
References: <20201218211026.1937168-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently --rebase without argument overrides pull.rebase:

  git config pull.rebase merges
  git pull --rebase

Up until now this hasn't been a big issue, since user has not been
forced to specify a merge, or a rebase. But with the introduction of
--merge and pull.mode, the user could in theory have the following
configuration:

  git config pull.mode merge
  git config pull.rebase merges

In such case, the user would expect:

  git pull --rebase

To be the same as:

  git pull --rebase=merges

If the user wants to override the configuration, she can do:

  git pull --rebase=true

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c  | 10 ++++++++--
 t/t5520-pull.sh | 10 ++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index ad8afabe9b..4e8e9d85a2 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -68,8 +68,14 @@ static int parse_opt_rebase(const struct option *opt, const char *arg, int unset
 
 	if (arg)
 		*value = parse_config_rebase("--rebase", arg, 0);
-	else
-		*value = unset ? REBASE_FALSE : REBASE_TRUE;
+	else {
+		if (!unset) {
+			/* --rebase shouldn't override pull.rebase=merges (and others) */
+			if (*value < REBASE_TRUE)
+				*value = REBASE_TRUE;
+		} else
+			*value = REBASE_FALSE;
+	}
 
 	if (*value > 0)
 		mode = *value >= REBASE_TRUE ? PULL_MODE_REBASE : PULL_MODE_MERGE;
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 45d818065f..d0f5722eab 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -595,6 +595,16 @@ test_expect_success REBASE_P \
 	test_cmp_rev HEAD^2 keep-merge
 '
 
+test_expect_success REBASE_P \
+	'pull.rebase=preserve interacts correctly with pull.mode and --rebase' '
+	git reset --hard before-preserve-rebase &&
+	test_config pull.mode merge &&
+	test_config pull.rebase preserve &&
+	git pull --rebase . copy &&
+	test_cmp_rev HEAD^^ copy &&
+	test_cmp_rev HEAD^2 keep-merge
+'
+
 test_expect_success 'pull.rebase=interactive' '
 	write_script "$TRASH_DIRECTORY/fake-editor" <<-\EOF &&
 	echo I was here >fake.out &&
-- 
2.30.0.rc0

