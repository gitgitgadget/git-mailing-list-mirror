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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22139C4320A
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014EF60F41
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240420AbhHJLsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 07:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240276AbhHJLsS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 07:48:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F89C0617B9
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:36 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id w14so2114471pjh.5
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Nrjb+lXCWBWyHgQW9ErD/EwJnaxHdeMQa1Au2UG9Fc=;
        b=HuQvdK8s7x30ZxdSEwurxS5FpFNAIpmbL4joVuTb6OFERo5VuCik7zXlILHkPOsEdE
         AlDHZBr5DQHi9EE9Ey0yObkmwCmCni1eL5+vIVlllsJe9Yr580RQbO+ozQ/WXuNKV7wT
         2yvWeIQF4F5BIvhf+xcxubpK0wraAJ2Q1soqkHkIn3HvH0ZiiL8nh08eWcl8nyq6U/So
         V1johtfyWsuY7b08wlFfAYlYH66cKdLozIsdumDXX13xxvpWoiZAtxQghwLFn1RGddew
         XLfARL3t4IVUYPEnusSFBxvVcLDtU+qhNtThvKp+0FUvCbDDYKKBIFGDYC5t167lYyaq
         P4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Nrjb+lXCWBWyHgQW9ErD/EwJnaxHdeMQa1Au2UG9Fc=;
        b=UyczfQIPNPUbZqxSn7mE6pAFZ3vE7lyMpWodZoZIRePpW8WZzKIr5zBV5ZfGKv3bcL
         9v0CA0uekz4qDJlXgxCsUSEhBpeaYr9wGiDs9u9lBMbsnmwBW824kzvRdZr5ZFbyHohy
         5uSkcUaVg6g/JeAA+wnKBykg0CQvVWOATBEhW6vVb/PGmgn8PbHTfL/zZJnGoOCGWF49
         w506182cjtKEwgYo7GAAmqvVDxhK0bQ7IG9AoaEsqxye6Rr1oSYcFblHlhaSkxNMAk6o
         iO6HJU1Kk7S5arnVe+PBD3hXogJSYwExvXnPAbNKa8zNLYGuTh1AnJCUnsvmYdPLzaFL
         RTEA==
X-Gm-Message-State: AOAM533a2NJBXvTzlbsVom3rOot1FXawbMechJRh3yyR4uNgiveNW0qD
        HM+xDx0bBDlfJCUlm0pvSOF+jGNgRYYbsA==
X-Google-Smtp-Source: ABdhPJwBG7h+h40Bb2/4Oj0BrPmnH+A05eE2mZfcNnWZO0arTRtHlTMCRAt0po/0RxVN2UjA9rY+dw==
X-Received: by 2002:a63:5925:: with SMTP id n37mr1135700pgb.251.1628596056476;
        Tue, 10 Aug 2021 04:47:36 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id g19sm12410232pfc.168.2021.08.10.04.47.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Aug 2021 04:47:36 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v5 8/9] submodule--helper: remove resolve-relative-url subcommand
Date:   Tue, 10 Aug 2021 17:16:40 +0530
Message-Id: <20210810114641.27188-9-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810114641.27188-1-raykar.ath@gmail.com>
References: <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210810114641.27188-1-raykar.ath@gmail.com>
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
index 0baff16686..65591e47eb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -223,25 +223,6 @@ static char *compute_submodule_clone_url(const char *rel_url, const char *up_pat
 	return resolved_url;
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
@@ -3118,7 +3099,6 @@ static struct cmd_struct commands[] = {
 	{"update-clone", update_clone, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
-	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
-- 
2.32.0

