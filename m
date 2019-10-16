Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0CF01F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 11:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392613AbfJPLK0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 07:10:26 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:62450 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730377AbfJPLK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 07:10:26 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x9GBA9bk013439;
        Wed, 16 Oct 2019 13:10:09 +0200
Date:   Wed, 16 Oct 2019 13:10:09 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191016111009.GE13154@1wt.eu>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Vegard,

On Wed, Oct 16, 2019 at 12:22:54PM +0200, Vegard Nossum wrote:
> (cross-posted to git, LKML, and the kernel workflows mailing lists.)
> 
> Hi all,
> 
> I've been following Konstantin Ryabitsev's quest for better development
> and communication tools for the kernel [1][2][3], and I would like to
> propose a relatively straightforward idea which I think could bring a
> lot to the table.
> 
> Step 1:
> 
> * git send-email needs to include parent SHA1s and generally all the
>   information needed to perfectly recreate the commit when applied so
>   that all the SHA1s remain the same
> 
> * git am (or an alternative command) needs to recreate the commit
>   perfectly when applied, including applying it to the correct parent
> 
> Having these two will allow a perfect mapping between email and git;
> essentially email just becomes a transport for git. There are a lot of
> advantages to this, particularly that you have a stable way to refer to
> a patch or commit (despite it appearing on a mailing list), and there
> is no need for "changeset IDs" or whatever, since you can just use the
> git SHA1 which is unique, unambiguous, and stable.

I agree this would be great and have been missing this a number of times,
eventhough I'm aware of git-send-pack/git-receive-pack. The text format
is way more convenient for a lot of reasons. It could also help with
Greg's idea of using the commit IDs to reference bugs, as such IDs could
remain stable within a series before it is merged, and as such referenced
in subsequent commit messages. It could also be useful to avoid losing
notes related to a patch once it's merged.

> Step 3:
> 
> * Instead of describing a patchset in a separate introduction email, we
>   can create a merge commit between the parent of the first commit in
>   the series and the last and put the patchset description in the merge
>   commit [5]. This means the patchset description also gets to be part
>   of git history.
> 
>   (This would require support for git send-email/am to be able to send
>   and apply merge commits -- at least those which have the same tree as
>   one of the parents. This is _not_ yet supported in my proposed git
>   patches.)

That's a good idea, as we've all seen long series with a very detailed
description in patch 0 and much less context in subsequent patches, thus
losing the context once merged.

> * stable SHA1s means we can refer to previous versions of a patchset by
>   SHA1 rather than archive links. I propose a new changelog tag for
>   this, maybe "Previous:" or maybe even a full list of "v1:", "v2:",
>   etc. with a SHA1 or ref. Note that these SHA1s do *not* need to exist
>   in Linus's repo, but those who want can pull those branches from the
>   bot-maintained repo on git.kernel.org.

For me this mainly brings the benefit of finally having a unique identifier
for multiple iterations of a patchset. It then becomes easier to use this
identifier to designate the functional work, regardless of the number of
updates it gets. Of course it's never that black and white since such work
may itself merge multiple other patchsets but for most use cases it can
help.

Willy
