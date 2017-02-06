Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBA711FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 20:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbdBFUsW (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 15:48:22 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:35818 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752477AbdBFUsW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 15:48:22 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id EFA3E1FAFC;
        Mon,  6 Feb 2017 20:48:20 +0000 (UTC)
Date:   Mon, 6 Feb 2017 20:48:20 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: Cross-referencing the Git mailing list archive with their
 corresponding commits in `pu`
Message-ID: <20170206204820.GA7128@starla>
References: <alpine.DEB.2.20.1702041206130.3496@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1702041206130.3496@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> For details, see:
> http://public-inbox.org/git/11340844841342-git-send-email-mailing-lists.git@rawuncut.elitemail.org/
> (this is also an example where public-inbox' thread detection went utterly
> wrong, including way too many mails in the "thread")

Thanks, it should be fixed in an hour or two when reindexing
finishes...

<https://public-inbox.org/meta/20170206200216.GA26676@dcvr/>

but it looks like reindexing is a little buggy in that it reuses
thread IDs, too... (will fix)

The Tor .onion mirrors should be done, first, since they're on
better hardware:
http://hjrcffqmbrq6wope.onion/git/11340844841342-git-send-email-mailing-lists.git@rawuncut.elitemail.org/
http://czquwvybam4bgbro.onion/git/11340844841342-git-send-email-mailing-lists.git@rawuncut.elitemail.org/

> This last example also demonstrates a very curious test case for a
> different difficulty in trying to reconstruct lost correspondences: the
> patch series was applied *twice*, independently of each other. First, on
> the day v3 was submitted, it was applied on top of v1.8.1-rc0 (as commits
> ee26a6e2b8..dd465ce66f), although it was not merged until v1.8.1-rc3. 22
> days later, it was reapplied on top of maint so it could enter v1.8.0.3
> (back then, Git still had "patchlevel" versions): c2999adcd5..008c208c2c.
> 
> As you can see, there is a many-to-many relationship here, even if you do
> leave the *original* branch out of the picture entirely.

Fwiw, I've always seen the search ability of public-inbox as
analogous to rename detection in git; in that it can never be
perfect, but can still be tweaked and improved after-the-fact
and be used more flexibly.

Right now, the thread searching public-inbox is loose in that it
favors overmatching based on Subject in addition to References.
But the actual threading algorithm (for display) is strict,
relying only on References.  But yeah, there can be tweaks to
improve matching and introducing git (code) repository awareness
into the mail search...

> Will keep you posted,

Likewise :>

> P.S.: I used public-inbox.org links instead of commit references to the
> Git repository containing the mailing list archive, because the format of
> said Git repository is so unfavorable that it was determined very quickly
> in a discussion between Patrick Reynolds (GitHub) and myself that it would
> put totally undue burden on GitHub to mirror it there (compare also Carlos
> Nieto's talk at GitMerge titled "Top Ten Worst Repositories to host on
> GitHub").

Any suggestions on how the repository format can be improved?

I haven't hit insurmountable performance problems, even on
low-end hardware; especially since I started storing blob ids in
Xapian itself, avoiding the expensive tree lookup via git.

The main problem seems to be tree size.  Deepening (2/2/36 vs
2/38) might be an option (I think Peff brought that up); but it
might be easier to switch to YYYYMM refs (working like
logrotate) and rely on Xapian to tie the entire thing together.

Some change will definitely be needed for all LKML, but most
projects have less traffic than even git, and should be fine.


But, I am working to undermine centralized messaging systems
(which GitHub and GitLab both are), so they would be wise to
undermine public-inbox all the same ;>
