From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] quickfetch(): Prevent overflow of the rev-list
 command line
Date: Thu, 9 Jul 2009 10:32:03 -0400
Message-ID: <20090709143203.GA31138@coredump.intra.peff.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se>
 <200907091134.45492.johan@herland.net>
 <4A55E100.9010700@viscovery.net>
 <200907091552.44545.johan@herland.net>
 <4A55FCD5.2020908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 16:32:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOufs-0007kb-BI
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 16:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761136AbZGIOcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 10:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761085AbZGIOcJ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 10:32:09 -0400
Received: from peff.net ([208.65.91.99]:42664 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761032AbZGIOcI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 10:32:08 -0400
Received: (qmail 16094 invoked by uid 107); 9 Jul 2009 14:34:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 09 Jul 2009 10:34:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jul 2009 10:32:03 -0400
Content-Disposition: inline
In-Reply-To: <4A55FCD5.2020908@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122978>

On Thu, Jul 09, 2009 at 04:21:09PM +0200, Johannes Sixt wrote:

> Johan Herland schrieb:
> > On Thursday 09 July 2009, Johannes Sixt wrote:
> >> Shouldn't you reset signal(SIGPIPE) to its previous value?
> > 
> > Done (provided that the sigchain_push/pop infrastructure works the way
> > I expect).
> 
> I'm not sure, either. Peff?

I don't think I ever tried explicitly pushing SIG_IGN, but the
infrastructure was designed so that it would Just Work. So yes, I think
it's right, but you may want to test it. :)

That being said, in the patch in question there is an early return after
the push that misses the corresponding pop. That should be fixed.

-Peff
