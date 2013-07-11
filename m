From: Dale Worley <worley@c-66-31-108-177.hsd1.ma.comcast.net>
Subject: Re: Bug:  Failure if stdin is closed.
Date: Thu, 11 Jul 2013 13:21:44 -0400
Message-ID: <201307111721.r6BHLiXD013670@freeze.ariadne.com>
References: <201307111511.r6BFBO44010988@freeze.ariadne.com> <87r4f52jjf.fsf@linux-k42r.v.cablecom.net>
Cc: Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 11 19:21:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxKZ1-0003hC-6R
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 19:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab3GKRVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 13:21:51 -0400
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:40825
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751290Ab3GKRVu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jul 2013 13:21:50 -0400
Received: from omta10.westchester.pa.mail.comcast.net ([76.96.62.28])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id z1Mq1l0050cZkys535Mpqn; Thu, 11 Jul 2013 17:21:49 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta10.westchester.pa.mail.comcast.net with comcast
	id z5Mo1l00Q1KKtkw3W5Morq; Thu, 11 Jul 2013 17:21:49 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r6BHLj8w013671;
	Thu, 11 Jul 2013 13:21:47 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r6BHLiXD013670;
	Thu, 11 Jul 2013 13:21:44 -0400
In-reply-to: <87r4f52jjf.fsf@linux-k42r.v.cablecom.net> (trast@inf.ethz.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1373563309;
	bh=twMXgfX68WvNEmJhS7YYArX/II37wwHwiV9bZrg6uzY=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=NKFEjtUTkqSKL/tSocO9wyf00f+EnQBw3VRtA9eWbPYGsfZbQQ4MuWTYs+LjJUulV
	 gszWRWjyxPnpFDFyCUsR0LnCEIZ0G/6crioooYV5W6ghqlb+jeqbmwZjME/Jbir3XI
	 dgEO0hVQWxHyCd4/Tvlec4SmFdkg1hAZaIZP5PP0+OuIyv1BGsMQkERP22NLWhwBLj
	 /ShooD0P77Pg7r8vY4kpn6dv7FWC/kl5B9j3ba8IgG37zVIus6Y2cPhv3RM/Hv8WJ3
	 uABnzIYd5X/D7+45uTfRN0mWBlfsRj90iQuJLjHGz04tEAIU0x0PWZsSrr8CfXM13n
	 wNTjzJbwiPYgg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230119>

> From: Thomas Rast <trast@inf.ethz.ch>

> May I ask why you need this, and to what extent this problem cannot be
> solved by instead redirecting from/to /dev/null?

The situation in which the problem arose is described here:

> worley@alum.mit.edu (Dale R. Worley) writes:
> 
> > (The original problem and the discussion that ensued is on the
> > git-users mailing list:
> > https://groups.google.com/forum/#!topic/git-users/lNQ7Cn35EqA)

It involves invoking git from Apache.  I haven't read up on the
details because I didn't need to in order to debug the problem.

> Closing 2 usually has even funkier consequences if the program proceeds
> to open some other file, it ends up as fd 2, and it then dies with an
> error.  In that sense it might be saner to simply die whenever open()
> gives an FD in the 0..2 range (and we weren't explicitly trying to
> reopen one of them).

True...  But fd 2 may be needed under many unpredictable
circumstances.  In regard to fd 0, we can predict that standard input
(per se) will not be needed, so it's anti-robust to require that it be
open for the code to function at all.

> However, does it fully fix the issue you describe?  What if you then run
> 'git checkout -F -' to read the message from stdin?

Obviously, if the git command explicitly requires use of
standard-input, then standard-input needs to be open.

> > However, when looking at the code, I noticed that few of the functions
> > have comments describing what they do, and none describe their input
> > and output values.  In particular, there are no comments specifying
> > what the error return values are.  This is appalling for a supposedly
> > professional-quality project!
> 
> You are touching on a sore point of the git code base.  Some
> contributors have made a point of adding comments where appropriate, so
> we're improving, but round tuits are in short supply as always.  If you
> can supply such tuits, they would be appreciated.

I will try to put my money where my mouth is.

Dale
