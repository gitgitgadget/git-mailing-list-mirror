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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2219EC4320A
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 23:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05DC160EE8
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 23:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhHBXXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 19:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhHBXX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 19:23:27 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C2FC061764
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 16:23:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so948159wmb.5
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 16:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gGfkCezrfD6smXUugi9sIVKxCCAugcZ62GlmyNQXaX4=;
        b=ZI0VXjMUvWtPYrKi6Yddl2emzgjzZNm2Ld0iR+FYghkGxRcR9b0qt437kcxt8+DXhL
         SxOBQFdnfAa0UObMbDP5ycXVlZvoRrfg6LK63BIRolzgw8lI2TmNgTlQvKGquZ6Y2ClM
         DWpOiUYS1PglxrHJ1y6/3xS1gAdvAPAs2Pukc7ziWboMbUeb0vewjKYJhz//ZN7GikzE
         GzJl0XpltL6r2ZkzNZFa/5Fj0xnRVuacDAZYMBmR48s4UyiJWANXBVWfsrbTZweDGPcg
         SWqjL1l49xrdEeuFCjiQCqGnoDUmWwvyyTa/ihVkTAFHeJkRmPAW/Ha/6GPlpmJw1Nyz
         +mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gGfkCezrfD6smXUugi9sIVKxCCAugcZ62GlmyNQXaX4=;
        b=XR+EEWwqKLstp5Xa/hpTHaQ4ivXkBiVG6RMywSUBRktTeZJxDgUqaWEbJghjkL+Waw
         Mcjb4/gNiaJjiPZhfLB32DGn2IQY175pR68/Qk0uv0lYdLNE0hpFz+UECqVG8pbiCGeF
         4LcCldZldF8GWmnsabwIa1FF13qvAVRX7WrjaeH4FE5xRCJX1HHd4JPdy4gW0p5+cmef
         R7hp8OnvdQcJHA6glLDhtQD/2oRJWeUqCcBjObq17V0w5Fz2Rffm6NG052Iz3WP3AOlp
         LIWsxdEVZiszFI2fUDm+wep44MHgfU14LQWpcvX938PDc8ZhubQtb/SYk2dWuSo5H8BL
         kI5A==
X-Gm-Message-State: AOAM532XpWZz2j/2vs6uCKwNFucHMzTjWoS6XRGpxAOV/ci5S/GPBaqa
        GqAqbc9MLEMFqWDgo4tP0cZbZvLbSY4=
X-Google-Smtp-Source: ABdhPJwX5QuPrCxYMgIRsylTaZCO8Wr8//12GCJj948pfOIU1wdnmZFqipg/DR6ddqq3w//FVUoG3Q==
X-Received: by 2002:a1c:4409:: with SMTP id r9mr19115039wma.150.1627946596412;
        Mon, 02 Aug 2021 16:23:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm9326353wrt.87.2021.08.02.16.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 16:23:15 -0700 (PDT)
Message-Id: <f3ddb344b49b00d62574135f857b472064219583.1627946590.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
References: <pull.1006.v2.git.1627943914.gitgitgadget@gmail.com>
        <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
From:   "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 23:23:10 +0000
Subject: [PATCH v3 4/4] clone: update whitespace according to style guide
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

Previously, the code used spaces to appropriately format. The spaces have been replaced with tabs to follow style guide standards.

Signed-off-by: Mahi Kolla <mahikolla@google.com>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f41fd1afb66..c6bb38d2fde 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1130,7 +1130,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					   strbuf_detach(&sb, NULL));
 		}
 
-                string_list_append(&option_config, "submodule.recurse=true");
+		string_list_append(&option_config, "submodule.recurse=true");
 		if (option_required_reference.nr &&
 		    option_optional_reference.nr)
 			die(_("clone --recursive is not compatible with "
-- 
gitgitgadget
