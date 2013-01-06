From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Re: [PATCH] Remove the suggestion to use parsecvs, which is
 currently broken.
Date: Sun, 6 Jan 2013 15:32:52 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130106203252.GA9377@thyrsus.com>
References: <20121228162025.8565E4413A@snark.thyrsus.com>
 <20121228230149.GA3575@book-mint>
 <20121229044200.GA16086@thyrsus.com>
 <20130106163420.GA3378@book-mint>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Jan 06 21:33:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrwuA-0002Hf-Eu
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 21:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950Ab3AFUcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 15:32:55 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:37068
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab3AFUcy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 15:32:54 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id C42954044B; Sun,  6 Jan 2013 15:32:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130106163420.GA3378@book-mint>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212838>

Heiko Voigt <hvoigt@hvoigt.net>:
> > I'm parsecvs's maintainer now.  It's not in good shape; there is at
> > least one other known showstopper besides the build issue.  I would
> > strongly prefer to direct peoples' attention away from it until I
> > have time to fix it and cut a release.  This is not a distant 
> > prospect - two or three weeks out, maybe.
> 
> So for this short amount of time you want to change gits documentation?

Yes.  We should not direct people to a tool that plain doesn't work.  

I'll fix parsecvs as soon as I can.  Once I do, I will add support to the
new git-cvsimport to use parsecvs as a conversion engine, alongside
cvsps and cvs2git.

You may not have seen the first version of that patch, so I'll 
explain. The new git-cvsimport can use multiple conversion engines;
each one is expressed as a Python class that knows how to convert
git-cvsimport options to engine options, and how to generate a
command that ships an import stream to standard output.  There's
an -e option that selects an engine.

Currently there are two such classes, one for cvsps and one for cvs2git.
cvsps is the default.  When parsecvs is working, it will be the work of
a few minutes to add a parsecvs class.

The architectural goal here is to make it easy for users of
git-cvsimport to be able to experiment with different engines to
get the best possible conversion, without having to fuss with 
details of the engine invocation.

> Is this hint causing you trouble? Are there many people asking for
> support because of that?

No.  But as a matter of principle I am against having documentation
tell pretty lies, even temporarily. It's bad craftsmanship and bad
faith to do that.
 
> There is no README so I am not sure how the tests are supposed to be
> build in general. Due to the lack of documentation its probably easier
> for you Eric to port my tests.

At the present state of things, I agree.  I have been so busy fighting other
aspects of this problem that I have not yet had time to separate the
test suite from the cvsps code and document it properly.

> The structure of my tests is quite simple:
> 
> 	t/  - All the tests
> 	t/cvsroot - A cvs module per test
> 	t/t[0-9]{4}*/expect - The expected cvsps output
> 
> You can copy the cvs repository modules and convert the expected cvsps
> output to whatever output you want to test against. It the found
> changeset ordering that is interesting.

Noted.  I have a copy and will port them.

> The fix was never clean and AFAIR the reason behind that was that the
> breakage in commit ordering is not easy to fix in cvsps.

Understood. But it's better than no fix at all.

>                                                           That and
> because there are other working tools out there was the reason why I
> stopped working on fixing cvsps.

Once I have all three tools working and can run them against a common
test suite, several interesting possibilities will open up.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
