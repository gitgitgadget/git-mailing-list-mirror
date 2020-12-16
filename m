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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7376AC0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465AB2342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgLPSwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732237AbgLPSwA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:52:00 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D408C0611CF
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:45 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s26so16309433lfc.8
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GP0HxVOUnxJUlHaIw6gjQUPUFR2A5WUAG2gP6dV+ons=;
        b=L6Oe0bs2Cf+hNyvUYOOFGp7B8I8NNUa6x3djOlLwdeNFt+p5Q0VJzOhMD4HItkWOzt
         7UYh+gNhI4su5YwytXAhOZohrJzr8a7ThkuOis+9HtPbvPSR9jwWrewiGXk5Z1Kw275k
         HP+seK5diJr90LsRKC3XxQtaROWc/SkSmzC7KOf/f+aGImoOg+UMJx8MIpFRU6e+IvBr
         US0kSMqF5gbQo4DMMwA8lSushCNSXMqb8LG0j3Qv6nyvYgnq9yigrTym33b0RAS8t5z6
         zelNpzchmu31CmN/7J3huXFeHuG/ayohNR+q33EZPluSGmoO9GuPfj9dh9adxgZcsyMX
         P+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GP0HxVOUnxJUlHaIw6gjQUPUFR2A5WUAG2gP6dV+ons=;
        b=pPgLe4e3Nz5FnHuGjKBi/5X87wKRNaERTierJMhzv9ZMqodaTru4ryZ36gn77T8ioT
         BXEotH2/P6Xt3vh4BAO5XF5ieudgkLbwfWj+ch1CbPeb02JMlmPWSs1EnpYJesbNvSu2
         eqSxIWY8qJ3HUIm71WysPgjDIYVJsj38SCJN4eTsa/hy09/JrENqByGi/iMKHunHHAuK
         tH6muHWbI/VWHNeCAMPHKJcistoBmT0/NLXou4vw+Oa2o1vtExUIHgOiYv1SZJTowvkg
         rQYkyGTgrpI+dlCPVaz+5Fc8tHAgx+lxDPjXKLxWkCKdaQ5v0SGRRh6OoD1SkS4GQ6Ta
         0GTw==
X-Gm-Message-State: AOAM533ryGg1d1ecSELethgGTe8FQUrFhaUTRu4QS5/1VtYO/jCa9x/S
        TraKhJT8THfkL7ZdDO2zke8Z+PqNSYs=
X-Google-Smtp-Source: ABdhPJyns7Oxd+duiR4S14tj2bjRRWnN+nQ3jZp2ql+i9fsS2wA+x8DHY8SDuHJVWZZAvKTAV/5l/g==
X-Received: by 2002:a05:6512:3054:: with SMTP id b20mr13216569lfb.45.1608144642795;
        Wed, 16 Dec 2020 10:50:42 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:42 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 16/33] diff-merges: fix -m to properly override -c/--cc
Date:   Wed, 16 Dec 2020 21:49:12 +0300
Message-Id: <20201216184929.3924-17-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Logically, -m, -c, --cc specify 3 different formats for representing
merge commits, yet -m doesn't in fact override -c or --cc, that makes
no sense.

Fix -m to properly override -c/--cc, and change the tests accordingly.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c           | 1 +
 t/t4013-diff-various.sh | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 76ddbc37bd59..5d20e329a661 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -29,6 +29,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 	const char *arg = argv[0];
 
 	if (!strcmp(arg, "-m")) {
+		suppress(revs);
 		/*
 		 * To "diff-index", "-m" means "match missing", and to the "log"
 		 * family of commands, it means "show full diff for merges". Set
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 64d9fce44614..8d8178a8a616 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -329,8 +329,8 @@ log --first-parent --diff-merges=off -p master
 log -p --first-parent master
 log -m -p --first-parent master
 log -m -p master
-:failure log --cc -m -p master
-:failure log -c -m -p master
+log --cc -m -p master
+log -c -m -p master
 log -SF master
 log -S F master
 log -SF -p master
-- 
2.25.1

