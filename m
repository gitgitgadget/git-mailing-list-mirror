Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D9BC04A6A
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 19:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjHHT4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjHHT4a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 15:56:30 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66461B516
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 11:09:43 -0700 (PDT)
Received: (qmail 32382 invoked by uid 109); 8 Aug 2023 18:09:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Aug 2023 18:09:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22584 invoked by uid 111); 8 Aug 2023 18:09:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Aug 2023 14:09:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Aug 2023 14:09:35 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] fix git-send-email with recent versions of
 Term::ReadLine::Gnu
Message-ID: <20230808180935.GA2096901@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using git-send-email with the latest release of Term::ReadLine::Gnu
causes any invocations which prompt more than once to fail. Details are
in the second patch, which fixes it. The first patch cleans up an
obsolete workaround that obscured the root cause of the problem.

The affected version of Term::ReadLine::Gnu is v1.46, which hit Debian
unstable in the past few weeks. So we should consider this for maint
and perhaps even for the -rc candidates, since people will presumably
start running into this more and more.

  [1/2]: send-email: drop FakeTerm hack
  [2/2]: send-email: avoid creating more than one Term::ReadLine object

 git-send-email.perl   | 32 +++++++++++---------------------
 t/t9001-send-email.sh |  5 +++--
 2 files changed, 14 insertions(+), 23 deletions(-)

-Peff
