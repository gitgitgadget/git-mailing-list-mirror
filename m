From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/8] upload/receive-pack: allow hiding ref hierarchies
Date: Tue, 5 Feb 2013 03:50:48 -0500
Message-ID: <20130205085047.GA24973@sigill.intra.peff.net>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <1359571542-19852-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 09:51:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2eFG-0004bD-GA
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 09:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699Ab3BEIuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 03:50:52 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:32976 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073Ab3BEIuv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 03:50:51 -0500
Received: (qmail 27422 invoked by uid 107); 5 Feb 2013 08:52:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Feb 2013 03:52:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Feb 2013 03:50:48 -0500
Content-Disposition: inline
In-Reply-To: <1359571542-19852-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215468>

On Wed, Jan 30, 2013 at 10:45:37AM -0800, Junio C Hamano wrote:

> Teach upload-pack and receive-pack to omit some refs from their
> initial advertisements by paying attention to the transfer.hiderefs
> multi-valued configuration variable.  Any ref that is under the
> hierarchies listed on the value of this variable is excluded from
> responses to requests made by "ls-remote", "fetch", "clone", "push",
> etc.
> 
> A typical use case may be
> 
> 	[transfer]
> 		hiderefs = refs/pull
> 
> to hide the refs that are internally used by the hosting site and
> should not be exposed over the network.

In the earlier review, I mentioned making this per-service, but I see
that is not the case here. Do you have an argument against doing so?

I'm specifically thinking of the way we do refs/pull at GitHub (which we
hide only from receive-pack).  I know that you think it would be cleaner
to hide those, and at some level I agree. But at the same time, the
current mechanism has been in place for some time; changing what we
present via upload-pack is likely to break people's workflows. And I
have not seen complaints about the current system. So unless there is a
compelling reason to do so, I'd rather let the fetcher make the
decision.

Gerrit's refs/changes may be a different story, if they have a large
enough number of them to make upload-pack's ref advertisement
overwhelming.

I'm happy to do the per-service patch on top, but I just expected it
here, so I'm wondering if you are against having the feature.

-Peff
