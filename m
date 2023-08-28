Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD35CC83F18
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 22:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjH1WxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 18:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbjH1WxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 18:53:09 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C71E99
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:53:06 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58d41109351so64933467b3.1
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693263185; x=1693867985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WLV4ZWApsmO0kuPIdYj0hxnbYvgZRufZuj3K65KOvuo=;
        b=RXcN+IFQEtkLB7LsUpwbWJk60c0XsCP0hTWhJKSVzPr8CzV7P1LML4qf1cjnxlBl5N
         60Es61S9qkVFftE9YTjYBE5UwQwVef1fd3JI697bPRSfhYwqB/UC+/aZppD2aziHX9At
         rX6krGzkqloHUoq/aXtc8B5tUEJ2sM14vnRUXtH1J8KQg0cMye2oUzyw5OMINAQkREvz
         E/n2lI5QvuPdEy0ayOxJbX4VocIJ9X6pAzZ67Vxrz59mNbmP6n9UxFMeHDPtQI+kwGNR
         YpGt2lnbxfn5uBL7k+f8sn7Ssch//0aN7aSYC/VAeEBhzVvPx10l95vEtmEvP7ILUrvk
         uMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693263185; x=1693867985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLV4ZWApsmO0kuPIdYj0hxnbYvgZRufZuj3K65KOvuo=;
        b=VylyCokUXFomQK0NX/OuUhsMIhkAqr1RC1j+GQuj2IsAC04xHagCTOjvAshEWMf43Q
         I72u+Vhc8loBUtKe2S8hN+tQXala8nTXDR0C06qaWH4/VPbQxxA4TE1GGqifFOk/SlHM
         zNhxhM1rIdkSsW3DBHp09CJecKd4KrG0lL+PqA3Rrzu11BAzc48CNq3dlpbK+3l85aNO
         TsgIdTzZHCFsGWTcsGlZyphrgQM1YS9ZgnMzL/qWs0QnQfljlPWrMCb45QYVYEKy1kJj
         bu5T0ks/78NxYfAIBRt6HE8pwlaT63X0aUYV8P1gRy6TAOUGFs+/rXkUX6IZfsEpJJHD
         q9fA==
X-Gm-Message-State: AOJu0YxJ3LdIWOJN94FK91p5p6FbkHlXsXEbc9TK5HzyxCiGG20LRH4/
        s9WWgDdoksRYssoGJTVBGqRBI94XrJI0lOvi8t1Yjw==
X-Google-Smtp-Source: AGHT+IEZJnNNXWIIp713bJ2rRAAX3h6V1Pk9EE1fcTNa+UxoLfdorOIbr9m8DGUzV6X7jHG6xF6o5g==
X-Received: by 2002:a0d:dd0f:0:b0:586:b0ad:18fa with SMTP id g15-20020a0ddd0f000000b00586b0ad18famr1059807ywe.25.1693263185454;
        Mon, 28 Aug 2023 15:53:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id eb6-20020a05690c26c600b00594fb0e2db3sm1516842ywb.138.2023.08.28.15.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 15:53:05 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:53:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2 4/4] leak tests: mark t5583-push-branches.sh as leak-free
Message-ID: <a16a0b2cac0923febf8738b59299608f1d813f7a.1693263171.git.me@ttaylorr.com>
References: <cover.1692902414.git.me@ttaylorr.com>
 <cover.1693263171.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693263171.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When t5583-push-branches.sh was originally introduced via 425b4d7f47
(push: introduce '--branches' option, 2023-05-06), it was not leak-free.
In fact, the test did not even run correctly until 022fbb655d (t5583:
fix shebang line, 2023-05-12), but after applying that patch, we see a
failure at t5583.8:

    ==2529087==ERROR: LeakSanitizer: detected memory leaks

    Direct leak of 384 byte(s) in 1 object(s) allocated from:
        #0 0x7fb536330986 in __interceptor_realloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:98
        #1 0x55e07606cbf9 in xrealloc wrapper.c:140
        #2 0x55e075fb6cb3 in prio_queue_put prio-queue.c:42
        #3 0x55e075ec81cb in get_reachable_subset commit-reach.c:917
        #4 0x55e075fe9cce in add_missing_tags remote.c:1518
        #5 0x55e075fea1e4 in match_push_refs remote.c:1665
        #6 0x55e076050a8e in transport_push transport.c:1378
        #7 0x55e075e2eb74 in push_with_options builtin/push.c:401
        #8 0x55e075e2edb0 in do_push builtin/push.c:458
        #9 0x55e075e2ff7a in cmd_push builtin/push.c:702
        #10 0x55e075d8aaf0 in run_builtin git.c:452
        #11 0x55e075d8af08 in handle_builtin git.c:706
        #12 0x55e075d8b12c in run_argv git.c:770
        #13 0x55e075d8b6a0 in cmd_main git.c:905
        #14 0x55e075e81f07 in main common-main.c:60
        #15 0x7fb5360ab6c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
        #16 0x7fb5360ab784 in __libc_start_main_impl ../csu/libc-start.c:360
        #17 0x55e075d88f40 in _start (git+0x1ff40) (BuildId: 38ad998b85a535e786129979443630d025ec2453)

    SUMMARY: LeakSanitizer: 384 byte(s) leaked in 1 allocation(s).

This leak was addressed independently via 68b51172e3 (commit-reach: fix
memory leak in get_reachable_subset(), 2023-06-03), which makes t5583
leak-free.

But t5583 was not in the tree when 68b51172e3 was written, and the two
only met after the latter was merged back in via 693bde461c (Merge
branch 'mh/commit-reach-get-reachable-plug-leak', 2023-06-20).

At that point, t5583 was leak-free. Let's mark it as such accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5583-push-branches.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5583-push-branches.sh b/t/t5583-push-branches.sh
index e7e1b6dab6..320f49c753 100755
--- a/t/t5583-push-branches.sh
+++ b/t/t5583-push-branches.sh
@@ -5,6 +5,7 @@ test_description='check the consisitency of behavior of --all and --branches'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 delete_refs() {
-- 
2.42.0.49.g03c54e21ee
