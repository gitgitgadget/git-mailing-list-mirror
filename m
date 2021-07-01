Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817B1C11F69
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 695606140C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhGAOug (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbhGAOu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD2C0613E6
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i94so8602675wri.4
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vMyqH4atwMy0u8EpIhOh4lmPem4fMyJcVWM1txZGxbs=;
        b=GBs+I4PpzHuu4Y3uxLRIW+4CsoUeQmUBc3jnX8ZejlLahZ7pgx87zoyloaDS1dmC1T
         l2Had6DuRLIpi6EcXAWKAruyySORq4Icy6nvATBUkx5XYElJjUBlq/Ww8/i605E2B5KC
         QXgbl1dPAxoptPt5lXjP8QvBGNSEL4SBbColeWoyN88PHwDpVhHO6AnNZUpxw4fwJB2p
         vatibS205gHChZSXwiDXUn8xo11V8OO5ZeBo/XTXlH6LAZO3swYQeQRo7r90eNSq1UnO
         +pZpw1LORHjqpVCbY/OlfNRBqE+SEsRmD+tKRNkrtbdvDnNjtwMEhu2mAHn6w/PpWcOU
         aWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vMyqH4atwMy0u8EpIhOh4lmPem4fMyJcVWM1txZGxbs=;
        b=kgEAu8AkZMaF6sVLzsZW8fdPNlsgY+jSg7bRby1Jbtkz+HppbNBeTlPFIrGHDaAZlK
         CbRM35xPFScwbonTV+yByAzxfg9/qSdDfdOVi2EgIedVU1W0cmvuLNBBXIRGuVsjRN9j
         HWv94Zr6ND/WRd7rEXuG8h7qRupu54PmfBstK1Y2CfhRDKOGWRWxT8JmfxawwuGJxBdi
         YQBM4rLRGC9vwYJIraWY7dufymy6gVHHs3YO4tBU39mTK8DEhycaNICnsaO/NSdrMZJq
         i8R/6cEMYkuj02OCAMxMu9e3U8OnypExba+lBacbJcCXyJN95pDNtaRBgZ435ETt/T5U
         rIpw==
X-Gm-Message-State: AOAM5320zBmV3cUYEwfzEngTploay6YKCWXxJ7vrS9rZIoZQTL2gHz2w
        ut0sRLj9IFlCaZXIHK4hT04pqBSh9x8=
X-Google-Smtp-Source: ABdhPJyKGADITEgtTh4cpQ/4iQVdilhIZVpldaeeJoZX/jqrv/S7tgXAIMTT7DybzTXN4hjF6741PQ==
X-Received: by 2002:a5d:488a:: with SMTP id g10mr30379wrq.180.1625150874413;
        Thu, 01 Jul 2021 07:47:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y66sm235579wmy.39.2021.07.01.07.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:54 -0700 (PDT)
Message-Id: <eef39aa168fec58321ee233d907db696b56ee0b8.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:25 +0000
Subject: [PATCH v3 15/34] fsmonitor: do not try to operate on bare repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Bare repos do not have a working directory, so there is no
directory for the daemon to register a watch upon.  And therefore
there are no files within the directory for it to actually watch.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c |  8 ++++++++
 t/t7519-status-fsmonitor.sh | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 7fcf960652f..d6161ad95a5 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -490,6 +490,14 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 		die(_("invalid 'ipc-threads' value (%d)"),
 		    fsmonitor__ipc_threads);
 
+	prepare_repo_settings(the_repository);
+	if (!the_repository->worktree)
+		return error(_("fsmonitor-daemon does not support bare repos '%s'"),
+			     xgetcwd());
+	if (the_repository->settings.fsmonitor_mode == FSMONITOR_MODE_INCOMPATIBLE)
+		return error(_("fsmonitor-daemon is incompatible with this repo '%s'"),
+			     the_repository->worktree);
+
 	if (!strcmp(subcmd, "start"))
 		return !!try_to_start_background_daemon();
 
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 02919c68ddd..ed20a4f7fb9 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -394,6 +394,22 @@ test_expect_success 'incompatible bare repo' '
 	test_cmp expect actual
 '
 
+test_expect_success FSMONITOR_DAEMON 'try running fsmonitor-daemon in bare repo' '
+	test_when_finished "rm -rf ./bare-clone" &&
+	git clone --bare . ./bare-clone &&
+	test_must_fail git -C ./bare-clone fsmonitor--daemon run 2>actual &&
+	grep "fsmonitor-daemon does not support bare repos" actual
+'
+
+test_expect_success FSMONITOR_DAEMON 'try running fsmonitor-daemon in virtual repo' '
+	test_when_finished "rm -rf ./fake-virtual-clone" &&
+	git clone . ./fake-virtual-clone &&
+	test_must_fail git -C ./fake-virtual-clone \
+			   -c core.virtualfilesystem=true \
+			   fsmonitor--daemon run 2>actual &&
+	grep "fsmonitor-daemon is incompatible with this repo" actual
+'
+
 test_expect_success 'incompatible core.virtualfilesystem' '
 	test_when_finished "rm -rf ./fake-gvfs-clone" &&
 	git clone . ./fake-gvfs-clone &&
-- 
gitgitgadget

