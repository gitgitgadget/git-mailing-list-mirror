Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C8DC209FA
	for <e@80x24.org>; Tue, 11 Apr 2017 12:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbdDKMhb (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 08:37:31 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:41218 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752312AbdDKMha (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 08:37:30 -0400
Received: from [10.1.0.219] (nat1.ableton.net [217.110.199.117])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id EFE4730036D;
        Tue, 11 Apr 2017 14:37:27 +0200 (CEST)
To:     jacob.keller@gmail.com (Jacob Keller)
Cc:     peff@peff.net (Jeff King),
        avarab@gmail.com (=?ISO-8859-1?Q?=C6var_Arnfj=F6r=3F_Bjarmason?=),
        matt@mattmccutchen.net (Matt McCutchen),
        git@vger.kernel.org (git), gitster@pobox.com (Junio C Hamano)
In-Reply-To: <CA+P7+xq6MJa-J5cj2Om20d+g7KBretShpxH=13HWV7vFR9be8g@mail.gmail.com>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Tue, 11 Apr 2017 14:37:27 +0200
Message-ID: <1n4blkv.2as01o10f3xkuM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.12.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> wrote:

> On Sun, Apr 9, 2017 at 4:00 AM, Stefan Haller <haller@ableton.com> wrote:
>
> > Maybe I wasn't clear enough about that in my proposal, but I propose to
> > always store the commit hash of the remote tracking branch as a new
> > lease after push and pull, not the local branch. This way it works
> > nicely with pull --rebase and a branch that has extra local commits.
> 
> Oh right. The main thing it doesn't give is that this doesn't enforce
> that your local branch *has* to have at one point prior to the push
> matched the remote branch that you're overwriting, which would be even
> more evidence that your changes are what you expect and aren't
> deleting anything unexpectedly.

I don't think it's a necessary requirement to enforce that the local
branch has to *match* the remote branch (i.e. point at the exact same
commit) prior to beginning a rewindy operation. All that matters is that
the local branch is what I called "up to date" with the remote branch in
earlier messages; a more precise way of saying this is that the remote
branch must either be the same as the local branch, or be reachable from
the local branch (in other words, local branch "contains" the remote
branch but has more commits on top).

If we take the lease after every push and every successful pull, then
this should be guaranteed, as far as I can see. (The "successful" here
is a bit problematic, because if the pull fails with conflicts, then we
need to wait until the next commit (if it was a merge) or the next
"rebase --continue" to be able to tell if it was successful. More on
that in a separate mail later.)


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
