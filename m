Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EEEC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD533616E8
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhELAdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 20:33:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:51598 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhELAdt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 20:33:49 -0400
Received: (qmail 25179 invoked by uid 109); 12 May 2021 00:32:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 May 2021 00:32:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30601 invoked by uid 111); 12 May 2021 00:32:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 20:32:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 20:32:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Gregory Anders <greg@gpanders.com>, git@vger.kernel.org
Subject: Re: Syntax for specifying a command in git config
Message-ID: <YJsiKDNbKclFU00b@coredump.intra.peff.net>
References: <YJrH8uqzapnpNEsb@gpanders.com>
 <YJrKJAa45mNIL+rf@coredump.intra.peff.net>
 <xmqqo8dgj2vk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8dgj2vk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 07:56:47AM +0900, Junio C Hamano wrote:

> > IMHO this is a good path forward. There's a thread from a few months ago
> > which talks about this idea:
> >
> >   https://lore.kernel.org/git/YCvotU6KVruFuf9%2F@coredump.intra.peff.net/
> >
> > There's some back and forth, and I'm not sure if I convinced Junio in
> > the end. But certainly a patch would be a good way to restart the
> > conversation. :)
> 
> The argument is not just about configuration but applies equally to
> its command line argument "--smtp-server=<what>", right?  I think it
> makes sense in both of these places.  I further wonder if we should
> allow not just a single token, but supplying an initial few arguments,
> too, e.g.
> 
> 	git send-email --smtp-server="/usr/bin/env msmtp"
> 	git send-email --smtp-server="!my-msa --emulate-sendmail"

Yes, the patch under discussion does apply to both the command-line
option and the config option (and I agree it should).

I didn't think about arguments, but you're right that may be a useful
feature. And if done via the shell, as brian suggested elsewhere, would
be more consistent with other parts of Git using "!" syntax.

It does make things a little weird in that:

  git send-email --smtp-server='/path/to/my-sendmail foo'

and

  git send-email --smtp-server '!my-sendmail foo'

behave differently (the first does not work; it looks for an executable
with a space in the name).

-Peff
