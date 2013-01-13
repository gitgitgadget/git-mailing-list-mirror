From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 3/8] git_remote_helpers: Force rebuild if python version
 changes
Date: Sun, 13 Jan 2013 12:14:02 -0500
Message-ID: <20130113171402.GA1307@padd.com>
References: <cover.1358018078.git.john@keeping.me.uk>
 <89f55d20da9a4c0a8490f95107cbf5d04219d0fb.1358018078.git.john@keeping.me.uk>
 <20130112233044.GB23079@padd.com>
 <20130113162605.GL4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 13 18:15:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuR9X-00048k-M2
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 18:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197Ab3AMROI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 12:14:08 -0500
Received: from honk.padd.com ([74.3.171.149]:40715 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755148Ab3AMROH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 12:14:07 -0500
Received: from arf.padd.com (50-52-235-227.drr01.drhm.nc.frontiernet.net [50.52.235.227])
	by honk.padd.com (Postfix) with ESMTPSA id 0BD952F3F;
	Sun, 13 Jan 2013 09:14:05 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0684B28EBE; Sun, 13 Jan 2013 12:14:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130113162605.GL4574@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213388>

john@keeping.me.uk wrote on Sun, 13 Jan 2013 16:26 +0000:
> On Sat, Jan 12, 2013 at 06:30:44PM -0500, Pete Wyckoff wrote:
> > john@keeping.me.uk wrote on Sat, 12 Jan 2013 19:23 +0000:
> >> When different version of python are used to build via distutils, the
> >> behaviour can change.  Detect changes in version and pass --force in
> >> this case.
> >[..]
> >> diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
> >[..]
> >> +py_version=$(shell $(PYTHON_PATH) -c \
> >> +	'import sys; print("%i.%i" % sys.version_info[:2])')
> >> +
> >>  all: $(pysetupfile)
> >> -	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
> >> +	$(QUIET)test "$$(cat GIT-PYTHON_VERSION 2>/dev/null)" = "$(py_version)" || \
> >> +	flags=--force; \
> >> +	$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build $$flags
> >> +	$(QUIET)echo "$(py_version)" >GIT-PYTHON_VERSION
> > 
> > Can you depend on ../GIT-PYTHON-VARS instead?  It comes from
> > 96a4647 (Makefile: detect when PYTHON_PATH changes, 2012-12-18).
> > It doesn't check version, just path, but hopefully that's good
> > enough.  I'm imagining a rule that would do "clean" if
> > ../GIT-PYTHON-VARS changed, then build without --force.
> 
> I was trying to keep the git_remote_helpers directory self contained.  I
> can't see how to depend on ../GIT-PYTHON-VARS in a way that is as simple
> as this and keeps "make -C git_remote_helpers" working in a clean tree.
> 
> Am I missing something obvious here?

Not if it wants to stay self-contained; you're right.

I'm not thrilled with how git_remote_helpers/Makefile always
runs setup.py, and always generates PYLIBDIR, and now always
invokes python a third time to see if its version changed.

		-- Pete
