From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Tue, 14 Aug 2012 10:27:58 +0200
Message-ID: <87zk5x6fox.fsf@thomas.inf.ethz.ch>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 10:28:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1CTx-0007el-So
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 10:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab2HNI2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 04:28:03 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:1617 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753951Ab2HNI2A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 04:28:00 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 14 Aug
 2012 10:27:57 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 14 Aug
 2012 10:27:58 +0200
In-Reply-To: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
	(Hilco Wijbenga's message of "Mon, 13 Aug 2012 12:58:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203390>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> # On branch master
> # Your branch and 'origin/master' have diverged,
> # and have 250 and 19 different commit(s) each, respectively.
> #
> nothing to commit (working directory clean)
>
> He asked me what to do and I told him to do what has always worked for
> me in the past when something like this happened: gitk, "reset master
> branch to here" (to a commit before the divergence and using --hard),
> git pull origin master. Problem solved.

There are several layers of pitfalls and misunderstandings here.

* Is your work origin/master..master (that is, anything in master but
  not origin/master) really so worthless as to make "scrap it all!" the
  normal course of resolution?

  Or perhaps the real reason for the divergence is that upstream rewrote
  its master (eeeek!), in which case you should get them acquainted with
  the clue bat... and probably rebase instead of merge.

* pull = fetch + merge!  Repeat this a few times until it sinks in.
  Then print it on A0 and stick it up in your office or something.

  For your case this means that the pull command is roughly equivalent
  to

    git fetch origin master
    git merge FETCH_HEAD

  The two-arg form of fetch does *not* update origin/master.  Assuming
  you got the reset right, the merge will fast-forward to whatever
  origin's master points to -- but origin/master is still the old state!

* Resetting to something that you think will fast-forward, only to then
  fast-forward it to the newest state, is silly.  You can just reset to
  the newest state instead.

Taking all of this together, I think you should stop using two-arg
pull[*] or fetch, and replace your error-prone recipe with simply

  git fetch
  git reset --hard origin/master

Assuming, as before, that your local work is worthless.  Is it?
Otherwise it would be better to run something like

  git fetch
  git rebase origin/master


[*] it's ok if you use it with an URL instead of a remote nickname

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
