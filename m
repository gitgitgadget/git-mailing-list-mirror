Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8981C83F19
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjH3S3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343741AbjH3QoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E4D1A6
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7ba833ef2aso981596276.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693413839; x=1694018639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XdAS3QYGi+fKqasODiis1gjbo3lIj0N6/HudKFzGUGY=;
        b=drOXSFKlcZd666xCZ/7OIV6H3flK8uY2LNSLud/PeEZ8zZJUC5pVd6ZW+ZYX93K1eg
         mjrs1ZCsAcrB5kJzxa4gEfoJvDM5LI9QH8JfQCOemmwHRTlyaeG5QB7jZ0xfTdA6zA0d
         dCdHGfUdwZq4cBDPXaEiAXZRVXYpiPxl+g9xG6WjfI3SspTa3cMRZu6lY/0CqBLoRY7q
         OjEoCYrYItOFo3eYayOBXig+31WSMXeShPb22h7b9mVCrA3dKGcnMYwiph2q5QAExalA
         +FAKz4NoAquGg9wddF/8trQFefQ3ULmOU97QA5QmM5hwTaHJDvkuBKubY82SqKD4KxGb
         uDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413839; x=1694018639;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XdAS3QYGi+fKqasODiis1gjbo3lIj0N6/HudKFzGUGY=;
        b=GgaR0oQUmYhWUtxsgvd1Jx1GYnAhQMKzm8wZkmO24bSAuxGw9LMMZZtPXSsPwAKooe
         ggWQgSJB3P/9qBGdhSfcH6FbjxSd1nzTLJm0DzTwcQPe8bHSr/6Mw3whMbSkrZS4oFUN
         ksxxTlEl7sq8fXwkoRHVwpcQAh9Cjh3P/1me7jtM2wHCYV4isnRYLcFsjfdj0pSgtaKY
         P2ue4atI9T8OPqWxxT+Qq6tL6tcRnV9kU/iDo9iMcvJQL2+KJnsbjWGZkyLTnBX2DmmK
         lVOokm8jY2RmXD6A4P6xpt6V+yCR3MHpEe798giQvX3ALPnpDrDGcUvcSoe5KgAXID8N
         mCxQ==
X-Gm-Message-State: AOJu0YxqKbJ6vjEILS9GVEBu78mTHUcBpX1hzXUPTVVE0pvgbrfFKSvp
        N+CobUVOyUIcyMgT1KlrgtbU+tzbOqptfG4Sl/Ou9rvlY7mWbVpzUfogwtH43HOrV9Is7/U0hX7
        qlaTQ54GrLov+OZg9aMNLTRFSW8EU7HyseUCl+RolznqOvsbipXZUEq1M3i3eCJKOpe/PZ4GHWG
        Ae
X-Google-Smtp-Source: AGHT+IG64/2Wc7Zl5WpLi3s6PG6r77b6e7Wdrym9hpbIPsN7p5DjavH+H1oXym+ps9f8u1qg2ZBvCUNfm1BS3IhQl4qo
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:2899:32d6:b7e3:8e6e])
 (user=jonathantanmy job=sendgmr) by 2002:a25:d48d:0:b0:cef:90e7:3b36 with
 SMTP id m135-20020a25d48d000000b00cef90e73b36mr74709ybf.12.1693413838841;
 Wed, 30 Aug 2023 09:43:58 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:43:40 -0700
In-Reply-To: <cover.1692654233.git.me@ttaylorr.com>
Mime-Version: 1.0
References: <cover.1692654233.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <cover.1693413637.git.jonathantanmy@google.com>
Subject: [PATCH v2 00/15] bloom: changed-path Bloom filters v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "SZEDER =?utf-8?B?R8OhYm9y?=" <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's an updated patch set containing updates to the tests, making them
run on non-root commits to ensure that we exercise the Bloom filters.
Thanks to SZEDER G=C3=A1bor for spotting this.

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
 t/helper/test-read-graph.c               |  65 +++++--
 t/t0095-bloom.sh                         |   8 +
 t/t4216-log-bloom.sh                     | 202 +++++++++++++++++++++-
 13 files changed, 564 insertions(+), 50 deletions(-)

Range-diff against v1:
 1:  dcfc987741 =3D  1:  dcfc987741 gitformat-commit-graph: describe versio=
n 2 of BDAT
 2:  0c56f2a9e9 =3D  2:  0c56f2a9e9 t/helper/test-read-graph.c: extract `du=
mp_graph_info()`
 3:  8405b845e5 =3D  3:  8405b845e5 bloom.h: make `load_bloom_filter_from_g=
raph()` public
 4:  3a25f90c15 =3D  4:  3a25f90c15 t/helper/test-read-graph: implement `bl=
oom-filters` mode
 5:  e300d338e1 !  5:  7858010665 t4216: test changed path filters with hig=
