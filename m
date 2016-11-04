Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B84642022D
	for <e@80x24.org>; Fri,  4 Nov 2016 23:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbcKDXqy (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 19:46:54 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:36647 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbcKDXqx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 19:46:53 -0400
Received: from mfilter32-d.gandi.net (mfilter32-d.gandi.net [217.70.178.163])
        by relay5-d.mail.gandi.net (Postfix) with ESMTP id 2F95941C08D;
        Sat,  5 Nov 2016 00:46:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter32-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
        by mfilter32-d.gandi.net (mfilter32-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id uH8Mz0ojanYj; Sat,  5 Nov 2016 00:46:50 +0100 (CET)
X-Originating-IP: 198.233.217.214
Received: from x (unknown [198.233.217.214])
        (Authenticated sender: josh@joshtriplett.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 19A5541C088;
        Sat,  5 Nov 2016 00:46:48 +0100 (CET)
Date:   Fri, 4 Nov 2016 17:46:47 -0600
From:   Josh Triplett <josh@joshtriplett.org>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Regarding "git log" on "git series" metadata
Message-ID: <20161104234647.xjaf7scdjpppfdop@x>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xq0LLFBJRNNvCMQ4QR7XBg9H7NSsifiqOYqr+PUBqYRGQ@mail.gmail.com>
 <20161104194907.3yxu2rkayfyic4dr@sigill.intra.peff.net>
 <20161104215538.xmpth6qfuou6nde6@x>
 <CA+P7+xoKORo6hC2n-E-gHG2OYg3h-m3ZnUQbdopS7S3-5AWoPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xoKORo6hC2n-E-gHG2OYg3h-m3ZnUQbdopS7S3-5AWoPQ@mail.gmail.com>
User-Agent: NeoMutt/20161014 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2016 at 04:37:34PM -0700, Jacob Keller wrote:
> On Fri, Nov 4, 2016 at 2:55 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> > That said, I'd *love* to have gitrefs available, for a wide variety of
> > applications, and I can see an argument for introducing them and waiting
> > a few years for them to become universally available, similar to the
> > process gitlinks went through.
> >
> > But I'd also love to have a backward-compatible solution.
> >
> > - Josh Triplett
> 
> I think that you won't really find a backwards compatible solution
> other than something like automatically generating refs for each point
> of history. I know that gerrit does something like this by storing
> each version in "refs/changes/id/version" or something along those
> lines. I think this might actually be cleaner than your parent links
> hack, and could be used as a fallback for when gitrefs don't work,
> though you'd have to code exactly how to tell what to push to a
> repository when pushing a series?

I'm not sure what the advantage of that would be, and it would mean that
if you ever have one branch without pushing the other(s), you'd get
severe time-delated breakage due to pruning.  (And if you pushed the
series without the other ref(s), its history would look right but then
you couldn't access the underlying versions of the patch series.)

One of my design goals was to *not* need a special "git series push" or
"git series pull"; you should just be able to use git push and git pull,
and you can set up normal refspecs.

That said, I could fairly easily generate the existing format with
artificial parent refs for backward compatibility, and provide a way to
use the new gitref-based storage format if you know that all your
servers and clients can handle it.  I'm also open to other suggestions
for how to make such a transition while still working with every git
server and git client that exists today.
