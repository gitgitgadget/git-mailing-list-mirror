Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41141C636D6
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 20:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBQUug (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 15:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBQUuf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 15:50:35 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772D560A41
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 12:50:32 -0800 (PST)
Received: (qmail 14882 invoked by uid 109); 17 Feb 2023 20:50:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Feb 2023 20:50:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23401 invoked by uid 111); 17 Feb 2023 20:50:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Feb 2023 15:50:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Feb 2023 15:50:30 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 6/6] imap-send: correctly report "host" when using
 "tunnel"
Message-ID: <Y+/olg2szMxLIkXp@coredump.intra.peff.net>
References: <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
 <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
 <Y91J+P5P9gV1Dygm@coredump.intra.peff.net>
 <230203.86bkmabfjr.gmgdl@evledraar.gmail.com>
 <Y94866yd3adoC1o9@coredump.intra.peff.net>
 <230205.86ilgf7osb.gmgdl@evledraar.gmail.com>
 <Y+KYwsBjty0aaLes@coredump.intra.peff.net>
 <230207.86fsbh2nqo.gmgdl@evledraar.gmail.com>
 <Y+LNitGAude1vogv@coredump.intra.peff.net>
 <230208.86a61p0x9n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230208.86a61p0x9n.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 08, 2023 at 02:06:55AM +0100, Ævar Arnfjörð Bjarmason wrote:

> >   Side note: If somebody were proposing to add imap-send at all today,
> >   I'd probably say "no, that should be a separate project, and you
> >   should probably write it in some language that has a decent imap
> >   library". It really has nothing at all to do with Git in terms of
> >   implementation, and I suspect it's not super well maintained in
> >   general. But perhaps it is too late for that.
> 
> I think it's a reasonable feature, but in hindsight our mistake was to
> think that we should be perma-forking isync, which has since moved
> on. I've used isync's "mbsync" extensively for IMAP in other contexts,
> and it works well for that.
> 
> So if we were going back to the drawing board a "git-imap-sync" really
> should just be something in our mail tooling that can produce a Maildir,
> and if we wanted an IMAP helper it could invoke mbsync, offlineimap or
> various other "maildir to IMAP" bidirectional syncing utilities to
> "send" via IMAP.
> 
> So, just some hook support for format-patch with some documented
> examples should do it, but I won't be working on that task...

Yes, I think format-patch plus a sync program would be good. I did
briefly look at the state of imap sync programs and was a bit
disappointed. Many older recommendations are for software that is no
longer packaged, or hard to find. And none of the ones I looked at do
something as simple as "copy these messages to this imap server".
They're all very interested in bidirectional sync, incremental updates,
and so on. But I do think one could make mbsync or offlineimap work, if
you used a dedicated folder on the server as the destination.

But yeah, I don't think you or I needs to come up with a solution there.
I was more proposing along the lines of: let's drop imap-send, and
interested people can then make a solution based on other tools, or even
spin off imap-send into its own repository.

But I get that even that is some work, and it may mean complaining
users.

-Peff
