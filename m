From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 4/4] fetch: opportunistically update tracking refs
Date: Sun, 12 May 2013 11:15:16 +0200
Message-ID: <871u9cftjv.fsf@linux-k42r.v.cablecom.net>
References: <20130511161320.GA14990@sigill.intra.peff.net>
	<20130511161652.GD3270@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	"Michael Haggerty" <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 12 11:15:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbSNM-0002r9-0l
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 11:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555Ab3ELJPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 05:15:23 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:9387 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340Ab3ELJPW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 05:15:22 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 12 May
 2013 11:15:07 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (213.221.117.227) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Sun, 12 May 2013 11:15:18 +0200
In-Reply-To: <20130511161652.GD3270@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 11 May 2013 18:16:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [213.221.117.227]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224030>

Jeff King <peff@peff.net> writes:

> When we run a regular "git fetch" without arguments, we
> update the tracking refs according to the configured
> refspec. However, when we run "git fetch origin master" (or
> "git pull origin master"), we do not look at the configured
> refspecs at all, and just update FETCH_HEAD.
>
> We miss an opportunity to update "refs/remotes/origin/master"
> (or whatever the user has configured). Some users find this
> confusing, because they would want to do further comparisons
> against the old state of the remote master, like:
>
>   $ git pull origin master
>   $ git log HEAD...origin/master

I agree with the patch, but I would use a different reasoning. Your
example here is not even correct because the range in the second command
would be empty unless the merge conflicted.

I believe the more common confusion stems from the tracking displays in
git-checkout and others.  The issue there is that we *internally* treat
origin/masters as a kind of mirror, and the tracking displays all go
against user expectations once they have seen a newer state of origin's
master by explicit pull or fetch.

Michael also pointed out yesterday that short of

  git fetch origin master:refs/remotes/origin/master

there is no way to fetch only one branch.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
