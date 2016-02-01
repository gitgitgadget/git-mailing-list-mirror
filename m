From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] checkout-index: handle "--no-index" option
Date: Sun, 31 Jan 2016 22:22:07 -0500
Message-ID: <20160201032207.GB12217@sigill.intra.peff.net>
References: <20160131112215.GA4589@sigill.intra.peff.net>
 <20160131112936.GD5116@sigill.intra.peff.net>
 <xmqqr3gxw4j1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 04:22:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ54B-0006u0-SH
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 04:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757610AbcBADWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 22:22:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:35292 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757585AbcBADWK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 22:22:10 -0500
Received: (qmail 18463 invoked by uid 102); 1 Feb 2016 03:22:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 22:22:09 -0500
Received: (qmail 20735 invoked by uid 107); 1 Feb 2016 03:22:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 22:22:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Jan 2016 22:22:07 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3gxw4j1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285183>

On Sun, Jan 31, 2016 at 06:25:22PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I also reformatted the comment that violated our style
> > guidelines, but I am not sure if it is all that helpful. It
> > seems we also cancel "--index" with "--temp" or
> > "--stage=all", but I do not know why. I left the content
> > as-is, but if somebody knows enough to elaborate, it might
> > be worth doing.
> 
> Isn't the --index about updating the cached stat information, to
> allow us to then say "the working tree file hasn't been modified
> since we wrote it out"?  After writing a file out to somewhere that
> is not its natural location (i.e. using prefix, stage or temp would
> all write the contents of F to somewhere that is not F), the next
> "diff-files" would not compare the index entry with the contents
> held in that relocated location, but with its natural location.

Yeah, that makes sense to me. I should have said "...but I do not know
why, and I did not really look into it" in my original.

That probably makes it OK to silently ignore (as opposed to complaining
that "--prefix" is used with "--index"). It is not so much "these
options are incompatible" as the fact that there is no entry to update
in the case of a prefix or tempfile. So "--index" is still in effect, it
just has no work to do. :)

-Peff
