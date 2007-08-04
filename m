From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rc4 - make quick-install-doc is broken
Date: Sat, 4 Aug 2007 23:37:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708042328000.14781@racer.site>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site>
 <46B4A2B0.9080208@gmail.com> <46B4DF39.2070506@lsrfire.ath.cx>
 <Pine.LNX.4.64.0708042232390.14781@racer.site> <46B4F923.3090604@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Aug 05 00:38:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHSGA-0005oT-LF
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 00:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762572AbXHDWhy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 18:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760496AbXHDWhy
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 18:37:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:34799 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760219AbXHDWhx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 18:37:53 -0400
Received: (qmail invoked by alias); 04 Aug 2007 22:37:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 05 Aug 2007 00:37:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18QPXtb6j0Q8aQKY15e58IO46ASj0P5L8CZi7YShw
	f6kxG2nc37HSzp
X-X-Sender: gene099@racer.site
In-Reply-To: <46B4F923.3090604@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54916>

Hi,

your test script is slightly wrong...

First you "git init", with GIT_DIR in $(pwd)/.git, i.e. the default.  But 
then, you need not do this, test scripts are called when git init was 
already called.

Then you make an untracked directory called untracked/.  Tradition 
dictates that when we're in that directory, we get the prefix 
"untracked/", because we might add a file, or reference a file in another 
branch, where that directory is _not_ untracked.

So it is expected that checkout-index and ls-files behave differently 
in a subdirectory (even if that is currently untracked).

It seems a bit counterintuitive that read-tree succeeds, but really, 
read-tree is only a commit -> index operation, which should not care about 
the current prefix.  So it is fine.

Checkout-index, instead, is an index -> working tree operation, and for 
most of these, we care about the current prefix (so that you can say git 
checkout-index file1, where file1 is in the current directory, which is 
_not_ the working tree root).

Ciao,
Dscho
