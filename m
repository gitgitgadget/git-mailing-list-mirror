Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872C2C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 15:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346428AbiBUP7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 10:59:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379778AbiBUP7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 10:59:25 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A983429817
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 07:59:01 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o24so27909949wro.3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 07:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eLUJL2mxz2y+4aBg9VQWVZGxIn/Fmqqg98RnoffVUrA=;
        b=I72NDD9YjkaXG7HsgsCp94BMk/a1v6coXHUytmYOcEeFEarD7W0IKOxFhBZFmHTl5x
         SGulBfjfO1FgT7s8POkEZ6mhtLh7Kye5aodyNL3K2niN0zj6OnUIq5K+haAaeYdUi3p+
         FCsCzToe2EUnYn2tbeb0BUfD0jXCXUVtxlwttvESrxTIKBqWV2d/frbKXbxWPx8kPdsX
         p12oC2VEg0mvNFIkLlVdlHQlSZGDUTG/bJr8WNZ8fJuHN7Nr6giJ+0hoswmM74IiB8RX
         eGy+XawarPRCowle+zMBbEbaCqW2B2pJW2/l38d9JqT+kbknFsFG1LiwDhVfqVqtAjOR
         OykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eLUJL2mxz2y+4aBg9VQWVZGxIn/Fmqqg98RnoffVUrA=;
        b=cvUvPl/VC9LdMwAh9pFPgL9niNyg1e8djYA/RbWQLpTXvDVKtSNpIl6NlpnOGoxrY6
         //x6zbRJYyAyVXOl/i6pE9QbSIq5Z9WV7B9j5qDHjxWw18v5x4jaIX+qmsi3k1QOIl+R
         yvpkQu1CNf3Dx/nyAsbAk8CRPlgkKCqYNrIr3KQ+MQTp6mDaksRpCdEd7SBFuRf9B4LF
         o0hQEwBNFCLOo+uejJYUh5MBsH8M2Jw1ba2R8Tlfk+W2Lmy7SqTStTJ6Hr35zKFJg5KL
         a53E8P7diUM1apLSntBGdaNog9uhlIV7YtVehZP89wVh2LldWlbh7vV0J/GYsHd7C5BP
         MmEg==
X-Gm-Message-State: AOAM530YsoG2eePXddmrNEpGN3t+PJTJhnggON787bXI4BcTReT/IzXb
        cDPinY4mr30euD2I/24LvSEEYVrbU26qqQ==
X-Google-Smtp-Source: ABdhPJysRlUDoHyFJC+ModDFWop1OcHRMsEOoSz3vTKEkGw2fXfVcsiV3O7y3g6Hwyu8mU9QI+U6AQ==
X-Received: by 2002:adf:e646:0:b0:1e4:a4b1:6cdf with SMTP id b6-20020adfe646000000b001e4a4b16cdfmr16439021wrn.205.1645459139915;
        Mon, 21 Feb 2022 07:58:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x10sm7811170wmj.17.2022.02.21.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 07:58:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/4] test-lib: add "fast_unwind_on_malloc=0" to LSAN_OPTIONS
Date:   Mon, 21 Feb 2022 16:58:35 +0100
Message-Id: <patch-v3-4.4-d212009e517-20220221T155656Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com> <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
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
index ff13321bfd3..a96d19a332e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -71,6 +71,7 @@ prepend_var ASAN_OPTIONS : detect_leaks=0
 export ASAN_OPTIONS
 
 prepend_var LSAN_OPTIONS : $GIT_SAN_OPTIONS
+prepend_var LSAN_OPTIONS : fast_unwind_on_malloc=0
 export LSAN_OPTIONS
 
 if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
-- 
2.35.1.1132.ga1fe46f8690

