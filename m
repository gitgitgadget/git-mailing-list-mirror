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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B53C433FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEEF3610FF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245749AbhIGMBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343565AbhIGMBg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:01:36 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38575C0613D9
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:00:28 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id w8so9688233pgf.5
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hb2LF+VpU/wqyJ3haQb6Y8wlYbcsPSXqAXl1nkeaUko=;
        b=nxZ2V+sV6ng+vcZHgrs+VKGpzk+wz0tMJ/WeQaWIiWxKrYS3xc8Q4qr66o1mDEM73Y
         WLeiGvUk4wwnEGJ1mgJS2GK1vPIYkpqvZhZET/uvcVaFjf44Ut3xLtuOU+TZMaX7B4pm
         tEoFgZgoM4CiG7VAnN524G6Ndgr0uKG/eEwnDHaEErZAYenpVmHodvHqWX3FsKDysgCA
         K+z1byZO6k9UFcf+ANhRnkL5MhMRceBv96yRkANR/AZooI1Ocvq2A4iKYA5T33MG9jA4
         PNlr92GXVsxknUxzcjWr6BcZrrvDo+KNNApneAxSsoe6mrMUEJhnrBJ+FnRCFM4yT3C7
         9Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hb2LF+VpU/wqyJ3haQb6Y8wlYbcsPSXqAXl1nkeaUko=;
        b=TTCVAamws08EfnumFotKQLY73bY6SudTo0GX7cON2BzhuIL/A+Aq1PEHArpIq2Wf2e
         BgNGYUyI9KmJTAODGBRyBLqpB0CllAEX5Kh4CfRRFQrOfqCtCecV+iNUo6jW1qWUbc/6
         ejJRcVlw3xnXo5uy76D3y2BCafm3J2tkwdaqg8TmcObylAZCmBXaUUmbihTpZr8ZhGNu
         cRQEWS3R/LgmAi/LleFzyBn+pv8B+i5mRVlOuozPvZQ3wG8VPMR7NroJhWlsC6VP/Nc5
         xCw8JEnqzt8oWvajwzPZm8U0InJ9S1VJpi799kQnPgjV54Iql2jazEIOLp+YpTGjynEu
         3Dqw==
X-Gm-Message-State: AOAM5339vS5BiqnHN3KLkimehbZu4zYwp1IwRDx9LhpVNXVCXHHO/AFi
        qEKgMYCjKsCnDPr9BcjUuC1coYv9qW8=
X-Google-Smtp-Source: ABdhPJw34UE3p37s/y4Q/0GfmEVb9WxutGQweqJOfRU4c2JToLU3MhpfBzCkLj93eOryOK+OrsoyfQ==
X-Received: by 2002:aa7:9e92:0:b0:40a:344:92c7 with SMTP id p18-20020aa79e92000000b0040a034492c7mr15965787pfq.71.1631016027607;
        Tue, 07 Sep 2021 05:00:27 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id a142sm11248150pfd.172.2021.09.07.05.00.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 05:00:26 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, emilyshaffer@google.com,
        gitster@pobox.com, jrnieder@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com, avarab@gmail.com,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: [PATCH 10/13] submodule--helper: remove shell interface to ensure_core_worktree()
Date:   Tue,  7 Sep 2021 17:29:29 +0530
Message-Id: <20210907115932.36068-11-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210907115932.36068-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'ensure-core-worktree' subcommand is no longer needed since the
conversion of the update code from shell to C.

Let's remove the subcommand, and while we are at it, let's rename
'do_ensure_core_worktree()' to 'ensure_core_worktree()' to signal that
it is no longer a utility function meant to be called by another
function.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e3e85600c3..597e303889 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2740,7 +2740,7 @@ static int push_check(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static void do_ensure_core_worktree(const char *path)
+static void ensure_core_worktree(const char *path)
 {
 	const struct submodule *sub;
 	const char *cw;
@@ -2771,19 +2771,6 @@ static void do_ensure_core_worktree(const char *path)
 	}
 }
 
-static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
-{
-	const char *path;
-
-	if (argc != 2)
-		BUG("submodule--helper ensure-core-worktree <path>");
-
-	path = argv[1];
-	do_ensure_core_worktree(path);
-
-	return 0;
-}
-
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -3017,7 +3004,7 @@ static int update_submodule(struct update_data *update_data)
 	char *prefixed_path;
 	struct string_list err = STRING_LIST_INIT_DUP;
 
-	do_ensure_core_worktree(update_data->sm_path);
+	ensure_core_worktree(update_data->sm_path);
 
 	if (update_data->recursive_prefix)
 		prefixed_path = xstrfmt("%s%s", update_data->recursive_prefix,
@@ -3441,7 +3428,6 @@ static struct cmd_struct commands[] = {
 	{"add-clone", add_clone, 0},
 	{"update", module_update, 0},
 	{"run-update-procedure", run_update_procedure, 0},
-	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
-- 
2.32.0

