From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Move JGit off JSch?
Date: Thu, 25 Jun 2009 23:11:23 +0200
Message-ID: <200906252311.23351.robin.rosenberg.lists@dewire.com>
References: <20090625181428.GM11191@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 25 23:11:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJwEM-0006wV-99
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 23:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbZFYVL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 17:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbZFYVL2
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 17:11:28 -0400
Received: from mail.dewire.com ([83.140.172.130]:12522 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbZFYVL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 17:11:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 845F914940CD;
	Thu, 25 Jun 2009 23:11:25 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id srdzpV6EsSCS; Thu, 25 Jun 2009 23:11:24 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id A9DEAAE51E6;
	Thu, 25 Jun 2009 23:11:24 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <20090625181428.GM11191@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122244>

torsdag 25 juni 2009 20:14:28 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> I'm fed up with JSch.
> 
> The remote.<name>.timeout stuff I added recently to JGit causes
> JSch to throw NPE on timeout[1] and the original author seems to
> think that's a reasonable thing to do[2].
> 
> MINA SSHD[3] contains a different client implementation, licensed
> under the Apache License 2.0.  Its currently missing public key
> support[4] but the library is actually a pretty solid library,
> and the author seems to have a decent clue.
Clues are useful :)

> I'm really starting to consider adding the public key support the
> client side of MINA SSHD, and then rewriting TransportGitSsh to use
> it instead of JSch.  The downside is, that really increases our
> dependency chain, and SSH key management under Eclipse becomes a
> unique EGit problem as we can't piggy-back onto the existing JSch
> key management already done by the workbench.

I haven't really looked into JSch internals, but rewriting complex code
without trying hard to fix the problem might not be worth it. New
code /will/ have problems and having a different mechanism for key
management is in some very obscure corner on the reverse side of
my wish list. 

> But, I just spent the last ~3 hours digging around JSch trying to

I'm not quite as efficient as you, but I've spent more than three
hours on fixing much simpler things.

> fix this NPE bug... and realized the code is very thread unsafe,
> uses at least 2 threads per connection (your thread, and a thread
> it spawns for you) so you have no choice but to use threads, and
> the author seems to think random NPEs are OK (see [2] and all of
> the NPE bugs on sourceforge).

Can't we bug him a little more, but then again patches are probably
more convincing than bug reports. Perhaps you could explain the 
issues in more detail before we start rewriting the key management
into SSHD. 

Should we raise a bug report in eclipse about replacing
JSch, in order to get some feedback from Eclipse people?

-- robin
