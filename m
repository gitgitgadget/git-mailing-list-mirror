Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB96C433E9
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 04:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201B3650DF
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 04:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhCPEF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 00:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhCPEFG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 00:05:06 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F8FC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 21:05:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t9so6722261wrn.11
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 21:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dZQyHzgxK2UZnclbp0X453UtNLzBqijIar+Zk5LQ7Qc=;
        b=YjCsO9TQfFAnfq3d1weQUtaR6KKZJpO1tegKQNJmufO/wK1ZHResf73QmfQPCE5Gzi
         aRaJCH4z8UpCPVmyfmxjBhKnNaphHrzAz4aTbsXsUc5USG4zYaqgjGwqTRh0nGHVrtRj
         3AFYwSnIzEfwCnp/tvPEFIfUj4fNtcW7MsOfBWIwIaOym7JlW5cFojFurk1AFC9p1+Iy
         5WZWQmWgFrlU/rwxtxONS5Hl3w9U1RP3KAA8jgirsfxQU7tXOa1A/e/dGwH9Y7GlFTVd
         0GuIXNz49bItc844ffQdfXhpq6uXa5ww6oih3wLpJv6I23/O7bVHTfpKJarknfdaWt4y
         AcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dZQyHzgxK2UZnclbp0X453UtNLzBqijIar+Zk5LQ7Qc=;
        b=f9XuzOwIXmwohx2PjmJ1O+w/rlcIOZKnRIRTFmJhCVGDuCST/mHo+3+lKR0rtB3Zgj
         fhhM1ZGIbWyOElNMtQ57+1sL/0ijGgBXxKdQWkLM2uyQ9NJr6I9RtW56yQfVsEb3LOBy
         9CcXf9lDro9BjujnN5/fqmQqMqoKCaURCRXxbMkYVF3AcXUNJsL45v/r+w4gefawcJHK
         /5gusN/A2q+RIXuVLuQEw/s81gA4UbXDICqVEkmbcZ78RHTr8Qp3bzgsNrZ0fl5l5Z8k
         rlvGrvjgzKJdkYeRgd291T2NsDNiUi+s2Wk2x79u4/nY+e5DgPjq347s7+2h8jwqKTfq
         o3hA==
X-Gm-Message-State: AOAM532++uiXcuEGzZ/GSyPYrehqAAzmr/MhgfNkZe0rP+R0NX+w8obM
        lz6a9pXwRSLOUVu6b+YMdQRCpyqQxYI=
X-Google-Smtp-Source: ABdhPJywmOSSqB/b57F1raXmg0dWUOHQGfn34uISzftKpfbSLFtxc/HoIkagZVYaFUX4NXjAqFfj2w==
X-Received: by 2002:adf:fb91:: with SMTP id a17mr2629523wrr.118.1615867504389;
        Mon, 15 Mar 2021 21:05:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p10sm21845254wrw.33.2021.03.15.21.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 21:05:03 -0700 (PDT)
Message-Id: <pull.905.git.1615867503.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 04:05:00 +0000
Subject: [PATCH 0/2] Declare merge-ort ready for general usage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This tiny series depends on ort-perf-batch-10[1].

If the ort-remainder topic[2] is merged with this series, then the result is
a version of merge-ort ready for general usage. Users can select it by (a)
passing -sort to either git merge or git rebase, or (b) by setting
pull.twohead=ort [3], or (c) by setting GIT_TEST_MERGE_ALGORITHM=ort.

There are still more optimizations that will be submitted for merge-ort, but
folks don't need to wait for all of them to start using it. The version of
merge-ort that comes from merging both these topics will run the testsuite
cleanly under GIT_MERGE_TEST_ALGORITHM=ort, which includes passing every
test that merge-recursive does and passing dozens of tests that
merge-recursive doesn't. merge-ort is also already significantly faster than
merge-recursive when rename detection is involved.

I'll send out a separate email later requesting feedback about what people
would like to see before switching the default from merge-recursive to
merge-ort.

[1]
https://lore.kernel.org/git/pull.853.git.1615674128.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/pull.973.v2.git.git.1615271086.gitgitgadget@gmail.com/
[3] See commit 14c4586c2d ("merge,rebase,revert: select ort or recursive by
config or environment", 2020-11-02)

Elijah Newren (2):
  Revert "merge-ort: ignore the directory rename split conflict for now"
  t6423: mark remaining expected failure under merge-ort as such

 merge-ort.c                         | 13 +------------
 t/t6423-merge-rename-directories.sh |  2 +-
 2 files changed, 2 insertions(+), 13 deletions(-)


base-commit: ac0ba91ce275227f5df8f16fb986308ff88b198b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-905%2Fgitgitgadget%2Fort-readiness-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-905/gitgitgadget/ort-readiness-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/905
-- 
gitgitgadget
