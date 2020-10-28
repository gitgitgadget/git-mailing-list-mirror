Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4BEC55179
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9625207BC
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUBTzsMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390443AbgJ1X0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390348AbgJ1XYh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:24:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83276C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:24:37 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so811644wmj.5
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TALQNTkPCqZi0Sh3usqwJVBnJ+g3wMucyiExSYwBcSw=;
        b=jUBTzsMIodTfqtz3KrFXhnA+r6uiPxGY77Xk8nh+J1x0RX8yOuQKQdHFVKYVwxhep7
         lgjaCGJHuuhcjjtXZiq1w7g5ytAJ7XgDxK0gNL9W5L0eKt6CfyJ7ZK++9789qMbpGEfY
         pF8pv+zPxkV+7iK/LhDOdA20WYolxglFDK9Xflob9VMR1uF9IlIyLJ9fwstIIZZ4iIhS
         KsTj9RdWsnAMXKkmtHLRBXS5GFsZyZG5VkX5Ki4hLEpPPYSJkvxPas5Ry46gLlr1FkER
         deK51JyJpVFfArtMkjHjTlly8DI03oj52y+F9TzV5GTF2BUqcsMe3vCCETWQhCv0XjkQ
         yW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TALQNTkPCqZi0Sh3usqwJVBnJ+g3wMucyiExSYwBcSw=;
        b=CG72L/LVnTMabD8msOI2FPjHeH0nt9iScOJMEUp0m4AmeYtv0bLVAkr1umLLMYhkc+
         h8hpPG6biD4ooEyNMkOhnmdxDXMu9ArL+EwLPop63TuDTn914+shUqkAp/ACbtj281lV
         UTRs68448OzbcUly4eMYO5qNO2daFo9rNGmgPrOqZ7IkZjtYSMo5GUekMF5jB4HpX85h
         IYHgboDxoWl4o5znRYvaNuNfYZKJAIz53Di4AOCKbHYPp/Ct4U4ftdhUg9YSMcGRH8Gb
         MnbRwU5+BWoSRJdTXTkyygqFYiHyfZcR0iqUwhGX8+T4scQ7Mkl2gdWtWK9gZG3C7wJI
         KSoA==
X-Gm-Message-State: AOAM5316JRPnnY9oaQVePzcQwJlMjPa+nrnM+xaneV0X+AbgmCNHdNDx
        nhe1M2iN1B9H3pPmJ0arWUR2jzllNCE=
X-Google-Smtp-Source: ABdhPJxLTbGQyadFn2mtRroAAl73sMac5dwA34ZVMdON4Ibmb/Bqs+Pg5Sr2heOMJuHRUCsVyYYICw==
X-Received: by 2002:a1c:dd8b:: with SMTP id u133mr6906587wmg.73.1603889276772;
        Wed, 28 Oct 2020 05:47:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm6706669wrj.60.2020.10.28.05.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 05:47:56 -0700 (PDT)
Message-Id: <27ef94e9cc4189c3d74e984437dcce24e1f29678.1603889270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.774.git.1603889270.gitgitgadget@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Oct 2020 12:47:49 +0000
Subject: [PATCH 5/6] line-log: mention both modes in 'blame' and 'log' short
 help
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

'git blame -h' and 'git log -h' both show '-L <n,m>' and describe this
option as "Process only line range n,m, counting from 1". No hint is
given that a function name regex can also be used.

Use <range> instead, and expand the description of the option to mention
both modes. Remove "counting from 1" as it's uneeded; it's uncommon to
refer to the first line of a file as "line 0".

Also, for 'git log', improve the wording to better reflect the long help.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 builtin/blame.c | 3 ++-
 builtin/log.c   | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index bb0f29300e..05f69211dd 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -889,7 +889,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("Use <file>'s contents as the final image")),
 		OPT_CALLBACK_F('C', NULL, &opt, N_("score"), N_("Find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback),
 		OPT_CALLBACK_F('M', NULL, &opt, N_("score"), N_("Find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback),
-		OPT_STRING_LIST('L', NULL, &range_list, N_("n,m"), N_("Process only line range n,m, counting from 1")),
+		OPT_STRING_LIST('L', NULL, &range_list, N_("range"),
+				N_("Process only the given line range (<range>=<start>,<end>) or function (<range>=:<funcname>)")),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
diff --git a/builtin/log.c b/builtin/log.c
index 0a7ed4bef9..e6a3bb7803 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -183,8 +183,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 				N_("pattern"), N_("do not decorate refs that match <pattern>")),
 		OPT_CALLBACK_F(0, "decorate", NULL, NULL, N_("decorate options"),
 			       PARSE_OPT_OPTARG, decorate_callback),
-		OPT_CALLBACK('L', NULL, &line_cb, "n,m:file",
-			     N_("Process line range n,m in file, counting from 1"),
+		OPT_CALLBACK('L', NULL, &line_cb, "range:file",
+			     N_("Trace the evolution of the given line range (<range>=<start>,<end>) or function (<range>=:<funcname>) in <file>"),
 			     log_line_range_callback),
 		OPT_END()
 	};
-- 
gitgitgadget

