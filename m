Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C92BC77B7A
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 10:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbjFGKkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjFGKkx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 06:40:53 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0CA1BD7
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 03:40:52 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-565ca65e7ffso66995847b3.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686134451; x=1688726451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XJf3/E7YYMJnEGKv7kXK0wUd50/Iz7Jp8Q0PHWftm4w=;
        b=XFyrZGP1UJuA1O/TsHRYOq6MAqPAwEAD2BvPvHYOgBfmXOZyRLCK5RmIdFrN7EAYV8
         UmYVwaX7zxvnLKDXV0jsbdesn7UJ7wsfx2YhSLWjzsIqgjrYPBPhmizIswDSHNtqKZBU
         a9DmygMrSjBBpg7fcrxKsWfY7tvoBoDeL9ouBBgRXX56GbZJcG0wu/owd2TSUbC5issD
         QZSmWy+IlD4UlbxNlHEkxfxu2aGbaokWDKmvo2Q3si73Xl1m3x6ItZS3pEge0vdGx9JX
         XgTBIJzQh85jJNGD7QDyA02Fh48ggT7elMJUL7yIAOPpekIInxHm69crqeUVoebRKkhd
         r0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134451; x=1688726451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJf3/E7YYMJnEGKv7kXK0wUd50/Iz7Jp8Q0PHWftm4w=;
        b=fKHnuGYOc3chVHGFQ+Sq1+hesR8A0/HAKqSwNBbNX1KHqbB5IyF+EvMh1Snoa74xri
         RE9RQ40x4GBXzzhebyEVNGga2QhLaDnbVDn8wbbuzatLp8/OhorYMl5fBcdFuMRAv/fq
         mFRpOoisc45dT8ZcbxQrsGpDnCIscXBNbsfopXifpZv5/4avIecShN1pKckfMO+a3LAB
         rxOYifwLkYVQ9dJvBUCFK2MnEGuXC7rsTRguRXKInEhLIYsCdxDE7BKqS1HWYZrPvx3D
         TLzZLs3DZcsuMIcD9LT7lFOkLFEfOCdmeSBs3ME5DTxKt5HG5ncN+GxIj6T06hL8Seea
         XS/w==
X-Gm-Message-State: AC+VfDwCkcgYrRtMPOkflEDij3FyAydFWkp7POowyrK9+0uCi3AVnnLO
        aKjxTkkcCtKriiUmZD2Q+ILwWzDW1q4nDQgKC1Cn+BW8
X-Google-Smtp-Source: ACHHUZ4bw/Sj/EpmoLyoP79ZM9xf6Ys/h0i1UC8CjPjZanYvVNb6ZTUNO7/VETEtr3oZi5eYbMDUfg==
X-Received: by 2002:a0d:c007:0:b0:565:d3c9:f4f3 with SMTP id b7-20020a0dc007000000b00565d3c9f4f3mr5289849ywd.3.1686134451258;
        Wed, 07 Jun 2023 03:40:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r2-20020a815d02000000b00569ff2d94f6sm651212ywb.19.2023.06.07.03.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:40:50 -0700 (PDT)
Date:   Wed, 7 Jun 2023 06:40:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/16] refs: implement jump lists for packed backend
Message-ID: <cover.1686134440.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a reroll of my series to implement jump (née skip) lists for the
packed refs backend, based on top of the current 'master'.

Nothing substantive has changed since the last version, where review had
stabilized. This version just resolves a couple of merge conflicts with
633390bd08 (Merge branch 'bc/clone-empty-repo-via-protocol-v0',
2023-05-19).

As usual, a range-diff is included below for convenience.

Thanks in advance for a hopefully final look ;-).

Jeff King (5):
  refs.c: rename `ref_filter`
  ref-filter.h: provide `REF_FILTER_INIT`
  ref-filter: clear reachable list pointers after freeing
  ref-filter: add `ref_filter_clear()`
  ref-filter.c: parameterize match functions over patterns

