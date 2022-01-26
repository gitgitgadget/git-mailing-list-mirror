Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABDCC3526D
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 13:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbiAZNGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbiAZNGE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 08:06:04 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAEBC061763
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:06:01 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r126so3542135wma.0
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kn5A5ztXO9lU6Ur5jZrZbKKDzEmRR/R6glConAkDM7Q=;
        b=ASSO+W1DJ4bkYEM3lAi5iFfRAn3LY9okbJet7MBdMqytb6C4TVgxpSdOBtsOkT7/hN
         ldtYiJ8Ok+RpENVLoCCpEh1SjsW8LPKvbTbPSFaHdYfYcqE+r5U9LUwizT0jNJ5V4Ej3
         5+WFNyqSAjM1Qwsp+EfQRcGu87mSY685+XEXznXhmKok2R2Vb24TL07FKXK/nk0UPNfK
         e7ORjmqkQWSy18mTddn3gZysuJ5Zaff15EVYxs7XKb/ittCvy5+cdnb6//q7dSEDAFEb
         XabsGHT7AZxsZzvllEynnRehlDG9RUkVxuza7Y9AJG+bAqhtM2AcRuJHGetMTTYiHhwd
         Teyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kn5A5ztXO9lU6Ur5jZrZbKKDzEmRR/R6glConAkDM7Q=;
        b=Fx3YF0QdtrMCg20eR4csdhoSZXMD2CyrRVyyQv7fynaehynDHXOqQEU2pT+VCjp6h7
         A9nWeeWLrGWbUN04SJ21ER9HYSHwGvyqlE6dg1tNima94yrAHy3VE8zhRcppezkCSXbc
         QLtEjRx4BRkVcNIPziKICBhTaxHXgMAnlLs9EpXct5CS9xTNxiLDlJEvc1h8LLmG3ziG
         m+psEUjkIoLKZMPYwYVcdWkobqMvS5OlYmpYOMG1yvK3/Q+EYHIKjhBtxvXm2lAi8/1z
         FLP6nyZ2VofLLgE7JFV8FV14xhIeRs2Bdm8SYjL1LvWLZXSr/d7egjlKiELJ+KD7aLby
         i3BA==
X-Gm-Message-State: AOAM530oNrSkLG1+mNbOxXNhCkg8sZzVUniFSBYhM4MdRF82PeemYAPy
        p0ncXkAQ2ENCftssHeoFS6DUP2Bh7yI=
X-Google-Smtp-Source: ABdhPJxpxzmG/BlsMqT+ih3zXMlFdYblXtswbpoEzaHfGrMRxaQP0iw/Ame0qsM6cuTpCQFMTt4nhw==
X-Received: by 2002:a1c:2bc4:: with SMTP id r187mr7078655wmr.28.1643202359603;
        Wed, 26 Jan 2022 05:05:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13sm20515370wrm.68.2022.01.26.05.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:05:59 -0800 (PST)
Message-Id: <ad7c646798780bfa2fb33bd40b1196802b8a3d27.1643202349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 13:05:45 +0000
Subject: [PATCH v3 10/14] rebase: cleanup reset_head() calls
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If ORIG_HEAD is not set by passing RESET_ORIG_HEAD then there is no
need to pass anything for reflog_orig_head. In addition to the callers
fixed in this commit move_to_original_branch() also passes
reflog_orig_head without setting ORIG_HEAD. That caller is mistakenly
passing the message it wants to put in the branch reflog which is not
currently possible so we delay fixing that caller until we can pass
the message as the branch reflog.

A later commit will make it a BUG() to pass reflog_orig_head without
RESET_ORIG_HEAD, that changes cannot be done here as it needs to wait
for move_to_original_branch() to be fixed first.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 3d78b5c8bef..fdd822c470f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -675,7 +675,7 @@ static int run_am(struct rebase_options *opts)
 
 		reset_head(the_repository, &opts->orig_head,
 			   opts->head_name, 0,
-			   "HEAD", NULL, DEFAULT_REFLOG_ACTION);
+			   NULL, NULL, DEFAULT_REFLOG_ACTION);
 		error(_("\ngit encountered an error while preparing the "
 			"patches to replay\n"
 			"these revisions:\n"
@@ -1777,7 +1777,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			options.head_name ? options.head_name : "detached HEAD",
 			oid_to_hex(&options.onto->object.oid));
 		reset_head(the_repository, NULL, options.head_name,
-			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf, NULL);
+			   RESET_HEAD_REFS_ONLY, NULL, msg.buf, NULL);
 		strbuf_release(&msg);
 		ret = finish_rebase(&options);
 		goto cleanup;
-- 
gitgitgadget

