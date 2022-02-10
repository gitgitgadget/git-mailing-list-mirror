Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC79C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbiBJJ3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:29:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238507AbiBJJ3W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:22 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAE510B9
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:23 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id m6-20020a056a00080600b004e06140d481so2336914pfk.9
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LTQppUaG6czFzYFgMJ1+lhXCVOnbg0TheoPSy/3IWaQ=;
        b=XWjc4zqa/FQqNnXMUp+8YsLymIe0liaDINK+41mPYzb+Rddot17NL4PWdpsXx5h97O
         SurqzQnvYFlQXts15T5QTqaV/wCL5eKCb/Rrapw70y3OYP5cJyN2P2q4s4IQqO0BV5Pt
         ji25iVRBm8e2emQNni8ke1u9A8Io5BPHp/aB5Yx0MBjDCJjXKDzJLPNNDq4urLH29ky3
         PMcfdVu3EYRvCBK9qTxBJQLjKl0YVUHflqJIE3ORuJaW0EJ/9MFm57hPyUlyYjcG3TEU
         2zbKKpsQUm3F5dIgpamwDz74zEZHvOFJAofMT73AvcT2rUhEjTfUUlGFR4XpDf09f1cz
         Igfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LTQppUaG6czFzYFgMJ1+lhXCVOnbg0TheoPSy/3IWaQ=;
        b=RElf1HV6W9nfXugruJf5yapSEzP5L7zUzfz1slAja9hAk/1QyJ7boozPdKfbEUEt7+
         SHv/6kakKJth+JyIXUDyBFIrEBvTb0Zq6AoHgPOHzq8wZxVWafpnEVTyoAaaThCJ3Cxm
         qQeVYVUDabdOiZgjGNaNYfu8/Bp5/BEWbuAdk7sZO6bZPotfHzZW5s8+O8pgZu2buJRp
         BN4OqieKSYQQHZ9wvulAB9cR9kzV9WLDiB0A9ppV0fCouwj9rL25Q3TirC7b6H1DJUQJ
         1YSUbkbY2xPfnqWARX7R3uDHhZngc3EWLqAW779jaPU6NlP/uTD1/3Oxq7mrs8rt8KYT
         G2rw==
X-Gm-Message-State: AOAM5309jJ/+3Tv+uAejO4FLLgDzj6piXcRjGmvWx7hX7sKj065Nvg3b
        D9n4G9cHwQHYCw7x3hEIQuv5435lkIWF4uEcCH1TU8tbm6FBcUm2bKNMWcBo7voCSbiu5/IeyKa
        tcHPAFlKgivDojmsN0sjqYWvbw+X89sIso+rwSrv9cYR2chxhKI2b8zlUwOMFM4U=
X-Google-Smtp-Source: ABdhPJyQ4G73qX5c6LHvvHAiHYR1tRTId4QKDSbHFWx0Zf+rm2bOvcknBIn6DISkwrdaMDV5glVoFyK3RUXLQA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d2ca:: with SMTP id
 n10mr6681474plc.28.1644485362662; Thu, 10 Feb 2022 01:29:22 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:29 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-17-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 16/20] submodule--helper: reduce logic in run_update_procedure()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A later commit will combine the "update-clone" and
"run-update-procedure" commands, so run_update_procedure() will be
removed. Prepare for this by moving as much logic as possible out of
run_update_procedure() and into update_submodule2().

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0ab8f9d49f..ff7ee73e1a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2001,9 +2001,11 @@ struct submodule_update_clone {
 }
 
 struct update_data {
+	const char *prefix;
 	const char *recursive_prefix;
 	const char *sm_path;
 	const char *displaypath;
+	const char *update_default;
 	struct object_id oid;
 	struct object_id suboid;
 	struct submodule_update_strategy update_strategy;
@@ -2458,7 +2460,6 @@ static void update_submodule(struct update_clone_data *ucd)
 static int update_submodule2(struct update_data *update_data);
 static int run_update_procedure(int argc, const char **argv, const char *prefix)
 {
-	char *prefixed_path, *update = NULL;
 	struct update_data opt = UPDATE_DATA_INIT;
 
 	struct option options[] = {
@@ -2471,10 +2472,10 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "just-cloned", &opt.just_cloned,
 			 N_("overrides update mode in case the repository is a fresh clone")),
 		OPT_INTEGER(0, "depth", &opt.depth, N_("depth for shallow fetch")),
-		OPT_STRING(0, "prefix", &prefix,
+		OPT_STRING(0, "prefix", &opt.prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
-		OPT_STRING(0, "update", &update,
+		OPT_STRING(0, "update", &opt.update_default,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
 		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix, N_("path"),
@@ -2500,18 +2501,6 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 
 	opt.sm_path = argv[0];
 
-	if (opt.recursive_prefix)
-		prefixed_path = xstrfmt("%s%s", opt.recursive_prefix, opt.sm_path);
-	else
-		prefixed_path = xstrdup(opt.sm_path);
-
-	opt.displaypath = get_submodule_displaypath(prefixed_path, prefix);
-
-	determine_submodule_update_strategy(the_repository, opt.just_cloned,
-					    opt.sm_path, update,
-					    &opt.update_strategy);
-
-	free(prefixed_path);
 	return update_submodule2(&opt);
 }
 
@@ -2871,8 +2860,24 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 /* NEEDSWORK: this is a temporary name until we delete update_submodule() */
 static int update_submodule2(struct update_data *update_data)
 {
+	char *prefixed_path;
+
 	ensure_core_worktree(update_data->sm_path);
 
+	if (update_data->recursive_prefix)
+		prefixed_path = xstrfmt("%s%s", update_data->recursive_prefix,
+					update_data->sm_path);
+	else
+		prefixed_path = xstrdup(update_data->sm_path);
+
+	update_data->displaypath = get_submodule_displaypath(prefixed_path,
+							     update_data->prefix);
+	free(prefixed_path);
+
+	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
+					    update_data->sm_path, update_data->update_default,
+					    &update_data->update_strategy);
+
 	/* NEEDSWORK: fix the style issues e.g. braces */
 	if (update_data->just_cloned) {
 		oidcpy(&update_data->suboid, null_oid());
-- 
2.33.GIT

