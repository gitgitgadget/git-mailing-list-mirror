Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4A0C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 23:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7AD160E78
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 23:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbhHBXXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 19:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhHBXXY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 19:23:24 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984EFC061764
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 16:23:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so952380wmd.3
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 16:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G75EU94H3VvMzOV2C8WaNF1CXSRXS5uIWoEJ+blAAaY=;
        b=Q5Ocx0h226XflatDZ9DVS5Sddn3J8obEiIc2XooAIHfCxN0enhV6SHr7/50nqZebam
         bPilRtKKJqELKLn5/wtEY2HN7KmbFHxFg1GJEF72/rEMX3moBMwPTICQEWvIce7LvvC+
         ViW7CzEsttHbzkfMTxyTy1MK9O59LkdZRt/lo8yt82DOvuU8a5zOs1K1VUmM8TXRx52T
         9aH0xicvSyhbod7yayQtFNc+LcfZ62MhtiMdZZfakvrpr0drB6ncan/OkEc6D9IWTqMG
         0Y9WW78ttxuyEx1HW2OCvrhlgfeZNJ7qAlNa5s5QLKqZDwapRA9vNYhM7lTcS6Cr4TiN
         diYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G75EU94H3VvMzOV2C8WaNF1CXSRXS5uIWoEJ+blAAaY=;
        b=ujVWSGM0AqpSSvl90Hm0gn7tzJeHybXrMdVtRjfLGAE1RmJXiKuAHEGNKTwdfAll0H
         25doRPxcuiTsqvdh8mLBrHcJDXyETFhzywlu2QuqMKHnh+RVwZnCVx76iIvgVyYiGGkX
         Q32w7AzqUnO4L4yySwX3q9E0bB8AnH4zJZfjbk35Pp9N9PCMEGw4RVSx3/r+MCX1TSzm
         aKbfFysTVtVqoBVr7HX6f9ARvbnBW9aPikhrOCLOGbVrF7GugyeFi6REf9hZDd5p85u1
         mQuSXW9GB/4YKkrjD3OZ5+WX5MbqCtz1xaTzVH0D/8I4HILJIikto5a1Bn25qWPbtJFk
         D7fw==
X-Gm-Message-State: AOAM531QU54Gj6G8B5XA4gHtZjVE0imxWQmzns9pPQ+rDMcjVcbP/Uet
        +r9A6fWFskwGu2Wj4yecAaEtXrp+Ql0=
X-Google-Smtp-Source: ABdhPJyfAglcmQTGAhF9l5TwXaeOGe2rbS5iG3VEiEqJCMHxMMrS8OjxB00Bp9n0PimPIu1It28tgQ==
X-Received: by 2002:a05:600c:1c11:: with SMTP id j17mr1173073wms.132.1627946593310;
        Mon, 02 Aug 2021 16:23:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a12sm12617217wrr.84.2021.08.02.16.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 16:23:12 -0700 (PDT)
Message-Id: <fea3d6d72b63c06138d8eeb61e45edb30abbd79d.1627946590.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
References: <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
        <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
From:   "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 23:23:07 +0000
Subject: [PATCH v3 1/4] clone: update submodule.recurse in config when using
 --recurse-submodule
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Mahi Kolla <mahikolla@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mahi Kolla <mahikolla@google.com>

When running 'git clone --recurse-submodules', developers expect various other commands such as 'pull' and 'checkout' to also run recursively into submodules.The submitted code updates the 'submodule.recurse' config value to true when 'git clone' is run with the '--recurse-submodules' option.

Signed-off-by: Mahi Kolla <mahikolla@google.com>
---
 builtin/clone.c          | 1 +
 t/t5606-clone-options.sh | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 66fe66679c8..f41fd1afb66 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1130,6 +1130,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					   strbuf_detach(&sb, NULL));
 		}
 
+                string_list_append(&option_config, "submodule.recurse=true");
 		if (option_required_reference.nr &&
 		    option_optional_reference.nr)
 			die(_("clone --recursive is not compatible with "
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 3a595c0f82c..3daef8c941f 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -16,6 +16,13 @@ test_expect_success 'setup' '
 
 '
 
+test_expect_success 'clone --recurse-submodules sets submodule.recurse=true' '
+
+        git clone --recurse-submodules parent clone-rec-submodule &&
+        test_config_global submodule.recurse true 
+
+'
+
 test_expect_success 'clone -o' '
 
 	git clone -o foo parent clone-o &&
-- 
gitgitgadget

