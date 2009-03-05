From: Jeff King <peff@peff.net>
Subject: Re: orthogonal cases of log --date option
Date: Thu, 5 Mar 2009 05:43:05 -0500
Message-ID: <20090305104304.GA17760@coredump.intra.peff.net>
References: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com> <7vtz6bdmfi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 11:45:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfB4K-0002Sj-3I
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 11:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbZCEKnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 05:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbZCEKnP
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 05:43:15 -0500
Received: from peff.net ([208.65.91.99]:33189 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753957AbZCEKnO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 05:43:14 -0500
Received: (qmail 29908 invoked by uid 107); 5 Mar 2009 10:43:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 05 Mar 2009 05:43:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Mar 2009 05:43:05 -0500
Content-Disposition: inline
In-Reply-To: <7vtz6bdmfi.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112292>

On Tue, Mar 03, 2009 at 12:45:37AM -0800, Junio C Hamano wrote:

> Miles Bader <miles@gnu.org> writes:
> 
> > I can use "git log --date=iso" to get YYYY-MM-DD format for dates, or
> > "git log --date=local" to force the dates to use my local time zone, but
> > if I use _both_ of these options together, it uses only the last one,
> > and ignores any preceding --date (even those in this case, the two
> > --date options affect orthogonal properties of dates).  Is there a way
> > to get YYYY-MM-DD format dates, but in my local time-zone?
> 
> No, there isn't.
> 
> But this patch may help you get started.

FWIW, I think this is the wrong direction. You are working around the
lack of orthogonality in the interface by tweaking things in the
implementation. I think you are better to fix the interface, but support
--date=local for historical reasons. IOW,

  git log --local-dates --date=short

with

  git log --date=local

as a historical synonym for

  git log --local-dates --date=default

This makes the interface simpler to understand: --date remains a
selector, and --date=local is a special case that new people don't need
to think about or understand.

-Peff
