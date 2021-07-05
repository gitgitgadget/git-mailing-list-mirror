Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91479C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE8E613AB
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhGEMfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhGEMfm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:42 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEDBC061765
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:33:05 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id t24-20020a9d7f980000b029046f4a1a5ec4so18198109otp.1
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECxxfPK1SRxAWQfueTPq13GzKWFfnsCubYM8g8rb+x4=;
        b=kvRn1cuBdxQ3gNSg8OXPRVrE3ZT/YAMVNcZTWL6dpVefz0Rwj78qgxG64b3jLiZZKA
         g11KodxU8gLkePJPNo1hT3pnCtjUm/P3NBjIMCGDJm/Gtxl2GzLK9X+Q7jv7sc1ATDU5
         pbZGsWpMEZjxIUipq/wzeUfpwrgmZA6hqFt0FgSdg06MDB6VuyU98fnZejnTnlL2auzU
         9loUqHxdXMHfqdPDNHujsde0KvkdiXTRmZRBcKhELk2QMLkM+Urpl6Yf/CNr7Cq9DI2K
         45EPxpy34TnktTyvDMJ4l5tvjBfLnhf0PBo05eCUpIItHnGKoeSrUb/NbM14YrnmEWbO
         wvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECxxfPK1SRxAWQfueTPq13GzKWFfnsCubYM8g8rb+x4=;
        b=PnMC7Al4eK6AVw0YrqUiFQB0GvLqtXnRJJJzwm5YOADAJsudD1LDoFsUUwCVr5NXj0
         JrDHDf7AoP7Yc5mAf/Hg7pQcfLPrZ8ng7VAYmEap/rli8ZVFNu/GGo+T1OHUFZBaYgYG
         V52EAAWWDPw+ngT5wFYpNUKpzi3PD3qQJ+DstatxGKYuqsxKaMMoriEq1SoMT6opHT3R
         dbu2qUK3N1JuUNvUZS9ZawWdB9sDFTYZksnDsMkbWjV66I9wIng2ITcII2sQmci/QQBO
         OdXncHrrxgpPKZ9T+JBvKszV74b7/WLv/0b12SHgeMDkGPCiLtC6EzPoNPOgIUWlPURm
         DblQ==
X-Gm-Message-State: AOAM532Zydp1Ke8IFq+MCrtJkRcj3L0crWuT9HK3NY8f/No3Xu4VR+/M
        Nx2cp5JfGu/SeandlINz00IMQblY2hvAvA==
X-Google-Smtp-Source: ABdhPJxv+gyrfR60YApuYY1rxg2bHwSfikR8gU5tA4z2HiGr4zytcZYna2si9FAR1JJpohhw4EDPaQ==
X-Received: by 2002:a9d:4b84:: with SMTP id k4mr6823343otf.262.1625488384577;
        Mon, 05 Jul 2021 05:33:04 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id p18sm2586451oth.60.2021.07.05.05.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:33:04 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 31/35] pull: improve --rebase and pull.rebase interaction
Date:   Mon,  5 Jul 2021 07:32:05 -0500
Message-Id: <20210705123209.1808663-32-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
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
index f4f822700a..e304b22bd8 100644
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
index 7ea558651d..b3b70d145f 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -597,6 +597,16 @@ test_expect_success REBASE_P \
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
2.32.0.36.g70aac2b1aa

