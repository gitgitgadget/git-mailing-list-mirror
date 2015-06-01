From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/3] silence missing-link warnings in some cases
Date: Mon, 1 Jun 2015 11:41:03 -0400
Message-ID: <20150601154103.GA14538@peff.net>
References: <556C0BAD.80106@atlas-elektronik.com>
 <20150601081450.GA32634@peff.net>
 <556C1A95.9010704@atlas-elektronik.com>
 <20150601085226.GA20537@peff.net>
 <20150601095410.GA16976@peff.net>
 <xmqqmw0j8o9i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 17:41:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzRq0-0004Ps-P2
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 17:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbbFAPlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 11:41:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:38908 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752850AbbFAPlG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 11:41:06 -0400
Received: (qmail 1634 invoked by uid 102); 1 Jun 2015 15:41:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 10:41:06 -0500
Received: (qmail 31235 invoked by uid 107); 1 Jun 2015 15:41:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 11:41:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 11:41:03 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmw0j8o9i.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270426>

On Mon, Jun 01, 2015 at 08:03:05AM -0700, Junio C Hamano wrote:

> > The reason is that since git d3038d2 (prune: keep objects reachable from
> > recent objects, 2014-10-15), we will traverse objects that are not
> > reachable but have recent mtimes (within the 2-week prune expiration
> > window). Because they are not reachable, we may not actually have all of
> > their ancestors; we use the revs->ignore_missing_links option to avoid
> > making this a fatal error. But we still print an error message. This
> > series suppresses those messages.
> 
> Nice finding.  One of us should have thought of this kind of fallout
> when we discussed that change, but we apparently failed.

I think the real culprit is that this should have been added along with
ignore_missing_links in the first place. That came along with the bitmap
code, but I was too busy focusing on the hard problems there to notice.
:)

> The fixes make sense to me (I haven't carefully read the
> implementation, but design/approach explained in the proposed log
> messages are very sound), and I think 3/3 is a good thing to do,
> too, in the new world order after d3038d2.

I think it's rather the opposite. In a post-d3038d2 world, a missing
object is _more_ likely to be a real corruption, and we would probably
prefer to complain about it. I am on the fence though.

-Peff
