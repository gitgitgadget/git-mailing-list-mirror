Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135E7C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 22:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D4D24656
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 22:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgANWI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 17:08:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:36642 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726491AbgANWI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 17:08:27 -0500
Received: (qmail 10540 invoked by uid 109); 14 Jan 2020 22:08:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Jan 2020 22:08:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25693 invoked by uid 111); 14 Jan 2020 22:14:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jan 2020 17:14:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Jan 2020 17:08:26 -0500
From:   Jeff King <peff@peff.net>
To:     1234dev <1234dev@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Can Git repos be hacked or otherwise manipulated?
Message-ID: <20200114220826.GB3957260@coredump.intra.peff.net>
References: <fOv65WlolaWZ638trkwZ6nnWIaRu14wx8bYkLdqzidlHPvhYpg1f6TSa_Z7w7iFEsXSLkMzQ6EYTwo3ggF3oXrDh5U4LM_i2Rzx0BkMh7zI=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fOv65WlolaWZ638trkwZ6nnWIaRu14wx8bYkLdqzidlHPvhYpg1f6TSa_Z7w7iFEsXSLkMzQ6EYTwo3ggF3oXrDh5U4LM_i2Rzx0BkMh7zI=@protonmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 14, 2020 at 02:48:05PM +0000, 1234dev wrote:

> Let's say you're working with a team of elite hackers, passing a
> tarball of a Git repo back and forth as you complete your mission. Now
> let's say one of them has malicious intent. What are the possibilities
> that he or she can, for instance, hide changes made to a script or
> binary that does something malicious if executed? Or perhaps maybe
> there are other such scenarios one should be made aware of?

It is absolutely not safe to run Git commands from a tarball of an
untrusted repo. There are many ways to execute arbitrary code specified
by a config option, and you'd be getting recipients .git/config.
Likewise for hooks.

And while we would consider it a bug if you can trigger a memory error
by reading a corrupted or malicious on-disk file, that's gotten _way_
less auditing than the code paths which take in objects from a remote.
So e.g., I would not be surprised if there are vulnerabilities that
could cause out-of-bounds reads of a corrupted .git/index.

-Peff
