From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 9 May 2006 13:21:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1147037659.25090.25.camel@dv> <Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
 <7vfyjli9vf.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
 <7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
 <Pine.LNX.4.64.0605081905240.6713@iabervon.org> <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
 <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE> <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
 <7virogc90u.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
 <7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
 <BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE> <Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
 <BAYC1-PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE> <Pine.LNX.4.64.0605082100460.3718@g5.osdl.org>
 <e3p5om$djs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 13:22:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdQI5-0002gv-IP
	for gcvg-git@gmane.org; Tue, 09 May 2006 13:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWEILWD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 07:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWEILWD
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 07:22:03 -0400
Received: from mail.gmx.de ([213.165.64.20]:42384 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751752AbWEILWC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 07:22:02 -0400
Received: (qmail invoked by alias); 09 May 2006 11:22:00 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp043) with SMTP; 09 May 2006 13:22:00 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e3p5om$djs$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19831>

Hi,

On Tue, 9 May 2006, Jakub Narebski wrote:

> Linus Torvalds wrote:
> 
> > I would suggest a much more readable format:
> > 
> > [core]
> > ...
> > 
> > [branch "core"]
> > ...
> > 
> > [remote "core"]
> > ...
> > 
> > and yes, enforce the <space>+<quoted name> format. We'd turn it internally
> > into some random internal string format (probably replacing the space with
> > a dot, and removing the quotes, so it would become "remote.core.<key>").
> 
> I'm all for it. Nice compromise of [branch."miXedCaps"] and ["miXedCaps"],
> human readable end editable, and easy parsable.

Okay, to summarize what people proposed (and that I remember):

1) [branch."AnY+String"]

2) multiple [branch]

3) magic <space>+<quoted>

4) [branch.just/allow-slashes/and-dashes]

5) the " for " notation

Of all these, only (5) is backwards compatible, but it is also the only 
one where you have to type the branch name over and over again.

However, the old gits do not really know what to do with the [branch] 
section anyway, so you could consider (2) (and (4), if you do not have 
branch names with slashes and/or dashes) backwards-compatible, because git 
will continue to work -- ignoring the funny entries.

(1) and (3) definitely would make an old git choke.

Now, for the ease of use:

(1), (3) and (4) are in the same league of easiness (except maybe that you 
have to keep in mind to extra-quote in shell scripts with (1) and (3)), 
(2) is especially good for people with a database mindset, and (5) is 
annoying as hell.

Now, for the ease of implementation:

(1) and (3) are in the same league, they have to change the way the config 
is parsed as well as make downcasing conditional in repo-config. (2) is 
obviously hardest of all. (4) is very easy (one line in config.c), and (5) 
easiest (nothing to do).

Now, for the versatility, i.e. what you can express with the syntax:

The same for all (except for (4) which has very weak restrictions on the 
branch name).

Oh, I completely forgot about another proposal: (6) subkeys (something 
like "url[branchname] = blablabla"). It has about the same effects as (1) 
or (3).

Another thing: I completely ignored the case sensitivity. Because it is 
irrelevant. Why? Because you do not have two branches which are only 
different by case-ness. It is confusing, and that's why. And you don't 
need to handle the case specially, because the comparison is done by 
downcasing anyway.

Obviously, I deem (4) the best solution ATM, because it has all the 
expressability needed, while being the simplest.

Ciao,
Dscho
