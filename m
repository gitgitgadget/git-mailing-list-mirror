Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAA721F803
	for <e@80x24.org>; Thu, 10 Jan 2019 06:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfAJGRj (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 01:17:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:60316 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725536AbfAJGRj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 01:17:39 -0500
Received: (qmail 676 invoked by uid 109); 10 Jan 2019 06:17:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Jan 2019 06:17:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29096 invoked by uid 111); 10 Jan 2019 06:17:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 Jan 2019 01:17:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jan 2019 01:17:37 -0500
Date:   Thu, 10 Jan 2019 01:17:37 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/11] jk/loose-object-cache sha1/object_id fixups
Message-ID: <20190110061737.GA28000@sigill.intra.peff.net>
References: <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
 <20190107083150.GC21362@sigill.intra.peff.net>
 <b0049722-d019-fd5d-d93d-7b7363b4f244@web.de>
 <xmqqy37v59qz.fsf@gitster-ct.c.googlers.com>
 <20190108180522.GA4610@sigill.intra.peff.net>
 <xmqqmuob58gu.fsf@gitster-ct.c.googlers.com>
 <xmqq8szv56e4.fsf@gitster-ct.c.googlers.com>
 <20190108211632.GB22946@sigill.intra.peff.net>
 <CAGZ79kZzg4_=Go+6btvyygzXOdEJ7VHwNmP+BDqedv+8hqdhCw@mail.gmail.com>
 <CAGZ79kY81WapxeDzytz1vva_j48TDg9vOXrDwkr9uYDx4H-FFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kY81WapxeDzytz1vva_j48TDg9vOXrDwkr9uYDx4H-FFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 09, 2019 at 02:42:28PM -0800, Stefan Beller wrote:

> On Wed, Jan 9, 2019 at 1:37 PM Stefan Beller <sbeller@google.com> wrote:
> >
> > > > Yikes, the conflicts with sb/more-repo-in-api is quite irritating.
> > > > I think I'll postpone the later parts of this series and ask this to
> > > > be sent after sb/more-repo-in-api matures a bit mroe.
> > >
> > > There were several conflicts, but it was mostly just tedious textual
> > > fixups. I pushed the result to:
> > >
> > >   https://github.com/peff/git.git resolve-oid-more-repo
> > >
> > > But I'm happy to wait and rebase if sb/more-repo-in-api is close to
> > > graduating.
> >
> > The merge looks good to me, though I just looked quickly.
> > The series itself is also a pleasant read.
> 
> Compiling this leads to:
> 
> sha1-file.c:1424:33: error: incompatible pointer types passing 'const
> struct object_id *' to parameter of type 'const unsigned char *'
> [-Werror,-Wincompatible-pointer-types]
>         if ((p = has_packed_and_bad(r, repl)) != NULL)
>                                        ^~~~
> ./packfile.h:149:95: note: passing argument to parameter 'sha1' here
> extern const struct packed_git *has_packed_and_bad(struct repository
> *r, const unsigned char *sha1);

Eek, sorry about that. I did the merge on a detached HEAD, and my
config.mak relaxes compilation warnings in that case (since I am often
sight-seeing to old versions that have warnings which have since been
fixed). And the result passes the tests since "repl" and "repl->hash"
are effectively the same pointer.

I've pushed up the fix (s/repl/repl->hash/). Thanks for noticing.

-Peff
