From: Olivier Galibert <galibert@pobox.com>
Subject: Re: Autoconf/Automake
Date: Thu, 15 Jun 2006 19:48:33 +0200
Message-ID: <20060615174833.GA32247@dspnet.fr.eu.org>
References: <1150324030.23268.12.camel@dv> <20060615072450.GF7766@nowhere.earth> <20060615133146.GA5794@steel.home> <20060615163209.GJ7766@nowhere.earth> <Pine.LNX.4.64.0606150954430.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>, Alex Riesen <raa.lkml@gmail.com>,
	Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 15 19:48:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqvxU-0004pq-2q
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 19:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030918AbWFORsh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 13:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030920AbWFORsh
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 13:48:37 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:34064 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1030918AbWFORsg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 13:48:36 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 51C71A424C; Thu, 15 Jun 2006 19:48:33 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606150954430.5498@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21898>

On Thu, Jun 15, 2006 at 10:02:10AM -0700, Linus Torvalds wrote:
> These days, there aren't fifteen different versions of UNIX. There's a 
> couple, and it's perfectly ok to actually say "fix your damn system and 
> just install GNU make". It's easier to install GNU make than it is to 
> install autoconf/automake.

You should be careful to separate autoconf and automake.  Autoconf is
not so bad, and you can make clean, maintainable Makefile.in and
config.h.in files with it, because it uses simple substitution.  It is
quite useful to detect available librairies when some are optional,
and also to lightly[1] ensure that prefix and friends will stay the
same between make and make install.  Also, especially if you hack a
little bit to alias 'enable' and 'with', you get a sane interface to
optional feature selection.  Oh, and to seperate compilation
directories too (vpath generation).

OTOH, automake is a BDSM session gone bad.  The makefiles it generates
are atrocious and outdated, even buggy on some lesser makes, which is
quite annoying when what you try to build is gnu make.

The worst of the lot is libtool, though.  That one explicitely tries
to make your experience as painful as possible.  Including, but not
limited to, hiding the files in dot-directories so that you try to run
gdb on a script, relinking at install time, silently removing flags
you want to pass to ld or the compiler because it thinks it knows
better, locking C++ shared libraries to the exact compiler version
that compiled them through the .la file crap, etc.

So, autoconf can be useful.  The rest should die.

  OG.

[1] As in, you can still override when running make, but if you don't
    override anything you'll get the value you passed to configure every
    time.
