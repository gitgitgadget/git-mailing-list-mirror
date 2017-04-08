Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE58E20970
	for <e@80x24.org>; Sat,  8 Apr 2017 17:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbdDHR3n convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 8 Apr 2017 13:29:43 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:38068 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbdDHR2h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 13:28:37 -0400
Received: from [192.168.42.152] (dslb-188-102-145-188.188.102.pools.vodafone-ip.de [188.102.145.188])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id 410F1300074;
        Sat,  8 Apr 2017 19:28:35 +0200 (CEST)
To:     avarab@gmail.com (=?ISO-8859-1?Q?=C6var_Arnfj=F6r=3F_Bjarmason?=)
Cc:     matt@mattmccutchen.net (Matt McCutchen), git@vger.kernel.org (git)
In-Reply-To: <CACBZZX4x0kJVWSkmQa+j6yn-w3m-u8ZiXDPZ60KG+ruvhejqNQ@mail.gmail.com>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Sat, 8 Apr 2017 19:28:35 +0200
Message-ID: <1n46fel.1dbwuj6b61w2oM%lists@haller-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.12.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjör? Bjarmason <avarab@gmail.com> wrote:

> On Sat, Apr 8, 2017 at 5:03 PM, Stefan Haller <lists@haller-berlin.de> wrote:
>
> > Here's a rough proposal for how I would imagine this to work.
> >
> > For every local branch that has a remote tracking branch, git maintains
> > a new config entry branch.*.integrated, which records the sha1 of the
> > last upstream commit that was integrated into the local branch.
> 
> Can you elaborate on what "integrate" means in this context?
> 
> In some ways the entire point of this feature is that you're trying to
> push over history that you don't want to integrate.
> 
> I.e. you're trying to force push your unrelated X over remote history
> A, but not more recent arbitrary history B based on A which someone
> may have just pushed.
> 
> I'm having a hard time imagining how anything merge/rebase/whatever
> would place in branch.*.integrated wouldn't just be a roundabout way
> of recording the info we now record via the tracking branch, or in
> cases where that's auto-updated for some reason having another
> tracking branch as my "[PATCH] push: document & test
> --force-with-lease with multiple remotes" suggests.

It doesn't matter whether the history you are overwriting is arbitrary,
or whether the new history you are pushing is related or unrelated to
what you are overwriting. What matters is whether you are aware of what
you are overwriting.

I want to record all cases where the local branch is brought up to date
with the tracking branch (or vice versa), i.e. mostly push and pull,
because I know that after pushing or pulling, my local branch is up to
date (in some way) with the tracking branch. If I then rewrite the local
branch, I know it is safe to push it *if* the branch on the remote is
still in the same state as what I recorded for last push or pull.

If the tracking branch is updated by fetch though, then my local branch
is not brought up to date with the remote branch, so I may be
overwriting stuff that appeared on the remote without me being aware of
it.

It may well be that there are better names then "integrate"; suggestions
welcome.

Your suggestion to use a second remote doesn't seem like a satisfactory
solution to me, firstly because it's extra work and complexity for the
user, and second because it doesn't solve the problem of working with
more than one local branch (pulling one branch amounts to a fetch for
the other).


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
