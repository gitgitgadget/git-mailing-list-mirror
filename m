Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDA1C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 22:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0093161107
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 22:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhDSWe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 18:34:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42673 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230029AbhDSWe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 18:34:57 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13JMYHrc003947
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 18:34:18 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C080B15C3B0D; Mon, 19 Apr 2021 18:34:17 -0400 (EDT)
Date:   Mon, 19 Apr 2021 18:34:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        patchwork@lists.ozlabs.org
Subject: Re: Pain points in Git's patch flow
Message-ID: <YH4FaQRB/vWOI9aI@mit.edu>
References: <YHaIBvl6Mf7ztJB3@google.com>
 <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com>
 <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
 <87czuq4r4l.fsf@evledraar.gmail.com>
 <CAHGBnuMedez4SE-4-JwCcR8k=_FRtjgBdBSEJqshQnVceCvGug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHGBnuMedez4SE-4-JwCcR8k=_FRtjgBdBSEJqshQnVceCvGug@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 09:23:14PM +0200, Sebastian Schuberth wrote:
> > That's not inherent with the E-Mail workflow, e.g. Linus on the LKML
> > also pulls from remotes.
> 
> Yeah, I was vaguely aware of this. To me, the question is why "also"?
> Why not *only* pull from remotes? What's the feature gap email patches
> try to close?

Linus mostly pulls from git trees.  The e-mail workflow tends to be
used by maintainers, who are reviewing submissions from their
contributors.  People submitting changes relating to ext4 know to send
it to the linux-ext4 mailing list; people who are submitting changes
to the xfs file system send it to linux-xfs, etc.

> > It does ensure that e.g. if someone submits patches and then deletes
> > their GitHub account the patches are still on the ML.
> 
> Ah, so it's basically just about a backup? That could also be solved
> differently by forking / syncing Git repos.

The primary reason why the kernel uses mailing lists is because code
reviews are fundamentally *discussions*, and people are used to using
inboxes.  Sure, you can have a gerrit server send e-mail notifications
about code reviews, but then you have to reply by going to the gerrit
server (and gerrit really doesn't work well on slow network link such
as those found on airplanes and cruise ships).  I'd say that most
maintainers simply find e-mail reviews to simply be more *convenient*
than using gerrit.  And over time, we've used other tools to track
metadata over the status of a patch, such as patchwork, which are
optional.

> > I just wanted to help bridge the gap between the distributed E-Mail v.s
> > centralized website flow.
> 
> Maybe, instead of jumping into something like an email vs Gerrit
> discussion, what would help is to get back one step and gather the
> abstract requirements. Then, with a fresh and unbiased mind, look at
> all the tools and infrastructure out there that are able to fulfill
> the needs, and then make a choice.

I'll note that the kernel folks have done this, starting with a 2019
Kernel Summit talk at the Linux Plumbers Conference in Lisbon.  A
description of the follow-up discussions from that talk can be found
here:

	https://lwn.net/Articles/803619/

There was a collection of requirements on a thread on the newly
created workflows@vger.kernel.org mailing list.  This has led to a
number of proposals to make improvements to git, public-inbox,
patchwork, the kernel.org infrastructures, etc., some of which were
funded by the Linux Foundation last year.

Konstantin Ryabitsev has been driving a large amount of that work, and
one of the things that has come out of that is b4.  (Yes, that's a
Star Trek reference...  https://memory-alpha.fandom.com/wiki/B-4)

  https://people.kernel.org/monsieuricon/introducing-b4-and-patch-attestation

Obviously, this isn't intended to be a solution for everyone, and I'm
sure there are many projects that are happy forcing developers to use,
say, Gerrit, which might be a better solution for them.

However, there are a number of core kernel developers who are
super-allergic to solutions which force users to use web interfaces.
So solutions that have a combination of CLI's as well as web interface
is probably going to be the right approach.  Things like pwclient and
b4 are exciting starting points for improved kernel workflows.

Of course, we've gone a bit farther afield from the original question
which is what should git's development workflows should be.  Given
that git is using some of the kernel.org infrastructures, certainly
some of the kernel workflow tools are options for the git development
community to consider.

One of the advantages of the kernel workflows model is that we don't
force users to use github or gitlab or gerrit, without having to make
a global decision for the entire community.  For example, if some
developers want to start using b4 to download patch series for git,
they could start doing that today.

Cheers,

						- Ted
