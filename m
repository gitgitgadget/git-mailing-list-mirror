Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F542C00528
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 16:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjHGQib (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 12:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjHGQiP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 12:38:15 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492E719B9
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 09:37:46 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-583d63ca1e9so54724407b3.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 09:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691426263; x=1692031063;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3CwGMgIgJy9sIZE5qGhEjpwcopwJ4Vvotd6V12zN2c=;
        b=kDat1Ylk6zNEB6jpfXH8LeouCepyQB7t6/f+3YNC+aC9d3Rsqob6ib3pG0nts2zwEn
         9wxGe4PY1ISSdD8of2mgF5cJyMcIwSFdK02h7D0tsSK25QFq9VYptg8g/SYSDU8YclsL
         1QlI7ZafgWzPcuC8nCwOLdzlOV8Qsopfxk1o12WFKNIvJq8OQrboWSfymKvCs0k5ix62
         QzMSQEf3H8B3DljoS57MnVNt3l62+LHzZwzUST6yquU4Umtxpf1yWUzBRdlRqeAxc0Lf
         dyJpuOhsja+4m4XN9+r+ry1o51ViYrQO9qBWO5AmKz+icDY4Zso2wgWZ2ORdqhlKja9a
         VidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426263; x=1692031063;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3CwGMgIgJy9sIZE5qGhEjpwcopwJ4Vvotd6V12zN2c=;
        b=UbNwLLZjgtYpMz49IERA9OU7AWpQ5rKWQr2rL1TFJju0eJQxn1jNBKVc3kL7fSO/6b
         6tU4kLcyqu4x/vYcDiKlh+1xnQxVxthOCO8jov5O0lRug4juHllGeGGeNj0KX4zL9Wz7
         AJ+C6uy5M0xcM2hRL+Ds13bgvkOthIKbRbMrtTRSGkzNRXfLqWkFwHNuTN+WlUng8/eF
         2ouJGUy6gGnLtBNvDsura42eIATXh2ZVzESg+E/NWuyhmpNenLyd0trAojpq7XJv+GM+
         4nkT6jZR7h/RbzPXSf7IBVotPbLyRyEwwj8GbFaAC7xyLIybbgWg4Zj9MIaVko61GnHN
         W/1A==
X-Gm-Message-State: AOJu0YzX9veWHfOqy9d7FxIm9j6ygtTKQxdRVCdAJKRxC+CY3pQArw0B
        OzHMS1KU5Q42dFM1BVN7CvZ8sUyA7qIElLUv6dtEbQ==
X-Google-Smtp-Source: AGHT+IHx8zeWpTinJSms7lpl4udIm/JcKu54yHjiosMDaVSf/IOHavrlWt26gu8h6j5PJM1BJ5mUGw==
X-Received: by 2002:a81:4e88:0:b0:57a:250:27ec with SMTP id c130-20020a814e88000000b0057a025027ecmr10316506ywb.32.1691426263555;
        Mon, 07 Aug 2023 09:37:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q63-20020a0de742000000b005463e45458bsm2789362ywe.123.2023.08.07.09.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:37:43 -0700 (PDT)
Date:   Mon, 7 Aug 2023 12:37:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 0/6] bloom: reuse existing Bloom filters when possible
 during upgrade
Message-ID: <cover.1691426160.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based off of 'jt/path-filter-fix'.

These few patches implement an idea that we discussed in [1], where we
attempt to reuse existing Bloom filters during an upgrade from v1 to v2
Bloom filters while rewriting the commit-graph.

The core idea is that Bloom filters are reusable when there aren't any
non-ASCII paths in a commit's tree-diff against its first parent (or the
empty tree, if none exists). If we assume that a commit's tree-diff
meets those conditions, we can't conclude anything about whether either
tree contains non-ASCII characters, since they could be unmodified on
either side and thus excluded from the tree-diff.

But assuming the RHS (that there aren't any non-ASCII characters present
in the tree's path set) *does* give us that there aren't any such paths
present in the first-parent tree diff, either.

This series checks whether or not commits meet that criteria, and reuses
the existing Bloom filter (if one exists) when possible. In practice, we
end up visiting relatively few trees, since we mark trees we've already
visited.

On both linux.git and git.git, this series gives a significant speed-up
when upgrading Bloom filters from v1 to v2. On linux.git:

    Benchmark 1: GIT_TEST_UPGRADE_BLOOM_FILTERS=0 git.compile commit-graph write --reachable --changed-paths
      Time (mean ± σ):     124.873 s ±  0.316 s    [User: 124.081 s, System: 0.643 s]
      Range (min … max):   124.621 s … 125.227 s    3 runs

    Benchmark 2: GIT_TEST_UPGRADE_BLOOM_FILTERS=1 git.compile commit-graph write --reachable --changed-paths
      Time (mean ± σ):     79.271 s ±  0.163 s    [User: 74.611 s, System: 4.521 s]
      Range (min … max):   79.112 s … 79.437 s    3 runs

    Summary
      'GIT_TEST_UPGRADE_BLOOM_FILTERS=1 git.compile commit-graph write --reachable --changed-paths' ran
        1.58 ± 0.01 times faster than 'GIT_TEST_UPGRADE_BLOOM_FILTERS=0 git.compile commit-graph write --reachable --changed-paths'

On git.git (where we do have some non-ASCII paths), the change goes from
4.163 seconds to 3.348 seconds, for a 1.24x speed-up.

I'm sending this as an RFC, since we are in the middle of the -rc phase,
and 'jt/path-filter-fix' isn't expected[2] to merge into 'master' until
we're on the other side of 2.42.

The structure of this series is as follows:

  - The first three patches prepare to load the `BDAT` chunk, even when
    the graph's Bloom filter settings are incompatible with the value in
    `commitGraph.changedPathsVersion`.
  - The fourth patch begins loading `BDAT` chunks unconditionally.
  - The fifth patch is a clean-up.
  - The sixth and final patch implements the approach discussed above.

Thanks in advance for your thoughts and review :-).

[1]: https://lore.kernel.org/git/ZMKvsObx+uaKA8zF@nand.local/
[2]: https://lore.kernel.org/git/xmqqy1it6ykm.fsf@gitster.g/

Taylor Blau (6):
  bloom: annotate filters with hash version
  bloom: prepare to discard incompatible Bloom filters
  t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
  commit-graph.c: unconditionally load Bloom filters
  object.h: fix mis-aligned flag bits table
  commit-graph: reuse existing Bloom filters where possible

 bloom.c              | 117 +++++++++++++++++++++++++++++++++++++++++--
 bloom.h              |  22 +++++++-
 commit-graph.c       |  24 +++++----
 object.h             |   3 +-
 t/t4216-log-bloom.sh |  49 ++++++++++++++++--
 5 files changed, 195 insertions(+), 20 deletions(-)

-- 
2.41.0.407.g6d1c33951b
