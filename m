Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E0CC433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 11:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbiBSLaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 06:30:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238736AbiBSLaN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 06:30:13 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BAC1A138D
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 03:29:53 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k41so6777252wms.0
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 03:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcmhDwstsnXq2UShK2IxmKIdoFf3vKkUu53WK6LSagA=;
        b=M4OzqJ69xr+8ojhBPfnpalSgqLiS5yqwmSpxUIjwuj884RQmJgfTLrbm/YgVRMJ77M
         VFOIpPYDgbJFO1P/zOGZgqe+7cqXnpWm/B1rucuyJra0WBQy9TMLyx2ak055nnL/SILH
         N1TLirPfGN/+c4TAqrgQt+rzSkCF6MC0QsqDzT5u6jEyA8673AJ/vmxJaoCUVgzJ258+
         A6FeGJ3A5s463zUiyOXYtnlVZ7sgJlKw1PBBWX/VtB/IFJUD3Q7UHqqvux0jgja3Vej3
         OIqEwUwt9N/h6f22FyxkUdY9bSKNDklSkFnH7B7+SZv617GSoxJFVxglTOKN3Oi/E7NL
         vaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcmhDwstsnXq2UShK2IxmKIdoFf3vKkUu53WK6LSagA=;
        b=OKKa9Do4d+rI7jC5X6PXAnryqKoB2EuV12BBGRKYAba+yEFZ+Y6ZaCvuu/iC6mYVgK
         nIaUgj9AKI/JKik7C3K2kSKgz0duaOEmRu/lkqdqJ+RgC28XL4F/WCQNN2XoVVADwP3+
         c1f8pgg+tDTtlTXJX5dkrNvKDbBDFz5F0KSlQa4VDiTBFJxghRsUon1M276rMa7+FHyO
         S/ZHZegQFe+BFNmJTsUGvdLkeCW7Nx1l2hRi7JKUvaANPl4NTL3VMBxnSiImPDghxcn0
         VgT2eZphDFba4KwiTeHUW4LzIbz37u/Qnx9Cg3d3T4ZlV3o6uJCsBS03/y+6vW5yG/jX
         8oWA==
X-Gm-Message-State: AOAM533/Gzp9lHSOdeyOjqw2ZIPV8K2hD/I4naactPFx6VTeTe79RxSQ
        T7LPrUKhI3jeKTIAtZS0RQqYlVTjwBTwYw==
X-Google-Smtp-Source: ABdhPJxOwgooUKFX3Nlnndia15WLqBUiTFIniCzUElWTbct4WmdTaa/X6yEZ69jVv64AqK66OJ32lQ==
X-Received: by 2002:a1c:4d0e:0:b0:37c:b85:5404 with SMTP id o14-20020a1c4d0e000000b0037c0b855404mr10366384wmh.184.1645270192156;
        Sat, 19 Feb 2022 03:29:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12sm29464695wrw.32.2022.02.19.03.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 03:29:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/4] test-lib: add "fast_unwind_on_malloc=0" to LSAN_OPTIONS
Date:   Sat, 19 Feb 2022 12:29:43 +0100
Message-Id: <patch-v2-4.4-e6a48b6e4ce-20220219T112653Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1130.g7c6dd716f26
In-Reply-To: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
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
index 80944035f2c..129668c685f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -71,6 +71,7 @@ prepend_var ASAN_OPTIONS : detect_leaks=0
 export ASAN_OPTIONS
 
 prepend_var LSAN_OPTIONS : $GIT_XSAN_OPTIONS
+prepend_var LSAN_OPTIONS : fast_unwind_on_malloc=0
 export LSAN_OPTIONS
 
 if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
-- 
2.35.1.1130.g7c6dd716f26

