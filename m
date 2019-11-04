Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 275941F454
	for <e@80x24.org>; Mon,  4 Nov 2019 09:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfKDJ7r (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 04:59:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42922 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfKDJ7q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 04:59:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so16248010wrf.9
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 01:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZBEGzfb22bgr9/a5p7Q6yLV+a10GeNAN2KIKVQl/ebI=;
        b=P7xVu1pN1h72z/PNBk6pnfq3TE8f9ksAtoL+qAh80zweXvUj8dzJphDUQ2rRXkcwJ8
         W3mhpm2GYSoZ7W9QYl3nY5BxWZz6Lrx2TMtrDZoTObQJ01tfNFRN2Yw/SWZjNZ+kXdA9
         UCtzh2AoH0Bj/E/29OVtJZUhDTkLvHG8BLXplW/B3xYlpeNO0FL0ahSM3jap94Yf8QQ1
         FsBdIq7mDU9uI8pE85zaU1ts2b2chNke1vJUeAid0RgVOlka5a2QDEXwo7icRc+HtKiM
         WvPH/kavmcbsICg0cMEY/5+P91neaG5weInTHIJ/LnvPiFe3TxfJcpqpO0pPyKDpJ4ZT
         wJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBEGzfb22bgr9/a5p7Q6yLV+a10GeNAN2KIKVQl/ebI=;
        b=pf0r5UTPZodqAz7YEgrT0Au5z5rq8NzdKMep+JmZVbFJNWxeIA2wsvKs/xMEMO67Nw
         VhDingBXjaqjFV1fWGIlmIjgmwQo5JJ8LrqUnmOPTY6ugbZGnf7un0dMrhQ9LrMFCmZJ
         RSrPs+Gz+LhC4CgdZjQfqB9LU/w/kuY+FaC7ADUFUmrbCQ8K6pkEh0CX9rkaQlEWpbTs
         XtpsbhK/7fn54o7n5sxbZMT6wKdoMuTSK/8RPYodNlb4JLSC/IZYe+KN7yzDyQwur9FL
         JjjQ174ZuPJXUd10XFAIr8+18i/IYXlUZcDZ/Aq9Gk4+OlkfoExWgJZxtxZIpAFe2tUn
         hG1g==
X-Gm-Message-State: APjAAAUvqkSXCY88PHmK0NZo7Wj/2c7Vaevlpz2p8VH/OIg6b5gcfy3n
        +rNl/XLUOifpMthCWeiF3UrxcQXOBw32jLpa
X-Google-Smtp-Source: APXvYqzVDWopMVzWX7kpSTVGF/7keHbGObC13cWEt+j5GtL6yoN7w02qW95KgiXYAP8ySKB9G9U5fg==
X-Received: by 2002:adf:e542:: with SMTP id z2mr20697341wrm.338.1572861584473;
        Mon, 04 Nov 2019 01:59:44 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([13.81.118.113])
        by smtp.gmail.com with ESMTPSA id j22sm23382554wrd.41.2019.11.04.01.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 01:59:43 -0800 (PST)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 32/32] date.c: fix code that may overflow 'int' before it is converted to 'time_t'
Date:   Mon,  4 Nov 2019 09:59:23 +0000
Message-Id: <20191104095923.116086-3-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.24.0.rc0.467.g566ccdd3e4.dirty
In-Reply-To: <20191104095923.116086-1-gitter.spiros@gmail.com>
References: <20191104095923.116086-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the LGTM warning fired by the rule that finds code that could convert the result of an integer
multiplication to a larger type. Since the conversion applies after the multiplication,
arithmetic overflow may still occur.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 date.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 041db7db4e..b8dcbdbb0e 100644
--- a/date.c
+++ b/date.c
@@ -1172,7 +1172,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 	while (tl->type) {
 		int len = strlen(tl->type);
 		if (match_string(date, tl->type) >= len-1) {
-			update_tm(tm, now, tl->length * *num);
+			update_tm(tm, now, (time_t)tl->length * *num);
 			*num = 0;
 			*touched = 1;
 			return end;
-- 
2.24.0.rc0.467.g566ccdd3e4.dirty

