Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993461F955
	for <e@80x24.org>; Mon,  1 Aug 2016 07:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbcHAH4r (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 03:56:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37466 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbcHAH4J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 03:56:09 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 446071F71B;
	Mon,  1 Aug 2016 07:55:54 +0000 (UTC)
Date:	Mon, 1 Aug 2016 07:55:54 +0000
From:	Eric Wong <e@80x24.org>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, dborowitz@google.com,
	Omar Jarjur <ojarjur@google.com>,
	Harry Lawrence <hazbo@gmx.com>
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160801075554.GA22222@starla>
References: <20160729064055.GB25331@x>
 <20160729101011.GA3469@salo>
 <CAP8UFD12Jk0s0HPPWS3CqFcB37gzhzZZi-V0PfqrRhZO4zhHOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD12Jk0s0HPPWS3CqFcB37gzhzZZi-V0PfqrRhZO4zhHOA@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> wrote:
> On Fri, Jul 29, 2016 at 12:10 PM, Richard Ipsum
> <richard.ipsum@codethink.co.uk> wrote:
> > On Thu, Jul 28, 2016 at 11:40:55PM -0700, Josh Triplett wrote:
> > [snip]
> >>
> >> I'd welcome any feedback, whether on the interface and workflow, the
> >> internals and collaboration, ideas on presenting diffs of patch series,
> >> or anything else.

> > I'm particularly interested in trying to establish a standard for
> > storing review data in git. I've got a prototype for doing that[3],
> > and an example tool that uses it[4]. The tool is still incomplete/buggy though.
> 
> There is also git-appraise (https://github.com/google/git-appraise)
> written in Go to store code review data in Git.
> It looks like it stores its data in git notes and can be integrated
> with Rust (https://github.com/Nemo157/git-appraise-rs).

I'm not convinced another format/standard is needed besides the
email workflow we already use for git and kernel development.

Rather, better ways to archive/search the emails is desirable.
Fortunately, commit titles are rather unique :)

I started archiving the git ML with public-inbox (which uses git):

  https://public-inbox.org/git/20160710004813.GA20210@dcvr.yhbt.net/T/

It can be easy to search by Subject (commit titles):

  https://public-inbox.org/git/?q=s:%22more+archives+of+this+list%22

Search (currently Xapian) will be tuned to parse things like
filenames and diffs to allow searching within those.  It is
already somewhat email-aware, such as deprioritizing quoted
text; and having a code repository browser with mail archive
integration is in the works.

I also see the reliance on an after-the-fact search engine
(which can be tuned/replaced) as philosophically inline with
what git does, too, such as not having rename tracking and
doing delayed deltafication.

Email also has the advantage of having existing tooling, and
being (at least for now) federated without a single point of
failure.

vger.kernel.org can still be a major point of failure, which is
why the "archives first" approach of public-inbox favors readers
pulling messages over NNTP/HTTP/git (and maybe soon, POP3).
