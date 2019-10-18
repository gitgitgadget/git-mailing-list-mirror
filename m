Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E979A1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 06:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404278AbfJRGCi (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 02:02:38 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53884 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732713AbfJRGCh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 02:02:37 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C7E851F4C0;
        Fri, 18 Oct 2019 02:22:53 +0000 (UTC)
Date:   Fri, 18 Oct 2019 02:22:53 +0000
From:   Eric Wong <e@80x24.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     workflows@vger.kernel.org, git@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191018022253.GA29290@dcvr>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> wrote:
<snip>

> Disadvantages:
> 
> - requires patching git

The bigger disadvantage is this won't work with a historical
patch series (and some folks stay on ancient git).  But maybe
that window for that is only a few years...

The toughest part right now for public-inbox is trying to make
sense of --range-diff (supporting --interdiff would be easy, I
think...).  Also, we've only had --range-diff for a year or
so.

Your proposal would make things 100% easier for public-inbox
to deal with future --range-diff uses, however :)

> - requires a bot to continuously create branches for patchsets sent to
>   mailing lists

Not necessarily, being able to search on commit OIDs would
be pretty handy itself for dealing with --range-diff output
in public-inbox, so there's no real need to actually make
the branch in git.

I also have a parallel solution in the works to make
--range-diff output more amenable for search engines like
public-inbox by adding blob OIDs to its output:

  https://public-inbox.org/git/20191017121045.GA15364@dcvr/
  I shall call myself an "SEO expert" from now on :>

> Thoughts?

Pretty much the same concerns others brought up around exactness
and working on top of cherry-picks.

> PS: Eric Wong described something that comes quite close to this idea, but
> AFAICT without actually recreating commits exactly. I've included the link
> for completeness. [4]

> [4]: https://lore.kernel.org/workflows/20191008003931.y4rc2dp64gbhv5ju@dcvr/

My plan is to work on interdiff support in the next week or so
once bugs are fixed and public-inbox v1.2 is out the door.  Not
sure about range-diff and reverse-mapping blobs -> trees ->
commits, but searching on "git patch-id --stable" output is also
on the table.

PS: Attached patches: I have nothing against using MIME for those,
    (not speaking for anybody else).  public-inbox needs to handle
    those better w.r.t search indexing linkification.  And then
    I found some bugs for --reindex corner cases which I'm still
    working on :x
