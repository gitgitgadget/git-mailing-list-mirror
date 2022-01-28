Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F57C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 00:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344493AbiA1AMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 19:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344449AbiA1AMh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 19:12:37 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE02C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:36 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l25so7610827wrb.13
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 16:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ff2Q/b+XBBCbZWENkgo9wWyYGUXXcYV6vwClmKN88ag=;
        b=TSZ714fGc6H3TkXMvwsqdbz0q3XFKIWSGBlHEMxKfMrxUr5emGPgoZmc+FpfS8nfT+
         jVL9cr77ZZBLgnrZpTq/K1UShWHcMVHY82Grd0iHNUrPvI1JEtUTt0iZgRhXPgdn1AIT
         DJZj3KXth/V/wPvFV3UOARtzGjTV6HeA35p8ZJHKEwEIrtsLOZsP1GGbWZLzNAnElVDt
         /HQqDw/tgnq8as9jxqpp+tI3LFYK4j5xZ9JPOKUdYKVmOTXv3dPngPL79VB98aIZVND9
         hN4xqRFFxomdV8Ru/qULwNTev45Fy2Ygw1qVrtIuBAmbQpNnPZa0LWkpFAUB28sxCrAS
         WliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ff2Q/b+XBBCbZWENkgo9wWyYGUXXcYV6vwClmKN88ag=;
        b=PPK6CbENe/fIOYLxqkcrb3g8ydlR08JelmV06Ia8gip4hcRohVGhnFdmRBjtuoFIGN
         IksEyHBB/YeY0hOeoHLTCSVM18Uzfw2B6tVA4TrwkGvIv0gOoSqNOJsVxjqqcbQLmsdD
         wL49OGm6KWdNXb5CfH1EICtQdCLy9BoXtq7/04Bwkt9Xuy9YXp7u9FlMhngfbTp0Og2K
         x/OgyeUXca8gR1PE6egKPBPPtOXnWmW2hUM96dPTKZGdue9OIeM35988nIEywqi1mB5R
         bdC/aF60NztVRjyoiM0w8zGvtyNvh7T1Pg0cdZ8+ajoeZH4eAq0VQiEen2ozZf7JMo+5
         Y21w==
X-Gm-Message-State: AOAM5327yNkT+1B4OYPVS5kwzVdKp5BmV7/aMk4OVfmWCMKWjLdnce0T
        +S9m495WF4fiqMQLUapG7ZeyqsmetTI=
X-Google-Smtp-Source: ABdhPJxZUghbgrXNWLF4tHAnhZVRCeIQc6q/yGKZdEvo8vKTQvxqM2yagg3H28A9N6CnIL7v0Z9VZw==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr5025887wrw.472.1643328755303;
        Thu, 27 Jan 2022 16:12:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j12sm3246757wru.38.2022.01.27.16.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:12:34 -0800 (PST)
Message-Id: <8e0e555998007b2625f4a99f3b800e5f4cf89e19.1643328752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Jan 2022 00:12:23 +0000
Subject: [PATCH 02/11] bisect--helper: retire the --no-log option
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

Turns out we actually never used it, anyway...

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4208206af07..9c8ba61dac0 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1182,7 +1182,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_VISUALIZE,
 		BISECT_RUN,
 	} cmdmode = 0;
-	int res = 0, nolog = 0;
+	int res = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
@@ -1206,8 +1206,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
 		OPT_CMDMODE(0, "bisect-run", &cmdmode,
 			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
-		OPT_BOOL(0, "no-log", &nolog,
-			 N_("no log for BISECT_WRITE")),
 		OPT_END()
 	};
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
-- 
gitgitgadget

