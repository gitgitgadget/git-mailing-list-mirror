From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git bisect enhancements?
Date: Wed, 30 Nov 2005 15:32:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511301526530.3099@g5.osdl.org>
References: <1133386585.30767.34.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 01 00:34:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhbRA-0006qg-1i
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 00:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVK3XcZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 18:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVK3XcY
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 18:32:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751239AbVK3XcY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 18:32:24 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAUNWLnO005495
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 30 Nov 2005 15:32:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAUNWKLr015995;
	Wed, 30 Nov 2005 15:32:21 -0800
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1133386585.30767.34.camel@cashmere.sps.mot.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13031>



On Wed, 30 Nov 2005, Jon Loeliger wrote:
> 
> So, I'm proposing something like:
> 
>     $ git bisect bump +<n>
>     $ git bisect bump -<n>
> 
> To move the bisection point "up" or "down" a commit chain.
> 
> Am I off in the weeds?

No, but we already have it.

If you decide to select a new bisection point by hand, just do it. It's 
called

	git reset --hard <new-bisect-point>

and it will simply move the bisect branch to the new point.

Then, compile and test that, and use "git bisect good/bad" as necessary.

Now, I agree that maybe I could have made that a bit more obvious, but it 
should all work.

Same goes for the case where "git bisect" selects a point that happens to 
have a different problem than the one you were looking for. Instead of 
saying "git bisect good" (or bad) and praying you got it right, just do 
that "git bisect visualize" and select another point entirely, and do that 
same "git reset --hard" thing, and leave the one you don't know about 
alone.

Of course, if you make a bad selection, you might have that problem again, 
or more commonly, you'll just have to test more kernels because your 
selection wasn't as close to "midway" as the one "git bisect" had selected 
for you. But you'll get there eventually.

[ Now, the _real_ problem with bisection is that some bugs simply cannot 
  be bisected. If it's timing-related etc, it might be a bug that comes 
  and goes, and then I'm afraid that git bisect won't really help you. ]

			Linus
