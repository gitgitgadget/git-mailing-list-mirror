From: Petr Baudis <pasky@suse.cz>
Subject: Re: Pushing vs. alternates
Date: Tue, 24 Oct 2006 19:23:11 +0200
Message-ID: <20061024172311.GT18879@pasky.or.cz>
References: <20061024035335.GW20017@pasky.or.cz> <7vmz7muvqu.fsf@assigned-by-dhcp.cox.net> <20061024112028.GY20017@pasky.or.cz> <7vzmblhc3y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 19:24:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcPzi-00081m-28
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 19:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbWJXRXO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 13:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWJXRXN
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 13:23:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49051 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965165AbWJXRXN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 13:23:13 -0400
Received: (qmail 15608 invoked by uid 2001); 24 Oct 2006 19:23:11 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmblhc3y.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29992>

On Tue, Oct 24, 2006 at 07:12:17PM CEST, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Dear diary, on Tue, Oct 24, 2006 at 07:29:45AM CEST, I got a letter
> > where Junio C Hamano <junkio@cox.net> said that...
> >> Petr Baudis <pasky@ucw.cz> writes:
> >> 
> >> >   I don't have time to code that myself right now, so I'm just tossing
> >> > an idea around - pushing to a directory with alternates set up should
> >> > avoid sending objects that are already in the alternate object database.
> >> 
> >> That is probably only relevant for the first time, since
> >> subsequent pushes have refs from its own repository that tracks
> >> the tips of branches that was pushed for the last time.
> >
> > Well, I would send haves for the alternate repository anyway,...
> 
> While I agree it would be an optimization if it worked, there is
> one conceptual problem here though, coming from old warts.  It's
> not alternate "repository" but it is alternate object store.

Yes. Which is ugly but it may make sense in case of really having things
like "portable objects database" on your usbflash or whatever else
insane. ;-) Still,

> There is no guarantee that refs/ directory that is next to the
> objects/ alternate points at is related to that object store,
> for historical reasons (i.e. we have separate GIT_DIR and
> GIT_OBJECT_DIRECTORIES).  So unless we declare that objects that
> are reachable from the refs/ *must* be fully connected in
> objects/ when objects/ has refs/ next to it, sending HAVEs from
> that refs/ can break the push, since that refs/ you are looking
> at may not be related to the alternate objects/ at all.  I do
> not think it is a big restriction at all, but it is a new
> restriction you are adding to the repository layout.

I think this situation (having something that looks like a Git
repository with objects/ inside that does *not* belong to this
repository) _is_ totally insane and such a restriction is fine. Who
thinks otherwise?

If this really bothers anyone (I can't see why), we could have something
like [ -e objects/info/standalone ] to prohibit receive-pack from ever
thinking of checking if the object database belongs to a repository. We
could of course keep the behaviour as is and make the new one optional,
but I believe that the new one is more sensible.

> > ... You can only push if your login access is reduced to
> > git-shell, and something external could've set up your alternates.
> 
> Ok, I was not thinking about "something external".

Also, if you can push, that does not imply at all that you can fetch as
well. In plenty of situations you can't; most UNIX machines do have ssh
running, but that's not very useful when they're behind a NAT or just a
restrictive firewall. And with my notebook, I'm almost always behind a
NAT.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
