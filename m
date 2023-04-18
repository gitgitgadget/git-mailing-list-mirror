Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6763C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 20:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjDRUkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 16:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjDRUkd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 16:40:33 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054C0A5CC
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:32 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54ee0b73e08so476887047b3.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681850431; x=1684442431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGA+xVj4j6tfHAZeSbSqbH+sMXH5u/tWGki88UkOoy8=;
        b=S4IXpM02Vw4T36UKOmul3mzt4C2Dma6KjgLZb9XabLCVgF9pX/vwIfZ3RUYqLS0yfh
         8+vSdxfg7mVUQlHkoGpPyM4Rb/RaJl/5Vt2fT5ijLGV9r4i3A6Q/L0kj7ds+2dnOIWX3
         tQ5oRIA9fp215CrgoorZifrupnmzhNYDlcaSDRv6WdaXzdknOc/6tanWl5/ggnBOpvOJ
         olozo0igpn93MmtbaEM6WQsT5r0U3p4QRaakWL/6hOkSfKgvOq8xw4kXbBweb8CfYuk7
         Cgb5VQxbtuRg6zfdR6AaCKj45ibPPF2aJVh1h59GxyxiKrSt3msKly9yRSVYthxlZF8U
         U2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850431; x=1684442431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGA+xVj4j6tfHAZeSbSqbH+sMXH5u/tWGki88UkOoy8=;
        b=b8VoFD9qdsKoagF3wRjbI3A0VVPViCHlKZEatcw/onCU3Qq3T2Dca1g374nyWcyN8d
         OWnQNxzzQnRtgrz84TqzKWT+WuYlS9I3YDIGnuRsw3616AFUUI7NrkbKPGecgqv77ISu
         4wANbG4DovZIph7yFnVYgIq8vCkAHqeooOs2oTpjA/abs4AjwVHSI5d1N/Eb2xwG2ULb
         mg7IN0O2WDjfFjPrUgvJxZrZJ//lyu7Iu6c3oNap5mQZkEfWpAVyUk9t8rRbTyDBjaxF
         aVdLheHDax/OLmEO98R1nvYafylmOjeVNUiqcMvc0TFzVXDwpiDXDG2ETpj3FrOdtFms
         Fe8w==
X-Gm-Message-State: AAQBX9fIzZONQBt92f+5XHU7DWrZ6aFCE+FwM/XT4CDKjME0h8dEzwJM
        yCdXRGG3g2gPv9rTu0lT/72v/hCDLk3/RDt9GxWspw==
X-Google-Smtp-Source: AKy350YOER1CSijKxlCS8AuDYo8Afv5Qbzfl9Z1CyAgsEl+7xd+HUy2iGa5m+ptsVyREq5beO+LbmQ==
X-Received: by 2002:a0d:f3c2:0:b0:541:8c8f:ec14 with SMTP id c185-20020a0df3c2000000b005418c8fec14mr1097607ywf.14.1681850430919;
        Tue, 18 Apr 2023 13:40:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bq8-20020a05690c060800b0054c082bad36sm4071863ywb.120.2023.04.18.13.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:40:30 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:40:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/10] gc: enable cruft packs by default
Message-ID: <cover.1681850424.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681764848.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a very tiny reroll of my series to graduate `gc.cruftPacks` out
of `feature.experimental` and enables it by default.

A complete summary of the topic is available in the original cover
letter[1], and the changes since last time are limited to test clean-up,
patch reorganization, and some touch-ups on the patch messages
themselves.

As always, a range-diff is below for convenience.

Thanks for all of the review thus far, and in advance for any review on
this round, too.

[1]: https://lore.kernel.org/git/cover.1681764848.git.me@ttaylorr.com/

