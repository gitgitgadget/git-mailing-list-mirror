Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F86C4320E
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 06:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61A260F5C
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 06:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbhHQGpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 02:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbhHQGpX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 02:45:23 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A90C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 23:44:50 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id l3so16310077qtk.10
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 23:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M/AmNEqD7zkdjHMOH1UAVuluRJcXK7t6+7F2a/MlVsk=;
        b=KYKxszV1lU6k16nhVoh9mDth81ossDIhgphPrKX5UbbDYy7YyCUQZs1uP36jUu63Et
         HBCISXLGV28INS4aQRhBFywOb+yHvat8XPZ0Im7PD+bN8ZaUJJAfJzdxTWL6OkCsNXSL
         V5PQJ2c38ygpsfcRvvgdQRgyWhR1DSTpMjgBcyxnldGGw0T+ZbJVNpsGRwRmSuMpdOgs
         5eQ3yr6Prq+NiSCFQD7m867WeocF0Qzzx5rAWbBhyU9Oc3LT6+aehmYRfIzgoRQq85B+
         io+8KrTjU/hQgy896FVsnJF0ydGvAg8kEl47gCkd4z0sIt9uuOkMs7EdPKJqf82feh5e
         F5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/AmNEqD7zkdjHMOH1UAVuluRJcXK7t6+7F2a/MlVsk=;
        b=Z10L/ya2QW5SjVMA17xw3J0QPgcmLzlkaLo6ZElCi5RUbACMqJVpWR2j8UCipMWBm3
         9XjYIAnlTWdf2Yy+h7jpZp9l/mi8wBTPKCzj6s4OvHR3s1ew0ByqzAGHRh3BsujI4yCO
         3WkPOgQhIcTOOTP/VzJI4bkIpxFNSd46T6yPINxUsQ/csuZX4llp2RPvlrg+kWmtYYJc
         916nyP1ehY2nSosulEax1c3cGpL44UVi8FtQMsgUyMiBF94CTODV0cZ9DNjQHOtQ+AK2
         7A1ykQ5ez0ZhPoI1/Pfpdho5orHz/YNMAgnYgLU+DsPfZ4Temn/LwCMvkRmm4Fmnba3s
         rIdg==
X-Gm-Message-State: AOAM531GjOi9JfdTxicwyQY3pXxrCDhieqHthOAAynB4qMYrI3Eee/RX
        6aedYSP0MGLB+IiALLQh2GslLoIbnw0=
X-Google-Smtp-Source: ABdhPJwPoD9pGh1+KFcwVI/sDHYpLJNyDYgsJoUndB01KF0L4GamAdU5nME/WV4ghbH6JVkGSv50Ow==
X-Received: by 2002:a05:622a:144:: with SMTP id v4mr1688075qtw.220.1629182689481;
        Mon, 16 Aug 2021 23:44:49 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id q194sm757062qke.83.2021.08.16.23.44.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Aug 2021 23:44:49 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/2] builtin/add: remove obsoleted support for legacy stash -p
Date:   Mon, 16 Aug 2021 23:44:34 -0700
Message-Id: <20210817064435.97625-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.476.gf000ecbed9
In-Reply-To: <20210817064435.97625-1-carenas@gmail.com>
References: <20210817064435.97625-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

90a6bb98d1 (legacy stash -p: respect the add.interactive.usebuiltin
setting, 2019-12-21) adds a hidden option and its supporting code
to support the legacy stash script, but that was left behind when
it was retired.

mostly revert commit.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/add.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index b773b5a499..a15b5be220 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -31,7 +31,6 @@ static int take_worktree_changes;
 static int add_renormalize;
 static int pathspec_file_nul;
 static const char *pathspec_from_file;
-static int legacy_stash_p; /* support for the scripted `git stash` */
 
 struct update_callback_data {
 	int flags;
@@ -382,8 +381,6 @@ static struct option builtin_add_options[] = {
 		   N_("override the executable bit of the listed files")),
 	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
 			N_("warn when adding an embedded repository")),
-	OPT_HIDDEN_BOOL(0, "legacy-stash-p", &legacy_stash_p,
-			N_("backend for `git stash -p`")),
 	OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
 	OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
 	OPT_END(),
@@ -483,6 +480,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
 	if (patch_interactive)
 		add_interactive = 1;
+
 	if (add_interactive) {
 		if (show_only)
 			die(_("--dry-run is incompatible with --interactive/--patch"));
@@ -490,17 +488,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
 		exit(interactive_add(argv + 1, prefix, patch_interactive));
 	}
-	if (legacy_stash_p) {
-		struct pathspec pathspec;
-
-		parse_pathspec(&pathspec, 0,
-			PATHSPEC_PREFER_FULL |
-			PATHSPEC_SYMLINK_LEADING_PATH |
-			PATHSPEC_PREFIX_ORIGIN,
-			prefix, argv);
-
-		return run_add_interactive(NULL, "--patch=stash", &pathspec);
-	}
 
 	if (edit_interactive) {
 		if (pathspec_from_file)
-- 
2.33.0.476.gf000ecbed9

