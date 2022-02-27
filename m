Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95154C433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 10:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiB0K0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 05:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiB0K0b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 05:26:31 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C4A1E3CA
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 02:25:52 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id s13so11046881wrb.6
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 02:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W4KXFaoxdKUAniduc3K9Rp+wa3QD6GQKU0apKf4hzfc=;
        b=gRvT9mimOXBIqBWuSMk4Y/RTpAX50pm9kMyv+zJJ584FYMO1+F8PoOTLDWHCRc/5Q9
         yKaFjHhZWSjnnohvuaVxho3Bj6hd1dgOt1huI6B/FqJ3l0R+LQLfXGnvSVspGmaaWf86
         ay9Sp17iL4KSaBnQZczR0mEjj4xhYUf9buDtGSp3zUMfzk7G86ZOMumo4FOeZHxwKGuN
         pLjjf7v9L+pGHwPuu1264EHlvMT6YtZW1dqLCC1ZGJCoTJZbN7lx7siw/nd1MVb7HPnX
         39bm/IZC/epSPN6x5iNqxpPuW06lHsnXXiX4qjdSo+ypKQ9qFhKhgEvigYI9Ycgbhxdi
         iOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W4KXFaoxdKUAniduc3K9Rp+wa3QD6GQKU0apKf4hzfc=;
        b=akqQ4a2gTG49dSy4KeYDphb4FvyjSgObTom4vkQozzBdpVVFkNUrUILpMpd0dYhEhG
         cXSeLkk/GoyrmnYWHeGuGPEa/VKid3gKCbPZARg11X5ONuRFb4GIFkk2OQBDYmrI8TKe
         czySHN2NmLMbtLW3D49Xl4mxbE8D7tUwjprqNZV4SCma3zWjugD5ZlAIb2rZGTEyMicf
         R9AMqGq1SuAgoOJ1DQyMPFIysF2ANM8Q99fc9hXoG51Va0NVrJqCdpisJyOItnXSi+xr
         fe6KBzFdNuxf23DfQqVVJ7R9CYwA+Oxo0/ABKhagCiMQwmAAK7EDx2l6rOsdOkS4uaWf
         DLlw==
X-Gm-Message-State: AOAM532veDg1iZu6Vmp3IoVeTTWJ7+AsH2jvByaDwnUnP8ehFXvM7/6y
        buDHRjnCnkvOvcVj+ToaDLrzMTLHTd2g4w==
X-Google-Smtp-Source: ABdhPJz+rXjehiy7ww8RlH7I7T3jpl3y0g+wqdfqw2Hg4S/ZOvZNk0EQseYPdS0ARHtMgwBNedAz/Q==
X-Received: by 2002:a5d:514b:0:b0:1ee:aed1:d48f with SMTP id u11-20020a5d514b000000b001eeaed1d48fmr11050253wrt.662.1645957551202;
        Sun, 27 Feb 2022 02:25:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a3-20020a7bc1c3000000b00380e493660esm11031685wmj.42.2022.02.27.02.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 02:25:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/4] test-lib: add "fast_unwind_on_malloc=0" to LSAN_OPTIONS
Date:   Sun, 27 Feb 2022 11:25:13 +0100
Message-Id: <patch-v4-4.4-fa4946ce7ef-20220227T102256Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1188.g137d9ee5e75
In-Reply-To: <cover-v4-0.4-00000000000-20220227T102256Z-avarab@gmail.com>
References: <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com> <cover-v4-0.4-00000000000-20220227T102256Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add "fast_unwind_on_malloc=0" to LSAN_OPTIONS to get more meaningful
stack traces from LSAN. This isn't required under ASAN which will emit
traces such as this one for a leak in "t/t0006-date.sh":

    $ ASAN_OPTIONS=detect_leaks=1 ./t0006-date.sh -vixd
    [...]
    Direct leak of 3 byte(s) in 1 object(s) allocated from:
        #0 0x488b94 in strdup (t/helper/test-tool+0x488b94)
        #1 0x9444a4 in xstrdup wrapper.c:29:14
        #2 0x5995fa in parse_date_format date.c:991:24
        #3 0x4d2056 in show_dates t/helper/test-date.c:39:2
        #4 0x4d174a in cmd__date t/helper/test-date.c:116:3
        #5 0x4cce89 in cmd_main t/helper/test-tool.c:127:11
        #6 0x4cd1e3 in main common-main.c:52:11
        #7 0x7fef3c695e49 in __libc_start_main csu/../csu/libc-start.c:314:16
        #8 0x422b09 in _start (t/helper/test-tool+0x422b09)

    SUMMARY: AddressSanitizer: 3 byte(s) leaked in 1 allocation(s).
    Aborted

