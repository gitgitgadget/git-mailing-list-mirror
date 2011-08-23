From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: How to check out the repository at a particular point in time
Date: Tue, 23 Aug 2011 11:17:00 +0200
Message-ID: <201108231117.00314.trast@student.ethz.ch>
References: <1314085268.42103.YahooMailClassic@web25406.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: PJ Weisberg <pjweisberg@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"in-git-vger@baka.org" <in-git-vger@baka.org>
To: <rdiezmail-temp2@yahoo.de>
X-From: git-owner@vger.kernel.org Tue Aug 23 11:17:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvn6e-00006t-5P
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 11:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085Ab1HWJRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 05:17:06 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:30786 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716Ab1HWJRE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 05:17:04 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Tue, 23 Aug
 2011 11:17:01 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.289.1; Tue, 23 Aug
 2011 11:17:01 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.1-40-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <1314085268.42103.YahooMailClassic@web25406.mail.ukl.yahoo.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179929>

R. Diez wrote:
> 
> check out HEAD, it should always work

Please stop using HEAD like this, you'll just confuse your coworkers
(and yourself).  HEAD denotes the currently checked out commit.
[Unlike SVN it is *not* the most recent version of anything.]  Thus by
definition, 'git checkout HEAD' is a no-op.

The newest commit on a branch is denoted by its branch name, because
as Jens said, a branch is in fact a pointer to its tip[1] commit.

> Now you're saying I cannot reliably checkout last week's versions
> because yesterday I did a merge from an older branch? You mean that
> git stores everything with clean graphs and numeric pointers, so it
> cannot know what this repository looked like last week?

Indeed.  Especially if forced pushes are allowed, there is no way to
know what was in the repo at a given time unless you have (local)
reflogs enabled on remote branches and going back until the time you
want.

> As the developer, I have full control, I can decide what the
> branches are called and how the public repository is
> updated/pushed/whatever. I can control the clock so there are no
> time skews.
> 
> What do I have to do in order to be able to reliably checkout last
> week's versions without too much administrative work? I just want to
> get the same result today as if I had done a checkout last week from
> the public repository and had made a back-up copy of the working
> directory then.

Assuming

* you never do a non-fast-forward (i.e., forced) push
* you never have any clock skew
* you always merge features into master (not the other way around)
* you always push immediately after committing on master

you can get there by using 'git log -1 --first-parent --until=...'
as mentioned in my first email.

I personally think that's crazy and -- if you want to avoid the work
of "really" using submodules -- support Jens's suggestion of having
the buildbot automatically assemble an "I tested this" superproject.



[1] or "head" in lowercase (thus "branch head"), but I prefer tip to
avoid confusion

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
