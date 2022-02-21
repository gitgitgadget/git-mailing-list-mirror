Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A284C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 15:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379777AbiBUP7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 10:59:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379771AbiBUP7V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 10:59:21 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A6F2981A
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 07:58:57 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o24so27909605wro.3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 07:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CiTYf0Z7AP+ZvT3U9aSzALldcazu7j6MaQfms7a00Is=;
        b=Ur/xD+lpmNWAGt3HZTURrwZ9WVGcnKg50ysGNbnjIAh8dOVajjSA7m0rF9n0eHJPIq
         H9wPbAeBfCypIJKqMYLym8vBNrdpZ7qD77mXHuylejsudNtB47KI9Wgm3FLIY/v1e3BE
         7IM3QAp1t7JKnkDraVMneho6Bcj7qeBrU1w+SHidG9vkQlBS7DoiPh8wLlQeVHymgo/R
         B8PHa1+jU3FOUqaQs21mVXstXYKLFC6TONG1jTv4sAatlNdXUhPbq1PdtFRIhuR5JnDz
         uEbRDzeAV1c+rJws0Um0fWTmm/OA8QibZ3z9yUFIn6w7Fr6sY17KbSgDe9oF5gZrUqOf
         I+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CiTYf0Z7AP+ZvT3U9aSzALldcazu7j6MaQfms7a00Is=;
        b=rgKZyxlEiYLyUaIQesZ40o6XlV3UgaPIaXtYcGiRnhfhiGKSG2ZisbukqoHvVlBkbP
         QgEhNHAVdvAd3DWv7iVnpMEOJwisHj5/GDFPfA+sEMLSBj45aVDiZwdyOBTp5S9ljYXI
         +hNzKBSMM2CU5V6f5IFs9peX+VzXnqHkWGSrPHbzqj32B+iVkdsG1dOzbRGUhn8UNE8y
         1VuNb/lSlmn6eeBh7Wm52X+zgiXTe8DpMtLHkt1wm9t7Y/n8BP9KwoEVmPcBh+G9CymM
         /xsCvpC8C6xNUrS0mw6dPI/gBiZKfAsdzzytSSDDCxNJbYVhpvBdRtbaXobA2KnWZRIp
         4w8A==
X-Gm-Message-State: AOAM530/KysYjr1mJsG1crM+3RUSPVcraKTIptQz68V/2L6xIWUaQL70
        ZmaxEsPmoPbHRgEXCOpBpgg4n9h7nlr15g==
X-Google-Smtp-Source: ABdhPJx3nNodnWuvqktC9nQK7rcBoyQRrJtrHa0KMqCGQMQk+MWr9XU+ffoG9yV54zWOhg2i6Cq+Lg==
X-Received: by 2002:adf:ec0b:0:b0:1e4:f1be:b62a with SMTP id x11-20020adfec0b000000b001e4f1beb62amr16416147wrn.487.1645459135625;
        Mon, 21 Feb 2022 07:58:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x10sm7811170wmj.17.2022.02.21.07.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 07:58:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/4] test-lib: improve LSAN + ASAN stack traces
Date:   Mon, 21 Feb 2022 16:58:31 +0100
Message-Id: <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A UX improvement for [AL]SAN stack traces. See
https://lore.kernel.org/git/cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com/
for the v2.

Changes:
 * Renamed GIT_XSAN_OPTIONS to GIT_SAN_OPTIONS per Junio's suggestion
 * Fixed grammar ("do do do...")" in commit message.

Ævar Arnfjörð Bjarmason (4):
  test-lib: add GIT_SAN_OPTIONS, inherit [AL]SAN_OPTIONS
  test-lib: correct commentary on TEST_DIRECTORY overriding
  test-lib: make $GIT_BUILD_DIR an absolute path
  test-lib: add "fast_unwind_on_malloc=0" to LSAN_OPTIONS

 t/test-lib.sh | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

