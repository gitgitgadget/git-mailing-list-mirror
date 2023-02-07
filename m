Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6C1C636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 18:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjBGSaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjBGSa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 13:30:28 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E3B1AE
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 10:30:27 -0800 (PST)
Received: (qmail 11233 invoked by uid 109); 7 Feb 2023 18:30:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Feb 2023 18:30:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23314 invoked by uid 111); 7 Feb 2023 18:30:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Feb 2023 13:30:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Feb 2023 13:30:26 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 6/6] imap-send: correctly report "host" when using
 "tunnel"
Message-ID: <Y+KYwsBjty0aaLes@coredump.intra.peff.net>
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
 <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
 <Y91J+P5P9gV1Dygm@coredump.intra.peff.net>
 <230203.86bkmabfjr.gmgdl@evledraar.gmail.com>
 <Y94866yd3adoC1o9@coredump.intra.peff.net>
 <230205.86ilgf7osb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230205.86ilgf7osb.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 05, 2023 at 10:51:04PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > Not if they did:
> >
> >   [imap]
> >   host = example.com
> >   tunnel = some-command
> 
> Yes, but how would they have ended up doing that? By discarding the
> documentation and throwing things at the wall & hoping they'd stick? 

That's what I would have tried without reading the documentation at all,
based on using other programs that tunnel imap. I'm just one data point,
of course.

> I just don't get how anyone could have come to rely on this so that we'd
> care about supporting it.
> 
> Because mutt has a feature that looks similar, users might have
> configured git-imap-send thinking it might do the same thing, and gotten
> lucky?

It's less "mutt happens to do it this way" and more "associating a host
is strictly more useful, because it lets you interact with all the other
host-like features". It's only imap-send's funky config scheme that
makes it easy to mis-configure.

> I guess in principle that could be true, but I think it's more likely
> that nobody's ever had reason to use it that way. I.e. if you use the
> "tunnel" the way the docs suggest you won't hit the credential helper,
> as you're authenticating with "ssh", and using "imapd" to directly
> operate on a Maildir path.

As I said, my main use of tunneling is to trigger the imap server's
preauth mode. But there are other reasons one might want to do so, like
piercing a firewall. E.g.:

  [imap]
  host = internal.example.com
  tunnel = "ssh bastion-server nc internal.example.com 143"

-Peff
