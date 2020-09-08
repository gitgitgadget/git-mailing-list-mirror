Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6ABC43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE5120768
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="foBvGfLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbgIHTuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730916AbgIHTsq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 15:48:46 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FD6C061756
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 12:48:46 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d184so31721qkf.15
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 12:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=XcY6xyVhSYie1UA3uifnaQdJNJ91XES1Mf59m7OFhQU=;
        b=foBvGfLRrilPpyq0fMUXIIhYjRuOWcerRm7eTtds2dvAtWs0Ckb2Y5BzPo6x5pH/n5
         Quz7oP3SZAKrq4ca6ZskUoTXXTCNXPTxNLWzilITn4a5Ct7o4c2tiBrGzYt/v39VyF7p
         NI6Mp9wEPU5Njh19T1OyhumbdkSLEKiG3gOkIVAKjyoyqZxgw/EC5BCdF5OHsSH13m1r
         lq143CjyFp6JvgjxK+4tkxtd8dyA+54kYDWFSt7Hdb2VZLSwb3yvmZmB7NvoxSoApMdI
         Wngy/LJq4rSumYF2FqI4eR1E5QQBTelgdDJTBreIhKKGvy6mDNAvRO2/F3OY500A0eYJ
         GFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XcY6xyVhSYie1UA3uifnaQdJNJ91XES1Mf59m7OFhQU=;
        b=hI8+JbTIKS6IYsQkKDqubu2InwRjLT2B3++swE83Nu3OeolodxxIJydWMPCeClmc7Y
         UXxzi/hVEtT9iejoKdBTso+R1olyBAAd1QfpKALnhBy9/JGydE+y3FiO1GwbKfaH9eQi
         DdaDm3FCcRM4pre9Ja4iDfKMGNbwuCxWdi4vHFapfmcBPHsvxubd3Mr3E2fFwNfKNH2e
         aVWRAm/rP3nEFFPzpQbKEzXhOR4u51RSbBOFq3Qydr2zMtuPdgIIsjtk5HZRzgXlJBt+
         7kdFcU/6wEkcSJZrgCjNoPc49u0Mrhdv2xISL25bQ7mjM7ipyei377pZRFmvqrsAfvzG
         92LA==
X-Gm-Message-State: AOAM533SkM5xY4GJl0y+RZjgb3/VVksAsJmTvu8VKY1guadQmAcEnEV4
        YYqb069oqbUJMIVaC74aoBO200VN8y+x1Gn6stzcAN03Avyl60oh+l2VHsZCFm3T50w5jxaQ/zP
        5B2x57O/jFIRk2n0MBO2aYYt8YuHUF7BuQSRL1ef4avnaSjZPv9X8a8dCy2QBKcRjeY5BYnb6hz
        NL
X-Google-Smtp-Source: ABdhPJyRnc8HmLMKDtcmVINI7vu9723rrCBZQPakBEAhKqEFsvR3eFsVo6fNqYf//U9IAG1V/b266BSuNpTrGKRSPhNx
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:c709:: with SMTP id
 w9mr735452qvi.26.1599594523749; Tue, 08 Sep 2020 12:48:43 -0700 (PDT)
Date:   Tue,  8 Sep 2020 12:48:29 -0700
In-Reply-To: <cover.1599594441.git.jonathantanmy@google.com>
Message-Id: <fe79905660bb11a88f605713cd132cbde46ec8a5.1599594441.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1598296530.git.jonathantanmy@google.com> <cover.1599594441.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 1/7] Documentation: deltaBaseCacheLimit is per-thread
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clarify that core.deltaBaseCacheLimit is per-thread, as can be seen from
the fact that cache usage (base_cache_used in struct thread_local in
builtin/index-pack.c) is tracked individually for each thread and
compared against delta_base_cache_limit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/core.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 74619a9c03..02002cf109 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -399,7 +399,7 @@ the largest projects.  You probably do not need to adjust this value.
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
 core.deltaBaseCacheLimit::
-	Maximum number of bytes to reserve for caching base objects
+	Maximum number of bytes per thread to reserve for caching base objects
 	that may be referenced by multiple deltified objects.  By storing the
 	entire decompressed base objects in a cache Git is able
 	to avoid unpacking and decompressing frequently used base
-- 
2.28.0.526.ge36021eeef-goog

