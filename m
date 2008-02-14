From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Thu, 14 Feb 2008 23:38:24 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802142334480.30505@racer.site>
References: <200802081828.43849.kendy@suse.cz> <m3y79nb8xk.fsf@localhost.localdomain> <alpine.LSU.1.00.0802142054080.30505@racer.site> <200802142300.01615.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Nicolas Pitre <nico@cam.org>, Jan Holesovsky <kendy@suse.cz>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brian Downing <bdowning@lavos.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 00:39:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPnfT-0004vo-JR
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 00:39:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbYBNXib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 18:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbYBNXia
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 18:38:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:52457 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932536AbYBNXi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 18:38:28 -0500
Received: (qmail invoked by alias); 14 Feb 2008 23:38:26 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp015) with SMTP; 15 Feb 2008 00:38:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193bS9N+Zp3Kcb2AzaUyE7qZ6OgJfzTOjMhGOjsWk
	iPF4crUFHFEzEQ
X-X-Sender: gene099@racer.site
In-Reply-To: <200802142300.01615.jnareb@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73928>

Hi,

On Thu, 14 Feb 2008, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> > On Thu, 14 Feb 2008, Jakub Narebski wrote:
> 
> >> Perhaps you could try running contrib/stats/packinfo.pl on this pack 
> >> to examine it to get to know what takes most space.
> > 
> > $ ~/git/contrib/stats/packinfo.pl < \
> > objects/pack/pack-e4dc6da0a10888ec4345490575efc587b7523b45.pack 2>&1 | \
> > tee packinfo.txt
> > Illegal division by zero at /home/imaging/git/contrib/stats/packinfo.pl 
> > line 141, <STDIN> line 6330855.
> 
> Errr... sorry, I should have been more explicit. What I meant here is 
> the result of
> 
> $ git verify-pack -v <packfile> | \
>   ~/git/contrib/stats/packinfo.pl

Heh.  I was too lazy to look up the usage, so I just did what I thought 
would make sense...

So here it goes:

$ git verify-pack -v 
objects/pack/pack-e4dc6da0a10888ec4345490575efc587b7523b45.pack | 
~/git/contrib/stats/packinfo.pl | tee packinfo.txt
      all sizes: count 601473 total 2855826280 min 0 max 62173032 mean 
4748.05 median 232 std_dev 221254.37
 all path sizes: count 601473 total 2855826280 min 0 max 62173032 mean 
4748.05 median 232 std_dev 221254.37
     tree sizes: count 601473 total 2855826280 min 0 max 62173032 mean 
4748.05 median 232 std_dev 221254.37
tree path sizes: count 601473 total 2855826280 min 0 max 62173032 mean 
4748.05 median 232 std_dev 221254.37
         depths: count 2477715 total 70336238 min 0 max 250 mean 28.39 
median 4 std_dev 55.49

Something in my gut tells me that those four repetitive lines are not 
meant to look like they do...

> > 2.4G
>
> That's huuuuge tree. Compared to that 1.6G (or 1.4G) packfile doesn't 
> look large.
> 
> I wonder if proper subdivision into submodules (which should encourage 
> better code by the way, see TAOUP), and perhaps partial checkouts 
> wouldn't be better solution than lazy clone. But it is nice to have long 
> discussed about feature, even if at RFC stage, but with some code.

I think partial checkouts are wrong.  If you can work on partial 
checkouts, chances are that what you work on should be a submodule.

Having said that, I can understand if some people do not want to have the 
hassle of test^H^H^H^Husing submodules...

Ciao,
Dscho
