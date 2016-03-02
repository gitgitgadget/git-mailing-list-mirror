From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] bundle: plug resource leak
Date: Wed, 2 Mar 2016 04:02:28 -0500
Message-ID: <20160302090228.GD30295@sigill.intra.peff.net>
References: <xmqqvb556abd.fsf@gitster.mtv.corp.google.com>
 <20160302085432.GB30295@sigill.intra.peff.net>
 <xmqqoaax45l5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 10:02:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab2g1-00051j-RW
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 10:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbcCBJCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 04:02:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:53099 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751422AbcCBJCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 04:02:31 -0500
Received: (qmail 12120 invoked by uid 102); 2 Mar 2016 09:02:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Mar 2016 04:02:31 -0500
Received: (qmail 21955 invoked by uid 107); 2 Mar 2016 09:02:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Mar 2016 04:02:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Mar 2016 04:02:28 -0500
Content-Disposition: inline
In-Reply-To: <xmqqoaax45l5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288114>

On Wed, Mar 02, 2016 at 01:00:38AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I do find it hard to believe that the bundle code had to invent its own
> > ref storage data structure, and couldn't just use "struct ref" like all
> > of the other code. It doesn't look like we ever sort it or do
> > non-sequential access. The linked-list "struct ref" probably would have
> > been fine.
> >
> > Not a problem you are introducing, of course, but if you are touching
> > this code a lot, it might be worth seeing how painful it is.
> 
> The bundle code being fairly old, I actually wouldn't be surprised
> if it predated the wide use of "struct ref" ;-)
> 
> It is not performance critical to add entries to the list of
> prerequisites or references (i.e. it is OK to have these as linear
> lists, not linked lists of "struct ref"), and these lists do not
> have to be ultra-efficient in their storage use (i.e. it is OK to
> replace these with "struct ref" linked lists), so we could go either
> way.  It's not like we would be using a lot of helper functions we
> already have for "struct ref" in this code, so I'm inclined to give
> a very low priority to the task of rethinking this data structure.

Sure, I agree it's low priority by itself. It was more something to
consider if you find that you are touching the bundle code a lot.

-Peff
