Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB582C77B71
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 06:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjDRGRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 02:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDRGRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 02:17:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1082117
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 23:17:14 -0700 (PDT)
Received: (qmail 2604 invoked by uid 109); 18 Apr 2023 06:17:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Apr 2023 06:17:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31281 invoked by uid 111); 18 Apr 2023 06:17:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Apr 2023 02:17:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Apr 2023 02:17:13 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH] doc: remove custom callouts format
Message-ID: <20230418061713.GA169940@coredump.intra.peff.net>
References: <20230418011828.47851-1-felipe.contreras@gmail.com>
 <20230418040034.GC60552@coredump.intra.peff.net>
 <643e2aeae0515_217cdb29473@chronos.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <643e2aeae0515_217cdb29473@chronos.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 11:30:18PM -0600, Felipe Contreras wrote:

> If we do this then the parser has no trouble understanding what we are trying
> to do:
> 
>   --- a/Documentation/git-checkout.txt
>   +++ b/Documentation/git-checkout.txt
>   @@ -523,36 +523,37 @@ EXAMPLES
>      the `Makefile` to two revisions back, deletes `hello.c` by
>      mistake, and gets it back from the index.
>    +
>   +--
>    ------------
>    $ git checkout master             <1>
>    $ git checkout master~2 Makefile  <2>
>    $ rm -f hello.c
>    $ git checkout hello.c            <3>
>    ------------
>   -+
>    <1> switch branch
>    <2> take a file out of another commit
>    <3> restore `hello.c` from the index
>   -+

Ah, that makes sense. I tried something like this, but asciidoc was
unhappy with the "+" continuation between the example and the callout
inside the block (which makes sense as there is no "list" to continue
within that block).

Just putting the example and its callouts in a block is sufficient, but
I agree that putting all of the "The following sequence..." list item's
content into a single block makes the source easier to read.

> I don't see why we insist on creating such complex list items though.
> 
> Creating a subsection is much clearer for everyone: the reader, the writer, and
> the parser:

Unless the subsection has a meaningful title, the formatting of the
result looks a bit odd to me:

  EXAMPLES
     1
         The following sequence checks out the master branch, reverts
         the Makefile to two revisions back, deletes hello.c by mistake,
         and gets it back from the index.

as opposed to:

          1. The following sequence checks out the master branch,
             reverts the Makefile to two revisions back, deletes hello.c
             by mistake, and gets it back from the index.

If each example had a short section title, it would make more sense.

At any rate, IMHO it is probably best to start with purely syntactic
fixes that don't change the output, as that is uncontroversial and
addresses the issue with your original patch (which is otherwise making
most spots look nicer). And then any conversation about sections versus
lists can proceed independently.

> > It's probably still worth moving forward with your patch, as I think it
> > takes us in the direction we want long-term (and which builds with
> > asciidoctor are already using). But we may want to pair it with a patch
> > to work around the issue with git-checkout.1 using asciidoc to avoid
> > regressing that section. It may require re-wording or re-organizing to
> > work around the bug.
> 
> I can add that patch depending what we want:
> 
> Open block:
> 
>   1. foo
>   +
>   --
>   bar
> 
>   roo
>   --
> 
> Or subsection:
> 
>   === 1
> 
>   foo
> 
>   bar
> 
>   roo

So I'd prefer the open block.

-Peff
