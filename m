From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 0/10] pkt-line and remote-curl cleanups server
Date: Mon, 18 Feb 2013 04:33:36 -0500
Message-ID: <20130218093335.GK5096@sigill.intra.peff.net>
References: <20130216064455.GA27063@sigill.intra.peff.net>
 <20130216064929.GC22626@sigill.intra.peff.net>
 <20130217110533.GF6759@elie.Belkin>
 <20130217192830.GB25096@sigill.intra.peff.net>
 <20130218014113.GC3221@elie.Belkin>
 <20130218091203.GB17003@sigill.intra.peff.net>
 <7vhalaas2b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:34:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7N6o-0006ED-Hj
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347Ab3BRJdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:33:39 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51709 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976Ab3BRJdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:33:38 -0500
Received: (qmail 17832 invoked by uid 107); 18 Feb 2013 09:35:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 04:35:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 04:33:36 -0500
Content-Disposition: inline
In-Reply-To: <7vhalaas2b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216458>

On Mon, Feb 18, 2013 at 01:29:16AM -0800, Junio C Hamano wrote:

> > I just checked, and GitHub also does not send flush packets after ERR.
> > Which makes sense; ERR is supposed to end the conversation.
> 
> Hmph.  A flush packet was supposed to be a mark to say "all the
> packets before this one can be buffered and kept without getting
> passed to write(2), but this and all such buffered data _must_ go on
> the wire _now_".  So in the sense, ERR not followed by a flush may
> not even have a chance to be seen on the other end, no?  That is
> what the comment before the implementation of packet_flush() is all
> about.

Despite the name, I always thought of packet_flush as more of a signal
for the _receiver_, who then knows that they have gotten all of a
particular list. In other words, we seem to use it as a sequence point
as much as anything (mostly because we immediately write() out any other
packets anyway, so there is no flushing to be done; but perhaps there
were originally thoughts that we could do more buffering on the writing
side).

-Peff