Range-diff against v2:
1:  01e63a72231 ! 1:  bf31efca464 test-lib: add GIT_XSAN_OPTIONS, inherit [AL]SAN_OPTIONS
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-lib: add GIT_XSAN_OPTIONS, inherit [AL]SAN_OPTIONS
    +    test-lib: add GIT_SAN_OPTIONS, inherit [AL]SAN_OPTIONS
     
         Change our ASAN_OPTIONS and LSAN_OPTIONS to set defaults for those
         variables, rather than punting out entirely if we already have them in
         the environment.
     
    -    We do want to take any user-provided settings over our own, but we can
    -    do do that by prepending our defaults to the variable. The
    -    libsanitizer options parsing has "last option wins" semantics.
    +    We want to take any user-provided settings over our own, but we can do
    +    that by prepending our defaults to the variable. The libsanitizer
    +    options parsing has "last option wins" semantics.
     
         It's now possible to do e.g.:
     
    @@ t/test-lib.sh: then
     +}
     +
     +# If [AL]SAN is in effect we want to abort so that we notice
    -+# problems. The GIT_XSAN_OPTIONS variable can be used to set common
    ++# problems. The GIT_SAN_OPTIONS variable can be used to set common
     +# defaults shared between [AL]SAN_OPTIONS.
    -+prepend_var GIT_XSAN_OPTIONS : abort_on_error=1
    ++prepend_var GIT_SAN_OPTIONS : abort_on_error=1
     +
      # If we were built with ASAN, it may complain about leaks
      # of program-lifetime variables. Disable it by default to lower
    @@ t/test-lib.sh: then
      # before we even do our "did we build git yet" check (since we don't
      # want that one to complain to stderr).
     -: ${ASAN_OPTIONS=detect_leaks=0:abort_on_error=1}
    -+prepend_var ASAN_OPTIONS : $GIT_XSAN_OPTIONS
    ++prepend_var ASAN_OPTIONS : $GIT_SAN_OPTIONS
     +prepend_var ASAN_OPTIONS : detect_leaks=0
      export ASAN_OPTIONS
      
     -# If LSAN is in effect we _do_ want leak checking, but we still
     -# want to abort so that we notice the problems.
     -: ${LSAN_OPTIONS=abort_on_error=1}
    -+prepend_var LSAN_OPTIONS : $GIT_XSAN_OPTIONS
    ++prepend_var LSAN_OPTIONS : $GIT_SAN_OPTIONS
      export LSAN_OPTIONS
      
      if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
2:  0c2867e30dc = 2:  33a628e9c3a test-lib: correct commentary on TEST_DIRECTORY overriding
3:  229654027b8 ! 3:  b03ae29fc92 test-lib: make $GIT_BUILD_DIR an absolute path
    @@ t/test-lib.sh: then
      # Prepend a string to a VAR using an arbitrary ":" delimiter, not
      # adding the delimiter if VAR or VALUE is empty. I.e. a generalized:
     @@ t/test-lib.sh: prepend_var () {
    - # problems. The GIT_XSAN_OPTIONS variable can be used to set common
    + # problems. The GIT_SAN_OPTIONS variable can be used to set common
      # defaults shared between [AL]SAN_OPTIONS.
    - prepend_var GIT_XSAN_OPTIONS : abort_on_error=1
    -+prepend_var GIT_XSAN_OPTIONS : strip_path_prefix=\"$GIT_BUILD_DIR/\"
    + prepend_var GIT_SAN_OPTIONS : abort_on_error=1
    ++prepend_var GIT_SAN_OPTIONS : strip_path_prefix=\"$GIT_BUILD_DIR/\"
      
      # If we were built with ASAN, it may complain about leaks
      # of program-lifetime variables. Disable it by default to lower
4:  e6a48b6e4ce ! 4:  d212009e517 test-lib: add "fast_unwind_on_malloc=0" to LSAN_OPTIONS
    @@ t/test-lib.sh
     @@ t/test-lib.sh: prepend_var ASAN_OPTIONS : detect_leaks=0
      export ASAN_OPTIONS
      
    - prepend_var LSAN_OPTIONS : $GIT_XSAN_OPTIONS
    + prepend_var LSAN_OPTIONS : $GIT_SAN_OPTIONS
     +prepend_var LSAN_OPTIONS : fast_unwind_on_malloc=0
      export LSAN_OPTIONS
      
-- 
2.35.1.1132.ga1fe46f8690

