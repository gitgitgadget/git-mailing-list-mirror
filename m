Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5CB1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 14:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbdAZOqO (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 09:46:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:45345 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752281AbdAZOqO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 09:46:14 -0500
Received: (qmail 5660 invoked by uid 109); 26 Jan 2017 14:46:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 14:46:13 +0000
Received: (qmail 23504 invoked by uid 111); 26 Jan 2017 14:46:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 09:46:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2017 09:46:11 -0500
Date:   Thu, 26 Jan 2017 09:46:11 -0500
From:   Jeff King <peff@peff.net>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, novalis@novalis.org,
        pclouds@gmail.com
Subject: Re: [PATCH] refs: add option core.logAllRefUpdates = always
Message-ID: <20170126144610.7tosfix4v3tah7p2@sigill.intra.peff.net>
References: <20170125213328.meehgxvzuajjgvag@sigill.intra.peff.net>
 <20170126011654.21729-1-cornelius.weig@tngtech.com>
 <20170126011654.21729-2-cornelius.weig@tngtech.com>
 <20170126033547.7bszipvkpi2jb4ad@sigill.intra.peff.net>
 <4faf836a-40b6-da9a-877a-3b2ce7c863df@tngtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4faf836a-40b6-da9a-877a-3b2ce7c863df@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 03:06:40PM +0100, Cornelius Weig wrote:

> > But it works quite by accident. I wonder if we should this
> > "is_bare_repository" check into a function that can be called instead of
> > accessing log_all_ref_updates() directly.
> 
> Are you saying that we should move the `!log_all_ref_updates` check into
> its own function where we should also check `is_bare_repository`? I
> don't see that this would win much, because as you said: checkouts in a
> bare repo are forbidden anyway.

Yes, I'm suggesting making something like the should_autocreate_reflog()
function public.

I agree it is working correctly now. It's just that it's rather subtle
that it treats LOG_REFS_UNSET implicitly as LOG_REFS_NONE.

It would also possibly break if more values are added to the enum
(depending on what those values are).

> However, I realized that I have not written tests about ref updates in a
> bare repository. Do you think it's worthwile?

There should already be a test for logAllRefUpdates=true in a bare
repository (if there isn't, we should probably add one). Testing the
"always" case individually does not add much over testing it in a
non-bare repository. IMHO.

-Peff
