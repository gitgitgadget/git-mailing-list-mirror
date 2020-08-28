Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBC5C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E882D2086A
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaCJpAOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgH1Mra (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbgH1MrS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 08:47:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD082C061232
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id s13so808802wmh.4
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ofxh5lrQ413krwngWYtfxJNA/uVroqEq6PSX1rEY46s=;
        b=XaCJpAOHm/IrC9JQPEhOpNe5ryb+v7poVMsoeQ4lC/6dfd1GTxvJH43QETqodlsIVb
         epliPR6jRWAfrJMu8wSgg8nRk5BmYbViuC9jTwpaCD+GQaR9ZReHz/AinsXMOFsaoQR/
         0NdmKCQVkDbSEgTaqRtd/xbX8+tGUXQc9aKhem7jmLPdXwYXEr5r3iwQSEk99zAGvdVl
         dW8a/TQj+oSPfqdgVp+qWOJlkSlek51tVQelcBf1td5qa6ETcRYReKyRrfUNxjXX7PL/
         /taYKmsIFuG6A8B7KbuotY0CvbSfTX/gFMcoAGskc0Q/4+ehy7d2zqZ576IjVBuyhQE1
         uPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ofxh5lrQ413krwngWYtfxJNA/uVroqEq6PSX1rEY46s=;
        b=i0zdZWrJGSmnC9+o6OPsiRavHNZR0afdxqUPnjPR/g/Cwdl28LHhlMXfKQMS9KHJKs
         9Jf2jZobD6LSvTTt32JZwQ0RUtZR1GFxoY1gB/OkWEd6ZV7/vVTYxX6P9zgyUI1Y2jMs
         HH9P6CIkIhi5LcZACgxnUfAAMyiCTqlFZNZQ8NsrLVXxRQaHsRGYUUXmekL07u3+wxzs
         C+fiBeM/Rx2gUormHfa0nQkAns1CZFtnqTa1gpeEAKoniZbw3iq/bwmobUF54byCZhZN
         vXO8xnspIDlZllyKbOZayDnej9Gpp4Cw5nilCC3KnW3iCWOG6iPld4NJaCjHi3gt1jjW
         DLmw==
X-Gm-Message-State: AOAM530QABlHcAzKAc7FJ5EYlwpYqgJ4sxb0xm5yz0epeMxio78e1YOa
        AsMAsiztRyCu5vFtDSRYpriHxsPvswQ=
X-Google-Smtp-Source: ABdhPJwCa1fFbl//BfzXIxyP6fbghMVJZZ06nREn0nNVga/J1uV1CfrzwfQD/A9oEtJEuQtsD9JuFw==
X-Received: by 2002:a1c:23c8:: with SMTP id j191mr1406430wmj.64.1598618832236;
        Fri, 28 Aug 2020 05:47:12 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id o66sm2176878wmb.27.2020.08.28.05.47.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 05:47:11 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 02/13] bisect--helper: use '-res' in 'cmd_bisect__helper' return
Date:   Fri, 28 Aug 2020 14:46:06 +0200
Message-Id: <20200828124617.60618-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200828124617.60618-1-mirucam@gmail.com>
References: <20200828124617.60618-1-mirucam@gmail.com>
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

