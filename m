From: Theodore Tso <tytso@mit.edu>
Subject: Re: Monotone workflow compared to Git workflow ( was RE: Git vs
	Monotone)
Date: Thu, 31 Jul 2008 17:22:15 -0400
Message-ID: <20080731212215.GI20819@mit.edu>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org> <63BEA5E623E09F4D92233FB12A9F79430238A5EE@emailmn.mqsoftware.com> <BLU0-SMTP273E4683B41DB7E44122F0AE7C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Craig L. Ching" <cching@mqsoftware.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	sverre@rabbelier.nl, Git Mailinglist <git@vger.kernel.org>
To: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Thu Jul 31 23:23:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOfck-0002So-AH
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 23:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbYGaVWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 17:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753529AbYGaVWs
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 17:22:48 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:52315 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752773AbYGaVWs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 17:22:48 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KOfbE-0001wH-9u; Thu, 31 Jul 2008 17:22:16 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KOfbD-0006Ud-Mm; Thu, 31 Jul 2008 17:22:15 -0400
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP273E4683B41DB7E44122F0AE7C0@phx.gbl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90996>

On Thu, Jul 31, 2008 at 04:57:24PM -0400, Sean Estabrooks wrote:
> > We find ourselves constantly having to shift gears and work on other
> > things in the middle of whatever it is we're currently working on.  For
> > instance, in the scenario above, A might be branch that contains a
> > feature going into our next release.  B might be a bugfix and takes
> > priority over A, so you have to leave A as-is and start work on B.  When
> > I come back to work on A, I have to rebuild A to continue working, and
> > that's just too expensive for us.  So we use the monotone-like
> > new-workdir which allows us to save those build artifacts.
>
> A decent build system will only compile the source files that actually
> changed when switching branches.  Couple that with a compiler cache
> (such as ccache) and switching between branches in the kernel or git
> project usually isn't prohibitively time consuming.

That being said, if the bugfix is on a "maint" branch, and one of the
things that has changed is a header file that forces most of the
project to be recompiled, a separate work directory may be more
convenient.  Of course, a separate work directory (whether created
using "git clone -s" or "git-new-workdir" means more disk space and it
means greater use of the page cache or a slowdown while the different
sets of sources get paged in and out.  Of course, you could hack
git-work-dir to use cp -rl to initially copy the working directory
using hard links, and then when the new branch is checked out, if most
of the files haven't changed, the files in the working directory could
be shared too.  A lot depends on how much you want to squeeze the last
bit of hard drive and speed optimization, and how big your project is.

       	    	      	    		      - Ted
