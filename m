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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFCBC432BE
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFDA961040
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbhHEHmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238667AbhHEHmV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:42:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35103C061798
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:42:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so12810581pjb.2
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e+6OCMo+DlGa2QWoBAGf75KRxMzKVKH6/dy+1rWuxBU=;
        b=TKnTKrrVLQrwBvYN42QUDBkk5D+R1zisPKHN5jS5FeLErLaxsWyakIFWcm2y77T3kD
         bYEusfqQg6KRE/8zdcd+T4DYT19JxEWeXkGSTiNPERZK3pRJD6Y1RhjJoeLvnmVnj2pU
         KWLtl1tTAk58eyDQUUxoIL7S2afPX08LncRvSJPuiE1z/VC5tBZ+lZKgOfBKjGXEX1Q9
         PJJbvHhhWShJqmUTTFNStVDwVrHnGGobpGgaVho3+DJsr2zd6ZNeDl6pka4UkLBVspHa
         v0N3r2lAkN85iDoz19jlIkEOCC5QHotfYk0ZD65CBkTMUzy0aVBppAddiwBVvoyCkbxI
         sfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+6OCMo+DlGa2QWoBAGf75KRxMzKVKH6/dy+1rWuxBU=;
        b=RaGgiCjQzbiFnlXT/ANHEmbe1KOPMlH0d9wHyVYSKhu3gXJEfeonF4bXr+RjgxnK62
         F7QjhT0LB6tAkwSCx5WRYR6fM5XZf9C2jblka8EjgBoTP9AZ37qXzfkWedwxlOw4WDYn
         z9NKkTv16CHO9ak8OKLIFFR1ORn8G0RnTWIwFzoA4fUyTa5VtG8MCE7TLgu6BmfNeH1d
         ETwQKZzW6twezp0J/Uy64+zGEKfJx1rKjcdL+20X9JzKFUkDQ/Q6iQGz5zL/N7shshqT
         G8eua3brFwwlp/Ij7N6E+N+XrPH20Wj0jyNGku+XIuvY7EVMgdqnDCMJ5rNql9+WhzXG
         7Vlg==
X-Gm-Message-State: AOAM532jbpc5Zm3r1xAdMsI1AuYXJD0JirX2rX2fgIch7OHoSH2n82tN
        uHGn1v+5R/lG5sWO877WuZk=
X-Google-Smtp-Source: ABdhPJyq+7FJ5c1EUkggKmUeOK7NYcgFHRWcaQqTvmPujYxaS1DhxaczPEbebboc5H5NV0XPuUIRvA==
X-Received: by 2002:a17:90a:6e07:: with SMTP id b7mr13877674pjk.1.1628149325824;
        Thu, 05 Aug 2021 00:42:05 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b2sm4885153pjh.18.2021.08.05.00.42.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:42:05 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v2 9/9] submodule--helper: remove resolve-relative-url subcommand
Date:   Thu,  5 Aug 2021 13:10:54 +0530
Message-Id: <20210805074054.29916-10-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805074054.29916-1-raykar.ath@gmail.com>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
 <20210805074054.29916-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The shell subcommand `resolve-relative-url` is no longer required, as
its last caller has been removed when it was converted to C.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index da83e8e2a5..514891a22f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -223,25 +223,6 @@ static char *compute_submodule_clone_url(const char *rel_url, const char *up_pat
 	return relurl;
 }
 
-static int resolve_relative_url(int argc, const char **argv, const char *prefix)
-{
-	const char *up_path = NULL;
-	char *res;
-	const char *url;
-
-	if (argc != 2 && argc != 3)
-		die("resolve-relative-url only accepts one or two arguments");
-
-	url = argv[1];
-	if (argc == 3)
-		up_path = argv[2];
-
-	res = compute_submodule_clone_url(url, up_path, 1);
-	puts(res);
-	free(res);
-	return 0;
-}
-
 static int resolve_relative_url_test(int argc, const char **argv, const char *prefix)
 {
 	char *remoteurl, *res;
@@ -3115,7 +3096,6 @@ static struct cmd_struct commands[] = {
 	{"update-clone", update_clone, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
-	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
-- 
2.32.0

