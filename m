From: Petr Baudis <pasky@suse.cz>
Subject: Re: Listing authors of each file in branch HEAD since given
	revision
Date: Thu, 29 May 2008 21:53:14 +0200
Message-ID: <20080529195314.GB18781@machine.or.cz>
References: <c6c947f60805290143r731b4a80v8d8297124899be22@mail.gmail.com> <alpine.DEB.1.00.0805291344400.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 29 21:54:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1oCm-0000uF-QX
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 21:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759622AbYE2TxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 15:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759074AbYE2TxU
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 15:53:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60694 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759401AbYE2TxT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 15:53:19 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E86AA244C03E; Thu, 29 May 2008 21:53:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805291344400.13507@racer.site.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83242>

Hi!

On Thu, May 29, 2008 at 01:47:29PM +0100, Johannes Schindelin wrote:
> On Thu, 29 May 2008, Alexander Gladysh wrote:
> 
> > For each file in the head of my current branch I need to get a list of 
> > all people who altered it since given revision. If file was not changed, 
> > it should be not listed.
> > 
> > Something like:
> > 
> >   my/file1.ext user1 user2 user3
> >   my/file2.ext user1
> 
> You will be able to do something like this easily from the output of
> 
> git log --pretty=format:%an --name-only HEAD
> 
> Probably just a Perl script which reads the author name, and then attaches 
> that author name to all following file names until an empty lines occurs, 
> recursively.

No rocket science:

git log --pretty=format:%an --no-merges -r --name-only HEAD~100..HEAD |
perl -lne 'our %i; $_ or $a = 0 or next; ++$a == 1 and $b = $_ and next;
$i{$_}{$b}++; END { print "$_: " . join(", ", keys %{$i{$_}}) for (keys
%i); }'

Sorry for the obfuscation. :-)

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
