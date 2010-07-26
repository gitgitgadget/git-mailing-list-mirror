From: Jeff King <peff@peff.net>
Subject: Re: URL decoding changed semantics of + in URLs
Date: Mon, 26 Jul 2010 11:40:42 -0400
Message-ID: <20100726154041.GA18762@coredump.intra.peff.net>
References: <201007231518.31071.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jstpierre@mecheye.net
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 26 17:40:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdPnQ-0007fa-Mc
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 17:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826Ab0GZPkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 11:40:46 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:42343 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070Ab0GZPkq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 11:40:46 -0400
Received: (qmail 8835 invoked by uid 111); 26 Jul 2010 15:40:44 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Mon, 26 Jul 2010 15:40:44 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jul 2010 11:40:42 -0400
Content-Disposition: inline
In-Reply-To: <201007231518.31071.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151849>

On Fri, Jul 23, 2010 at 03:18:30PM +0200, Thomas Rast wrote:

> As pointed out by Jasper St. Pierre on #git, it is no longer possible
> to clone
> 
>   git://git.gnome.org/gtk+
> 
> because your 9d2e942 (decode file:// and ssh:// URLs, 2010-05-23)
> decodes + characters in URLs to spaces in the http style.  It was
> later fixed by ce83eda (url.c: "<scheme>://" part at the beginning
> should not be URL decoded, 2010-06-23) but the later part of the url
> still decodes + as space.
> 
> The tests that go along with the commit make it clear that it was an
> intended change.  But the interesting thing is, I cannot find any
> reference in any RFC that + must have this meaning.  In particular,
> 
>   http://www.ietf.org/rfc/rfc2396.txt
> 
> doesn't say much about + and the only escaping defined is the usual
> %xx style.  So is there a standard that mandates this, or was it just
> a well-meaning but unnecessary backwards incompatible change?

Sorry for the slow reply. I am in the middle of moving and just got a
usable machine running.

I think it is well-meaning but unnecessary. That is, I think %-decoding
is probably still a good idea, and I just dragged '+'-decoding along out
of cluelessness. I thought I cross-checked with what curl was doing to
http URLs, but now I can't even get it to do anything but pass the path
component literally to the webserver. So I'm really not sure what I
tested before.

As Jasper noted, "+" is a reserved character, which means "gtk+"
probably _should_ be escaped. But clearly it doesn't happen in practice,
and I am more interested in not breaking current use than in nitpicking
with a standard.

So I agree with the spirit of your patches, and reading over your v2, it
looks fine to me, but I didn't do any extensive testing.

-Peff
