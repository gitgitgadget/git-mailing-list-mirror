From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: Re: question about: Facebook makes Mercurial faster than Git
Date: Mon, 10 Mar 2014 18:51:02 +0100
Message-ID: <20140310175102.GA17336@domone.podge>
References: <531D8ED9.7040305@gmx.net>
 <alpine.DEB.2.02.1403100310080.25193@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dennis Luehring <dl.soluz@gmx.net>, git@vger.kernel.org
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Mon Mar 10 18:58:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN4TG-0001iL-82
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 18:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbaCJR6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 13:58:34 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:46806 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbaCJR6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 13:58:33 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Mar 2014 13:58:32 EDT
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id 2469F6BAAF;
	Mon, 10 Mar 2014 18:51:03 +0100 (CET)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id F22075F802; Mon, 10 Mar 2014 18:51:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1403100310080.25193@nftneq.ynat.uz>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97.8 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243783>

On Mon, Mar 10, 2014 at 03:13:45AM -0700, David Lang wrote:
> On Mon, 10 Mar 2014, Dennis Luehring wrote:
> 
> >according to these blog posts
> >
> >http://www.infoq.com/news/2014/01/facebook-scaling-hg
> >https://code.facebook.com/posts/218678814984400/scaling-mercurial-at-facebook/
> >
> >mercurial "can" be faster then git
> >
> >but i don't found any reply from the git community if it is a real problem
> >or if there a ongoing (maybe git 2.0) changes to compete better in this case
> 
> As I understand this, the biggest part of what happened is that
> Facebook made a tweak to mercurial so that when it needs to know
> what files have changed in their massive tree, their version asks
> their special storage array, while git would have to look at it
> through the filesystem interface (by doing stat calls on the
> directories and files to see if anything has changed)
> 
That is mostly a kernel problem. Long ago there was proposed patch to
add a recursive mtime so you could check what subtrees changed. If
somebody ressurected that patch it would gave similar boost.

There are two issues that need to be handled, first if you are concerned
about one mtime change doing lot of updates a application needs to mark
all directories it is interested on, when we do update we unmark
directory and by that we update each directory at most once per
application run.

Second problem were hard links where probably a best course is keep list
of these and stat them separately.
