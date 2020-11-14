Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABD4C55ABD
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 00:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522892225E
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 00:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8jOZtHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKNAet (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 19:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKNAes (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 19:34:48 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749BDC0617A6
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 16:34:48 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so12082171wrc.11
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 16:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UVeF//q+7/vEAexPlhXSoTaBVDx8d+zrKUSEMsoruVo=;
        b=H8jOZtHrtLCwV7XJ7l7xyyYqTTSk722zkFi0drKAuc7KGfH+UG4HiRXwlOh35WJ/8T
         QsyF9rgFF5I8w8sS4ShJnOGJvm9YQUcCB0sOwKR7J2Zxtzbcm7vSLzeCUbM6XpOTEYg6
         CFqDZQE5c3AttbPX7EZL6iln114h1aXGKoYtxS/AyFJafcEl1juUTFoMSwVlnVlkzc2U
         wSSIovL1tTUQO7KMyBD4xhFW2babvcc/A4GNcpSPc73lHfzuwKfEC53YHqS8Tx4nWqtF
         VsqFYxXHx3nTfJDudojDQlFEom6l59kLYQyrFOFNuxvpIyfpnb/urEH99k/eYlh/c7Zl
         b6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UVeF//q+7/vEAexPlhXSoTaBVDx8d+zrKUSEMsoruVo=;
        b=F1SVkIIl35l0nsHaIg8BYtD/W8XDY4fS/fPP7Tk0xgZUMsOVLcZPI/353adH30iNpf
         ajck2HBe81NlfvLplwVsC2D/Ll/Oy2E7YBBqMJprX2t9l5UZ2pFFEkB2W9juyQ7qzDPM
         ioNmBiqMRJx+wDoHyZ7pXlyoT2bSAivu2iC5aj/Wz384PKmyQfT90bOrDiPF2cAQXAjj
         R3AhfuRRU4aekaU6chkutssQJPyxHL4QzLlpWhg5VALVWehH63tk3lUq8vShfqQVbQXn
         aRUGJBFi+/izUmcIvsUVJOQJqlqU/O00ps6501ifyU7qIZVjBX63kHOdwcD8u9ARBzf5
         iaXw==
X-Gm-Message-State: AOAM533GfphEyvfTnvCbXN+TManWAuSuuySGIdZ6Qws19o2r+QSKcrSz
        bC5S6FUCPutRAnu8tYOFlZdm6K0Y68I=
X-Google-Smtp-Source: ABdhPJxQA2etciXDKPRbJnTe7UsA6EM6lZJLP13CuUndyuJPTyDCeAw4Qq2iGlF28W9mCKDZHzATFA==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr6616076wrw.109.1605314087051;
        Fri, 13 Nov 2020 16:34:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm13031918wrn.75.2020.11.13.16.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 16:34:46 -0800 (PST)
Message-Id: <cdabd96daa8bccf6338c118273c6f8af661e8b41.1605314085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.789.git.1605314085.gitgitgadget@gmail.com>
References: <pull.789.git.1605314085.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Nov 2020 00:34:42 +0000
Subject: [PATCH 1/4] pull --rebase: compute rebase arguments in separate
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Brice Goglin <bgoglin@free.fr>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The function 'run_rebase' is responsible for constructing the
command line to be passed to 'git rebase'. This includes both forwarding
pass-through options given to 'git pull' as well computing the <newbase>
and <upstream> arguments to 'git rebase'.

A following commit will need to access the <upstream> argument in
'cmd_pull' to fix a bug with 'git pull --rebase --recurse-submodules'.
In order to do so, refactor the code so that the <newbase> and
<upstream> commits are computed in a new, separate function,
'get_rebase_newbase_and_upstream'.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 builtin/pull.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 17aa63cd35..ac6ef650ab 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -852,21 +852,42 @@ static int get_octopus_merge_base(struct object_id *merge_base,
 
 /**
  * Given the current HEAD oid, the merge head returned from git-fetch and the
- * fork point calculated by get_rebase_fork_point(), runs git-rebase with the
- * appropriate arguments and returns its exit status.
+ * fork point calculated by get_rebase_fork_point(), compute the <newbase> and
+ * <upstream> arguments to use for the upcoming git-rebase invocation.
  */
-static int run_rebase(const struct object_id *curr_head,
+static int get_rebase_newbase_and_upstream(struct object_id *newbase,
+		struct object_id *upstream,
+		const struct object_id *curr_head,
 		const struct object_id *merge_head,
 		const struct object_id *fork_point)
 {
-	int ret;
 	struct object_id oct_merge_base;
-	struct strvec args = STRVEC_INIT;
 
 	if (!get_octopus_merge_base(&oct_merge_base, curr_head, merge_head, fork_point))
 		if (!is_null_oid(fork_point) && oideq(&oct_merge_base, fork_point))
 			fork_point = NULL;
 
+	if (fork_point && !is_null_oid(fork_point))
+		oidcpy(upstream, fork_point);
+	else
+		oidcpy(upstream, merge_head);
+
+	oidcpy(newbase, merge_head);
+
+	return 0;
+}
+
+/**
+ * Given the <newbase> and <upstream> calculated by
+ * get_rebase_newbase_and_upstream(), runs git-rebase with the
+ * appropriate arguments and returns its exit status.
+ */
+static int run_rebase(const struct object_id *newbase,
+		const struct object_id *upstream)
+{
+	int ret;
+	struct strvec args = STRVEC_INIT;
+
 	strvec_push(&args, "rebase");
 
 	/* Shared options */
@@ -894,12 +915,9 @@ static int run_rebase(const struct object_id *curr_head,
 		warning(_("ignoring --verify-signatures for rebase"));
 
 	strvec_push(&args, "--onto");
-	strvec_push(&args, oid_to_hex(merge_head));
+	strvec_push(&args, oid_to_hex(newbase));
 
-	if (fork_point && !is_null_oid(fork_point))
-		strvec_push(&args, oid_to_hex(fork_point));
-	else
-		strvec_push(&args, oid_to_hex(merge_head));
+	strvec_push(&args, oid_to_hex(upstream));
 
 	ret = run_command_v_opt(args.v, RUN_GIT_CMD);
 	strvec_clear(&args);
@@ -1011,6 +1029,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (opt_rebase) {
 		int ret = 0;
 		int ran_ff = 0;
+
+		struct object_id newbase;
+		struct object_id upstream;
+		get_rebase_newbase_and_upstream(&newbase, &upstream, &curr_head,
+						merge_heads.oid, &rebase_fork_point);
+
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
 		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
@@ -1034,7 +1058,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			free_commit_list(list);
 		}
 		if (!ran_ff)
-			ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
+			ret = run_rebase(&newbase, &upstream);
 
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
-- 
gitgitgadget

