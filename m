From: Jeff King <peff@peff.net>
Subject: Re: git-bisect working only from toplevel dir
Date: Wed, 23 Nov 2011 14:23:29 -0500
Message-ID: <20111123192329.GA21630@sigill.intra.peff.net>
References: <20111123145034.GB17927@angband.pl>
 <7vd3cibqqe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Borowski <kilobyte@angband.pl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 20:23:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTIPy-000067-L9
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 20:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab1KWTXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 14:23:33 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49399
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754012Ab1KWTXd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 14:23:33 -0500
Received: (qmail 5605 invoked by uid 107); 23 Nov 2011 19:23:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Nov 2011 14:23:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Nov 2011 14:23:30 -0500
Content-Disposition: inline
In-Reply-To: <7vd3cibqqe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185866>

On Wed, Nov 23, 2011 at 11:09:29AM -0800, Junio C Hamano wrote:

> As to the approach, I suspect that it would be far better if it made
> workable with cd_to_toplevel at the beginning, instead of saying
> SUBDIRECTORY_OK.
> 
> After all, the current directory may disappear during the course of
> bisection, upon checking out a revision that did not have the directory
> you started your bisection from.

But from what directory would you expect:

  git bisect run make

to run from? If you use a GNU-ish layout with all of your code in
"src/", then I can see it useful to do something like:

  cd src
  git bisect run make

If we cd_to_toplevel, we can remember the prefix that we started from
and cd to it before running the user's command, but there is no
guarantee that it actually exists. Maybe that commit should be
considered indeterminate then?

I dunno. I haven't thought that hard about it. But I don't think it's
quite as simple as just telling bisect it's OK to run from a subdir.

-Peff
