Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57FEC2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D0420643
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfLWShe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:37:34 -0500
Received: from ikke.info ([178.21.113.177]:56248 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfLWShe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 13:37:34 -0500
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Dec 2019 13:37:33 EST
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 5C9204400C6; Mon, 23 Dec 2019 19:29:39 +0100 (CET)
Date:   Mon, 23 Dec 2019 19:29:39 +0100
From:   Kevin Daudt <kdaudt@alpinelinux.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Arnaud Bertrand <xda@abalgo.com>, git@vger.kernel.org
Subject: Re: Mismatch meaning between git-diff and git-log for the .. (double
 dot notation) and ... (triple dot notation)
Message-ID: <20191223182939.GB676947@alpha>
Mail-Followup-To: Kevin Daudt <kdaudt@alpinelinux.org>,
        Junio C Hamano <gitster@pobox.com>,
        Arnaud Bertrand <xda@abalgo.com>, git@vger.kernel.org
References: <CAEW0o+gYqWT5u-Tf8aDoMgXaf36Mb-XOApLNs4D+GMVLvsOjxg@mail.gmail.com>
 <xmqqy2v26hu0.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy2v26hu0.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 23, 2019 at 10:02:31AM -0800, Junio C Hamano wrote:
> Please unlearn dot-dot and three-dots when using "git diff", which
> is not about ranges but about comparing two endpoints.  If we were
> reinventing Git today from scratch, we would make "git diff A..B" an
> error.  You can consider it a bug that the command accepts a range
> notation, but this will not change any time soon without a large
> fight to find and fix uses of the syntax in scripts by longtime Git
> users have written over the years.
> 
> Allowing dot-dot on the command line of "git diff", instead of
> diagnosing them as errors and dying, was a stupid mistake we (well,
> mostly Linus, but I am willing to take the blame too) made due to
> laziness when we reused the machinery, which we invented to parse
> the command line of "log" family of commands to specify ranges, to
> parse the command line of "diff", which accidentally ended up
> allowing the syntax for ranges where it shouldn't be allowed.
> 
> And worse yet, since there was only dot-dot and three-dots came much
> later, "git diff A..B" ended up comparing the endpoints A and B,
> because there didn't even A...B notation exist.
> 
> This is not limited to you but any user of modern Git is better off
> to pretend "git diff A..B" does not exist; please unlearn dot-dot
> and three-dots when using "git diff" and you'd be happier.

I agreen that you should not use `A..B`, but what is wrong with
`A...B`? The alternative is a lot more verbose.

git diff $(git merge-base A B) B

Kevin
