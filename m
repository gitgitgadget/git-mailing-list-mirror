From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Sat, 2 Feb 2008 18:34:46 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802021825220.7372@racer.site>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802021815510.7372@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 19:36:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLNDk-0006Q5-Js
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 19:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbYBBSfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 13:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbYBBSfX
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 13:35:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:59483 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751563AbYBBSfW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 13:35:22 -0500
Received: (qmail invoked by alias); 02 Feb 2008 18:35:20 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp012) with SMTP; 02 Feb 2008 19:35:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Qdbdp547QERGOvykb+mLPrLbSPf+IGQWnyyALOO
	6/uFgVEPSKKjHz
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802021815510.7372@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72296>

Hi,

BTW just to tell you why I am so excited with your patch: I have a patch 
to git-branch in my tree, which implements the git-new-workdir 
functionality (it's a patch to git-branch, not git-checkout, mainly 
because git-checkout is no builtin yet).

Now, git-new-workdir works by having symlinks _in_ .git/, but not for 
everything.  .git/HEAD is specific to the workdir, of course.

But your patch made me realise that this is the wrong way to go about it.  
Sure, you do not need to change core git, and can use a script to make the 
new working directory.  But there is no lock preventing the same ref being 
checked out twice.

Howver, having .git a file pointing to another git directory allows you to 
have locks there.  And they can be actually pretty sensible locks, like

	.git/HEAD.<mangled-path>

actually containing the symbolic ref describing which branch we're on in 
that working directory.  Likewise, .git/index.<mangled-path> needs to hold 
the current index.

Of course, for this to work, you need to use different HEADs and indexes 
only if .git was a file originally.

BTW <mangled-path> could be a hash of the path, and for convenience, we 
could store the path in .git/workdir.<mangled-path>.

Food for thought.

Ciao,
Dscho
