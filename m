From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] git-credential-cache--daemon on Cygwin
Date: Thu, 27 Oct 2011 10:41:23 -0700
Message-ID: <20111027174123.GA1967@sigill.intra.peff.net>
References: <4EA2FC0D.5060404@ramsay1.demon.co.uk>
 <20111022191509.GB1785@sigill.intra.peff.net>
 <4EA99266.7030002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Oct 27 19:41:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJTxL-00038e-SC
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 19:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144Ab1J0Rl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 13:41:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56726
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab1J0Rl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 13:41:26 -0400
Received: (qmail 3748 invoked by uid 107); 27 Oct 2011 17:47:13 -0000
Received: from c-67-169-41-183.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.41.183)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Oct 2011 13:47:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Oct 2011 10:41:23 -0700
Content-Disposition: inline
In-Reply-To: <4EA99266.7030002@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184306>

On Thu, Oct 27, 2011 at 06:18:30PM +0100, Ramsay Jones wrote:

> > It's definitely coming back, so if you feel like working on it, please
> > do. Also note that if it would be easier to have an alternate
> > abstraction for inter-process communication on windows, I'm open to
> > doing that in the cache daemon.
> 
> My initial reaction was to use a "named pipe" (aka fifo), but on reflection,
> I don't think it would be any easier; the unix socket emulation should not be too
> difficult (famous last words!).  :-D

The problem with named pipes is that all clients share the same pipe. So
if two clients connect, their writes will be intermingled at the server,
and they will both get the responses for each other. Assuming your
platform provides atomic write() over pipes, you could design a
packet-ized protocol, and just have clients ignore packets not meant for
them. But that's getting pretty complex.

-Peff
