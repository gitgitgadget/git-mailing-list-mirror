Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2E7C32792
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 19:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiHVTue (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 15:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238900AbiHVTu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 15:50:29 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E963DDC
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:50:27 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id j1so8943860qvv.8
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=jLRY8e6WgXNPLNfWJ4XldDJbW+9yYFxLe7JFkp22QHc=;
        b=1pMP0r0aiThYbUagGX1y/DhDK97JQjQPW/LmJdBKdBhkVa7tz1SfJA8ZeFd95ANXhK
         2jHmSJhBvMrBez5lJAUWvftmnfhdakKzT3RZIEghatk4xYdu7YHZrk/VVYHGs7fIy1T3
         5NG1e/BCJgTQ5Q0EzlmXT4QYoXiDwvuj5eHzUEKOdFQNApqCkChBhooC1FyKbPQdGFMq
         1C9/lFLV0mFB7qbzqLhFTdh4doUUVqEFHnfax2INIRDqFa3VlamdFaebPns/Tpl3kgxi
         RWBBMYLt29AGwmibDUkdOdBEPcRlBYg6RbMp8zj65XZDbClA45RwikVTvzKLeylnSs7/
         /45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=jLRY8e6WgXNPLNfWJ4XldDJbW+9yYFxLe7JFkp22QHc=;
        b=P9sHKoDun7SG33E8w13PRANiAn9KL5+8ULsdD6GDHj4F8TIlTbqFO7Xvdftzz/HFNE
         QdwBkSNWXhXBEAS1pyKsFPFsBDpBZ+71m9Xr7LjCM0vnO6C1xPx+wMEemZYwKgSCiY41
         npECj6RiUrX+aLFqoQr5/cmTKyZSnvBITxVNDhZe6F1xPjqxES1ulZJYCWNi8rOZpCjK
         4+n5Da8w7tMTYyVKNflv9LWMNrOqxWORNDV63prmhbl7XuizOu0F1Ymkl2HeBqE5/DFV
         A/iHagibKzYzOhdQWHoXWdK4x7j7OrTxvxt3VeOeH7oNlbJmUG1FV97wqPd98rQxfuT8
         d2bQ==
X-Gm-Message-State: ACgBeo18hi8uoHrxeOh90K4VAyAX9iBXjwCi+alxhgryHxJ+m/ulBMcn
        B48xYxSCbAC460720xjLw+qdlhmeTW1+NgsQ
X-Google-Smtp-Source: AA6agR4b1IvVpntUaq85yLpJ912imONRyGqBXH7UCauipdf+bX45zWrzo+3zm5JgmE2iIs/snRArMw==
X-Received: by 2002:a05:6214:62a:b0:476:858d:b2c8 with SMTP id a10-20020a056214062a00b00476858db2c8mr16588634qvx.65.1661197826194;
        Mon, 22 Aug 2022 12:50:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id fg24-20020a05622a581800b00344b807bb95sm3885926qtb.74.2022.08.22.12.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:50:25 -0700 (PDT)
Date:   Mon, 22 Aug 2022 15:50:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, derrickstolee@github.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: [PATCH v2 0/7] midx: permit changing the preferred pack when reusing
 the MIDX
Message-ID: <cover.1661197803.git.me@ttaylorr.com>
References: <cover.1660944574.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1660944574.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a small reroll of my series that resolves a bug that was
reported[1] by Johannes, and investigated by him, Abhradeep, and Stolee
in that same sub-thread.

As before: the crux of the issue is that a MIDX bitmap can enter a
corrupt state when changing the preferred pack from its value in an
existing MIDX in certain circumstances as described in the first and
final patches.

This version incorporates some cosmetic changes suggested by Stolee, and
adds a new patch on top which avoids adding objects from the MIDX that
were represented by the (new) preferred pack, since we know we'll end up
discarding those objects anyways. For convenience, a range-diff against
v1 is included below.

Thanks again for your review!

[1]: https://lore.kernel.org/git/p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr/

Taylor Blau (7):
  t5326: demonstrate potential bitmap corruption
  t/lib-bitmap.sh: avoid silencing stderr
  midx.c: extract `struct midx_fanout`
  midx.c: extract `midx_fanout_add_midx_fanout()`
  midx.c: extract `midx_fanout_add_pack_fanout()`
  midx.c: include preferred pack correctly with existing MIDX
  midx.c: avoid adding preferred objects twice

 midx.c                        | 139 +++++++++++++++++++++++-----------
 t/lib-bitmap.sh               |   2 +-
 t/t5326-multi-pack-bitmaps.sh |  44 +++++++++++
 3 files changed, 139 insertions(+), 46 deletions(-)

Range-diff against v1:
1:  3e30ab1a19 ! 1:  6b38bfcd2c t5326: demonstrate potential bitmap corruption
    @@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'graceful fallback when missi
      '
      
     +test_expect_success 'preferred pack change with existing MIDX bitmap' '
    -+	rm -fr repo &&
    -+	git init repo &&
    -+	test_when_finished "rm -fr repo" &&
    ++	git init preferred-pack-with-existing &&
     +	(
    -+		cd repo &&
    ++		cd preferred-pack-with-existing &&
     +
     +		test_commit base &&
     +		test_commit other &&
    @@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'graceful fallback when missi
     +		p2="$(git pack-objects "$objdir/pack/pack" \
     +			--delta-base-offset <p2.objects)" &&
     +
    -+		# Generate a MIDX containing the first two packs, marking p1 as
    -+		# preferred, and ensure that it can be successfully cloned.
    ++		# Generate a MIDX containing the first two packs,
    ++		# marking p1 as preferred, and ensure that it can be
    ++		# successfully cloned.
     +		git multi-pack-index write --bitmap \
     +			--preferred-pack="pack-$p1.pack" &&
     +		test_path_is_file $midx &&
     +		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
     +		git clone --no-local . clone1 &&
     +
    -+		# Then generate a new pack which sorts ahead of any existing
    -+		# pack (by tweaking the pack prefix).
    ++		# Then generate a new pack which sorts ahead of any
    ++		# existing pack (by tweaking the pack prefix).
     +		test_commit foo &&
     +		git pack-objects --all --unpacked $objdir/pack/pack0 &&
     +
    -+		# Generate a new MIDX which changes the preferred pack to a pack
    -+		# contained in the existing MIDX, such that not all objects from
    -+		# p2 that appear in the MIDX had their copy selected from p2.
    ++		# Generate a new MIDX which changes the preferred pack
    ++		# to a pack contained in the existing MIDX, such that
    ++		# not all objects from p2 that appear in the MIDX had
    ++		# their copy selected from p2.
     +		git multi-pack-index write --bitmap \
     +			--preferred-pack="pack-$p2.pack" &&
     +		test_path_is_file $midx &&
     +		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
     +
    ++		# When the above circumstances are met, an existing bug
    ++		# in the MIDX machinery will cause the reverse index to
    ++		# be read incorrectly, resulting in failed clones (among
    ++		# other things).
     +		test_must_fail git clone --no-local . clone2
     +	)
     +'
2:  053045db14 = 2:  d6648ed88f t/lib-bitmap.sh: avoid silencing stderr
3:  2df8f1e884 = 3:  ae2077acb7 midx.c: extract `struct midx_fanout`
4:  92b82c83ea = 4:  2351a9fc27 midx.c: extract `midx_fanout_add_midx_fanout()`
5:  db1c6ea8e5 = 5:  845e1484b4 midx.c: extract `midx_fanout_add_pack_fanout()`
6:  4ddddc959b ! 6:  d301c4d87f midx.c: include preferred pack correctly with existing MIDX
    @@ Commit message
         from a single source. (We could still mark these preferred bits, but
         doing so is redundant and unnecessary).
     
    -    This resolves the bug described in the first patch of this series.
    +    This resolves the bug demonstrated by t5326.174 ("preferred pack change
    +    with existing MIDX bitmap").
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ midx.c: static struct pack_midx_entry *get_sorted_entries(struct multi_pack_inde
     
      ## t/t5326-multi-pack-bitmaps.sh ##
     @@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'preferred pack change with existing MIDX bitmap' '
    + 		git pack-objects --all --unpacked $objdir/pack/pack0 &&
    + 
    + 		# Generate a new MIDX which changes the preferred pack
    +-		# to a pack contained in the existing MIDX, such that
    +-		# not all objects from p2 that appear in the MIDX had
    +-		# their copy selected from p2.
    ++		# to a pack contained in the existing MIDX.
    + 		git multi-pack-index write --bitmap \
    + 			--preferred-pack="pack-$p2.pack" &&
      		test_path_is_file $midx &&
      		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
      
    +-		# When the above circumstances are met, an existing bug
    +-		# in the MIDX machinery will cause the reverse index to
    +-		# be read incorrectly, resulting in failed clones (among
    +-		# other things).
     -		test_must_fail git clone --no-local . clone2
    ++		# When the above circumstances are met, the preferred
    ++		# pack should change appropriately and clones should
    ++		# (still) succeed.
     +		git clone --no-local . clone2
      	)
      '
-:  ---------- > 7:  887ab9485f midx.c: avoid adding preferred objects twice
-- 
2.37.0.1.g1379af2e9d
