Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B69FC433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 00:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5169023B6A
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 00:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbhAWAHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 19:07:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:36042 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbhAWAFt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 19:05:49 -0500
Received: (qmail 15774 invoked by uid 109); 23 Jan 2021 00:04:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 Jan 2021 00:04:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20522 invoked by uid 111); 23 Jan 2021 00:04:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Jan 2021 19:04:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Jan 2021 19:04:55 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] run-command: document use_shell option
Message-ID: <YAtoJ1ooPn9sdoGL@coredump.intra.peff.net>
References: <20210122142137.21161-1-jacob@gitlab.com>
 <20210122142137.21161-2-jacob@gitlab.com>
 <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
 <YAs9pTBsdskC8CPN@coredump.intra.peff.net>
 <xmqqzh1062as.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzh1062as.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 22, 2021 at 02:21:15PM -0800, Junio C Hamano wrote:

> > -	unsigned stdout_to_stderr:1;
> > +	/**
> > +	 * Run the command from argv[0] using a shell (but note that we may
> > +	 * still optimize out the shell call if the command contains no
> > +	 * metacharacters). Note that further arguments to the command in
> > +	 * argv[1], etc, do not need to be shell-quoted.
> > +	 */
> >  	unsigned use_shell:1;
> > +
> > +	unsigned stdout_to_stderr:1;
> 
> Reads well.  Thanks.
> 
> It is curious why "diff" chose to move stdout_to_stderr line around,
> though.

Heh, I also noticed that and tried a few options to no avail (both
patience/histogram, but also diff.indentHeuristic). It is one deletion
and 8 insertions even if it is done the other way:

  + /*
  + ... 6 more lines ...
  + */
  + unsigned use_shell:1;
  +
    unsigned stdout_to_stderr:1;
  - unsigned use_shell:1;

so it may just come down to the order of xdiff parsing the lines.

-Peff
