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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E9BC4320A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 13:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D200610A5
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 13:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbhHMNIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 09:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240582AbhHMNIF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 09:08:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A12C0617AD
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 06:07:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x12so13199006wrr.11
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 06:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BgsF+fo7/k1/tpNtuEPyAUz7wglr0K7widR0CaHWWCQ=;
        b=pLkIQJdr3XgV6WOwIF3UBg8pgh+3m6kehG33OPBvIYwt8LDAD9J0xmzpE/e5qu7vHi
         Q1CufLJI+7Cx3QpyW2J1ic6mBP1nlSSuS72BkV3WM2ZEuqr4MVb6Xjcem2P3haxRkiBa
         zw8i5WhoXh8FX/ILrkBgLh46QBKJ5/IICo+xeKISmuaJM9X0cGhdzKlshRVQQXLyYhJH
         ysYwFiOEoCJsyunco3/pEf1/Lj6BlUlkXxYurTqTr6NhERAxenlLUXiBzQwr4u9z2Fum
         508nKfUvG3+b4i6u1x+q22hmTYOoz+bxzfmvlhM6lx+IhA5gFHMwL14Jf72YpHZy7dQ9
         PzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BgsF+fo7/k1/tpNtuEPyAUz7wglr0K7widR0CaHWWCQ=;
        b=EfGWSk0RBntLKxtxW1n4Q09Bx7K1VlGO0V2Zhnkuqe4T0WGnKQ+rmPq9NlH2mFa8Fz
         E+rCfmxeOH9U3jHUq2f5131lXIqiomRJUnLReW6DU6uSO85O1lT0uk1XH9w7J8gPdXpD
         9MgWL4qQ2L8Z0dDI2omrOYSWSWamIO8Nt9yjsOkJrqPl6LSckT9UwHhe8Y56oo/bQesS
         ZII6zAl+lL3nWPlazf+ikEn3geuw0yLE2edaVo9gVzAlNznYEoLmmNJLH+jP6aTPe0sZ
         Zfn8piHpjoyGm39BuJgOrqh3ifFxHmtfYwVp31l8lOS9gj6A0frksjAHrnwu0f/0qRRf
         fQOw==
X-Gm-Message-State: AOAM533wLhKfpObhpONoD3pqpahnUnBqTGpJFr/WZ/GNx6uE5Hhs0wCI
        thhqYK/+WXv3JqxNay8kirEJ/Pwfm1I=
X-Google-Smtp-Source: ABdhPJyegiIf3Fnp+MJEK7lKpqEfUkcyXb3w5ghByxz1xV/nv7vS1bDWtVLLuiFr3K9W6QQZ8Hxh6g==
X-Received: by 2002:adf:fc09:: with SMTP id i9mr3152942wrr.110.1628860057177;
        Fri, 13 Aug 2021 06:07:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18sm1550168wrr.89.2021.08.13.06.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 06:07:36 -0700 (PDT)
Message-Id: <f2a2e3531a181f68cee43f832045633aee519fb8.1628860053.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1015.git.1628860053.gitgitgadget@gmail.com>
References: <pull.1015.git.1628860053.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 13:07:33 +0000
Subject: [PATCH 4/4] rebase -r: fix merge -c with a merge strategy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If a rebase is started with a --strategy option other than "ort" or
"recursive" then "merge -c" does not allow the user to reword the
commit message.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c              |  5 ++++-
 t/t3430-rebase-merges.sh | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index c2cba5ed4b1..a19980f62d9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3934,7 +3934,10 @@ static int do_merge(struct repository *r,
 				strvec_pushf(&cmd.args,
 					     "-X%s", opts->xopts[k]);
 		}
-		strvec_push(&cmd.args, "--no-edit");
+		if (!(flags & TODO_EDIT_MERGE_MSG))
+			strvec_push(&cmd.args, "--no-edit");
+		else
+			strvec_push(&cmd.args, "--edit");
 		strvec_push(&cmd.args, "--no-ff");
 		strvec_push(&cmd.args, "--no-log");
 		strvec_push(&cmd.args, "--no-stat");
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 183c3a23838..43c82d9a33b 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -187,6 +187,24 @@ test_expect_success 'merge -c commits before rewording and reloads todo-list' '
 	check_reworded_commits E H
 '
 
+test_expect_success 'merge -c rewords when a strategy is given' '
+	git checkout -b merge-c-with-strategy H &&
+	write_script git-merge-override <<-\EOF &&
+	echo overridden$1 >G.t
+	git add G.t
+	EOF
+
+	PATH="$PWD:$PATH" \
+	GIT_SEQUENCE_EDITOR="echo merge -c H G >" \
+	GIT_EDITOR="echo edited >>" \
+		git rebase --no-ff -ir -s override -Xxopt E &&
+	test_write_lines overridden--xopt >expect &&
+	test_cmp expect G.t &&
+	test_write_lines H "" edited "" >expect &&
+	git log --format=%B -1 >actual &&
+	test_cmp expect actual
+
+'
 test_expect_success 'with a branch tip that was cherry-picked already' '
 	git checkout -b already-upstream main &&
 	base="$(git rev-parse --verify HEAD)" &&
-- 
gitgitgadget
