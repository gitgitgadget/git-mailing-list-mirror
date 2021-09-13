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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C470C433FE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879D660F6F
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344063AbhIMPrF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245581AbhIMPqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:46:42 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60190C0A8899
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g19-20020a1c9d13000000b003075062d4daso273596wme.0
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=zT1wBgFnMRZCsLcFWTrqBz0f8Tr5pzLEPGPlNRXpipY=;
        b=qeeMed0NALZe8J/TpJe9QSDtiiuXTlIrUfFhJkHfajJab1x9T3ak1HX+pR8F3JqATb
         7W/47nmvgzwkidr2cZcoxPJRZ40lsJ3eIX1YCoISXeYh9N6Sekzn+5qVVg/goJaHWwLX
         2a5aBciIogPs29aOPny8g+N8RqXeRvyrrtPo3Do93X4lqqdHcGLp325yKdYMm4iYTIal
         T9xSTPWuzxA1iEqYc7IcLmod2FdVBMXci+b3Y1LlMwO4/91hfGS6nGgRBBsSjnbzfEi4
         AkAVa+sARqceWKzkt+b4zNWNDZdFNgCPzTKSB7G5gVOMPR62wtNDNw2wrsluVYpzxL51
         8X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=zT1wBgFnMRZCsLcFWTrqBz0f8Tr5pzLEPGPlNRXpipY=;
        b=48ho+FQY/Xej8RjEepLdflduelOZ2lLo7j201MRGg3pUmbLJY2OiFY1LH1UgNHrY0O
         TaHm9ROPrU3MdHh+LkwXwC8nx6lPIzXShU3whc3OoWad+O9FfY7YC+xYBi9a3EvP3toT
         SJTDUB7SBnIlkTb+spQf1RohjFUgGvoTgbWPAWcQp/q9M7B13ruU/jUlRmPSwfR91aDS
         nJYxJg3zKb+rkXAgt56gMvFy1E2hyVGCYpBdlDUnDxvlPbVP/OAZJ+29HdGg18isDkW8
         2DhcjYR6l7zDH1CCYck10KZ6k2/gawAWp6N4OOqwCDsw9EUrwMCOAuv79Nv6I/Ax3u8i
         LsxQ==
X-Gm-Message-State: AOAM533Z4YXE2UaAAO9/b5mwC1xYiOa9CAbw0aHKUtZ5zwZrmCaMehH/
        mmygHqDkxNSIAynOE74LvEK1HeJjWMo=
X-Google-Smtp-Source: ABdhPJynGSFu8ER7mEznN4FddRqrxK2S+L0MA39g4lGJmh2RyfH5t6U5aGGf1BOQia2nn/FsAl3vHQ==
X-Received: by 2002:a1c:234a:: with SMTP id j71mr11667759wmj.11.1631546373034;
        Mon, 13 Sep 2021 08:19:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k4sm7146484wrv.24.2021.09.13.08.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 08:19:32 -0700 (PDT)
Message-Id: <ad940b633d08ac3e364adc7015cfc52ad0f9d900.1631546362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
        <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 15:19:20 +0000
Subject: [PATCH v2 09/11] rebase: use our standard error return value
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

Git uses −1 to signal an error. The builtin rebase converts these to
+1 all over the place using !! (presumably because the in the scripted
version an error was signalled by +1). This is confusing and clutters
the code, we only need to convert the value when the function returns.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 69a67ab1252..7905672d8de 100644
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

