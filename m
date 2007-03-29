From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Add --with-tcltk and --without-tcltk to configure.
Date: Thu, 29 Mar 2007 12:29:08 +0400
Message-ID: <20070329082908.GH59098@codelabs.ru>
References: <7vejnbtjdq.fsf@assigned-by-dhcp.cox.net> <20070327065940.GC51155@codelabs.ru> <20070327102437.GM14837@codelabs.ru> <7vtzw7nej6.fsf@assigned-by-dhcp.cox.net> <20070327110714.GA14837@codelabs.ru> <7vps6um8wv.fsf@assigned-by-dhcp.cox.net> <20070328091209.GQ14837@codelabs.ru> <7vps6tf8te.fsf@assigned-by-dhcp.cox.net> <20070329074424.GD59098@codelabs.ru> <7vwt107a3g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 10:29:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWq0V-0007Em-SF
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 10:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbXC2I3Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 04:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbXC2I3Q
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 04:29:16 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:57071 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbXC2I3P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 04:29:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=VYaMI4raXCdSIa46eWAv573/oHmISWutGG7a+/IuqoSZSUUBZ6uMhjtsMAT9D3K+YrVrxCRQU6uZjmf99HXcXrKUgCIf+Z/HrEXukBAruF/Z/9h0dX/lv5Cp2ngt+z5MC6uJHu2IZL2wkcAGgSQSajw4KJ2oY9AjUlkTCVbdzqs=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HWq0P-000Dny-DU; Thu, 29 Mar 2007 12:29:13 +0400
Content-Disposition: inline
In-Reply-To: <7vwt107a3g.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, score=-3.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43417>

Junio,
Thu, Mar 29, 2007 at 01:00:35AM -0700, Junio C Hamano wrote:
> Actually, look at the wish script you are running sed on.
> 
> 	exec wish "$0" -- "$@"
> 
> If you substitute "wish" with "/i use stupid/$PATH/to/wish", I
> think Tcl splits the path at SP and does not protect $var
> reference, so the careful quoting in the Makefile is still not
> good enough ;-).

It is not Tcl/Tk, who interprets that string: it is for shell.
So, if the line will look like
exec "/insane path/to/wish" "$0" -- "$@",
then we will just get the "/insane path/to/wish" executed with
the script name on the first place and other arguments following
the '--'.

Or you meant something different? I am little confused with
the '$PATH' in your example. Was it intended?

> But come to think of it, it lets shell handle $PATH to find wish
> anyway, so *unless* we have specific version dependency to wish
> that wish binary normally found on user's $PATH is inadequate,
> we probably should not even need to be doing any of this path
> munging.  You might end up discovering the path to wish binary
> in your autoconf script, we do not have to use it.  ./configure
> can just see if there is wish, and set NO_TCLTK appropriately
> without any of the path business.
> 
> What do you think?

There are problems at least with FreeBSD: it just installs the
wish8.4, wish8.3, wish8.2, etc. It does not provide the bare 'wish'
as the link to one of those: it is hard to tell what 'wish' we will
like to use. Sure, I can search for 'wish8.3', 'wish8.4' in the
configure script. But when new wish will be out the Git configure
should be fixed for it. Seems like passing the path of the Tcl/Tk
interpreter still have some meaning in this situation.

> 
> > By the way, when I was creating the git.spec from the git.spec.in,
> > I had the 'Version' field equal to the '1.5.1-rc1.GIT' and RPM
> > does not like the '-' characters inside the versions.
> 
> That is semi-intended, in that you are not even supposed to be
> building with "1.5.1-rc1.GIT".  The version file in the tarball
> that git.spec file lives in should use git-describe, built from
> the source before the tarball was made, to get the version
> number, and wouldn't be "$anything.GIT", which is the last-ditch
> fallback string, which is set by GIT-VERSION-GEN for people who
> build in a wrong way.

Just built the tarball and tried the produced specfile: it wanted
to build 'git-1.5.1.rc1.26.g7a88-dirty'. Yes, my repository was
dirty, I admit it. Maybe you're right and there is no good reason
for the '-' symbols in the version string.
-- 
Eygene
