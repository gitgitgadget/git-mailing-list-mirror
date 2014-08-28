From: dev <dev@cor0.com>
Subject: Re: make install fails because GNU tar needed
Date: Thu, 28 Aug 2014 11:08:56 -0400 (EDT)
Message-ID: <502287515.26012.1409238536022.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
References: <267282067.24350.1409235408562.JavaMail.vpopmail@webmail2.networksolutionsemail.com> <20140828145056.GA26855@peff.net>
Reply-To: dev <dev@cor0.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 28 17:09:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN1KC-0000nv-FU
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 17:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbaH1PJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 11:09:16 -0400
Received: from atl4mhob19.myregisteredsite.com ([209.17.115.112]:46413 "EHLO
	atl4mhob19.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750794AbaH1PJP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2014 11:09:15 -0400
Received: from atl4oxapp02pod2.mgt.hosting.qts.netsol.com ([10.30.77.38])
	by atl4mhob19.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s7SF8u5M021442;
	Thu, 28 Aug 2014 11:08:56 -0400
In-Reply-To: <20140828145056.GA26855@peff.net>
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v6.20.7-Rev18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256095>



On August 28, 2014 at 10:50 AM Jeff King <peff@peff.net> wrote:
> On Thu, Aug 28, 2014 at 10:16:48AM -0400, dev wrote:
>
> > # gmake CFLAGS="$CFLAGS" LDFLAGS="$LD_OPTIONS" NEEDS_LIBICONV=Yes \
> > > SHELL_PATH=/usr/local/bin/bash \
> > > SANE_TOOL_PATH=/usr/local/bin \
> > > USE_LIBPCRE=1 LIBPCREDIR=/usr/local CURLDIR=/usr/local \
> > > EXPATDIR=/usr/local NEEDS_LIBINTL_BEFORE_LIBICONV=1 \
> > > NEEDS_SOCKET=1 NEEDS_RESOLV=1 USE_NSEC=1 \
>
> As an aside, you may be able to drop some of these defines. For
> example,
> we set NEEDS_SOCKET automatically on Solaris. See the "SunOS" section
> of
> config.mak.uname for the complete set of defaults.

I figured as much but for the moment I am flailing along towards a nice
working build first and then pray to the gods of complication for some
kindness and simplification.  :-)

Thus far the build process seems to work fine. I have no idea if I
can use SSH protocol as I would need to set up a dummy to test it.
Everything else seems to work. I think. :-\

> > Is there some magic somewhere to use ordinary POSIX tar ?
>
> gmake TAR=tar ?

ha .. yeah I guess.

Actually I found a file called GIT-BUILD-OPTIONS :

# cat GIT-BUILD-OPTIONS
SHELL_PATH='/usr/local/bin/bash'
PERL_PATH='/usr/local/bin/perl'
DIFF='diff'
PYTHON_PATH='/usr/bin/python'
TAR='tar'
NO_CURL=''
USE_LIBPCRE='1'
NO_PERL=''
NO_PYTHON='1'
NO_UNIX_SOCKETS=''
NO_GETTEXT=''
GETTEXT_POISON=''


Funny looking options for NO_foo where I would think that a null
string indicates that in fact I have foo?  Because I do have curl
and perl and most likely UNIX_SOCKETS.  Regardless, I simply edited
that file and three others to stop the search for gtar.

> The default of gtar for Solaris dates back to 2005. There may have
> been
> a reason then that is no longer valid now, or there may be something
> besides "make install" which uses a more advanced feature.

Yes, I seem to recall that long long ago there were problems with old
tar on Solaris 2.5.1 back in the 90's and then it carried forwards up
to Solaris 7 or 8.  The ultimate POSIX tar as well as tar that can
archive
or extract anything from anything is Joerg Schilling's star.

   http://sourceforge.net/projects/s-tar/

I use that nearly everywhere that I must ensure all metadata and data
gets taken care of correctly and cross platform.  However, hell will
freeze over before we ever see it included in a distro or UNIX anywhere
so for now tar will suffice.

> > /bin/sh: gtar: /bin/shnot found
> > : gtar: not found
> > gmake[1]: *** [install] Error 1
> > gmake: *** [install] Error 2
> >
> > [...]
> >
> > Also, what is shnot ?
>
> Two messages stepping on each other's toes?

Yeah .. I saw that after I sent the email.

dev
