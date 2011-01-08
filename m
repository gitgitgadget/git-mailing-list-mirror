From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] Avoid unportable nested double- and backquotes in shell
 scripts.
Date: Sat, 8 Jan 2011 17:23:53 +0100
Organization: Institute for Numerical Simulation, University of Bonn
Message-ID: <20110108162353.GB4786@gmx.de>
References: <20110108090105.GB14536@gmx.de>
 <20110108161441.GA28898@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 17:24:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbbaD-0007k3-Nh
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 17:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042Ab1AHQX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 11:23:57 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:33635 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753012Ab1AHQX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 11:23:56 -0500
Received: (qmail invoked by alias); 08 Jan 2011 16:23:54 -0000
Received: from xdsl-78-34-215-107.netcologne.de (EHLO localhost.localdomain) [78.34.215.107]
  by mail.gmx.net (mp072) with SMTP; 08 Jan 2011 17:23:54 +0100
X-Authenticated: #13673931
X-Provags-ID: V01U2FsdGVkX19YVC0SwcdYHLCk89TtgoToM8IBsqizaTs16QylsD
	FMra4di1pMtyxN
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1Pbba5-0001XY-PP; Sat, 08 Jan 2011 17:23:53 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20110108161441.GA28898@burratino>
User-Agent: Mutt/1.5.20 (2010-08-04)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164829>

* Jonathan Nieder wrote on Sat, Jan 08, 2011 at 05:14:41PM CET:
> Ralf Wildenhues wrote:
> 
> > [Subject: Avoid unportable nested double- and backquotes in shell scripts]
> >
> > Some shells parse them wrongly, esp. pdksh.
> 
> How does it treat $( ) command substitutions?  (We use those more
> heavily and they are easier on the eyes anyway.)

Better (except for the usual problems when 'case ...)' comes into play).
But git makes heavy use of "no quoting needed on RHS of assignment"
anyway, so it seems like this would be a good move nonetheless.  And the
testsuite uses backticks a lot, it seems a move away from that should be
done more uniformly?

Anyway, I'll be happy to respin in whatever form is acceptable.

> > --- a/t/t9107-git-svn-migrate.sh
> > +++ b/t/t9107-git-svn-migrate.sh
> > @@ -94,7 +94,7 @@ test_expect_success 'migrate --minimize on old inited layout' '
> >  		echo "$svnrepo"$path > "$GIT_DIR"/svn/$ref/info/url ) || exit 1;
> >  	done &&
> >  	git svn migrate --minimize &&
> > -	test -z "`git config -l | grep "^svn-remote\.git-svn\."`" &&
> > +	! git config -l | grep "^svn-remote\.git-svn\." &&
> 
> I thought I remembered portability problems with the
> 
> 	! a | b
> 
> construct but it seems I am wrong; t7810-grep.sh uses that
> construct without trouble, at least.

Some non-Posix-conforming shells have problems with that too, e.g.,
Solaris /bin/sh, but I figured git wouldn't cater to them as I also saw
other such uses in the tree.

Cheers,
Ralf
