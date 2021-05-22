Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7670C4707F
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BD3610A6
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhEVN6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhEVN6k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45699C061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n2so23815956wrm.0
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vXmaiC8x6u8wcpNaHM4nwJMmiaeQYsIMT/cHQQVEbVc=;
        b=NLREgGNGLmXlfxv8M6Po+ml78Bi2rOnpMshI6xuG6bD8kGhqhM3l9LRcxSNBJcEZqm
         vGbsQxmQBxpwqCv7eMbzf3xbu+KE5N28mRLhaluNBZSyeyZB9LZnSr8utWS17Q08GZGj
         s8eiIWcCWv50hxTj2ujKTl3QIW+PK7CFwNHIwGRFewc22ici0dzG44WTcdGJTtEsCNjq
         R4AHnQd1pJWyI7C2ubNhx4W4haimpV0lSvLUsUnL6um9UfAYD3JhdEtg1/DVtqQePES5
         /YD8zW1UexWemYGockznNFk1wmEmYYNOXG4tkhJwOzsB5KA7dle178ZCSGCvq3EwmxNG
         pvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vXmaiC8x6u8wcpNaHM4nwJMmiaeQYsIMT/cHQQVEbVc=;
        b=n9NyQwoa1ncDviD3Z7DT0/UiF5BJZ0zo19dwri3rtq5jBPjc/0SBn6Byp05sHje+DW
         QsXNhhsX4D7Qk23X6/odk6+SzMPMQIaV1aQYsnUis8ojLypzae3j1Uc7cgR+WN1iDlH5
         mTcHAxpsnuI5xEAhNeeCxPTrXvRXU8/mjpFdgbG2Y7jzxkmdsydMhGS7U9ih+tWiy7N1
         j3W3ffG2wwySGdUEUiQ4VPIu9LqLl9n3JJMdcSCnSkBhYjP2svVruZj6+qG8WDSTP2Mh
         UwI7oFvCp7MFfSylAmjHC1d5rTXNWLrE4ECvIfPsEtvjlofI5foGV4zoHjnlc06SX1Vq
         QtsA==
X-Gm-Message-State: AOAM530Rl6zdO7STDOLrpim+kM6CZeVt3XAgm4GLuIrHSgvMg6PS6opu
        oy+inn0+SnU/R0qygs1enYrvSmTCntQ=
X-Google-Smtp-Source: ABdhPJwF0aox/05fQ+wjB0ZKHdhzn1wMZHT8ZBmI+IgnjMHlzUGw3ZbFUZkCArJvOWevxQ9Zcf/IdQ==
X-Received: by 2002:a5d:4351:: with SMTP id u17mr14044593wrr.47.1621691833887;
        Sat, 22 May 2021 06:57:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm5538984wrr.20.2021.05.22.06.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:13 -0700 (PDT)
Message-Id: <d5d09eb1635bc6a0781df6218f0d2537605c4666.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:56:44 +0000
Subject: [PATCH v2 05/28] help: include fsmonitor--daemon feature flag in
 version info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add the "feature: fsmonitor--daemon" message to the output of
`git version --build-options`.

This allows users to know if the built-in fsmonitor feature is
supported on their platform.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 help.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/help.c b/help.c
index 3c3bdec21356..e22ba1d246a5 100644
--- a/help.c
+++ b/help.c
@@ -11,6 +11,7 @@
 #include "version.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "fsmonitor-ipc.h"
 
 struct category_description {
 	uint32_t category;
@@ -664,6 +665,9 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
 		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
+
+		if (fsmonitor_ipc__is_supported())
+			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
 	}
 }
 
-- 
gitgitgadget

