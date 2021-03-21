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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6433AC433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2884761946
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCUQ7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhCUQ6l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 12:58:41 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A57C061762
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:40 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso7960183wmi.0
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VRVig6r2OQ7VUMmLKHIM+DZFPJ7DwZl4ljHRZhrvI1M=;
        b=KLcVGJFIhop4Tjs1KPrwc91AgN3gmcGixTw9Jj6ABtw2ua1vhr1DGQ8J48eH+yvgBY
         Fi1GpCtC6bs+9HJ6nnSG0S9SYOG4AoOGbur2bR3B1DJlbxGilSs6cadWzjNasmRBpL63
         MSzg5TaHTXsVamjH+8tx5/Qvz/vU9yy5MWNjvYBZ7kSE0YnpXrninm45hH7yzzL0ObKs
         kpClLNisjnUfAwiHkjFAD0uct3MHkbg3hALZVBKRENG91EewY31AYX8ujBYxfZCcGi+s
         YRdabhbd+0nOMIEAQsvTGXf0kYm6lxkT882BccK0+pSBaqlh7EyIarnIq+/CxI4ZS2Gp
         9p5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VRVig6r2OQ7VUMmLKHIM+DZFPJ7DwZl4ljHRZhrvI1M=;
        b=EKCqk9JshWH8oUfdjJI+KV8o5G3M++EQqKfcE8N0n9wwlYBpNddg0ExmpNqZAWG0tu
         Lii1A+zrh5IBb8dsUN9+NltBOI+5xI/gJhiX7Y7UJu1+7aApQPSXgM9NDJzBJSmpgiKb
         KSK0scQ0CbOl8YCfnkn8n4rM25wETajnRjYQNIGg/6h2QzlgExDeCH7oXGLaG2vfQ4St
         DC2ksDG6R8EdsAKVF0DfBJL/NFti1jF1MhRB8sL2sPk139COyxiDdCbHFird/pbSvLfx
         +8bksAvj/4v9RmbQ5en/DkRAUMbuPcW4jAKEsI0pKcFDzGshVAisTC7jXR8v8/lHevmR
         qYnA==
X-Gm-Message-State: AOAM532iYQ7vhaD+D8afs/cm0/06hyA7bDXYoOujIolF831R3ds3iKui
        s6oW0OFUzqP8T24bytV2vKWUWVagUXU=
X-Google-Smtp-Source: ABdhPJyP1YJxSwGlVzdUpg7YeS8RX4B79jjABS+UfC3a0b8IuNrrASTW3vyfHPz1jAxPzdlquxg70Q==
X-Received: by 2002:a1c:600a:: with SMTP id u10mr12575028wmb.139.1616345919658;
        Sun, 21 Mar 2021 09:58:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm15138932wme.40.2021.03.21.09.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 09:58:39 -0700 (PDT)
Message-Id: <6af157dfed796508933793f6c4e7453764643fd4.1616345918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
References: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
        <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 16:58:29 +0000
Subject: [PATCH v3 1/9] symbolic-ref: don't leak shortened refname in
 check_symref()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
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

