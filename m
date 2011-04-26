From: Jeff King <peff@peff.net>
Subject: Re: "git clone --depth=2 git://git.sv.gnu.org/gnulib" hangs
Date: Tue, 26 Apr 2011 03:59:17 -0400
Message-ID: <20110426075917.GA26874@sigill.intra.peff.net>
References: <87aafedqjp.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 09:59:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEdBa-0002CM-Q9
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 09:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758587Ab1DZH7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 03:59:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36027
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758413Ab1DZH7U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 03:59:20 -0400
Received: (qmail 16171 invoked by uid 107); 26 Apr 2011 08:01:00 -0000
Received: from c-67-172-212-47.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.212.47)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Apr 2011 04:01:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Apr 2011 03:59:17 -0400
Content-Disposition: inline
In-Reply-To: <87aafedqjp.fsf@rho.meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172074>

On Mon, Apr 25, 2011 at 10:28:10PM +0200, Jim Meyering wrote:

> We've had a report that this command is hanging:
> 
>     git clone --depth=2 git://git.sv.gnu.org/gnulib

It might be related to this deadlock which impacts upload-pack on a
server with pthreads serving a shallow clone:

  http://thread.gmane.org/gmane.comp.version-control.git/170789

Unfortunately the fix I posted is not yet in any released version of
git. It is in the current 'next'.

> It appears to be something specific to the gnulib repository,
> since I can do a shallow clone of e.g., this one just fine:
> 
>     git://git.savannah.gnu.org/parallel.git

It's a race condition on filling up a rev-list buffer, so certain repos
may be more prone to triggering the race than others.

-Peff
