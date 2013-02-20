From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 08/19] write_or_die: raise SIGPIPE when we get EPIPE
Date: Wed, 20 Feb 2013 17:03:59 -0500
Message-ID: <20130220220359.GA1417@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
 <20130220200136.GH25647@sigill.intra.peff.net>
 <20130220215043.GA24236@google.com>
 <20130220215845.GB817@sigill.intra.peff.net>
 <20130220220114.GB24236@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:04:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Hm8-00045n-Ub
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 23:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278Ab3BTWED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 17:04:03 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54828 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907Ab3BTWEC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 17:04:02 -0500
Received: (qmail 19276 invoked by uid 107); 20 Feb 2013 22:05:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 17:05:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 17:03:59 -0500
Content-Disposition: inline
In-Reply-To: <20130220220114.GB24236@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216740>

On Wed, Feb 20, 2013 at 02:01:14PM -0800, Jonathan Nieder wrote:

> >> How about
> >>
> >> 		die("BUG: another thread changed SIGPIPE handling behind my back!");
> >>
> >> to make it easier to find and fix such problems?
> >
> > You mean for the "should never happen" bit, not the first part, right? I
> > actually wonder if we should simply exit(141) in the first place. That
> > is shell exit-code for SIGPIPE death already (so it's what our
> > run_command would show us, and what anybody running us through shell
> > would see).
> 
> Yes, for the "should never happen" part.  Raising a signal is nice
> because it means the wait()-ing process can see what happened by
> checking WIFSIGNALED(status).

Right. My point is that only happens if there's no shell in the way. But
I guess it doesn't hurt to make the attempt to help the people using
wait() directly.

I don't mind adding a "BUG: " message like you described, but we should
still try to exit(141) as the backup, since that is the shell-equivalent
code to the SIGPIPE signal death.

-Peff
