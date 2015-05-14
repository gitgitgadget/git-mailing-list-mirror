From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] log: do not shorten decoration names too early
Date: Thu, 14 May 2015 02:33:18 -0400
Message-ID: <20150514063317.GA22509@peff.net>
References: <55534D95.60609@alum.mit.edu>
 <xmqqwq0c9zc1.fsf@gitster.dls.corp.google.com>
 <xmqqsib09z8y.fsf@gitster.dls.corp.google.com>
 <xmqqoalo9sgc.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 08:33:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysmhz-0000eI-HX
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 08:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbbENGdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 02:33:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:58438 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750896AbbENGdV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 02:33:21 -0400
Received: (qmail 13400 invoked by uid 102); 14 May 2015 06:33:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 01:33:22 -0500
Received: (qmail 20305 invoked by uid 107); 14 May 2015 06:33:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 02:33:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 02:33:18 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoalo9sgc.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269026>

On Wed, May 13, 2015 at 12:40:35PM -0700, Junio C Hamano wrote:

> The DECORATE_SHORT_REFS option given to load_ref_decorations()
> affects the way a copy of the refname is stored for each decorated
> commit, and this forces later steps like current_pointed_by_HEAD()
> to adjust their behaviour based on this initial settings.
> 
> Instead, we can always store the full refname and then shorten them
> when producing the output.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * [1/2] is just the earlier "this should fix it" patch, with
>    adjustments to the existing tests.

Nice. After reading the first one, I was wondering why it did not look
like this one. :)

>    I suspect that it may be a good idea to lose the decoration_flags
>    from load_ref_decorations() and instead make that a new parameter
>    to format_decorations().  That way, the caller could decide which
>    ones to use.  It is not unconceivable to extend "log --format=%d"
>    that shows the decoration in the style given by --decorate arg
>    and let the callers specify two additional formats (i.e. decorate
>    always short, decorate always in full), and for that kind of
>    work, this patch will become a prerequisite.

Yeah, agreed.

While we are on the subject of the name_decoration code, I had
considered at one point replacing the use of the decorate.[ch] hash
table with a commit_slab (you can't do it in the general case, because
decorate.[ch] handles arbitrary objects, but the name_decoration code
only does commits). It would in theory be faster, though I don't know if
the time we spend on the hash table is actually measurable (we make a
lot of queries on it, but it doesn't actually get that big in the first
place).

In case you are looking for something to do with your copious free time.
:)

-Peff
