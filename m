From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: State of CVS-to-git conversion tools (Was: Re: cvsps: bad usage:
 invalid argument --norc)
Date: Thu, 18 Apr 2013 05:43:26 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130418094326.GB11038@thyrsus.com>
References: <323381594.20130414121834@gmail.com>
 <673219382.20130414124800@gmail.com>
 <20130414113351.GA1299@thyrsus.com>
 <1762779000.20130415215818@gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 11:43:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USlNW-0000jg-31
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 11:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967063Ab3DRJnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 05:43:37 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:59234
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966428Ab3DRJng (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 05:43:36 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 5ECF140584; Thu, 18 Apr 2013 05:43:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1762779000.20130415215818@gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221632>

Ilya Basin <basinilya@gmail.com>:
> Hi Eric.
> 
> I tried --fast-export. It's 2 times faster.
> The first thing that differs: in cvsps2 commits with adjacent
> timestamps were joined into one (see the attached files). Do you know
> the reason?

The cvsps guy included code to do that. Keith Packard didn't.  
Sorry I can't be more helpful, but that's about all I know.

I didn't write either analysis stage; I understand cvsps's, somewhat,
because I had to fix several nasty bugs in it.  I *don't* understand
cvs-fast-export's analysis stage very well yet, because it has no
obvious bugs that have required me to dive in.  (Keith's notes
document one major bug, which may be inherent to the mismatch between
file- and changest-orientation and not fixable in the general case,
though I will try.)

> Does this --fast-export thing support what John mentioned, the
> "incremental import support"? Does 'git fast-import' has it?

cvs-fast-export does not have incremental-import support.  Whether
git-cvs-import has it depend on which version you have and what
backend it it is using. I don't maintain that wrapper.

> I need it, because full import takes too long.
> The central repo of my employer is CVS, other people commit to it and
> I use git internally to be able to tidy my commit history before
> exporting to CVS.

You are out of luck. That feature was dependent on a very fragile
coupling between the old output format and a bunch of unmaintainably 
horrible Perl in the git-cvs-import wrapper script.  It didn't
work very well; frankly, I'm amazed it worked at all.

The things I had to do to fix the serious bugs in cvsps2 and make it
output a fast-import stream had the side effect of breaking that
coupling. cvsps3 won't give you that feature. Dropping back to cvsps2
to keep that feature will expose you to the cvsps2 bugs.

I'm sorry these tools are such a mess.  I'm trying to fix that, but
it's hard, slow work.  The problems are deeply ugly and the edge cases
have poisoned spikes.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
