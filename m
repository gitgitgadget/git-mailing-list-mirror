From: Petr Baudis <pasky@suse.cz>
Subject: Re: Howto request: going home in the middle of something?
Date: Thu, 18 Oct 2007 13:27:58 +0200
Message-ID: <20071018112758.GN18279@machine.or.cz>
References: <200710181144.22655.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Thu Oct 18 13:28:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiTXw-0002TB-U9
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 13:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398AbXJRL2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 07:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755914AbXJRL2A
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 07:28:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39611 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754973AbXJRL17 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 07:27:59 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 34CA95A53A; Thu, 18 Oct 2007 13:27:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200710181144.22655.wielemak@science.uva.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61517>

  Hi,

On Thu, Oct 18, 2007 at 11:44:22AM +0200, Jan Wielemaker wrote:
> I've somewhere seen it in a mail, but I can't find it anymore. I have a
> bare central (public) repository and clones on various machines I work
> on. We all know it, you're right in the middle of something and it is
> really time to go home. You want to pick up your work at home, but
> without pushing to the shared repository.
> 
> I'm sure GIT can do this elegantly, but I'm not yet sure how.  I guess
> Ideally I want "git stash" at work, transfer the stashed changes to my
> other machine and apply them.  How do I do that?
> 
> Alternatively, I guess, one can commit at machine A, fetch the commit
> from machine A and continue. I'm still too uncertain about the remote
> access options to work this out properly, but it also feels less
> clean.

  this should be pretty simple assuming SSH access to machine A. Git can
fetch over SSH, so it's merely about telling it that repository X is
available over ssh over there and it'll fetch it home.

  The exact setup depends on whether you want to do this just once or
semi-regularily.  If the former, just

	git pull git+ssh://a.machine.aero/absolute/path

Note that this should fetch only the remote master branch, if I'm not
mistaken.

  If the latter, tell your home repository about your work repository:

	git remote add workrepo git+ssh://a.machine.aero/absolute/path

  Then, you can anytime just

	git fetch workrepo

and it will fetch all the branches from workrepo; whether you want to
use git fetch and git merge or git pull depends on your local
arrangement of branches at home.


  So, basically, when fetching you deal with your work repository
exactly the same way as in the shared repository.

  When pushing, this is not so trivial. Git _allows_ you to just push to
your work repository, but if you push to a branch that is currently
checked out, unexpected things will happen - always avoid that. If you
can fetch from home at work, do. If not, at least push to a branch at
work that can never be checked out and is reserved for that purpose.

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
