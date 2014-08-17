From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] git-imap-send: use libcurl for implementation
Date: Sun, 17 Aug 2014 04:30:22 -0400
Message-ID: <20140817083022.GJ23808@peff.net>
References: <53EA8C3E.1080500@raz.or.at>
 <20140813015917.GA30756@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bernhard Reiter <ockham@raz.or.at>, git@vger.kernel.org,
	434599@bugs.debian.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 10:31:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIvsO-00007D-3J
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 10:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbaHQIaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 04:30:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:53587 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751092AbaHQIaX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 04:30:23 -0400
Received: (qmail 10415 invoked by uid 102); 17 Aug 2014 08:30:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Aug 2014 03:30:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Aug 2014 04:30:22 -0400
Content-Disposition: inline
In-Reply-To: <20140813015917.GA30756@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255359>

On Tue, Aug 12, 2014 at 06:59:17PM -0700, Jonathan Nieder wrote:

> > +		curl_socket_t sockfd = tunnel.out; // what about tunnel.in ?
> 
> Hmm.  curl expects to get a socket it can send(), recv(), setsockopt(),
> etc on instead of a pair of fds to read() and write().

I wonder if we could teach run_command to optionally use socketpair()
instead of pipe(). I'm not sure if that would cause problems on Windows,
though.

> I wonder why someone would want to use SSL through a tunnel, though.
> Currently it's impossible to get to the SSL codepath when a tunnel is
> active (it's in the 'else' block an 'if (srvc->tunnel)').  If that
> property is preserved, then we should be safe.

I'm not sure I understand this comment. Even if SSL is not in use,
wouldn't we be passing a regular pipe to curl, which would break?

-Peff
