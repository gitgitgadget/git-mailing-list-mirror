Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7719CC55181
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37BE6207FC
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=klerks-biz.20150623.gappssmtp.com header.i=@klerks-biz.20150623.gappssmtp.com header.b="Bk6mpArg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgDTVSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726021AbgDTVSy (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 17:18:54 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1C6C061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:18:53 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id q9so2831429otf.5
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=9pRMBdA9edS6ZZlnzM1qgN0NJ2KmX0WCLvH646YmZe0=;
        b=Bk6mpArgoAbu7LGB5bHtTdoC9yNR9+61MP1Qu2aaaYc2dFYFtQRV8JDbEnhf0Zvl39
         qdloCMwDcxYiNRlGhI0TUWdRsrRoZj2Q0+sWekgxfIvEcdfyi4FiHobTCNhP6NjqS2SZ
         SH+AnvgflL5UcqBWrlH+p65UoIvxq5mM7AARXajqdXBAHhpSoFLuDtVlTNjNzxsEoR81
         YmFErSQ4OG3UomFmf3LRk6BOjZpsItijDxaYuRbqvaPzNus6mZeh2hdsTg+Z0FcglY6/
         MZ8bNBB/erQGqVNN2r+K6B4AyEgFJYqr5CcdlOcURaucL2g3cKxDsRNCc5rhtqq0k/8f
         Jdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9pRMBdA9edS6ZZlnzM1qgN0NJ2KmX0WCLvH646YmZe0=;
        b=KP/goYtvsjn2AFoXVyEAsowe0ICBfkZ7OAQz2At3vFJ9uri6T0NLkKcbHOkWvqT7V2
         uowV5Mk48jpq1hGGmXXBb8v/hB7eAlwI69pr+kOcG3U4XFzs1x1BYeG+XDXTsBOQM5EA
         gLouzVZnK0d+n5TYB3vFY4cc2KNocHG8xs2p4KPyZ4+/LV4XfNPdSBgVnxMtJpPt5BC6
         /kLmk3P+wo5Vph60gcdvNVmg3VrScx4tQqCV63A6uq9J2i52o1tRhpAMh5wtkKit0AsF
         YhtT1EutDUFK+FqtL/qpUtpkffywgXC2tqYSZPTtP4480vkB8XHpxybPcdcmKOj9pwQ6
         SGMg==
X-Gm-Message-State: AGi0PuZxb4+8wbSPLc3aI3ZOAqiImCG7JZQGMHVxaJpSpjJaY92EVOZr
        Jtjiqf9CdlTWllNm4+sZnoSytXlI2BJl/+RyhIaD8Kzf922Vdg==
X-Google-Smtp-Source: APiQypI5BSzdquerIyRX9DeUDzdFs24miE2yCYiK9Dp70/Jmobz6G8gqycxPcTks6wmm4BrQE1+bkr5A2KJkjnzG0gk=
X-Received: by 2002:a9d:3a45:: with SMTP id j63mr10329222otc.71.1587417531489;
 Mon, 20 Apr 2020 14:18:51 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 20 Apr 2020 23:18:40 +0200
Message-ID: <CAPMMpoimeOB7-ZTbApMuvA=n6QxFtW_E80gy8Y60CU8EduZc6Q@mail.gmail.com>
Subject: Git and sparse-checkout on large monorepos - hiding irrelevant
 changes for a sparse-checkout specification?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I posted an "Is this possible?" question on stackoverflow
(https://stackoverflow.com/q/61326025/74296) and was pointed here.

I understand from recent updates that there is increasing built-in
support for large files and large repos, between some of the older
capabilities (sparse checkout in general and shallow clone), and the
newer ones (partial-clone and git-sparse-checkout).

I'm playing with a large repo, and finding some "rough edges" around
large diffs (eg 200,000 files "added" in the "initial" commits of
shallow clones).

I was hoping these could be smoothed out when using sparse checkout
(where each user would only see say 30,000 of those 200,000 files),
but can't figure out a way to easily & consistently apply the
.git/info/sparse-checkout specification to tools like git-diff and
git-log (across many users with some semblance of consistency).

Is this something that is or is expected to be supported at some point?

While I'm asking, I have two less-important questions:

1) Are there any plans to support a filter along the lines of "keep
blobs used for commits since date X handy"? I know I can do a shallow
clone, then turn on filtering/promisors, and then unshallow, but then
later fetches don't bring in binaries - a mode that provides this
"full commit history but recent blobs only" might be nice? (I imagine
that's probably non-trivial, because the filters are probably based on
properties of the blobs themselves... but one can dream?)

2) Is there a target date for when git-sparse-checkout will become
non-experimental?

Thanks for any help, my apologies if my questions are too forward.

Best regards,
Tao Klerks
