Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5F9C83F15
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 22:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjH1WxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 18:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjH1WxA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 18:53:00 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483B099
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:52:58 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d746ea563f9so3580029276.1
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693263177; x=1693867977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Nz/yD5Q4DmqXtQBwVf/XLqmw0aqScWrdJNHEWd7fVI=;
        b=P+1HRh//WTO0Fw+tx9SS2GazZAYGeuTRauZ9GwwRJ7PLIxbxMwsgEhrxV1jbIMxIGp
         nAl4I5z9Q21c47YXULxapuvPFNynkDspj6k3mzgmQQcA3fEsLVZ+EGik7e4t6SaaadYa
         fcxCW9UmEMxq3p47WqMsGEHPR9AIKhAdIM2wjNJTrSm3PFyvgxp20C1/AAK5lE15UIZQ
         7V34zSsDz0Cu/Sd6BL75zDYL1lSnEh27yvf6yZb7DobPgcduybZfreCRdzYefuQErQoL
         NMCTcxzpU3rH/okBh8mUuoEkPqgeHJK6hbulUknxJoQp/tI9w7bbmOqgSEwbDPpgtM21
         CkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693263177; x=1693867977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Nz/yD5Q4DmqXtQBwVf/XLqmw0aqScWrdJNHEWd7fVI=;
        b=ZFd+4P2uF236Yg2NHx+sgraS6XcirY4NrvQEU6Wxhl37Hkasymy6JbL8jJ3X2eT/S+
         L8ni1GSBuNIRby/GJSL53P7HAuWI1AcsZH/hXU/VtBYKKWL2Xe8o/gdRrb+ojJS4fF5T
         uwPLA4l+N2rSpOMQ8KpgiFKHVjmpewYgsPJqMW7a5N05opRsgJVFiPNzyvkkFxlT4q27
         cKiKMivzR0BnPR0D/Hdmw464NCA9dZtelFoTZNvsXfl1dYEwdO5pKT9PhKCanCDJtk2P
         /ZiAt2epo+kYrTJgBDopYSWWTnKrPluxPbt3T79vXySvvkfBahH5htSli3fcX0zB9Elq
         mFQg==
X-Gm-Message-State: AOJu0YybntTsvWySOAIc07DvDzCKuQamZZrXQ7P+TGh3fZWaJ4dgz97T
        zfiEbcZLtvDpiz45CoKfeNu/TbZ+E7TnhEddiSCkKg==
X-Google-Smtp-Source: AGHT+IErFB1MpPwH8i8yRA8Ko13ffjJvk1fcmK2plx4WxNs2sgGrCz72zJGrbDNnC/ovu8EnItHnSQ==
X-Received: by 2002:a25:241:0:b0:d74:6c43:f327 with SMTP id 62-20020a250241000000b00d746c43f327mr26256664ybc.10.1693263177381;
        Mon, 28 Aug 2023 15:52:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e8-20020a256908000000b00d7497467d36sm1916786ybc.45.2023.08.28.15.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 15:52:57 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:52:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2 1/4] test-lib: ignore uninteresting LSan output
Message-ID: <7dd42212c0b0debe40504cca474f2a5d9207155a.1693263171.git.me@ttaylorr.com>
References: <cover.1692902414.git.me@ttaylorr.com>
 <cover.1693263171.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693263171.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

When I run the tests in leak-checking mode the same way our CI job does,
like:

  make SANITIZE=leak \
       GIT_TEST_PASSING_SANITIZE_LEAK=true \
       GIT_TEST_SANITIZE_LEAK_LOG=true \
       test

then LSan can racily produce useless entries in the log files that look
like this:

  ==git==3034393==Unable to get registers from thread 3034307.

I think they're mostly harmless based on the source here:

  https://github.com/llvm/llvm-project/blob/7e0a52e8e9ef6394bb62e0b56e17fa23e7262411/compiler-rt/lib/lsan/lsan_common.cpp#L414

which reads:

    PtraceRegistersStatus have_registers =
        suspended_threads.GetRegistersAndSP(i, &registers, &sp);
    if (have_registers != REGISTERS_AVAILABLE) {
      Report("Unable to get registers from thread %llu.\n", os_id);
      // If unable to get SP, consider the entire stack to be reachable unless
      // GetRegistersAndSP failed with ESRCH.
      if (have_registers == REGISTERS_UNAVAILABLE_FATAL)
        continue;
      sp = stack_begin;
    }

The program itself still runs fine and LSan doesn't cause us to abort.
But test-lib.sh looks for any non-empty LSan logs and marks the test as
a failure anyway, under the assumption that we simply missed the failing
exit code somehow.

I don't think I've ever seen this happen in the CI job, but running
locally using clang-14 on an 8-core machine, I can't seem to make it
through a full run of the test suite without having at least one
failure. And it's a different one every time (though they do seem to
often be related to packing tests, which makes sense, since that is one
of our biggest users of threaded code).

We can hack around this by only counting LSan log files that contain a
line that doesn't match our known-uninteresting pattern.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 293caf0f20..5ea5d1d62a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -334,6 +334,7 @@ nr_san_dir_leaks_ () {
 	find "$TEST_RESULTS_SAN_DIR" \
 		-type f \
 		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
+	xargs grep -lv "Unable to get registers from thread" |
 	wc -l
 }
 
-- 
2.42.0.49.g03c54e21ee

