Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4AC41F404
	for <e@80x24.org>; Fri,  9 Mar 2018 13:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbeCINX5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 08:23:57 -0500
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:48460 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751086AbeCINX4 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Mar 2018 08:23:56 -0500
Received: from [194.72.166.2] (helo=bokrug.cam.docker.com)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <ijc@hellion.org.uk>)
        id 1euI02-0003Zp-NP; Fri, 09 Mar 2018 13:23:54 +0000
Message-ID: <1520601834.2474.27.camel@hellion.org.uk>
Subject: Re: How to use filter-branch with --state-branch?
From:   Ian Campbell <ijc@hellion.org.uk>
To:     Michele Locati <michele@locati.it>
Cc:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Date:   Fri, 09 Mar 2018 13:23:54 +0000
In-Reply-To: <CAGen01hYG40jKQSu7ZJpb8TXROC74NfVXVT82wNjYqx1yKYD=w@mail.gmail.com>
References: <P56D58$52E406B139FE9D3C295CB5ABAB5C8893@locati.it>
         <87zi3inckw.fsf@evledraar.gmail.com>
         <1520502026.23648.29.camel@hellion.org.uk>
         <CAGen01hYG40jKQSu7ZJpb8TXROC74NfVXVT82wNjYqx1yKYD=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2018-03-09 at 14:04 +0100, Michele Locati wrote:
> Just a couple of questions:
> 
> 1. it seems to me it's not possible to process all the branches in one
> go. Am I right?

I'm not sure, I've never done such a thing, in fact I didn't know you
could.

Really all this feature does is record the `.git/rewrite-map` (or
whatever the correct name is) at the end of the rewrite and reinstate
it again the next time, so it shouldn't really interact with many of
the other options.

My method for storeing "last version processed" in a branch does
conflict I suppose (since that branch would be rewritten) but that's an
artefact of the surrounding scaffolding -- you could equally well keep
the record in some file on the local system or in a non-branch-ish ref
(I guess).

> 2. Why do you have this line in filter.sh?
> `rm -f .git/refs/original/refs/heads/${UPSTREAM_REWRITTEN}`

TBH I'm not really sure. I originally wrote this patch many years ago,
it's just recently that I got around to upstreaming, so my memory is
more fuzzy than might be expected.

I think perhaps I was trying to avoid this error:

    A previous backup already exists in $orig_namespace
    Force overwriting the backup with -f"

which comes if there is an existing backup (a safety feature in the
non-incremental case).

Note quite sure why I didn't use `-f` as the message says, but I guess
because it forces other things too which I didn't want to do?

Perhaps what I should have done is make that check conditional on the
use of --state-branch.

I wonder if you could use the `original/refs/...` as the "last version
processed"? Would be a lot less manual messing around than what I do!

Ian.
