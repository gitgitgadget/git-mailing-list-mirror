Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FBAC4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 18:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D30B960E0B
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 18:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFWSlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 14:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWSlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 14:41:25 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D806DC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 11:39:06 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id b5so3533831ilc.12
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 11:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7eahv9PuanPnfmcpIzmfFuvrh7v9YuEO26/3FK+Nmew=;
        b=jwJ3yuT3DgJs9cedj6AHGzg7D0qcThKtKQ9o32g41Lnrk8t+oEhOhv4e1ZIw3jJYm8
         LbV8bAbniGyiyUXy0qeVAlCQSui8v6pSj6dfIFa5lUTTdEDzx6bdd50v4kuRU1riWFd9
         fRYPFg2odHbsQ2mmSAcGrCkv/9s8ooE1fgLLNp4lzntVViUZlHz5pwTG8pwaj8+kZ+Hg
         qx1p4HyzmWRpvzMtdoz+eUvskOc+NLVfHYgQH38DBIEuLGTX5ySQqSogU9xrzS/m9WdC
         S02I/VEXB0PPmWcJ4F7jhsQp+p6nR7Pm3/JRWEfiIqqJIuLNiuGOfYzX2tLIJZmt6Q5W
         zxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7eahv9PuanPnfmcpIzmfFuvrh7v9YuEO26/3FK+Nmew=;
        b=lAlGaJn4sYst70kKH9wkwD5NJxjeeYBtr5fNMpv8ekSY0sc8xzwYYfFMF0GHS980kj
         VHYqTSIeyD5vZ6V6vU5QEW6iVMo6LO0spKP2RN4yLn6jOPLPwlmsqGSiuGiAoECpXT/c
         JWgJV1LAlDNoAVVq1Z079PmPLGIU6/nVYs5B92pURWgahgam9YrxlsFHLVxuk1dXZRs6
         aeAa+iETgxMZD3cJvxzR0tfI8UnnujqsJmXRZffRhl02VSSm/Xk8CwFN06Rity3yrGAY
         9mtq+JcKxoM8DBnD3bY9Hjmg6PsFmUUL0LCkkdtNLRscmGKmpIX2JiglMkSNWiNJMKFP
         SMww==
X-Gm-Message-State: AOAM5328FSw4UnZdoJKfTOHW2tkATr5Gd2Pr179XNaz6y/+TsTbwYcxs
        zksaC3HtyoFu+iVvNBspj4o0kq4ltfQSDCnl
X-Google-Smtp-Source: ABdhPJzbfTzDA8ufwzgfduw9Me2qI3/nRf0EA0TOpRB5DvffewLy2+5Nw1IWqnQTWXumKkZdxn7Klg==
X-Received: by 2002:a05:6e02:10c2:: with SMTP id s2mr618522ilj.24.1624473545579;
        Wed, 23 Jun 2021 11:39:05 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:827b:778a:e73b:3ade])
        by smtp.gmail.com with ESMTPSA id s9sm409211ilt.44.2021.06.23.11.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:39:05 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:39:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 0/4] midx: verify MIDX checksum before reusing
Message-ID: <cover.1624473543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a small series that came out of a corruption we noticed at GitHub. The
corruption is described in the third patch, but the gist is this:

  - After writing a MIDX, we experience a disk failure that corrupts the
    contents of the repository's MIDX.

  - We later go to write another MIDX, notice that one is already there, and
    then blindly reuse its data without checking its validity, resulting in a
    MIDX that contains corrupt data, but whose trailing checksum matches the
    preceding contents.

This series checks the validity of the trailing checksum when reusing a MIDX
while writing a new one, as well as a few other related fix-ups. That should be
sufficient to avoid propagating corrupt data forward while writing a MIDX.

We could go further here and run 'git multi-pack-index verify' on the existing
MIDX while writing a new one, but the point of this reuse is to avoid having to
re-compute/verify the contents of an existing MIDX. So a more lightweight option
is pursued here, but alternatives are discussed in 3/4.

Thanks in advance for your review.

Taylor Blau (4):
  csum-file: introduce checksum_valid()
  commit-graph: rewrite to use checksum_valid()
  midx: don't reuse corrupt MIDXs when writing
  midx: report checksum mismatches during 'verify'

 commit-graph.c              | 14 ++++++--------
 csum-file.c                 | 16 ++++++++++++++++
 csum-file.h                 |  3 +++
 midx.c                      | 13 +++++++++++++
 pack-check.c                | 11 +----------
 t/t5319-multi-pack-index.sh | 13 +++++++++++++
 6 files changed, 52 insertions(+), 18 deletions(-)

-- 
2.31.1.163.ga65ce7f831
