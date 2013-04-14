From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: State of CVS-to-git conversion tools (Was: Re: cvsps: bad usage:
 invalid argument --norc)
Date: Sun, 14 Apr 2013 07:33:52 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130414113351.GA1299@thyrsus.com>
References: <323381594.20130414121834@gmail.com>
 <673219382.20130414124800@gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 13:44:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URLMT-0005i9-IK
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 13:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318Ab3DNLoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 07:44:30 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:54074
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab3DNLo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 07:44:29 -0400
X-Greylist: delayed 630 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Apr 2013 07:44:29 EDT
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 1864540571; Sun, 14 Apr 2013 07:33:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <673219382.20130414124800@gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221096>

Ilya Basin <basinilya@gmail.com>:
> IB> Hi esr.
> IB> In cvsps 3.10 the flag --norc was removed. It broke 'git cvsimport'.
> IB> Please give the option back and write something in the man page like:
> IB>     This option has no effect; it is present for compatibility
> 
> Looks like the tool is completely different. I think I'll have to
> downgrade.

Or you could just use 3.x directly rather than through the git-cvsimport
wrapper.  It works better that way - it actually ships a fast-import 
stream that git fast-import can consume directly.

Old cvsps (2.x) was very, very broken; there was a bug in it that
pretty much guaranteed incorrect conversion of branchy repos.  I've
fixed that particular bug, and several other serious ones, along with
adding the import-stream output stage, but I don't really trust the
cvsps code; I think its algorithmic core is weak and klugey and only
works semi-by-accident.

I do *not* recommend downgrading, it will pitch you from a bad
situation into a worse one.  Yes, Junio is still shipping a wrapper
for 2.x, but that was very much against my advice.

I'm also now the maintainer of cvs-fast-export, which used to be Keith 
Packard's utility for lifting the X.org CVS repo to git.  That was before
I resurrected it and added a fast-import stream output stage. 

I *think* cvs-fast-export's algorithms are more correct than cvsps's,
but I have not yet been able to pry loose the time to write the really
rigorous test suite to verify this.  That goal has been second on my
prority list for a couple of months now; I keep wanting to get to it
but having to fight fires on other projects instead.

I wish I could point you at a convertor I really trust.  I can't.
There is a third tool, cvs2git (based on the analyzer from cvs2svn)
that I don't maintain, which has problems of its own. And those three
are about it.

Yes, it's a swamp. The relatively poor capability of the tools isn't
anybody's fault; the problem domain is *nasty*.  I've been working a
closely related but easier one (Subversion stream dump analysis) for a
couple years now and understanding it doesn't make it less ugly.

I think with 4-6 weeks of concentrated attention I could clean up the
mess and deliver a really high-quality converter, and I'm motivated to
do this because I want it as a CVS front end for reposurgeon.  But it
hasn't happened yet and the incompleteness of my test suite is a
blocker in the way.

The topo analysis code in all these tools is really fragile and tends
to break on old edge cases when you try to teach it to handle new
ones, so a good set of regression tests is especially important.  And
doesn't yet exist, though I have built a decent start for cvsps based
on the tests in the git tree.

Do you have enough interest and spare cycles to help finish the test
suite?  Another pair of hands on it might speed things up a lot.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
