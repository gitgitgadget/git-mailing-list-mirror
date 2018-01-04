Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39621F406
	for <e@80x24.org>; Thu,  4 Jan 2018 04:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeADEmd (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 23:42:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:52870 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751169AbeADEmd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 23:42:33 -0500
Received: (qmail 4044 invoked by uid 109); 4 Jan 2018 04:42:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Jan 2018 04:42:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2593 invoked by uid 111); 4 Jan 2018 04:43:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 03 Jan 2018 23:43:03 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jan 2018 23:42:30 -0500
Date:   Wed, 3 Jan 2018 23:42:30 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Segev Finer <segev208@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] connect: add GIT_SSH_{SEND,RECEIVE}{,_COMMAND} env
 variables
Message-ID: <20180104044230.GA12113@sigill.intra.peff.net>
References: <20180103102840.27897-1-avarab@gmail.com>
 <xmqq373mh62r.fsf@gitster.mtv.corp.google.com>
 <87bmiacwoz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bmiacwoz.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 04, 2018 at 01:08:28AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Hopefully this is clearer, and depending on how the rest of the
> discussion goes I'll submit v2 with something like this in the commit
> message:
> 
> SSH keys A and B are known to the remote service, and used to identify
> two different users.
> 
> A can only push to repository X, and B can only fetch from repository Y.
> 
> Thus, if you have a script that does:
> 
>     GIT_SSH_COMMAND="ssh -i A -i B" git ...
> 
> It'll always fail for pulling from X, and pushing to Y. Supply:
> 
>     GIT_SSH_COMMAND="ssh -i B -i A" git ...
> 
> And now pulling will work, but pushing won't.

I get that you may have two different keys to go with two different
identities on a remote system. But I'm not sure I understand why
"sending" or "receiving" is the right way to split those up. Wouldn't
you also sometimes want to fetch from repository X? IOW, wouldn't you
want to tie identity "A" to repository "X", and "B" to repository "Y?

> So now I just have a GIT_SSH_COMMAND that dispatches to different keys
> depending on the operation, as noted in the commit message, and I can
> assure you that without that logic it doesn't work.

You mentioned host aliases later, which is the solution I've seen in the
wild. And then you can map each remote to a different host alias.

-Peff
