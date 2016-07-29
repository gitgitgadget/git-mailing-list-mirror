Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E1981F855
	for <e@80x24.org>; Fri, 29 Jul 2016 22:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbcG2W6H (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 18:58:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:51415 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751586AbcG2W6E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 18:58:04 -0400
Received: (qmail 18883 invoked by uid 102); 29 Jul 2016 22:58:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 18:58:04 -0400
Received: (qmail 6356 invoked by uid 107); 29 Jul 2016 22:58:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 18:58:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 18:58:00 -0400
Date:	Fri, 29 Jul 2016 18:58:00 -0400
From:	Jeff King <peff@peff.net>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
Message-ID: <20160729225800.GA23268@sigill.intra.peff.net>
References: <20160728211149.GA371@x>
 <xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
 <20160728215603.GA22865@sigill.intra.peff.net>
 <xmqq4m79qujr.fsf@gitster.mtv.corp.google.com>
 <20160729001618.GA9646@sigill.intra.peff.net>
 <20160729020801.GA14892@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160729020801.GA14892@x>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 07:08:02PM -0700, Josh Triplett wrote:

> > I think on the whole that defaulting to "--from" would help more people
> > than hurt them, but if we do believe there are scripts that would be
> > regressed, it probably needs a deprecation period.
> 
> I don't think it's likely that there are scripts that would be regressed
> (and I think it's likely that there are scripts that would be
> progressed), but I'd also have no objection to a deprecation period.

I'm on the fence, so I'd leave the final decision on whether to deal
with deprecation to you (who will write the patch) and Junio (as the
maintainer).

> I just confirmed that with the default changed, --no-from works to
> return to the current behavior, so we don't need a new option.  And
> --no-from has worked for a long time, so scripts won't need to care if
> they're working with an old version of git.
> 
> I can provide a patch implementing a new config option to set the
> format-patch --from default ("false" for --no-from, "true" for --from,
> or a string value for --from=value).

I'd be surprised if the config option is actually useful to anybody in
practice (the distinction is not "this my preference" as much as "in
what context am I calling the program?"). It is a convenient way to do
deprecations (introduce an option, then flip the default, leaving the
option as an escape hatch for anybody who has been broken), though.

> Do you think this needs the kind of very noisy deprecation period that
> push.default had, where anyone without the git-config option set gets a
> warning to stderr?  Or do you think it would suffice to provide a
> warning in the release notes for a while and then change the default?

IMHO the noisy deprecations haven't really been all that beneficial.
Even after the length push.default one, I think we still had people who
had skipped enough versions to miss it, and quite a few people became
confused or annoyed by the spew of text.

OTOH, I'm not sure most people read the release notes carefully, either.
It would be nice if we could make the change and count on people to
notice it in 'next' or even 'master' before the release, but empirically
that does not happen.

So I dunno. If we consider the risk minor, perhaps a mention in the
release notes for version X, and then the change in X+1 would be fine.
That gives some opportunity for release-note readers to pipe up. It's
not foolproof, but it would give us more confidence.

-Peff
