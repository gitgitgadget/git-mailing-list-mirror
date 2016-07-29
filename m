Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB27D1F858
	for <e@80x24.org>; Fri, 29 Jul 2016 02:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbcG2CIL (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 22:08:11 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44231 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbcG2CIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 22:08:09 -0400
Received: from mfilter39-d.gandi.net (mfilter39-d.gandi.net [217.70.178.170])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id AD1181720A3;
	Fri, 29 Jul 2016 04:08:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter39-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
	by mfilter39-d.gandi.net (mfilter39-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id ZKEeqryHnwD6; Fri, 29 Jul 2016 04:08:05 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id EAD0017209B;
	Fri, 29 Jul 2016 04:08:03 +0200 (CEST)
Date:	Thu, 28 Jul 2016 19:08:02 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
Message-ID: <20160729020801.GA14892@x>
References: <20160728211149.GA371@x>
 <xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
 <20160728215603.GA22865@sigill.intra.peff.net>
 <xmqq4m79qujr.fsf@gitster.mtv.corp.google.com>
 <20160729001618.GA9646@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160729001618.GA9646@sigill.intra.peff.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 08:16:19PM -0400, Jeff King wrote:
> The question in my mind is whether people actually use format-patch for
> things besides emailing, and if the final destination is something other
> than "git am".  It is a handy format because it is the least-lossy way
> to move commits around external to git itself.  That's why "rebase" used
> it originally. If the final destination is "am" (as it is for rebase),
> then in-body headers are OK, because we know it understands those. If
> not, then it's a regression.
> 
> I think on the whole that defaulting to "--from" would help more people
> than hurt them, but if we do believe there are scripts that would be
> regressed, it probably needs a deprecation period.

I don't think it's likely that there are scripts that would be regressed
(and I think it's likely that there are scripts that would be
progressed), but I'd also have no objection to a deprecation period.

I just confirmed that with the default changed, --no-from works to
return to the current behavior, so we don't need a new option.  And
--no-from has worked for a long time, so scripts won't need to care if
they're working with an old version of git.

I can provide a patch implementing a new config option to set the
format-patch --from default ("false" for --no-from, "true" for --from,
or a string value for --from=value).

Do you think this needs the kind of very noisy deprecation period that
push.default had, where anyone without the git-config option set gets a
warning to stderr?  Or do you think it would suffice to provide a
warning in the release notes for a while and then change the default?
