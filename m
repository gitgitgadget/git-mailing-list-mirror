From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: git rebase -i
Date: Mon, 23 Feb 2009 01:32:45 +0100
Message-ID: <20090223003245.GC21616@leksak.fem-net>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com> <871vtudabm.fsf@iki.fi> <43d8ce650902190152t6162593x8d0920be0e6d7a6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 01:34:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbOmO-00005N-6l
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 01:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869AbZBWAcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 19:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754768AbZBWAcx
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 19:32:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:54741 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754747AbZBWAcw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 19:32:52 -0500
Received: (qmail invoked by alias); 23 Feb 2009 00:32:50 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp008) with SMTP; 23 Feb 2009 01:32:50 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+2CpYFuaO2LjtQ1KM0BBxUQLTDL7x9/s2bHXRZHC
	lNKZiZs596EPRz
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LbOkX-0006Q4-A6; Mon, 23 Feb 2009 01:32:45 +0100
Content-Disposition: inline
In-Reply-To: <43d8ce650902190152t6162593x8d0920be0e6d7a6d@mail.gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111068>

Hi,

> > I think it's better to use aliases for this kind of personal things:
> >
> >    git config --global alias.my-rebase "rebase -i HEAD~10"
> >
> > Now you can do:
> >
> >    git my-rebase
> >
> 
> I'm trying to make git more obvious and easier to use, rather than
> find any solution :-)

As Wincent pointed out, git rebase -i without arguments isn't that
obvious or intuitive.

If you was looking for a solution, I'd be telling you that I use a
simple script "git-tickle-last" for this purpose:

--- 8< ---
#!/bin/sh
default=10

get_safe_num () {
	n=0
	git rev-list --parents "HEAD~$default.." | while read line
	do
		i=0
		for p in $line
		do
			i=$((i+1))
		done
		if test "$i" -gt 2
		then
			echo $n
			return 1
		fi
		n=$((n+1))
	done && echo $default
}

git rebase -i "HEAD~$(get_safe_num)"
--- >8---

It makes sure (I hope) that no merges get into the list, but it doesn't
care about published changes (i.e. tracking branch behavior).

I use it because I often reorder or squash commits before I push or
merge.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
