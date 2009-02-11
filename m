From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fast-export: ensure we traverse commits in topological
	order
Date: Wed, 11 Feb 2009 12:37:17 -0500
Message-ID: <20090211173717.GA19749@coredump.intra.peff.net>
References: <1234332233-10017-1-git-send-email-newren@gmail.com> <1234332233-10017-2-git-send-email-newren@gmail.com> <alpine.DEB.1.00.0902111125410.10279@pacific.mpi-cbg.de> <e2b179460902110248m8055b3amdebcfc550438cff2@mail.gmail.com> <20090211135640.GA19600@coredump.intra.peff.net> <alpine.DEB.1.00.0902111618120.13279@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 11 18:38:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJ2t-0004rm-Lg
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 18:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbZBKRhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 12:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755457AbZBKRhU
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 12:37:20 -0500
Received: from peff.net ([208.65.91.99]:56933 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755140AbZBKRhU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 12:37:20 -0500
Received: (qmail 31673 invoked by uid 107); 11 Feb 2009 17:37:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 11 Feb 2009 12:37:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 12:37:17 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902111618120.13279@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109454>

On Wed, Feb 11, 2009 at 04:18:28PM +0100, Johannes Schindelin wrote:

> >   $ time git fast-export --all --signed-tags=strip >/dev/null
> >   real    1m6.013s
> >   user    1m3.840s
> >   sys     0m2.140s
> 
> Or a warm against a cold cache?

Nope. See how the CPU is more or less pegged in the numbers above? Cold
cache looks like this:

  $ echo 3 >/proc/sys/vm/drop_caches
  $ time git fast-export --all --signed-tags=strip >/dev/null
  real    1m11.148s
  user    1m3.952s
  sys     0m0.760s

So only 7 extra seconds paging in. Hooray for packing. :)

-Peff