Taylor Blau (10):
  pack-write.c: plug a leak in stage_tmp_packfiles()
  builtin/repack.c: fix incorrect reference to '-C'
  builtin/gc.c: ignore cruft packs with `--keep-largest-pack`
  t/t5304-prune.sh: prepare for `gc --cruft` by default
  t/t6501-freshen-objects.sh: prepare for `gc --cruft` by default
  t/t6500-gc.sh: refactor cruft pack tests
  t/t6500-gc.sh: add additional test cases
  t/t9300-fast-import.sh: prepare for `gc --cruft` by default
  builtin/gc.c: make `gc.cruftPacks` enabled by default
  repository.h: drop unused `gc_cruft_packs`

 Documentation/config/feature.txt |   3 -
 Documentation/config/gc.txt      |  12 +--
 Documentation/git-gc.txt         |  12 +--
 Documentation/gitformat-pack.txt |   4 +-
 builtin/gc.c                     |   8 +-
 builtin/repack.c                 |   2 +-
 pack-write.c                     |  14 ++--
 repo-settings.c                  |   4 +-
 repository.h                     |   1 -
 t/t5304-prune.sh                 |  28 +++----
 t/t6500-gc.sh                    | 135 ++++++++++++++++---------------
 t/t6501-freshen-objects.sh       |  10 +--
 t/t9300-fast-import.sh           |  13 +--
 13 files changed, 120 insertions(+), 126 deletions(-)

