Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CF2C433B4
	for <git@archiver.kernel.org>; Sat,  1 May 2021 14:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50CC761494
	for <git@archiver.kernel.org>; Sat,  1 May 2021 14:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhEAODL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 10:03:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:42010 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231876AbhEAODL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 10:03:11 -0400
Received: (qmail 26362 invoked by uid 109); 1 May 2021 14:02:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 May 2021 14:02:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9977 invoked by uid 111); 1 May 2021 14:02:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 May 2021 10:02:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 May 2021 10:02:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Yiyuan guo <yguoaz@gmail.com>
Subject: [PATCH 0/5] pack-objects: better handling of negative options
Message-ID: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a few problems discussed on the security list, but I
don't think the security implications are that interesting (an attacker
would need to control config or command-line options, which are already
pretty dangerous, and can mostly just cause the process to abort). But
still worth addressing.

Patches 3 and 5 are the interesting ones. The rest are just cleaning up
or improving test coverage.

  [1/5]: t5300: modernize basic tests
  [2/5]: t5300: check that we produced expected number of deltas
  [3/5]: pack-objects: clamp negative window size to 0
  [4/5]: t5316: check behavior of pack-objects --depth=0
  [5/5]: pack-objects: clamp negative depth to 0

 builtin/pack-objects.c      |   4 +
 t/t5300-pack-object.sh      | 265 +++++++++++++++---------------------
 t/t5316-pack-delta-depth.sh |  15 ++
 3 files changed, 126 insertions(+), 158 deletions(-)

-Peff
