Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 043591F855
	for <e@80x24.org>; Mon,  1 Aug 2016 21:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbcHAVUI (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 17:20:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47990 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbcHAVUG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 17:20:06 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 969681F855;
	Mon,  1 Aug 2016 21:19:38 +0000 (UTC)
Date:	Mon, 1 Aug 2016 21:19:38 +0000
From:	Eric Wong <e@80x24.org>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Christian Couder <christian.couder@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org,
	dborowitz@google.com, Omar Jarjur <ojarjur@google.com>,
	Harry Lawrence <hazbo@gmx.com>
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160801211938.GA16348@dcvr>
References: <20160729064055.GB25331@x>
 <20160729101011.GA3469@salo>
 <CAP8UFD12Jk0s0HPPWS3CqFcB37gzhzZZi-V0PfqrRhZO4zhHOA@mail.gmail.com>
 <20160801075554.GA22222@starla>
 <20160801085928.lw3ltdksyrjujutu@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160801085928.lw3ltdksyrjujutu@x>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> wrote:
> On Mon, Aug 01, 2016 at 07:55:54AM +0000, Eric Wong wrote:
> > Christian Couder <christian.couder@gmail.com> wrote:
> > > On Fri, Jul 29, 2016 at 12:10 PM, Richard Ipsum
> > > <richard.ipsum@codethink.co.uk> wrote:
> > > > On Thu, Jul 28, 2016 at 11:40:55PM -0700, Josh Triplett wrote:
> > > > [snip]
> > > >>
> > > >> I'd welcome any feedback, whether on the interface and workflow, the
> > > >> internals and collaboration, ideas on presenting diffs of patch series,
> > > >> or anything else.
> > 
> > > > I'm particularly interested in trying to establish a standard for
> > > > storing review data in git. I've got a prototype for doing that[3],
> > > > and an example tool that uses it[4]. The tool is still incomplete/buggy though.

> > I'm not convinced another format/standard is needed besides the
> > email workflow we already use for git and kernel development.
> 
> Not all projects use a patches-by-email workflow, or want to.  To the
> extent that tools and projects use some other workflow, standardizing
> the format they use to store patch reviews (including per-line
> annotations, approvals, test results, etc) seems preferable to having
> each tool use its own custom format.

I think standardizing on email conventions (such as what we
already do with format-patch, request-pull, S-o-b trailers) would
be a step in this direction and a good step to take.

But yeah, I also hope git adopters can somehow be convinced to
also adopt the workflow that built git itself.

> > I also see the reliance on an after-the-fact search engine
> > (which can be tuned/replaced) as philosophically inline with
> > what git does, too, such as not having rename tracking and
> > doing delayed deltafication.
> 
> Storing review data in git doesn't mean it needs to end up in the
> history of the project itself; it can use after-the-fact annotations on
> a commit.

Right.  So on public-inbox.org/git today, one could search for
after-the-fact annotations based on commit titles and maybe
exact commit ID matches.

A future goal might be to get search indexing working on commit
ID substrings.  So finding references to commit
deadbeefcafe01234567890123467890abcdef00 could be done by
searching for "commit deadbeefcafe" or even a shorter ID, and
the following results could still be returned:

  1. commit deadbeefcafe broke my cat feeder
  2. commit deadbeef killed my cow

> > Email also has the advantage of having existing tooling, and
> > being (at least for now) federated without a single point of
> > failure.
> 
> Storing review data in git makes it easy to push and pull it, which can
> provide the basis for a federated system.

Every public-inbox exposed over HTTP(S) is git clonable[1], so
it's possible to push/pull or have developers merge/combine
inboxes with index-only operations.  There's no UI for that,
yet, and having a working tree checked out is inefficient with
300K uncompressed mails...

But there needs to be way to message others about the existence
of new pushes/pull-requests/reviews/etc; including users
unable to clone or host 800M git repos; so that messaging
system might as well be email.



[1] git clone --mirror https://public-inbox.org/git/
    That's not efficient, yet, though, at around 800M when the
    gzipped fast-export dump is around half that:
    https://public-inbox.org/git/20160710034745.GA20270@dcvr.yhbt.net/T/#u
