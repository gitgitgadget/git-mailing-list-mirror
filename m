Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E322C3526D
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 13:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbiAZNFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiAZNFx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 08:05:53 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486C4C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:05:53 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h21so8131222wrb.8
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ikYH1r6fCA0IM2JUoU9OQOizt046BswPyLilaHP+nmI=;
        b=L+UkR+DYCtJultBfPHuvy5OrrctM1gOGDurv57Z2JOZED1GnAJ/gTk/WBSWfPlVF9C
         5jq2z8nXoBEcWBLZp3K/YU/Q9txi7F/jPQiHAlPgii53Jb1wCxQsn8ePMyzMtuM8HwCv
         VkbuSbUiRsEjkXUoG8hNh2HOlsGp1sAKsALClTmdinWCd+rKLwe9gGJhhZzAlg26TOz/
         y0+fBHWXEBR2Tq839XTMDMODoYhC0BJDNNzcr1BBOmCimFg3713uC+fifDn/ZuOe6tSt
         b3bmFWGh150ItlqxlabU3Da4FZFyw49hDby+qFZwCLalbh2tmvil+yWmPKTM40ttW2nu
         cVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ikYH1r6fCA0IM2JUoU9OQOizt046BswPyLilaHP+nmI=;
        b=hl/S6VhKbYqlvaxzHvjpKxYIh1y2VwYpOLzR5iWCAbwgVZK0cqK/2oLVAAB4G8ocjU
         HJRy5DPCzuuXdqTe4V/+FvzLlN5xIfw6ZUmhe7h9Q+AGDZFgDAFC2p6qKYrOCZGLqRFQ
         y7h/5tgWBfoGlkjT/Vst6OPXrHXMyXdPcpDuXLpDmTI6Ns05izELC9VCSIv//60ig98l
         HnMYF+D9ROpQgrkajd8JzoKxf7HaVlw5iCEmHIfRsdZ4WfsVMmdQYSXZh+BJG0RbxlZ9
         85yQygsXr6v39wa8h7eZiH7ym49G9N9THvpPMe1M9oEGqH0sxEEoo1NJvyXeA2Ds39mP
         IKjQ==
X-Gm-Message-State: AOAM532yv0827zu98r5zIv5Mj/QwevTB0VHJPTFh42hrjIpg6xsbPIOp
        B8laupH8FSd0Eepd5noXfl1IpcJK27w=
X-Google-Smtp-Source: ABdhPJw6XU9SA4l2R0WJolZNqzKfYriwpe/yC7ij6qmG41zbLlf0d1eRvc1NBDVkfzLqAtzDrCvSIg==
X-Received: by 2002:a5d:5088:: with SMTP id a8mr23390973wrt.326.1643202351757;
        Wed, 26 Jan 2022 05:05:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12sm19156107wrd.98.2022.01.26.05.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:05:51 -0800 (PST)
Message-Id: <0e84d00572ed9a99d68ec856b779f550b2a934de.1643202349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 13:05:36 +0000
Subject: [PATCH v3 01/14] rebase: factor out checkout for up to date branch
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

