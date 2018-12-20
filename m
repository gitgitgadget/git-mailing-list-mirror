Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D378F1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 17:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbeLTRc3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 12:32:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:47110 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387479AbeLTRc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 12:32:29 -0500
Received: (qmail 8038 invoked by uid 109); 20 Dec 2018 17:32:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Dec 2018 17:32:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3009 invoked by uid 111); 20 Dec 2018 17:31:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Dec 2018 12:31:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2018 12:32:05 -0500
Date:   Thu, 20 Dec 2018 12:32:05 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] diff: add support for reading files literally with
 --no-index
Message-ID: <20181220173204.GC6684@sigill.intra.peff.net>
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
 <CACsJy8CScTBbYJt_LLp-rBdmJubEQOZqkPQeszzax9YpbCPUkg@mail.gmail.com>
 <20181220171725.GB6684@sigill.intra.peff.net>
 <CACsJy8AFwSgL-YAc2YU2XfqKFkXf-W+2V7tMy3ZOYvm_zhv5Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AFwSgL-YAc2YU2XfqKFkXf-W+2V7tMy3ZOYvm_zhv5Bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 06:23:42PM +0100, Duy Nguyen wrote:

> On Thu, Dec 20, 2018 at 6:18 PM Jeff King <peff@peff.net> wrote:
> > > I wonder if --follow-symlinks would be a good alternative for this
> > > (then if the final destination is unmmapable then we just read the
> > > file whole in memory without the user asking, so it will work with
> > > pipes). --follow-symlinks then could be made work with non-"no-index"
> > > case too. But --literally is also ok.
> >
> > It's more than symlinks, though. Reading from a named pipe, we'd want to
> > see the actual contents with --literally (and not "oops, I don't know
> > how to represent a named pipe").
> 
> Yes, but I think at least --no-index it makes sense to just fall back
> to read() if we can't mmap(). mmap is more of an optimization than a
> requirement. There's no loss going from "oops I don't know how to
> represent it" to "here's the content from whatever what that device
> is". Symlinks are different because we have two possible
> representations and the user should choose.

Oh, I see. I misread your paragraph. Yeah, I think that is the behavior
I would want by default, too, though the previous thread makes me thing
some people would literally rather have the "I can't represent this"
behavior (because they really do want a diff that can reconstruct the
filesystem state, and an error if not).

-Peff
