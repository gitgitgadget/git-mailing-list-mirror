Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAF2C4320A
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3DFA610E6
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbhHTPl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbhHTPlW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 11:41:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03C0C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:40:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v10so3642656wrd.4
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BgsF+fo7/k1/tpNtuEPyAUz7wglr0K7widR0CaHWWCQ=;
        b=ZFl5BIlJrvTPge8D2ga6qUZXq6yHbZjGRNjGowt03vyUPsau7gDM5zLzXXKJ8zL1aw
         Z7XHbAy6qpFaF5hv3do3C5elX6ZOq99a0y+6vVycBSQYd5AxwMRsKktEzwVb/PbCTnGk
         sCnKuck73UJRQRB6ctp/+AjgjqrbCNiqEDdSGh+xy7atP2PhBURB8IrdCvVUrzv/xvwn
         lUaLI/190hI11KWD8QwsvuNb7Pfq9ecl7SZH6dYkDxG9iqtw4fDdqA4/0j1UiKeIc1Fr
         5ETGibGiFaGy4oi5MPrMaMEHMznywMlHC4Gz8Ta/w+IF4qjILUciuzvVhLN4lyAoNMd0
         iDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BgsF+fo7/k1/tpNtuEPyAUz7wglr0K7widR0CaHWWCQ=;
        b=EJhAgnKs2icuvNrI7ClneEmRjueCit0VpKv05dehU9aZ/+sNfyAScpAT4ltGYQakmG
         2GGypYwiFPEzCYthhmuZ2rbVhZbHeN5lermUs9lyFo+V0O657Zq8gCM05Ec/MjP9pWUg
         Vkoos9fOPkarey03dDaDZr45Bp9V6PeFvNwm/XixhxG1daZMv5tuGFpgA1h9kwOwQ8GN
         gsfNbyhqDpHB57eZfs8K8JhdHZqV+mPb1uVcAKg/v2BO1fhYX16NAXX/TjysNFrY+cje
         UHp3nP3hSNvXptaKCIZ2cJBdxTBDVuAg6e59ZYFDswrtVmnKRhh+PpeH/JtG8oVw1/zn
         R7tw==
X-Gm-Message-State: AOAM530DDfmMUwUTUykZjaXBgVeJYpNsAAES6YaH7IESYXoPTAQMo6gV
        1HOoLZEoq5ZUekVtvScEPT76zN9LHT8=
X-Google-Smtp-Source: ABdhPJzyuPOMFjXkerT3Oi/4QInMVJGX4mfEO8pRpQTgalS+Xa2YJ4T58aS9LIjgGbhRK0g2GvVu6A==
X-Received: by 2002:a5d:618f:: with SMTP id j15mr10707181wru.80.1629474042473;
        Fri, 20 Aug 2021 08:40:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x19sm5375185wmi.30.2021.08.20.08.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 08:40:42 -0700 (PDT)
Message-Id: <b6981ea5439416f57e97575f89bbe8d2f3f38527.1629474038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1015.v2.git.1629474038.gitgitgadget@gmail.com>
References: <pull.1015.git.1628860053.gitgitgadget@gmail.com>
        <pull.1015.v2.git.1629474038.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Aug 2021 15:40:38 +0000
Subject: [PATCH v2 4/4] rebase -r: fix merge -c with a merge strategy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
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
