Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF73BC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98EAF61038
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243602AbhHZVBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 17:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhHZVBC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 17:01:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7925AC061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:00:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id t19so9107736ejr.8
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1d2o+Nw2KsQzeTaVypWo5wnX24mYknNaGl50SOXOzOk=;
        b=iI+DwYds9MFmCPSQqOgOVKdKMxf8qUJRnNLa32ZWDqHB2r+HW7ctnH43fPVT9C3Y6e
         h2nveLtKkqJIiqqy+LVu+ioqtBNS9SzhahJaugDouK2Jdwru792AFIB8Ewj0HqKKJ+yi
         SBVMPtw1qRu2iUR+5zzz2yqUbPg5c4R5fNDKwCZHea5IzisUDMQejy+4ScQ88qfuERKz
         CvhPH5bR5EdOLV6TerhSM5vg78zcGoFx7ZuNlYcz2r1yLf0ibV3RTOcZ8SQpgHvGn2BN
         0vi8x23zL86KAq2ulUlrBz7GAr/icg7bgA/mBDM1UOabEbPQT7N31Rd4wjUMtIo9b97g
         8kIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1d2o+Nw2KsQzeTaVypWo5wnX24mYknNaGl50SOXOzOk=;
        b=ZkSMzwfhEPNTpod/O+KAQZkMyD415uI0cSe/jgyehTioAazx2Izg0XVIk7BHsBcqvy
         AXWHjsiVAfyghje3qbDNOTZtRrJ8qZvWIbznACrG2b5CoEE7ZozpsbXDP/9SM4IF/vNW
         KFT1Ut7S5MmhZBuftjmjfda0xnqXSUk3txEalSBDDwzcSCl/KSQ8RTF+AoaaBCoGJ4TK
         oGmEY3Lz/3RdPindZ/bQkXmHJHID4svZmxGJf2/8uyp0TZ9/IRDJltB7Qi8F4k/06dbI
         xfAIuZa8v5TGPgMhZvXO5ovmwal2k18ZiBMMuwsLxpc9ACi50BGYXwe29ddizZEkn+ed
         Z+vw==
X-Gm-Message-State: AOAM533eXq+c5sHxmzM6aLx3gmuawqrkpErK971xGdrGhqom9A0W8i8i
        EpzDeVFoptD119sfQmOzMhJp7CWNYoI=
X-Google-Smtp-Source: ABdhPJze5ZBVv6g+GQ+qzh858+qD8gdBap56RhUFxmR/un6L/ke/myHo/kCm2D9GGXRuXjEwOx6wYA==
X-Received: by 2002:a17:906:9388:: with SMTP id l8mr6214610ejx.307.1630011612741;
        Thu, 26 Aug 2021 14:00:12 -0700 (PDT)
Received: from localhost.localdomain (84-236-78-211.pool.digikabel.hu. [84.236.78.211])
        by smtp.gmail.com with ESMTPSA id q14sm1884779ejc.93.2021.08.26.14.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 14:00:12 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/6] Fix GIT_TEST_SPLIT_INDEX
Date:   Thu, 26 Aug 2021 22:59:58 +0200
Message-Id: <20210826210004.672860-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.358.g803110d36e
In-Reply-To: <20210817174938.3009923-1-szeder.dev@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To recap from v1's cover letter:

Running tests with GIT_TEST_SPLIT_INDEX=1 is supposed to turn on the
split index feature and trigger index splitting (mostly) randomly.
Alas, this has been broken for ~2.5 years, and it hasn't triggered any
index splitting since then.

The last patch in this series makes GIT_TEST_SPLIT_INDEX=1 work again,
although it slightly changes its behavior; see its log message for all
the details.

Patches 3 and 4 fix old tests that started to fail because
of this slight behavior change.  Bsides the final fix, patch 4 is the
most interesting in this series.

Patch 5 fixes recent sparse index tests that were introduced while
GIT_TEST_SPLIT_INDEX was broken.

The first two patches are just minor while-at-it test cleanups.


