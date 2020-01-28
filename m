Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A9AC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09886207FD
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bg4SKF02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbgA1OlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:41:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51013 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbgA1OlP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 09:41:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so2809059wmb.0
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 06:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z1w/Hc4cOkaibn8kvCOgrzsn1RxBbiqlk6Mv4m5lJ4c=;
        b=bg4SKF02Djm+tbt6WumL2FK+8/U6nxUz8wJ/tyldJIR+AhHggZwz4vtMkazuEaJPPp
         Ry7TuKN/MVZGVo2GK1b8ugpnRpJMtwfdXH0H8IzD0yQ1EH+AtbmqYvw6b2lee35hW/S0
         T8uf+dMK86BhraLLVeL6xP4S2vLfoHt22qacuy4kf/7LJbgMx4PsHYSHElC7NjwgtLHz
         CZeQU+qPzbgzKEZcBOvfBgj1Orb+jneAd3XjALQX7gLB5mKRHsydBDFEm/l/prsUg/Tu
         xGyQF0ghfTlxwztOWARJFgKFXOY909UthJQwvm+xDAOXDWBbIhVK37Gd94KAhnLq0piP
         or6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z1w/Hc4cOkaibn8kvCOgrzsn1RxBbiqlk6Mv4m5lJ4c=;
        b=YCG+Vv758BgrgU+7gfVrWPyIGYbE2bDCt51BMSEdrgSmiPhXLFNhWe9oq9CvVqh68R
         yoO3a67DqURQwYrvq1CxS/NiiyZ7QlK9DhqRdBWiyoMs8G1nwSqgFUPtwfHHKVrMod1D
         VqyxOmh/CnP49gGeGkGdr4WAeGQk18XPxd72FLJa9kRp3AO73+YuWd9w/jGaAG6S1bek
         K83PcEMrsaptOBhLwCsJBJqrJ3sb477BO0b2YkvbWnAOUZW1Qi9P40hUAHT2NDlK4D7y
         doD4qZlRVFNWMvUjJBVHhKIMKMQ6/oD3dMEbowb1IqKDTp57y1ue1uPQ1LKGQGdDYRg5
         4fnw==
X-Gm-Message-State: APjAAAV+NELaTU/JepgDe2UZbw1MgwUg0CHbdFmzmn8ShGl740NdFOp1
        3+5tGsoLiybm0rJBYl4+2qjiKWbK
X-Google-Smtp-Source: APXvYqx4uNDdzjcDfbzkZSWdHyGmRoNqJUOp2ktP4rqHoFi7oyaIG/TK9oHv02Ro4RJyXgLtTNT7Mg==
X-Received: by 2002:a1c:a584:: with SMTP id o126mr5208579wme.163.1580222473026;
        Tue, 28 Jan 2020 06:41:13 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id g7sm25732439wrq.21.2020.01.28.06.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 06:41:12 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 01/11] bisect--helper: convert `vocab_*` char pointers to char arrays
Date:   Tue, 28 Jan 2020 15:40:16 +0100
Message-Id: <20200128144026.53128-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200128144026.53128-1-mirucam@gmail.com>
References: <20200128144026.53128-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using a pointer that points at a constant string,
just give name directly to the constant string; this way, we
do not have to allocate a pointer variable in addition to
the string we want to use.

Let's convert `vocab_bad` and `vocab_good` char pointers to char arrays.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1718df7f09..36c09b7238 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -52,8 +52,8 @@ static void set_terms(struct bisect_terms *terms, const char *bad,
 	terms->term_bad = xstrdup(bad);
 }
 
-static const char *vocab_bad = "bad|new";
-static const char *vocab_good = "good|old";
+static const char vocab_bad[] = "bad|new";
+static const char vocab_good[] = "good|old";
 
 /*
  * Check whether the string `term` belongs to the set of strings
-- 
2.21.1 (Apple Git-122.3)

