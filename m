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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD117C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78F161139
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351111AbhIHJu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 05:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348951AbhIHJuj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 05:50:39 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A0DC0617A8
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 02:49:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso1086364wmb.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 02:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=bWPhQXgHi9Ug5njzCVgWdfnwNqZP6vAfKFv1PzIYfSc=;
        b=oCZgEaBHmlq3VAiRVbfn7lgleaF5LipHaVnfomueqHT7VOC9OWqSppntOFYYhzwRxe
         9FOX8a3U/p0DP1ogzGevdVYsWgvx0fygM5z2ov53C2OsITZ4oyiR066tVtfuEF1KjhuK
         EkZ25PScA6yJSU4XtA2fgqfDeaxKuDlKlEC74lLMDr+bXiw2BwVB1Qv8iwUfnbdrXpJ8
         FkuEpGiFjZRnc96gqEd+caVX9rBfZSkM+xrybq6mzvulKegpVfmJPbjwLQHgbMxhZ023
         HOsffFakFHn1dFYLN4kcVKKlwzoKsomAuzBXCY/WYfYV1XA1GQAY7XWIIh7XxZi75vzI
         OEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=bWPhQXgHi9Ug5njzCVgWdfnwNqZP6vAfKFv1PzIYfSc=;
        b=QNscd6Fu80gwtzfBBdhFaz2dxj61KHc17QbbCfxEOezGKduFj/WCKpXqDaEpMuuRxQ
         ZBenvSmYctVj8Py9ent0rr2Mrx12NdvlA6R1Zv3A8k7wTEQw4d2Kg0Yjk5FvfrQr/QqI
         dCwL8YzQ2+Izpu31VEgGF1T02LDteEjxu1yGqqCHLjX7tTINTv0bbk16pASXde61qcyU
         X2XYXfAjAMZL/pf82MV5E6Zcw+2jFOMiRVSexHqdcuKoym7qKR1EBUoO2DKT4bD/x+bb
         8mUpBdTNeCXwKiKuun6ICTGDLn6EJls3LNAkszYQc3V65xQcLKnGBh71bpciIrer9CsF
         P3Tg==
X-Gm-Message-State: AOAM530P9Bpgq0ZTfOaMeaW5K1G1eO4cGSrXIzy9mR+iLy2PgAZGnnOj
        HH2PDHrIcxtEVuCm0IABC4ft3+1IOb0=
X-Google-Smtp-Source: ABdhPJw793ovxXFl6wFVKfYNcqJcb35eNiyGAtxd2hv3PiH02x1m89G6IPkNizXvpf/bBESIsne9rg==
X-Received: by 2002:a1c:7403:: with SMTP id p3mr2725565wmc.72.1631094569059;
        Wed, 08 Sep 2021 02:49:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16sm1626555wrd.47.2021.09.08.02.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 02:49:28 -0700 (PDT)
Message-Id: <f0644cde7252920abc831e7a81f33c85f17e818b.1631094563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 09:49:20 +0000
Subject: [PATCH 09/11] rebase: use our standard error return value
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Git uses −1 to signal an error. The builtin rebase converts these to
+1 all over the place using !! (presumably because the in the scripted
version an error was signalled by +1). This is confusing and clutters
the code, we only need to convert the value when the function returns.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 48ab7d9ae3b..e8c3c77bab0 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1573,7 +1573,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head));
 		remove_branch_state(the_repository, 0);
-		ret = !!finish_rebase(&options);
+		ret = finish_rebase(&options);
 		goto cleanup;
 	}
 	case ACTION_QUIT: {
@@ -1582,11 +1582,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			struct replay_opts replay = REPLAY_OPTS_INIT;
 
 			replay.action = REPLAY_INTERACTIVE_REBASE;
-			ret = !!sequencer_remove_state(&replay);
+			ret = sequencer_remove_state(&replay);
 		} else {
 			strbuf_reset(&buf);
 			strbuf_addstr(&buf, options.state_dir);
-			ret = !!remove_dir_recursively(&buf, 0);
+			ret = remove_dir_recursively(&buf, 0);
 			if (ret)
 				error(_("could not remove '%s'"),
 				       options.state_dir);
@@ -1958,7 +1958,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (require_clean_work_tree(the_repository, "rebase",
 				    _("Please commit or stash them."), 1, 1)) {
-		ret = 1;
+		ret = -1;
 		goto cleanup;
 	}
 
@@ -1993,7 +1993,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 					       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 					       NULL, buf.buf,
 					       DEFAULT_REFLOG_ACTION) < 0) {
-					ret = !!error(_("could not switch to "
+					ret = error(_("could not switch to "
 							"%s"),
 						      options.switch_to);
 					goto cleanup;
@@ -2008,7 +2008,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			else
 				printf(_("Current branch %s is up to date.\n"),
 				       branch_name);
-			ret = !!finish_rebase(&options);
+			ret = finish_rebase(&options);
 			goto cleanup;
 		} else if (!(options.flags & REBASE_NO_QUIET))
 			; /* be quiet */
@@ -2085,7 +2085,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		reset_head(the_repository, NULL, "Fast-forwarded", options.head_name,
 			   RESET_HEAD_REFS_ONLY, "HEAD", buf.buf,
 			   DEFAULT_REFLOG_ACTION);
-		ret = !!finish_rebase(&options);
+		ret = finish_rebase(&options);
 		goto cleanup;
 	}
 
@@ -2099,7 +2099,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	options.revisions = revisions.buf;
 
 run_rebase:
-	ret = !!run_specific_rebase(&options, action);
+	ret = run_specific_rebase(&options, action);
 
 cleanup:
 	strbuf_release(&buf);
@@ -2110,5 +2110,5 @@ cleanup:
 	free(options.strategy);
 	strbuf_release(&options.git_format_patch_opt);
 	free(squash_onto_name);
-	return ret;
+	return !!ret;
 }
-- 
gitgitgadget

