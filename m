Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0A0C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8645B61153
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350239AbhIHJuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 05:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348741AbhIHJui (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 05:50:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D208BC0613CF
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 02:49:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so880044wme.0
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 02:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4JiF5aUr7lHwrDLZ/aDrCns+OORVJQykve1EOZCFWhs=;
        b=bzadVsZ8/A2S4ED5amTxRc3wZdlLr0V4IFNfCK+WZx/oU6vrBV8D5ypCws9Zio+5Zq
         M3qqo8PVwwUppQXJH2R0o79Zu6YjsyA+othDRQXjAm+qYYSLI46G5xAT1yaaxHBYKBZX
         22xovetrRSfGHxyl132vs3WG+8yuMoB0urOvkAddvIwCexuXMM5UV3iERvVockWagJtF
         B17XwQiLuAJOnAt7OziwEKwyJcKcZt+CqFK/QCI1V5TdQeIOz+KbTR1QDO7NYMrrjPwZ
         vFhO1H9VbaYV1admP2CPeW0+1Pg3LE8uD9BZVpbpL9h/eoaiciR18Vhyfjg3qBlUhWXz
         FI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4JiF5aUr7lHwrDLZ/aDrCns+OORVJQykve1EOZCFWhs=;
        b=UOu/VWEY5X3opu0rI3S0blU7iS8mxh+jeSbLehAyFcjCdAIE93wIgW0MbF1zdv8kj9
         iLkf4xejyeAuX+/Q9mk6u/I+PBgOD2WokJaeFo2YvyhQTzUp1xWQMdXeyFHzmr/m2jaw
         CJGzuTVwY+baGpM68d24ytIR56Lcue7+nLGH76EFO1Dw76aJYX3+rnv7Uz5WG4+xevJp
         4UoA5EEj9FoU/May4f/8bzH8Et6qYhzYijuP+iquRpOw/jMTDdw7XgRtEJpXyxZxfGGX
         umSx0cChnsjx+0lIzNPE1ayMeUATus0MleyBt4xEY31NoDs+B/6c+FkmVIM0iPZM1nSY
         kefw==
X-Gm-Message-State: AOAM533fhgg2A0/PP1ybJsvxspVMD0s9wCATltzqy4FFoGjeF0lKCYlR
        3JCAe1Cvj5zgtwD8xtkxIAH/rNZvmvQ=
X-Google-Smtp-Source: ABdhPJzRfUj39r9GkSuOrygkrC8Ae3fI1PK/BcyycxgyPVpJ9G9Qch02Yh1DzxnlAp4dp8K4Pct/eA==
X-Received: by 2002:a1c:4e14:: with SMTP id g20mr1292789wmh.64.1631094568531;
        Wed, 08 Sep 2021 02:49:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s205sm1583986wme.4.2021.09.08.02.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 02:49:28 -0700 (PDT)
Message-Id: <35b6c26c8f934e3bac984014a59c095c15416c79.1631094563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 09:49:19 +0000
Subject: [PATCH 08/11] rebase: remove redundant strbuf
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
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
index 33e09619005..48ab7d9ae3b 100644
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

