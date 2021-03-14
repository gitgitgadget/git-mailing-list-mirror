Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5A4C433E9
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8096964EB3
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhCNSsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 14:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhCNSrp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 14:47:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4221FC061762
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:47:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c76-20020a1c9a4f0000b029010c94499aedso18951960wme.0
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VRVig6r2OQ7VUMmLKHIM+DZFPJ7DwZl4ljHRZhrvI1M=;
        b=hffnrqEZMWdIqwn+b0gEGp7tmaWoXp/UvBqYJXN/Vsj8a21GQ4nWoXEn+LTU/3rEaV
         ChfCmpwUYwJkwfM2G/XMJkIRHzt0FJz3kT5pJ+mio4LcB8nNoukxUle+9LPQspFCtm03
         ppvNTxYLekcLew97gVd6U9O3azeRWJQutcVw8rY1aJmTibCfLnEYcJyTl5UnTTDyySZb
         zxwh5OUeWdiyYrBk8rsLkdlzsvnk8Euu4e7MLrP5JpI2qXSpxz+RaunLceFrJ1nMq+15
         pClhOyV1kw/wxPAPC27NTcgrpvzP2eNF08sb8Yn4Gfbd3L25qDdwBTkbXTdG+ctL1TLU
         s/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VRVig6r2OQ7VUMmLKHIM+DZFPJ7DwZl4ljHRZhrvI1M=;
        b=J5Vo2zkAdTZGnSIEDI1egRhTvxgiWxaYx3IHVEb8Urbp6ec33doUF9SopQHVCWvYOF
         2q137W8yfAPUNyO9nUR1DNQqpxNAJZnM4QD4ZgKSpK9Ec6SQq7UhEbgCzniSHQ06SQLC
         SImt+ftADxzewBe3BV4G56KpEw5cCs5uoJZYAQV/r2HISNDSrafqgkVY7OyQWVavatez
         EMykn9WKykdeF0SbX21sTjG0OYHgdIwSPEdADt3mer37o09jkP7V62FuuOn6jpTQMtb1
         lNcy5+t2Gl5YGifwF0jUmAfVRWeSLlf2dd4MmdvVtEJPIL1Q22Yj2uwc1Jf6e21+pMnV
         TT4g==
X-Gm-Message-State: AOAM530c+dOB8L+2wBjds7GHIlONU6D92KMcmZSDpnt8vpH4kaWoFncc
        KtY93D2b7Fsz951fZSm/+Os0TH4F0p4=
X-Google-Smtp-Source: ABdhPJyyTA4vwhk1wpQB1za2L3Q0qpmiqJqfItufH7Qqds0s3s1z9rgNjqWwQp84El6ZFyYqKWxf6Q==
X-Received: by 2002:a1c:bac2:: with SMTP id k185mr23135796wmf.148.1615747664065;
        Sun, 14 Mar 2021 11:47:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13sm16811042wro.23.2021.03.14.11.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 11:47:43 -0700 (PDT)
Message-Id: <c7bb403ae381b0518b53b93964aad15ba67404d4.1615747662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
        <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 18:47:34 +0000
Subject: [PATCH v2 1/9] symbolic-ref: don't leak shortened refname in
 check_symref()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

shorten_unambiguous_ref() returns an allocated string. We have to
track it separately from the const refname.

This leak has existed since:
9ab55daa55 (git symbolic-ref --delete $symref, 2012-10-21)

This leak was found when running t0001 with LSAN, see also LSAN output
below:

Direct leak of 19 byte(s) in 1 object(s) allocated from:
    #0 0x486514 in strdup /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
    #1 0x9ab048 in xstrdup /home/ahunt/oss-fuzz/git/wrapper.c:29:14
    #2 0x8b452f in refs_shorten_unambiguous_ref /home/ahunt/oss-fuzz/git/refs.c
    #3 0x8b47e8 in shorten_unambiguous_ref /home/ahunt/oss-fuzz/git/refs.c:1287:9
    #4 0x679fce in check_symref /home/ahunt/oss-fuzz/git/builtin/symbolic-ref.c:28:14
    #5 0x679ad8 in cmd_symbolic_ref /home/ahunt/oss-fuzz/git/builtin/symbolic-ref.c:70:9
    #6 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
    #7 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
    #8 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
    #9 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
    #10 0x69cc6e in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
    #11 0x7f98388a4349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/symbolic-ref.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 80237f0df10f..e547a08d6c7c 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -24,9 +24,11 @@ static int check_symref(const char *HEAD, int quiet, int shorten, int print)
 			return 1;
 	}
 	if (print) {
+		char *to_free = NULL;
 		if (shorten)
-			refname = shorten_unambiguous_ref(refname, 0);
+			refname = to_free = shorten_unambiguous_ref(refname, 0);
 		puts(refname);
+		free(to_free);
 	}
 	return 0;
 }
-- 
gitgitgadget

