From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 0/8] Initial support for Python 3
Date: Sat, 12 Jan 2013 18:43:04 -0500
Message-ID: <20130112234304.GC23079@padd.com>
References: <cover.1358018078.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sebastian Morr <sebastian@morr.cc>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 13 00:43:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuAja-0002qf-9s
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 00:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498Ab3ALXnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 18:43:09 -0500
Received: from honk.padd.com ([74.3.171.149]:51027 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754457Ab3ALXnI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 18:43:08 -0500
Received: from arf.padd.com (50-52-235-227.drr01.drhm.nc.frontiernet.net [50.52.235.227])
	by honk.padd.com (Postfix) with ESMTPSA id 2C78CE9A;
	Sat, 12 Jan 2013 15:43:06 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7B4B427CDB; Sat, 12 Jan 2013 18:43:04 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213315>

john@keeping.me.uk wrote on Sat, 12 Jan 2013 19:23 +0000:
> I started having a look to see how much work would be needed to make Git
> work with Python 3 and the answer is mostly not much.  The exception is
> git-p4.py which is hit hard by the distinction between byte strings and
> unicode strings, particularly because the Python output mode of p4
> targets Python 2.
> 
> I don't know if it's worthwhile to actually apply these but here they
> are in case anyone's interested.
> 
> Having said that, the changes are minimal and involve either wrapping
> parentheses around arguments to print or being a bit more explicit about
> how we expect byte strings to be decoded to unicode.
> 
> With these patches all tests pass with python3 except t98* (git-p4), but
> there are a couple of topics in-flight which will affect that
> (fc/remote-testgit-feature-done and er/replace-cvsimport).
> 
> John Keeping (8):
>   git_remote_helpers: Allow building with Python 3
>   git_remote_helpers: fix input when running under Python 3
>   git_remote_helpers: Force rebuild if python version changes
>   git_remote_helpers: Use 2to3 if building with Python 3
>   svn-fe: allow svnrdump_sim.py to run with Python 3
>   git-remote-testpy: hash bytes explicitly
>   git-remote-testpy: don't do unbuffered text I/O
>   git-remote-testpy: call print as a function
> 
>  contrib/svn-fe/svnrdump_sim.py     |  4 ++--
>  git-remote-testpy.py               | 40 +++++++++++++++++++-------------------
>  git_remote_helpers/.gitignore      |  1 +
>  git_remote_helpers/Makefile        | 10 ++++++++--
>  git_remote_helpers/git/importer.py |  2 +-
>  git_remote_helpers/setup.py        | 10 ++++++++++
>  6 files changed, 42 insertions(+), 25 deletions(-)

These look good, in that there are relatively few changed needed.

Sebastian Morr tried a similar patch a year ago, in

    http://thread.gmane.org/gmane.comp.version-control.git/187545

He made changes beyond yours, in particular "print >>" lines,
that you seem to handle with 2to3 during the build.  I'm not sure
which approach is better in the long run.  He worked on the
other .py in contrib/ too.

Can you give me some hints about the byte/unicode string issues
in git-p4.py?  There's really only one place that does:

    p4 = subprocess.Popen("p4 -G ...")
    marshal.load(p4.stdout)

If that's the only issue, this might not be too paniful.

I hesitated to take Sebastian's changes due to the huge number of
print() lines, but maybe a 2to3 approach would make that aspect
of python3 support not too onerous.

		-- Pete
