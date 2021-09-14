Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B73C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D08861175
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 22:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhINWHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbhINWHT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 18:07:19 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDBFC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:06:01 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id n24so734633ion.10
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 15:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eYPHvdJaWAws5Zqxt4zIjHT0mSAwdq9hWenQrLM4k5M=;
        b=IsuaV4HENc50AjCrAGu5v2mHZU/sd0R4IMjPw2QYiUftAR4LbQWWm0Cw/8tQaHWWxC
         9hjVSeYVaZi9su1f6eboG1mdN3LsF7DmYXYrv/2rmdUII0VAnCGykQ1Bd+GER5oNI4KV
         oPmW0xnUhT0Iv+uQO2ub5O23XadlvWKYbnCFf8Z7AAhpxfKM4ERD1j2t64AzsU6/pHQp
         feSu9Izxc5pKCs+TK+5vJReR8julEnbsDhfuAZTDN963KrgdrFrG2c24vxRBLOzW1Chz
         HcU2voMvgkHFnRlm0nDcrg9XjmJHEnsdEoP9ASm5RdNNpv5d6kflbhMANkUv4mWBurtw
         +hmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eYPHvdJaWAws5Zqxt4zIjHT0mSAwdq9hWenQrLM4k5M=;
        b=wE8qWsGZdfwYw30zIcW0c8pZidVe/Evmw2fHqW9jb7DXQ7GxQzF5GCi8le+ie1b7O8
         c99ngbPfKaw+hAAtIXdQVIPiEG6MjLdsUUtJkJpSH4ZjhkH8yah6p59PndL9ezHB7zdb
         qL+4RI8Dy09LpvdtI5pBlpMlIyf2TeY9cSQ+tJuPoceFznpDeRiTh6O8baCJYLm1RATn
         FXS96cmqcGa9hUNr+En7u0XJCyJoHKWKLi5lBp3VmTgNTjyfo+yTkQ1vi8poK/v073VF
         VzTSR4Z2AW6wljgLGWoFvVYs9d1AxA8c/EKp/5E31YAs/jpgGKVCpFY7lYdUQwL7BN6v
         LfdA==
X-Gm-Message-State: AOAM531G51xr05CweHAUkVDWRq3sGeUZs00zWD1VdfzLsCpOm+Q/AE+h
        qPUOEbHkU8/OLkGq3Lk/N7cX7xC3hfphmpCo
X-Google-Smtp-Source: ABdhPJzCpBr/7mOaxJMWbAZ4cPBIS+bTe3khVzssTEaJX8QULAze47sd05T6F5CpwF0Llbdd/jo7xw==
X-Received: by 2002:a6b:c8c7:: with SMTP id y190mr15319216iof.210.1631657160509;
        Tue, 14 Sep 2021 15:06:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s12sm3332848ilo.70.2021.09.14.15.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:05:59 -0700 (PDT)
Date:   Tue, 14 Sep 2021 18:05:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 0/7] pack-bitmap: permute existing namehash values
Message-ID: <cover.1631657157.git.me@ttaylorr.com>
References: <cover.1631049462.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631049462.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a small-ish rerool of my series to carry forward values from an existing
hash-cache when generating multi-pack reachability bitmaps.

Since last time, the performance tests in p5326 were cleaned up in order to
produce timings for generating a pack when using a MIDX bitmap with the
hash-cache extension.

The test-tool implementation in the second patch was also fixed to print the
correct OID for each name-hash. In the previous version, the order we looked up
read the hash-cache was according to pack order, when it should be in index
order. This bug still allowed the tests to pass, because the two orderings are
permutations of one another, so the expected and actual orderings were wrong in
the same way.

It is based on the `tb/multi-pack-bitmaps` topic, which graduated to master.
Thanks in advance for your review.

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
 t/perf/p5326-multi-pack-bitmaps.sh |  8 +++---
 t/t5326-multi-pack-bitmaps.sh      | 32 +++++++++++++++++++++++
 9 files changed, 113 insertions(+), 11 deletions(-)

Range-diff against v1:
1:  918f9b275a ! 1:  4f2b8d9530 t/helper/test-bitmap.c: add 'dump-hashes' mode
    @@ pack-bitmap.c: int test_bitmap_commits(struct repository *r)
     +{
     +	struct bitmap_index *bitmap_git = prepare_bitmap_git(r);
     +	struct object_id oid;
    -+	uint32_t i;
    ++	uint32_t i, index_pos;
     +
     +	if (!bitmap_git->hashes)
     +		goto cleanup;
     +
     +	for (i = 0; i < bitmap_num_objects(bitmap_git); i++) {
    -+		nth_bitmap_object_oid(bitmap_git, &oid, i);
    ++		if (bitmap_is_midx(bitmap_git))
    ++			index_pos = pack_pos_to_midx(bitmap_git->midx, i);
    ++		else
    ++			index_pos = pack_pos_to_index(bitmap_git->pack, i);
    ++
    ++		nth_bitmap_object_oid(bitmap_git, &oid, index_pos);
     +
     +		printf("%s %"PRIu32"\n",
    -+		       oid_to_hex(&oid), get_be32(bitmap_git->hashes + i));
    ++		       oid_to_hex(&oid), get_be32(bitmap_git->hashes + index_pos));
     +	}
     +
     +cleanup:
2:  fa9f5633f6 = 2:  2cd2f3aa5e pack-bitmap.c: propagate namehash values from existing bitmaps
3:  be8f47e13c ! 3:  f0d8f106c2 midx.c: respect 'pack.writeBitmapHashcache' when writing bitmaps
    @@ builtin/multi-pack-index.c: static struct option *add_common_options(struct opti
     +	}
     +
     +	/*
    -+	 * No need to fall-back to 'git_default_config', since this was already
    -+	 * called in 'cmd_multi_pack_index()'.
    ++	 * We should never make a fall-back call to 'git_default_config', since
    ++	 * this was already called in 'cmd_multi_pack_index()'.
     +	 */
     +	return 0;
     +}
-:  ---------- > 4:  a8c6e845ad p5326: create missing 'perf-tag' tag
-:  ---------- > 5:  191922c8f2 p5326: don't set core.multiPackIndex unnecessarily
-:  ---------- > 6:  040bb40548 p5326: generate pack bitmaps before writing the MIDX bitmap
4:  acf3ec60cb ! 7:  fdf71432b3 t5326: test propagating hashcache values
    @@ Commit message
         the configuration to enable the hashcache at all, test that both of
         these function correctly by hardening their behavior with a test.
     
    +    Like the hash-cache in classic single-pack bitmaps, this helps more
    +    proportionally the more up-to-date your bitmap coverage is. When our
    +    bitmap coverage is out-of-date with the ref tips, we spend more time
    +    proportionally traversing, and all of that traversal gets the name-hash
    +    filled in.
    +
    +    But for the up-to-date bitmaps, this helps quite a bit. These numbers
    +    are on git.git, with `pack.threads=1` to help see the difference
    +    reflected in the overall runtime.
    +
    +        Test                            origin/tb/multi-pack-bitmaps   HEAD
    +        -------------------------------------------------------------------------------------
    +        5326.4: simulated clone         1.87(1.80+0.07)                1.46(1.42+0.03) -21.9%
    +        5326.5: simulated fetch         2.66(2.61+0.04)                1.47(1.43+0.04) -44.7%
    +        5326.6: pack to file (bitmap)   2.74(2.62+0.12)                1.89(1.82+0.07) -31.0%
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## t/t5326-multi-pack-bitmaps.sh ##
-- 
2.33.0.96.g73915697e6
