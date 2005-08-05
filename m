From: Junio C Hamano <junkio@cox.net>
Subject: Re: Template files location
Date: Fri, 05 Aug 2005 10:33:02 -0700
Message-ID: <7vpsssjnld.fsf@assigned-by-dhcp.cox.net>
References: <42DC4537.2080103@orionmulti.com>
	<20050805024222.GE7762@shell0.pdx.osdl.net>
	<42F2E571.6040207@orionmulti.com>
	<7voe8dow4w.fsf@assigned-by-dhcp.cox.net>
	<20050805042332.GG7762@shell0.pdx.osdl.net>
	<7vd5otov7s.fsf@assigned-by-dhcp.cox.net>
	<20050805094324.GF29216@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 19:34:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E164I-0004WO-5T
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 19:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVHERdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 13:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVHERdG
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 13:33:06 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:62097 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262755AbVHERdE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2005 13:33:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050805173304.USDA19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 5 Aug 2005 13:33:04 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050805094324.GF29216@pasky.ji.cz> (Petr Baudis's message of
	"Fri, 5 Aug 2005 11:43:24 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@ucw.cz> writes:

> Any reason why that's not the default destination then?

Inertia, installing things under $HOME, is why it is not the
default.  It may be that the project is mature enough that it is
time to move away from default installation in HOME, IOW to
change the Makefile to say prefix=/usr/local (or prefix=/usr)
to match practices of other projects [*1*].

> Or you can try /etc/git-core/ and fall back to /usr/share/git-core :-)

If the template files are to become something that always have
to exist, /etc first and then falling back on /usr/share would
make a lot of sense.  But as Johannes Schindelin correctly
argued against the "Use the template mechanism to set up refs/
hierarchy as well." patch [*2*], I think git-init-db should work
when there is no template directory.  In other words, its
primary purpose is to help local project administrators ensure
newly created repositories have hooks and probably info/exclude
that they recommend to the project members.

The reason to have a sample one shipped as part of the core
package is just to help newbies --- they would get a boilerplate
hooks/update that explains how they can set it up when they do
git-init-db even when they do not have their own customized set
of templates yet.  For this kind of use, I do not think one
default falling back to another is needed.

Come to think of it, GIT_TEMPLATE_DIRECTORY environment variable
does not make _ANY_ sense; I am an idiot.  It is used only by
git-init-db and the reason to have it is to override the
default.  It should become the command line parameter of it.
I'll fix up this breakage soonish.


[Footnote]

*1* This would probably break Linus, myself and others ---
everybody has to say "make prefix=$HOME", so I do not think I am
actually going to do it any time soon, if ever.

Having prefix=/usr/local as default only helps people who are
installing system-wide from the source, and nobody else.  People
who are writing spec.in and/or debian/rules need to override it
to prefix=/usr anyway, and it forces people who are installing
to their home to say prefix=$HOME/.  I suspect it is an inertia
from the good old days when nobody used binary distributions.

*2* And I am sure many others shared the same objection but did
not even bother to say anything because what Johannes said made
a lot of sense and what the patch did was obviously wrong.
