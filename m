Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95356C47256
	for <git@archiver.kernel.org>; Fri,  1 May 2020 06:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758EE208C3
	for <git@archiver.kernel.org>; Fri,  1 May 2020 06:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgEAGcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 02:32:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:33346 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728307AbgEAGcI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 02:32:08 -0400
Received: (qmail 1928 invoked by uid 109); 1 May 2020 06:32:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 May 2020 06:32:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15651 invoked by uid 111); 1 May 2020 06:32:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 May 2020 02:32:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 May 2020 02:32:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     douglas.fuller@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 2/2] gitcredentials(7): make shell-snippet example more
 realistic
Message-ID: <20200501063207.GA26128@coredump.intra.peff.net>
References: <20200501061917.GC23665@coredump.intra.peff.net>
 <20200501062316.GB25603@coredump.intra.peff.net>
 <xmqqy2qcnpb4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2qcnpb4.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 11:26:39PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There's an example of using your own bit of shell to act as a credential
> > helper, but it's not very realistic:
> >
> >  - It's stupid to hand out your secret password to _every_ host. In the
> >    real world you'd use the config-matcher to limit it to a particular
> >    host.
> >
> >  - We never provided a username. We can easily do that in another config
> >    option (you can do it in the helper, too, but this is much more
> >    readable).
> >
> >  - We were sending the secret even for store/erase operations. This
> >    is OK because Git would just ignore it, but a real system would
> >    probably be unlocking a password store, which you wouldn't want to do
> >    more than necessary.
> 
> All of them make sense, but I do not think we want to encourage that
> loose style of passing unquoted argument to echo to lose embedded
> $IFS spaces that is not a SP.

You mean dropping the quotes in the first patch?

Doing:

  echo "password=$(cat $HOME/.secret)"

already eats some trailing whitespace, though I guess if you have
newlines in your password you are beyond help anyway.

I can add back in the quoted \", though it does make the code slightly
harder to read.

-Peff
