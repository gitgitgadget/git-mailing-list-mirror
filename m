Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23172C43460
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B2361166
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbhDZQQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbhDZQQq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:16:46 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6B7C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:16:03 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso38529862otm.4
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+o9SlKPJQYIkGFHCKhrfKvRoe4G7Vu37d1Y9ElXihzs=;
        b=ZuqV1gKmYvYf6tS7+oJdsh1kWGVf8oMveRy1L2pr/cuA01h2ozLpm2r1QqAPl058ng
         KBHinNk38eEoO+hib8+96UKAUAYZFXQFBzl2Tv45N3jgZyS7yunvZxU27p77Zh03z4Dp
         2xYF3XN451WWs+NCIODbrVMVmR4b7VALpWlIlChnHnekaRAYBAVBEvur8lG1d/rBH+oH
         cPEWRIcAF5KrR526Vo02dcvtnT6jSb14xCg5a0KMqG8CD/A97LHnJbjp9v4A6EgazGAk
         ZqXtFvax3XcWN1OPl0p6zUG3D1TDUjVruoaaPAYsMdvLLLy4MCdfGC0QaQI8Oga/eyHj
         e4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+o9SlKPJQYIkGFHCKhrfKvRoe4G7Vu37d1Y9ElXihzs=;
        b=SQhWHxB8wXZ7FPK3noN0mb784W+y6syO98eeaDA2Vwg7CaaOQ6FpMUWwujNVSY9e4w
         eiND2C+29QtYvJQEpl7/x/ztQUAfnwO1wUC+VB5OMNMjSTE3HWCCrQ2splzVPta6fEyx
         7r0jb3xaagxzlxnHXkr7eS6AilmQkOtPhRKB0hgucCgf/VSozDsn/6rWO8g8YikAIqla
         ZvalHb698vnPj48UE/1D4Koe73s8YMCGsGmzvqj0Rf5CBGuxfTM/lxK3SuxDfAsewWEh
         S01E2ZWFZeSOv5trVnN2ncFCTMLb96eOMiDlvc5Sis/XbCDEhXwdzgLFPf1f1p3Z9jnl
         z39Q==
X-Gm-Message-State: AOAM530GeTwr6OfJXjk2myUgfKDN3fl6fBdn1HwblXM2cz8dM371mRgZ
        5QrBoF47WaTpfQEmMy0L9hIV7w5QFQqfaQ==
X-Google-Smtp-Source: ABdhPJwzHfB49WnwIjNlQV6SJA3V69OC5VtyJS9UQ7sN1uOzbgeFzOTY0+Dg4byu1XCG7LqnyelmRA==
X-Received: by 2002:a9d:628f:: with SMTP id x15mr15634523otk.186.1619453763215;
        Mon, 26 Apr 2021 09:16:03 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id l8sm1673455otk.36.2021.04.26.09.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:16:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 13/43] completion: zsh: expand --git-dir file argument
Date:   Mon, 26 Apr 2021 11:14:28 -0500
Message-Id: <20210426161458.49860-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 966b2d9277..755135a2a5 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -247,7 +247,7 @@ __git_zsh_main ()
 		if (( $+opt_args[--bare] )); then
 			__git_dir='.'
 		else
-			__git_dir=${opt_args[--git-dir]}
+			__git_dir=${~opt_args[--git-dir]}
 		fi
 
 		(( $+opt_args[--help] )) && command='help'
-- 
2.31.0