Changes since v1, both in patch 5:
  - Removed a remark about making split and sparse index compatible.
  - Stolle suggested to rebase this patch series on top of topic
    'ds/sparse-index-ignored-files' to avoid merge conflicts in a
    sparse index test.  Well, I didn't do that, but instead I rebased
    this series on top of the merge of master and 86d6ca5886 (t7519:
    rewrite sparse index test, 2021-08-10), and the latter commit:
      - is the one responsible for said merge conflicts, and
      - is at the bottom of 'ds/sparse-index-ignored-files', and could
	be considered more as a followup fix for topic
	'ds/status-with-sparse-index' (already in v2.33.0) than an
	integral part of 'ds/sparse-index-ignored-files'.
    The rest of 'ds/sparse-index-ignored-files' doesn't have any
    conflicts with this patch series that auto-merge couldn't resolve.

SZEDER Gábor (6):
  t1600-index: remove unnecessary redirection
  t1600-index: don't run git commands upstream of a pipe
  t1600-index: disable GIT_TEST_SPLIT_INDEX
  read-cache: look for shared index files next to the index, too
  tests: disable GIT_TEST_SPLIT_INDEX for sparse index tests
  read-cache: fix GIT_TEST_SPLIT_INDEX

 read-cache.c                       | 37 +++++++++++-----
 t/t1091-sparse-checkout-builtin.sh | 25 ++++++-----
 t/t1600-index.sh                   | 13 ++++--
 t/t1700-split-index.sh             | 34 +++++++++++++++
 t/t7519-status-fsmonitor.sh        | 68 ++++++++++++++++--------------
 5 files changed, 121 insertions(+), 56 deletions(-)

Range-diff against v1:
1:  7e1d38d215 = 1:  ab555030cb t1600-index: remove unnecessary redirection
2:  d86c91d26e = 2:  38d350b02d t1600-index: don't run git commands upstream of a pipe
3:  792b6739e5 = 3:  57b5386aee t1600-index: disable GIT_TEST_SPLIT_INDEX
4:  b12467bab7 = 4:  58c444bcd0 read-cache: look for shared index files next to the index, too
5:  51e13df905 ! 5:  24b8b7738c tests: disable GIT_TEST_SPLIT_INDEX for sparse index tests
    @@ Commit message
         by later sanity checks finding that the index is not in fact a sparse
         index.  This indicates that 'git sparse-checkout init --sparse-index'
         lacks some error checking and its tests lack coverage related to split
    -    index, but fixing those issues (let alone making sparse index
    -    comparible with split index) is beyond the scope of this patch series.
    +    index, but fixing those issues is beyond the scope of this patch
    +    series.
     
         [1] https://public-inbox.org/git/48e9c3d6-407a-1843-2d91-22112410e3f8@gmail.com/
     
    @@ t/t7519-status-fsmonitor.sh: check_sparse_index_behavior () {
      }
      
      test_expect_success 'status succeeds with sparse index' '

  I took the liberty to cut the part of the range-diff showing the
  changes of changes to this test, because 86d6ca5886 totally rewrites
  this test, while this patch changes the test's indentation,
  resulting in an unusable range-diff.
  Instead, to show the only relevant change in this patch here is the
  first hunk touching this test with --ignore-all-space from v1:

    @@ -402,6 +402,10 @@ check_sparse_index_behavior () {
     }
    
     test_expect_success 'status succeeds with sparse index' '
    +       (
    +               sane_unset GIT_TEST_SPLIT_INDEX &&
    +               git update-index --no-split-index &&
    +
                    git reset --hard &&
    
                    test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&

  And from v2:

    @@ -399,6 +399,9 @@ check_sparse_index_behavior () {
     }
    
     test_expect_success 'status succeeds with sparse index' '
    +       (
    +               sane_unset GIT_TEST_SPLIT_INDEX &&
    +
                    git clone . full &&
                    git clone . sparse &&
                    git -C sparse sparse-checkout init --cone --sparse-index &&

6:  a5c790e622 = 6:  a43a12b0ce read-cache: fix GIT_TEST_SPLIT_INDEX
-- 
2.33.0.358.g803110d36e

