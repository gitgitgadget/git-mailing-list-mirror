Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5D6C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 14:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F039206D6
	for <git@archiver.kernel.org>; Mon, 11 May 2020 14:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgEKOb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 10:31:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:43324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726173AbgEKOb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 10:31:58 -0400
Received: (qmail 6873 invoked by uid 109); 11 May 2020 14:31:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 May 2020 14:31:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17334 invoked by uid 111); 11 May 2020 14:31:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 May 2020 10:31:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 May 2020 10:31:57 -0400
From:   Jeff King <peff@peff.net>
To:     George Brown <321.george@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
Message-ID: <20200511143157.GA1415@coredump.intra.peff.net>
References: <CAFKec1W0-OOQYypP-3VC=dJnuNDrykdQ2xibc=u4D=Zo6if-+Q@mail.gmail.com>
 <xmqqd07cvl9b.fsf@gitster.c.googlers.com>
 <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
 <xmqq8si0vfp3.fsf@gitster.c.googlers.com>
 <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
 <xmqqwo5ju47t.fsf@gitster.c.googlers.com>
 <CAFKec1Wy1iT8Z=gNDBn++XLxzGWr0UUiu3AKMU-qaR+jj2yoKQ@mail.gmail.com>
 <xmqqo8qvu0ao.fsf@gitster.c.googlers.com>
 <CAFKec1VGzpxVJV4zak46r_p2gGcw4UanFr7U4U4MSsG7t2A23w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFKec1VGzpxVJV4zak46r_p2gGcw4UanFr7U4U4MSsG7t2A23w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 10, 2020 at 07:34:09PM +0100, George Brown wrote:

> Arguably the most interoperable way for "git jump" to work would be to
> output the formatted lines and do nothing else, leaving it to users to
> choose how to operate upon the output/invoke editors. Of course such
> a change would break the workflow of anyone who uses "git jump" today
> and isn't a valid option.

Looks like I missed an exciting thread, but let me add a few thoughts as
the author of git-jump:

 - I had no inkling that people would run it from within vim; I assumed
   they'd use more integrated tools like fugitive.vim. ;) I don't think
   it's wrong to do so, though.

 - The paragraph quoted above is the heart of the matter. The tool does
   two things: generate the list and open the editor. My thinking in
   combining them was that "generate the list" was pretty simple and
   just used existing tools anyway, but we have grown a _bit_ of a
   complexity over the years that might make it worth using.

   IMHO the right solution here is a command-line option to say "don't
   start an editor, just send output". Setting GIT_EDITOR=cat
   accomplishes the same thing, but it's much less obvious/discoverable.

 - I'm pretty sure git-jump does _not_ work with emacs or emacsclient.
   Somebody corresponded with me off-list about patches many years ago,
   but I can't remember what the hold-up was. If anybody is interested
   in pushing that forward, I'd be happy to dig it out my archive.

   However, it should work with gvim, and any isatty() check would
   potentially cause issues there. So I'd much prefer the caller say
   explicitly that they're not expecting the editor to start.

So I'm OK to leave the status quo and let people use the GIT_EDITOR
solution in this instance. But I'd also be happy to take a patch for
"--no-editor" or similar if somebody wants to work it up.

-Peff
