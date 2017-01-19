Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BDF720A17
	for <e@80x24.org>; Thu, 19 Jan 2017 22:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753411AbdASWYE (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 17:24:04 -0500
Received: from mail.nottheoilrig.com ([52.27.13.164]:39856 "EHLO
        mail.nottheoilrig.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbdASWYD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 17:24:03 -0500
Received: from mail.nottheoilrig.com (localhost [127.0.0.1])
        by mail.nottheoilrig.com (Postfix) with ESMTP id 4EEF720293
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 22:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nottheoilrig.com;
        s=3532ada; t=1484863974;
        bh=PmrOCH9I4wzyWImcUYeO3W5eZGAz0LPO/H2AYtLI160=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=tcXOnzPA/91U2LKTZ99I/mZFHmUjDu4Te+up0ABuX0nIsFpXM8xFySSnlJuJbq3Gq
         f3UTNXXxe3DG6hNE+DabR3O2bwgT3iugPc/uP1znfbxJvltRh6rcC4mo0cR5y7u29O
         MV08lmTm0sGHBdUFxVm5W4SkdbE/VmbqfaD490LI=
Received: from [192.168.0.11] (S0106c8fb26402908.ek.shawcable.net [24.66.132.201])
        by mail.nottheoilrig.com (Postfix) with ESMTPSA;
        Thu, 19 Jan 2017 22:12:54 +0000 (UTC)
Subject: Re: grep open pull requests
To:     Jeff King <peff@peff.net>
References: <276f6ed9-ff06-a00f-b88a-4d40d55c6d40@nottheoilrig.com>
 <20170119190227.opjisryyqn766tqy@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Jack Bates <bk874k@nottheoilrig.com>
Message-ID: <9f59c0d7-73d3-1b4c-65ca-700d6e1f4f23@nottheoilrig.com>
Date:   Thu, 19 Jan 2017 15:12:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20170119190227.opjisryyqn766tqy@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/01/17 12:02 PM, Jeff King wrote:
> It's much trickier to find from the git topology whether a particular
> history contains rebased versions of commits.  You can look at the
> --cherry options to "git log", which use patch-ids to try to equate
> commits. Something like:
>
>   git for-each-ref --format='%(refname)' 'refs/pull/*/head' |
>   while read refname; do
> 	if test -z "$(git rev-list --right-only --cherry-pick -1 origin...$refname)
> 	then
> 		echo "$refname: not merged"
> 	fi
>   done
>
> That's obviously much less efficient than `--no-merged`, but it should
> generally work. The exception is if the rebase changed the commit
> sufficiently that its patch-id may have changed.

Cool, thanks for all your help! "git log --cherry-pick" works quite 
well. One thing: I expected the following to be equivalent, but found 
that they're not. Is that by accident or design?

   $ git rev-list --cherry-pick --right-only master...refs/pull/1112/head
   $ git rev-list --cherry-pick master..refs/pull/1112/head

> I think that's probably the best answer to your "unmerged" question,
> too. Ask the API which PRs are unmerged, and then do whatever git-level
> analysis you want based on that.

Right, that makes sense. Thanks again!
