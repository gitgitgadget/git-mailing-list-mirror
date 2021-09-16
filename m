Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90160C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C6861108
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbhIPKex (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbhIPKex (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 06:34:53 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62E4C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:32 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id n18so5695041pgm.12
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ZsYKhVnL+IuBodtegGy0VCqxe39ceufVO7HEtxfens=;
        b=RpUniyBgdHVj30RsFte+j/zHy1Anw/a9q1qcx6QN0GdC9kt56FntwpzbXj9yb2riKi
         VkxiIZf+LiMrg5o12d6JepwAtRTpYhqx/r0aRgZtb025A9bpB6l3A9TxMe0h09+QUkHG
         CLpMn17ij5oSUdhlHwO3z/994Zf0RcLMF98we4iKtewT1Nyxhu963TIqLw0cCMWJ/hDJ
         8UzU/VMj5W2QqJtZDIhWCvKqSdbjxYJXfo4VTdO/YS6H1i8xTq0H9IqrpzhHvvacu/5k
         4YObOgKxQGswsUBMuJzwodH8gCd4r29zV4Nj7gDy6CyiLgudMg/Ki28xYGBSF1fm4aYc
         yVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ZsYKhVnL+IuBodtegGy0VCqxe39ceufVO7HEtxfens=;
        b=32r0obBISFzLQb4nkTGoqq//jmXJikolO9aH2SA5WBOWVw/cLMXcERSNuSEDhNT8KL
         10NdAdXN6dL4TXKmHng46vEu/h2EqbFaYDKCSxdbqa/Ya+oJW/cS6yNcqq+qAJT7k2MC
         CP/hBKfIwUpO2twceGozXpt9vtEEfqThqddSIQ0XIf+VosQcOV3tBpkMwl4cLA4z43os
         dSF6aDCyLNQmTYYQY4G84HHGmi0a0HWHBmZMUeczVlXyjLht+4DZwb8+sQUSzY8oJJjD
         nk0DuXEtv+jZla7gVim/pVqUdSpLeNDzOUb8WYb3cD18nfrX1kQg/nC7IVQRuAbQd/C2
         e6NA==
X-Gm-Message-State: AOAM530nWbXeD1mX19q/1kZUMI93EA8eY5z5KxWi6/8QVI5QJXIM//4T
        DMICXY81MfMoFIGqBg8ENU0=
X-Google-Smtp-Source: ABdhPJwPGr0hWReye3Brf1//QRNay1NaQeyutd0I0tpjzsHPubQCnIPB4DKLsOpm4wFsEnMGrjs8Dw==
X-Received: by 2002:a63:4cd:: with SMTP id 196mr4359882pge.239.1631788412463;
        Thu, 16 Sep 2021 03:33:32 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.182])
        by smtp.gmail.com with ESMTPSA id c199sm2642605pfb.152.2021.09.16.03.33.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 03:33:32 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v2 8/8] submodule--helper: rename helper functions
Date:   Thu, 16 Sep 2021 16:02:41 +0530
Message-Id: <20210916103241.62376-9-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210916103241.62376-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210916103241.62376-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two functions were prefixed with 'do' before the shell-to-C
conversion because they were utility functions meant to be called by
their non-prefixed counterpart.

Since those callers don't exist anymore, and these functions can now be
used directly, let's rename them to signal this fact.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0910af9c71..e5e33be6ea 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2484,7 +2484,7 @@ static int run_update_command(struct update_data *ud, int subforce, struct strin
 	return 0;
 }
 
-static int do_run_update_procedure(struct update_data *ud, struct string_list *err)
+static int run_update_procedure(struct update_data *ud, struct string_list *err)
 {
 	int subforce = is_null_oid(&ud->suboid) || ud->force;
 
@@ -2646,7 +2646,7 @@ static int push_check(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static void do_ensure_core_worktree(const char *path)
+static void ensure_core_worktree(const char *path)
 {
 	const struct submodule *sub;
 	const char *cw;
@@ -2910,7 +2910,7 @@ static int update_submodule(struct update_data *update_data)
 	char *prefixed_path;
 	struct string_list err = STRING_LIST_INIT_DUP;
 
-	do_ensure_core_worktree(update_data->sm_path);
+	ensure_core_worktree(update_data->sm_path);
 
 	if (update_data->recursive_prefix)
 		prefixed_path = xstrfmt("%s%s", update_data->recursive_prefix,
@@ -2950,7 +2950,7 @@ static int update_submodule(struct update_data *update_data)
 	}
 
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
-		if (do_run_update_procedure(update_data, &err))
+		if (run_update_procedure(update_data, &err))
 			return 1;
 
 	if (update_data->recursive) {
-- 
2.32.0

