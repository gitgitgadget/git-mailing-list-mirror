Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178FFC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhLHPBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhLHPBh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:01:37 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8183DC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:58:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j3so4588472wrp.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ikYH1r6fCA0IM2JUoU9OQOizt046BswPyLilaHP+nmI=;
        b=Gy31vjjyEnG0BIVJJGbfbhbFgD/SJ4gUsfC6F9lqz62pEnkhYxltUgZ374j96U810J
         TxH0RztuJRHqtMwbv58Psxt4ZgGNkyhHJnd/eagKcw971HkyUVkv4e9dls+Fs7ywDSMI
         8XdWMobNiAxJc8QkVou3d82IKDYOwo82sQGVi/4PZVRY9u4E65Ggaf1DQBFV92XQuxar
         +AIdA5/1jEWwpsCIZLkVZC7GTD07h2om9NNFufloISQWpM4vkP9m5YYTHrfSY3wZzjfL
         DQj3G8/SPO2WZoxgvTOPeLp0ZnWUonyhkS/EnNhPW3b2P1jyQw8JuCH0JUG1CU6L439f
         HeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ikYH1r6fCA0IM2JUoU9OQOizt046BswPyLilaHP+nmI=;
        b=R1fqacbsHNb/rxJtGF1BwQBxrMaKpvxYJ3Wu4/Z3bakqwemXdMVlviNMKGG9uerNT8
         Kp39wkF9db28FwsMokSAdPz2NaH9Itzn2ZhBXjiUUWGhSpSxxxOc5lWS/Xr0pgSWEMh9
         mHSlrwlb97gvznh378WFOJZ5F/WXT+z+TDv2+dYZA3fd2iA/TDumi1vijOsSiTnZ6cFS
         ip0Gyjb20DIzp+AKBPvcXSiJu6Fj0weiwSuWtQ8DtwnvCDyAAvb7xrjcbx9AmhtNtkG1
         d83C+IlVhbRXp+Fge8yH96cqkLrzP/y0yHFfs+MJ1SdbtHJ4WS8EZwXzXGitTcKZL4Yh
         ZsJg==
X-Gm-Message-State: AOAM531/JzXBcO4XqCjYlOFjnHHb2Ls2OBJ+hYiizvm2l5VleGyn99E6
        fVpKjIyW2Mwkb6Dm3F8m3EbKmaWc0tM=
X-Google-Smtp-Source: ABdhPJxGhWAryX2WJH5wF7bTRH/2/DVidvjZz+f2GErPLe/Lbsuh2kKZFbLN0JtwDyO0RvKct9PZMg==
X-Received: by 2002:adf:f602:: with SMTP id t2mr60485251wrp.539.1638975483930;
        Wed, 08 Dec 2021 06:58:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm3725438wmp.9.2021.12.08.06.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:58:03 -0800 (PST)
Message-Id: <0e84d00572ed9a99d68ec856b779f550b2a934de.1638975482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 14:57:48 +0000
Subject: [PATCH v2 01/14] rebase: factor out checkout for up to date branch
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

This code is heavily indented and it will be convenient later in the
series to have it in its own function.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 34b4744e5f3..f5c37b7d4a5 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -812,6 +812,23 @@ static int rebase_config(const char *var, const char *value, void *data)
 	return git_default_config(var, value, data);
 }
 
+static int checkout_up_to_date(struct rebase_options *options)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret = 0;
+
+	strbuf_addf(&buf, "%s: checkout %s",
+		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
+		    options->switch_to);
+	if (reset_head(the_repository, &options->orig_head, "checkout",
+		       options->head_name, RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
+		       NULL, buf.buf, DEFAULT_REFLOG_ACTION) < 0)
+		ret = error(_("could not switch to %s"), options->switch_to);
+	strbuf_release(&buf);
+
+	return ret;
+}
+
 /*
  * Determines whether the commits in from..to are linear, i.e. contain
  * no merge commits. This function *expects* `from` to be an ancestor of
@@ -1673,21 +1690,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (!(options.flags & REBASE_FORCE)) {
 			/* Lazily switch to the target branch if needed... */
 			if (options.switch_to) {
-				strbuf_reset(&buf);
-				strbuf_addf(&buf, "%s: checkout %s",
-					    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
-					    options.switch_to);
-				if (reset_head(the_repository,
-					       &options.orig_head, "checkout",
-					       options.head_name,
-					       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
-					       NULL, buf.buf,
-					       DEFAULT_REFLOG_ACTION) < 0) {
-					ret = error(_("could not switch to "
-							"%s"),
-						      options.switch_to);
+				ret = checkout_up_to_date(&options);
+				if (ret)
 					goto cleanup;
-				}
 			}
 
 			if (!(options.flags & REBASE_NO_QUIET))
-- 
gitgitgadget

