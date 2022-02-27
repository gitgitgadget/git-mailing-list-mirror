Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236CFC433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 10:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiB0K0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 05:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiB0K0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 05:26:25 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8AC1E3C3
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 02:25:48 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j17so11111327wrc.0
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 02:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W6ypK++w4tU2tg3FSEL8dshj1npuedoIJat72JV4NVs=;
        b=PgKC58l9Wor9MDC8fNW8+iND0r1j5Urxo/5ojRcWrwF+Tav9paLf5AbQzEEDXREGe6
         dvfJB2tG5ypjtLSE/66rBZGVzNfpVQ4kMwoC6ZsXLaZciPC219/wmm26l8Sl4Z0lRRjH
         kUUcirGE38MrxRIK+ZCNczKqqGuT+BoTrwW2rhAagKihQy1iRZm7fYUMWxujoSUmh+wM
         wWOiV9HXnP0ilTxTCFrRKmb5rcScFnKS+x4xEKt8lKlLxyDJvhhoDPo+0pMgxDbUEk/l
         p0jXV/z+zh5/Ct6NAUrgyCS5sWvyiwXpRd5X4wZyql5IDYu8iujPe20U4gbIB2zP5rfD
         ZmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6ypK++w4tU2tg3FSEL8dshj1npuedoIJat72JV4NVs=;
        b=ke08fk3ujBsXS4PaJiuKjpiw3sdn8pOwULzay07uwAgtn4ZHLXMNDbR0qj0xipk4G/
         nMLT1F1QZqc0tRjRlw/sLy/XMqQnqBq/CwvEaHxqzG2M4CBJCKvuzQb/KYl4ROlu8a+Z
         0LpTKO0N8gqYM96ZRZlOt69QbeoE15EE1icXL4IJgh28xWt0BTbzs06dPyIINJIsr5wP
         nz35C2QTTgn6Uo2MVknn9TrrUYG6rJ0MdDwKZ5Ww6BQ7RtlcBhPzYc1/ReRczEgX5LbJ
         +hfVdyRl0cWb4UODWQ3LDAKZ9b0GHnVhAdw7BTetdzkFO2j753QFoaAmLthnBqY7JM7n
         Xspw==
X-Gm-Message-State: AOAM532pk/NUugiHlfakRTTIbiBhcc5kpJquZQQOfQmynF1AW4rp98rL
        FOnMYofHfNbYjrOgHu3t1uh5MBBlzlI=
X-Google-Smtp-Source: ABdhPJyuWF1HiifYiT/05H8RSr5sIT+H1hSRaAagA+tNORWhvP+QlylNoa/X8SJUlrn4KQQQ/HhIcg==
X-Received: by 2002:a5d:5987:0:b0:1e8:d8ad:abc9 with SMTP id n7-20020a5d5987000000b001e8d8adabc9mr12054998wri.413.1645957546613;
        Sun, 27 Feb 2022 02:25:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a3-20020a7bc1c3000000b00380e493660esm11031685wmj.42.2022.02.27.02.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 02:25:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/4] test-lib: improve LSAN + ASAN stack traces
Date:   Sun, 27 Feb 2022 11:25:09 +0100
Message-Id: <cover-v4-0.4-00000000000-20220227T102256Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1188.g137d9ee5e75
In-Reply-To: <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
References: <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A UX improvement for [AL]SAN stack traces. See
https://lore.kernel.org/git/cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com/
for the v3.

Changes since v3:

 * Add a comment/assertion in 2/4 about what "t" directory we
   expect/must have.

 * The 3/4 "change" is only for rebasing on the new 2/4.

Ævar Arnfjörð Bjarmason (4):
  test-lib: add GIT_SAN_OPTIONS, inherit [AL]SAN_OPTIONS
  test-lib: correct and assert TEST_DIRECTORY overriding
  test-lib: make $GIT_BUILD_DIR an absolute path
  test-lib: add "fast_unwind_on_malloc=0" to LSAN_OPTIONS

 t/test-lib.sh | 50 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 10 deletions(-)

Range-diff against v3:
1:  bf31efca464 = 1:  d1967ab34a5 test-lib: add GIT_SAN_OPTIONS, inherit [AL]SAN_OPTIONS
2:  33a628e9c3a ! 2:  97586ad4541 test-lib: correct commentary on TEST_DIRECTORY overriding
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-lib: correct commentary on TEST_DIRECTORY overriding
    +    test-lib: correct and assert TEST_DIRECTORY overriding
     
         Correct a misleading comment added by me in 62f539043c7 (test-lib:
    -    Allow overriding of TEST_DIRECTORY, 2010-08-19).
    +    Allow overriding of TEST_DIRECTORY, 2010-08-19), and add an assertion
    +    that TEST_DIRECTORY cannot point to any directory except the "t"
    +    directory in the top-level of git.git.
     
    -    Between that comment and the later addition of
    +    This assertion is in effect not new, since we'd already die if that
    +    wasn't the case[1], but it and the updated commentary help to make
    +    that clearer.
    +
    +    The existing comments were also on the wrong arms of the
    +    "if". I.e. the "allow tests to override this" was on the "test -z"
    +    arm. That came about due to a combination of 62f539043c7 and
         85176d72513 (test-lib.sh: convert $TEST_DIRECTORY to an absolute path,
    -    2013-11-17) the comments were on the wrong arms of the "if". I.e. the
    -    "allow tests to override this" was on the "test -z" arm.
    +    2013-11-17).
     
    -    But more importantly this could be read allowing the "$TEST_DIRECTORY"
    +    Those earlier comments could be read as allowing the "$TEST_DIRECTORY"
         to be some path outside of t/. As explained in the updated comment
         that's impossible, rather it was meant for *tests* that ran outside of
         t/, i.e. the "t0000-basic.sh" tests that use "lib-subtest.sh".
    @@ Commit message
         reflect that, and further comment on why we have a hard dependency on
         this.
     
    +    1. https://lore.kernel.org/git/220222.86o82z8als.gmgdl@evledraar.gmail.com/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/test-lib.sh ##
    @@ t/test-lib.sh
      	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
      fi
      if test -z "$TEST_OUTPUT_DIRECTORY"
    +@@ t/test-lib.sh: then
    + 	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
    + fi
    + GIT_BUILD_DIR="$TEST_DIRECTORY"/..
    ++if test "$TEST_DIRECTORY" = "${TEST_DIRECTORY%/t}"
    ++then
    ++	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
    ++	exit 1
    ++fi
    + 
    + # Prepend a string to a VAR using an arbitrary ":" delimiter, not
    + # adding the delimiter if VAR or VALUE is empty. I.e. a generalized:
3:  b03ae29fc92 ! 3:  c25c4532c72 test-lib: make $GIT_BUILD_DIR an absolute path
    @@ t/test-lib.sh: then
      	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
      fi
     -GIT_BUILD_DIR="$TEST_DIRECTORY"/..
    +-if test "$TEST_DIRECTORY" = "${TEST_DIRECTORY%/t}"
     +GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
    - 
    - # Prepend a string to a VAR using an arbitrary ":" delimiter, not
    - # adding the delimiter if VAR or VALUE is empty. I.e. a generalized:
    ++if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
    + then
    + 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
    + 	exit 1
     @@ t/test-lib.sh: prepend_var () {
      # problems. The GIT_SAN_OPTIONS variable can be used to set common
      # defaults shared between [AL]SAN_OPTIONS.
4:  d212009e517 = 4:  fa4946ce7ef test-lib: add "fast_unwind_on_malloc=0" to LSAN_OPTIONS
-- 
2.35.1.1188.g137d9ee5e75

