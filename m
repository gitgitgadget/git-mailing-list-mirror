Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24AF920437
	for <e@80x24.org>; Thu, 12 Oct 2017 07:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbdJLHQN (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 03:16:13 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:59257 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbdJLHQN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 03:16:13 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:34462 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e2Xj2-0007Ul-CQ; Thu, 12 Oct 2017 03:16:12 -0400
Date:   Thu, 12 Oct 2017 03:16:10 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] doc: emphasize stash "--keep-index" stashes staged
 content
In-Reply-To: <20171012041631.GC155740@aiede.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1710120257450.24121@localhost.localdomain>
References: <alpine.LFD.2.21.1710110443360.11205@localhost.localdomain> <20171012041631.GC155740@aiede.mtv.corp.google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 11 Oct 2017, Jonathan Nieder wrote:

> Hi,
>
> Robert P. J. Day wrote:
>
> > It's not immediately obvious from the man page that the "--keep-index"
> > option still adds the staged content to the stash, so make that
> > abundantly clear.
> >
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> > ---
> >
> > diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> > index 00f95fee1..037144037 100644
> > --- a/Documentation/git-stash.txt
> > +++ b/Documentation/git-stash.txt
> > @@ -68,8 +68,8 @@ entries and working tree files are then rolled back to the state in
> >  HEAD only for these files, too, leaving files that do not match the
> >  pathspec intact.
> >  +
> > -If the `--keep-index` option is used, all changes already added to the
> > -index are left intact.
> > +If the `--keep-index` option is used, all changes already staged in the
> > +index are left intact in the index, while still being added to the stash.
>
> Aside from Junio's note about "in the index" vs "in the working tree":

  yes, that was a good point, i will ponder further.

> The "Testing partial commits" item in the EXAMPLES section explains
> what --keep-index is useful for.  I wonder if some allusion to that
> would make the explanation in the OPTIONS section easier to
> understand.
>
> Something that I end up still curious about when reading this
> description is what will happen when I "git stash pop".  Will it
> apply only the changes that were stashed away and removed from the
> working tree, or will it apply the changes that were kept in the
> index, too? If the latter, why?  Is there some way I can turn that
> behavior off?

  at risk of embarrassing myself, it seems that the simplest way to
explain stashing WRT to those --keep-index and --index options is to
first explain that, regardless of --keep-index with push, stash will
*always* stash all of your changes in the working tree, and will
further distinguish between staged and unstaged content. that's based
on the diagram in the man page:

                  .----W
                 /    /
           -----H----I

so the initial explanation should be that the above *always* happens,
no matter what.

  the next sentence should then say, "if you add --keep-index, then
staged changes are preserved in the working tree and index", or
something like that. but the use of --keep-index does not (unless i'm
reading this incorrectly) in any way affect what is stashed, correct?

  in that same vein, the explanation should then go on to explain that
popping always restores the *entire* stash to the working tree -- all
of it -- and the use of "--index" simply means that the portion of
the stash representing what had been staged will be restaged.

  not to belabour the point, but i think it's important to emphasize
early that --keep-index and --index in no way affect what is stashed,
and what is popped, which i think is a common misunderstanding.

> E.g. in the "Testing partial commits" example, it seems like the
> natural behavior for "git stash pop" would be just restore the
> changes that were removed from the working tree.  That would also
> match an assumption of save/push and pop being symmetrical ('inverse
> operations').
>
> Is this related to "git stash pop --index"?  I notice that the
> EXAMPLES section doesn't give any examples of that option.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