Whereas LSAN would emit this instead:

    $ ./t0006-date.sh -vixd
    [...]
    Direct leak of 3 byte(s) in 1 object(s) allocated from:
        #0 0x4323b8 in malloc (t/helper/test-tool+0x4323b8)
        #1 0x7f2be1d614aa in strdup string/strdup.c:42:15

    SUMMARY: LeakSanitizer: 3 byte(s) leaked in 1 allocation(s).
    Aborted

Now we'll instead git this sensible stack trace under
LSAN. I.e. almost the same one (but starting with "malloc", as is
usual for LSAN) as under ASAN:

    Direct leak of 3 byte(s) in 1 object(s) allocated from:
        #0 0x4323b8 in malloc (t/helper/test-tool+0x4323b8)
        #1 0x7f012af5c4aa in strdup string/strdup.c:42:15
        #2 0x5cb164 in xstrdup wrapper.c:29:14
        #3 0x495ee9 in parse_date_format date.c:991:24
        #4 0x453aac in show_dates t/helper/test-date.c:39:2
        #5 0x453782 in cmd__date t/helper/test-date.c:116:3
        #6 0x451d95 in cmd_main t/helper/test-tool.c:127:11
        #7 0x451f1e in main common-main.c:52:11
        #8 0x7f012aef5e49 in __libc_start_main csu/../csu/libc-start.c:314:16
        #9 0x42e0a9 in _start (t/helper/test-tool+0x42e0a9)

    SUMMARY: LeakSanitizer: 3 byte(s) leaked in 1 allocation(s).
    Aborted

As the option name suggests this does make things slower, e.g. for
t0001-init.sh we're around 10% slower:

    $ hyperfine -L v 0,1 'LSAN_OPTIONS=fast_unwind_on_malloc={v} make T=t0001-init.sh' -r 3
    Benchmark 1: LSAN_OPTIONS=fast_unwind_on_malloc=0 make T=t0001-init.sh
      Time (mean ± σ):      2.135 s ±  0.015 s    [User: 1.951 s, System: 0.554 s]
      Range (min … max):    2.122 s …  2.152 s    3 runs

    Benchmark 2: LSAN_OPTIONS=fast_unwind_on_malloc=1 make T=t0001-init.sh
      Time (mean ± σ):      1.981 s ±  0.055 s    [User: 1.769 s, System: 0.488 s]
      Range (min … max):    1.941 s …  2.044 s    3 runs

    Summary
      'LSAN_OPTIONS=fast_unwind_on_malloc=1 make T=t0001-init.sh' ran
        1.08 ± 0.03 times faster than 'LSAN_OPTIONS=fast_unwind_on_malloc=0 make T=t0001-init.sh'

I think that's more than worth it to get the more meaningful stack
traces, we can always provide LSAN_OPTIONS=fast_unwind_on_malloc=0 for
one-off "fast" runs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ba5186c859b..9af5fb7674d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -76,6 +76,7 @@ prepend_var ASAN_OPTIONS : detect_leaks=0
 export ASAN_OPTIONS
 
 prepend_var LSAN_OPTIONS : $GIT_SAN_OPTIONS
+prepend_var LSAN_OPTIONS : fast_unwind_on_malloc=0
 export LSAN_OPTIONS
 
 if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
-- 
2.35.1.1188.g137d9ee5e75

