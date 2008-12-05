From: Pete Wyckoff <pw@padd.com>
Subject: Re: git alias always chdir to top
Date: Fri, 5 Dec 2008 09:09:48 -0500
Message-ID: <20081205140948.GB23087@osc.edu>
References: <20081203160852.GA3773@osc.edu> <20081204123402.GA23740@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 05 15:11:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8bOj-0000Bf-DD
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 15:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbYLEOJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 09:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbYLEOJu
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 09:09:50 -0500
Received: from marge.padd.com ([99.188.165.110]:33447 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943AbYLEOJt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 09:09:49 -0500
Received: from oink.padd.com (oink.padd.com [69.36.12.13])
	by marge.padd.com (Postfix) with ESMTPSA id 1A5FF10F8032;
	Fri,  5 Dec 2008 06:08:20 -0800 (PST)
Received: by oink.padd.com (Postfix, from userid 7770)
	id 26B4AFD4167; Fri,  5 Dec 2008 09:09:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20081204123402.GA23740@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102401>

peff@peff.net wrote on Thu, 04 Dec 2008 07:34 -0500:
> On Wed, Dec 03, 2008 at 11:08:52AM -0500, Pete Wyckoff wrote:
> 
> > It looks like handle_alias() uses setup_git_directory_gently() to
> > find the .git, which chdir()s up until it gets there.  Is there a
> > way to do this without changing the process current working
> > directory instead?  I could even handle an environment variable
> > saving the original cwd, but that's ickier.
> 
> There has been some discussion of refactoring the setup to _not_ do that
> chdir until later, which should fix your problem. And other problems,
> too, since aliases can get confused about whether or not we're in a
> worktree (try "git config alias.st status && cd .git && git st") as a
> result of the startup sequence.  Ideally the _only_ thing to happen
> before running an alias would be to look at the config to see how to run
> the alias, and everything else would be "as if" you had just run the
> alias manually.
> 
> So no, there's no way to do it correctly right now. The git commands
> internally do know the original prefix, but I don't think it is exposed
> via the environment.
> 
> I hope this will get fixed eventually, but refactoring this code is
> unpleasant enough and I have been busy enough that it hasn't happened
> yet. You are of course welcome to volunteer. ;)

Thanks for these comments.  I missed the discussion about
refactoring to move the chdir around.

In my particular case, since the only usage of this particular git
alias is by another script, I can get away with passing the full
path name and making some assumptions about the caller.

Point taken that it would be good to clean up the alias code path
so that this issue doesn't even arise in the first place.

		-- Pete
