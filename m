Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D418CC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E0442064C
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgJEIx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:53:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:49434 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgJEIx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:53:27 -0400
Received: (qmail 31352 invoked by uid 109); 5 Oct 2020 08:53:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 08:53:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17529 invoked by uid 111); 5 Oct 2020 08:53:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 04:53:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 04:53:26 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 7/7] fsck: complain when .gitattributes or .gitignore is
 a symlink
Message-ID: <20201005085326.GF2862927@coredump.intra.peff.net>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005072503.GG2291074@coredump.intra.peff.net>
 <20201005081233.GJ1166820@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005081233.GJ1166820@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 05, 2020 at 01:12:33AM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > The previous commit made it impossible to have a symlinked
> > .gitattributes or .gitignore file via verify_path(). Let's add the same
> > check to fsck, which matches how we handle .gitmodules symlinks, via
> > b7b1fca175 (fsck: complain when .gitmodules is a symlink, 2018-05-04).
> >
> > Note that we won't add these to the existing gitmodules block. Its logic
> > is a bit more complicated, as we also check the content of non-symlink
> > instances we find. But for these new files, there is no content check;
> > we're just looking at the name and mode of the tree entry (and we can
> > avoid even the complicated name checks in the common case that the mode
> > doesn't indicate a symlink).
> 
> On the subject of where the check gets added, the old description said
> 
> 	It's easier to handle than .gitmodules, because we don't care
> 	about checking the blob content. This is really just about
> 	whether the name and mode for the tree entry are valid.
> 
> which I think was self-explanatory enough.  The new text is a little
> more confusing because I get lost in figuring out what the "it" in
> "Its" refers to.

I rewrote it because I found your original text confusing. ;)

I'll write "The logic for gitmodules is a bit more complicated...".

-Peff
