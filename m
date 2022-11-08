Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7CBC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiKHOme (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbiKHOmd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:42:33 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37BC29C91
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:42:31 -0800 (PST)
Received: (qmail 7799 invoked by uid 109); 8 Nov 2022 14:42:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Nov 2022 14:42:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4938 invoked by uid 111); 8 Nov 2022 14:42:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Nov 2022 09:42:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Nov 2022 09:42:30 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 4/6] revision: add new parameter to exclude hidden refs
Message-ID: <Y2pq1q3VmXq6UEJk@coredump.intra.peff.net>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667823042.git.ps@pks.im>
 <de7c1aa210c2df9bdbbb6c19f44f72c37f56c5da.1667823042.git.ps@pks.im>
 <Y2mpefFJspp4QnAz@nand.local>
 <Y2oQb12WwEh0bpxW@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2oQb12WwEh0bpxW@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 09:16:47AM +0100, Patrick Steinhardt wrote:

> > > +--exclude-hidden=[transfer|receive|uploadpack]::
> > > +	Do not include refs that have been hidden via either one of
> > > +	`transfer.hideRefs`, `receive.hideRefs` or `uploadpack.hideRefs` that
> > > +	the next `--all`, `--branches`, `--tags`, `--remotes` or `--glob` would
> > > +	otherwise consider.  This option is cleared when seeing one of these
> > > +	pseudo-refs.
> > > +
> > 
> > Hmm. I thought that part of the motivation behind this round was to drop
> > the 'transfer' group, since it's implied by '--exclude-hidden=receive
> > --exclude-hidden-uploadpack', no?
> > 
> > Thanks,
> > Taylor
> 
> I didn't quite see the point in not providing the `transfer` group so
> that users can ask for only the set of refs that are hidden by both
> `uploadpack` and `receive`. But given that you're the second person
> asking for it to be dropped now and given that I don't really have a
> plausible usecase for this I'll drop it in the next version.

Sorry, I'm a little slow on the review. I just left a message in
response to v2 saying that I'm OK with it _if_ it's explained. But the
explanation above still seems misleading. Saying "either one of" implies
that they are mutually exclusive, but "receive" is really pulling from
"receive.hideRefs" and "transfer.hideRefs".

I think you'd need to lay out the rules. But if we just drop "transfer"
then that is simpler still (but the explanation probably still ought to
become "refs hidden by receive-pack" and not mention receive.hideRefs
explicitly).

-Peff
