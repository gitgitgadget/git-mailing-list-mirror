Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA11C4742C
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E6C206B7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/5YWRhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbgKDRrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgKDRrX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:47:23 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B7EC0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 09:47:23 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id u127so23009370oib.6
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 09:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gICJVCMqfDrg885NseUjxrp8f2rqBBXCJDy5po/R+oA=;
        b=i/5YWRhxRYqWKuYYQ6lTaSFdBVw+0xnJ2Y2I+GYCKmXGLcb/ekMqJLA37A4v+MS92k
         za3ff5y1JbASmGZxFj/JG+NKGB37v5THg2t10Tutk71oe4NoQz2RI0vuLCo/8d/+7f4A
         XBF+Wmd1Rge8BW8KXTj2Jnz5eRCwGU6WHxgfrTW8QtPBP2sRyckyjEiXnt/ATkr7sY9h
         UL+FaBRy5b9eSA48TNIM5Ei/A0jZRvKSqeabF/9IVZfE2TR05f7MUxs6UmtQJp/9aikS
         bIXEk2mdFEhZ7oacuHaxZWa5cxE2B/zXYyI2u6DUPXMprmVtiMpesYA8jaIwtfJAW37r
         UGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gICJVCMqfDrg885NseUjxrp8f2rqBBXCJDy5po/R+oA=;
        b=q8xK72vsScOirhaUd+X1TEnTKcKjp9gPAO9N8DdE6h+oUlxeFi8MBBimBA5yxw+XMZ
         MI72HRY7Elp24O6IoNUZ+311Wlqp1TPkaPdsQs/k9d/8X5Y1bnYjkDkDlJqEfpS8OzE6
         r6ztjrr4kK/UGkKlWeBHIL9p2cs2XHFrYqV7iI/ckZQJ5JayrIcrxW6A9OkbehvVQLFO
         6EXvxU98JR47EWfL1wgsjeLhuCiZfZ9VoJCTvEFynmuGe4yGyhO4Ob4nzPMcqDz2fOt7
         JDWL86z2k2Mx7DvCaTbk01feOy7EVGeCtuLwhDyCUK0ZLa8PBnKWOnIvAG4H4r8P+q2d
         Sncg==
X-Gm-Message-State: AOAM530U5BfMHmXYjphRZvGVKlIpKQRFGmSUJnP0nZwbL6f6YGj1u7BS
        y/Ak52HSxxnrqoGMTvHnP/PZ2h5kkZneew==
X-Google-Smtp-Source: ABdhPJwW3VjsPc52/A9lKocN5f0zfew9xoUC4DhNslNO75JR6YRl5P19oLTsGKBDvXbuf30XY8wIDw==
X-Received: by 2002:aca:1e09:: with SMTP id m9mr3376876oic.60.1604512042302;
        Wed, 04 Nov 2020 09:47:22 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 76sm628962oty.15.2020.11.04.09.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 09:47:21 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/10] completion: bash: remove non-append functionality
Date:   Wed,  4 Nov 2020 11:47:08 -0600
Message-Id: <20201104174716.783348-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201104174716.783348-1-felipe.contreras@gmail.com>
References: <20201104174716.783348-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no point in setting COMPREPLY only to override it later, and in
fact; we don't do that.

Therefore there's no functional difference between __gitcomp_direct()
and __gitcomp_direct_append(), since __gitcomp_direct() *always*
operates on empty COMPREPLY.

The same goes for __gitcomp_nl().

This patch makes the functionality of append and non-append functions
the same.

There should be no functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0a96ad87e7..87762dc33e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -303,7 +303,7 @@ __gitcomp_direct ()
 {
 	local IFS=$'\n'
 
-	COMPREPLY=($1)
+	COMPREPLY+=($1)
 }
 
 # Similar to __gitcomp_direct, but appends to COMPREPLY instead.
@@ -456,7 +456,6 @@ __gitcomp_nl_append ()
 #    appended.
 __gitcomp_nl ()
 {
-	COMPREPLY=()
 	__gitcomp_nl_append "$@"
 }
 
-- 
2.29.2

