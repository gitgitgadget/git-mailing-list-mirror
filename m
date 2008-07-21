From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Ensure that SSH runs in non-interactive mode
Date: Mon, 21 Jul 2008 03:05:17 -0400
Message-ID: <20080721070517.GB2080@sigill.intra.peff.net>
References: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com> <1216490252.10694.58.camel@koto.keithp.com> <1216491512.3911.9.camel@pc7.dolda2000.com> <alpine.DEB.1.00.0807201214060.3305@eeepc-johanness> <7v63r0bejy.fsf@gitster.siamese.dyndns.org> <20080721001422.GB12454@sigill.intra.peff.net> <20080721065348.GB24608@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Fredrik Tolf <fredrik@dolda2000.com>,
	Keith Packard <keithp@keithp.com>, git@vger.kernel.org,
	"Edward Z. Yang" <edwardzyang@thewritingpot.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 09:06:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKpTR-0007UG-Al
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 09:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbYGUHFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 03:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752286AbYGUHFU
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 03:05:20 -0400
Received: from peff.net ([208.65.91.99]:3626 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719AbYGUHFU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 03:05:20 -0400
Received: (qmail 9688 invoked by uid 111); 21 Jul 2008 07:05:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 21 Jul 2008 03:05:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jul 2008 03:05:17 -0400
Content-Disposition: inline
In-Reply-To: <20080721065348.GB24608@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89311>

On Mon, Jul 21, 2008 at 08:53:48AM +0200, Mike Hommey wrote:

> I'm not sure the ControlMaster option is still followed when using -T. 

It is still followed.

> Also, IIRC, ControlMaster doesn't exit until slave connections are
> done, so git ssh sessions granted the master control would stall until
> then if they happen to have slaves launched. i.e. It can *already* have
> bad side effects.

Yes, that is a problem (and IMHO a weakness in the implementation, but
obviously not git's problem at all).

> Adding '-S none' would ensure ControlMaster would not take effect; on

I think that is definitely a mistake; git is one of the main reasons I
use ControlMaster in the first place.

> the other hand, it would not allow git's ssh connection to be a slave
> either. '-o ControlMaster no' could be a solution.

That is actually quite sensible, and would make this a non-issue, as
far as I can see.

> All these need to be tested, obviously.

I tested, and doing "ssh -Tx -o 'ControlMaster no'" does the right thing
(reuse existing session if possible, create a new one with -Tx
otherwise, and never create a control socket for slaves).

-Peff
