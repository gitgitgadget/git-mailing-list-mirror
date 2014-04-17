From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Thu, 17 Apr 2014 23:52:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info>
References: <20140416141519.GA9684@camelia.ucw.cz> <20140416154653.GB4691@sigill.intra.peff.net> <alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info> <20140417213238.GA14792@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Stepan Kasal <kasal@ucw.cz>,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:53:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WauEz-0000rJ-1D
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 23:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbaDQVxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 17:53:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:50233 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbaDQVw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 17:52:58 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MUILK-1WScmY38Dq-00R38W;
 Thu, 17 Apr 2014 23:52:56 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20140417213238.GA14792@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:qJxYki3qm0CHIv7SPUAZ/H6QInM09wZPRPBsASmsMXFhTlNGOG5
 8ZwZV+ssCV2oqOwAAf0erHGZQXAkEdSsGGoc4eppLDPEbB+x1ADVe5lWJNfQ5n5FJkSJ1hs
 FoyzTdDMLa6x6eojECYQCX1S5B6k9EVKZ7jR43+gk0Qm49BOJDkFV20ANMtFMbKgA8LzAy+
 an89O2IL+fgLVQPL9KPig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246455>

Hi Peff,

On Thu, 17 Apr 2014, Jeff King wrote:

> On Thu, Apr 17, 2014 at 07:31:54PM +0200, Johannes Schindelin wrote:
> 
> > > 	bash -c "ulimit -s 64 && git tag --contains HEAD" >actual &&
> > [...]
> > Please see https://github.com/msysgit/git/c63d196 for the fixup, and
> > https://github.com/msysgit/git/compare/tag-contains%5E...tag-contains for
> > the updated patch.
> 
> I tried running the test on my Linux box, but it doesn't fail with the
> existing recursive code.

I cannot recall how I came to choose 64, but I *think* I only tested on
Windows, and I *think* I reduced the number of tags in order to make
things faster (Windows is *unbearably* slow with spawn-happy programs such
as Git's tests -- literally every single line in a shell script tests the
patience of this developer, running the complete test suite with 15
parallel threads takes several hours, no kidding).

> The results are strangely non-deterministic, but with -O0, we generally
> die reliably below about 60. With -O2, though, it's more like 43. We
> can't go _too_ low here, though, as lots of things start breaking around
> 32.

How about using 40, then? I am more interested in reducing the runtime
than reducing the number of false negatives. The problem will be exercised
enough on Windows, but not if the test suite becomes even slower than it
already is.

Ciao,
Johannes
