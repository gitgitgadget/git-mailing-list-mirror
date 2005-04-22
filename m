From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] multi item packed files
Date: Thu, 21 Apr 2005 20:16:16 -0400
Message-ID: <200504212016.16729.mason@suse.com>
References: <200504211113.13630.mason@suse.com> <200504211622.48065.mason@suse.com> <Pine.LNX.4.58.0504211530370.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Krzysztof Halasa <khc@pm.waw.pl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 02:14:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOloT-0001Bl-BV
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 02:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVDVASl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 20:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVDVARZ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 20:17:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:22755 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261790AbVDVAQU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 20:16:20 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 0D617880F;
	Fri, 22 Apr 2005 02:16:20 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id 92E6F1162D9; Fri, 22 Apr 2005 02:16:19 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504211530370.2344@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 21 April 2005 18:47, Linus Torvalds wrote:
> On Thu, 21 Apr 2005, Chris Mason wrote:
> > Shrug, we shouldn't need help from the kernel for something like this. 
> > git as a database hits worst case scenarios for almost every FS.

[ ... ]

We somewhat agree on most of this, I snipped out the parts that aren't worth 
nitpicking over.  git is really fast right now, and I'm all for throwing 
drive space at things to solve problems.  I just don't think we have to throw 
as much space at it as we are.

> The _seek_ issue is real, but git actually has a very nice architecture
> even there: not only dos it cache really really well (and you can do a
> simple "ls-tree $(cat .git/HEAD)" and populate the case from the results),
> but the low level of indirection in a git archive means that it's almost
> totally prefetchable with near-perfect access patterns.

We can sort by the files before reading them in, but even if we order things 
perfectly, we're spreading the io out too much across the drive. It works 
right now because the git archive is relatively dense.  At a few hundred MB 
when we order things properly the drive head isn't moving that much.

At 3-6 GB this hurts more.  The data gets farther apart as things age, and 
drive performance rots away.  I'll never convince you without numbers, which 
means I'll have to wait for the full load of old history and try it out ;)

-chris
