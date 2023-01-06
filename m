Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09879C5479D
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 11:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjAFLA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjAFLAx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 06:00:53 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B473E853
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 03:00:51 -0800 (PST)
Received: (qmail 13955 invoked by uid 109); 6 Jan 2023 11:00:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Jan 2023 11:00:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13254 invoked by uid 111); 6 Jan 2023 11:00:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Jan 2023 06:00:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Jan 2023 06:00:50 -0500
From:   Jeff King <peff@peff.net>
To:     Carl Baldwin <carl@ecbaldwin.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/3] fixing "diff --relative" with external diff
Message-ID: <Y7f/YiVu1TgbucDI@coredump.intra.peff.net>
References: <CALiLy7raQsK3j+f6+dpYrEiegvFZRra5F9JwPWu---4h_AR49w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALiLy7raQsK3j+f6+dpYrEiegvFZRra5F9JwPWu---4h_AR49w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 04, 2023 at 03:03:17PM -0700, Carl Baldwin wrote:

> What did you expect to happen? (Expected behavior)
> 
>     When using a diff.external command with --relative, the diff output should
>     show the minor change that I made to the file.
> 
> What happened instead? (Actual behavior)
> 
>     The diff output shows the entire old contents of the file as deleted. The
>     header of the patch looked like this (indent added for this report):

Nice catch, and thank you for a clear reproduction recipe. It looks like
this bug has been lurking since --relative was introduced in 2008. :)

Here's a patch series which fixes it. The first one is the fix itself,
and the other two are some cleanups we can do on top (I almost squashed
them in, but their diffs are rather noisy and make it harder to see the
actual fix).

  [1/3]: diff: use filespec path to set up tempfiles for ext-diff
  [2/3]: diff: clean up external-diff argv setup
  [3/3]: diff: drop "name" parameter from prepare_temp_file()

 diff.c                   | 30 +++++++++++++-----------------
 t/t4045-diff-relative.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 17 deletions(-)

-Peff
