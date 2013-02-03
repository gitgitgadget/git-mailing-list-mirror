From: Pete Wyckoff <pw@padd.com>
Subject: Re: [RFC/PATCH v2] CodingGuidelines: add Python coding guidelines
Date: Sun, 3 Feb 2013 10:12:03 -0500
Message-ID: <20130203151203.GA10423@padd.com>
References: <20130129190844.GB1342@serenity.lan>
 <5108F056.9040406@alum.mit.edu>
 <20130130203158.GN1342@serenity.lan>
 <510B7F4B.7040902@alum.mit.edu>
 <20130201111634.GA2476@farnsworth.metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Feb 03 16:10:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U21DK-00016G-MV
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 16:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698Ab3BCPKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 10:10:14 -0500
Received: from honk.padd.com ([74.3.171.149]:42991 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754615Ab3BCPKM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 10:10:12 -0500
Received: from tic.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 771272E8;
	Sun,  3 Feb 2013 07:10:11 -0800 (PST)
Received: by tic.padd.com (Postfix, from userid 1000)
	id B9AB5100F04; Sun,  3 Feb 2013 10:12:03 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130201111634.GA2476@farnsworth.metanate.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215315>

john@keeping.me.uk wrote on Fri, 01 Feb 2013 11:16 +0000:
> On Fri, Feb 01, 2013 at 09:39:39AM +0100, Michael Haggerty wrote:
> > On 01/30/2013 09:31 PM, John Keeping wrote:
> > > On Wed, Jan 30, 2013 at 11:05:10AM +0100, Michael Haggerty wrote:
> > >> [...] maybe we should establish a small Python library of
> > >> compatibility utilities (like a small "six"). [...]
> > >> But I haven't had time to think of where to put such a library, how to
> > >> install it, etc.
> > > 
> > > If we want to go that route, I think restructuring the
> > > "git_remote_helpers" directory and re-using its infrastructure for
> > > installing the "Git Python modules" would be the way to go.  The
> > > directory structure would become something like this:
> > > 
> > >     git/
> > >     `-- python/
> > >         |-- Makefile    # existing file pulled out of git_remote_helpers
> > >         |-- < some new utility library >
> > >         |-- git_remote_helpers
> > >         |   |-- __init__.py
> > >         |   |-- git
> > >         |   |   |-- __init__.py
> > >         |   |   |-- exporter.py
> > >         |   |   |-- git.py
> > >         |   |   |-- importer.py
> > >         |   |   |-- non_local.py
> > >         |   |   `-- repo.py
> > >         |   `-- util.py
> > >         |-- setup.cfg   # existing file pulled out of git_remote_helpers
> > >         `-- setup.py    # existing file pulled out of git_remote_helpers
> > > 
> > > 
> > > It looks like the GitPython project[1] as already taken the "git" module
> > > name, so perhaps we should use "git_core" if we do introduce a new
> > > module.
> > > 
> > > [1] http://pypi.python.org/pypi/GitPython
> > 
> > This sounds reasonable.  But not all Python code will go under the
> > "python" subdirectory, right?  For example, I am working on a Python
> > script that fits thematically under contrib/hooks.
> 
> I was thinking of it as analagous with the "perl" directory that
> currently exists.  So the "python" directory will contain library code
> but scripts can live wherever is most appropriate.
> 
> One way of looking at it is: could the user want to have this installed
> for all available versions of Python?  For a script, the answer is "no"
> because they will call it and it will just run.  For libraries, you want
> them to be available with whatever Python interpreter you happen to be
> running (assuming that it is a version supported by the library).
> 
> > OTOH (I'm thinking aloud here) it is probably a bad idea for a hook
> > script to depend on a Python module that is part of git itself.  Doing
> > so would make the hook script depend on a particular version of git (or
> > at least a version with a compatible Python module).  But users might be
> > reluctant to upgrade git just to install a hook script.
> 
> I don't think such a dependency is a bad idea in the longer term.  If a
> "Git Python library" is developed, then at some point most people who
> have Git installed will have some version of that library - it becomes a
> case of perhaps wanting to limit yourself to some subset of the library
> rather than just not using it.
> 
> In fact, git_remote_helpers has been available since Git 1.7.0 and
> contains a lot of functionality that is more generic than its name
> suggests.

This library idea would be a great help; there are 100-odd calls
to git in git-p4, and we've had to deal with getting the arguments
and parsing correct.  I'd happily switch to using git_core.

Probably some elements of GitPython can be used too.  I'm not so
interested in the raw database manipulation, but the command
wrappers look reasonable.

		-- Pete
