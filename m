Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43229C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 15:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbiKQPSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 10:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240442AbiKQPSS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 10:18:18 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B896874AA0
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 07:12:41 -0800 (PST)
Received: (qmail 25409 invoked by uid 109); 17 Nov 2022 15:12:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Nov 2022 15:12:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12839 invoked by uid 111); 17 Nov 2022 15:12:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Nov 2022 10:12:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Nov 2022 10:12:27 -0500
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@grubix.eu>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] notes: avoid empty line in template
Message-ID: <Y3ZPW/seP0auAtKZ@coredump.intra.peff.net>
References: <347ee7ad6fea7cf96bb1e51772802102082b58cc.1668614158.git.git@grubix.eu>
 <221117.86wn7tj4af.gmgdl@evledraar.gmail.com>
 <166867999215.10813.7408480606700051633.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <166867999215.10813.7408480606700051633.git@grubix.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2022 at 11:13:12AM +0100, Michael J Gruber wrote:

> > I don't mind the consistency here, but what does "wrong structurally"
> > mean? Doesn't the usual removing of duplicate newlines make this amount
> > to the same?
> 
> I am talking about what we present to the user as a template, and that
> contains two newlines. Whether they will be reduced afterwards depends
> on the cleanup policy.

I wondered if this might actually be a non-cosmetic bug, if you could so
something like:

  git notes add --cleanup=only-comments

which would retain the extra newlines. But there is no --cleanup option
for git-notes at all (it always calls strbuf_stripspace() internally).
And there is no "comments only" cleanup mode; it is either "clean
nothing", "clean space but leave comments", or "clean both".

So I think it really is just cosmetic.

-Peff
