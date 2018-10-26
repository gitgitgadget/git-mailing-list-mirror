Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F05D1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 09:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeJZSNH (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 14:13:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:55522 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726179AbeJZSNH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 14:13:07 -0400
Received: (qmail 7447 invoked by uid 109); 26 Oct 2018 09:36:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Oct 2018 09:36:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27759 invoked by uid 111); 26 Oct 2018 09:36:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 26 Oct 2018 05:36:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2018 05:36:44 -0400
Date:   Fri, 26 Oct 2018 05:36:44 -0400
From:   Jeff King <peff@peff.net>
To:     Jason Cooper <jason@lakedaemon.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "lhf635@163.com" <lhf635@163.com>, git <git@vger.kernel.org>
Subject: Re: the opposite of .gitignore, whitelist
Message-ID: <20181026093644.GA20876@sigill.intra.peff.net>
References: <201810251039388653199@163.com>
 <xmqqh8hak2mh.fsf@gitster-ct.c.googlers.com>
 <c166b421-a228-8349-0815-2ebb9dcab998@lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c166b421-a228-8349-0815-2ebb9dcab998@lakedaemon.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 10:38:46AM -0400, Jason Cooper wrote:

> On 10/25/18 1:37 AM, Junio C Hamano wrote:
> > "lhf635@163.com" <lhf635@163.com> writes:
> >
> >> I have a good idea, add a file to git that is the opposite of .gitignore...,
> > Do negative patterns in .gitignore file help without inventing
> > anything new?
> I did this several years ago in an attempt to track /etc/ (minus
> ownership, of course) without storing secrets in the git history.  As
> the system grew and was maintained (read: crap added), the negative
> patterns grew untenable.  I quickly realized it wasn't the correct way
> to solve the problem.
> 
> Unfortunately, shortly after realizing this, I left that project.  So I
> never had the chance to develop a proper solution.  However, the concept
> of a '.gitonly' file was exactly was I was seeking.  So, for what it's
> worth, I've definitely had at least one legit usecase for this feature.
> 
> The usecases tend to center around tracking select files within the
> rootfs of a full-blown operating system.  Or a subset thereof.

I think what Junio meant is to ignore everything by default, like:

  echo '*' >.gitignore

and then selectively use negative patterns (and being in .gitignore,
that makes them positive "yes, include this") to add things back:

  echo 'foo' >>.gitignore

which ends up being roughly the same as your .gitonly concept.

I don't offhand remember if you might run into problems where a
subdirectory is ignored by the "*" and we do not even recurse into it. I
think it would work OK as long as you put everything in the top-level
gitignore, like:

  echo 'subdir/file' >>.gitignore

but I didn't test.

-Peff
