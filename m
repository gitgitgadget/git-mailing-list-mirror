Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13B1C433E9
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 859DF22D08
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgLUS0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgLUS0h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:26:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66587C0613D6
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:25:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id e25so11896591wme.0
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3r7mtXInoIgW9xHjAGWVPhNwI0akWriajwOoDVsErOw=;
        b=dB5jKvL3VC+ftnzE751C/30X2hBbh1+e1eUqMhaoyKl2GZjgdz3vLn6kR+Mp6GGGt5
         3sm0P80Cl28cjlMsR++OwnW2j+m0rD0nawD+3UkMMehP06kpzhRKPR+RYD0f4BnVAnuQ
         buZYd2jHO//mKtuW5v8JZzUyllCsrpnY2OJ8aM2VNOvHlE/glJqpkYcEiHom9d8eS304
         TO1FswYcuYzElYv8pHMBBFBF3y6YVIcPQrjcXHE3yLdhNfQfI2eJUbrM0C/kVXZ0VGnt
         r/Hb+MqxX5pzNBUcdm3J6QbIu08+ecHzla8PIKUYc5s/mxkKytFLRSWxROogvPvum49D
         cPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3r7mtXInoIgW9xHjAGWVPhNwI0akWriajwOoDVsErOw=;
        b=abxHEiZHuBvWhsL7pjG1307x/UzxEfeUCotEFvWjeaW3kg1ZPETns049fR0lO90A2b
         nRjUfvDVn7iQswjPKzgHFNTrpiK8ohgGHciol48HCGJWbBKo7dRDuz14RJwyT8oSBkCS
         PS6jCkq1v3y0I9cuPa7urJ+SXTOTcbNx8nX24eJW6AX31lwugrDqTdPFVj3v6xAm3HLw
         2x4JDrYXEeFlH/lJ0Q4xoL70PyfKfJPU4uqCOC9BbvQTxbnc8Tu4KBPREBqBqBZcgPZ8
         F5j5iQdfO2wEXMBjMb/loV/mhiHnZXwGfHILVkcMRPQB5F+dtbZlZwoqjR71q3TpGVlr
         y1Yw==
X-Gm-Message-State: AOAM530thNBIF+Hygef7nSFMkAnzQbO4sc6jdbuthGO1gTWsUzSVS0y2
        Y0RdZHXkFJoI+f1wtKU3EkTfn9fufY+MpA==
X-Google-Smtp-Source: ABdhPJzOswkb/vYYdDUKjwzAyBMgU1mnbmnx0JsgfWaIweQe8UapVIMsUejCM1iZ1McTCP4q1C5tkw==
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr17870860wmd.49.1608568171520;
        Mon, 21 Dec 2020 08:29:31 -0800 (PST)
Received: from localhost.localdomain ([81.0.34.85])
        by smtp.gmail.com with ESMTPSA id w18sm28523532wrn.2.2020.12.21.08.29.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 08:29:31 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 4/7] bisect--helper: use `res` instead of return in BISECT_RESET case option
Date:   Mon, 21 Dec 2020 17:27:40 +0100
Message-Id: <20201221162743.96056-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221162743.96056-1-mirucam@gmail.com>
References: <20201221162743.96056-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Use `res` variable to store `bisect_reset()` output in BISECT_RESET
case option to make bisect--helper.c more consistent.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 896c54f869..e2e568823e 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1085,7 +1085,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case BISECT_RESET:
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-		return !!bisect_reset(argc ? argv[0] : NULL);
+		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
 	case CHECK_AND_SET_TERMS:
 		if (argc != 3)
-- 
2.29.2

