From: Jeff King <peff@peff.net>
Subject: Re: Large repo and pack.packsizelimit
Date: Tue, 8 May 2012 16:31:37 -0400
Message-ID: <20120508203137.GA15707@sigill.intra.peff.net>
References: <37267143.413194.1336046278583.JavaMail.ngmail@webmail07.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: th.acker66@arcor.de
X-From: git-owner@vger.kernel.org Tue May 08 22:31:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRr4S-0005KH-HQ
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 22:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265Ab2EHUbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 16:31:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34396
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258Ab2EHUbj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 16:31:39 -0400
Received: (qmail 8187 invoked by uid 107); 8 May 2012 20:31:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 May 2012 16:31:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2012 16:31:37 -0400
Content-Disposition: inline
In-Reply-To: <37267143.413194.1336046278583.JavaMail.ngmail@webmail07.arcor-online.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197423>

On Thu, May 03, 2012 at 01:57:58PM +0200, th.acker66@arcor.de wrote:

> I am using MSysgit 1.7.9 on WinXP 32bit and have a very large repo
> (10GB in .git; 20GB in source tree).  I had to set
> pack.packsizelimit=1024MB to prevent "out of memory" during repacking
> in git-gc and everything seemed to work fine.
> 
> When I tried to clone this repo an "out of memory" occured because the
> packs to be transferred by the git protocol are not limited by
> pack.packsizelimit.

Yes, pack-objects respects pack.packsizelimit when creating local packs,
but incoming packs from the network (which are processed by index-pack)
are not split.

This should be fixed in git. Unfortunately, I don't know that it is as
trivial as just splitting the incoming stream; we would also have to
make sure that there were no cross-pack deltas in the result.

-Peff
