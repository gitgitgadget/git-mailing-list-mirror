From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Using gpg and gitattributes together
Date: Fri, 29 Feb 2008 14:59:43 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802291455120.22527@racer.site>
References: <alpine.LSU.1.00.0802270008550.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 29 16:01:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV6jJ-0006s1-QS
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 16:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759063AbYB2PAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 10:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759186AbYB2PAU
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 10:00:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:33989 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758952AbYB2PAT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 10:00:19 -0500
Received: (qmail invoked by alias); 29 Feb 2008 15:00:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 29 Feb 2008 16:00:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+EBFEOSdeEBKX1OaGCSmnqtrzYSmGrftMWNNqQLq
	jRiNw7puM7kuLu
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802270008550.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75542>

Hi,

On Wed, 27 Feb 2008, Johannes Schindelin wrote:

> I just added my .netrc to a repository where I track some files that I 
> would hate to lose.  However, since I mirror that repository to a 
> machine where other people than me have root access, I thought that I 
> encrypt the file with gpg.
> 
> To make this procedure more convenient for me, I decided not to encrypt 
> with a private key, but with a passphrase, and to use gitattributes to 
> do the encryption for me:
> 
> $ echo 'netrc filter=gpg' > .gitattributes
> $ git config filter.gpg.clean 'gpg --cipher-algo AES256 -c'
> $ git config filter.gpg.smudge 'gpg --decrypt'
> $ git add netrc
> 
> It asks quite a few times for the passphrase (as expected), but I had to 
> add the file twice (not expected).  However, since it worked now, I am 
> happy.
> 
> Maybe somebody else will find this information useful.

Unfortunately, this procedure has an issue I was not able to fix, and not 
even Daniel's checkout patch could fix it.

When encrypting, gpg uses a random element (to make the encryption harder 
to break, I guess).  So when I update netrc with "git add" (and nothing 
was changed), git will have a _different_ blob.

So I just tried "git checkout netrc", hoping that the index would be 
updated to say that the netrc file is current, after writing it.

But that did not work, since git checkout insisted on readding the file 
(which again resulted in a different blob, and therefore netrc seems to be 
out-of-date at all times).

So scrap that method.

Ciao,
Dscho

