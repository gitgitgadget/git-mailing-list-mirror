From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Newbie:  Restore messed up code from local or remote repository
Date: Fri, 12 Nov 2010 13:46:21 +0100
Message-ID: <20101112124621.GF30870@efreet.light.src>
References: <1289550163511-5731540.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gzoller <gzoller@hotmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 13:46:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGt1R-0008EN-HJ
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 13:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761Ab0KLMqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 07:46:24 -0500
Received: from cuda1.bluetone.cz ([212.158.128.5]:34607 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab0KLMqY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 07:46:24 -0500
X-ASG-Debug-ID: 1289565982-0706a5430001-QuoKaX
Received: from efreet.light.src (152-31-80-78.praha.adsl.tmcz.cz [78.80.31.152]) by cuda1.bluetone.cz with ESMTP id ohfzxN6AVvJxuYwL; Fri, 12 Nov 2010 13:46:22 +0100 (CET)
X-Barracuda-Envelope-From: bulb@ucw.cz
X-Barracuda-Apparent-Source-IP: 78.80.31.152
Received: from bulb by efreet.light.src with local (Exim 4.72)
	(envelope-from <bulb@ucw.cz>)
	id 1PGt1J-00020E-Pl; Fri, 12 Nov 2010 13:46:21 +0100
X-ASG-Orig-Subj: Re: Newbie:  Restore messed up code from local or remote repository
Content-Disposition: inline
In-Reply-To: <1289550163511-5731540.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Barracuda-Connect: 152-31-80-78.praha.adsl.tmcz.cz[78.80.31.152]
X-Barracuda-Start-Time: 1289565982
X-Barracuda-URL: http://212.158.128.5:8000/cgi-mod/mark.cgi
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5032 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=4.5 KILL_LEVEL=4.8 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.46419
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161340>

On Fri, Nov 12, 2010 at 00:22:43 -0800, gzoller wrote:
> 
> Hello -- Extreme Git Newbie
> 
> I have a project that is checked into a local git repository as well as
> pushed to a remote repository.
> 
> Through misadventure I've managed to screw up my working code and want to
> restore what I had from my last commit on either the local or remote
> repositories.

If you screwed up content of the index, you will need the 'reset' command.

> So I blew away my messed up working files and tried:
> 
> git checkout

I don't think it does anything without argument. With argument '.' this
restores working tree to the state in index (stage). So if you have that
screwed up too, it won't be enough.

> git pull -f /path/to/remote/repos

This is just
    git fetch -f /path/to/remote/repos
followed by
    git merge FETCH_HEAD
(or appropriate tracking branch if you have the remote and tracking branch
set up)

The former ensured the latest revision of remote repo is available. It will
not itself

> git fetch -f /path/to/remote/repos

See above.

> None of the above did the trick.  The two remote commands reported that
> everything was Already up-to-date! (even though I'd deleted a lot of local
> working files)
> 
> What am I missing?  How can I restore my previous state from last commit?

Yes, using combination of reset and checkout. First make sure the branch you
want to use is checked out (git status will tell you if you don't have the
git aware shell prompt installed).

Than run

   git reset --hard <the-commit-you-want-to-be-at>

That will unconditionally make the current branch point to the specified
commit and make both the index and the working tree match the content of the
commit.

If you don't want it to touch the working tree (so you can compare what you
had in the working tree with that commit), you'd use --mixed instead of
--hard. You can than use checkout to revert those changes -- see above.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
