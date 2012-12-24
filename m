From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Python scripts audited for minimum compatible version
 and checks added.
Date: Mon, 24 Dec 2012 10:32:57 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121224153257.GA28213@thyrsus.com>
References: <20121220141855.05DAA44105@snark.thyrsus.com>
 <20121224133649.GA1400@padd.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 16:33:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnA2C-00043d-A7
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 16:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab2LXPd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 10:33:26 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:35496
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597Ab2LXPdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 10:33:25 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id E5DF04411F; Mon, 24 Dec 2012 10:32:57 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20121224133649.GA1400@padd.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212112>

Pete Wyckoff <pw@padd.com>:
> esr@thyrsus.com wrote on Thu, 20 Dec 2012 09:13 -0500:
> > diff --git a/git-p4.py b/git-p4.py
> > index 551aec9..ec060b4 100755
> > --- a/git-p4.py
> > +++ b/git-p4.py
> > @@ -12,6 +12,11 @@ import optparse, sys, os, marshal, subprocess, shelve
> >  import tempfile, getopt, os.path, time, platform
> >  import re, shutil
> >  
> > +if sys.hexversion < 0x02040000:
> > +    # The limiter is the subprocess module
> > +    sys.stderr.write("git-p4.py: requires Python 2.4 or later.")
> > +    sys.exit(1)
> > +
> >  verbose = False
> 
> If 2.3 does not have the subprocess module, this script will fail
> at the import, and not run your version test.

Yes, the import of subprocess should move to after the check.

> All the uses of sys.stderr.write() should probably include a
> newline.  Presumably you used write instead of print to avoid
> 2to3 differences.

That is correct.
 
> The name of this particular script, as users would type it, is
> "git p4"; no dash and no ".py".
> 
> Many of your changes have these three problems; I just picked on
> my favorite one.

Should I resubmit, or do you intend to fix these while merging?
 
> > diff --git a/git-remote-testgit.py b/git-remote-testgit.py
> > index 5f3ebd2..22d2eb6 100644
> > --- a/git-remote-testgit.py
> > +++ b/git-remote-testgit.py
> > @@ -31,6 +31,11 @@ from git_remote_helpers.git.exporter import GitExporter
> >  from git_remote_helpers.git.importer import GitImporter
> >  from git_remote_helpers.git.non_local import NonLocalGit
> >  
> > +if sys.hexversion < 0x01050200:
> > +    # os.makedirs() is the limiter
> > +    sys.stderr.write("git-remote-testgit.py: requires Python 1.5.2 or later.")
> > +    sys.exit(1)
> > +
> 
> This one, though, is a bit of a lie because git_remote_helpers
> needs 2.4, and you add that version enforcement in the library.

Agreed. The goal here was simply to have the depedencies of the individual
scripts be clearly documented, and establish a practice for future
submitters to emulate.

> I assume what you're trying to do here is to make the
> version-related failures more explicit, rather than have users
> parse an ImportError traceback, e.g.

See above.  At least half the point is making our dependencies
explicit rather than implicit, so we can make better policy
decisions.

> But what about the high-end of the version range?  I'm pretty
> sure most of these scripts will throw syntax errors on >= 3.0,
> how should we catch that before users see it?

That's a problem for another day, when 3.x is more widely deployed.
I'd be willing to run 2to3 on these scripts and check forward 
compatibility.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
