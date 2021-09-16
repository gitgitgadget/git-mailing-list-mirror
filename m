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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB05C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E6360238
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbhIPKe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbhIPKe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 06:34:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1B7C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:06 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j16so5515540pfc.2
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6++1T30h1iGYOlKKfZKE16nCjyjI8IJhhiJmo/sUrrI=;
        b=ECweIR2QqvC8YpnhgQxeOjbbIlCV7MGbK2uucpr723IXaahXS+4r4EWa0gpqU68op7
         Z7qL/uXlsC7z3KaScHWmrL+8seT1eLiJ/ZWz3YxxjRjrnUUWgfzNaMyOHn5QXEsAiOZH
         pN1zsqyaeHFRUtCcO8ujZCGbegWdzlLs0jo0f8beBM9bTSjlkoz4EzdbtvPC+15tPGV9
         9cj8QDx8/t4GWwq2vAonMV4qxGNLRmbD4YyCgGrg/QGH9ie/6TDptA3qNlLFSFVux0Lh
         TUTu5qakierw45Q1IjkLcNyqvDoVp4MOn2UMpXqzWvUPXzM8WkHgSLACAEfwIrjJWMpD
         60Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6++1T30h1iGYOlKKfZKE16nCjyjI8IJhhiJmo/sUrrI=;
        b=RuTmdqc7xudr0Zl7n4hziE4Ip5wCWYWY2jcRtDsq3AO+vUHayL+45G5/y6j8AvPWWP
         8ns3BV0x+zWMImBfZ4evbYsO2c0/hKisgVnsHdGR5yHlI/+EAl2825FEU+xyE5gz2yMD
         KBcBAiH4xsPPGp2Hofnm+C91baN2aHI6N3VSOOCd8NB+Vvpia8KSktKIfxzXiiKPHVva
         ltzEVvslfPsaYzBeAccoiDKpX0uCRz5FdFRbcppEWpOrgHzJugOT99xein9eMw5cmicx
         BSrzqy2W52ChimPWqLJAQccfLkdFsXNLtV6SrNnMy4EHPIHVfB2hUMsvyiIf+vyc2+K1
         vkuQ==
X-Gm-Message-State: AOAM533mqyJUyOJxV9mALsnwnpk5O2W+LO1ua/ka7DhF98J2w7vt7UV8
        jpTRHaB0VYNa3yBgKxp/KMM=
X-Google-Smtp-Source: ABdhPJz3CGFlVh/VMkPyX+g5RCaym8ybdsFylUX26Yro0AEyKGdYZj/ihw9izup+S5HlLfJAqy1o6w==
X-Received: by 2002:a62:7e55:0:b0:441:c7a6:fcd2 with SMTP id z82-20020a627e55000000b00441c7a6fcd2mr2111938pfc.6.1631788385729;
        Thu, 16 Sep 2021 03:33:05 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.182])
        by smtp.gmail.com with ESMTPSA id c199sm2642605pfb.152.2021.09.16.03.33.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 03:33:05 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v2 1/8] submodule--helper: split up ensure_core_worktree()
Date:   Thu, 16 Sep 2021 16:02:34 +0530
Message-Id: <20210916103241.62376-2-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210916103241.62376-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210916103241.62376-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's split up `ensure_core_worktree()` so that we can call it from C
code without needing to deal with command line arguments.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 80619361fc..97512ccf0b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2794,18 +2794,12 @@ static int push_check(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
+static void do_ensure_core_worktree(const char *path)
 {
 	const struct submodule *sub;
-	const char *path;
 	const char *cw;
 	struct repository subrepo;
 
-	if (argc != 2)
-		BUG("submodule--helper ensure-core-worktree <path>");
-
-	path = argv[1];
-
 	sub = submodule_from_path(the_repository, null_oid(), path);
 	if (!sub)
 		BUG("We could get the submodule handle before?");
@@ -2829,6 +2823,17 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 		free(abs_path);
 		strbuf_release(&sb);
 	}
+}
+
+static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
+{
+	const char *path;
+
+	if (argc != 2)
+		BUG("submodule--helper ensure-core-worktree <path>");
+
+	path = argv[1];
+	do_ensure_core_worktree(path);
 
 	return 0;
 }
-- 
2.32.0