Taylor Blau (11):
  builtin/for-each-ref.c: add `--exclude` option
  refs: plumb `exclude_patterns` argument throughout
  refs/packed-backend.c: refactor `find_reference_location()`
  refs/packed-backend.c: implement jump lists to avoid excluded
    pattern(s)
  refs/packed-backend.c: add trace2 counters for jump list
  revision.h: store hidden refs in a `strvec`
  refs/packed-backend.c: ignore complicated hidden refs rules
  refs.h: let `for_each_namespaced_ref()` take excluded patterns
  builtin/receive-pack.c: avoid enumerating hidden references
  upload-pack.c: avoid enumerating hidden refs where possible
  ls-refs.c: avoid enumerating hidden refs where possible

 Documentation/git-for-each-ref.txt |   6 +
 builtin/branch.c                   |   4 +-
 builtin/for-each-ref.c             |   7 +-
 builtin/receive-pack.c             |   7 +-
 builtin/tag.c                      |   4 +-
 http-backend.c                     |   2 +-
 ls-refs.c                          |   8 +-
 ref-filter.c                       |  63 ++++++--
 ref-filter.h                       |  12 ++
 refs.c                             |  61 ++++----
 refs.h                             |  15 +-
 refs/debug.c                       |   5 +-
 refs/files-backend.c               |   5 +-
 refs/packed-backend.c              | 226 ++++++++++++++++++++++++++---
 refs/refs-internal.h               |   7 +-
 revision.c                         |   4 +-
 revision.h                         |   5 +-
 t/helper/test-reach.c              |   2 +-
 t/helper/test-ref-store.c          |  10 ++
 t/t0041-usage.sh                   |   1 +
 t/t1419-exclude-refs.sh            | 131 +++++++++++++++++
 t/t3402-rebase-merge.sh            |   1 +
 t/t6300-for-each-ref.sh            |  35 +++++
 trace2.h                           |   2 +
 trace2/tr2_ctr.c                   |   5 +
 upload-pack.c                      |  43 ++++--
 26 files changed, 565 insertions(+), 106 deletions(-)
 create mode 100755 t/t1419-exclude-refs.sh

Range-diff against v2:
 1:  6cac42e70e =  1:  afac948f04 refs.c: rename `ref_filter`
 2:  8dda7db738 =  2:  b9336e3b77 ref-filter.h: provide `REF_FILTER_INIT`
 3:  bf21df783d =  3:  fc28b5caaa ref-filter: clear reachable list pointers after freeing
 4:  85ecb70957 =  4:  bc5356fe4b ref-filter: add `ref_filter_clear()`
 5:  385890b459 =  5:  1988ca4c0a ref-filter.c: parameterize match functions over patterns
 6:  1a3371a0a7 =  6:  60d85aa4ad builtin/for-each-ref.c: add `--exclude` option
 7:  aa05549b6e =  7:  c4fe9a1893 refs: plumb `exclude_patterns` argument throughout
 8:  6002c568b5 =  8:  9cab5e0699 refs/packed-backend.c: refactor `find_reference_location()`
 9:  8c78f49a8d =  9:  8066858bf5 refs/packed-backend.c: implement jump lists to avoid excluded pattern(s)
10:  5059f5dd42 = 10:  3c045076a9 refs/packed-backend.c: add trace2 counters for jump list
11:  f765b50a84 = 11:  0ff542eaef revision.h: store hidden refs in a `strvec`
12:  254bcc4361 = 12:  ca006b2c3f refs/packed-backend.c: ignore complicated hidden refs rules
13:  50e7df7dc0 ! 13:  cae703a425 refs.h: let `for_each_namespaced_ref()` take excluded patterns
    @@ upload-pack.c: void upload_pack(const int advertise_refs, const int stateless_rp
      		head_ref_namespaced(send_ref, &data);
     -		for_each_namespaced_ref(send_ref, &data);
     +		for_each_namespaced_ref(NULL, send_ref, &data);
    - 		/*
    - 		 * fflush stdout before calling advertise_shallow_grafts because send_ref
    - 		 * uses stdio.
    + 		if (!data.sent_capabilities) {
    + 			const char *refname = "capabilities^{}";
    + 			write_v0_ref(&data, refname, refname, null_oid());
     @@ upload-pack.c: void upload_pack(const int advertise_refs, const int stateless_rpc,
      		packet_flush(1);
      	} else {
14:  f6a3a5a6ba = 14:  1db10b76ea builtin/receive-pack.c: avoid enumerating hidden references
15:  2331fa7a4d ! 15:  014243ebe6 upload-pack.c: avoid enumerating hidden refs where possible
    @@ upload-pack.c: void upload_pack(const int advertise_refs, const int stateless_rp
      		head_ref_namespaced(send_ref, &data);
     -		for_each_namespaced_ref(NULL, send_ref, &data);
     +		for_each_namespaced_ref_1(send_ref, &data);
    - 		/*
    - 		 * fflush stdout before calling advertise_shallow_grafts because send_ref
    - 		 * uses stdio.
    + 		if (!data.sent_capabilities) {
    + 			const char *refname = "capabilities^{}";
    + 			write_v0_ref(&data, refname, refname, null_oid());
     @@ upload-pack.c: void upload_pack(const int advertise_refs, const int stateless_rpc,
      		packet_flush(1);
      	} else {
16:  2c6b89d64a = 16:  e02fe93379 ls-refs.c: avoid enumerating hidden refs where possible
-- 
2.41.0.16.g26cd413590
