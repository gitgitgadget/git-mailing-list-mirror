From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Add support for GIT_CEILING_DIRS
Date: Thu, 15 May 2008 18:45:44 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805151841040.30431@racer>
References: <482B935D.20105@facebook.com> <482BE0EB.6040306@viscovery.net> <482BE238.5020309@facebook.com> <482BF69C.6020604@viscovery.net> <alpine.DEB.1.00.0805151004400.30431@racer> <482C644F.9090903@facebook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Thu May 15 19:46:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwhXH-0008F8-Bm
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 19:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728AbYEORpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 13:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752337AbYEORpn
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 13:45:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:36688 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751569AbYEORpm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 13:45:42 -0400
Received: (qmail invoked by alias); 15 May 2008 17:45:40 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp034) with SMTP; 15 May 2008 19:45:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gS2ZrcxBgU4yWnWZRJCCSdbm5gOGvPE8TY1Ka4r
	m8IeF5mp7UOdLB
X-X-Sender: gene099@racer
In-Reply-To: <482C644F.9090903@facebook.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82214>

Hi,

On Thu, 15 May 2008, David Reiss wrote:

> The problem with this implementation is that it does not distinguish 
> between GIT_CEILING_DIRS being unset and GIT_CEILING_DIRS="/".  For 
> example...
> 
> cd /
> sudo git init
> cd /home
> git rev-parse --show-prefix
> 
> That series of commands works with either version of my patch, but fails 
> with "fatal: Not a git repository" if I apply this change.  I am 
> certainly open to changing this code, but I think we will always need 
> two separate values of ceil_offset to represent "unset" and "/". It's 
> just a question of whether they should be -1 and 0 or 0 and 1.

You are much more familiar with the code, but I suspect that a simple 
change would fix that:

> >> +             do { } while (offset > ceil_offset && cwd[--offset] != '/');

Just use "--offset >= 0 && cwd[--offset] != '/'" here.  And maybe 
ceil_offset = -1 again.

I cannot quickly test, since I am short on time, and it would be too 
cumbersome to find which patches to apply first.

But I strongly believe that it is not beyond your capabilities to adjust 
Hannes' patch for your command series, keeping the elegance.

Ciao,
Dscho
