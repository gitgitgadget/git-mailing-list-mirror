Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C743FC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiCAAJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiCAAJF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:09:05 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8D99A99D
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:25 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id x17-20020a17090ab01100b001bbffb2c5f3so365642pjq.9
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UH8t/E0TczNz4tziesvMRSUOID+d/VyUA9f/OELjrWw=;
        b=lgBNiQlSH4SXN+Yp2yAlZcf2q6Kqv8rEPBg5FV8m0fRrMgOt2r3/BtfWTymao/j/3b
         TStFCj/ETcqTCghbJg60EZ4cD7h2HL88fYul5BN+WS9ewjonThXprBr2EUuUmYwDvj5m
         nmcbWbFtmqq8j/A3D04EwWLfr6FiBniT0GhJVNQrgEuJbknf41FuBYi/svG7EG+8uB3N
         7v0kAql1NeCfs/gH2tlgSwD4PgOK+wui93WlVGrR62iDTH6UG2VwH5+g30824BjcV32u
         9IPMfFizWXiyrfk81AYHUF0nnyM7bq40hqL1IM6Rx9FkppAw6TNTd2HivLSKVETISbUw
         IhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UH8t/E0TczNz4tziesvMRSUOID+d/VyUA9f/OELjrWw=;
        b=ZlN2IYwC4XgO88KyFhSh4U/qHkKbqK3THOZCx5Qf4CKPkJm1PFBzwLBGj4JRHTwxpF
         xPAYB+mwAtPm9Qg2zq+brFF3g8yLNyAVZWpPYm5Zo+cA2PLbijwCgpjqjEVtlXeDG4KF
         3cPzHXdxPS4Sq0FhO7jzmiH/l5GvuJ2wfTL1MuP//UFT20vPiVtMaE3xHKwPw4bfzt8X
         FhkOxZUHZjsnYeFCN8AHte+Y55UiYLO3HyH4mMeRGmv9F+y8qVlK5YWDJtEVldqwP+dK
         8kuAEWZ4t2uhxuEIWIHrTZGbOcPIAk8nu7RQlpGhrAa+yinCIVUHOnCheX7KbLvKgXC5
         1EsA==
X-Gm-Message-State: AOAM533z5EF0i01hM1oPqM9sJJ2M7YZ6BYx4KnSjfUznCLOOkNUmDLjz
        sbofe99kG3gAnQFIJ8ahfw/KJoiVZMdMLbBXRuHHzJeRPQJXU5uU+oCVewKMS4T/+kUHLmxMFDL
        rtaPIwVsE2LcUwHWIOtNCgHEum1uCkAyqeq1eiZm/b51rTKlDpTvKeUroCg1d2z8=
X-Google-Smtp-Source: ABdhPJy1biFBBM2uAV5MadEaMj78idHnqPio7iaboW+67N3AEOJ2zMkhzw15jlJqrKeHdZq9c1S2o5vKbwXYxQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:86:0:b0:36c:48e8:627e with SMTP id
 128-20020a630086000000b0036c48e8627emr19506515pga.53.1646093305009; Mon, 28
 Feb 2022 16:08:25 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:08:05 -0800
In-Reply-To: <20220301000816.56177-1-chooglen@google.com>
Message-Id: <20220301000816.56177-3-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH 02/13] submodule--helper: remove update-module-mode
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is dead code - it has not been used since c51f8f94e5
(submodule--helper: run update procedures from C, 2021-08-24).

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index eeacefcc38..c11ee1ea2b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1957,29 +1957,6 @@ static void determine_submodule_update_strategy(struct repository *r,
 	free(key);
 }
 
-static int module_update_module_mode(int argc, const char **argv, const char *prefix)
-{
-	const char *path, *update = NULL;
-	int just_cloned;
-	struct submodule_update_strategy update_strategy = { .type = SM_UPDATE_CHECKOUT };
-
-	if (argc < 3 || argc > 4)
-		die("submodule--helper update-module-clone expects <just-cloned> <path> [<update>]");
-
-	just_cloned = git_config_int("just_cloned", argv[1]);
-	path = argv[2];
-
-	if (argc == 4)
-		update = argv[3];
-
-	determine_submodule_update_strategy(the_repository,
-					    just_cloned, path, update,
-					    &update_strategy);
-	fputs(submodule_strategy_to_string(&update_strategy), stdout);
-
-	return 0;
-}
-
 struct update_clone_data {
 	const struct submodule *sub;
 	struct object_id oid;
@@ -3430,7 +3407,6 @@ static struct cmd_struct commands[] = {
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
-	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
 	{"run-update-procedure", run_update_procedure, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
-- 
2.33.GIT

