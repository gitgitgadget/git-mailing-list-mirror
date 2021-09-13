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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F33C4332F
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE79610A6
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245317AbhIMPrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244790AbhIMPqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:46:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEADAC0A8897
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t8so10256526wrq.4
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e27GD8xkMudz3rHhWiu0IkNP5dF76ybzVTv7XI/D+pQ=;
        b=HMDB76bBMizIxvYgk4gvqm92C3eq/vFkix6SNhT/Ko/8nJDrv3bp3O/kY8GVVKWLKe
         cWyfO6+qEywc463jHqVx3Hn5YN8LzuibapqmoxjE5qve22poSrP813lgUKKs7FbjCJyj
         W7nHWCPPN8frrKVbwDsHBZTo+H5bbzKBESm3q6l+5e/w4nscKmqAFyLgyzZHqvYZVHTR
         kXxSpyHHuVigHMlEbM4E9caJnw3XosHb8tgFBH8JiVuMQKROTo3nb31cl6+pCo46qZ3/
         mDqnyC1zwpOKoynxrna64OIkNNcTUMLpT+/GEVLvNB9EP9NXpP9qVaqTLqFAwJLeD0NX
         d2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e27GD8xkMudz3rHhWiu0IkNP5dF76ybzVTv7XI/D+pQ=;
        b=DvjQOZ0ETsy7UXh/Z1sPaWGvk3Lgfs2GRIifFY1qftC+WXftehhLYcDgUEGaLUBkqI
         nTtjW/FjhaHaZRovegtV0dIPOtsOmXM6vA92oTveahMpgm0BxienXRc9XuOqFnJcvXjD
         Cdhl10izwX8j3LTJHLyqr6siG4CG3CZaYANrSfIggpBVcsS49m0PWmgzWERqTJn32VQ7
         1+MIeucP/msQmvA5KURdh3hyzgvT///QiJW29rPrp1hTL+a8VUNhdiqt27CVisOeQXTj
         1p8F1B/JcBiyMk34c4FItizrp+zTpU9/XfWZ1LgdAaavy/+serMVwaAIdlB2GhPcyKnm
         GW6Q==
X-Gm-Message-State: AOAM532l4wfC4TPUCg9Y2l8r/v/kgREaJAEWwa8mQzB8KPIbtu/Z6yIK
        ZpD97wWVOsbnxmW8J1HcXOWc6+K3xVc=
X-Google-Smtp-Source: ABdhPJzTOzDF0LxbPdTJXCG6xzgXP6pNgSV1p24Gb2Wn62Nncr3MzxpTWJP0TlJ3chbHBoQWA7e29Q==
X-Received: by 2002:adf:f80e:: with SMTP id s14mr13215819wrp.435.1631546372483;
        Mon, 13 Sep 2021 08:19:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i5sm6617330wmq.17.2021.09.13.08.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 08:19:32 -0700 (PDT)
Message-Id: <ad3c4efc0272be8eee052a08731656a406f8f90b.1631546362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
        <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 15:19:19 +0000
Subject: [PATCH v2 08/11] rebase: remove redundant strbuf
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

There is already an strbuf that can be reused for creating messages.
msg is not freed if there is an error and there is a logic error where
we call strbuf_release(&msg) followed by strbuf_reset(&msg) and
strbuf_addf(&msg).

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6138009d6e4..69a67ab1252 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1299,7 +1299,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	int ret, flags, total_argc, in_progress = 0;
 	int keep_base = 0;
 	int ok_to_skip_pre_rebase = 0;
-	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id merge_base;
@@ -2063,30 +2062,29 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		printf(_("First, rewinding head to replay your work on top of "
 			 "it...\n"));
 
-	strbuf_addf(&msg, "%s: checkout %s",
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	if (reset_head(the_repository, &options.onto->object.oid, "checkout", NULL,
 		       RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 		       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
-		       NULL, msg.buf, DEFAULT_REFLOG_ACTION))
+		       NULL, buf.buf, DEFAULT_REFLOG_ACTION))
 		die(_("Could not detach HEAD"));
-	strbuf_release(&msg);
 
 	/*
 	 * If the onto is a proper descendant of the tip of the branch, then
 	 * we just fast-forwarded.
 	 */
-	strbuf_reset(&msg);
+	strbuf_reset(&buf);
 	if (oideq(&merge_base, &options.orig_head)) {
 		printf(_("Fast-forwarded %s to %s.\n"),
 			branch_name, options.onto_name);
-		strbuf_addf(&msg, "rebase finished: %s onto %s",
+		strbuf_addf(&buf, "rebase finished: %s onto %s",
 			options.head_name ? options.head_name : "detached HEAD",
 			oid_to_hex(&options.onto->object.oid));
 		reset_head(the_repository, NULL, "Fast-forwarded", options.head_name,
-			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf,
+			   RESET_HEAD_REFS_ONLY, "HEAD", buf.buf,
 			   DEFAULT_REFLOG_ACTION);
-		strbuf_release(&msg);
 		ret = !!finish_rebase(&options);
 		goto cleanup;
 	}
-- 
gitgitgadget

