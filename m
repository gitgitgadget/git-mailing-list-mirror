Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11D631F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 08:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeCZIKj (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 04:10:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:42938 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751840AbeCZIKi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 04:10:38 -0400
Received: (qmail 6303 invoked by uid 109); 26 Mar 2018 08:10:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Mar 2018 08:10:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17701 invoked by uid 111); 26 Mar 2018 08:11:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Mar 2018 04:11:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2018 04:10:36 -0400
Date:   Mon, 26 Mar 2018 04:10:36 -0400
From:   Jeff King <peff@peff.net>
To:     Aaron Greenberg <p@aaronjgreenberg.com>
Cc:     git@matthieu-moy.fr, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] branch: implement shortcut to delete last branch
Message-ID: <20180326081036.GA18714@sigill.intra.peff.net>
References: <20180323085636.GA24416@sigill.intra.peff.net>
 <1521844835-23956-1-git-send-email-p@aaronjgreenberg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521844835-23956-1-git-send-email-p@aaronjgreenberg.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 10:40:34PM +0000, Aaron Greenberg wrote:

> I updated the commit message to include my first email's cover letter
> and cleaned up the test.

Thanks. This one looks good to me.

> I can appreciate Matthieu's points on the use of "-" in destructive
> commands. As of this writing, git-merge supports the "-" shorthand,
> which while not destructive, is at least _mutative_. Also,
> "git branch -d" is not destructive in the same way that "rm -rf" is
> destructive since you can recover the branch using the reflog.

There's a slight subtlety there with the reflog, because "branch -d"
actually _does_ delete the reflog for the branch. By definition if
you've found the branch with "-" then it was just checked out, so you at
least have the old tip. But the branch's whole reflog is gone for good.

That said, I'd still be OK with it.

> One thing to consider is that approval of this patch extends the
> implementation of the "-" shorthand in a piecemeal, rather than
> consistent, way (implementing it in a consistent way was the goal of
> the patch set you mentioned in your previous email.) Is that okay? Or
> is it better to pick up the consistent approach where it was left?

I don't have a real opinion on whether it should be implemented
everywhere or not. But IMHO it's OK to do it piecemeal for now either
way, unless we're really sure it's time to move to respecting it
everywhere. Because we can always convert a
piecemeal-but-covers-everything state to centralized parsing as a
cleanup.

-Peff
