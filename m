Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E22EC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 20:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiHJUEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 16:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiHJUET (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 16:04:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A8082758
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 13:04:18 -0700 (PDT)
Received: (qmail 6755 invoked by uid 109); 10 Aug 2022 20:04:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Aug 2022 20:04:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15236 invoked by uid 111); 10 Aug 2022 20:04:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Aug 2022 16:04:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Aug 2022 16:04:17 -0400
From:   Jeff King <peff@peff.net>
To:     Xavier Morel <xavier.morel@masklinn.net>
Cc:     git@vger.kernel.org
Subject: Re: fsck: BAD_FILEMODE diagnostic broken / never triggers
Message-ID: <YvQPQUuC+IxO0uo4@coredump.intra.peff.net>
References: <B3488A12-BCE3-48C8-915C-E2AC4E71ECD2@masklinn.net>
 <YvLkU3X9lBsG8wXp@coredump.intra.peff.net>
 <YvLttyyaZWm4pitu@coredump.intra.peff.net>
 <6688857F-B899-4253-933B-0DFE25155D13@masklinn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6688857F-B899-4253-933B-0DFE25155D13@masklinn.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2022 at 05:01:34PM +0200, Xavier Morel wrote:

> > Note that these are treated with a severity of "warning", so fsck won't
> > give a non-zero exit.
> 
> Yeah from what I understand it is classified as a warning already
> (just not emitted), like the zero padded filemodes. And that can be
> upgraded to error using fsck.msgid=error so shouldn't be an issue.

Right.

> > I think it still enough for transfer.fsckObjects
> > to mark them. I kind of wonder if fixing this at this point might create
> > more problems than it solves though (e.g., if people have broken modes
> > in historical objects that servers may now reject).
> 
> Maybe downgrade to info or ignore by default then? It might still be
> an issue for people who wilfully upgraded the diagnostic to error
> hoping to catch the, but hopefully if they did that they'd rather get
> the notice later than never?

Yeah, that may be a sensible resolution. All things being equal I think
"warning" is the right level, but out of caution and the historical
precedent, maybe downgrading it to "info" is justified.

It should be easy to work that into the patch I showed earlier.

-Peff
