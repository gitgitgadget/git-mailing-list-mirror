Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B7EC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiJNPkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiJNPkf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:40:35 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A4CD57E4
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 6-20020a1c0206000000b003c6c154d528so668299wmc.4
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDMsddTcchLQ+RogwtGT9AYtAffFjvt6JtkN/S2ISbI=;
        b=himsfKbSEJokD0u4h9docFCbCUe/B9PiDAChKfJ6zrXbsLDtV/KRORfxiZLbtdkuO6
         Jk4ZAICNHjjrctFfWfdkfyKOOWnLCssKghiTzLFQin+WR7KT8IckIy7MOei4jZmWG6yA
         xvguVpPiTurcAtllQ8K24p4TS/n8AhP2Mq76IkkfhWjNLetQEdkXlTYXjUiUhzyxPZTI
         Isy6kOMNiTw5xYA7pTNF3hK/6+9xZbVbT1mu3w7q4Ym1FcQCMprAl6US//vfXHY2pdrw
         boGv2aBQIHeWDxOh+xASe5K9jJyrtE6gluE3UAlQ98L0b13FMgdhp3MV6QAnjXSNWfKM
         i49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDMsddTcchLQ+RogwtGT9AYtAffFjvt6JtkN/S2ISbI=;
        b=NVXFsmfmk27/grOMiNEWydsiD2zbEvFIIt+2cPWdlRG1tj4b0ZTEAReVUFh3/VtMCi
         AxtC1AKSddPHFaQnmrA9VUfeRQJ5AJor7dOMFyqqPBRcQ/An+8tnOX4fmcJjgeLqhyzO
         +QwmBvlfbicIiJeCfBQcvL/uWbvnJUS75N+MR2jv9eTCZWaceEvzkwrZfpO134qNCy+X
         tNwwJLBtpFzEQo6SKm8/bwgUUe9oa/Eup8DMk0qF6B9Cba0GmiWd3OKxN4aqm0bOz+hI
         zeKJDyFJyYlMbQoYoqwYcYxRq6/cde87mCV0xKB5g8ZPEbniepoiLNmvmvopPzSsJGs7
         h2dg==
X-Gm-Message-State: ACrzQf3pLS44JlGC/RGcr6rxnP5AA53nhApSEMc+Y5ylbaNS3XSDwwlO
        AJAxf/VXIZcmNo44mqGrzhDxADTEjEOO4Q==
X-Google-Smtp-Source: AMsMyM4KHrt12gNpmhJ8JLg8AYVzUySn8+9ixdXjr9DtC7+cpIPKZXf1YcUYqqGbtHyhV5hKGkBy7g==
X-Received: by 2002:a05:600c:198e:b0:3c6:e7e6:490 with SMTP id t14-20020a05600c198e00b003c6e7e60490mr2909321wmq.79.1665762031069;
        Fri, 14 Oct 2022 08:40:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm2385391wmz.34.2022.10.14.08.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:40:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/10] am: use run_command_l_opt() for show_patch()
Date:   Fri, 14 Oct 2022 17:40:16 +0200
Message-Id: <patch-04.10-4cd61aaa981-20221014T153426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git show" invocation added in 66335298a47 (rebase: add
--show-current-patch, 2018-02-11) is a one-off, and one where we're
not calling oid_to_hex() twice. So we can rely on the static buffer
that oid_to_hex() points to, rather than xstrdup()-ing it. As a result
we can use the run_command_l_opt() function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/am.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 39fea248330..1d298a91306 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2186,16 +2186,10 @@ static int show_patch(struct am_state *state, enum show_patch_type sub_mode)
 	const char *patch_path;
 	int len;
 
-	if (!is_null_oid(&state->orig_commit)) {
-		const char *av[4] = { "show", NULL, "--", NULL };
-		char *new_oid_str;
-		int ret;
-
-		av[1] = new_oid_str = xstrdup(oid_to_hex(&state->orig_commit));
-		ret = run_command_v_opt(av, RUN_GIT_CMD);
-		free(new_oid_str);
-		return ret;
-	}
+	if (!is_null_oid(&state->orig_commit))
+		return run_command_l_opt(RUN_GIT_CMD, "show",
+					 oid_to_hex(&state->orig_commit),
+					 "--", NULL);
 
 	switch (sub_mode) {
 	case SHOW_PATCH_RAW:
-- 
2.38.0.1092.g8c0298861b0

