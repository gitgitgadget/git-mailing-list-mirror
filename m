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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6222C433E9
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C3D6516B
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCHSg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhCHSgX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:36:23 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB478C06175F
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 10:36:22 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so4424647wml.2
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 10:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WLt+Mw3aUHd8kwTus48dz1NRvLaZykpZPphmoIPyrT4=;
        b=QuiUhoJLtOhRDcBbkDfgd0H0u+XFypqSHLJG32xnKk8VDIpwhoBLnsuxOSQbKzP0JG
         MNtmqXs2ilw+K/tjN8g58/SZAaN8USTcQelHrixDcYETLlM38aHRNHqNJkWD+RMbxLGc
         DeocYnFAKf7QfU2pA8V7zbDWw3bCZZehh8abd16D0isUXE5iVyyfX4tff0Ik2Yyv+oD0
         al/hMXRWMAxqH9w34OWTuCWRQPAjnxi2WPVJ4FRGEhABps4gNm+KKlQHCqsXJAK3d1tW
         OLYFSxffLBa5Q7Hq9c2BCAnU5ROc+1XgT6toKAGZCfmH9PTW/FQnj/fEVP3bHTg9wGYt
         0w/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WLt+Mw3aUHd8kwTus48dz1NRvLaZykpZPphmoIPyrT4=;
        b=pQzQFsgcjaJG9f21jv5A0lXzqb5p4D9fwZezQl/h3gFoUedjjT6h77nDwcEA5T4bBr
         hBuk1oSEcyY5CeZiMdWE/h0Q+zPVvPXxYcd+yeMvKfBi+2BDVZbpqeupqKBzx7fydek9
         uR9ZNuJtyAWQKhixowmillKOSYVE+z7mBWrGt1sQpxdyqGy9U4tVPs8zSeGWbJinpA5F
         dLLKzOigYjkEe3KBujMf6B6jDZ9+qqlHzTjfHmMInAWZIuECuYtEUvag/bZamOUmz5jH
         5ITdPS1Qzbef1lNDhLEe1P4PEp2hhZDXUf/A+soOLij2sMiK4lvoATsJTlf6aMn3pv+Q
         uM/Q==
X-Gm-Message-State: AOAM530C6AjIH5kSwd+1BL4edGQkC2rLdlWlJY2VVcEe+lyPiiT3M8qf
        Zn8siGNRwV0KNBBpKswfHi0I7jPhur8=
X-Google-Smtp-Source: ABdhPJxDOrg51Sltbp1tyu/rAt3pPD6j5Cxx+MsZYRcY7so0fEzs31anrz1uCx1gNCm0CJT55W1sRw==
X-Received: by 2002:a05:600c:289:: with SMTP id 9mr114223wmk.135.1615228581775;
        Mon, 08 Mar 2021 10:36:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h62sm229087wmf.37.2021.03.08.10.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:36:21 -0800 (PST)
Message-Id: <ff0f7c167fa5b5da2d843fa03edb70907e6af763.1615228580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.git.1615228580.gitgitgadget@gmail.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 18:36:14 +0000
Subject: [PATCH 1/7] symbolic-ref: don't leak shortened refname in
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
 builtin/symbolic-ref.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 80237f0df10f..8cf52599693a 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -24,9 +24,15 @@ static int check_symref(const char *HEAD, int quiet, int shorten, int print)
 			return 1;
 	}
 	if (print) {
-		if (shorten)
-			refname = shorten_unambiguous_ref(refname, 0);
-		puts(refname);
+		if (shorten) {
+			const char *shortened_refname;
+
+			shortened_refname = shorten_unambiguous_ref(refname, 0);
+			puts(shortened_refname);
+			free((void *)shortened_refname);
+		} else {
+			puts(refname);
+		}
 	}
 	return 0;
 }
-- 
gitgitgadget

