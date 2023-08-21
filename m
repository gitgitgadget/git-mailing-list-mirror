Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9B0EE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjHUVoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHUVoA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:44:00 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F429CE
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:43:58 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d7484cfdc11so2186845276.1
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692654237; x=1693259037;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uf2/4MPrcDEoRBqyJtEI2+Cklfjn4GWR1SuBSFacGMU=;
        b=sCx+83Z1nI/wFy0Bq6ytYJXG/X0XMKLqcnNv4qKrd4VWJoDDwSTv8GG+AnCxW3a7Rz
         sBVciwoqzrT/w89djerYzieQssxs34xNpfu9tGeQUfNR8sUjx3rSApJdC3EQZyTUbt5j
         yJCyc45/A6+P7674jwrezT+QRMvMG0ap7KLSr914L9kl6VOiBsZUDUkSXUgurAuRfG9r
         ROaydcCyQJv7fNf775ctvyrTL6CmW6RSoTnkYoZYwGM12Rj5bL5acs9yVAijQ1/H9Ty7
         mSO9MnWbA+Q9bOTUHxOepySjoRtBh1xkL8i8fcUTnMIsQmAAhEu1vVVRDK0JqKzw4/i1
         WJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654237; x=1693259037;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uf2/4MPrcDEoRBqyJtEI2+Cklfjn4GWR1SuBSFacGMU=;
        b=G3uQbJOZXX61EM2PlA60flZzQUiHjB8bmyZ/cVWqOVOIv59iqYcq9uWADb+aV7BSJq
         AW064D++LWbZaRkxSXDFhrFPWjleYx/jK0W+4VRi41iAfA9mSSEKrUlkCRG4TebzFjI9
         0l2lulKNiX07dhu+aDPJduqyGoc91PSxD6IOrOQ2VAXNcwj785bqivYXVqLIq8C34i+5
         8sm6d6eZ+FjfDOsIlY43PyFoCV9RS7SBAhvwfHsoypHJC2eDT5co8f30WAVEvryoBbpU
         r5fC25fSPsoiQp+KlOfmmPo03mcFmsEXD6YeZwP8IRrfzcKjxZnDHqn++A/zVfrCOFkg
         qxKw==
X-Gm-Message-State: AOJu0Yy7upmARWoh8WISJW+KnTqVz4pSgb99G3WgmGz7r2xw8MsTitCb
        bq+wod810BkymDUW3LO+uTCpjReCWjurmJ58S91KoQ==
X-Google-Smtp-Source: AGHT+IG11+iedHc3zeeRDtZ8YJa188f5tWiaPVRZtZVKN8BW6210yGtlBMldB0Wq4FMAHc3LQ3EjiQ==
X-Received: by 2002:a25:ae01:0:b0:d63:1d3b:9416 with SMTP id a1-20020a25ae01000000b00d631d3b9416mr7972386ybj.2.1692654237380;
        Mon, 21 Aug 2023 14:43:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 19-20020a250d13000000b00d13b72fae3esm2063605ybn.2.2023.08.21.14.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:43:57 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:43:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 00/15] bloom: changed-path Bloom filters v2
Message-ID: <cover.1692654233.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series combines the efforts in [1] and [2] to culminate in v2 of
the changed-path Bloom filter format (which uses a bona-fide murmur3
implementation) as well as an efficient upgrade path for repositories
with few non-ASCII paths.

The first seven patches are from [1], and are unchanged from that
version. Most of the remaining patches are from [2], and they have been
modified based on the review therein.

The final patch is new, and avoids leaking memory when the Bloom
subsystem is initialized both in the read- and read/write-cases.

Thanks to Jonathan and Peff who have both helped a great deal in putting
these patches together. And, as always, thanks in advance for your
review!

[1]: https://lore.kernel.org/git/cover.1684790529.git.jonathantanmy@google.com/
[2]: https://lore.kernel.org/git/cover.1691426160.git.me@ttaylorr.com/

Jonathan Tan (4):
  gitformat-commit-graph: describe version 2 of BDAT
  t4216: test changed path filters with high bit paths
  repo-settings: introduce commitgraph.changedPathsVersion
  commit-graph: new filter ver. that fixes murmur3

Taylor Blau (11):
  t/helper/test-read-graph.c: extract `dump_graph_info()`
  bloom.h: make `load_bloom_filter_from_graph()` public
  t/helper/test-read-graph: implement `bloom-filters` mode
  bloom: annotate filters with hash version
  bloom: prepare to discard incompatible Bloom filters
  t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
  commit-graph.c: unconditionally load Bloom filters
  commit-graph: drop unnecessary `graph_read_bloom_data_context`
  object.h: fix mis-aligned flag bits table
  commit-graph: reuse existing Bloom filters where possible
  bloom: introduce `deinit_bloom_filters()`

 Documentation/config/commitgraph.txt     |  26 ++-
 Documentation/gitformat-commit-graph.txt |   9 +-
 bloom.c                                  | 208 +++++++++++++++++++++--
 bloom.h                                  |  38 ++++-
 commit-graph.c                           |  36 +++-
 object.h                                 |   3 +-
 oss-fuzz/fuzz-commit-graph.c             |   2 +-
 repo-settings.c                          |   6 +-
 repository.h                             |   2 +-
 t/helper/test-bloom.c                    |   9 +-
 t/helper/test-read-graph.c               |  67 ++++++--
 t/t0095-bloom.sh                         |   8 +
 t/t4216-log-bloom.sh                     | 184 +++++++++++++++++++-
 13 files changed, 548 insertions(+), 50 deletions(-)

-- 
2.42.0.4.g52b49bb434
