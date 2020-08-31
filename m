Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07735C433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A5920936
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 10:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRiAdEtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHaKvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgHaKvM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 06:51:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B950C061575
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a65so4914744wme.5
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 03:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ofxh5lrQ413krwngWYtfxJNA/uVroqEq6PSX1rEY46s=;
        b=QRiAdEtqt6Cn+e+wvnf1gZwhRnjB+txFVPUtq6rWI6DwXfjbw0owYUBhCPoL1Cnd7g
         C4ynKMicJQkKkV7vIzvYVdQP1esU9c1HTAv0xeKLxjQV3zQ9TnqVtBQc2l2q+XesmoVh
         u64ibr7BzYTQGv9MDDfR2qxR3pClmMt63u8mE0VMASO+7TRTS1gOH40qj3T8AqbpcpG0
         zlFWsAvYT+DWRkJFF/w+wO+pjaN9f1e28VJEGmtwDbpZbHzwjKcxR36FGBVLQDj6bWQy
         /rdrcGSXhlRA483tsIHLRy2HD6lFUCffuMmAbJPZBsKkvyutVku+mqG4lQhIHaEnqXyE
         lSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ofxh5lrQ413krwngWYtfxJNA/uVroqEq6PSX1rEY46s=;
        b=j2ENdlVoVASpZw1u8PbP4/QOL4j9Eh3uT9i3fWIghGZnC56PEHEQPXwZSZnI6RWVzx
         iSMpnWFeZBthmF3yRLKugETQCirC8duk+gmZfVw5KdH2xW/MTa1X8k/H+0Ez3UPHXwI4
         EfrFLDW537TpMeYwfcO10Dgl3E0nkFCZ9EsARmsfuNZXqu81Hsb1Vlh9U/hhrAuLLo54
         AQJJrWqWqvSL/3yr0Xs/dsAiZbL90lYRnabziHM4xC9VQcSuZz3iPSP5djKv8mz85J3y
         IjrsBYTedT/oLF3YG/FJ5H7B2zg6amkiDxH7boEU4vQmXjET/qL9Vlpx2AbA9w0n2Ovt
         EByg==
X-Gm-Message-State: AOAM5333NvYN+oSbxxIUkAyC+DZHOyYC5YOTV70ppW/dcoMPxwGc5v8i
        EwjfQd9OzzIw5SzJVE2SRuleqYpfUhA=
X-Google-Smtp-Source: ABdhPJyN6Q1Kk+rGIZVaM+wYQbxYdeaKHWkqFxn4EEvhbybBP+9G6lH6RaMhInT4Uj8itA9D0uRYHg==
X-Received: by 2002:a1c:f30f:: with SMTP id q15mr840667wmq.60.1598871070462;
        Mon, 31 Aug 2020 03:51:10 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id k84sm7674454wmf.6.2020.08.31.03.51.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 03:51:10 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 02/13] bisect--helper: use '-res' in 'cmd_bisect__helper' return
Date:   Mon, 31 Aug 2020 12:50:32 +0200
Message-Id: <20200831105043.97665-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200831105043.97665-1-mirucam@gmail.com>
References: <20200831105043.97665-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following 'enum bisect_error' vocabulary, return variable 'res' is
always non-positive.
Let's use '-res' instead of 'abs(res)' to make the code clearer.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index f464e95792..b7345be3a5 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -731,5 +731,5 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE)
 		res = BISECT_OK;
 
-	return abs(res);
+	return -res;
 }
-- 
2.25.0

