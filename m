From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Libification project (SoC)
Date: Mon, 19 Mar 2007 02:43:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703190235330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org>
 <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316060033.GD31606@spearce.org>
 <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070318140816.GG4489@pasky.or.cz> <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070319012111.GS18276@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Mar 19 02:44:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT6v0-0006U2-Sp
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 02:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933611AbXCSBn5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 21:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933614AbXCSBn5
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 21:43:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:42161 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933611AbXCSBn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 21:43:56 -0400
Received: (qmail invoked by alias); 19 Mar 2007 01:43:55 -0000
X-Provags-ID: V01U2FsdGVkX1/zfNMwtgjzyGCw2a/JXflWr98AMS0oPK8PXzAkI4
	8DI7IzpEjxDrt0
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070319012111.GS18276@pasky.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42558>

Hi,

On Mon, 19 Mar 2007, Petr Baudis wrote:

> On Mon, Mar 19, 2007 at 12:48:27AM CET, Johannes Schindelin wrote:
> > On Sun, 18 Mar 2007, Petr Baudis wrote:
> > 
> > > [...] if you look at the UNIX history, you'll notice that first 
> > > people started with non-reentrant stuff because it was "good enough" 
> > > and then came back later and added reentrant versions anyway. Let's 
> > > learn from history. It's question of probability but it's very 
> > > likely this will happen to us as well.
> > 
> > Yes, let's learn from history. Start with a libgit that is good 
> > enough. And when somebody actually needs it to behave a little 
> > differently, or more sophisticated, then let that somebody work on it!
> 
>   I was talking about the API. The API has to be designed to be 
> reentrant. And you get pretty much stuck with the API. And requiring 
> reentrance isn't that far off once libgit is there, as I tried to point 
> out; it's not really any obscure requirement.

I don't see _any_ problem in making an API which works with _one_ repo 
first. This has several advantages:

- most users (if any!) will work that way,

- it is easier to implement,

- you are more likely to get that right than the more complex thing you 
  seem to want already in the first version, and

- it is easy enough to extend the API later, _retaining_ the small and 
  beautiful functions.

As for the memory problems I was pointing out to you on IRC: if you do 
some operation on one repo, and run out of memory, okay, there is not much 
you can do about it. Tough luck.

If you cache different repos in the _same_ process, and run out of memory, 
you should free the caches of the _other_ repos first, instead of just 
erroring out. This is not entirely trivial, likely to make libgit fragile, 
and quite possibly a performance hit (making libgit unattractive for 
plumbing, which would take away the best test case for libgit).

Also, when you cache different repos, you want to avoid duplicating 
identical objects in different caches, which makes the cache handling no 
easier.

But even if these issues would not exist, isn't it obvious that you should 
start with something _simple_?

Ciao,
Dscho
