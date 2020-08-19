Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CD9C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 20:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DED22083B
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 20:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHSUi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:38:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:35844 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHSUi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 16:38:27 -0400
Received: (qmail 28634 invoked by uid 109); 19 Aug 2020 20:38:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 Aug 2020 20:38:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9658 invoked by uid 111); 19 Aug 2020 20:38:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 Aug 2020 16:38:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 Aug 2020 16:38:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Lukas Straub' <lukasstraub2@web.de>,
        'git' <git@vger.kernel.org>, 'Elijah Newren' <newren@gmail.com>,
        'Brandon Williams' <bwilliams.eng@gmail.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
Message-ID: <20200819203825.GA2511902@coredump.intra.peff.net>
References: <cover.1597853634.git.lukasstraub2@web.de>
 <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
 <04aa01d67659$2dc217b0$89464710$@nexbridge.com>
 <xmqqimdetpuw.fsf@gitster.c.googlers.com>
 <20200819201736.GA2511157@coredump.intra.peff.net>
 <xmqqa6yqtm03.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6yqtm03.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 19, 2020 at 01:32:28PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It _could_ still be useful in a more isolated environment (e.g., your
> > company server that is serving only internal repos to employees). But I
> > have misgivings about a feature that lets people intentionally create
> > repositories whose history cannot ever interact with other users who
> > haven't set a special config flag. It's one thing to say "to take
> > advantage of this feature, we must all agree to have version X, or set
> > flag Y". But it's another to bake that restriction into the repository
> > history for all time.
> 
> If people want a pre-prepared repository propagated to CI
> environment and keep trakc of the state of such repository over
> time, for example, they can use (versioned) tarballs.  Such a
> tarball won't automatically get extracted after "git pull" (which
> is a feature), but those who want such a pre-prepared repository
> for CI can make the extraction step as a part of their CI build
> procedure.

Yeah, I almost went into more detail there. There are lots of solutions
that make accessing an embedded sub-repository only one command away for
the person who clones. :)  Some others are:

  - just call it "foo.git", and "mv foo.git .git" solves it (you'd
    probably want to "git checkout -f" after that, but even if it were
    embedded it seems silly to hold the data in two separate formats
    anyway

  - just hold a bare repository ("foo.git") and then clone it

etc. I think this is really a solution in search of a problem.

-Peff
