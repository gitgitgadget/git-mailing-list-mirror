Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F933C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 02:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA6864E2E
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 02:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhBWCZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 21:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhBWCZm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 21:25:42 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C17C061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 18:25:02 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id v206so14876175qkb.3
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 18:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kYBDRCpSDOEAgVE5KmFHQt0aHmfi8ybfjDRAOX5C+IA=;
        b=XItwSfaVXBuiKdA9th/V9x5ir6qtRrfA206kzZl0SMAHyj20963s3x3E03BCDPGued
         6UYSUnKzQ8E6F22BdXiGineNJuBKFvoJdPwYnuZe4cZGPZRO4JZ4jHbFrSUDu1c2yQch
         86BE6vsvossVTWPV103j5y3QlZ3dAGLH9B5ClOOPhDsy5/ZzYdwY+VfqfGV/AsLp42lY
         BvH6qZEt0aMR4O0a4sjylXQkY5zv2GDQvbWDRZfRWrVyrSOdJe4T4pZcPsRHAQqxwO90
         UziNQY470JGNZIdH+fPyVKpAVG9almmgHdDGMlPEnLWY0BnngZak09D9lS0Lyo6sCM6j
         ZYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kYBDRCpSDOEAgVE5KmFHQt0aHmfi8ybfjDRAOX5C+IA=;
        b=de9XrclOUI2zEFBdLk+JyuzhEdIHrAuzY4HtIoKuZ58sOsTZmYXCYraMAkpGL2zf2/
         bhCJoObaMwzLqU17NHfqwK16sFOiPTs2Jb5m5lCAG1qy+U6KvSLPo+6s7VmqgJcA+1rY
         UzNaV2YHHZ60yRsG7gvF75Th/R+8ixbeeFB0NCPPJ85pKpesJWZurnAWfbanZsmxX/QE
         8FHskKgZIP6Y+Wo6CIdhkT+CELUomOe+b8dUWBM9BjKySfiuwdXI5jz68bTgy2alzUC1
         yv573yIJ4o4YLS7s0njvyK6O8qxX/7cB2MQjAIbZlzdOIx7XorWJbh3XBAI/e602vOmS
         kmGw==
X-Gm-Message-State: AOAM533Gx+5ZSCSl7/phSY5o4kG7ZhhECLvGFffbZUonX7zaaSWnA6Tt
        EbEAfc/pWB5mINzI1+BE1N6gCE6UfZjn5bUb
X-Google-Smtp-Source: ABdhPJwjLUwMva3gb2dg3crncFCiTdbfkGMlQBCdyzWTMltyvKpA2JnF9T5Ob04wU+SgcnzYc7QIsg==
X-Received: by 2002:a05:620a:6d2:: with SMTP id 18mr24356702qky.33.1614047101314;
        Mon, 22 Feb 2021 18:25:01 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:29df:918f:599f:2c96])
        by smtp.gmail.com with ESMTPSA id t6sm13712331qkd.127.2021.02.22.18.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 18:25:00 -0800 (PST)
Date:   Mon, 22 Feb 2021 21:24:59 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH v4 0/8] repack: support repacking into a geometric sequence
Message-ID: <cover.1614047097.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611098616.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a very lightly modified version on v3 of mine and Peff's series
to add a new 'git repack --geometric' mode. Almost nothing has changed
since last time, with the exception of:

  - Packs listed over standard input to 'git pack-objects --stdin-packs'
    are sorted in descending mtime order (and objects are strung
    together in pack order as before) so that objects are laid out
    roughly newest-to-oldest in the resulting pack.

  - Swapped the order of two paragraphs in patch 5 to make the perf
    results clearer.

  - Mention '--unpacked' specifically in the documentation for 'git
    repack --geometric'.

  - Typo fixes.

Range-diff is below. It would be good to start merging this down since
we have a release candidate coming up soon, and I'd rather focus future
reviewer efforts on the multi-pack reverse index and bitmaps series
instead of this one.

Jeff King (4):
  p5303: add missing &&-chains
  p5303: measure time to repack with keep
  builtin/pack-objects.c: rewrite honor-pack-keep logic
  packfile: add kept-pack cache for find_kept_pack_entry()

