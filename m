Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86834C4332F
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 00:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344506AbiA1AMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 19:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344203AbiA1AMh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 19:12:37 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D903C06173B
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:37 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso6995879wmh.4
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rQxd9UNl4dqkd7Hv933DGBgLXVurR9u+yuPopOgIpdI=;
        b=b4aSwceWDfjsdm63fdezhuANsYYnjvBB/0rMNKeJpHDhQd4DCMZC9RFhUBcLpRm57Q
         xZAFREqVodXwMqpsMZnAB1o9CNMJo77j3DyxO4LDBtgP4KNRHATKR1hS9DpbTw9yUVGQ
         3a18DIil2TKtFltZD9n0ZjoaK6AYrrxoCknID0Lg2MhH40jQEqbstKqCo4XmPiZWjshk
         ZBqWlSMu+hVH8Zp+GfhWDxd+AwpvnZy0BRj7/24DbkNFRn8Yoe/Ho6J36hY6tDRXQsge
         n46V4JzonclgTsxFiF0vGqJ98eoS/OACuKC+BHxg26GBAVTkgTvcoIMacI9yG7eVYXkS
         jygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rQxd9UNl4dqkd7Hv933DGBgLXVurR9u+yuPopOgIpdI=;
        b=jiKfEpd3HXBDsoeNaOd8LRRF6ix0oXfGc6ivj59UMVO33L7esNJ4EWmUTm1YIwLFLP
         wQr6ca5Y8h+ndVNc00LHJYlp2dzQkNrGbPMYWbV6jf9+manLzRKZib5nFvJSglnShw0j
         4pCkPpKSB2WaaogZsljJWMY+zivrGAqHTqPs6WgJKeLi/7vHe/+FdOEn2jfc+ZZseeTI
         BnXz6XSnR979RsGpYYmVPvvUEX6roelpc8plgExrRvMF1+8gm5ogPm2iyiaP/CxRIQki
         4dGWnOG6WLY9CsIaLh59QesniywyoEaShdpGgdWmWtRDcv1N3BHCVnFHdwgpn8WBL6ua
         n3lQ==
X-Gm-Message-State: AOAM533ujQfP77e+mk/eR8tDDTTDjg6T5FBoVlR0eXCVZ9LSoTHuRM1C
        sb6l+St+raXeAuU/tKRIu/L7fQBkSa0=
X-Google-Smtp-Source: ABdhPJzzwFY8io/hBcEv1N94jkIUo8ovptIiiBP0d23LHyLCR84/koP2JVC4hBpEcpL8PSiL4W9G6A==
X-Received: by 2002:a1c:730e:: with SMTP id d14mr13751382wmb.64.1643328755963;
        Thu, 27 Jan 2022 16:12:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6sm4061181wrc.65.2022.01.27.16.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:12:35 -0800 (PST)
Message-Id: <996a7099bf8177ac018f9f534aec04921c4ef0e0.1643328752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 00:12:24 +0000
Subject: [PATCH 03/11] bisect--helper: really retire --bisect-next-check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 911aba14205 (bisect--helper: retire `--bisect-next-check` subcommand,
2021-09-13), we removed the usage string and the implementation, but not
actually the option.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 9c8ba61dac0..dc840736cb5 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1170,7 +1170,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
 		BISECT_AUTOSTART,
@@ -1186,8 +1185,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
-			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
 			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
-- 
gitgitgadget

