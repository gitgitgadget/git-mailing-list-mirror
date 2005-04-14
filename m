From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Remove need to untrack before tracking new branch
Date: Fri, 15 Apr 2005 01:00:47 +0200
Message-ID: <20050414230047.GS22699@pasky.ji.cz>
References: <20050413092656.GO16489@pasky.ji.cz> <1113394537.23299.51.camel@nosferatu.lan> <20050413221936.GI25711@pasky.ji.cz> <1113461754.23299.68.camel@nosferatu.lan> <1113467335.23299.77.camel@nosferatu.lan> <1113467905.23299.81.camel@nosferatu.lan> <20050414091106.GX25711@pasky.ji.cz> <1113471609.23299.95.camel@nosferatu.lan> <20050414224257.GM22699@pasky.ji.cz> <1113519687.23299.126.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 01:01:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMDKP-0003rU-AX
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 01:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVDNXD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 19:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVDNXBV
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 19:01:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41677 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261629AbVDNXAt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 19:00:49 -0400
Received: (qmail 18006 invoked by uid 2001); 14 Apr 2005 23:00:47 -0000
To: Martin Schlemmer <azarah@nosferatu.za.org>
Content-Disposition: inline
In-Reply-To: <1113519687.23299.126.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 15, 2005 at 01:01:27AM CEST, I got a letter
where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> On Fri, 2005-04-15 at 00:42 +0200, Petr Baudis wrote:
> > Dear diary, on Thu, Apr 14, 2005 at 11:40:09AM CEST, I got a letter
> > where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > > So basically the modes that are stored in the cache are not applied ...
> > > Although, yes, I prob should add the relevant code to checkout-cache.
> > 
> > This should be fixed now, BTW. git apply didn't correctly apply the
> > mode changes, but now it should. Several bugs prevented it to, in fact.
> > ;-)
> 
> Yep, I saw - thought you scrapped this, so mailed a new patch (or was
> busy doing the touch ups to the email when this came in.

Hmm, I must've missed the new patch. The latest I have still puts the
stuff to update-cache and combines it with the show-diff change.

> > > > > show-diff.c:  a531ca4078525d1c8dcf84aae0bfa89fed6e5d96
> > > > > --- a531ca4078525d1c8dcf84aae0bfa89fed6e5d96/show-diff.c
> > > > > +++ uncommitted/show-diff.c
> > > > > @@ -5,13 +5,18 @@
..snip..
> > > > > -       snprintf(cmd, sizeof(cmd), "diff -L %s -u -N  - %s", name, name);
> > > > > +       for (n = 0; n < 20; n++)
> > > > > +               snprintf(&(sha1[n*2]), 3, "%02x", ce->sha1[n]);
> > > > > +       snprintf(cmd, sizeof(cmd), "diff -L %s/%s -L uncommitted/%s -u -N  - %s",
> > > > > +               sha1, ce->name, ce->name, ce->name);
> > > > 
> > > > The "directory" sha1 is the sha1 of the tree, not of the particular
> > > > file - that one is in the "attributes" list (parentheses after the
> > > > filename), together with mode.
> > > > 
> > > 
> > > Does it really matter?  It is more just to get the patch prefix right,
> > > and I did it as it went nicely with the printed:
> > > 
> > > ----
> > > show-diff.c:  a531ca4078525d1c8dcf84aae0bfa89fed6e5d96
> > > ----
> > > 
> > > for example ...
> > 
> > Yes, it matters, and I don't care how nicely it wents with what you
> > print before.
> > 
> 
> hah ;p
> 
> > Either print there some nonsense which is clear not to be a tree ID, or
> > (much more preferably) print the real tree ID there. If some tool ever
> > uses it (e.g. to help resolve conflicts, perhaps even actually doing a
> > real merge based on the patch), you just confused it.
> > 
> 
> Ok, understood.  Do you think it will be scripted?  If not I guess we
> can just do labels like:
> 
> --- committed/
> +++ uncommitted/
> 
> ?

Heh. Well, of course this could do. But is there any technical reason
why not just carry the sha1 id of the tree around and stuff it there?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
