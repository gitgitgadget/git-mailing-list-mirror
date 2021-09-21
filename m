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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724ACC433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F07660E54
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhIUKZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhIUKZo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 06:25:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D659C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t7so4321702wrw.13
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2qd5TUzrI4IQm2to1klhkL7Kkut0E/FdcBRuFM/3FmY=;
        b=pfFbzgM77TUi9pldPkrvqlT8rl9fyi5QbUApWkhbyMl/bNcLlItaz8fJZqWQvjisz8
         txHxpjTmnUz8bHkAsJ2PMty9uqg9yv81aknkS+Om7xpDF9w2q4YvVFIswEUXr+2FWkAY
         e82lR/lhdwAahX+lyBaB8HXlZ3sZD8Oxw/Kk/9yutcY8OZ2CSuxkFj9JI6QIIG+vbZFr
         tKkdwPUOM9ClvhQmTrIRgOsCKHcakM6diiAvZ6gWF5dd+5WWBhXNb4nu6e94d7a64K8P
         Z40QhD7xrvsFz52dy6lMp0BdPOMfY1Smt6mwd8TdqUftrmufQVB/Yo+CHTjCuq1TWmgb
         8Wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2qd5TUzrI4IQm2to1klhkL7Kkut0E/FdcBRuFM/3FmY=;
        b=OtIvZCa5hCiiDeRU2uPhgf9+YNi0sjvaZsg4Oxt/J6s+qqRoMxSvaR+UpiwqPb6TTT
         FfqWnUpbI8bcIKRa++4VJM3fnVtjNyXvFeEk2FciOa4hEX1JsU2Q1oQFiSKFpT9DNDBM
         rYddKHAmA+2KDWqbSS6UyBjCDuP+9kDLNuNLk39BIfUOMK1fzYZnW77QJr9KIbXHZ95c
         dODXVk0e2vKKIWLtm5yGM8xlnSRGZtRXgsqO8sFWg041DUFB4wkwJUePEncg6W/6UKJK
         AaSnD+Brmgz0MuMCJYQ8QawxnszKs+QRdPsm6dpRVAqsoulWVzjdvAv1WXarn388cPmS
         FoYw==
X-Gm-Message-State: AOAM532J0xiLxbALpI0zsVGCbHYDZqICFyo7WtxkW7+/uOlRD7VxPvj/
        WZgGvk3j6h6H9z4EUNZYpAmPvgGZ9bs=
X-Google-Smtp-Source: ABdhPJwKPrV85AARE9jrA8DoEH0LdcMWhuN5bBc5PzXytsUAHvfxD61F2+1WP6ExlUFnLNnq3caITw==
X-Received: by 2002:a1c:c913:: with SMTP id f19mr3768452wmb.86.1632219854723;
        Tue, 21 Sep 2021 03:24:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9sm2322816wmc.19.2021.09.21.03.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 03:24:14 -0700 (PDT)
Message-Id: <d3af62c746c18dd3124d1ec165d51a7aa627ab07.1632219848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
References: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
        <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Sep 2021 10:24:05 +0000
Subject: [PATCH v3 08/10] rebase: use our standard error return value
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
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
index 6138009d6e4..444e169ef74 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1574,7 +1574,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head));
 		remove_branch_state(the_repository, 0);
-		ret = !!finish_rebase(&options);
+		ret = finish_rebase(&options);
 		goto cleanup;
 	}
 	case ACTION_QUIT: {
@@ -1583,11 +1583,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1959,7 +1959,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (require_clean_work_tree(the_repository, "rebase",
 				    _("Please commit or stash them."), 1, 1)) {
-		ret = 1;
+		ret = -1;
 		goto cleanup;
 	}
 
@@ -1994,7 +1994,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 					       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 					       NULL, buf.buf,
 					       DEFAULT_REFLOG_ACTION) < 0) {
-					ret = !!error(_("could not switch to "
+					ret = error(_("could not switch to "
 							"%s"),
 						      options.switch_to);
 					goto cleanup;
@@ -2009,7 +2009,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			else
 				printf(_("Current branch %s is up to date.\n"),
 				       branch_name);
-			ret = !!finish_rebase(&options);
+			ret = finish_rebase(&options);
 			goto cleanup;
 		} else if (!(options.flags & REBASE_NO_QUIET))
 			; /* be quiet */
@@ -2087,7 +2087,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf,
 			   DEFAULT_REFLOG_ACTION);
 		strbuf_release(&msg);
-		ret = !!finish_rebase(&options);
+		ret = finish_rebase(&options);
 		goto cleanup;
 	}
 
@@ -2101,7 +2101,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	options.revisions = revisions.buf;
 
 run_rebase:
-	ret = !!run_specific_rebase(&options, action);
+	ret = run_specific_rebase(&options, action);
 
 cleanup:
 	strbuf_release(&buf);
@@ -2112,5 +2112,5 @@ cleanup:
 	free(options.strategy);
 	strbuf_release(&options.git_format_patch_opt);
 	free(squash_onto_name);
-	return ret;
+	return !!ret;
 }
-- 
gitgitgadget

