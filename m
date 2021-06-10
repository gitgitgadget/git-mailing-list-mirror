Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC2DC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 204BB613FF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhFJMxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 08:53:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:51162 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhFJMxM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 08:53:12 -0400
Received: (qmail 7564 invoked by uid 109); 10 Jun 2021 12:51:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jun 2021 12:51:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29537 invoked by uid 111); 10 Jun 2021 12:51:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Jun 2021 08:51:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Jun 2021 08:51:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] fix union merge with binary files
Message-ID: <YMIKwsEFnkqz6PWa@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This started as an attempt to silence a "gcc -O3" warning. But I was
curious if we could trigger the problem it complains about in practice
(spoiler: we can), so I wrote a test. And it seems there was an even
bigger bug lurking, where we'd generate bogus merge results. :)

This fixes both bugs.

  [1/2]: ll_binary_merge(): handle XDL_MERGE_FAVOR_UNION
  [2/2]: ll_union_merge(): pass name labels to ll_xdl_merge()

 ll-merge.c            |  6 ++++--
 t/t6406-merge-attr.sh | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

-Peff
