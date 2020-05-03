Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22208C28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 06:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FDC207DD
	for <git@archiver.kernel.org>; Sun,  3 May 2020 06:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgECGyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 02:54:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:34952 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727026AbgECGys (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 02:54:48 -0400
Received: (qmail 19360 invoked by uid 109); 3 May 2020 06:54:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 May 2020 06:54:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4392 invoked by uid 111); 3 May 2020 06:54:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 03 May 2020 02:54:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 3 May 2020 02:54:46 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Denhartog <ben@sudoforge.com>
Cc:     git@vger.kernel.org
Subject: Re: --no-tags doesn't appear to be working as intended
Message-ID: <20200503065446.GA1829906@coredump.intra.peff.net>
References: <7480e635-97cc-4acd-875e-54bc71a88068@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7480e635-97cc-4acd-875e-54bc71a88068@www.fastmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 02, 2020 at 02:01:35PM -0700, Ben Denhartog wrote:

> # set up the fork
> git -C /tmp/b init
> git -C /tmp/b remote add -f --no-tags upstream file:///tmp/a
> ```
> 
> You'll see the 0.0.1 tag being fetched. You can delete it all you
> want, set the `remote.upstream.tagopt = --no-tags`, etc -- it will
> always be pulled. This is the opposite behavior I would expect based
> on the available documentation and discussion around the tag in the
> mailing list.

I don't see that behavior. I get:

  $ git -C /tmp/b remote add -f --no-tags upstream file:///tmp/a
  Updating upstream
  remote: Enumerating objects: 3, done.
  remote: Counting objects: 100% (3/3), done.
  remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
  Unpacking objects: 100% (3/3), 197 bytes | 197.00 KiB/s, done.
  From file:///tmp/a
   * [new branch]      master     -> upstream/master

Is it possible you have some other config that might be conflicting
(e.g., extra refspecs that ask to transfer tags)? What does "git config
--list --show-origin" say?

-Peff