Range-diff against v1:
 1:  65ac7ed9b8 =  1:  c477b754e7 pack-write.c: plug a leak in stage_tmp_packfiles()
 2:  fbc8d15032 =  2:  52fb61fa9c builtin/repack.c: fix incorrect reference to '-C'
 3:  796df920ad !  3:  63b9ee8e2e builtin/gc.c: ignore cruft packs with `--keep-largest-pack`
    @@ Commit message
           - The same is true for `gc.bigPackThreshold`, if the size of the cruft
             pack exceeds the limit set by the caller.
     
    -    Ignore cruft packs in the common implementation for both of these
    -    options, and add a pair of tests to prevent any future regressions here.
    +    In the future, it is possible that `gc.bigPackThreshold` could be used
    +    to write a separate cruft pack containing any new unreachable objects
    +    that entered the repository since the last time a cruft pack was
    +    written.
    +
    +    There are some complexities to doing so, mainly around handling
    +    pruning objects that are in an existing cruft pack that is above the
    +    threshold (which would either need to be rewritten, or else delay
    +    pruning). Rewriting a substantially similar cruft pack isn't ideal, but
    +    it is significantly better than the status-quo.
    +
    +    If users have large cruft packs that they don't want to rewrite, they
    +    can mark them as `*.keep` packs. But in general, if a repository has a
    +    cruft pack that is so large it is slowing down GC's, it should probably
    +    be pruned anyway.
    +
    +    In the meantime, ignore cruft packs in the common implementation for
    +    both of these options, and add a pair of tests to prevent any future
    +    regressions here.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ Documentation/git-gc.txt: be performed as well.
     -	All packs except the largest pack and those marked with a
     -	`.keep` files are consolidated into a single pack. When this
     -	option is used, `gc.bigPackThreshold` is ignored.
    -+	All packs except the largest pack, any packs marked with a
    -+	`.keep` file, and any cruft pack(s) are consolidated into a
    -+	single pack. When this option is used, `gc.bigPackThreshold` is
    -+	ignored.
    ++	All packs except the largest non-cruft pack, any packs marked
    ++	with a `.keep` file, and any cruft pack(s) are consolidated into
    ++	a single pack. When this option is used, `gc.bigPackThreshold`
    ++	is ignored.
      
      AGGRESSIVE
      ----------
 4:  44006da959 =  4:  905eeb9027 t/t5304-prune.sh: prepare for `gc --cruft` by default
 8:  4ccc525c39 !  5:  fa6eafb1fe t/t6501-freshen-objects.sh: prepare for `gc --cruft` by default
    @@ Commit message
         cover the case of freshening loose objects not using cruft packs.
     
         We could run this test twice, once with `--cruft` and once with
    -    `--no-cruft`, but doing so is unnecessary, since the object rescuing and
    -    freshening behavior is already extensively tested via t5329.
    +    `--no-cruft`, but doing so is unnecessary, since we already test object
    +    rescuing, freshening, and dealing with corrupt parts of the unreachable
    +    object graph extensively via t5329.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
 6:  56a965e517 =  6:  e6270d75fa t/t6500-gc.sh: refactor cruft pack tests
 7:  6957e54f51 !  7:  9db3fa9e36 t/t6500-gc.sh: add additional test cases
    @@ Commit message
         which enumerates all possible combinations of arguments that will
         produce (or not produce) a cruft pack.
     
    -    This prepares us for the following commit, which will change the default
    +    This prepares us for a future commit which will change the default value
         of `gc.cruftPacks` by ensuring that we understand which invocations do
         and do not change as a result.
     
    @@ t/t6500-gc.sh: do
      done
      
      for argv in \
    -+	"gc --no-cruft" \
    ++	"gc" \
     +	"-c gc.cruftPacks=false gc" \
     +	"-c gc.cruftPacks=true gc --no-cruft" \
      	"-c feature.expiremental=true -c gc.cruftPacks=false gc" \
 5:  1b07eb83fe !  8:  894cf176ea t/t9300-fast-import.sh: prepare for `gc --cruft` by default
    @@ Metadata
      ## Commit message ##
         t/t9300-fast-import.sh: prepare for `gc --cruft` by default
     
    -    In a similar fashion as the previous commit, adjust the fast-import
    -    tests to prepare for "git gc" generating a cruft pack by default.
    +    In a similar fashion as previous commits, adjust the fast-import tests
    +    to prepare for "git gc" generating a cruft pack by default.
     
         This adjustment is slightly different, however. Instead of relying on us
         writing out the objects loose, and then calling `git prune` to remove
    @@ Commit message
         one `git gc --prune`, which handles pruning both loose objects, and
         objects that would otherwise be written to a cruft pack.
     
    +    Likely this pattern of "git gc && git prune" started all the way back in
    +    03db4525d3 (Support gitlinks in fast-import., 2008-07-19), which
    +    happened after deprecating `git gc --prune` in 9e7d501990 (builtin-gc.c:
    +    deprecate --prune, it now really has no effect, 2008-05-09).
    +
    +    After `--prune` was un-deprecated in 58e9d9d472 (gc: make --prune useful
    +    again by accepting an optional parameter, 2009-02-14), this script got a
    +    handful of new "git gc && git prune" instances via via 4cedb78cb5
    +    (fast-import: add input format tests, 2011-08-11). These could have been
    +    `git gc --prune`, but weren't (likely taking after 03db4525d3).
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## t/t9300-fast-import.sh ##
 9:  bfda40a21d !  9:  b6784ddfe2 builtin/gc.c: make `gc.cruftPacks` enabled by default
    @@ t/t6500-gc.sh: assert_no_cruft_packs () {
      }
      
      for argv in \
    +-	"gc --cruft" \
     +	"gc" \
    - 	"gc --cruft" \
      	"-c gc.cruftPacks=true gc" \
     -	"-c gc.cruftPacks=false gc --cruft" \
     -	"-c feature.experimental=true gc" \
    @@ t/t6500-gc.sh: assert_no_cruft_packs () {
      do
      	test_expect_success "git $argv generates a cruft pack" '
      		test_when_finished "rm -fr repo" &&
    -@@ t/t6500-gc.sh: done
    +@@ t/t6500-gc.sh: do
    + done
    + 
      for argv in \
    - 	"gc --no-cruft" \
    +-	"gc" \
    ++	"gc --no-cruft" \
      	"-c gc.cruftPacks=false gc" \
     -	"-c gc.cruftPacks=true gc --no-cruft" \
     -	"-c feature.expiremental=true -c gc.cruftPacks=false gc" \
10:  fa15125454 = 10:  c67ee7c2ff repository.h: drop unused `gc_cruft_packs`
-- 
2.40.0.362.gc67ee7c2ff
