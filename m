From: Petr Baudis <pasky@suse.cz>
Subject: repo.or.cz renovated
Date: Mon, 17 Mar 2008 19:10:15 +0100
Message-ID: <20080317181015.GC10335@machine.or.cz>
References: <20080313231413.27966.3383.stgit@rover> <m3ve3nwtl3.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 19:11:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbJnX-0004Lt-Ol
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 19:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbYCQSKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 14:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbYCQSKS
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 14:10:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38939 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbYCQSKR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 14:10:17 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 64401204C054; Mon, 17 Mar 2008 19:10:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3ve3nwtl3.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77450>

On Sat, Mar 15, 2008 at 02:44:42PM -0700, Jakub Narebski wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > On repo.or.cz (permanently I/O overloaded and hosting 1050 project +
> > forks), 
> 
> It looks like repo.or.cz is overwhelmed by its success. I hope that
> now that there are other software hosting sites with git hosting
> (Savannah, GitHub, Gitorious,...) the number of projects wouldn't grow
> as rapidly.

Actually, it was overwhelmed to so much by its success but by lack of
good maintenance. ;-) I gave it some love again for the past week and
the improvement was, well, overwhelming. :-)

I finally fixed tons of failures and broken repositories, and most
importantly repacked some of the big repositories with object databases
in pretty horrid shape. The effect has been immense, having everything
in database of 1/3 the size and single big pack drastically reduced the
I/O load.

Scenario: Site with about 1100 repositories weighting 13GB, running a
fetch job for about 200 of them hourly. About two git-daemon requests
per minute and 10 gitweb requests per minute (the last two numbers are
taken quite sloppily over a small sample of the last ten minutes ;-).
Site is running on 2x1GHz P3 with 2G RAM, repository is on hw RAID5.
(We are currently preparing to migrate it to a more powerful machine.)

Before, the load on the server would be normally about 6 to 15 _all the
time_ and bunch of git-related processes would be permanently eating
some CPU and crunch on the disk.

After introducing the index caching and repacking the repositories, the
load seems to be around 1 at most and hardly seems to come above 3; all
feels very snappy.

So for anyone running a hosting site, make sure your repositories are
nicely packed. It makes huge difference to the I/O load!

> Another solution would be to divide projects list page into pages,
> perhaps adding search box for searching for a project (by name, by
> description and by owner).
> 
> Nevertheless even with pagination, if we want to have "sort by last
> update" we do need caching.

Yes, I'm pondering about pagination, but because of web clients, not the
server load; it takes firefox on my notebook noticeable time to render
this list already, and it's rather big too. Ideas are welcome here.

My current plan is to have a [Search project] box at the front page,
together with direct link to 'show all'. Other than that, what makes
sense to display on the front page? I think recently added projects (age
< 1 week) for sure. I'm not so sure about recently changed projects -
maybe it is better to keep the front page cruft-free.

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
