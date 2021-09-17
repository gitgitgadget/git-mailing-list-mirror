Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3962FC433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14734611C3
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343513AbhIQVWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 17:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbhIQVWg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 17:22:36 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B73C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:21:13 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id x2so11675428ila.11
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O1Ns20CTQr1tBSl4/WkV2feHtZRK4aRePOBZ+TMo5Mo=;
        b=Om6GQhNIJX4VKTABV4t5CkWgQgwX6g2UhnIws0EsAiGhwmUhobo2EFk5ZMSh5qC/dN
         wsGLIgc5GcQPRO5I9JAS22B/1CRAnISZ8c669XMeXdRblSnJgdOruaump12DplNQ3Lnl
         b7MbZYkTBBaJvKQVBgKP/YRL7xEAF5p9qLP+mWAGmrJaNF73MFseEGMrv4mpMDBp1gqj
         DSLp/AeacKbukqFyJ33kGVBpBAvcXqrKZmToVgFEHoKPqt/IgAquINOG5dnkixNp4dM/
         SOCsCWlMpt+UxWPcinS3CbcDxe8pZXqZhnSxskAP/Ya6+opxKG0++63Z7o4khCUGZRwx
         ho8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O1Ns20CTQr1tBSl4/WkV2feHtZRK4aRePOBZ+TMo5Mo=;
        b=qD6xqDAfGWlP/O28g8Ze8+1PWrdQsedX2wsvr9qzC5YLcs5Lb6Sgorc41vKdNsw96i
         t0FKhcte2nWBiQMLRwYStCoElilPX4x5lRW8nLz+/DI9l4kX/Offvc950LBKby/P5qx+
         eLtv+wc4SC9s0/fJFfWMtdB4C8Mj3VHEMs85ZSH9cBtnL3rhlUhIAWrRudVkN/nxZxaw
         Wu5VosBxnkIUMCGid1lN4REB6n6wBuTlLgMWNnx75Khuav9dyoHNzSFnmpXyOmzwt1sh
         MVC46zvNso6XxpChtYNgnwKjM44/bW0gpF5akfXQslHYOqEocYmkGsYOPT7/1zfFYCqP
         Ja2w==
X-Gm-Message-State: AOAM530UCog6ijb1NBD+b31nqxvzbgVSUpXK+PpqQZCylejQ1j1W9KrY
        jj4xGT2X2yFjxM6KcfCHeeY9PEsgUUhY30e6
X-Google-Smtp-Source: ABdhPJyfeU9A676TKk5R/A/f0ohoL8p2tT6e9+uVI6W3fug+Umd4jX4NLaqseR+bCIQydzNkI+Bd9w==
X-Received: by 2002:a92:d3c1:: with SMTP id c1mr9677801ilh.223.1631913673094;
        Fri, 17 Sep 2021 14:21:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b12sm2847887ioj.55.2021.09.17.14.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 14:21:12 -0700 (PDT)
Date:   Fri, 17 Sep 2021 17:21:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v3 0/7] pack-bitmap: permute existing namehash values
Message-ID: <cover.1631913631.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631049462.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a very small reroll of my series to permute values from an existing
hash-cache when generating multi-pack reachability bitmaps.

The only changes since last time are a slightly modified version of the
performance tests which don't time generating the pack-bitmap. And the new test
in t5326 no longer has a redundant `git config pack.writeBitmapHashCache` since
it is true by default.

It is based on the `tb/multi-pack-bitmaps` topic, which graduated to master.
Thanks in advance for your review on this hopefully-final iteration :-).

Taylor Blau (7):
  t/helper/test-bitmap.c: add 'dump-hashes' mode
  pack-bitmap.c: propagate namehash values from existing bitmaps
  midx.c: respect 'pack.writeBitmapHashcache' when writing bitmaps
  p5326: create missing 'perf-tag' tag
  p5326: don't set core.multiPackIndex unnecessarily
  p5326: generate pack bitmaps before writing the MIDX bitmap
  t5326: test propagating hashcache values

 Documentation/config/pack.txt      |  4 +++
 builtin/multi-pack-index.c         | 21 +++++++++++++++
 midx.c                             |  6 ++++-
 midx.h                             |  1 +
 pack-bitmap.c                      | 41 +++++++++++++++++++++++++-----
 pack-bitmap.h                      |  1 +
 t/helper/test-bitmap.c             | 10 +++++++-
 t/perf/p5326-multi-pack-bitmaps.sh | 15 ++++++++---
 t/t5326-multi-pack-bitmaps.sh      | 30 ++++++++++++++++++++++
 9 files changed, 118 insertions(+), 11 deletions(-)

Range-diff against v2:
1:  4f2b8d9530 = 1:  4f2b8d9530 t/helper/test-bitmap.c: add 'dump-hashes' mode
2:  2cd2f3aa5e = 2:  2cd2f3aa5e pack-bitmap.c: propagate namehash values from existing bitmaps
3:  f0d8f106c2 = 3:  f0d8f106c2 midx.c: respect 'pack.writeBitmapHashcache' when writing bitmaps
4:  a8c6e845ad = 4:  a8c6e845ad p5326: create missing 'perf-tag' tag
5:  191922c8f2 = 5:  191922c8f2 p5326: don't set core.multiPackIndex unnecessarily
6:  040bb40548 ! 6:  59b6914ef8 p5326: generate pack bitmaps before writing the MIDX bitmap
    @@ Commit message
         we have to rely on a single-pack bitmap to generate those values for us.

         Therefore, generate a pack bitmap before the MIDX one in order to ensure
    -    that the MIDX bitmap has entries in its hash-cache.
    +    that the MIDX bitmap has entries in its hash-cache. Since we don't want
    +    to time generating the pack bitmap, move that to a non-perf test run
    +    before we try to generate the MIDX bitmap.
    +
    +    Likewise, get rid of the pack bitmap afterwords, to make certain that we
    +    are not accidentally using it in the performance tests run later on.

         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## t/perf/p5326-multi-pack-bitmaps.sh ##
     @@ t/perf/p5326-multi-pack-bitmaps.sh: test_expect_success 'create tags' '
    + 	git tag --message="tag pointing to HEAD" perf-tag HEAD
      '

    ++test_expect_success 'start with bitmapped pack' '
    ++	git repack -adb
    ++'
    ++
      test_perf 'setup multi-pack index' '
     -	git repack -ad &&
    -+	git repack -adb &&
      	git multi-pack-index write --bitmap
      '

    ++test_expect_success 'drop pack bitmap' '
    ++	rm -f .git/objects/pack/pack-*.bitmap
    ++'
    ++
    + test_full_bitmap
    +
    + test_expect_success 'create partial bitmap state' '
7:  fdf71432b3 ! 7:  bb16125915 t5326: test propagating hashcache values
    @@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'pack.preferBitmapTips' '
     +	(
     +		cd repo &&
     +
    -+		git config pack.writeBitmapHashCache true &&
    -+
     +		test_commit base &&
     +		test_commit base2 &&
     +		git repack -adb &&
--
2.33.0.96.g73915697e6
