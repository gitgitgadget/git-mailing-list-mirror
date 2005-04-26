From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Mon, 25 Apr 2005 19:08:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 04:02:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQFOR-0004he-Cj
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 04:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVDZCGn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 22:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVDZCGn
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 22:06:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:35224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261255AbVDZCGc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 22:06:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3Q26Ts4024593
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 19:06:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3Q26SAm020574;
	Mon, 25 Apr 2005 19:06:29 -0700
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20050426004111.GI21897@waste.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Apr 2005, Matt Mackall wrote:
>
> Here are the results of checking in the first 12 releases of Linux 2.6
> into empty repositories for Mercurial v0.3 (hg) and git-pasky-0.7.
> This is on my 512M Pentium M laptop. Times are in seconds.
> 
>                  user         system       real        du -sh
> ver    files   hg    git    hg    git    hg    git    hg   git
> 
> 2.6.0  15007 19.949 35.526 3.171 2.264 25.138 87.994 145M   89M
> 2.6.1    998  5.906  4.018 0.573 0.464 10.267  5.937 146M   99M
> 2.6.2   2370  9.696 13.051 0.752 0.652 12.970 15.167 150M  117M
> 2.6.3   1906 10.528 11.509 0.816 0.639 18.406 14.318 152M  135M
> 2.6.4   3185 11.140  7.380 0.997 0.731 15.265 12.412 156M  158M
> 2.6.5   2261 10.961  6.939 0.843 0.640 20.564  8.522 158M  177M
> 2.6.6   2642 11.803 10.043 0.870 0.678 22.360 11.515 162M  197M
> 2.6.7   3772 18.411 15.243 1.189 0.915 32.397 21.498 165M  227M
> 2.6.8   4604 20.922 16.054 1.406 1.041 39.622 25.056 172M  262M
> 2.6.9   4712 19.306 12.145 1.421 1.102 35.663 24.958 179M  297M
> 2.6.10  5384 23.022 18.154 1.393 1.182 40.947 32.085 186M  338M
> 2.6.11  5662 27.211 19.138 1.791 1.253 42.605 31.902 193M  379M

That time in checking things in is worrisome.

"git" is basically linear in the size of the patch, which is what I want,
since most patches I work with are a couple of files at most. The patches
you are checking in are huge - I never actually work with a change that is
as big as a whole release. I work with changes that are five files or
something.

"hg" seems to basically slow down the more patches you have applied. It's 
hard to tell from the limited test set, but look at "user" time. It seems 
to increase from 6 seconds to 27 seconds.

To make an interesting benchmark, try applying the first 200 patches in 
the current git kernel archive. Can you do them three per second? THAT is 
the thing you should optimize for, not checking in huge changes.

If you're checking in a change to 1000+ files, you're doing something
wrong.

> Full-tree working dir diff (2.6.0 base with 2.6.1 in working dir):
> hg:  real 4.920s  user 4.629s  sys 0.260s
> git: real 3.531s  user 1.869s  sys 0.862s
> (this needed an update-cache --refresh on top of git commit, which
> took another: real 2m52.764s  user 2.833s  sys 1.008s)

You're doing something wrong with git here. Why would you need to update 
your cache?

			Linus
