Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACF8C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D614361159
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhDZQQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbhDZQQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:16:27 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2150C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:45 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id e89-20020a9d01e20000b0290294134181aeso26800766ote.5
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TN5fyIbQXpcWr6TA0JuNUKoUtDPdeg1HgvROSqtCZbk=;
        b=Y5hg19Y2y4MgC+HNeoprWjGz96y3PDSpBoED0frEZxML5pBojJPI+5BiLVbTqTyXJ7
         1mo+wqUOYY4t4p36TIhjjkoXZxnN0TNxukyEIRfZWwt8wOyc1N3kWnh5lteq8B56PasI
         kexGmkNUAuUTwJe7xm7xzrjWfpABS+Fu3j9O3bBQTv/cZMZdR9VA+l/6OP5rKshnw0re
         7fkj3Zw2EtmmDjjZwlLumZfIOcb/8TpXyeUAYowz6rzo1l2susRgXRgyZFFbR8mCqSFE
         LpF3bZuttN58IoiNvFyn2gILkiGV+VH2XM85cH9zBv/j6d4gknFJnAyT1n5AkrbDAH+m
         NenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TN5fyIbQXpcWr6TA0JuNUKoUtDPdeg1HgvROSqtCZbk=;
        b=Bnv9kxCjv4eouiS4vjlg2mSvGO6z/SDoNtU10sg6x8UyRnu5fKMsdSZ9W+lWJXBA/p
         yi/DwX+whoNOa6sCCeLWcGH1+9bOe7LnW+9VQfEOPAOykrhfeostWfCptk0BJOXH70j5
         VALXuYILlQ+i7FQovxCfEwLZrM8pBzPEQG5zU/VOpsf58mK7nTWMfCivi39jEQBi/32u
         0jqmReyB9InsOrZQxeC76Kkwtp+CoQ2IG/wuKvwbqjgTp93fqFpiFVZlF4+J2dAz7IAL
         yz8YleDCGti4jpFV0JK0G5saM3ZbP06aQmKds+Tf2YrgEssYk/HEZ08fkwsEGVQyObUv
         juZQ==
X-Gm-Message-State: AOAM533cghCehnxiZAAoflCI4X3I1ZeVxTcPci+4SmS/fUtUoVFvUMrn
        v3YZ+heR9kp2oSVFgREcOlGd3U/gTqjt4Q==
X-Google-Smtp-Source: ABdhPJxlObGINHE/f+qiyH1IvJ8kYrj91rXIjuLjbKnthRjv6gca+QsTcINbxrvpq2A+Cy4cah8lyQ==
X-Received: by 2002:a05:6830:1386:: with SMTP id d6mr15445729otq.150.1619453744945;
        Mon, 26 Apr 2021 09:15:44 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f20sm73019oov.21.2021.04.26.09.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:15:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 09/43] completion: bash: remove non-append functionality
Date:   Mon, 26 Apr 2021 11:14:24 -0500
Message-Id: <20210426161458.49860-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
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
index cbb2730bf9..162c8a89a2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -307,7 +307,7 @@ __gitcomp_direct ()
 {
 	local IFS=$'\n'
 
-	COMPREPLY=($1)
+	COMPREPLY+=($1)
 }
 
 # Similar to __gitcomp_direct, but appends to COMPREPLY instead.
@@ -459,7 +459,6 @@ __gitcomp_nl_append ()
 #    appended.
 __gitcomp_nl ()
 {
-	COMPREPLY=()
 	__gitcomp_nl_append "$@"
 }
 
-- 
2.31.0