h bit paths
    @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backfill=
s empty comm
     +	true
     +'
     +
    ++test_expect_success 'setup make another commit' '
    ++	# "git log" does not use Bloom filters for root commits - see how, i=
n
    ++	# revision.c, rev_compare_tree() (the only code path that eventually=
 calls
    ++	# get_bloom_filter()) is only called by try_to_simplify_commit() whe=
n the commit
    ++	# has one parent. Therefore, make another commit so that we perform =
the tests on
    ++	# a non-root commit.
    ++	test_commit -C highbit1 anotherc1 "another$CENT"
    ++'
    ++
     +test_expect_success 'version 1 changed-path used when version 1 reque=
sted' '
     +	(
     +		cd highbit1 &&
    -+		test_bloom_filters_used "-- $CENT"
    ++		test_bloom_filters_used "-- another$CENT"
     +	)
     +'
     +
 6:  6bc665e1d3 =3D  6:  94ad289dbb repo-settings: introduce commitgraph.ch=
angedPathsVersion
 7:  7ef3b2bbbd !  7:  44d3163125 commit-graph: new filter ver. that fixes =
murmur3
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path us=
ed when vers
     +	(
     +		cd highbit1 &&
     +		git config --add commitgraph.changedPathsVersion 2 &&
    -+		test_bloom_filters_not_used "-- $CENT"
    ++		test_bloom_filters_not_used "-- another$CENT"
     +	)
     +'
     +
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path us=
ed when vers
     +	(
     +		cd highbit1 &&
     +		git config --add commitgraph.changedPathsVersion -1 &&
    -+		test_bloom_filters_used "-- $CENT"
    ++		test_bloom_filters_used "-- another$CENT"
     +	)
     +'
     +
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path us=
ed when vers
     +	)
     +'
     +
    ++test_expect_success 'setup make another commit' '
    ++	# "git log" does not use Bloom filters for root commits - see how, i=
n
    ++	# revision.c, rev_compare_tree() (the only code path that eventually=
 calls
    ++	# get_bloom_filter()) is only called by try_to_simplify_commit() whe=
n the commit
    ++	# has one parent. Therefore, make another commit so that we perform =
the tests on
    ++	# a non-root commit.
    ++	test_commit -C highbit2 anotherc2 "another$CENT"
    ++'
    ++
     +test_expect_success 'version 2 changed-path used when version 2 reque=
sted' '
     +	(
     +		cd highbit2 &&
    -+		test_bloom_filters_used "-- $CENT"
    ++		test_bloom_filters_used "-- another$CENT"
     +	)
     +'
     +
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path us=
ed when vers
     +	(
     +		cd highbit2 &&
     +		git config --add commitgraph.changedPathsVersion 1 &&
    -+		test_bloom_filters_not_used "-- $CENT"
    ++		test_bloom_filters_not_used "-- another$CENT"
     +	)
     +'
     +
    @@ t/t4216-log-bloom.sh: test_expect_success 'version 1 changed-path us=
ed when vers
     +	(
     +		cd highbit2 &&
     +		git config --add commitgraph.changedPathsVersion -1 &&
    -+		test_bloom_filters_used "-- $CENT"
    ++		test_bloom_filters_used "-- another$CENT"
     +	)
     +'
     +
 8:  302caee39d =3D  8:  a5bf23a7d3 bloom: annotate filters with hash versi=
on
 9:  d2b0726266 =3D  9:  3de6cd8460 bloom: prepare to discard incompatible =
Bloom filters
10:  9a9992220f =3D 10:  ef04389a0e t/t4216-log-bloom.sh: harden `test_bloo=
m_filters_not_used()`
11:  607945ab05 =3D 11:  e0c1c1ccec commit-graph.c: unconditionally load Bl=
oom filters
12:  e397d83895 =3D 12:  4d57f51854 commit-graph: drop unnecessary `graph_r=
ead_bloom_data_context`
13:  bd3ad6b6c0 =3D 13:  a3b4e7ef59 object.h: fix mis-aligned flag bits tab=
le
14:  2996f0fdb6 =3D 14:  05357f9533 commit-graph: reuse existing Bloom filt=
ers where possible
15:  a3b5b22db0 =3D 15:  58a1d90e6d bloom: introduce `deinit_bloom_filters(=
)`
--=20
2.42.0.rc2.253.gd59a3bf2b4-goog

