From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Fri, 4 May 2007 20:56:08 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705042049330.3819@woody.linux-foundation.org>
References: <200705012346.14997.jnareb@gmail.com>  <Pine.LNX.4.64.0705020143460.4010@racer.site>
 <8fe92b430705020433v7ae5c117qdefccc791cd07fff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, dev@tools.openoffice.org,
	Jan Holesovsky <kendy@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 05:56:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkBNi-0005rO-EK
	for gcvg-git@gmane.org; Sat, 05 May 2007 05:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767969AbXEED4U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 23:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767970AbXEED4U
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 23:56:20 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:57059 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1767969AbXEED4T (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2007 23:56:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l453u9Y3021648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 May 2007 20:56:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l453u8jF020553;
	Fri, 4 May 2007 20:56:08 -0700
In-Reply-To: <8fe92b430705020433v7ae5c117qdefccc791cd07fff@mail.gmail.com>
X-Spam-Status: No, hits=-2.977 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46241>



On Wed, 2 May 2007, Jakub Narebski wrote:
> On 5/2/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > Something I realized with pain is that the refs/ directory is 24MB big.
> > Yep. Really. They have 3464 heads and 2639 tags. I suspect that this is
> > the reason why.
> 
> Then packed refs would certainly help with speed and a bit with size.

Btw, this reminds me: we really should start out clones with a fully 
packed set of refs. It seems stupid to get the refs in one go, and then 
explode them into thousands of files.

A trivial patch is to just do

	git pack-refs --all --prune

in the "git-clone.sh" script rather than force people to do it themselves, 
but we really probably shouldn't have ever even unpacked them in the first 
place. That is kind of stupid, but especially since that thing is written 
in shell, it's hard to do anything smarter.

Of course, I don't know what the hell openoffice is doing with that many 
branches and tags, but I guess it's a normal result of having used CVS/SVN 
- you want to tag every single merge you do, and all branches stay around 
forever, because you can never merge them back and get rid of them.

It's always sad to see the crap that is CVS, and how bad decisions in CVS 
end up resulting in pain downstream.

		Linus
