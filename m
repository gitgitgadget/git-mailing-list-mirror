Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F90C0015E
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 04:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjGMEnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 00:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjGMEmv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 00:42:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AA41FDE
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 21:42:46 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666e6541c98so309114b3a.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 21:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689223365; x=1691815365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjV/Zi/O2jxtwqhEjrKlibfSxhgEzPvF4Af2ioSe3Ps=;
        b=C9KKRtgjsFULwPnNtc90Xwo6mC9pgnq8EdxwyZM3i4fK1IE6UV0AQMlNrsXrGPGQhL
         k4C/UDwFDSUI3J5cTisoOeWR9dXn42srVp5t0iQ9lsg/VE3PLEJ9nGQpGXAp7deIB6zZ
         sTnHEw6NYU0uzJt6w4nFRyHBbBe49R59J/oXCyeJNMRATwlH5da95clQZbNmASFNdWaY
         2HvM4IrUIBIF48DqwR+csjWJAYl/eycIN1KEXxCVuYjh/Ultfh2TgkNAxtrJVc7BiVEO
         lPfStVfx5kPbvJMrsyBYmbg1HLnGLqSx9om4HkLDna0KUdEL71wsYzXJBg3BfQPwis2c
         qPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689223365; x=1691815365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjV/Zi/O2jxtwqhEjrKlibfSxhgEzPvF4Af2ioSe3Ps=;
        b=bUgLhsi/b8BLLMWO9doKTqcug+zCqDTK3iQC0xmvLngLi8t9OSuNsFjNtwicQSiMLw
         w1lY+PRZc0qP0x6qzPSobghgtnZBFn/TwIAIFxmajZ/FPPWvFiX66ST2pNkWcwXp//lJ
         5N6xh1mgdFZ4TJIsh4ypbw57GS1J2VabxoxzVcIHmM6rmBDLSt6MI31+iRL5xQrwYDd9
         RmXnrDBv5/spP+IpbTT0j51aWiTrp1Ty2GQxww85KiAxlUpQ4LWL3p0srjjHXbTl8I5/
         VtGRdho46gab0UnIYUMQBF3TKJ8ZYBZvgjnazuEXFhVR1D5TDBkRFd4FcgnBzG01SvRl
         T6wA==
X-Gm-Message-State: ABy/qLbhUPdCTog0waSd4yC/xklL6YR/eHQYvg/P9lj6t1qjHf+8J3Bb
        RHKR/S6tONPxCKO42uc3vDfu98IOOSo=
X-Google-Smtp-Source: APBJJlF144joVzF3mNPq8ksFXUASWhWTtLk5IPianIra+FyGG6BPae8S9MiGZzDjGxa08QC2QgDt7Q==
X-Received: by 2002:a05:6a21:6d98:b0:130:f6bc:9146 with SMTP id wl24-20020a056a216d9800b00130f6bc9146mr516585pzb.14.1689223365321;
        Wed, 12 Jul 2023 21:42:45 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902cd0d00b001ae5d21f760sm4843040ply.146.2023.07.12.21.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:42:43 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v5 3/3] push: don't imply that integration is always required before pushing
Date:   Wed, 12 Jul 2023 22:41:15 -0600
Message-ID: <20230713044128.3771818-4-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713044128.3771818-1-alexhenrie24@gmail.com>
References: <20230707054257.3366355-1-alexhenrie24@gmail.com>
 <20230713044128.3771818-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a narrow but common case, the user is the only author of a branch and
doesn't mind overwriting the corresponding branch on the remote. This
workflow is especially common on GitHub, GitLab, and Gerrit, which keep
a permanent record of every version of a branch that is pushed while a
pull request is open for that branch. On those platforms, force-pushing
is encouraged and is analogous to emailing a new version of a patchset.

When giving advice about divergent branches, tell the user about
`git pull`, but don't unconditionally instruct the user to do it. A less
prescriptive message will help prevent users from thinking that they are
required to create an integrated history instead of simply replacing the
previous history. Also, don't put `git pull` in an awkward
parenthetical, because `git pull` can always be used to reconcile
branches and is the normal way to do so.

Due to the difficulty of knowing which command for force-pushing is best
suited to the user's situation, no specific advice is given about
force-pushing. Instead, the user is directed to the Git documentation to
read about possible ways forward that do not involve integration.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/push.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 6f8a8dc711..61a251c50a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -301,21 +301,21 @@ static void setup_default_push_refspecs(int *flags, struct remote *remote)
 
 static const char message_advice_pull_before_push[] =
 	N_("Updates were rejected because the tip of your current branch is behind\n"
-	   "its remote counterpart. Integrate the remote changes (e.g.\n"
-	   "'git pull ...') before pushing again.\n"
+	   "its remote counterpart. If you want to integrate the remote changes,\n"
+	   "use 'git pull' before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_checkout_pull_push[] =
 	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
-	   "counterpart. Check out this branch and integrate the remote changes\n"
-	   "(e.g. 'git pull ...') before pushing again.\n"
+	   "counterpart. If you want to integrate the remote changes, use 'git pull'\n"
+	   "before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_ref_fetch_first[] =
-	N_("Updates were rejected because the remote contains work that you do\n"
-	   "not have locally. This is usually caused by another repository pushing\n"
-	   "to the same ref. You may want to first integrate the remote changes\n"
-	   "(e.g., 'git pull ...') before pushing again.\n"
+	N_("Updates were rejected because the remote contains work that you do not\n"
+	   "have locally. This is usually caused by another repository pushing to\n"
+	   "the same ref. If you want to integrate the remote changes, use\n"
+	   "'git pull' before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_ref_already_exists[] =
@@ -327,10 +327,10 @@ static const char message_advice_ref_needs_force[] =
 	   "without using the '--force' option.\n");
 
 static const char message_advice_ref_needs_update[] =
-	N_("Updates were rejected because the tip of the remote-tracking\n"
-	   "branch has been updated since the last checkout. You may want\n"
-	   "to integrate those changes locally (e.g., 'git pull ...')\n"
-	   "before forcing an update.\n");
+	N_("Updates were rejected because the tip of the remote-tracking branch has\n"
+	   "been updated since the last checkout. If you want to integrate the\n"
+	   "remote changes, use 'git pull' before pushing again.\n"
+	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static void advise_pull_before_push(void)
 {
-- 
2.41.0

