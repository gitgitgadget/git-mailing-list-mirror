From: Jeff King <jrk@wrek.org>
Subject: Re: [PATCH 3/3] t5523: test push progress output to tty
Date: Wed, 13 Oct 2010 23:34:48 -0400
Message-ID: <20101014033448.GB28197@sigill.intra.peff.net>
References: <20101014030220.GB20685@sigill.intra.peff.net>
 <20101014030505.GC5626@sigill.intra.peff.net>
 <20101014031642.GB14664@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 05:41:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6Egr-00021J-C7
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 05:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913Ab0JNDlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 23:41:07 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51789 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab0JNDlG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 23:41:06 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Oct 2010 23:41:06 EDT
Received: (qmail 4995 invoked by uid 111); 14 Oct 2010 03:34:24 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 14 Oct 2010 03:34:24 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Oct 2010 23:34:48 -0400
Content-Disposition: inline
In-Reply-To: <20101014031642.GB14664@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159022>

On Wed, Oct 13, 2010 at 10:16:42PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > --- a/t/t5523-push-upstream.sh
> > +++ b/t/t5523-push-upstream.sh
> [...]
> > @@ -72,7 +73,14 @@ test_expect_success 'push -u HEAD' '
> >  	check_config headbranch upstream refs/heads/headbranch
> >  '
> >  
> > -test_expect_success 'progress messages to non-tty' '
> > +test_expect_success 'progress messages go to tty' '
> > +	ensure_fresh_upstream &&
> > +
> > +	test_terminal git push -u upstream master >out 2>err &&
> > +	grep "Writing objects" err
> > +'
> 
> Missing TTY prerequisite.  (Do you think test_terminal should check
> $prereq to prevent this?)

Oops, good catch. I think we should already catch it, as test_terminal
will not be defined at all in the no-tty case. We could print a nicer
message, but it is not likely to be seen by the user. If they are
using "-v", then stderr probably _is_ a tty. And if not, they will not
see the message. There are ways around it, but they are not likely to be
seen unless the user is really trying (e.g., "./t5523-* -v >not_a_tty").

-Peff