Taylor Blau (4):
  packfile: introduce 'find_kept_pack_entry()'
  revision: learn '--no-kept-objects'
  builtin/pack-objects.c: add '--stdin-packs' option
  builtin/repack.c: add '--geometric' option

 Documentation/git-pack-objects.txt |  10 +
 Documentation/git-repack.txt       |  23 ++
 builtin/pack-objects.c             | 333 ++++++++++++++++++++++++-----
 builtin/repack.c                   | 187 +++++++++++++++-
 object-store.h                     |   5 +
 packfile.c                         |  67 ++++++
 packfile.h                         |   5 +
 revision.c                         |  15 ++
 revision.h                         |   4 +
 t/perf/p5303-many-packs.sh         |  36 +++-
 t/t5300-pack-object.sh             |  97 +++++++++
 t/t6114-keep-packs.sh              |  69 ++++++
 t/t7703-repack-geometric.sh        | 137 ++++++++++++
 13 files changed, 926 insertions(+), 62 deletions(-)
 create mode 100755 t/t6114-keep-packs.sh
 create mode 100755 t/t7703-repack-geometric.sh

Range-diff against v3:
1:  aa94edf39b = 1:  bb674e5119 packfile: introduce 'find_kept_pack_entry()'
2:  82f6b45463 = 2:  c85a915597 revision: learn '--no-kept-objects'
3:  033e4e3f67 ! 3:  649cf9020b builtin/pack-objects.c: add '--stdin-packs' option
    @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
     +	struct packed_git *a = ((const struct string_list_item*)_a)->util;
     +	struct packed_git *b = ((const struct string_list_item*)_b)->util;
     +
    ++	/*
    ++	 * order packs by descending mtime so that objects are laid out
    ++	 * roughly as newest-to-oldest
    ++	 */
     +	if (a->mtime < b->mtime)
    -+		return -1;
    -+	else if (b->mtime < a->mtime)
     +		return 1;
    ++	else if (b->mtime < a->mtime)
    ++		return -1;
     +	else
     +		return 0;
     +}
4:  f9a5faf773 = 4:  6de9f0c52b p5303: add missing &&-chains
5:  181c104a03 ! 5:  94e4f3ee3a p5303: measure time to repack with keep
    @@ Metadata
      ## Commit message ##
         p5303: measure time to repack with keep
     
    -    Add two new tests to measure repack performance. Both test split the
    +    Add two new tests to measure repack performance. Both tests split the
         repository into synthetic "pushes", and then leave the remaining objects
         in a big base pack.
     
    @@ Commit message
           5303.17: repack (1000)                      216.87(490.79+14.57)
           5303.18: repack with kept (1000)            665.63(938.87+15.76)
     
    -    Likewise, the scaling is pretty extreme on --stdin-packs:
    -
    -      5303.7: repack with --stdin-packs (1)       0.01(0.01+0.00)
    -      5303.13: repack with --stdin-packs (50)     3.53(12.07+0.24)
    -      5303.19: repack with --stdin-packs (1000)   195.83(371.82+8.10)
    -
         That's because the code paths around handling .keep files are known to
         scale badly; they look in every single pack file to find each object.
         Our solution to that was to notice that most repos don't have keep
    @@ Commit message
         single .keep, that part of pack-objects slows down again (even if we
         have fewer objects total to look at).
     
    +    Likewise, the scaling is pretty extreme on --stdin-packs (but each
    +    subsequent test is also being asked to do more work):
    +
    +      5303.7: repack with --stdin-packs (1)       0.01(0.01+0.00)
    +      5303.13: repack with --stdin-packs (50)     3.53(12.07+0.24)
    +      5303.19: repack with --stdin-packs (1000)   195.83(371.82+8.10)
    +
         Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
6:  67af143fd1 = 6:  a116587fb2 builtin/pack-objects.c: rewrite honor-pack-keep logic
7:  e9e04b95e7 = 7:  db9f07ec1a packfile: add kept-pack cache for find_kept_pack_entry()
8:  bd492ec142 ! 8:  51f57d5da2 builtin/repack.c: add '--geometric' option
    @@ Documentation/git-repack.txt: depth is 4095.
     +packs determined to need to be combined in order to restore a geometric
     +progression.
     ++
    -+Loose objects are implicitly included in this "roll-up", without respect
    -+to their reachability. This is subject to change in the future. This
    -+option (implying a drastically different repack mode) is not guarenteed
    -+to work with all other combinations of option to `git repack`).
    ++When `--unpacked` is specified, loose objects are implicitly included in
    ++this "roll-up", without respect to their reachability. This is subject
    ++to change in the future. This option (implying a drastically different
    ++repack mode) is not guaranteed to work with all other combinations of
    ++option to `git repack`).
     +
      Configuration
      -------------
-- 
2.30.0.667.g81c0cbc6fd
