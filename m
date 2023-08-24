Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD069C6FA8F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 18:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbjHXSlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 14:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbjHXSks (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 14:40:48 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8719E50
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 11:40:46 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5922380064bso2206107b3.2
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692902446; x=1693507246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R2p5Y/cIFlD0Tldx/3Oip4ox3pGZjn1CX7hE8uJvI00=;
        b=2sdIX83CMhNB1vW965TAJNGPICHuZp4Mu/QFZ7UxsG2EP1hzNUJ2EbKn52BtmBsrNL
         4rsbGTKIsQjGfgz7EPGYrre1TCFLv+MxvVRHaMemJ6fNOnq0MwsT/29bpsEOiE/KwQnT
         hFYWtsNNr7fc4V2AxFQrKwoDghCic8/WDzesKNb9k7n1jQr4iXn/Z8KRa8X/Gs4/qwze
         nJVDZgThFp+CHE3uX+vnXjNSoDVMql6N3L9VdnbKZSMxOef/BBAz+/i4jNyrVmJk0+0+
         etuFD253iVuUQrghJB1b4FRQ4fsRODbHnDkdytdJHAMQDRhzMkutCTUVtyNsnUhzq0QP
         GXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692902446; x=1693507246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2p5Y/cIFlD0Tldx/3Oip4ox3pGZjn1CX7hE8uJvI00=;
        b=NzO2Dx9tQDiJR8ntHRa+dvy8gNik7D8S76RaKW2GU9GHKMBVns4wuIqrBBaOMnqn1l
         OE74PFrU0bYgG/iXy3uFSxJyvWqkaAo4hUCs+q7LK7OLYzXcxhZwfYlxUpbPHNgyxCyX
         Fhn8KNImmg2kyL38Tf1sDR7tA940zTrDUsi4FQg11jnAbWv7xIpLn+5q7luUkOjrrOty
         aWkKfFS+RlQw8JwaOs4V0EJX9cbUyNQPljv38P4bhx8DpnYGtgFGMPS1dneeTDD6Vw3o
         HLFRwR3Y0XJGCfL42eaw60WFsW8zZnEb9FhaksmryLFcaNrXhcEjKbR7Iqvix9LpWOFT
         lLpw==
X-Gm-Message-State: AOJu0YysAjXOkluol6roARJzabWdVZhCauR4DfM/V/M8BTgHQr+SxUdH
        Ecvfk5sBI/Eh3oVdvoMatEdAvEM/jgrPNgCb5ZnPuA==
X-Google-Smtp-Source: AGHT+IEbJlrCbCj4B9O/dDVCMXx9mhaJHLfSfBOaw9zpXoJ9gBfKlKhlLP/9IqQxUBMFzO6y0EXiLQ==
X-Received: by 2002:a81:ab4d:0:b0:592:b38:9662 with SMTP id d13-20020a81ab4d000000b005920b389662mr12938377ywk.22.1692902445904;
        Thu, 24 Aug 2023 11:40:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z132-20020a0dd78a000000b0058419c57c66sm42777ywd.4.2023.08.24.11.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:40:45 -0700 (PDT)
Date:   Thu, 24 Aug 2023 14:40:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 3/3] leak tests: mark t5583-push-branches.sh as leak-free
Message-ID: <4011eb6a8b6200da88082a313f67bfeeca536d6a.1692902414.git.me@ttaylorr.com>
References: <cover.1692902414.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692902414.git.me@ttaylorr.com>
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
2.42.0.3.g4011eb6a8b
